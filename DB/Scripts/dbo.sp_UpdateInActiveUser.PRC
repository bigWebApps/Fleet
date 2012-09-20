SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_UpdateInActiveUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_UpdateInActiveUser]
GO



create procedure dbo.sp_UpdateInActiveUser
	(
		@UserId int,
		@btActive bit
	)
AS
	set nocount on
	
	if not exists(select 'true' from Logins where [Id] = @UserId)
	begin
		return -1
	end
	else
	begin
		update Logins
		set btActive = @btActive
		where [Id] = @UserId
	
		return 0
	end



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

