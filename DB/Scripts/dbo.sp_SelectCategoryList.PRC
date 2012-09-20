SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectCategoryList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectCategoryList]
GO

CREATE PROCEDURE sp_SelectCategoryList
	(
		@OrgId int
	)
AS
	set nocount on
	select [Id], vchName
	from RepairCats
	where OrgId = @OrgId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

