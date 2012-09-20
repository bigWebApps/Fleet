SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectRepairItemsAndCats]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectRepairItemsAndCats]
GO

CREATE   procedure sp_SelectRepairItemsAndCats
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

