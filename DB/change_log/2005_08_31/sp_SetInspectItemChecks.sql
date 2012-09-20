SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 9/2/2004 
-- Description: The procedure set te check status to inspection items 
-- in work order and PM items associated with instection items
---------------------------------------------------------------------------
ALTER   procedure sp_SetInspectItemChecks
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
	declare @PMSchedDetailId int
	
	declare @tmp table(
		[Id] int identity(1, 1), 
		RepairId int
		)
	declare @tmp_pm table(
		[Id] int identity(1, 1),
		PMSchedDetailId int
		)

	if not exists(select 'true' from WorkOrderInspectItems where [Id] = @ItemId and OrgId = @OrgId and WorkOrderId = @OrderId)
	begin
		return -1
	end
	else
	begin
		-- select the link to serviced repairs if they is there
		select 	@RepairItemId = isnull(RepairItemId, 0)
		from 	WorkOrderInspectItems
		where 	[Id] = @ItemId 
		and 	OrgId = @OrgId
		and 	WorkOrderId = @OrderId

		-- set a new check status for the Inspection item
		update 	WorkOrderInspectItems
		set 	ServiceCheckId = @ServiceCheckId,
			ServiceResultId = null,
			RepairItemId = null
		where 	[Id] = @ItemId
		and 	OrgId = @OrgId
		and 	WorkOrderId = @OrderId

		-- updating the PM Items that was associated with an Inspection items
		-- The association store in a InspectionItems_PMSchedDetails

		if isnull(@ServiceCheckId, 0) = 1 or isnull(@ServiceCheckId, 0) = 2
		begin
			-- update PM Items according to InspectionItems_PMSchedDetails
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
				set 	ServiceCheckId = @ServiceCheckId,
					ServiceResultId = null,
					RepairItemId = null
				where 	WorkOrderId = @OrderId
				and 	OrgId = @OrgId
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
		
				while @i <= @N
				begin
					select @PMSchedDetailId  = PMSchedDetailId 
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
							@dtCurrentDate,
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
						set 	dtDate = @dtCurrentDate,
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

		if isnull(@ServiceResultId, 0) > 0 
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
				insert into @tmp(RepairId)
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
							from @tmp
							where [Id] = @i
							)
						)
					begin
						delete from PartsUsed
						where OrgId = @OrgId
						and RepairId in (
							select RepairId
							from @tmp
							where [Id] = @i
							)
		
						delete from Repairs
						where OrgId = @OrgId
						and [Id] in (
							select RepairId
							from @tmp
							where [Id] = @i
							)
					end
					select @i = @i + 1
				end
			end
		end

		return 0
	end



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

