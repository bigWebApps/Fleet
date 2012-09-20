SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER  procedure sp_SelectUserList_Filter
	(
		@OrgId int,
		@vchFirstName varchar(50),
		@vchLastName varchar(50),
		@vchEmail varchar(50),
		@UserTypeId int
	)
as
	set nocount on
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
	and L.btActive = 1
	and LO.UserId = L.[Id]
	and LO.OrgId = @OrgId
	inner join Logins_UserTypes LUT
	on LUT.UserId = L.[Id]
	and LUT.UserTypeId <> @UserTypeId
	order by L.vchLastName asc, L.vchFirstName asc
	return 

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

