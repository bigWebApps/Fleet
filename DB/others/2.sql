use FleetPro

declare @OrderId int
declare @OrgId int

select @OrderId = 1
select @OrgId = 1

	select 	PMI.[Id],
		case when isnull(PMI.ServiceCheckId, 0) in (1, 2) 
			or (isnull(PMI.ServiceCheckId, 0) = 3 and isnull(PMI.ServiceResultId, 0) in (1, 2))
		then 'images\Okay.gif'
		else 'images\Fail.gif'
		end as IsProcessed,
		isnull(SC.vchDesc, 'Unchecked') as CheckStatusName,
		case when isnull(PMI.ServiceCheckId, 0) <> 3
			then ''
			else isnull(SR.vchDesc, 'no result')
		end as ResultStatusName,
		S.vchDesc as ServiceName
	from WorkOrderPMItems PMI
	inner join PMSchedDetails SD
	on PMI.WorkOrderId = @OrderId
	and PMI.OrgId = @OrgId
	and PMI.PMSchedDetailId = SD.[Id]
	and PMI.OrgId = SD.OrgId
	inner join PMServices S
	on S.[Id] = SD.PMServiceId
	and S.OrgId = SD.OrgId
	left outer join ServiceChecks SC
	on SC.[Id] = PMI.ServiceCheckId
	and SC.btInspectOnly = 0
	left outer join ServiceResults SR
	on SR.[Id] = PMI.ServiceResultId

	select 	RI.[Id],
		case when isnull(RI.ServiceCheckId, 0) in (1, 2) 
			or (isnull(RI.ServiceCheckId, 0) = 3 and isnull(RI.ServiceResultId, 0) in (1, 2))
		then 'images\Okay.gif'
		else 'images\Fail.gif'
		end as IsProcessed,
		RI.vchDesc as IssuesName,
		RC.vchName as CatName,
		isnull(SC.vchDesc, 'unchecked') as CheckStatusName,
		case when isnull(RI.ServiceCheckId, 0) <> 3
			then ''
			else isnull(SR.vchDesc, 'no result')
		end as ResultStatusName
	from WorkOrderReportedIssues RI
	inner join RepairCats RC
	on RI.WorkOrderId = @OrderId
	and RI.OrgId = @OrgId
	and RI.RepairCatId = RC.[Id]
	and RI.OrgId = RC.OrgId
	left outer join ServiceChecks SC
	on SC.[Id] = RI.ServiceCheckId
	and SC.btInspectOnly = 0
	left outer join ServiceResults SR
	on SR.[Id] = RI.ServiceResultId

	select 	WOI.[Id],
		case when isnull(WOI.btIsProcessed, 0) = 0 then 'images\Fail.gif' else 'images\Okay.gif' end as IsProcessed,
		I.vchName as InspectionName,
		case when isnull(WOI.btIsProcessed, 0) = 0 then 'uncompleted' else 'completed' end as StatusName
	from WorkOrderInspections WOI
	inner join Inspections I
	on WOI.WorkOrderId = @OrderId
	and WOI.OrgId = @OrgId
	and I.[Id] = WOI.InspectId
	and I.OrgId = WOI.OrgId

exec sp_SelectWorkOrderInspections 1, 1