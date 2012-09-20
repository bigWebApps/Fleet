SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER procedure sp_GetServiceName
	(
		@OrgId int,
		@OrderId int,
		@ItemId int,
		@vchTypeService varchar(25),
		@ServiceName varchar(100)=null output,
		@ServiceCheckId int=null output,
		@ServiceResultId int=null output,
		@RepairItemId int=null output,
		@ExtItem int=null output
	)
as
	set nocount on

	if isnull(@vchTypeService, '') = 'PMI'
	begin -- getting info of PM item
		select 	@ServiceName = isnull(S.vchDesc, ''),
			@ServiceCheckId = isnull(WOI.ServiceCheckId, 0),
			@ServiceResultId = isnull(WOI.ServiceResultId, 0),
			@RepairItemId = isnull(WOI.RepairItemId, 0),
			@ExtItem = 0
		from PMServices S
		inner join PMSchedDetails SD
		on SD.PMServiceId = S.[Id]
		and SD.OrgId = S.OrgId
		inner join WorkOrderPMItems WOI
		on WOI.WorkOrderId = @OrderId
		and WOI.[Id] = @ItemId
		and WOI.OrgId = @OrgId
		and WOI.PMSchedDetailId = SD.[Id]
		and WOI.OrgId = SD.OrgId
	end
	if isnull(@vchTypeService, '') = 'RI'
	begin -- getting info of Reported issue
		select 	@ServiceName = isnull(RI.vchDesc, ''),
			@ServiceCheckId = isnull(RI.ServiceCheckId, 0),
			@ServiceResultId = isnull(RI.ServiceResultId, 0),
			@RepairItemId = isnull(RI.RepairItemId, 0),
			@ExtItem = 0
		from WorkOrderReportedIssues RI
		where RI.[Id] = @ItemId
		and RI.WorkOrderId = @OrderId
		and RI.OrgId = @OrgId
	end
	if isnull(@vchTypeService, '') = 'II'
	begin -- getting info of Inspection item
		select 	@ServiceName = isnull(II.vchDesc, ''),
			@ServiceCheckId = isnull(WII.ServiceCheckId, 0),
			@ServiceResultId = isnull(WII.ServiceResultId, 0),
			@RepairItemId = isnull(WII.RepairItemId, 0),
			@ExtItem = isnull(WorkOrderInspectId, 0)
		from WorkOrderInspectItems WII
		inner join InspectionItems II
		on WII.[Id] = @ItemId
		and WII.WorkOrderId = @OrderId
		and WII.OrgId = @OrgId
		and WII.ItemId = II.[Id]
		and WII.OrgId = II.OrgId
	end



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

