SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



ALTER  PROCEDURE sp_SelectInspectionsList
	(
		@OrgId int
	)
AS
	set nocount on

	select 0 as [Id], '' as vchName
	union
	select [Id], vchName 
	from Inspections
	where OrgId = @OrgId



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

