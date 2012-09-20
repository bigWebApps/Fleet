SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectGroupsListByUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectGroupsListByUser]
GO

CREATE procedure sp_SelectGroupsListByUser
		@OrgId int,
		@UserId int
as
	set nocount on
	select 	G.[Id], 
		G.vchDesc
	from Groups G
	inner join Logins_Groups LG
	on LG.UserId = @UserId
	and LG.OrgId = @OrgId
	and LG.GroupId = G.[Id]
	and LG.OrgId = G.OrgId
	order by G.vchDesc asc

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

