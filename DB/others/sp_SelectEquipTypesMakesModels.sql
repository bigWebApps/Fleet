
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER  PROCEDURE sp_SelectEquipTypesMakesModels
	(
		@OrgId int
	)
AS
	SELECT 	[id], 
		vchName 
	FROM EquipTypes -- Type
	WHERE OrgId=@OrgId 
	ORDER BY vchName
	
	select EM.[id], 
		EM.vchMakeName, 
		MIN(EMT.intTypeId) as TypeId --it is incorrectly, for correctly need remade of the UI code 
	from EquipMakes EM	-- Type1
	inner join EquipModelType EMT
	on EM.[Id] = EMT.MakeID 
	and EMT.OrgId=@OrgId  
	and EMT.btIsComponent = 0 
	and EM.OrgId=@OrgId 
	group by EM.[id], EM.vchMakeName
	order by EM.vchMakeName
	
	select 	EM.[id], 
		EM.vchModelName, 
		EMT.MakeId 
	from EquipModels EM -- Type2
	inner join EquipModelType EMT
	on EMT.OrgId=@OrgId 
	and EMT.btIsComponent = 0
	and EMT.[Id] = EM.TypeId
	and EM.OrgId=@OrgId 
	order by EM.vchModelName

	SELECT 	[id], 
		vchName 
	FROM Departments 
	WHERE OrgId=@OrgId 
	ORDER BY vchName
	
	SELECT 	[id], 
		vchName 
	FROM Locations 
	WHERE OrgId=@OrgId 
	ORDER BY vchName

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

