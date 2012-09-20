SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_LoginsGroupsDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_LoginsGroupsDetail]
GO

CREATE procedure sp_LoginsGroupsDetail
	(
		@Action char(1),
		@OrgId int,
		@UserId int,
		@GroupId int
	)
as
	set nocount on
	
	if @Action = 'D'
	begin
		if not exists(select 'true' from Logins_Groups where GroupId = @GroupId and UserId = @UserId and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			delete from Logins_Groups 
			where GroupId = @GroupId 
			and UserId = @UserId 
			and OrgId = @OrgId
		end
	end
	if @Action = 'I'
	begin
		if exists(select 'true' from Logins_Groups where GroupId = @GroupId and UserId = @UserId and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin 
			if not exists(select 'true' from Logins where [Id] = @UserId)
			begin
				return -1
			end
			else
			begin
				insert into [Logins_Groups]([OrgId], [UserId], [GroupId])
				values(@OrgId, @UserId, @GroupId)
	
				return 0
			end
		end
	end
	return 0

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

