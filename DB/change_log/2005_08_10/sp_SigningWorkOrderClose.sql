SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER procedure sp_SigningWorkOrderClose
	(
		@OrgId int,
		@OrderId int,
		@chInitials char(3),
		@vchPIN varchar(10),
		@vchCleanliness varchar(1000),
		@dtCurrentDate datetime
	)
AS
	set nocount on
	
	if exists(select 'true' from Logins where Initials = @chInitials and PIN = @vchPIN)
	begin
		-- check reported issues and unassign it

		update 	WorkOrderReportedIssues
		set 	WorkOrderId = null,
			LastWorkOrderId = @OrderId
		where 	WorkOrderId = @OrderId
		and 	OrgId = @OrgId
		and 	isnull(ServiceCheckId, 0) = 3
		and 	isnull(ServiceResultId, 0) = 0
		
		-- change status
		update 	WorkOrders
		set 	StatusId = 2,
			dtClosed = @dtCurrentDate,
			vchCleanliness = @vchCleanliness
		where 	[Id] = @OrderId
		and 	OrgId = @OrgId

		-- sign to close
		insert into [SignedDocuments](
			[OrgId], 
			[UserId], 
			[DocumentId], 
			[DocumentTypeId], 
			[dtSignDate]
			)
		select 	@OrgId,
			L.[Id],
			@OrderId,
			4,
			@dtCurrentDate
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

