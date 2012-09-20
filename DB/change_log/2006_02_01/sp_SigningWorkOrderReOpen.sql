SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER  procedure dbo.sp_SigningWorkOrderReOpen
	(
		@OrgId int,
		@OrderId int,
		@UserId int,
		@dtCurrentDate datetime
	)
as
	set nocount on
	
	if not exists(select 'true' from WorkOrders where [Id] = @OrderId and OrgId = @OrgId)
	begin
		return -1
	end
	else
	begin
		if exists(select 'true' 
			from WorkOrders 
			where OrgId = @OrgId 
			and [Id] = @OrderId 
			and StatusId = 2)
		begin
			update 	WorkOrders
			set 	dtOpened = @dtCurrentDate,
				StatusId = 6,
				OperatorStatusId = 1,
				dtClosed = null,
				dtDeparture = null,
				dtUpdated = @dtCurrentDate,
				intUpdatedBy = @UserId
			where 	[Id] = @OrderId
			and 	OrgId = @OrgId
	
			insert into [SignedDocuments](
				[OrgId], 
				[UserId], 
				[DocumentId], 
				[DocumentTypeId], 
				[dtSignDate]
				)
			values(	@OrgId,
				@UserId,
				@OrderId,
				6,
				@dtCurrentDate
				)
		end
		return 0
	end



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

