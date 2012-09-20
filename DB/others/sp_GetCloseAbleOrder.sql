SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

alter procedure sp_GetCloseAbleOrder
	(
		@OrgId int,
		@OrderId int
	)
as
	set nocount on

	declare @btCloseAble int

	if not exists(select 'true' 
		from WorkOrders 
		where [Id] = @OrderId 
		and OrgId = @OrgId 
		and btIsActive = 1
		and StatusId <> 2)
	begin
		return 0
	end
	else
	begin
		select @btCloseAble = 1

		if exists(select 'true' 
			from WorkOrderInspections 
			where WorkOrderId = @OrderId 
			and OrgId = @OrgId
			and btIsProcessed = 0)
		begin
			select @btCloseAble = 0
		end

		if exists(select 'true'
			from WorkOrderPMItems
			where WorkOrderId = @OrderId
			and OrgId = @OrgId
			and isnull(ServiceCheckId, 3) = 3
			and isnull(ServiceResultId, 0) = 0)
		begin
			select @btCloseAble = 0
		end

		if exists(select 'true'
			from WorkOrderReportedIssues
			where WorkOrderId = @OrderId
			and OrgId = @OrgId
			and isnull(ServiceCheckId, 3) = 3
			and isnull(ServiceResultId, 0) = 0)
		begin
			select @btCloseAble = 0
		end

		return @btCloseAble
	end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

