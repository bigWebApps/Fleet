SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_SelectUserGroups
	(
		@OrgId int,
		@UserId int
	)
AS
	select G.vchDesc 
	from Groups G 
	inner join Logins_Groups LG
	on G.[Id] = LG.GroupId
	and G.OrgId = LG.OrgId
	where LG.UserId = @UserId
	and LG.OrgId = @OrgId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

