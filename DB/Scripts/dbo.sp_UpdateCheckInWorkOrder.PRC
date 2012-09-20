SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_UpdateCheckInWorkOrder]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_UpdateCheckInWorkOrder]
GO

CREATE  procedure sp_UpdateCheckInWorkOrder
	(
		@OrgId int,
		@OrderId int,
		@UserId int,
		@dtCurrentDate datetime
	)
AS
	set nocount on
	
	if not exists(select 'true' from WorkOrders where [Id] = @OrderId and OrgId = @OrgId)
	begin
		return -1
	end
	else
	begin
		update WorkOrders
		set 	OperatorStatusId = 1,
			dtArrival = @dtCurrentDate,
			intUpdatedBy = @UserId,
			dtUpdated = @dtCurrentDate
		where [Id] = @OrderId
		and OrgId = @OrgId
		insert into [SignedDocuments](
			[OrgId], 
			[UserId], 
			[DocumentId], 
			[DocumentTypeId], 
			[dtSignDate]
			)
		values	(
			@OrgId,
			@UserId,
			@OrderId,
			1,
			@dtCurrentDate
			)
	
		return 0
	end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

