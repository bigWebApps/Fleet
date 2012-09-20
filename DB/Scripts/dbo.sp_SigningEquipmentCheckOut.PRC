SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SigningEquipmentCheckOut]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SigningEquipmentCheckOut]
GO


CREATE   procedure sp_SigningEquipmentCheckOut
	(
		@OrgId int,
		@OrderId int,
		@chInitials char(3),
		@vchPIN varchar(10),
		@vchReleasedTo varchar(50),
		@dtCurrentDate datetime,
		@UserId int=null output
	)
AS
	set nocount on
	select @UserId = [Id]
	from Logins 
	where Initials = @chInitials 
	and PIN = @vchPIN	
	if isnull(@UserId, 0) <> 0
	begin
		update 	WorkOrders
		set 	OperatorStatusId = 2,
			vchReleasedTo = @vchReleasedTo,
			dtDeparture = @dtCurrentDate,
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
			3,
			@dtCurrentDate
			)
	
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

