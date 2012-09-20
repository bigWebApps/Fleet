SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectWorkOrderListForTime]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectWorkOrderListForTime]
GO



CREATE procedure dbo.sp_SelectWorkOrderListForTime
(
		@OrgId int,
		@dtCurrentDay datetime
)
as
	set nocount on
--	select *
--	from (	
	select 	[Order].[Id],
		convert(varchar, year([Order].dtCreated)) + '-' + 
		convert(varchar, month([Order].dtCreated)) + '-' + 
		convert(varchar, day([Order].dtCreated)) + '-' + 
		convert(varchar, [Order].WorkOrderNumber) as [Number],
		isnull(E.vchEquipId, '') as Equipment,
		case when isnull(LO.vchFirstName, '') = '' then '' else LO.vchLastName + ', ' + LO.vchFirstName end as Operator,
		convert(varchar, datepart(hh, [Order].dtScheduled)) as [Time],
		isnull(WOS.vchStatus, 'Unknown') as Status,
		isnull(WOS.vchColor, '') as Color,
		isnull(WOOS.vchStatus, '') as OperatorStatusName,
		isnull(WOOS.vchColor, 'lightgrey') as OperatorColor
	from WorkOrders [Order]
	inner join WorkOrderStatus WOS
	on [Order].StatusId = WOS.[Id]
	and [Order].OrgId = @OrgId
	and [Order].btIsActive = 1
	and datediff(minute, [Order].dtScheduled, dateadd(d, 1, dateadd(d, datediff(d, '', @dtCurrentDay), ''))) > 0 
	and datediff(minute, dateadd(d, datediff(d, '', @dtCurrentDay), ''), [Order].dtScheduled) >= 0 
	and [Order].StatusId = 3
	left outer join WorkOrderOperatorStatus WOOS
	on [Order].OperatorStatusId = WOOS.[Id]
	left outer join Equipments E
	on E.[Id] = [Order].EquipId
	and E.OrgId = [Order].OrgId
	left outer join Logins LT
	on [Order].intTechid = LT.[Id]
	left outer join Logins LO
	on [Order].intOperatorId = LO.[Id]
	union all
	select 	[Order].[Id],
		convert(varchar, year([Order].dtCreated)) + '-' + 
		convert(varchar, month([Order].dtCreated)) + '-' + 
		convert(varchar, day([Order].dtCreated)) + '-' + 
		convert(varchar, [Order].WorkOrderNumber) as [Number],
		isnull(E.vchEquipId, '') as Equipment,
		case when isnull(LO.vchFirstName, '') = '' then 'blank' else LO.vchLastName + ', ' + LO.vchFirstName end as Operator,
		isnull(WOS.vchStatus, 'Unknown') as Status,
		convert(varchar, datepart(hh, [Order].dtOpened)) as [Time],
		isnull(WOS.vchColor, '') as Color,
		isnull(WOOS.vchStatus, '') as OperatorStatusName,
		isnull(WOOS.vchColor, 'lightgrey') as OperatorColor
	from WorkOrders [Order]
	inner join WorkOrderStatus WOS
	on [Order].StatusId = WOS.[Id]
	and [Order].OrgId = @OrgId
	and [Order].btIsActive = 1
	and datediff(minute, [Order].dtOpened, dateadd(d, 1, dateadd(d, datediff(d, '', @dtCurrentDay), ''))) > 0 
	and datediff(minute, dateadd(d, datediff(d, '', @dtCurrentDay), ''), [Order].dtOpened) >= 0 
	and [Order].StatusId in (1, 4, 5, 6)
	left outer join WorkOrderOperatorStatus WOOS
	on [Order].OperatorStatusId = WOOS.[Id]
	left outer join Equipments E
	on E.[Id] = [Order].EquipId
	and E.OrgId = [Order].OrgId
	left outer join Logins LT
	on [Order].intTechid = LT.[Id]
	left outer join Logins LO
	on [Order].intOperatorId = LO.[Id]
--	) as WorkOrders
	for xml auto, elements



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

