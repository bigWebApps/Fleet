SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create procedure dbo.sp_UpdateFutureInspections
	(
		@OrgId int,
		@OrderId int output,
		@InspectId int
	)
AS
	set nocount on

	declare @oldOrderId int

	if not exists(select 'true' from WorkOrderInspections 
			where [Id] = @InspectId
			and OrgId = @OrgId)
	begin
		return -1
	end
	else
	begin
		select @oldOrderId = WorkOrderId
		from [WorkOrderInspections]
		where 	[Id] = @InspectId
		and 	OrgId = @OrgId
		
		update 	[WorkOrderInspectItems]
		set 	[WorkOrderId] = @OrderId,
			[ServiceCheckId] = null,
			[ServiceResultId] = null,
			[RepairItemId] = null
		where 	[WorkOrderInspectId] = @InspectId
		and 	OrgId = @OrgId

		update 	[WorkOrderInspections]
		set 	[WorkOrderId] = @OrderId
		where 	[Id] = @InspectId
		and 	OrgId = @OrgId

		select 	@OrderId = @oldOrderId
		
		return 0
	end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

