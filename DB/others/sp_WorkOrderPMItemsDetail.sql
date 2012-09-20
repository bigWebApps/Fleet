SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER procedure sp_WorkOrderPMItemsDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int output,
		@WorkOrderId int=null output,
		@PMSchedDetailId int=null output,
		@ServiceResultId int=null output,
		@ServiceCheckId int=null output,
		@RepairItemId int=null output,
		@dtReport datetime=null output
	)
AS
	set nocount on

	declare @IsDelete bit

	create table #tmp(
		[Id] int identity(1, 1), 
		RepairId int
		)
	
	
	if @Action = 'S'
	begin
		if not exists(select 'true' from WorkOrderPMItems where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			select 	@WorkOrderId = WorkOrderId,
				@PMSchedDetailId = PMSchedDetailId,
				@ServiceResultId = ServiceResultId,
				@ServiceCheckId = ServiceCheckId,
				@RepairItemId = RepairItemId,
				@dtReport = dtReport
			from WorkOrderPMItems
			where [Id] = @Id
			and OrgId = @OrgId

			return 0
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
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
				@WorkOrderId,
				@PMSchedDetailId,
				@ServiceResultId,
				@ServiceCheckId,
				@RepairItemId,
				getdate()
				)
			select @Id = scope_identity()

			return 0
		end
		else
		begin -- update
			if not exists(select 'true' from WorkOrderPMItems where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				update 	[WorkOrderPMItems]
				set 	[WorkOrderId] = @WorkOrderId,
					[PMSchedDetailId] = @PMSchedDetailId,
					[ServiceResultId] = @ServiceResultId,
					[ServiceCheckId] = @ServiceCheckId,
					[RepairItemId] = @RepairItemId,
					[dtReport]=@dtReport
				where 	[Id] = @Id
				and 	OrgId = @OrgId
				
				return 0
			end
		end
	end
	if @Action = 'D'
	begin
		if not exists(select 'true' from WorkOrderPMItems where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			-- delete issues and all data relating to him 
			-- from RepairMult. Repairs and PartsUsed
			select 	@RepairItemId = isnull(RepairItemId, 0)
			from WorkOrderPMItems
			where [Id] = @Id
			and OrgId = @OrgId

			if isnull(@RepairItemId, 0) <> 0
			begin
				select @IsDelete = 1
	
				if exists(select 'true' 
					from WorkOrderPMItems
					where OrgId = @OrgId
					and WorkOrderId = @WorkOrderId
					and RepairItemId = @RepairItemId
					and [Id] <> @Id
					)
				begin
					select @IsDelete = 0
				end
	
				if exists(select 'true' 
					from WorkOrderReportedIssues
					where OrgId = @OrgId
					and WorkOrderId = @WorkOrderId
					and RepairItemId = @RepairItemId
					)
				begin
					select @IsDelete = 0
				end
	
				if exists(select 'true' 
					from WorkOrderInspectItems
					where OrgId = @OrgId
					and WorkOrderId = @WorkOrderId
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
					where [Id] = @Id
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
					where [Id] = @Id
					and OrgId = @OrgId
				end
			end
			else
			begin
				delete from WorkOrderPMItems
				where [Id] = @Id
				and OrgId = @OrgId
			end
			return 0
		end
	end
	drop table #tmp



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

