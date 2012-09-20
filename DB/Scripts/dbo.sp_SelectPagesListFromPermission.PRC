SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectPagesListFromPermission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectPagesListFromPermission]
GO

CREATE   PROCEDURE sp_SelectPagesListFromPermission
		@PermId int
AS
	set nocount on
	select 	distinct 
		P.[Id],
		P.vchPageName
	from 	Pages P
	inner join Pages_Permissions PP
	on P.[Id] = PP.PageId
	and PP.PermissionID = @PermId
	select distinct 
		P.[Id],
		P.vchPageName
	from 	Pages P
	where P.[Id] not in(
		select PP.PageId
		from Pages_Permissions PP
		where PP.PermissionID = @PermId
		)
	order by P.vchPageName asc

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

