SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create PROCEDURE sp_SigningWorkOrder
	(
		@OrgId int,
		@WorkOrderId int,
		@chInitials char(3),
		@vchPIN varchar(4)
	)
AS
	set nocount on
	
	if exists(select 'true' from Logins where Initials = @chInitials and PIN = @vchPIN)
	begin

		update WorkOrders
		set btIsActive = 1
		where [Id] = @WorkOrderId
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
			@WorkOrderId,
			1,
			getdate()
		from Logins L 
		where L.Initials = @chInitials 
		and L.PIN = @vchPIN

		return 0
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

