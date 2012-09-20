SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SetAssociationsIssue]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SetAssociationsIssue]
GO



----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 14/02/2006
-- Description: The procedure set the association between Reported Issue and 
-- Inspection Item
---------------------------------------------------------------------------
CREATE procedure dbo.sp_SetAssociationsIssue
(
	@OrgId int,
	@OrderId int,
	@InspectItemId int,
	@ReportedIssueId int
)
as
	set nocount on

	-- getting RepairItemId from processed Inspection Item (@InspectItemId)
	-- if RepairItemId = null then get out from procedure
	-- Look at Reported Issue (@ReportedIssueId) if he already
	-- has RepairItemId != null then get it and replace it to 
	-- new RepairItemId for every item of WorkOrderReportedIssue
	-- and RepairMult tables
	
	declare @newRepairItemId int
	declare @oldRepairItemId int
	declare @ServiceResultId int

	select 	@newRepairItemId = RepairItemId,
		@ServiceResultId = ServiceResultId
	from 	WorkOrderInspectItems 
	where 	WorkOrderId = @OrderId
	and 	[Id] = @InspectItemId
	and 	OrgId = @OrgId

	if isnull(@newRepairItemId, 0) <> 0
	begin
		select 	@oldRepairItemId = RepairItemId
		from 	WorkOrderReportedIssues
		where 	WorkOrderId = @OrderId
		and 	[Id] = @ReportedIssueId
		and 	OrgId = @OrgId

		if isnull(@oldRepairItemId, 0) = 0
		begin
			update 	WorkOrderReportedIssues
			set 	RepairItemId = @newRepairItemId,
				ServiceCheckId = 3,
				ServiceResultId = @ServiceResultId
			where 	WorkOrderId = @OrderId
			and 	[Id] = @ReportedIssueId
			and 	OrgId = @OrgId
		end
		else
		begin
			update 	WorkOrderReportedIssues
			set	RepairItemId = @newRepairItemId
			where 	WorkOrderId = @OrderId
			and 	OrgId = @OrgId
			and	RepairItemId = @oldRepairItemId

			update 	WorkOrderPMItems
			set	RepairItemId = @newRepairItemId
			where 	WorkOrderId = @OrderId
			and 	OrgId = @OrgId
			and	RepairItemId = @oldRepairItemId

			update 	WorkOrderInspectItems
			set	RepairItemId = @newRepairItemId
			where 	WorkOrderId = @OrderId
			and 	OrgId = @OrgId
			and	RepairItemId = @oldRepairItemId

			update 	RepairMult
			set	ItemId = @newRepairItemId
			where 	OrgId = @OrgId
			and	ItemId = @oldRepairItemId

			-- deleting the doubles into RepairMult
			delete from RepairMult
			where [Id] in (
				select RM.[Id]
				from RepairMult RM
				inner join (
					select convert(varchar, ItemId) + '_' + convert(varchar, RepairId) as sKey, 
					min([Id]) as min_id
					from RepairMult
					where OrgId = @OrgId
					group by convert(varchar, ItemId) + '_' + convert(varchar, RepairId)
					) rs 
				on convert(varchar, RM.ItemId) + '_' + convert(varchar, RM.RepairId) = rs.sKey 
				and RM.[Id] <> rs.min_id
				and RM.OrgId = @OrgId
				)
			and OrgId = @OrgId
		end
	end

	return
	

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

