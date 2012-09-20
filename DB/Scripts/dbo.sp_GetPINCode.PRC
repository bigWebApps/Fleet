SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GetPINCode]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GetPINCode]
GO


create procedure sp_GetPINCode
(
	@UserId int,
	@chInitials char(3)=null output,
	@vchPIN varchar(10)=null output
)
as
	set nocount on

	if exists(select 'true' from Logins where [Id] = @UserId)
	begin
		select	@chInitials = Initials,
			@vchPIN = PIN
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

