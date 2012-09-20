SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

alter procedure sp_SelectMonthlyWorkOrder
(
		@OrgId int,
		@dtCurrentDate datetime
)
AS
	set nocount on
	
	select 	WO.[Id],
		datepart(day, WO.dtScheduled) as [Day],
		convert(varchar, year(WO.dtCreated)) + '-' + 
		convert(varchar, month(WO.dtCreated)) + '-' + 
		convert(varchar, day(WO.dtCreated)) + '-' + 
		convert(varchar, WO.WorkOrderNumber) as vchWorkOrderNumber,
		isnull(E.vchEquipId, '') as vchEquipId,
		case when isnull(LO.vchLastName, '') = '' then 'Unassigned' else LO.vchLastName end as OperatorName,
		isnull(WOS.vchStatus, 'Unknown') as StatusName,
		isnull(WOS.vchColor, '') as Color
	from WorkOrders WO
	inner join WorkOrderStatus WOS
	on WO.StatusId = WOS.[Id]
	and WO.OrgId = @OrgId
	and WO.btIsActive = 1
	and datediff(minute, dateadd(m, datediff(m, '', @dtCurrentDate), ''), WO.dtScheduled) > 0 
	and datediff(minute, WO.dtScheduled, dateadd(m, 1, dateadd(m, datediff(m, '', @dtCurrentDate), ''))) > 0 
	left outer join Equipments E
	on E.[Id] = WO.EquipId
	and E.OrgId = Wo.OrgId
	left outer join Logins LO
	on WO.intOperatorId = LO.[Id]
	order by [Day] asc, WO.WorkOrderNumber asc







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

