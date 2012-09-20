SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sp_GroupsPermissionsDetail
	(
		@Action char(1),
		@OrgId int,
		@PermId int,
		@GroupId int
	)
AS
	set nocount on
	
	if @Action = 'D'
	begin
		if not exists(select 'true' from Groups_Permissions where GroupId = @GroupId and PermissionId = @PermId and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			delete from Groups_Permissions
			where GroupId = @GroupId 
			and PermissionId = @PermId 
			and OrgId = @OrgId
		end
	end
	if @Action = 'I'
	begin
		if exists(select 'true' from Groups_Permissions where GroupId = @GroupId and PermissionId = @PermId and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin 
			insert into [Groups_Permissions]([OrgId], [GroupId], [PermissionId])
			values(@OrgId, @GroupId, @PermId)

			return 0
		end
	end
	return 0



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

