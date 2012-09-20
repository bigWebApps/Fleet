SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create procedure dbo.sp_UpdateEquipAssignedTempTo
	(
		@OrgId int,
		@UId int, /*UserId*/
		@EquipId int,
		@TempOperatorId int,
		@vchNote varchar(250)
	)
as
	set nocount on

	declare @TempOperatorIdFrom int
	
	if @TempOperatorId = 0 
		select @TempOperatorId = null
	
	select @TempOperatorIdFrom = TempOperatorId
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
			1,
			@TempOperatorIdFrom, 
			@TempOperatorId, 
			@UId, 
			@vchNote, 
			getdate()
		)

	update Equipments
	set TempOperatorId = @TempOperatorId
	where OrgId=@OrgId 
	and [Id]=@EquipId

	return 

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

