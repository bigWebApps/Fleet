SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectOrgsListFromUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectOrgsListFromUser]
GO

CREATE   PROCEDURE sp_SelectOrgsListFromUser
(
		@UserId int
)
AS
	set nocount on
	
	select 	O.[Id], 
		O.[intBWAId],
		O.[vchName]
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

