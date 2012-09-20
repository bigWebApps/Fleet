SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER procedure sp_SetInspectItemChecks
	(
		@OrgId int,
		@OrderId int,
		@ItemId int,
		@ServiceCheckId int=null,
		@ServiceResultId int=null, -- old result status
		@dtCurrentDate datetime
	)
AS
	set nocount on
	declare @IsDelete bit
	declare @RepairItemId int
	declare @i int
	declare @N int
	create table #tmp(
		[Id] int identity(1, 1), 
		RepairId int
		)
	if not exists(select 'true' from WorkOrderInspectItems where [Id] = @ItemId and OrgId = @OrgId and WorkOrderId = @OrderId)
	begin
		return -1
	end
	else
	begin
		select 	@RepairItemId = isnull(RepairItemId, 0)
		from 	WorkOrderInspectItems
		where 	[Id] = @ItemId 
		and 	OrgId = @OrgId
		and 	WorkOrderId = @OrderId
		if isnull(@ServiceResultId, 0) > 0 -- then delete the his repairs
		begin
			-- if the deleting repair has relate to an other PM items, Issues, and Inspection Items 
			-- then don't delete repair and only update this Inspection Items
			select @IsDelete = 1
			if exists(select 'true' 
				from WorkOrderPMItems
				where OrgId = @OrgId
				and WorkOrderId = @OrderId
				and RepairItemId = @RepairItemId
				)
			begin
				select @IsDelete = 0
			end
			if exists(select 'true' 
				from WorkOrderReportedIssues
				where OrgId = @OrgId
				and WorkOrderId = @OrderId
				and RepairItemId = @RepairItemId
				)
			begin
				select @IsDelete = 0
			end
			if exists(select 'true' 
				from WorkOrderInspectItems
				where OrgId = @OrgId
				and WorkOrderId = @OrderId
				and RepairItemId = @RepairItemId
				and [Id] <> @ItemId
				)
			begin
				select @IsDelete = 0
			end
			if @IsDelete = 1
			begin -- processing all repairs for delete
				insert into #tmp(RepairId)
				select RepairId
				from RepairMult
				where ItemId = @RepairItemId
				and OrgId = @OrgId
				select @i = 1, @N = scope_identity()
				delete from RepairMult
				where ItemId = @RepairItemId
				and OrgId = @OrgId
				
				-- deleting all repairs, if repair has other issues (or other item) 
				-- then don't delete it
				while @i <= @N
				begin
					if not exists(select 'true' 
						from RepairMult 
						where OrgId = @OrgId 
						and RepairId in (
							select RepairId
							from #tmp
							where [Id] = @i
							)
						)
					begin
						delete from PartsUsed
						where OrgId = @OrgId
						and RepairId in (
							select RepairId
							from #tmp
							where [Id] = @i
							)
		
						delete from Repairs
						where OrgId = @OrgId
						and [Id] in (
							select RepairId
							from #tmp
							where [Id] = @i
							)
					end
					select @i = @i + 1
				end
			end
		end

		update 	WorkOrderInspectItems
		set 	ServiceCheckId = @ServiceCheckId,
			ServiceResultId = null,
			RepairItemId = null
		where 	[Id] = @ItemId
		and 	OrgId = @OrgId
		and 	WorkOrderId = @OrderId
/*

		if isnull(@ServiceCheckId, 0) = 1 or isnull(@ServiceCheckId, 0) = 2
		begin
			-- update PM Items according to InspectionItems_PMSchedDetails
		update 	WorkOrderPMItems
		set 	ServiceCheckId = @ServiceCheckId,
			ServiceResultId = null,
			RepairItemId = null
		where 	[Id] = @ItemId 
		and 	OrgId = @OrgId
		and 	WorkOrderId = @OrderId

			-- in history table is keeping the last check of detail
			-- if the record already there then editing else adding
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
					@CurrentDate,
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
				set 	dtDate = @CurrentDate,
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
*/
		return 0
	end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

