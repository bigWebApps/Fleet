SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER   procedure sp_SigningWorkOrderComplete
	(
		@OrgId int,
		@WorkOrderId int,
		@chInitials char(3),
		@vchPIN varchar(4),
		@vchCleanliness varchar(1000),
		@vchDesc varchar(8000)
	)
AS
	set nocount on
	
	if exists(select 'true' from Logins where Initials = @chInitials and PIN = @vchPIN)
	begin

		update 	WorkOrders
		set 	StatusId = 6,
			dtCompleted = getdate(),
			vchCleanliness = @vchCleanliness,
			vchDesc = @vchDesc
		where 	[Id] = @WorkOrderId
		and 	OrgId = @OrgId

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
			3,
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

