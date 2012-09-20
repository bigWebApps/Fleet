SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER  procedure sp_SigningInspection
	(
		@OrgId int,
		@WorkOrderId int,
		@InspectId int,
		@chInitials char(3),
		@vchPIN varchar(4)
	)
AS
	set nocount on

	declare @CountItems int
	
	if exists(select 'true' from Logins where Initials = @chInitials and PIN = @vchPIN)
	begin

		select @CountItems = count([Id])
		from WorkOrderInspectItems 
		where WorkOrderInspectId = @InspectId
		and WorkOrderId = @WorkOrderId
		and OrgId = @OrgId
		and (	isnull(ServiceCheckId, 0) = 0 
			or (	isnull(ServiceCheckId, 0) = 3 
				and isnull(ServiceResultId, 0) = 0
				)
			)

		if @CountItems > 0 -- if there are uncompleted items 
		begin 
			return -2
		end
		else
		begin
			update WorkOrderInspections
			set btIsProcessed = 1
			where [Id] = @InspectId
			and WorkOrderId = @WorkOrderId
			and OrgId = @OrgId
	
			insert into [SignedDocuments](
				[OrgId], 
				[UserId], 
				[DocumentId], 
				[DocumentTypeId], 
				[dtSignDate]
				)
			select 	@OrgId,
				L.[Id],
				@InspectId,
				2,
				getdate()
			from Logins L 
			where L.Initials = @chInitials 
			and L.PIN = @vchPIN

			-- the history table is keeping the inspection history 
			-- of equipment

			insert into EquipInspectHistory (
				OrgId, 
				EquipId,
				dtDate,
				InspectionId,
				WorkOrderId
				)
			select	@OrgId,
				WO.EquipId,
				getdate(),
				WI.InspectId,
				@WorkOrderId
			from 	WorkOrderInspections WI
			inner join WorkOrders WO
			on WI.[Id] = @InspectId
			and WI.WorkOrderId = @WorkOrderId
			and WI.OrgId = @OrgId
			and WI.WorkOrderId = WO.[Id]
			and WI.OrgId = WO.OrgId
	
			return 0
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

