SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Authenticate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Authenticate]
GO


----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 11/30/2004 
-- Description: Description: The procedure return the Id, password hash 
-- and salt of user. If the user not found then return -1. 
---------------------------------------------------------------------------
CREATE   procedure dbo.sp_Authenticate
	(
		@vchEmail varchar(75),
		@vchPass varchar(40)=null output,
		@Salt varchar(10)=null output,
		@UserId int=null output,
		@btActive bit=null output
	)
as
	set nocount on
	
	if exists(select 'true' from Logins where vchEmail=@vchEmail)
	begin
		select 	@vchPass = vchPass, 
			@Salt = salt,
			@UserId = [Id],
			@btActive = btActive
		from 	Logins 
		where 	vchEmail=@vchEmail
		return 0
	end
	else
		return -1


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

