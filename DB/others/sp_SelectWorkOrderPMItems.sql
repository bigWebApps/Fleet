SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER procedure sp_SelectWorkOrderPMItems
	(
		@OrgId int,
		@OrderId int,
		@UserId int
	)
as
	set nocount on

	declare @btEnableLink bit

	select @btEnableLink = dbo.f_IsTechnician(@UserId)

	select 	PMI.[Id],
		@OrderId as WorkOrderId,
		case when isnull(PMI.ServiceCheckId, 0) in (1, 2) 
			or (isnull(PMI.ServiceCheckId, 0) = 3 and isnull(PMI.ServiceResultId, 0) in (1, 2))
		then 'images\Okay.gif'
		else 'images\Fail.gif'
		end as IsProcessed,
		isnull(SC.vchDesc, 'Unchecked') as CheckStatusName,
		case when isnull(PMI.ServiceCheckId, 0) <> 3
			then ''
			else isnull(SR.vchDesc, 'No result')
		end as ResultStatusName,
		S.vchDesc as ServiceName,
		case when @btEnableLink = 1 and WO.StatusId <> 2 and WO.StatusId <> 3 and  WO.StatusId <> 6 then 'True' else 'False' end as Access,
		case when isnull(PMI.RepairItemId, 0) = 0 then 'False' else 'True' end as AddNewRepair
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
	left outer join ServiceChecks SC
	on SC.[Id] = PMI.ServiceCheckId
	and SC.btInspectOnly = 0
	left outer join ServiceResults SR
	on SR.[Id] = PMI.ServiceResultId








GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

