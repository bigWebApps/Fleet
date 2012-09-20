SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create function f_IsTechnician
	(@UserId int) returns bit
as
begin
	declare @btResult bit

	if exists(select 'true' from Logins_UserTypes where UserId = @UserId and UserTypeId = 1)
	begin
		select @btResult = 1
	end
	else
	begin
		select @btResult = 0
	end

	return @btResult

end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
