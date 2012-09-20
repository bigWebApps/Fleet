SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SigningWorkOrderOpen]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SigningWorkOrderOpen]
GO

CREATE   procedure sp_SigningWorkOrderOpen
	(
		@OrgId int,
		@WorkOrderId int,
		@chInitials char(3),
		@vchPIN varchar(10),
		@dtCurrentDate datetime
	)
AS
	set nocount on
	
	if exists(select 'true' from Logins where Initials = @chInitials and PIN = @vchPIN)
	begin
		if exists(select 'true' from WorkOrders where [Id] = @WorkOrderId and OrgId = @OrgId)
		begin
			update 	WorkOrders
			set 	dtOpened = @dtCurrentDate,
				StatusId = 1
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
				5,
				@dtCurrentDate
			from Logins L 
			where L.Initials = @chInitials 
			and L.PIN = @vchPIN
	
			return 0
		end
		else
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

