SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GetPassword]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GetPassword]
GO

create procedure sp_GetPassword
(
	@UserId int,
	@vchPass varchar(40)=null output,
	@Salt varchar(10)=null output
)
as
	set nocount on
	if exists(select 'true' from Logins where [Id] = @UserId)
	begin
		select	@vchPass = vchPass,
			@Salt = salt
		from 	Logins
		where 	[Id] = @UserId
		return 0
	end
	else
	begin
		return -1
	end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

