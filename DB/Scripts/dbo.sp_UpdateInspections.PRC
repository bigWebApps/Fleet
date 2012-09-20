SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_UpdateInspections]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_UpdateInspections]
GO




----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 09/09/2005 
-- Description: The procedure add/delete inspection to the work order
---------------------------------------------------------------------------
CREATE  procedure sp_UpdateInspections
	(
		@btChecked bit,
		@OrgId int,
		@OrderId int,
		@ItemId int=null,
		@InspectSchedDetailId int
	)
AS
	set nocount on
	declare @tbl table ([Id] int identity(1,1), RepairItemId int)
	declare @tbl2 table (RepairId int)
	declare @IsDelete bit
	declare @i int, @N int, @j int, @M int
	
	if isnull(@btChecked, 0) = 0
	begin -- remove inspection or nothing
		if exists(select 'true' from WorkOrderInspections where [Id] = isnull(@ItemId, 0) and OrgId = @OrgId)
		begin -- unchecked [delete item and his sub-items]
			-- define all RepairItemIds related to the Inspection

			insert into @tbl(RepairItemId)
			select RepairItemId
			from WorkOrderInspectItems
			where WorkOrderInspectId = isnull(@ItemId, 0)
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
					and PMI.WorkOrderId = @OrderId
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
					and RI.WorkOrderId = @OrderId
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
					select @j = 1, @M = scope_identity()

					delete from RepairMult
					where OrgId = @OrgId
					and ItemId in (
						select RepairItemId
						from @tbl
						where [Id] = @i
						)

					-- deleting all repairs, if repair has other issues (or other item) 
					-- then don't delete it
					while @j <= @M
					begin
						if not exists(select 'true' 
							from RepairMult 
							where OrgId = @OrgId 
							and RepairId in (
								select RepairId
								from @tbl2
								where [Id] = @j
								)
							)
						begin
							delete from PartsUsed
							where OrgId = @OrgId
							and RepairId in (
								select RepairId
								from @tbl2
								where [Id] = @j
								)
			
							delete from Repairs
							where OrgId = @OrgId
							and [Id] in (
								select RepairId
								from @tbl2
								where [Id] = @j
								)
						end
						select @j = @j + 1
					end
				end

				select @i = @i + 1
			end

			-- delete inspection items
			delete from WorkOrderInspectItems
			where [WorkOrderInspectId] = @ItemId
			and WorkOrderId = @OrderId
			and OrgId = @OrgId

			-- delete inspection
			delete from WorkOrderInspections
			where [Id] = @ItemId
			and WorkOrderId = @OrderId
			and OrgId = @OrgId
			return 0
		end
		else -- nothing
		begin
			return -1
		end
	end
	else
	begin -- add inspection or nothing

		if not exists(select 'true' from WorkOrderInspections where [Id] = isnull(@ItemId, 0) and OrgId = @OrgId)
		begin -- checked [insert item and his sub-items]
			insert into WorkOrderInspections(
				[OrgId], 
				[WorkOrderId], 
				[InspectSchedDetailId],
				[TechId],
				[dtReport],
				[btIsProcessed]
				)
			select	@OrgId,
				@OrderId,
				@InspectSchedDetailId,
				WO.intTechId,
				getdate(),
				0
			from WorkOrders WO
			where [Id] = @OrderId
			and OrgId = @OrgId

			select @ItemId = scope_identity()

			insert into [WorkOrderInspectItems](
				[OrgId], 
				[WorkOrderId], 
				[WorkOrderInspectId], 
				[ItemId], 
				[ServiceResultId], 
				[ServiceCheckId], 
				[RepairItemId])
			select 	@OrgId,
				@OrderId,
				@ItemId,
				II.[Id],
				null,
				null,
				null
			from InspectionItems II
			inner join InspectSchedDetails ISD
			on ISD.[Id] = @InspectSchedDetailId
			and ISD.InspectionId = II.InspectId 
			and ISD.OrgId = @OrgId
			and ISD.OrgId = II.OrgId
			and II.btEnabled = 1
			order by II.InspectCatId, II.tintOrder asc

			return @ItemId
		end
		else -- nothing
		begin
			return -1
		end
	end




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

