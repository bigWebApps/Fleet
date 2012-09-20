SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectActivityWorkOrderList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectActivityWorkOrderList]
GO




CREATE  procedure dbo.sp_SelectActivityWorkOrderList
		@OrgId int,
		@dtCurrentDate datetime
as
	set nocount on
	-- CheckIn if work order status is scheduled and operator status is null
	-- CheckOut if work order status is closed and operator status is checked-in
	-- CheckOutSpare if work order spare is null and operator status is checked-in and work order status is not closed
	-- elsewise - Operator Visible = False
	select 	WO.[Id],
		WO.EquipId as EquipId,
		isnull(E.vchEquipId, '') as vchEquipId,
		case when isnull(LT.vchFirstName, '') = '' then '' else LT.vchLastName + ', ' + LT.vchFirstName end as TechName,
		case when isnull(LO.vchFirstName, '') = '' then '' else LO.vchLastName + ', ' + LO.vchFirstName end as OperatorName,
		isnull(WOS.vchStatus, '') as StatusName,
		isnull(WOS.vchColor, '#E0E0E0') as StatusColor,
		isnull(WOOS.vchStatus, '') as OperatorStatusName,
		isnull(WOOS.vchColor, '') as OperatorColor
	from WorkOrders WO
	inner join WorkOrderStatus WOS
	on WO.StatusId = WOS.[Id]
	and WO.OrgId = @OrgId
	and WO.btIsActive = 1
	left outer join WorkOrderOperatorStatus WOOS
	on WO.OperatorStatusId = WOOS.[Id]
	left outer join Equipments E
	on E.[Id] = WO.EquipId
	and E.OrgId = WO.OrgId
	left outer join Logins LT
	on WO.intTechid = LT.[Id]
	left outer join Logins LO
	on WO.intOperatorId = LO.[Id]
	where (datediff(minute, dateadd(d, -1, dateadd(d, datediff(d, '', @dtCurrentDate), '')), WO.dtDeparture) > 0 
	and isnull(WO.OperatorStatusId, 0) = 2)
	or (datediff(minute, WO.dtScheduled, dateadd(d, 2, dateadd(d, datediff(d, '', @dtCurrentDate), ''))) > 0 
	and isnull(WO.OperatorStatusId, 0) <> 2)
	order by LO.vchLastName asc, LO.vchFirstName asc, WO.StatusId asc, WO.dtScheduled asc



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

