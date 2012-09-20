SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER   procedure sp_SelectWorkOrderInspectionItems
	(
		@OrgId int,
		@OrderId int,
		@InspectId int,
		@UserId int
	)
as
	set nocount on

	declare @btEnableLink bit

	select @btEnableLink = dbo.f_IsTechnician(@UserId)

	select 	WII.[Id],
		@OrderId as WorkOrderId,
		case when isnull(WII.ServiceCheckId, 0) = 0 then 'True' else 'False' end as VisibleCheckBox,
		case when isnull(WII.ServiceCheckId, 0) in (1, 2, 4) 
			or (isnull(WII.ServiceCheckId, 0) = 3 and isnull(WII.ServiceResultId, 0) in (1, 2))
		then 'images\Okay.gif'
		else 'images\Fail.gif'
		end as IsProcessed,
		II.vchDesc as ItemName,
		case when GR.m = WII.[Id] then IC.vchName else '' end as CatName,
		case when GR.m = WII.[Id] then '#9E755F' else '#CCCCCC' end as BorderColor,
		isnull(SC.vchDesc, 'Unchecked') as CheckStatusName,
		case when isnull(WII.ServiceCheckId, 0) <> 3
			then ''
			else isnull(SR.vchDesc, 'No result')
		end as ResultStatusName,
		case when @btEnableLink = 1 and isnull(WI.btIsProcessed, 0) = 0 and WO.StatusId <> 3 then 'True' else 'False' end as Access,
		case when isnull(WII.RepairItemId, 0) = 0 then 'False' else 'True' end as AddNewRepair
	from WorkOrderInspectItems WII
	inner join InspectionItems II
	on WII.WorkOrderInspectId = @InspectId
	and WII.WorkOrderId = @OrderId
	and WII.OrgId = @OrgId
	and WII.ItemId = II.[Id]
	and WII.OrgId = II.OrgId
	inner join WorkOrderInspections WI
	on WII.WorkOrderInspectId = WI.[Id]
	and WII.OrgId = WI.OrgId
	inner join WorkOrders WO
	on WO.[Id] = WII.WorkOrderId
	and WO.OrgId = WII.OrgId
	inner join InspectCats IC
	on IC.[Id] = II.InspectCatId
	and IC.OrgId = II.OrgId
	left join (
		select II.InspectCatId, min(WII.[Id]) as m
		from WorkOrderInspectItems WII
		inner join InspectionItems II
		on WII.WorkOrderInspectId = @InspectId
		and WII.OrgId = @OrgId
		and WII.ItemId = II.[Id]
		and WII.OrgId = II.OrgId
		group by II.InspectCatId
		) GR
	on GR.InspectCatId = II.InspectCatId
	left outer join ServiceChecks SC
	on SC.[Id] = WII.ServiceCheckId
	left outer join ServiceResults SR
	on SR.[Id] = WII.ServiceResultId
	order by II.InspectCatId asc, II.tintOrder asc










GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

