SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER procedure sp_SelectWorkOrderReportedIssues
	(
		@OrgId int,
		@OrderId int,
		@UserId int
	)
as
	set nocount on

	declare @btEnableLink bit

	select @btEnableLink = dbo.f_IsTechnician(@UserId)
	
	select 	RI.[Id],
		@OrderId as WorkOrderId,
		case when isnull(RI.ServiceCheckId, 0) in (1, 2) 
			or (isnull(RI.ServiceCheckId, 0) = 3 and isnull(RI.ServiceResultId, 0) in (1, 2))
		then 'images\Okay.gif'
		else 'images\Fail.gif'
		end as IsProcessed,
		RI.vchDesc as IssuesName,
		RC.vchName as CatName,
		isnull(SC.vchDesc, 'Unchecked') as CheckStatusName,
		case when isnull(RI.ServiceCheckId, 0) <> 3
			then ''
			else isnull(SR.vchDesc, 'No result')
		end as ResultStatusName,
		case when @btEnableLink = 1 and WO.StatusId <> 2 and WO.StatusId <> 3 and WO.StatusId <> 6 then 'True' else 'False' end as Access,
		case when isnull(RI.RepairItemId, 0) = 0 then 'False' else 'True' end as AddNewRepair
	from WorkOrderReportedIssues RI
	inner join RepairCats RC
	on RI.WorkOrderId = @OrderId
	and RI.OrgId = @OrgId
	and RI.RepairCatId = RC.[Id]
	and RI.OrgId = RC.OrgId
	inner join WorkOrders WO
	on WO.[Id] = RI.WorkOrderId
	and WO.OrgId = RI.OrgId
	left outer join ServiceChecks SC
	on SC.[Id] = RI.ServiceCheckId
	and SC.btInspectOnly = 0
	left outer join ServiceResults SR
	on SR.[Id] = RI.ServiceResultId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

