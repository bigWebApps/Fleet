SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER  procedure sp_SelectWorkOrderListForDate
(
		@OrgId int,
		@dtMinDate datetime,
		@dtMaxDate datetime
)
AS
	set nocount on
	
	select 	WO.[Id],
		dateadd(d, datediff(d, '', WO.dtScheduled), '') as [Date],
		datepart(dw, WO.dtScheduled) as [WeekDay],
		isnull(E.vchEquipId, '') as vchEquipId,
		convert(varchar, year(WO.dtCreated)) + '-' + 
		convert(varchar, month(WO.dtCreated)) + '-' + 
		convert(varchar, day(WO.dtCreated)) + '-' + 
		convert(varchar, WO.WorkOrderNumber) as vchWorkOrderNumber,
		case when isnull(LT.vchFirstName, '') = '' then 'Unassigned' else LT.vchLastName + ', ' + LT.vchFirstName end as TechName,
		case when isnull(LO.vchFirstName, '') = '' then 'Unassigned' else LO.vchLastName + ', ' + LO.vchFirstName end as OperatorName,
		case when isnull(LO.vchLastName, '') = '' then 'Unassigned' else LO.vchLastName end as OperatorLastName,
		isnull(WOS.vchStatus, 'Unknown') as StatusName,
		isnull(WOS.vchColor, '') as Color
	from WorkOrders WO
	inner join WorkOrderStatus WOS
	on WO.StatusId = WOS.[Id]
	and WO.OrgId = @OrgId
	and WO.btIsActive = 1
	and datediff(minute, @dtMinDate, dateadd(d, 1, dateadd(d, datediff(d, '', WO.dtScheduled), ''))) > 0 
	and datediff(minute, dateadd(d, datediff(d, '', WO.dtScheduled), ''), @dtMaxDate) > 0 
	left outer join Equipments E
	on E.[Id] = WO.EquipId
	and E.OrgId = Wo.OrgId
	left outer join Logins LT
	on WO.intTechid = LT.[Id]
	left outer join Logins LO
	on WO.intOperatorId = LO.[Id]
	order by vchWorkOrderNumber asc


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

