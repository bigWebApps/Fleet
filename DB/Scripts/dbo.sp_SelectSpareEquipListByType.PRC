SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectSpareEquipListByType]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectSpareEquipListByType]
GO


CREATE  procedure sp_SelectSpareEquipListByType
(
		@OrgId int,
		@EquipId int
)		
as
	set nocount on
	
	select 	E.[Id],
		isnull(E.vchEquipId, '') as EquipId,
		isnull(D.vchName, '') as DeptName,
		isnull(L.vchName, '') as LocName,
		isnull(EMa.vchMakeName, '') as MakeName, 
		isnull(EMo.vchModelName, '') as ModelName
	from Equipments E
	inner join Equipments E2
	on E2.[Id] = @EquipId
	and E2.OrgId = @OrgId
	and E2.TypeId = E.TypeId
	and E2.OrgId = E.OrgId
	and E.bitSpare = 1
	and isnull(E.TempOperatorId, 0) = 0
	left outer join EquipModels EMo
	on EMo.OrgId = @OrgId 
	and EMo.[Id] = E.ModelId 
	left outer join EquipModelType EMT
	on EMT.OrgId = @OrgId 
	and EMT.[Id] = EMo.TypeId
	left outer join EquipMakes EMa
	on EMa.OrgId = @OrgId 
	and EMa.[Id] = EMT.MakeId
	left outer join Departments D
	on D.OrgId = @OrgId 
	and D.[Id] = E.DeptId
	left outer join Locations L
	on L.OrgId = @OrgId 
	and L.[Id] = E.LocId
	order by E.vchEquipId asc


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

