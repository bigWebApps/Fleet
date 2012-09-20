SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER   PROCEDURE sp_WorkOrderReportedIssuesDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int output,
		@EquipId int=null output,
		@vchDesc varchar(4000)=null output,
		@WorkOrderId int=null output,
		@LastWorkOrderId int=null output,
		@RepairCatId int=null output,
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
		if not exists(select 'true' from WorkOrderReportedIssues where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			select 	@vchDesc = vchDesc,
				@WorkOrderId = WorkOrderId,
				@LastWorkOrderId = LastWorkOrderId,
				@EquipId = EquipId,
				@RepairCatId = RepairCatId,
				@ServiceResultId = ServiceResultId,
				@ServiceCheckId = ServiceCheckId,
				@RepairItemId = RepairItemId,
				@dtReport = dtReport
			from WorkOrderReportedIssues 
			where [Id] = @Id
			and OrgId = @OrgId

			return 0
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
			if isnull(@EquipId, 0) = 0 
			begin
				select @EquipId = EquipId
				from WorkOrders
				where [Id] = @WorkOrderId
				and OrgId = @OrgId
			end

			insert into WorkOrderReportedIssues(
				[OrgId], 
				[EquipId], 
				[vchDesc], 
				[WorkOrderId], 
				[LastWorkOrderId], 
				[RepairCatId], 
				[ServiceResultId], 
				[ServiceCheckId],
				[RepairItemId],
				[dtReport]
				)
			values(
				@OrgId,
				@EquipId,
				@vchDesc,
				@WorkOrderId,
				null, 
				@RepairCatId,
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
			if not exists(select 'true' from WorkOrderReportedIssues where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				if isnull(@WorkOrderId, 0) <> 0
				begin -- updating issue
					update 	 WorkOrderReportedIssues
					set 	[EquipId] = @EquipId,
						[vchDesc] = @vchDesc,
						[WorkOrderId] = @WorkOrderId,
						[LastWorkOrderId] = @LastWorkOrderId,
						[RepairCatId] = @RepairCatId,
						[ServiceResultId] = @ServiceResultId,
						[ServiceCheckId] = @ServiceCheckId,
						[RepairItemId] = @RepairItemId,
						[dtReport] = @dtReport
					where 	[Id] = @Id
					and 	OrgId = @OrgId
				end
				else
				begin -- unassign issue from order
					-- update issue and delete all data relating to him 
					-- from RepairMult. Repairs and PartsUsed
		
					select 	@WorkOrderId = isnull(WorkOrderId, 0),
						@RepairItemId = isnull(RepairItemId, 0)
					from 	WorkOrderReportedIssues
					where 	[Id] = @Id
					and 	OrgId = @OrgId
		
					if @RepairItemId <> 0
					begin
						select @IsDelete = 1
			
						if exists(select 'true' 
							from WorkOrderPMItems
							where OrgId = @OrgId
							and WorkOrderId = @WorkOrderId
							and RepairItemId = @RepairItemId
							)
						begin
							select @IsDelete = 0
						end
			
						if exists(select 'true' 
							from WorkOrderReportedIssues
							where OrgId = @OrgId
							and WorkOrderId = @WorkOrderId
							and RepairItemId = @RepairItemId
							and [Id] <> @Id
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
				
							update 	WorkOrderReportedIssues
							set 	[WorkOrderId] = null,
								[LastWorkOrderId] = @LastWorkOrderId,
								[vchDesc] = @vchDesc,
								[RepairCatId] = @RepairCatId,
								[ServiceResultId] = null,
								[ServiceCheckId] = null,
								[RepairItemId] = null
							where 	[Id] = @Id
							and 	OrgId = @OrgId
				
							delete from PartsUsed
							where OrgId = @OrgId
							and RepairId in (select RepairId from #tmp)
				
							delete from Repairs
							where OrgId = @OrgId
							and [Id] in (select RepairId from #tmp)
						end
						else
						begin
							update 	WorkOrderReportedIssues
							set 	[WorkOrderId] = null,
								[LastWorkOrderId] = @LastWorkOrderId,
								[vchDesc] = @vchDesc,
								[RepairCatId] = @RepairCatId,
								[ServiceResultId] = null,
								[ServiceCheckId] = null,
								[RepairItemId] = null
							where 	[Id] = @Id
							and 	OrgId = @OrgId
						end
					end
					else
					begin
						update 	WorkOrderReportedIssues
						set 	[WorkOrderId] = null,
							[LastWorkOrderId] = @LastWorkOrderId,
							[vchDesc] = @vchDesc,
							[RepairCatId] = @RepairCatId,
							[ServiceResultId] = null,
							[ServiceCheckId] = null,
							[RepairItemId] = null
						where 	[Id] = @Id
						and 	OrgId = @OrgId
					end
				end
				
				return 0
			end
		end
	end
	if @Action = 'D'
	begin
		if not exists(select 'true' from WorkOrderReportedIssues where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			-- delete issues and all data relating to him 
			-- from RepairMult. Repairs and PartsUsed

			select 	@WorkOrderId = isnull(WorkOrderId, 0),
				@RepairItemId = isnull(RepairItemId, 0)
			from 	WorkOrderReportedIssues
			where 	[Id] = @Id
			and 	OrgId = @OrgId

			if @RepairItemId <> 0
			begin
				select @IsDelete = 1
	
				if exists(select 'true' 
					from WorkOrderPMItems
					where OrgId = @OrgId
					and WorkOrderId = @WorkOrderId
					and RepairItemId = @RepairItemId
					)
				begin
					select @IsDelete = 0
				end
	
				if exists(select 'true' 
					from WorkOrderReportedIssues
					where OrgId = @OrgId
					and WorkOrderId = @WorkOrderId
					and RepairItemId = @RepairItemId
					and [Id] <> @Id
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
		
					delete from WorkOrderReportedIssues
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
					delete from WorkOrderReportedIssues
					where [Id] = @Id
					and OrgId = @OrgId
				end
			end
			else
			begin
				delete from WorkOrderReportedIssues
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

