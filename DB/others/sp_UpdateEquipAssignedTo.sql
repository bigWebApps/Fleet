SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER    PROCEDURE sp_UpdateEquipAssignedTo
	(
		@OrgId int,
		@UId int, /*UserId*/
		@EquipId int,
		@intAssignedTo int,
		@vchNote varchar(250)
	)
AS
	set nocount on
	declare @intAssignedFrom int
	
	IF @intAssignedTo = 0 
		select @intAssignedTo = null
	
	begin transaction
		select top 1 @intAssignedFrom = AssignedTo from Equipments where OrgId = @OrgId and [Id] = @EquipId
		
		insert into EquipAssignLogs (OrgId, EquipId, AssignedFrom, AssignedTo, AssignedBy, vchNote, dtUpdated) 
		values (@OrgId, @EquipId, @intAssignedFrom, @intAssignedTo, @UId, @vchNote, getdate())
	
		update Equipments
		set AssignedTo=@intAssignedTo 
		where OrgId=@OrgId 
		and [Id]=@EquipId
	commit transaction
	return 


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

