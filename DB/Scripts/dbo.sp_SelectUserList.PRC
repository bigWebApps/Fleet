SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectUserList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectUserList]
GO

CREATE  PROCEDURE sp_SelectUserList
	(
		@OrgId int
	)
AS
	set nocount on
	select L.[Id] as [Id], ISNULL(L.vchLastName, '') + ', ' + ISNULL(L.vchFirstName, '') as vchName
	from Logins L
	inner join Logins_Orgs LO
	on L.[Id] = LO.UserId
	and LO.OrgId = @OrgId
	order by L.vchLastName asc

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

