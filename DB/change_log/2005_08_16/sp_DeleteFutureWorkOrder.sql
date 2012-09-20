SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


create procedure dbo.sp_DeleteFutureWorkOrder
	(
		@OrgId int,
		@OrderId int
	)
as
	set nocount on

	declare @IsDelete bit
	declare @tbl table (DataId int)

	if not exists(select 'true' from WorkOrders where [Id] = @OrderId and OrgId = @OrgId)
		return -1
	else
	begin
		select @IsDelete = 1
	
		if exists(select 'true' 
			from WorkOrderReportedIssues
			where WorkOrderId = @OrderId
			and OrgId = @OrgId)
			select @IsDelete = 0
	
		if exists(select 'true' 
			from WorkOrderPMItems
			where WorkOrderId = @OrderId
			and OrgId = @OrgId)
			select @IsDelete = 0
	
		if exists(select 'true' 
			from WorkOrderInspections
			where WorkOrderId = @OrderId
			and OrgId = @OrgId)
			select @IsDelete = 0
	
		if @IsDelete = 1
		begin
			insert into @tbl(DataId)
			select DataId 
			from WorkOrders
			where [Id] = @OrderId
			and OrgId = @OrgId
	
			delete from WorkOrders
			where [Id] = @OrderId
			and OrgId = @OrgId
			
			delete from EquipData 
			where OrgId = @OrgId
			and [Id] in (
				select DataId
				from @tbl
				)
			
			delete from Notes
			where ItemId = @OrderId
			and TypeId in (1, 2)
			and OrgId = @OrgId
		end
		return 0
	end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

