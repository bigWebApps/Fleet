SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectWorkOrderReportedIssues]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectWorkOrderReportedIssues]
GO



CREATE  procedure sp_SelectWorkOrderReportedIssues
	(
		@OrgId int,
		@OrderId int,
		@UserId int
	)
as
	set nocount on
	declare @btEnableLink bit
	select @btEnableLink = dbo.f_IsTechnician(@UserId)
	if @btEnableLink = 1
	begin
		if exists(select 'true' from WorkOrders where [Id] = @OrderId and OrgId = @OrgId and StatusId <> 2)
		begin
			select @btEnableLink = 1
		end 
		else
		begin
			select @btEnableLink = 0
		end
	end
	else	select @btEnableLink = 0

	
	select 	RI.[Id],
		@OrderId as WorkOrderId,
		isnull(RI.ServiceCheckId, 0) as ServiceCheckId,
		isnull(RI.ServiceResultId, 0) as ServiceResultId,
		case when isnull(RI.ServiceCheckId, 0) in (1, 2) 
			or (isnull(RI.ServiceCheckId, 0) = 3 and isnull(RI.ServiceResultId, 0) in (1, 2))
		then 'images\Okay.gif'
		else case when isnull(RI.ServiceCheckId, 0) = 3 and isnull(RI.ServiceResultId, 0) = 0 
		then 'images\Yellow.gif'
		else 'images\Fail.gif' end
		end as IsProcessed,
		RI.vchDesc as IssuesName,
		RC.vchName as CatName,
		case when isnull(RI.ServiceCheckId, 0) <> 3
			then isnull(SC.vchDesc, '')
			else isnull(SC.vchDesc, '') + ' - ' + isnull(SR.vchDesc, 'Non-Serviced')
		end as SummaryName,
		case when @btEnableLink = 1 
			then 'True' 
			else 'False' 
		end as Access,
		case when @btEnableLink = 1 
			then 'javascript:return confirm("Are you sure that you want to delete this item?")' 
			else '' 
		end as RemoveConfirmation,
		case when isnull(RI.ServiceCheckId, 0) = 3 and @btEnableLink = 1 then 'True' else 'False' end as AccessResult,
		case when isnull(RI.ServiceCheckId, 0) = 1 then 'images\cb_okay.gif' else 'images\cb_blank.gif' end as OkayStatus,
		case when isnull(RI.ServiceCheckId, 0) = 2 then 'images\cb_fair.gif' else 'images\cb_blank.gif' end as FairStatus,
		case when isnull(RI.ServiceCheckId, 0) = 3 then 'images\cb_rn.gif' else 'images\cb_blank.gif' end as RNStatus,
		case when isnull(RI.ServiceCheckId, 0) <> 3 then 'images\cb_disabled.gif' else case when isnull(RI.ServiceResultId, 0) = 0 then 'images\cb_black.gif' else 'images\cb_blank.gif' end end as NSStatus,
		case when isnull(RI.ServiceCheckId, 0) <> 3 then 'images\cb_disabled.gif' else case when isnull(RI.ServiceResultId, 0) = 1 then 'images\cb_black.gif' else 'images\cb_blank.gif' end end as RepairedStatus,
		case when isnull(RI.ServiceCheckId, 0) <> 3 then 'images\cb_disabled.gif' else case when isnull(RI.ServiceResultId, 0) = 2 then 'images\cb_black.gif' else 'images\cb_blank.gif' end end as ReplacedStatus,
		case when isnull(RI.ServiceResultId, 0) > 0 and @btEnableLink = 1 
			then 'javascript:return confirm("This repair issue has been serviced. Select OK to continue and remove the service.")' 
			else case when isnull(WO.StatusId, 0) = 3 
				then case when isnull(WO.OperatorStatusId, 0) = 0
					then 'javascript:return confirm("This work order is not currently Checked-In. Click OK to Check-In and Open this Work Order.")'
					else 'javascript:return confirm("This work order is not currently Open. Click OK to Open this Work Order.")'
				end
				else '' 
			end
		end as Confirmation
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
	on SC.[Id] = isnull(RI.ServiceCheckId, 0)
	and SC.btInspectOnly = 0
	left outer join ServiceResults SR
	on SR.[Id] = isnull(RI.ServiceResultId, 0)





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

