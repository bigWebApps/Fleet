SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectEquipList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectEquipList]
GO

CREATE    PROCEDURE sp_SelectEquipList
	(
		@OrgId int,
		@TypeId int
	)
AS
	set nocount on
	if @TypeId = 0
	begin
		select 	E.[Id],
			ISNULL(E.vchEquipId, '') as EquipId,
			ET.vchName as TypeName,
			ISNULL(EMa.vchMakeName, '') as MakeName, 
			ISNULL(EMo.vchModelName, '') as ModelName,
			ISNULL(CAST(E.intYear as varchar(25)), '') as [Year], 
			ISNULL(E.vchVinSerial, '') as VinSerial,
			ISNULL(E.vchFuelCode, '') as FuelCode,
			ISNULL(D.vchName, '') as DeptName,
			ISNULL(L.vchName, '') as LocName
		from Equipments E
		inner join EquipTypes ET
		on ET.OrgId = E.OrgId and ET.[Id] = E.TypeId
		and E.OrgId = @OrgId
		left outer join EquipModels EMo
		on EMo.OrgId = @OrgId and EMo.[Id] = E.ModelId 
		left outer join EquipModelType EMT
		on EMT.OrgId = @OrgId and EMT.[Id] = EMo.TypeId
		left outer join EquipMakes EMa
		on EMa.OrgId = @OrgId and EMa.[Id] = EMT.MakeId
		left outer join Departments D
		on D.OrgId = @OrgId and D.[Id] = E.DeptId
		left outer join Locations L
		on L.OrgId = @OrgId and L.[Id] = E.LocId
		order by ET.[Id] asc, E.vchEquipId asc
	end
	else
	begin
		select 	E.[Id],
			ISNULL(E.vchEquipId, '') as EquipId,
			ET.vchName as TypeName,
			ISNULL(EMa.vchMakeName, '') as MakeName, 
			ISNULL(EMo.vchModelName, '') as ModelName,
			ISNULL(CAST(E.intYear as varchar(25)), '') as [Year], 
			ISNULL(E.vchVinSerial, '') as VinSerial,
			ISNULL(E.vchFuelCode, '') as FuelCode,
			ISNULL(D.vchName, '') as DeptName,
			ISNULL(L.vchName, '') as LocName
		from Equipments E
		inner join EquipTypes ET
		on ET.OrgId = E.OrgId and ET.[Id] = E.TypeId
		and E.TypeId = @TypeId
		and E.OrgId = @OrgId
		left outer join EquipModels EMo
		on EMo.OrgId = @OrgId and EMo.[Id] = E.ModelId 
		left outer join EquipModelType EMT
		on EMT.OrgId = @OrgId and EMT.[Id] = EMo.TypeId
		left outer join EquipMakes EMa
		on EMa.OrgId = @OrgId and EMa.[Id] = EMT.MakeId
		left outer join Departments D
		on D.OrgId = @OrgId and D.[Id] = E.DeptId
		left outer join Locations L
		on L.OrgId = @OrgId and L.[Id] = E.LocId
		order by E.vchEquipId asc
	end	
	RETURN 

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

