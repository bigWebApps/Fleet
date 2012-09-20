SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectUsersListFromGroup]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectUsersListFromGroup]
GO

CREATE  procedure sp_SelectUsersListFromGroup
(
	@OrgId int,
	@GroupId int
)
AS
	set nocount on
	
	-- 1th select for main list
	select 	L.[Id] as UserId,
		L.vchFirstName as FirstName,
		L.vchLastName as LastName,
		L.Initials as Initials,
		(select case when count(LUT.[Id]) > 1 
			then 'Technician/Operator'
			else (	case when min(LUT.[UserTypeId])=1 
				then 'Technician'
				else 'Operator'
				end
				)
			end 
		from Logins_UserTypes LUT
		where LUT.UserId = L.[Id]
		) as UserType
	from [Logins] L
	inner join Logins_Groups LG
	on LG.GroupId = @GroupId
	and LG.OrgId = @OrgId
	and L.[Id] = LG.UserId
	and L.btActive = 1
	
	-- 2th select for below list as adding users
	select 	L.[Id] as UserId,
		L.vchFirstName + ', ' + L.vchLastName + 
		(select case when count(LUT.[Id]) > 1 
			then  ' [tech/op]'
			else (	case when min(LUT.[UserTypeId])=1 
				then ' [tech]'
				else ' [op]'
				end
				)
			end 
		from Logins_UserTypes LUT
		where LUT.UserId = L.[Id]
		) as UserName
	from [Logins] L
	inner join Logins_Orgs LO
	on LO.OrgId = @OrgId
	and L.[Id] = LO.UserId
	where L.[Id] not in (
		select LG.UserId
		from Logins_Groups LG
		where LG.GroupId = @GroupId
		and LG.OrgId = @OrgId
		)
	and L.btActive = 1

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

