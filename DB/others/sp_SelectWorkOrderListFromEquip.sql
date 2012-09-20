SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER  procedure sp_SelectWorkOrderListFromEquip
(
		@OrgId int,
		@EquipId int
)
as
	set nocount on
	
	select 	WO.[Id],
		WO.EquipId,
		convert(varchar, year(WO.dtCreated)) + '-' + 
		convert(varchar, month(WO.dtCreated)) + '-' + 
		convert(varchar, day(WO.dtCreated)) + '-' + 
		convert(varchar, WO.WorkOrderNumber) as vchWorkOrderNumber,
		case when isnull(LT.vchFirstName, '') = '' then 'Unassigned' else LT.vchLastName + ', ' + LT.vchFirstName end as TechName,
		case when isnull(LO.vchFirstName, '') = '' then 'Unassigned' else LO.vchLastName + ', ' + LO.vchFirstName end as OperatorName,
		case when isnull(WO.StatusId, 0) = 3 then isnull(WOS.vchStatus, '') + ' (' + convert(varchar, WO.dtScheduled, 101) + ')' else isnull(WOS.vchStatus, 'Unknown') end as StatusName,
		isnull(WOS.vchColor, '') as StatusColor,
		case when isnull(WO.dtScheduled, 0) = 0 then 'didn''t begin' else convert(varchar, WO.dtScheduled) end as BeginWork 
	from WorkOrders WO
	inner join WorkOrderStatus WOS
	on WO.StatusId = WOS.[Id]
	and WO.EquipId = @EquipId
	and WO.OrgId = @OrgId
	and WO.btIsActive = 1
	left outer join Logins LT
	on WO.intTechid = LT.[Id]
	left outer join Logins LO
	on WO.intOperatorId = LO.[Id]
	order by WO.dtCreated desc, WO.WorkOrderNumber desc




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

