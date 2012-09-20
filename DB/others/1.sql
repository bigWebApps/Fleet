-- select * from Inspections
-- select * from InspectCats

-- first table

-- second table
select 	WII.[Id] as Id,
	WII.ServiceCheckId,
	WII.ServiceResultId,
	case when GR.m = WII.[Id] then IC.vchName else '' end as CatName,
	II.vchDesc as ItemName
from WorkOrderInspectItems WII
inner join InspectionItems II
on WII.WorkOrderInspectId = 24
and WII.OrgId = 1
and WII.ItemId = II.[Id]
and WII.OrgId = II.OrgId
inner join InspectCats IC
on IC.[Id] = II.InspectCatId
and IC.OrgId = II.OrgId
left join (
	select II.InspectCatId, min(WII.[Id]) as m
	from WorkOrderInspectItems WII
	inner join InspectionItems II
	on WII.WorkOrderInspectId = 24
	and WII.OrgId = 1
	and WII.ItemId = II.[Id]
	and WII.OrgId = II.OrgId
	group by II.InspectCatId
	) GR
on GR.InspectCatId = II.InspectCatId
order by II.InspectCatId asc, II.tintOrder asc

/*
select InspectCatId
from InspectionItems
where OrgId = 1
group by InspectCatId

*/