SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER   procedure dbo.sp_SelectEquipListByOperator2
	(
		@OrgId int,
		@UserId int,
		@dtCurrentDate datetime
	)
as
	set nocount on

/*
The system displays the equipment table and an input box to enter a specific 
equipment number.  The equipment table should list all equipment where; 
a.	they are the operator, 
b.	they checked in the equipment and there are open work orders,  
c.	they checked in the equipment and the work order was closed 
on the same day.  
*/
	declare @ActiveEquips table (
		EquipId int,
		vchLink varchar(255)
		)

	-- where they checked in the equipment and there are open work orders
	insert into @ActiveEquips(EquipId, vchLink)
	select distinct WO.EquipId, 'ok_mainDetails.aspx?id=' + convert(varchar, WO.[Id])
	from WorkOrders WO
	inner join SignedDocuments SD
	on WO.StatusId in (1, 4, 5, 6) 
	and isnull(WO.OperatorStatusId, 0) = 1
	and WO.OrgId = @OrgId
	and WO.btIsActive = 1
	and SD.DocumentId = WO.[Id]
	and SD.DocumentTypeId = 1
	and SD.UserId = @UserId
	and SD.OrgId = WO.OrgId

	-- they checked in the equipment and the work order was closed on the same day
	insert into @ActiveEquips(EquipId, vchLink)
	select distinct WO.EquipId, 'ok_mainDetails.aspx?id=' + convert(varchar, WO.[Id])
	from WorkOrders WO
	inner join SignedDocuments SD
	on WO.StatusId = 2
	and WO.dtClosed between dateadd(d, -1, dateadd(d, datediff(d, '', @dtCurrentDate), '')) and dateadd(d, datediff(d, '', dateadd(d, 1, @dtCurrentDate)), '')
	and WO.OrgId = @OrgId
	and WO.btIsActive = 1
	and SD.DocumentId = WO.[Id]
	and SD.DocumentTypeId = 1
	and SD.UserId = @UserId
	and SD.OrgId = WO.OrgId


	-- where they are the operator but these equipment hasn't activity
	-- work orders
	insert into @ActiveEquips(EquipId, vchLink)
	select E.[Id], 'ok_selectEquipment.aspx?orderid=0&equipid=' + convert(varchar, E.[Id])
	from Equipments E 
	where E.EquipOperatorId = @UserId	
	and E.OrgId = @OrgId
	and E.[Id] not in (
		select WO.EquipId
		from WorkOrders WO
		where isnull(WO.OperatorStatusId, 0) <> 2
		and WO.OrgId = E.OrgId
		union all
		select EquipId 
		from @ActiveEquips
		)

	select 	AE.vchLink as vchLink,
		E.[Id],
		ISNULL(E.vchEquipId, '') as EquipId,
		ET.vchName as TypeName,
		ISNULL(EMa.vchMakeName, '') as MakeName, 
		ISNULL(EMo.vchModelName, '') as ModelName,
		LO.vchLastName + ', ' + LO.vchFirstName as OperatorName
	from Equipments E
	inner join @ActiveEquips AE
	on AE.EquipId = E.[Id]
	inner join EquipTypes ET
	on ET.OrgId = @OrgId
	and ET.[Id] = E.TypeId
	and ET.OrgId = E.OrgId
	left outer join EquipModels EMo
	on EMo.OrgId = @OrgId and EMo.[Id] = E.ModelId 
	left outer join EquipModelType EMT
	on EMT.OrgId = @OrgId and EMT.[Id] = EMo.TypeId
	left outer join EquipMakes EMa
	on EMa.OrgId = @OrgId and EMa.[Id] = EMT.MakeId
	left outer join Logins LO
	on LO.[Id] = E.EquipOperatorId
	order by ET.[Id] asc, E.vchEquipId asc



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

