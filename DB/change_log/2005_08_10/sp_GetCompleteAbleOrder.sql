SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER  procedure sp_GetCompleteAbleOrder
	(
		@OrgId int,
		@OrderId int
	)
as
	set nocount on
	declare @btCompleteAble int
	if not exists(select 'true' 
		from WorkOrders 
		where [Id] = @OrderId 
		and OrgId = @OrgId 
		and btIsActive = 1
		and StatusId <> 2
		and StatusId <> 3)
	begin
		return 0
	end
	else
	begin
		select @btCompleteAble = 1

		if exists(select 'true' 
			from WorkOrderInspections 
			where WorkOrderId = @OrderId 
			and OrgId = @OrgId
			and btIsProcessed = 0)
		begin
			select @btCompleteAble = 0
		end

		if exists(select 'true'
			from WorkOrderPMItems
			where WorkOrderId = @OrderId
			and OrgId = @OrgId
			and isnull(ServiceCheckId, 3) = 3
			and isnull(ServiceResultId, 0) = 0)
		begin
			select @btCompleteAble = 0
		end

		if exists(select 'true'
			from WorkOrderReportedIssues
			where WorkOrderId = @OrderId
			and OrgId = @OrgId
			and isnull(ServiceCheckId, 3) = 3
			and isnull(ServiceResultId, 0) = 0)
		begin
			if exists(select 'true'
				from WorkOrderReportedIssues
				where WorkOrderId = @OrderId
				and OrgId = @OrgId
				and isnull(ServiceCheckId, 0) = 0
				and isnull(ServiceResultId, 0) = 0)
				select @btCompleteAble = 0
			else
				select @btCompleteAble = 1
			
		end

		return @btCompleteAble
	end



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

