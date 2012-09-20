SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sp_SelectPermissionsListFromGroup
(
	@OrgId int,
	@GroupId int
)
AS
	set nocount on

	select P.[Id], P.vchName, P.chCode
	from [Permissions] P
	inner join Groups_Permissions GP
	on P.[Id] = GP.PermissionId
	and GP.GroupId = @GroupId

	select P.[Id], P.vchName, P.chCode
	from [Permissions] P
	where P.[Id] not in (
		select GP.PermissionId
		from Groups_Permissions GP
		where GP.GroupId = @GroupId
		and GP.OrgId = @OrgId
		)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

