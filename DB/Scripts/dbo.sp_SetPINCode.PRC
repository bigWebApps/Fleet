SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SetPINCode]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SetPINCode]
GO


create procedure sp_SetPINCode
(
	@UserId int,
	@chInitials char(3),
	@vchPIN varchar(10)
)
as
	set nocount on
	
	if exists(select 'true' from Logins where [Id] = @UserId)
	begin
		update 	Logins
		set 	PIN = @vchPIN
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

