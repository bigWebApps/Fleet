SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectNotesList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectNotesList]
GO

CREATE procedure sp_SelectNotesList
	(
		@OrgId int,
		@ItemId int,
		@TypeId int
	)
as
	set nocount on
	select 	N.[Id],
		N.vchDesc as Note,
		L.vchLastName + ', ' + L.vchFirstName as UserName,
		N.dtCreated as CreatedDate
	from 	Notes N
	inner join Logins L
	on 	N.ItemId = @ItemId
	and 	N.TypeId = @TypeId
	and 	N.OrgId = @OrgId
	and 	L.[Id] = N.UserId
	order by N.dtCreated desc

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

