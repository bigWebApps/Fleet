SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_SelectGroupsList
		@OrgId int
AS
	set nocount on

	select 	[Id], 
		vchDesc,
		CanDelete
	from 	Groups
	where 	OrgId = @OrgId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

