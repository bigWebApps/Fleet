SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create procedure sp_UpdateGeneralNotes
	(
		@OrgId int,
		@OrderId int,
		@UserId int,
		@vchDesc varchar(8000)
	)
AS
	set nocount on
	declare @intAssignedTo int
	
	if not exists(select 'true' from WorkOrders where [Id] = @OrderId and OrgId = @OrgId)
	begin
		return -1
	end
	else
	begin
		update 	WorkOrders
		set 	vchDesc = @vchDesc,
			intUpdatedBy = @UserId,
			dtUpdated = getdate()
		where 	[Id] = @OrderId
		and	OrgId = @OrgId
	end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

