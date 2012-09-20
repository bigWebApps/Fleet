SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

alter procedure sp_SigningWorkOrderClose
	(
		@OrgId int,
		@WorkOrderId int,
		@chInitials char(3),
		@vchPIN varchar(4),
		@vchReleasedTo varchar(50),
		@dtDeparture datetime
	)
AS
	set nocount on

	declare @IsAble bit
	declare @UserId int
	declare @SpareEquipId int
	declare @intAssignedFrom int
	
	if exists(select 'true' from Logins where Initials = @chInitials and PIN = @vchPIN)
	begin
		select @IsAble = 0
		
		select @UserId = [Id]
		from Logins 
		where Initials = @chInitials 
		and PIN = @vchPIN

		if dbo.f_IsTechnician(@UserId) = 1
		begin	
			select @IsAble = 1
		end
		else
		begin
			if exists(select 'true' 
				from SignedDocuments 
				where DocumentId = @WorkOrderId
				and DocumentTypeId = 1 
				and UserId = @UserId
				and OrgId = @OrgId)
			begin
				select @IsAble = 1
			end
		end

		if @IsAble = 1
		begin -- close the order
			-- free the spare equipment

			select 	@SpareEquipId = isnull(SpareEquipId, 0),
				@intAssignedFrom = intOperatorId
			from 	WorkOrders
			where 	[Id] = @WorkOrderId
			and 	OrgId = @OrgId

			if @SpareEquipId <> 0
			begin
				insert into EquipAssignLogs (OrgId, EquipId, AssignedFrom, AssignedTo, AssignedBy, vchNote, dtUpdated) 
				values (@OrgId, @SpareEquipId, @intAssignedFrom, null, @UserId, 'checking in the spare equipment', getdate())
		
				update Equipments
				set AssignedTo = null
				where [Id] = @SpareEquipId
				and OrgId = @OrgId 
			end

			-- update the order
			update 	WorkOrders
			set 	StatusId = 2,
				SpareEquipId = null,
				dtClosed = getdate(),
				vchReleasedTo = @vchReleasedTo,
				dtDeparture = @dtDeparture
			where 	[Id] = @WorkOrderId
			and 	OrgId = @OrgId
	
			-- sign the document
			insert into [SignedDocuments](
				[OrgId], 
				[UserId], 
				[DocumentId], 
				[DocumentTypeId], 
				[dtSignDate]
				)
			select 	@OrgId,
				L.[Id],
				@WorkOrderId,
				4,
				getdate()
			from Logins L 
			where L.Initials = @chInitials 
			and L.PIN = @vchPIN

			return 0
		end
		begin
			return -2
		end
	end
	else
	begin
		return -1
	end




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

