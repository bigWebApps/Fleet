SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER  PROCEDURE sp_SelectModelMakesList
	(
		@OrgId int,
		@btIsComponent bit,
		@intTypeId int
	)
AS
	set nocount on


	select distinct EM.[Id], EM.vchMakeName
	from EquipMakes EM
	inner join EquipModelType EMT
	on EM.[Id] = EMT.[MakeId]
	and EM.OrgId = EMT.OrgId
	and EMT.btIsComponent = @btIsComponent
	and EMT.intTypeId = @intTypeId
	and EMT.OrgId = @OrgId


	select distinct EM.[Id], EM.vchModelName, EMT.MakeId
	from EquipModels EM
	inner join EquipModelType EMT
	on EM.TypeId = EMT.[Id]
	and EMT.OrgId = @OrgId
	and EM.OrgId = @OrgId
	inner join EquipModels EM2
	on EM2.[TypeId] = EMT.[Id]
	where EMT.btIsComponent = @btIsComponent
	and EMT.intTypeId = @intTypeId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

