SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER PROCEDURE sp_UpdateEquipSpare
	(
		@OrgId int,
		@UserId int,
		@OrderId int,
		@EquipId int,
		@vchNote varchar(250)
	)
AS
	set nocount on
	declare @intAssignedTo int
	
	if not exists(select 'true' from Equipments where [Id] = @EquipId and OrgId = @OrgId)	
	begin
		return -1
	end
	else
	begin
		if not exists(select 'true' from WorkOrders where [Id] = @OrderId and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			begin transaction
			select @intAssignedTo = intOperatorId
			from WorkOrders
			where OrgId = @OrgId 
			and [Id] = @OrderId
		
			insert into EquipAssignLogs (OrgId, EquipId, AssignedFrom, AssignedTo, AssignedBy, vchNote, dtUpdated) 
			select @OrgId, @EquipId, AssignedTo, @intAssignedTo, @UserId, @vchNote, getdate()
			from Equipments
			where [Id] = @EquipId
			and OrgId = @OrgId
	
			update Equipments
			set AssignedTo=@intAssignedTo 
			where OrgId=@OrgId 
			and [Id]=@EquipId
	
			update WorkOrders
			set SpareEquipId = @EquipId
			where OrgId = @OrgId 
			and [Id] = @OrderId
			commit
			return 0
		end
	end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

