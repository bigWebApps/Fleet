SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectUserListByType]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectUserListByType]
GO


CREATE procedure dbo.sp_SelectUserListByType
	(
		@OrgId int,
		@UserTypeId int
	)
AS
	set nocount on
	select 	0 as Type, 
		0 as [Id], 
		'<none>' as vchName
	union all
	select  1 as Type,
		L.[Id] as [Id], 
		ISNULL(L.vchLastName, '') + ', ' + ISNULL(L.vchFirstName, '') as vchName
	from Logins L
	inner join Logins_Orgs LO
	on L.[Id] = LO.UserId
	and LO.OrgId = @OrgId
	and L.btActive = 1
	inner join Logins_UserTypes LUT
	on L.[Id] = LUT.UserId
	and LUT.UserTypeId = @UserTypeId
	order by Type, vchName asc


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

