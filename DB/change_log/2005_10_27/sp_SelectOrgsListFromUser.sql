SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER    PROCEDURE sp_SelectOrgsListFromUser
(
		@UserId int
)
AS
	set nocount on
	
	select 	O.[Id], 
		O.[intBWAId],
		O.[vchName],
		O.vchLogo
	from Orgs O
	inner join Logins_Orgs LO
	on O.[Id] = LO.OrgId
	and LO.UserId = @UserId
	and O.btActive = 1

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

