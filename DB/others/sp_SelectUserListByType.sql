SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

alter PROCEDURE sp_SelectUserListByType
	(
		@OrgId int,
		@UserTypeId int
	)
AS
	set nocount on

	select 0 as [Id], 'Unassign' as vchName
	union all
	select L.[Id] as [Id], ISNULL(L.vchLastName, '') + ', ' + ISNULL(L.vchFirstName, '') as vchName
	from Logins L
	inner join Logins_Orgs LO
	on L.[Id] = LO.UserId
	and LO.OrgId = @OrgId
	inner join Logins_UserTypes LUT
	on L.[Id] = LUT.UserId
	and LUT.UserTypeId = @UserTypeId
	order by L.[Id] asc


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

