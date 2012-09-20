SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_SelectEquipTypeList
	(
		@OrgId int
	)
AS
	set nocount on

	select [Id], [vchName]
	from EquipTypes
	where OrgId = @OrgId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

