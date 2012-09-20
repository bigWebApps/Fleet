SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE PROCEDURE sp_PagesPermissionDetail
	(
		@Action char(1),
		@PermId int,
		@PageId int
	)
AS
	set nocount on
	
	if @Action = 'D'
	begin
		if not exists(select 'true' from Pages_Permissions where PageId = @PageId and PermissionId = @PermId)
		begin
			return -1
		end
		else
		begin
			delete from Pages_Permissions
			where PermissionId = @PermId
			and PageId = @PageId
		end
	end
	if @Action = 'I'
	begin
		if exists(select 'true' from Pages_Permissions where PageId = @PageId and PermissionId = @PermId)
		begin
			return -1
		end
		else
		begin 
			insert into [Pages_Permissions]([PageId], [PermissionId])
			values(@PageId, @PermId)
			return 0
		end
	end
	return 0


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

