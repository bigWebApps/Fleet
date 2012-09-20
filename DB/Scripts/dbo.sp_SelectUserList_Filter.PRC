SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectUserList_Filter]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectUserList_Filter]
GO


CREATE procedure dbo.sp_SelectUserList_Filter
	(
		@OrgId int,
		@vchFirstName varchar(50),
		@vchLastName varchar(50),
		@vchEmail varchar(50),
		@GroupId int,
		@UserTypeId int,
		@btActive int
	)
as
	set nocount on
	if isnull(@GroupId, 0) = 0
	begin
		select distinct 
			L.[Id] as [Id],
			L.vchFirstName as FirstName,
			L.vchLastName as LastName,
			L.vchEmail as Email,
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
		from Logins L
		inner join Logins_Orgs LO
		on L.vchFirstName like '%' + @vchFirstName + '%'
		and L.vchLastName like '%' + @vchLastName + '%'
		and L.vchEmail like '%' + @vchEmail + '%'
		and L.btActive <> @btActive
		and LO.UserId = L.[Id]
		and LO.OrgId = @OrgId
		and L.PIN <> 'XXX'
		inner join Logins_UserTypes LUT
		on LUT.UserId = L.[Id]
		and LUT.UserTypeId <> @UserTypeId
		order by L.vchLastName asc, L.vchFirstName asc
	end
	else
	begin
		select distinct 
			L.[Id] as [Id],
			L.vchFirstName as FirstName,
			L.vchLastName as LastName,
			L.vchEmail as Email,
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
		from Logins L
		inner join Logins_Orgs LO
		on L.vchFirstName like '%' + @vchFirstName + '%'
		and L.vchLastName like '%' + @vchLastName + '%'
		and L.vchEmail like '%' + @vchEmail + '%'
		and L.btActive <> @btActive
		and LO.UserId = L.[Id]
		and LO.OrgId = @OrgId
		and L.PIN <> 'XXX'
		inner join Logins_UserTypes LUT
		on LUT.UserId = L.[Id]
		and LUT.UserTypeId <> @UserTypeId
		inner join Logins_Groups LG
		on LG.OrgId = LO.OrgId
		and LG.GroupId = @GroupId
		and L.[Id] = LG.UserId
		order by L.vchLastName asc, L.vchFirstName asc
	end
	return 



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

