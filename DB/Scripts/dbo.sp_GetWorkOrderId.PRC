SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GetWorkOrderId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GetWorkOrderId]
GO

create procedure sp_GetWorkOrderId
	(
		@OrgId int,
		@OrderId int,
		@WorkOrderNumber int=null output,
		@dtCreated datetime=null output
	)
as
	set nocount on
	if not exists(select 'true' from WorkOrders where [Id] = @OrderId and OrgId = @OrgId)
	begin
		return -1
	end
	else
	begin
		select 	@WorkOrderNumber = WO.WorkOrderNumber,
			@dtCreated = WO.dtCreated
		from WorkOrders WO
		where WO.[Id] = @OrderId
		and WO.OrgId = @OrgId
	end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

