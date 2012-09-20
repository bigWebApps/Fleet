SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER  procedure sp_SelectWorkOrderInspections
	(
		@OrgId int,
		@OrderId int,
		@UserId int
	)
as
	set nocount on

	select 	WOI.[Id],
		@OrderId as OrderId,
		case when isnull(WOI.btIsProcessed, 0) = 0 then 'images\Fail.gif' else 'images\Okay.gif' end as IsProcessed,
		I.vchName as InspectionName,
		case when isnull(WOI.btIsProcessed, 0) = 0 then 'Incomplete' else 'Completed' end as StatusName,
		case when isnull(WOI.btIsProcessed, 0) = 0 and WO.StatusId <> 3 then '[complete]' else '[view]' end as LinkName,
		case when dbo.f_IsTechnician(@UserId) = 1 and WO.StatusId <> 2 and WO.StatusId <> 3 and WO.StatusId <> 6 and isnull(WOI.btIsProcessed, 0) = 0 then 'True' else 'False' end as Access
	from WorkOrderInspections WOI
	inner join Inspections I
	on WOI.WorkOrderId = @OrderId
	and WOI.OrgId = @OrgId
	and I.[Id] = WOI.InspectId
	and I.OrgId = WOI.OrgId
	inner join WorkOrders WO
	on WOI.WorkOrderId = WO.[Id]
	and WOI.OrgId = WO.OrgId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

