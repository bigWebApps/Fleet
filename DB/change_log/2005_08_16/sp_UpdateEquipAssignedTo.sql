SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER  procedure sp_UpdateEquipAssignedTo
	(
		@OrgId int,
		@UId int, /*UserId*/
		@EquipId int,
		@EquipOperatorId int,
		@vchNote varchar(250)
	)
as
	set nocount on

	declare @EquipOperatorIdFrom int
	
	if @EquipOperatorId = 0 
		select @EquipOperatorId = null
	
	select @EquipOperatorIdFrom = EquipOperatorId 
	from Equipments 
	where OrgId = @OrgId 
	and [Id] = @EquipId
	
	insert into EquipAssignLogs (
			OrgId, 
			EquipId, 
			IsTemp,
			AssignedFrom, 
			AssignedTo, 
			AssignedBy, 
			vchNote, 
			dtUpdated
			) 
	values (	
			@OrgId, 
			@EquipId, 
			0,
			@EquipOperatorIdFrom, 
			@EquipOperatorId, 
			@UId, 
			@vchNote, 
			getdate()
		)

	update Equipments
	set EquipOperatorId = @EquipOperatorId
	where OrgId=@OrgId 
	and [Id]=@EquipId

	return 

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

