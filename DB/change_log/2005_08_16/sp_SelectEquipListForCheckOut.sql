SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER procedure sp_SelectEquipListForCheckOut
	(
		@OrgId int,
		@UserId int
	)
as
	set nocount on
	if exists(select 'true' 
		from WorkOrders WO
		inner join Equipments E
		on isnull(E.EquipOperatorId, 0) = @UserId
		and WO.StatusId = 2
		and WO.OperatorStatusId = 1
		and WO.EquipId = E.[Id]
		and WO.OrgId = @OrgId
		and WO.OrgId = E.OrgId
		)
	begin
		select 	WO.[Id],
			ISNULL(E.vchEquipId, '') as EquipId,
			ET.vchName as TypeName,
			ISNULL(EMa.vchMakeName, '') as MakeName, 
			ISNULL(EMo.vchModelName, '') as ModelName,
			E.intYear as [Year],
			L.vchLastName + ', ' + L.vchFirstName as OperatorName
		from WorkOrders WO
		inner join Equipments E
		on isnull(E.EquipOperatorId, 0) = @UserId
		and WO.EquipId = E.[Id]
		and WO.StatusId = 2
		and WO.OperatorStatusId = 1
		and WO.OrgId = @OrgId
		and WO.OrgId = E.OrgId
		inner join EquipTypes ET
		on E.OrgId = WO.OrgId 
		and ET.[Id] = E.TypeId
		and ET.OrgId = E.OrgId
		inner join Logins L
		on L.[Id] = isnull(E.EquipOperatorId, 0)
		left outer join EquipModels EMo
		on EMo.OrgId = E.OrgId and EMo.[Id] = E.ModelId 
		left outer join EquipModelType EMT
		on EMT.OrgId = E.OrgId and EMT.[Id] = EMo.TypeId
		left outer join EquipMakes EMa
		on EMa.OrgId = E.OrgId and EMa.[Id] = EMT.MakeId
		order by ET.[Id] asc, E.vchEquipId asc
	end
	else
	begin
		select 	WO.[Id],
			ISNULL(E.vchEquipId, '') as EquipId,
			ET.vchName as TypeName,
			ISNULL(EMa.vchMakeName, '') as MakeName, 
			ISNULL(EMo.vchModelName, '') as ModelName,
			E.intYear as [Year],
			L.vchLastName + ', ' + L.vchFirstName as OperatorName
		from WorkOrders WO
		inner join Equipments E
		on WO.StatusId = 2
		and WO.OperatorStatusId = 1
		and WO.EquipId = E.[Id]
		and WO.OrgId = @OrgId
		and WO.OrgId = E.OrgId
		inner join EquipTypes ET
		on E.OrgId = WO.OrgId 
		and ET.[Id] = E.TypeId
		and ET.OrgId = E.OrgId
		inner join Logins L
		on L.[Id] = isnull(E.EquipOperatorId, 0)
		left outer join EquipModels EMo
		on EMo.OrgId = E.OrgId and EMo.[Id] = E.ModelId 
		left outer join EquipModelType EMT
		on EMT.OrgId = E.OrgId and EMT.[Id] = EMo.TypeId
		left outer join EquipMakes EMa
		on EMa.OrgId = E.OrgId and EMa.[Id] = EMT.MakeId
		order by ET.[Id] asc, E.vchEquipId asc
	end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

