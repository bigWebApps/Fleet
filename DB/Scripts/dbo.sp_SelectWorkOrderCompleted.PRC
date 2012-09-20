SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectWorkOrderCompleted]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectWorkOrderCompleted]
GO


CREATE  procedure sp_SelectWorkOrderCompleted
(
		@OrgId int,
		@vchEquipId varchar(50),
		@OperatorId int
)
AS
	set nocount on
	
	if @OperatorId = 0
	begin
		select 	WO.[Id],
			isnull(E.vchEquipId, '') as vchEquipId,
			convert(varchar, year(WO.dtCreated)) + '-' + 
			convert(varchar, month(WO.dtCreated)) + '-' + 
			convert(varchar, day(WO.dtCreated)) + '-' + 
			convert(varchar, WO.WorkOrderNumber) as vchWorkOrderNumber,
			case when isnull(LT.vchFirstName, '') = '' then '' else LT.vchLastName + ', ' + LT.vchFirstName end as TechName,
			case when isnull(LO.vchFirstName, '') = '' then '' else LO.vchLastName + ', ' + LO.vchFirstName end as OperatorName,
			WO.dtCompleted as CompletedDate
		from WorkOrders WO
		inner join Equipments E
		on WO.OrgId = @OrgId
		and WO.btIsActive = 1
		and WO.StatusId = 2 -- select the completed orders
		and WO.OperatorStatusId = 1 -- and checked-in equipment
		and E.[Id] = WO.EquipId
		and E.OrgId = WO.OrgId
		and vchEquipId like '%' + @vchEquipId + '%'
		left outer join Logins LT
		on WO.intTechid = LT.[Id]
		left outer join Logins LO
		on WO.intOperatorId = LO.[Id]
		order by vchWorkOrderNumber asc
	end
	else
	begin
		select 	WO.[Id],
			isnull(E.vchEquipId, '') as vchEquipId,
			convert(varchar, year(WO.dtCreated)) + '-' + 
			convert(varchar, month(WO.dtCreated)) + '-' + 
			convert(varchar, day(WO.dtCreated)) + '-' + 
			convert(varchar, WO.WorkOrderNumber) as vchWorkOrderNumber,
			case when isnull(LT.vchFirstName, '') = '' then 'blank' else LT.vchLastName + ', ' + LT.vchFirstName end as TechName,
			case when isnull(LO.vchFirstName, '') = '' then 'blank' else LO.vchLastName + ', ' + LO.vchFirstName end as OperatorName,
			WO.dtCompleted as CompletedDate
		from WorkOrders WO
		inner join Equipments E
		on WO.OrgId = @OrgId
		and WO.btIsActive = 1
		and WO.StatusId = 2 -- select the completed orders
		and WO.OperatorStatusId = 1 -- and checked-in equipment
		and E.[Id] = WO.EquipId
		and E.OrgId = WO.OrgId
		and vchEquipId like '%' + @vchEquipId + '%'
		and WO.[Id] in (
			select DocumentId 
			from SignedDocuments 
			where DocumentTypeId = 1 
			and UserId = @OperatorId
			and OrgId = @OrgId
			)
		left outer join Logins LT
		on WO.intTechid = LT.[Id]
		left outer join Logins LO
		on WO.intOperatorId = LO.[Id]
		order by vchWorkOrderNumber asc
	end



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

