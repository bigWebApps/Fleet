SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GetDeleteAbleOrder]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GetDeleteAbleOrder]
GO



create procedure dbo.sp_GetDeleteAbleOrder
	(
		@OrgId int,
		@OrderId int
	)
as
	set nocount on

	if not exists(select 'true' 
		from WorkOrders 
		where [Id] = @OrderId 
		and OrgId = @OrgId 
		and btIsActive = 1
		and StatusId <> 2
		)
	begin
		return 0
	end
	else
	begin
		if exists(select 'true' 
			from WorkOrderInspectItems 
			where WorkOrderId = @OrderId 
			and OrgId = @OrgId
			and isnull(ServiceCheckId, 0) <> 0
			)
		begin
			return 0
		end

		if exists(select 'true'
			from WorkOrderPMItems
			where WorkOrderId = @OrderId
			and OrgId = @OrgId
			and isnull(ServiceCheckId, 0) <> 0
			)
		begin
			return 0
		end

		if exists(select 'true'
			from WorkOrderReportedIssues
			where WorkOrderId = @OrderId
			and OrgId = @OrgId
			and isnull(ServiceCheckId, 0) <> 0
			)
		begin
			return 0
		end

		return 1
	end




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

