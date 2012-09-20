SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER procedure sp_WorkOrderInspectionsDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int output,
		@WorkOrderId int=null output,
		@InspectId int=null output,
		@TechId int=null output,
		@dtReport datetime=null output,
		@btIsProcessed bit=null output
	)
as
	set nocount on
	
	declare @tbl table ([Id] int identity(1,1), RepairItemId int)
	declare @tbl2 table (RepairId int)
	declare @IsDelete bit
	declare @i int, @N int

	if @Action = 'S'
	begin
		if not exists(select 'true' from WorkOrderInspections where OrgId = @OrgId and [Id] = @Id)
		begin
			return -1
		end
		else
		begin
			select 	@WorkOrderId = WorkOrderId,
				@InspectId = InspectId,
				@TechId = TechId,
				@dtReport = dtReport,
				@btIsProcessed = btIsProcessed
			from WorkOrderInspections
			where [Id] = @Id
			and OrgId = @OrgId

			return 0
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
			insert into WorkOrderInspections(
				[OrgId], 
				[WorkOrderId], 
				[InspectId],
				[TechId],
				[dtReport],
				[btIsProcessed]
				)
			select	@OrgId,
				@WorkOrderId,
				@InspectId,
				WO.intTechId,
				getdate(),
				0
			from WorkOrders WO
			where [Id] = @WorkOrderId
			and OrgId = @OrgId

			select @Id = scope_identity()

			insert into [WorkOrderInspectItems](
				[OrgId], 
				[WorkOrderId], 
				[WorkOrderInspectId], 
				[ItemId], 
				[ServiceResultId], 
				[ServiceCheckId], 
				[RepairItemId]
				)
			select 	@OrgId,
				@WorkOrderId,
				@Id,
				II.[Id],
				null,
				null,
				null
			from InspectionItems II
			where II.InspectId = @InspectId
			and II.OrgId = @OrgId
			and II.btEnabled = 1
			order by II.InspectCatId, II.tintOrder asc

			return 0
		end
		else
		begin -- update
			if not exists(select 'true' from WorkOrderInspections where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				update 	[WorkOrderInspections]
				set 	[WorkOrderId] = @WorkOrderId,
					[InspectId] = @InspectId,
					[TechId] = @TechId,
					[dtReport] = @dtReport,
					[btIsProcessed] = @btIsProcessed
				where 	[Id] = @Id
				and 	OrgId = @OrgId
				
				return 0
			end
		end
	end
	if @Action = 'D'
	begin
		if not exists(select 'true' from WorkOrderInspections where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			-- define all RepairItemIds related to the Inspection
			insert into @tbl(RepairItemId)
			select RepairItemId
			from WorkOrderInspectItems
			where WorkOrderInspectId = isnull(@Id, 0)
			and OrgId = @OrgId
			and isnull(RepairItemId, 0) <> 0
			
			-- processing all repairs, if repair has the other sources 
			-- as PM items or Issues then we don't delete this repair
			-- or else we delete records of RepairMult, PartsUsed and
			-- Repairs tables
			select @i = 1, @N = scope_identity()
			while @i <= @N
			begin
				select @IsDelete = 1

				if exists(select 'true' 
					from WorkOrderPMItems PMI
					inner join @tbl tmp
					on PMI.OrgId = @OrgId
					and PMI.WorkOrderId = @WorkOrderId
					and PMI.RepairItemId = tmp.RepairItemId
					and tmp.[Id] = @i
					)
				begin
					select @IsDelete = 0
				end

				if exists(select 'true' 
					from WorkOrderReportedIssues RI
					inner join @tbl tmp 
					on RI.OrgId = @OrgId
					and RI.WorkOrderId = @WorkOrderId
					and RI.RepairItemId = tmp.RepairItemId
					and tmp.[Id] = @i
					)
				begin
					select @IsDelete = 0
				end

				if @IsDelete = 1
				begin -- deleting the relate records
					insert into @tbl2(RepairId)
					select RepairId
					from RepairMult
					where OrgId = @OrgId
					and ItemId in (
						select RepairItemId
						from @tbl
						where [Id] = @i
						)

					delete from RepairMult
					where OrgId = @OrgId
					and ItemId in (
						select RepairItemId
						from @tbl
						where [Id] = @i
						)

					delete from PartsUsed
					where OrgId = @OrgId
					and RepairId in (
						select RepairId
						from @tbl2
						)

					delete from Repairs
					where OrgId = @OrgId
					and [Id] in (
						select RepairId
						from @tbl2
						)

					delete from @tbl
				end
				
				select @i = @i + 1
			end

			-- delete inspection items
			delete from WorkOrderInspectItems
			where [WorkOrderInspectId] = @Id
			and WorkOrderId = @WorkOrderId
			and OrgId = @OrgId

			-- delete inspection
			delete from WorkOrderInspections
			where [Id] = @Id
			and WorkOrderId = @WorkOrderId
			and OrgId = @OrgId

			return 0
		end
	end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

