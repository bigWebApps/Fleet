SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 09/15/2005
-- Description: creating of the Work Order with Inspection on future
---------------------------------------------------------------------------
ALTER procedure sp_SetInspectWorkOrder
(
	@OrgId int,
	@EquipId int,
	@dtScheduledDate datetime,
	@InspectSchedDetailId int,
	@UserId int,
	@dtCurrentDate datetime,
	@OrderId int=null output,
	@WorkOrderNumber int=null output
)
as
	set nocount on

	declare @intOperatorId int
	declare @DataId int
	declare @WOInspectId int

	select @WorkOrderNumber = isnull(max(WorkOrderNumber), 0) + 1
	from WorkOrders
	where datediff(minute, dateadd(d, datediff(d, '', @dtCurrentDate), ''), dtCreated) > 0
	and datediff(minute, dtCreated, dateadd(day, 1, dateadd(d, datediff(d, '', @dtCurrentDate), ''))) > 0
	
	if exists(select 'true' 
		from Equipments 
		where [Id] = @EquipId
		and OrgId = @OrgId
		and isnull(EquipOperatorId, 0) = 0
		and isnull(TempOperatorId, 0) = 0)
		select @intOperatorId = @UserId
	else
		select @intOperatorId = (case when isnull(EquipOperatorId, 0) = 0 then TempOperatorId else EquipOperatorId end)
		from Equipments
		where [Id] = @EquipId
		and OrgId = @OrgId

	insert into [EquipData](
		[OrgId], 
		[intCreatedBy], 
		[dtCreated], 
		[intUpdatedBy], 
		[dtUpdated], 
		[vchOrdering], 
		[ftItemOrder], 
		[intSize]
		)
	values(
		@OrgId,
		@UserId,
		@dtCurrentDate,
		@UserId,
		@dtCurrentDate,
		null, 
		null, 
		0
		)
	select @DataId = scope_identity()
		
	insert into [WorkOrders](
		[OrgId], 
		[WorkOrderNumber], 
		[EquipId], 
		[TypeId],
		[StatusId], 
		[OperatorStatusId],
		[DataId],
		[btIsActive], 
		[intOperatorId], 
		[intTechId],
		[dtScheduled], 
		[intCreatedBy], 
		[dtCreated], 
		[intUpdatedBy], 
		[dtUpdated]
		)
	values(
		@OrgId, 
		@WorkOrderNumber,
		@EquipId,
		1,
		3,
		null,
		@DataId,
		1,
		@intOperatorId,
		null,
		@dtScheduledDate,
		@UserId,
		@dtCurrentDate,
		@UserId,
		@dtCurrentDate
		)

	select @OrderId = scope_identity()

	insert into WorkOrderInspections(
		[OrgId], 
		[WorkOrderId], 
		[InspectSchedDetailId],
		[TechId],
		[dtReport],
		[btIsProcessed]
		)
	values(	
		@OrgId,
		@OrderId,
		@InspectSchedDetailId,
		null,
		@dtCurrentDate,
		0
		)

	select @WOInspectId = scope_identity()

	insert into [WorkOrderInspectItems](
		[OrgId], 
		[WorkOrderId], 
		[WorkOrderInspectId], 
		[ItemId], 
		[ServiceResultId], 
		[ServiceCheckId], 
		[RepairItemId]
		)
	select 	@OrgId,
		@OrderId,
		@WOInspectId,
		II.[Id],
		null,
		null,
		null
	from InspectionItems II
	inner join InspectSchedDetails ISD
	on ISD.[Id] = @InspectSchedDetailId
	and ISD.OrgId = @OrgId
	and II.InspectId = ISD.InspectionId
	and II.OrgId = ISD.OrgId
	and II.btEnabled = 1
	order by II.InspectCatId, II.tintOrder asc

	return



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

