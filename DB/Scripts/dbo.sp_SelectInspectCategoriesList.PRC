SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectInspectCategoriesList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectInspectCategoriesList]
GO


create procedure dbo.sp_SelectInspectCategoriesList
	(
		@OrgId int,
		@InspectId int
	)
as
	set nocount on

	select [Id], vchName
	from InspectCats
	where InspectId = @InspectId
	and OrgId = @Orgid
	order by tintOrder asc


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

