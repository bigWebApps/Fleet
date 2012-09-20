SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER  procedure sp_UpdateEquipSpare
	(
		@OrgId int,
		@UserId int,
		@OrderId int,
		@SpareEquipId int=null,
		@vchNote varchar(250),
		@dtCurrentDate datetime,
		@IsOperator bit
	)
as
	set nocount on
	declare @TempOperatorId int
	declare @SpareEquipIdFrom int
	
	if not exists(select 'true' from WorkOrders where [Id] = @OrderId and OrgId = @OrgId)
	begin
		return -1
	end
	else
	begin
		-- if the spare is updating then assign the spare equipment
		if isnull(@IsOperator, 0) = 0
			select 	@SpareEquipIdFrom = SpareEquipId,
				@TempOperatorId = intOperatorId
			from 	[WorkOrders]
			where 	[OrgId] = @OrgId 
			and 	[Id] = @OrderId
		else
			select 	@SpareEquipIdFrom = SpareEquipId,
				@TempOperatorId = @UserId
			from 	[WorkOrders]
			where 	[OrgId] = @OrgId 
			and 	[Id] = @OrderId

		if isnull(@SpareEquipIdFrom, 0) <> isnull(@SpareEquipId, 0)
		begin -- assign or unassign the spare equipment 
			if isnull(@SpareEquipIdFrom, 0) <> 0
			begin -- unassign the old spare equipment
				insert into EquipAssignLogs (
					OrgId, 
					EquipId, 
					IsTemp,
					AssignedFrom, 
					AssignedTo, 
					AssignedBy, 
					vchNote, 
					dtUpdated) 
				select 	@OrgId, 
					@SpareEquipIdFrom, 
					1,
					TempOperatorId, 
					null, 
					@UserId, 
					'checking in the spare equipment', 
					@dtCurrentDate
				from Equipments
				where [Id] = @SpareEquipIdFrom
				and OrgId = @OrgId

				update Equipments
				set TempOperatorId = null
				where [Id] = @SpareEquipIdFrom
				and OrgId = @OrgId
			end
			if isnull(@SpareEquipId, 0) <> 0
			begin -- assign the new spare equipment
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
				select 	@OrgId, 
					@SpareEquipId, 
					1,
					TempOperatorId, 
					@TempOperatorId, 
					@UserId, 
					'checking out the spare equipment', 
					@dtCurrentDate
				from Equipments
				where [Id] = @SpareEquipId
				and OrgId = @OrgId

				update Equipments
				set TempOperatorId = @TempOperatorId
				where OrgId = @OrgId 
				and [Id] = @SpareEquipId
			end
		end
		if isnull(@SpareEquipId, -1) <> -1
		begin
			update 	WorkOrders
			set 	SpareEquipId = @SpareEquipId,
				bitStaying = 0
			where OrgId = @OrgId 
			and [Id] = @OrderId
		end 
		return 0
	end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

