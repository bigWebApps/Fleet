SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER  procedure sp_UpdateRepairMult
	(
		@OrgId int,
		@OrderId int,
		@ItemId int,
		@vchTypeService varchar(25),
		@RepairId int=null output
	)
as
	set nocount on

	declare @RepairItemId int

	if isnull(@vchTypeService, '') = 'PMI' -- adding repair to WorkOrderPMItems item
	begin
		select @RepairItemId = RepairItemId
		from WorkOrderPMItems
		where [Id] = @ItemId
		and WorkOrderId = @OrderId
		and OrgId = @OrgId
	end

	if isnull(@vchTypeService, '') = 'RI' -- adding repair to WorkOrderReportedIssues item
	begin
		select @RepairItemId = RepairItemId
		from WorkOrderReportedIssues
		where [Id] = @ItemId
		and WorkOrderId = @OrderId
		and OrgId = @OrgId
	end

	if isnull(@vchTypeService, '') = 'II' -- adding repair to WorkOrderInspectionItems item
	begin
		select @RepairItemId = RepairItemId
		from WorkOrderInspectItems
		where [Id] = @ItemId
		and WorkOrderId = @OrderId
		and OrgId = @OrgId
	end

	if isnull(@RepairItemId, 0) = 0
	begin
		return -1
	end
	else
	begin
		insert into Repairs(
			OrgId,
			RepairItemId,
			WorkOrderId,
			vchDesc
			)
		values( 
			@OrgId,
			null,
			@OrderId,
			''
			)
		select @RepairId = scope_identity()

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
	end

	return 0


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

