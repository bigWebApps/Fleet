SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create procedure dbo.sp_UpdateInActiveWorkOrder
	(
		@OrgId int,
		@OrderId int
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
		set btIsActive = 0
		where [Id] = @OrderId
		and OrgId = @OrgId
		return 0
	end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

