SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER  procedure sp_SelectWorkOrderPMItems
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
		if exists(select 'true' from WorkOrders where [Id] = @OrderId and OrgId = @OrgId and StatusId <> 2 and StatusId <> 3 and StatusId <> 6)
		begin
			select @btEnableLink = 1
		end 
		else
		begin
			select @btEnableLink = 0
		end
	end
	select 	PMI.[Id],
		@OrderId as WorkOrderId,
		isnull(PMI.ServiceCheckId, 0) as ServiceCheckId,
		isnull(PMI.ServiceResultId, 0) as ServiceResultId,
		case when isnull(PMI.ServiceCheckId, 0) in (1, 2) 
			or (isnull(PMI.ServiceCheckId, 0) = 3 and isnull(PMI.ServiceResultId, 0) in (1, 2))
		then 'images\Okay.gif'
		else 'images\Fail.gif'
		end as IsProcessed,
		RC.vchName as CatName,
		S.vchDesc as ServiceName,
		case when isnull(PMI.ServiceCheckId, 0) <> 3
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
		case when isnull(PMI.ServiceCheckId, 0) = 3 and @btEnableLink = 1 and WO.StatusId <> 2 and WO.StatusId <> 3 and WO.StatusId <> 6 then 'True' else 'False' end as AccessResult,
		case when isnull(PMI.ServiceCheckId, 0) = 1 then 'images\cb_okay.gif' else 'images\cb_blank.gif' end as OkayStatus,
		case when isnull(PMI.ServiceCheckId, 0) = 2 then 'images\cb_fair.gif' else 'images\cb_blank.gif' end as FairStatus,
		case when isnull(PMI.ServiceCheckId, 0) = 3 then 'images\cb_rn.gif' else 'images\cb_blank.gif' end as RNStatus,
		case when isnull(PMI.ServiceCheckId, 0) <> 3 then 'images\cb_disabled.gif' else case when isnull(PMI.ServiceResultId, 0) = 0 then 'images\cb_black.gif' else 'images\cb_blank.gif' end end as NSStatus,
		case when isnull(PMI.ServiceCheckId, 0) <> 3 then 'images\cb_disabled.gif' else case when isnull(PMI.ServiceResultId, 0) = 1 then 'images\cb_black.gif' else 'images\cb_blank.gif' end end as RepairedStatus,
		case when isnull(PMI.ServiceCheckId, 0) <> 3 then 'images\cb_disabled.gif' else case when isnull(PMI.ServiceResultId, 0) = 2 then 'images\cb_black.gif' else 'images\cb_blank.gif' end end as ReplacedStatus,
		case when isnull(PMI.ServiceResultId, 0) > 0 and @btEnableLink = 1 then 'javascript:return confirm("This PM item has been serviced. Select OK to continue and remove the service.")' else '' end as Confirmation
	from WorkOrderPMItems PMI
	inner join PMSchedDetails SD
	on PMI.WorkOrderId = @OrderId
	and PMI.OrgId = @OrgId
	and PMI.PMSchedDetailId = SD.[Id]
	and PMI.OrgId = SD.OrgId
	inner join WorkOrders WO
	on WO.[Id] = PMI.WorkOrderId
	and WO.OrgId = PMI.OrgId
	inner join PMServices S
	on S.[Id] = SD.PMServiceId
	and S.OrgId = SD.OrgId
	left outer join RepairCats RC
	on RC.[Id] = S.RepairCatId
	and RC.OrgId = S.OrgId
	left outer join ServiceChecks SC
	on SC.[Id] = isnull(PMI.ServiceCheckId, 0)
	and SC.btInspectOnly = 0
	left outer join ServiceResults SR
	on SR.[Id] = isnull(PMI.ServiceResultId, 0)
	order by RC.[Id], S.[Id]


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

