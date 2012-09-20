SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectWorkOrderUnassigned]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectWorkOrderUnassigned]
GO

CREATE  procedure sp_SelectWorkOrderUnassigned
(
		@OrgId int
)
AS
	set nocount on
	
	select 	WO.[Id],
		isnull(E.vchEquipId, '') as vchEquipId,
		convert(varchar, year(WO.dtCreated)) + '-' + 
		convert(varchar, month(WO.dtCreated)) + '-' + 
		convert(varchar, day(WO.dtCreated)) + '-' + 
		convert(varchar, WO.WorkOrderNumber) as vchWorkOrderNumber,
		case when isnull(LO.vchFirstName, '') = '' then '' else LO.vchLastName + ', ' + LO.vchFirstName end as OperatorName,
		LC.vchLastName + ', ' + LC.vchFirstName as UserCreated,
		WO.dtScheduled as ScheduledDate,
		isnull(WOOS.vchStatus, '') as OperatorStatusName,
		isnull(WOOS.vchColor, 'lightgrey') as OperatorColor
	from WorkOrders WO
	inner join Equipments E
	on WO.OrgId = @OrgId
	and WO.btIsActive = 1
	and WO.StatusId = 3
	and E.[Id] = WO.EquipId
	and E.OrgId = WO.OrgId
	inner join WorkOrderStatus WOS
	on WO.StatusId = WOS.[Id]
	and WO.OrgId = @OrgId
	inner join Logins LC
	on WO.intCreatedBy = LC.[Id]
	left outer join WorkOrderOperatorStatus WOOS
	on WO.OperatorStatusId = WOOS.[Id]
	left outer join Logins LO
	on WO.intOperatorId = LO.[Id]
	order by WO.dtScheduled asc

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

