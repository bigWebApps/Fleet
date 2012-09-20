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
		isnull(WII.ServiceCheckId, 0) as ServiceCheckId,
		isnull(WII.ServiceResultId, 0) as ServiceResultId,
		case when isnull(WII.ServiceCheckId, 0) = 0 then 'True' else 'False' end as VisibleCheckBox,
		case when isnull(WII.ServiceCheckId, 0) in (1, 2, 4) 
			or (isnull(WII.ServiceCheckId, 0) = 3 and isnull(WII.ServiceResultId, 0) in (1, 2))
		then 'images\Okay.gif'
		else 	case when isnull(WII.ServiceCheckId, 0) = 3 and isnull(WII.ServiceResultId, 0) = 0 
			then 'images\Yellow.gif'
			else 'images\Fail.gif'
			end
		end as IsProcessed,
		II.vchDesc as ItemName,
		case when isnull(WII.ServiceCheckId, 0) = 0 then 'okay_div' + convert(varchar, IC.[Id]) else 'checked' end as OkayCatId,
		case when isnull(WII.ServiceCheckId, 0) = 0 then 'fair_div' + convert(varchar, IC.[Id]) else 'checked' end as FairCatId,
		case when GR.m = WII.[Id] then '		<tr valign="middle" class="ag03">
									<td align="center">Category</td>
									<td align="center"></td>
									<td align="center">Name</td>
									<td align="center">Summary</td>
									<td align="center" width="50px">OK</td>
									<td align="center" width="50px">FAIR</td>
									<td align="center" width="50px">Repairs<br>
										Needed</td>
									<td align="center" width="50px">No<br>
										Service</td>
									<td align="center" width="50px">Repaired</td>
									<td align="center" width="50px">Replaced</td>
								</tr>
		' else '' end as Header,
		case when GR.m = WII.[Id] then IC.vchName else '' end as CatName,
		case when GR.m = WII.[Id] then '#9E755F' else '#CCCCCC' end as BorderColor,
		case when GR.m = WII.[Id] then 'display:' else 'display:none' end as VisibleSelectButtonOkay,
		case when (GR.m + 1) = WII.[Id] then 'display:' else 'display:none' end as VisibleSelectButtonFair,
		case when GR.m = WII.[Id] then 'javascript:CheckOkayCat("okay_div' + convert(varchar, IC.[Id]) + '");' else '' end as OkayScript,
		case when (GR.m + 1) = WII.[Id] then 'javascript:CheckFairCat("fair_div' + convert(varchar, IC.[Id]) + '");' else '' end as FairScript,
		case when isnull(WII.ServiceCheckId, 0) <> 3
			then isnull(SC.vchDesc, '')
			else isnull(SC.vchDesc, '') + ' - ' + isnull(SR.vchDesc, 'Non-Serviced')
		end as SummaryName,
		case when @btEnableLink = 1 and isnull(WI.btIsProcessed, 0) = 0 and WO.StatusId <> 3 then 'True' else 'False' end as Access,
		case when @btEnableLink = 1 and isnull(WI.btIsProcessed, 0) = 0 and WO.StatusId <> 3 and isnull(WII.ServiceCheckId, 0) = 3 then 'True' else 'False' end as AccessCheck,
		case when isnull(WII.ServiceCheckId, 0) = 1 then 'True' else 'False' end as OkayChecked,
		case when isnull(WII.ServiceCheckId, 0) = 2 then 'True' else 'False' end as FairChecked,
		case when isnull(WII.ServiceCheckId, 0) = 3 then 'True' else 'False' end as RNChecked,
		case when isnull(WII.ServiceCheckId, 0) = 3 and isnull(WII.ServiceResultId, 0) = 0 then 'True' else 'False' end as NSChecked,
		case when isnull(WII.ServiceCheckId, 0) = 3 and isnull(WII.ServiceResultId, 0) = 1 then 'True' else 'False' end as RepairedChecked,
		case when isnull(WII.ServiceCheckId, 0) = 3 and isnull(WII.ServiceResultId, 0) = 2 then 'True' else 'False' end as ReplacedChecked
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

