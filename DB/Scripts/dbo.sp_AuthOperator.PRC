SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_AuthOperator]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_AuthOperator]
GO


----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 06/03/2005
-- Description: The procedure validate user by the LastName and PIN code 
-- and return the User Id, if the user is not valid then return 0. 
---------------------------------------------------------------------------
CREATE procedure dbo.sp_AuthOperator
	(
		@OrgId int,
		@vchLastName varchar(50),
		@vchPIN varchar(10),
		@UserId int=null output,
		@vchFirstName varchar(50)=null output,
		@btActive bit=null output
)
as
	set nocount on
	
	select 	@UserId = isnull(L.[Id], 0),
		@vchFirstName = isnull(L.vchFirstName, ''),
		@btActive = L.btActive
	from 	Logins L
	inner join Logins_Orgs LO
	on L.vchLastName = @vchLastName
	and L.PIN = @vchPIN
	and LO.UserId = L.[Id]
	and LO.OrgId = @OrgId

	select 	@UserId = isnull(@UserId, 0), 
		@vchFirstName = isnull(@vchFirstName, ''),
		@btActive = isnull(@btActive, 0)

	if @UserId = 0
		return 0;
	else
		return 1;


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

