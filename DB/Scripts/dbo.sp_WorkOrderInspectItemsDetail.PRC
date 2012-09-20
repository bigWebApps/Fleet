SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_WorkOrderInspectItemsDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_WorkOrderInspectItemsDetail]
GO

CREATE  PROCEDURE sp_WorkOrderInspectItemsDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int output,
		@WorkOrderId int=null output,
		@WorkOrderInspectId int=null output,
		@InspectionItemId int=null output,
		@ServiceResultId int=null output,
		@ServiceCheckId int=null output,
		@RepairItemId int=null output
	)
AS
	set nocount on
	
	if @Action = 'S'
	begin
		if isnull(@Id, 0) = 0
		begin
			if not exists(select 'true' from WorkOrderInspectItems where OrgId = @OrgId and WorkOrderInspectId = @WorkOrderInspectId)
			begin
				return -1
			end
			else
			begin
				select 	@Id = [Id],
					@WorkOrderId = WorkOrderId,
					@InspectionItemId = ItemId,
					@ServiceResultId = ServiceResultId,
					@ServiceCheckId = ServiceCheckId,
					@RepairItemId = RepairItemId
				from WorkOrderInspectItems
				where OrgId = @OrgId
				and WorkOrderInspectId = @WorkOrderInspectId
				return 0
			end
		end
		else
		begin
			if not exists(select 'true' from WorkOrderInspectItems where OrgId = @OrgId and [Id] = @Id)
			begin
				return -1
			end
			else
			begin
				select 	@WorkOrderId = WorkOrderId,
					@WorkOrderInspectId = WorkOrderInspectId,
					@InspectionItemId = ItemId,
					@ServiceResultId = ServiceResultId,
					@ServiceCheckId = ServiceCheckId,
					@RepairItemId = RepairItemId
				from WorkOrderInspectItems
				where [Id] = @Id
				and OrgId = @OrgId
				return 0
			end
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
			insert into WorkOrderInspectItems(
				[OrgId], 
				[WorkOrderId], 
				[WorkOrderInspectId],
				[ItemId],
				[ServiceResultId],
				[ServiceCheckId],
				[RepairItemId]
				)
			values(
				@OrgId,
				@WorkOrderId,
				@WorkOrderInspectId,
				@InspectionItemId,
				@ServiceResultId,
				@ServiceCheckId,
				@RepairItemId
				)
			select @Id = scope_identity()
			return 0
		end
		else
		begin -- update
			if not exists(select 'true' from WorkOrderInspectItems where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				update 	[WorkOrderInspectItems]
				set 	[WorkOrderId] = @WorkOrderId,
					[WorkOrderInspectId] = @WorkOrderInspectId,
					[ItemId] = @InspectionItemId,
					[ServiceResultId] = @ServiceResultId,
					[ServiceCheckId] = @ServiceCheckId,
					[RepairItemId] = @RepairItemId
				where 	[Id] = @Id
				and 	OrgId = @OrgId
				
				return 0
			end
		end
	end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

