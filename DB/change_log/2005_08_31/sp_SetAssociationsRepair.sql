SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 9/2/2004 
-- Description: The procedure set the association between serviced repair and 
-- issue (reported Issue, PM Item, Inspection Item)
---------------------------------------------------------------------------
ALTER   procedure sp_SetAssociationsRepair
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
	declare @i int
	declare @N int
	declare @PMSchedDetailId int

	declare @tmp_pm table(
		[Id] int identity(1, 1),
		PMSchedDetailId int
		)
	
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
				update 	WorkOrderInspectItems
				set 	ServiceResultId = @ServiceResultId,
					RepairItemId = @RepairItemId
				where 	[Id] = @ItemId
				and 	WorkOrderId = @OrderId
				and 	OrgId = @OrgId

				-- updated the PM items that associated with current Inspection Item 
				if exists(select 'true' 
					from InspectionItems_PMSchedDetails I_P
					inner join WorkOrderInspectItems II
					on 	II.[Id] = @ItemId
					and  	II.WorkOrderId = @OrderId
					and 	II.OrgId = @OrgId
					and  	I_P.InspectItemId = II.ItemId
					and 	I_P.OrgId = II.OrgId
					)
				begin
					update 	WorkOrderPMItems 
					set 	ServiceCheckId = 3,
						ServiceResultId = @ServiceResultId,
						RepairItemId = @RepairItemId
					where 	WorkOrderId = @OrderId
					and 	OrgId = @OrgId
					and 	isnull(RepairItemId, 0) = 0
					and 	PMSchedDetailId in (
						select 	I_P.PMSchedDetailId
						from 	InspectionItems_PMSchedDetails I_P
						inner join WorkOrderInspectItems II
						on 	II.[Id] = @ItemId
						and  	II.WorkOrderId = @OrderId
						and 	II.OrgId = @OrgId
						and  	I_P.InspectItemId = II.ItemId
						and 	I_P.OrgId = II.OrgId
						)
	
					-- in any case we must to update of PM history 
					-- that this pm items was serviced
	
					-- select all associated PM Items 
					insert into @tmp_pm(PMSchedDetailId)
					select 	PMSD.[Id]
					from 	WorkOrders WO
					inner join Equipments E 
					on 	WO.[Id] = @OrderId
					and 	WO.OrgId = @OrgId
					and 	WO.EquipId = E.[Id]
					and 	WO.ORgId = E.OrgId
					inner join PMSchedDetails PMSD
					on 	PMSD.PMSchedId = E.PMScheduleId
					and 	PMSD.OrgId = E.OrgId
					inner join InspectionItems_PMSchedDetails IP
					on 	IP.PMSchedDetailId = PMSD.[Id]
					and 	IP.OrgId = PMSD.OrgId
					inner join WorkOrderInspectItems II
					on 	II.[Id] = @ItemId
					and 	II.WorkOrderId = WO.[Id]
					and 	IP.InspectItemId = II.ItemId
					and 	IP.OrgId = II.OrgId
	
					select @i = 1, @N = scope_identity()
	
					-- update the PM History
					while @i <= @N
					begin
						select @PMSchedDetailId = PMSchedDetailId
						from @tmp_pm
						where [Id] = @i
		
						-- in history table is keeping the last check of detail
						-- if the record already there then editing else adding
						if not exists(select 'true' 
							from EquipPMHistory EH 
							inner join WorkOrders WO
							on 	WO.[Id] = @OrderId
							and 	WO.OrgId = @OrgId
							and 	EH.WorkOrderid = WO.[Id]
							and 	EH.EquipId = WO.EquipId
							and 	EH.OrgId = WO.OrgId
							and 	EH.PMSchedDetailId = @PMSchedDetailId
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
								@PMSchedDetailId,
								WO.dmMileage,
								@OrderId
							from 	WorkOrders WO
							where  	WO.[Id] = @OrderId
							and 	WO.OrgId = @OrgId
						end
						else
						begin -- update history
							update 	EquipPMHistory
							set 	dtDate = getdate(),
								dmUnits = WO.dmMileage
							from 	WorkOrders WO
							where	WO.[Id] = @OrderId
							and 	WO.OrgId = @OrgId
							and	EquipPMHistory.EquipId = WO.Equipid
							and	EquipPMHistory.OrgId = WO.OrgId
							and	EquipPMHistory.PMSchedDetailId = @PMSchedDetailId
							and 	EquipPMHistory.WorkOrderId = WO.[Id]
						end
		
						select @i = @i + 1
					end
				end
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

