SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

alter procedure sp_SelectWorkOrderUnassigned
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
		case when isnull(LO.vchFirstName, '') = '' then 'Unassigned' else LO.vchLastName + ', ' + LO.vchFirstName end as OperatorName,
		LC.vchLastName + ', ' + LC.vchFirstName as UserCreated,
		isnull(WOS.vchStatus, 'Unknown') as StatusName,
		isnull(WOS.vchColor, '') as Color
	from WorkOrders WO
	inner join Equipments E
	on WO.OrgId = @OrgId
	and WO.btIsActive = 1
	and isnull(intTechId, 0) = 0
	and E.[Id] = WO.EquipId
	and E.OrgId = WO.OrgId
	inner join WorkOrderStatus WOS
	on WO.StatusId = WOS.[Id]
	and WO.OrgId = @OrgId
	inner join Logins LC
	on WO.intCreatedBy = LC.[Id]
	left outer join Logins LO
	on WO.intOperatorId = LO.[Id]
	order by LC.vchLastName asc, vchWorkOrderNumber asc


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

