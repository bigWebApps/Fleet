SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectGroupsListByNotUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectGroupsListByNotUser]
GO

CREATE procedure sp_SelectGroupsListByNotUser
		@OrgId int,
		@UserId int
as
	set nocount on
	select  distinct
		G.[Id], 
		G.vchDesc
	from Groups G
	where G.[Id] not in (
		select tG.[Id]
		from Groups tG
		inner join Logins_Groups LG
		on LG.UserId = @UserId
		and LG.OrgId = @OrgId
		and LG.GroupId = tG.[Id]
		and LG.OrgId = tG.OrgId
		)
	and G.OrgId = @OrgId
	order by G.vchDesc asc

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

