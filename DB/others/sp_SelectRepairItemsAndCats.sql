SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER  procedure sp_SelectRepairItemsAndCats
	@OrgId int
AS
	set nocount on

	select 	0 as [Id],
		'' as vchName
	union all
	select 	[Id],
		vchName
	from RepairCats
	where OrgId = @OrgId

	select 	0 as [Id],
		'' as vchDesc,
		0 as CatId
	union all
	select 	[Id],
		vchDesc,
		CatId
	from RepairItems
	where OrgId = @OrgId


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

