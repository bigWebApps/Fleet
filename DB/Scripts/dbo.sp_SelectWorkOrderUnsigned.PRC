SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectWorkOrderUnsigned]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectWorkOrderUnsigned]
GO


CREATE    procedure sp_SelectWorkOrderUnsigned
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
		WO.dtScheduled as CreatedDate,
		case when isnull(LT.vchFirstName, '') = '' then '' else LT.vchLastName + ', ' + LT.vchFirstName end as TechName,
		case when isnull(LO.vchFirstName, '') = '' then '' else LO.vchLastName + ', ' + LO.vchFirstName end as OperatorName,
		LC.vchLastName + ', ' + LC.vchFirstName as UserCreated
	from WorkOrders WO
	inner join Equipments E
	on WO.OrgId = @OrgId
	and WO.btIsActive = 0
	and E.[Id] = WO.EquipId
	and E.OrgId = WO.OrgId
	inner join Logins LC
	on WO.intCreatedBy = LC.[Id]
	left outer join Logins LT
	on WO.intTechid = LT.[Id]
	left outer join Logins LO
	on WO.intOperatorId = LO.[Id]
	order by LC.vchLastName asc, vchWorkOrderNumber asc


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

