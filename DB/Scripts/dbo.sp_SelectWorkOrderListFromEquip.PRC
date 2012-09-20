SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectWorkOrderListFromEquip]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectWorkOrderListFromEquip]
GO

CREATE   procedure sp_SelectWorkOrderListFromEquip
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
		case when isnull(LT.vchFirstName, '') = '' then '' else LT.vchLastName + ', ' + LT.vchFirstName end as TechName,
		case when isnull(LO.vchFirstName, '') = '' then '' else LO.vchLastName + ', ' + LO.vchFirstName end as OperatorName,
		case when isnull(WO.StatusId, 0) = 3 then isnull(WOS.vchStatus, '') + ' (' + convert(varchar, WO.dtScheduled, 101) + ')' else isnull(WOS.vchStatus, 'Unknown') end as StatusName,
		isnull(WOS.vchColor, '') as StatusColor,
		isnull(WOOS.vchStatus, '') as OperatorStatusName,
		isnull(WOOS.vchColor, 'lightgrey') as OperatorColor,
		case when isnull(WO.dtScheduled, 0) = 0 then 'didn''t begin' else convert(varchar, WO.dtScheduled) end as BeginWork 
	from WorkOrders WO
	inner join WorkOrderStatus WOS
	on WO.StatusId <> 2
	and WO.StatusId = WOS.[Id]
	and WO.EquipId = @EquipId
	and WO.OrgId = @OrgId
	and WO.btIsActive = 1
	left outer join WorkOrderOperatorStatus WOOS
	on WO.OperatorStatusId = WOOS.[Id]
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

