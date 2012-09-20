SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER PROCEDURE sp_SelectEquipAssignTo
	(
		@OrgId int,
		@EquipId int
	)
AS
	set nocount on
	declare @AssignedTo int

	select @AssignedTo = AssignedTo 
	from Equipments 
	where OrgId = @OrgId 
	and [Id] = @EquipId

	select @AssignedTo = ISNULL(@AssignedTo, 0)

	select L.[Id], vchName = 'operator. "' + L.vchLastName + ', ' + L.vchFirstName + '"'
	from Logins L
	inner join Logins_Orgs LO
	on L.[Id] = LO.UserId
	inner join Logins_UserTypes LUT
	on LUT.UserId = L.[Id]
	where LO.OrgId = @OrgId 
	and LUT.UserTypeId = 2 -- select drivers only
	and L.[Id] <> @AssignedTo
	order by vchLastName, vchFirstName

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

