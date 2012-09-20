SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


create procedure sp_GetRepairInfo
	(
		@Action char(1),
		@OrgId int,
		@OrderId int,
		@ItemId int,
		@vchTypeService varchar(25),
		@ServiceName varchar(100)=null output,
		@RepairId int=null output,
		@RepairDesc varchar(4000)=null output,
		@RepairItemId int=null output,
		@RepairItemName varchar(1000)=null output,
		@RepairReasonId int=null output,
		@RepairReasonName varchar(100)=null output,
		@RepairCatId int=null output,
		@RepairCatName varchar(25)=null output
	)
as
	set nocount on

	if isnull(@vchTypeService, '') = 'PMI'
	begin


		select 	@ServiceName = isnull(S.vchDesc, ''),
			@ServiceCheckId = isnull(WOI.ServiceCheckId, 0),
			@ServiceResultId = isnull(WOI.ServiceResultId, 0),
			@RepairId = isnull(WOI.RepairId, 0)
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
	begin
		select 	@ServiceName = isnull(RI.vchDesc, ''),
			@ServiceCheckId = isnull(RI.ServiceCheckId, 0),
			@ServiceResultId = isnull(RI.ServiceResultId, 0),
			@RepairId = isnull(RI.RepairId, 0)
		from WorkOrderReportedIssues RI
		where RI.[Id] = @ItemId
		and RI.WorkOrderId = @OrderId
		and RI.OrgId = @OrgId
	end



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

