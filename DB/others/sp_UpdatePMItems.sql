SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER procedure sp_UpdatePMItems
	(
		@btChecked bit,
		@OrgId int,
		@OrderId int,
		@ItemId int=null,
		@PMSchedDetailId int=null
	)
AS
	set nocount on

	declare @RepairItemId int
	declare @IsDelete bit

	create table #tmp(
		[Id] int identity(1, 1), 
		RepairId int
		)

	if isnull(@btChecked, 0) = 0
	begin -- unchecked or nothing
		if exists(select 'true' from WorkOrderPMItems where [Id] = @ItemId and OrgId = @OrgId)
		begin -- unchecked [delete item and his sub-items]

			-- delete issues and all data relating to him 
			-- from RepairMult. Repairs and PartsUsed

			select 	@RepairItemId = isnull(RepairItemId, 0)
			from WorkOrderPMItems
			where [Id] = isnull(@ItemId, 0)
			and OrgId = @OrgId

			if isnull(@RepairItemId, 0) <> 0
			begin

				select @IsDelete = 1
	
				if exists(select 'true' 
					from WorkOrderPMItems
					where OrgId = @OrgId
					and WorkOrderId = @OrderId
					and RepairItemId = @RepairItemId
					and [Id] <> isnull(@ItemId, 0)
					)
				begin
					select @IsDelete = 0
				end
	
				if exists(select 'true' 
					from WorkOrderReportedIssues
					where OrgId = @OrgId
					and WorkOrderId = @OrderId
					and RepairItemId = @RepairItemId
					)
				begin
					select @IsDelete = 0
				end
	
				if exists(select 'true' 
					from WorkOrderInspectItems
					where OrgId = @OrgId
					and WorkOrderId = @OrderId
					and RepairItemId = @RepairItemId
					)
				begin
					select @IsDelete = 0
				end
	
				if @IsDelete = 1
				begin -- processing all repairs for delete
					insert into #tmp(RepairId)
					select RepairId
					from RepairMult
					where ItemId = @RepairItemId
					and OrgId = @OrgId
		
					delete from RepairMult
					where ItemId = @RepairItemId
					and OrgId = @OrgId
		
					delete from WorkOrderPMItems
					where [Id] = isnull(@ItemId, 0)
					and OrgId = @OrgId
		
					delete from PartsUsed
					where OrgId = @OrgId
					and RepairId in (select RepairId from #tmp)
		
					delete from Repairs
					where OrgId = @OrgId
					and [Id] in (select RepairId from #tmp)
				end
				else
				begin
					delete from WorkOrderPMItems
					where [Id] = isnull(@ItemId, 0)
					and OrgId = @OrgId
				end
			end
			else
			begin
				delete from WorkOrderPMItems
				where [Id] = isnull(@ItemId, 0)
				and OrgId = @OrgId
			end
	
			return 0
		end
		else -- nothing
		begin
			return -1
		end
	end
	else
	begin -- checked or nothing
		if not exists(select 'true' from WorkOrderPMItems where [Id] = @ItemId and OrgId = @OrgId)
		begin -- checked [insert item and his sub-items]

			insert into [WorkOrderPMItems](
				[OrgId], 
				[WorkOrderId], 
				[PMSchedDetailId], 
				[ServiceResultId],
				[ServiceCheckId],
				[RepairItemId],
				[dtReport]
				)
			values(
				@OrgId,
				@OrderId,
				isnull(@PMSchedDetailId, 0),
				null,
				null,
				null,
				getdate()
				)

			return scope_identity()
		end
		else -- nothing
		begin
			return -1
		end
	end
	drop table #tmp





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

