SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER PROCEDURE sp_SelectModelsList
	(
		@OrgId int,
		@ModelId int
	)
AS
	set nocount on

	select EM.[Id], EM.vchModelName 
	from EquipModels EM
	inner join EquipModelType EMT
	on EM.TypeId = EMT.[Id]
	and EMT.OrgId = @OrgId
	and EM.OrgId = @OrgId
	inner join EquipModels EM2
	on EM2.[TypeId] = EMT.[Id]
	and EM2.OrgId =  @OrgId
	and EM2.[Id] = @ModelId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

