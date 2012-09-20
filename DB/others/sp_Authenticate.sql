SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER PROCEDURE sp_Authenticate
	(
		@vchEmail varchar(75),
		@vchPass varchar(50),
		@OrgId int=null OUTPUT,
		@vchFirstName varchar(50)=null OUTPUT,
		@vchLastName varchar(50)=null OUTPUT,
		@UserId int=null OUTPUT
	)
AS
	/*RETURNS
	-1 = authentication failed
	*/
	set nocount on
	
	if exists(select 'true' from Logins where vchEmail=@vchEmail and vchPass=@vchPass)
	begin
		select 	@vchFirstName = vchFirstName, 
			@vchLastName = vchLastName, 
			@UserId = [Id] 
		from 	Logins 
		where 	vchEmail=@vchEmail 
		and 	vchPass=@vchPass
	
		if (select count([Id]) from Logins_Orgs where UserId = @UserId) > 1
		begin
			return 1
		end
		else
		begin
			select @OrgId = OrgId 
			from Logins_Orgs 
			where UserId = @UserId

			return 0
		end
	end
	else
		return -1

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

