SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
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

