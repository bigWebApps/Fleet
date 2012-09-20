SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER  PROCEDURE sp_SelectUserList
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

