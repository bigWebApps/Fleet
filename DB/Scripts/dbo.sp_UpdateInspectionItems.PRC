SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_UpdateInspectionItems]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_UpdateInspectionItems]
GO


CREATE  procedure sp_UpdateInspectionItems
	(
		@OrgId int,
		@OrderId int,
		@InspectItemId int,
		@ServiceCheckId int
	)
AS
	set nocount on
	if not exists(select 'true' from WorkOrderInspectItems where [Id] = @InspectItemId and OrgId = @OrgId and WorkOrderId = @OrderId)
	begin
		return -1
	end
	else
	begin
		-- update InspectionItems_PMSchedDetails

		update 	WorkOrderInspectItems
		set 	ServiceCheckId = @ServiceCheckId,
			ServiceResultId = null,
			RepairItemId = null
		where [Id] = @InspectItemId
		and OrgId = @OrgId
		and WorkOrderId = @OrderId
		return 0
	end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

