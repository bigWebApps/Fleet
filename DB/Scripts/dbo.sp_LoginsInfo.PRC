SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_LoginsInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_LoginsInfo]
GO

----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 05/17/2005
-- Description: Description: The procedure get user information for his 
-- login to system - ID, First Name, Last Name. 
-- If user be in one organization only then procedure return an Organization 
-- ID or else return 1. 
---------------------------------------------------------------------------
CREATE  procedure sp_LoginsInfo
	(
		@Id int,
		@OrgId int=null OUTPUT,
		@vchLogo varchar(255)=null output,
		@vchFirstName varchar(50)=null OUTPUT,
		@vchLastName varchar(50)=null OUTPUT
	)
as
	/*RETURNS
	-1 = authentication failed
	*/
	set nocount on
	
	if exists(select 'true' from Logins where [Id] = @Id)
	begin
		select 	@vchFirstName = vchFirstName, 
			@vchLastName = vchLastName
		from 	Logins 
		where 	[Id] = @Id
	
		if (select count([Id]) from Logins_Orgs where UserId = @Id) > 1
		begin
			return 1
		end
		else
		begin
			select 	@OrgId = LO.OrgId,
				@vchLogo = O.vchLogo
			from Logins_Orgs LO
			inner join Orgs O 
			on LO.UserId = @Id
			and LO.OrgId = O.[Id]
			
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

