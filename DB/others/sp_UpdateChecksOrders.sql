SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER PROCEDURE sp_UpdateChecksOrders
	(
		@OrgId int,
		@OrderId int,
		@ItemId int,
		@vchTypeService varchar(25),
		@ServiceCheckId int,
		@ServiceResultId int=null,
		@CurrentDate datetime,
		@RepairId int=null output
	)
AS
	set nocount on

	declare @MultItemId int
	declare @RepairItemId int
	declare @IsDelete bit
	declare @i int
	declare @N int

	create table #tmp(
		[Id] int identity(1, 1), 
		RepairId int
		)

	if isnull(@vchTypeService, '') = 'PMI' -- update WorkOrderPMItems
	begin
		if not exists(select 'true' from WorkOrderPMItems where [Id] = @ItemId and OrgId = @OrgId and WorkOrderId = @OrderId)
		begin
			return -1
		end
		else
		begin
--			begin transaction

			select @RepairItemId = isnull(RepairItemId, 0)
			from WorkOrderPMItems 
			where [Id] = @ItemId 
			and OrgId = @OrgId 
			and WorkOrderId = @OrderId

			if isnull(@ServiceResultId, 0) > 0
			begin -- if Service result is there then 

				if isnull(@RepairItemId, 0) = 0
				begin	--- if repair isn't exists then insert record into Repairs
					if isnull(@RepairId, 0) = 0 
					begin -- if @RepairId equal 0 then we add a new Repair and RepairMult record

						insert into Repairs(
							OrgId,
							RepairItemId,
							WorkOrderId,
							vchDesc
							)
						values( 
							@OrgId,
							null,
							@OrderId,
							''
							)
						select @RepairId = scope_identity()
	
						select @MultItemId = max(ItemId) + 1
						from RepairMult
						where OrgId = @OrgId
	
						insert into [RepairMult](
							[OrgId], 
							[ItemId], 
							[RepairId]
							)
						values(
							@OrgId,
							@MultItemId,
							@RepairId
							)
					end
					else
					begin -- else we modify the RepairItemId column of WorkOrderPMItems table
						select top 1 @MultItemId = ItemId
						from RepairMult
						where OrgId = @OrgId
						and RepairId = @RepairId

					end

					select @RepairItemId = @MultItemId
				end
				else
				begin
					select top 1 @RepairId = RepairId
					from RepairMult
					where ItemId = @RepairItemId
					and OrgId = @OrgId 
				end
			end
			else -- else to delete recors from RepairMult, Repairs and PartsUsed tables
			begin
				-- if the deleting repair has relate to an other PM items, Issues, and Inspection Items 
				-- then don't delete repair and only update this PM items
				select @IsDelete = 1

				if exists(select 'true' 
					from WorkOrderPMItems
					where OrgId = @OrgId
					and WorkOrderId = @OrderId
					and RepairItemId = @RepairItemId
					and [Id] <> @ItemId
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

					select @i = 1, @N = scope_identity()

					delete from RepairMult
					where ItemId = @RepairItemId
					and OrgId = @OrgId
					
					-- deleting all repairs, if repair has other issues (or other item) 
					-- then don't delete it
					while @i <= @N
					begin
						if not exists(select 'true' 
							from RepairMult 
							where OrgId = @OrgId 
							and RepairId in (
								select RepairId
								from #tmp
								where [Id] = @i
								)
							)
						begin
							delete from PartsUsed
							where OrgId = @OrgId
							and RepairId in (
								select RepairId
								from #tmp
								where [Id] = @i
								)
			
							delete from Repairs
							where OrgId = @OrgId
							and [Id] in (
								select RepairId
								from #tmp
								where [Id] = @i
								)
						end
						select @i = @i + 1
					end
				end

				select @RepairItemId = null
			end

			-- updating the main table
			update 	WorkOrderPMItems
			set 	ServiceCheckId = @ServiceCheckId,
				ServiceResultId = @ServiceResultId,
				RepairItemId = @RepairItemId
			where 	[Id] = @ItemId 
			and 	OrgId = @OrgId
			and 	WorkOrderId = @OrderId

			-- in history table is keeping the last check of detail
			-- if the record already there then editing else adding

			if not exists(select 'true' 
				from EquipPMHistory EH 
				inner join WorkOrderPMItems PMI 
				on 	PMI.[Id] = @ItemId 
				and 	PMI.OrgId = @OrgId
				and 	PMI.WorkOrderId = @OrderId
				and 	EH.WorkOrderid = PMI.WorkOrderId
				and 	EH.OrgId = PMI.OrgId
				and 	EH.PMSchedDetailId = PMI.PMSchedDetailId
				)
			begin -- insert history
				insert into EquipPMHistory (
					OrgId, 
					EquipId,
					dtDate,
					PMSchedDetailId,
					dmUnits,
					WorkOrderId
					)
				select 	@OrgId,
					WO.EquipId,
					@CurrentDate,
					PMI.PMSchedDetailId,
					WO.dmMileage,
					@OrderId
				from 	WorkOrders WO
				inner join WorkOrderPMItems PMI
				on 	WO.[Id] = @OrderId
				and 	WO.OrgId = @OrgId
				and 	PMI.WorkOrderId = WO.[Id]
				and  	PMI.OrgId = WO.OrgId
				and 	PMI.[Id] = @ItemId
			end
			else
			begin -- update history
				update 	EquipPMHistory
				set 	dtDate = @CurrentDate,
					dmUnits = WO.dmMileage
				from 	WorkOrders WO
				inner join WorkOrderPMItems PMI
				on 	WO.[Id] = @OrderId
				and 	WO.OrgId = @OrgId
				and 	PMI.WorkOrderId = WO.[Id]
				and  	PMI.OrgId = WO.OrgId
				and 	PMI.[Id] = @ItemId
				where 	EquipPMHistory.EquipId = WO.Equipid
				and	EquipPMHistory.OrgId = WO.OrgId
				and	EquipPMHistory.PMSchedDetailId = PMI.PMSchedDetailId
				and 	EquipPMHistory.WorkOrderId = PMI.WorkOrderId
			end
/*			
			if @@error <> 0 
			begin
				rollback
			end
			else
			begin
				commit
			end
*/
			return 0
		end
	end
	if isnull(@vchTypeService, '') = 'RI' -- update WorkOrderReportedIssues
	begin
		if not exists(select 'true' from WorkOrderReportedIssues where [Id] = @ItemId and OrgId = @OrgId and WorkOrderId = @OrderId)
		begin
			return -1
		end
		else
		begin
--			begin transaction 

			select 	@RepairItemId = isnull(RepairItemId, 0)
			from 	WorkOrderReportedIssues
			where 	[Id] = @ItemId 
			and 	OrgId = @OrgId
			and 	WorkOrderId = @OrderId

			--- insert record into Repairs
			if isnull(@ServiceResultId, 0) > 0
			begin	-- if Service result is there then 
				if isnull(@RepairItemId, 0) = 0
				begin	--- if repair isn't exists then insert record into Repairs
					if isnull(@RepairId, 0) = 0 
					begin -- if @RepairId equal 0 then we add a new Repair and RepairMult record

						insert into Repairs(
							OrgId,
							RepairItemId,
							WorkOrderId,
							vchDesc
							)
						values( 
							@OrgId,
							null,
							@OrderId,
							''
							)
						select @RepairId = scope_identity()
	
						select @MultItemId = max(ItemId) + 1
						from RepairMult
						where OrgId = @OrgId
	
						insert into [RepairMult](
							[OrgId], 
							[ItemId], 
							[RepairId]
							)
						values(
							@OrgId,
							@MultItemId,
							@RepairId
							)
					end
					else
					begin -- else we modify the RepairItemId column of WorkOrderPMItems table
						select top 1 @MultItemId = ItemId
						from RepairMult
						where OrgId = @OrgId
						and RepairId = @RepairId
					end

					select @RepairItemId = @MultItemId
				end
				else
				begin
					select top 1 @RepairId = RepairId
					from RepairMult
					where ItemId = @RepairItemId
					and OrgId = @OrgId 
				end 
			end
			else  -- else to delete recors from RepairMult, Repairs and PartsUsed tables
			begin
				-- if the deleting repair has relate to an other PM items, Issues, and Inspection Items 
				-- then don't delete repair and only update this PM items
				select @IsDelete = 1

				if exists(select 'true' 
					from WorkOrderPMItems
					where OrgId = @OrgId
					and WorkOrderId = @OrderId
					and RepairItemId = @RepairItemId
					)
				begin
					select @IsDelete = 0
				end

				if exists(select 'true' 
					from WorkOrderReportedIssues
					where OrgId = @OrgId
					and WorkOrderId = @OrderId
					and RepairItemId = @RepairItemId
					and [Id] <> @ItemId
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

					select @i = 1, @N = scope_identity()

					delete from RepairMult
					where ItemId = @RepairItemId
					and OrgId = @OrgId
					
					-- deleting all repairs, if repair has other issues (or other item) 
					-- then don't delete it
					while @i <= @N
					begin
						if not exists(select 'true' 
							from RepairMult 
							where OrgId = @OrgId 
							and RepairId in (
								select RepairId
								from #tmp
								where [Id] = @i
								)
							)
						begin
							delete from PartsUsed
							where OrgId = @OrgId
							and RepairId in (
								select RepairId
								from #tmp
								where [Id] = @i
								)
			
							delete from Repairs
							where OrgId = @OrgId
							and [Id] in (
								select RepairId
								from #tmp
								where [Id] = @i
								)
						end
						select @i = @i + 1
					end
				end

				select @RepairItemId = null
			end

			-- update main info
			update WorkOrderReportedIssues
			set 	ServiceCheckId = @ServiceCheckId,
				ServiceResultId = @ServiceResultId,
				RepairItemId = @RepairItemId
			where [Id] = @ItemId
			and OrgId = @OrgId
			and WorkOrderId = @OrderId
/*
			if @@error <> 0 
			begin
				rollback
			end
			else
			begin
				commit
			end
*/
			return 0

		end
	end

	if isnull(@vchTypeService, '') = 'II' -- update WorkOrderInpectionItems
	begin
		if not exists(select 'true' from WorkOrderInspectItems where [Id] = @ItemId and OrgId = @OrgId and WorkOrderId = @OrderId)
		begin
			return -1
		end
		else
		begin

			select 	@RepairItemId = isnull(RepairItemId, 0)
			from 	WorkOrderInspectItems
			where 	[Id] = @ItemId 
			and 	OrgId = @OrgId
			and 	WorkOrderId = @OrderId

			--- insert record into Repairs
			if isnull(@ServiceResultId, 0) > 0
			begin	-- if Service result is there then 
				if isnull(@RepairItemId, 0) = 0
				begin	--- if repair isn't exists then insert record into Repairs
					if isnull(@RepairId, 0) = 0 
					begin -- if @RepairId equal 0 then we add a new Repair and RepairMult record

						insert into Repairs(
							OrgId,
							RepairItemId,
							WorkOrderId,
							vchDesc
							)
						values( 
							@OrgId,
							null,
							@OrderId,
							''
							)
						select @RepairId = scope_identity()
	
						select @MultItemId = max(ItemId) + 1
						from RepairMult
						where OrgId = @OrgId
	
						insert into [RepairMult](
							[OrgId], 
							[ItemId], 
							[RepairId]
							)
						values(
							@OrgId,
							@MultItemId,
							@RepairId
							)
					end
					else
					begin -- else we modify the RepairItemId column of WorkOrderPMItems table
						select top 1 @MultItemId = ItemId
						from RepairMult
						where OrgId = @OrgId
						and RepairId = @RepairId
					end

					select @RepairItemId = @MultItemId
				end
				else
				begin
					select top 1 @RepairId = RepairId
					from RepairMult
					where ItemId = @RepairItemId
					and OrgId = @OrgId 
				end 
			end
			else  -- else to delete recors from RepairMult, Repairs and PartsUsed tables
			begin
				-- if the deleting repair has relate to an other PM items, Issues, and Inspection Items 
				-- then don't delete repair and only update this Inspection Items
				select @IsDelete = 1

				if exists(select 'true' 
					from WorkOrderPMItems
					where OrgId = @OrgId
					and WorkOrderId = @OrderId
					and RepairItemId = @RepairItemId
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
					and [Id] <> @ItemId
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

					select @i = 1, @N = scope_identity()

					delete from RepairMult
					where ItemId = @RepairItemId
					and OrgId = @OrgId
					
					-- deleting all repairs, if repair has other issues (or other item) 
					-- then don't delete it
					while @i <= @N
					begin
						if not exists(select 'true' 
							from RepairMult 
							where OrgId = @OrgId 
							and RepairId in (
								select RepairId
								from #tmp
								where [Id] = @i
								)
							)
						begin
							delete from PartsUsed
							where OrgId = @OrgId
							and RepairId in (
								select RepairId
								from #tmp
								where [Id] = @i
								)
			
							delete from Repairs
							where OrgId = @OrgId
							and [Id] in (
								select RepairId
								from #tmp
								where [Id] = @i
								)
						end
						select @i = @i + 1
					end
				end

				select @RepairItemId = null
			end

			-- update main info
			update 	WorkOrderInspectItems
			set 	ServiceCheckId = @ServiceCheckId,
				ServiceResultId = @ServiceResultId,
				RepairItemId = @RepairItemId
			where [Id] = @ItemId
			and OrgId = @OrgId
			and WorkOrderId = @OrderId

			return 0
		end
	end

	drop table #tmp

	return -2


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

