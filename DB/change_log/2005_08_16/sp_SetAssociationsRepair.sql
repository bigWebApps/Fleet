SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER procedure sp_SetAssociationsRepair
(
	@btChecked bit,
	@OrgId int,
	@OrderId int,
	@vchType varchar(25),
	@ItemId int,
	@RepairId int,
	@ServiceResultId int
)
as
	set nocount on
	declare @btAssociation bit
	declare @countLinks int
	declare @RepairItemId int
	
	-- to define, is there association? and also RepairItemId
	select 	@btAssociation  = (case when count(RM.[Id]) = 0 then 0 else 1 end),
		@RepairItemId = isnull(S.ItemId, 0)
	from RepairMult RM
	inner join (
		select 	'RI' as Type,
			RI.[Id] as [Id],
			RI.RepairItemId as ItemId
		from WorkOrderReportedIssues RI
		where RI.[Id] = @ItemId
		and RI.WorkOrderId = @OrderId
		and RI.OrgId = @OrgId
		union all
		select 	'PMI' as Type,
			PMI.[Id] as [Id],
			PMI.RepairItemId as ItemId
		from WorkOrderPMItems PMI
		where PMI.[Id] = @ItemId
		and PMI.WorkOrderId = @OrderId
		and PMI.OrgId = @OrgId
		union all
		select 	'II' as Type,
			II.[Id] as [Id],
			II.RepairItemId as ItemId
		from WorkOrderInspectItems II
		where II.[Id] = @ItemId
		and II.WorkOrderId = @OrderId
		and II.OrgId = @OrgId	
		) S
	on RM.RepairId = @RepairId
	and S.ItemId = RM.ItemId
	and S.Type = @vchType	
	group by S.ItemId
	if isnull(@btChecked, 0) = 0
	begin -- unchecked or nothing
		if isnull(@btAssociation, 0) = 1 -- if the accosiation was then delete it
		begin -- unchecked [delete association]
			-- So when we is removing association between a source and repair 
			-- we must know how many repaires has source. (See in RepairMult table)
			-- if the repair is alone then this link will be deleted (a row in RepairMult) 
			-- and also we set null in ServiceResultId, ServiceCheckId and RepairItemId 
			-- fields in source table
			-- if the repaires are many then we delete only link (the RepairMult row)
			-- for curent repair
			select @countLinks = count([Id])
			from RepairMult 
			where ItemId = isnull(@RepairItemId, 0)
			and OrgId = @OrgId
			if @countLinks < 1
			begin
				return 0
			end 
			else
			begin
				delete 
				from RepairMult
				where RepairId = @RepairId
				and OrgId = @OrgId
				and ItemId = isnull(@RepairItemId, 0)
			end
			if @countLinks = 1
			begin
				if @vchType = 'RI'
				begin
					update 	WorkOrderReportedIssues
					set 	ServiceResultId = null,
						ServiceCheckId = null,
						RepairItemId = null
					where 	[Id] = @ItemId
					and 	WorkOrderId = @OrderId
					and 	OrgId = @OrgId
				end
				if @vchType = 'PMI'
				begin
					update 	WorkOrderPMItems
					set 	ServiceResultId = null,
						ServiceCheckId = null,
						RepairItemId = null
					where 	[Id] = @ItemId
					and 	WorkOrderId = @OrderId
					and 	OrgId = @OrgId
				end
				if @vchType = 'II'
				begin
					update 	WorkOrderInspectItems
					set 	ServiceResultId = null,
						ServiceCheckId = null,
						RepairItemId = null
					where 	[Id] = @ItemId
					and 	WorkOrderId = @OrderId
					and 	OrgId = @OrgId
				end
			end
			return 0
		end
		else -- nothing
		begin
			return -1
		end
	end
	else
	begin -- checked or nothing
		if isnull(@btAssociation, 0) = 0 -- if the association wasn't then insert it
		begin -- checked [insert association]
			-- Well, first we set ServiceResultId to source's table, 
			-- second, we define has the current source another repaires. 
			-- if yes then we define the RepairItemId from source and create row in 
			-- RepairMult table with defined ItemId. 
			-- if not, we generate a new ItemId and also create a new row for RepairMult.
			-- if the source is PM item then we keep the history for his.
			select @RepairItemId = S.ItemId
			from (	select 	'RI' as Type,
					RI.[Id] as [Id],
					RI.RepairItemId as ItemId
				from WorkOrderReportedIssues RI
				where RI.[Id] = @ItemId
				and RI.WorkOrderId = @OrderId
				and RI.OrgId = @OrgId
				union all
				select 	'PMI' as Type,
					PMI.[Id] as [Id],
					PMI.RepairItemId as ItemId
				from WorkOrderPMItems PMI
				where PMI.[Id] = @ItemId
				and PMI.WorkOrderId = @OrderId
				and PMI.OrgId = @OrgId
				union all
				select 	'II' as Type,
					II.[Id] as [Id],
					II.RepairItemId as ItemId
				from WorkOrderInspectItems II
				where II.[Id] = @ItemId
				and II.WorkOrderId = @OrderId
				and II.OrgId = @OrgId
				) S
			where S.Type = @vchType
			and S.[Id] = @ItemId
			if isnull(@RepairItemId, 0) = 0
			begin 
				select @RepairItemId = isnull(max(ItemId), 0) + 1
				from RepairMult
				where OrgId = @OrgId
			end
			insert into [RepairMult](
				[OrgId], 
				[ItemId], 
				[RepairId]
				)
			values(
				@OrgId,
				@RepairItemId,
				@RepairId
				)
			if @vchType = 'RI'
			begin
				update 	WorkOrderReportedIssues
				set 	ServiceResultId = @ServiceResultId,
					RepairItemId = @RepairItemId
				where 	[Id] = @ItemId
				and 	WorkOrderId = @OrderId
				and 	OrgId = @OrgId
			end
			if @vchType = 'PMI'
			begin
				update 	WorkOrderPMItems
				set 	ServiceResultId = @ServiceResultId,
					RepairItemId = @RepairItemId
				where 	[Id] = @ItemId
				and 	WorkOrderId = @OrderId
				and 	OrgId = @OrgId
				if not exists(select 'true' 
					from EquipPMHistory EH 
					inner join WorkOrderPMItems PMI 
					on 	PMI.[Id] = @ItemId 
					and 	PMI.OrgId = @OrgId
					and 	PMI.WorkOrderId = @OrderId
					and 	EH.WorkOrderid = PMI.WorkOrderId
					and 	EH.OrgId = PMI.OrgId
					and 	EH.PMSchedDetailId = PMI.PMSchedDetailId
					)
				begin -- insert history
					insert into EquipPMHistory (
						OrgId, 
						EquipId,
						dtDate,
						PMSchedDetailId,
						dmUnits,
						WorkOrderId
						)
					select 	@OrgId,
						WO.EquipId,
						getdate(),
						PMI.PMSchedDetailId,
						WO.dmMileage,
						@OrderId
					from 	WorkOrders WO
					inner join WorkOrderPMItems PMI
					on 	WO.[Id] = @OrderId
					and 	WO.OrgId = @OrgId
					and 	PMI.WorkOrderId = WO.[Id]
					and  	PMI.OrgId = WO.OrgId
					and 	PMI.[Id] = @ItemId
				end
				else
				begin -- update history
					update 	EquipPMHistory
					set 	dtDate = getdate(),
						dmUnits = WO.dmMileage
					from 	WorkOrders WO
					inner join WorkOrderPMItems PMI
					on 	WO.[Id] = @OrderId
					and 	WO.OrgId = @OrgId
					and 	PMI.WorkOrderId = WO.[Id]
					and  	PMI.OrgId = WO.OrgId
					and 	PMI.[Id] = @ItemId
					where 	EquipPMHistory.EquipId = WO.Equipid
					and	EquipPMHistory.OrgId = WO.OrgId
					and	EquipPMHistory.PMSchedDetailId = PMI.PMSchedDetailId
					and 	EquipPMHistory.WorkOrderId = PMI.WorkOrderId
				end
			end
			if @vchType = 'II'
			begin
				-- update PM Items according to InspectionItems_PMSchedDetails
	
				update 	WorkOrderInspectItems
				set 	ServiceResultId = @ServiceResultId,
					RepairItemId = @RepairItemId
				where 	[Id] = @ItemId
				and 	WorkOrderId = @OrderId
				and 	OrgId = @OrgId
			end
			return 0
		end
		else -- nothing
		begin
			return -1
		end
	end	

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

