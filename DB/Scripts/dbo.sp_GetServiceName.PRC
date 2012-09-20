SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GetServiceName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GetServiceName]
GO

CREATE procedure sp_GetServiceName
	(
		@OrgId int,
		@OrderId int,
		@ItemId int,
		@vchTypeService varchar(25),
		@ServiceName varchar(100)=null output,
		@ServiceType varchar(25)=null output,
		@ServiceCategory varchar(50)=null output
	)
as
	set nocount on
	if isnull(@vchTypeService, '') = 'PMI'
	begin -- getting info of PM item
		select 	@ServiceName = isnull(S.vchDesc, ''),
			@ServiceType = 'Preventive Maintenance',
			@ServiceCategory = isnull(RC.vchName, '')
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
		left outer join RepairCats RC
		on RC.[Id] = S.RepairCatId
		and RC.OrgId = S.OrgId
	end
	if isnull(@vchTypeService, '') = 'RI'
	begin -- getting info of Reported issue
		select 	@ServiceName = isnull(RI.vchDesc, ''),
			@ServiceType = 'Reported Issue',
			@ServiceCategory = isnull(RC.vchName, '')
		from WorkOrderReportedIssues RI
		left outer join RepairCats RC
		on RC.[Id] = RI.RepairCatId
		and RC.OrgId = RI.OrgId
		where RI.[Id] = @ItemId
		and RI.WorkOrderId = @OrderId
		and RI.OrgId = @OrgId
	end
	if isnull(@vchTypeService, '') = 'II'
	begin -- getting info of Inspection item
		select 	@ServiceName = isnull(II.vchDesc, ''),
			@ServiceType = 'Inspection',
			@ServiceCategory = isnull(IC.vchName, '')
		from WorkOrderInspectItems WII
		inner join InspectionItems II
		on WII.[Id] = @ItemId
		and WII.WorkOrderId = @OrderId
		and WII.OrgId = @OrgId
		and WII.ItemId = II.[Id]
		and WII.OrgId = II.OrgId
		left outer join InspectCats IC
		on IC.[Id] = II.InspectCatId
		and IC.OrgId = II.OrgId
	end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

