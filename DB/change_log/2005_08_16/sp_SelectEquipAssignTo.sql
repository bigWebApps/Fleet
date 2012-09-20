SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

alter procedure sp_SelectEquipAssignTo
	(
		@OrgId int,
		@EquipId int
	)
as
	set nocount on
	declare @OperatorId int
	select @OperatorId = EquipOperatorId
	from Equipments 
	where OrgId = @OrgId 
	and [Id] = @EquipId

	select @OperatorId = isnull(@OperatorId, 0)

	select L.[Id], vchName = L.vchLastName + ', ' + L.vchFirstName
	from Logins L
	inner join Logins_Orgs LO
	on L.[Id] = LO.UserId
	inner join Logins_UserTypes LUT
	on LUT.UserId = L.[Id]
	where LO.OrgId = @OrgId 
	and LUT.UserTypeId = 2 -- select drivers only
	and L.[Id] <> @OperatorId
	order by vchLastName, vchFirstName

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

