SET QUOTED_IDENTIFIER ON ਍ഀ
GO਍ഀ
SET ANSI_NULLS ON ਍ഀ
GO਍ഀ
਍ഀ
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SetPassword]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)਍ഀ
drop procedure [dbo].[sp_SetPassword]਍ഀ
GO਍ഀ
਍ഀ
CREATE  procedure sp_SetPassword਍ഀ
(਍ഀ
	@UserId int,਍ഀ
	@vchPass varchar(40),਍ഀ
	@Salt varchar(10)਍ഀ
)਍ഀ
as਍ഀ
	set nocount on਍ഀ
	if exists(select 'true' from Logins where [Id] = @UserId)਍ഀ
	begin਍ഀ
		update 	Logins਍ഀ
		set 	vchPass = @vchPass,਍ഀ
			salt = @Salt਍ഀ
		where 	[Id] = @UserId਍ഀ
		return 0਍ഀ
	end਍ഀ
	else਍ഀ
	begin਍ഀ
		return -1਍ഀ
	end਍ഀ
਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER OFF ਍ഀ
GO਍ഀ
SET ANSI_NULLS ON ਍ഀ
GO਍ഀ
਍ഀ
