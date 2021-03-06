SET QUOTED_IDENTIFIER ON ਍ഀ
GO਍ഀ
SET ANSI_NULLS ON ਍ഀ
GO਍ഀ
਍ഀ
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_UpdateInspections]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)਍ഀ
drop procedure [dbo].[sp_UpdateInspections]਍ഀ
GO਍ഀ
਍ഀ
਍ഀ
਍ഀ
਍ഀ
਍ഀ
----------------------------------------------------------------------------਍ഀ
-- Author: Alexey Gavrilov਍ഀ
-- Date: 09/09/2005 ਍ഀ
-- Description: The procedure add/delete inspection to the work order਍ഀ
---------------------------------------------------------------------------਍ഀ
CREATE   procedure sp_UpdateInspections਍ഀ
	(਍ഀ
		@btChecked bit,਍ഀ
		@OrgId int,਍ഀ
		@OrderId int,਍ഀ
		@ItemId int=null,਍ഀ
		@InspectSchedDetailId int,਍ഀ
		@CurrDate datetime਍ഀ
	)਍ഀ
AS਍ഀ
	set nocount on਍ഀ
	declare @tbl table ([Id] int identity(1,1), RepairItemId int)਍ഀ
	declare @tbl2 table (RepairId int)਍ഀ
	declare @IsDelete bit਍ഀ
	declare @i int, @N int, @j int, @M int਍ഀ
	਍ഀ
	if isnull(@btChecked, 0) = 0਍ഀ
	begin -- remove inspection or nothing਍ഀ
		if exists(select 'true' from WorkOrderInspections where [Id] = isnull(@ItemId, 0) and OrgId = @OrgId)਍ഀ
		begin -- unchecked [delete item and his sub-items]਍ഀ
			-- define all RepairItemIds related to the Inspection਍ഀ
਍ഀ
			insert into @tbl(RepairItemId)਍ഀ
			select RepairItemId਍ഀ
			from WorkOrderInspectItems਍ഀ
			where WorkOrderInspectId = isnull(@ItemId, 0)਍ഀ
			and OrgId = @OrgId਍ഀ
			and isnull(RepairItemId, 0) <> 0਍ഀ
			਍ഀ
			-- processing all repairs, if repair has the other sources ਍ഀ
			-- as PM items or Issues then we don't delete this repair਍ഀ
			-- or else we delete records of RepairMult, PartsUsed and਍ഀ
			-- Repairs tables਍ഀ
			select @i = 1, @N = scope_identity()਍ഀ
			while @i <= @N਍ഀ
			begin਍ഀ
				select @IsDelete = 1਍ഀ
				if exists(select 'true' ਍ഀ
					from WorkOrderPMItems PMI਍ഀ
					inner join @tbl tmp਍ഀ
					on PMI.OrgId = @OrgId਍ഀ
					and PMI.WorkOrderId = @OrderId਍ഀ
					and PMI.RepairItemId = tmp.RepairItemId਍ഀ
					and tmp.[Id] = @i਍ഀ
					)਍ഀ
				begin਍ഀ
					select @IsDelete = 0਍ഀ
				end਍ഀ
				if exists(select 'true' ਍ഀ
					from WorkOrderReportedIssues RI਍ഀ
					inner join @tbl tmp ਍ഀ
					on RI.OrgId = @OrgId਍ഀ
					and RI.WorkOrderId = @OrderId਍ഀ
					and RI.RepairItemId = tmp.RepairItemId਍ഀ
					and tmp.[Id] = @i਍ഀ
					)਍ഀ
				begin਍ഀ
					select @IsDelete = 0਍ഀ
				end਍ഀ
਍ഀ
				if @IsDelete = 1਍ഀ
				begin -- deleting the relate records਍ഀ
					insert into @tbl2(RepairId)਍ഀ
					select RepairId਍ഀ
					from RepairMult਍ഀ
					where OrgId = @OrgId਍ഀ
					and ItemId in (਍ഀ
						select RepairItemId਍ഀ
						from @tbl਍ഀ
						where [Id] = @i਍ഀ
						)਍ഀ
					select @j = 1, @M = scope_identity()਍ഀ
਍ഀ
					delete from RepairMult਍ഀ
					where OrgId = @OrgId਍ഀ
					and ItemId in (਍ഀ
						select RepairItemId਍ഀ
						from @tbl਍ഀ
						where [Id] = @i਍ഀ
						)਍ഀ
਍ഀ
					-- deleting all repairs, if repair has other issues (or other item) ਍ഀ
					-- then don't delete it਍ഀ
					while @j <= @M਍ഀ
					begin਍ഀ
						if not exists(select 'true' ਍ഀ
							from RepairMult ਍ഀ
							where OrgId = @OrgId ਍ഀ
							and RepairId in (਍ഀ
								select RepairId਍ഀ
								from @tbl2਍ഀ
								where [Id] = @j਍ഀ
								)਍ഀ
							)਍ഀ
						begin਍ഀ
							delete from PartsUsed਍ഀ
							where OrgId = @OrgId਍ഀ
							and RepairId in (਍ഀ
								select RepairId਍ഀ
								from @tbl2਍ഀ
								where [Id] = @j਍ഀ
								)਍ഀ
			਍ഀ
							delete from Repairs਍ഀ
							where OrgId = @OrgId਍ഀ
							and [Id] in (਍ഀ
								select RepairId਍ഀ
								from @tbl2਍ഀ
								where [Id] = @j਍ഀ
								)਍ഀ
						end਍ഀ
						select @j = @j + 1਍ഀ
					end਍ഀ
				end਍ഀ
਍ഀ
				select @i = @i + 1਍ഀ
			end਍ഀ
਍ഀ
			-- delete inspection items਍ഀ
			delete from WorkOrderInspectItems਍ഀ
			where [WorkOrderInspectId] = @ItemId਍ഀ
			and WorkOrderId = @OrderId਍ഀ
			and OrgId = @OrgId਍ഀ
਍ഀ
			-- delete inspection਍ഀ
			delete from WorkOrderInspections਍ഀ
			where [Id] = @ItemId਍ഀ
			and WorkOrderId = @OrderId਍ഀ
			and OrgId = @OrgId਍ഀ
			return 0਍ഀ
		end਍ഀ
		else -- nothing਍ഀ
		begin਍ഀ
			return -1਍ഀ
		end਍ഀ
	end਍ഀ
	else਍ഀ
	begin -- add inspection or nothing਍ഀ
਍ഀ
		if not exists(select 'true' from WorkOrderInspections where [Id] = isnull(@ItemId, 0) and OrgId = @OrgId)਍ഀ
		begin -- checked [insert item and his sub-items]਍ഀ
			insert into WorkOrderInspections(਍ഀ
				[OrgId], ਍ഀ
				[WorkOrderId], ਍ഀ
				[InspectSchedDetailId],਍ഀ
				[TechId],਍ഀ
				[dtReport],਍ഀ
				[btIsProcessed]਍ഀ
਍ऀऀऀऀ⤀ഀ
਍ऀऀऀ猀攀氀攀挀琀ऀ䀀伀爀最䤀搀Ⰰഀ
਍ऀऀऀऀ䀀伀爀搀攀爀䤀搀Ⰰഀ
਍ऀऀऀऀ䀀䤀渀猀瀀攀挀琀匀挀栀攀搀䐀攀琀愀椀氀䤀搀Ⰰഀ
਍ऀऀऀऀ圀伀⸀椀渀琀吀攀挀栀䤀搀Ⰰഀ
਍ऀऀऀऀ䀀䌀甀爀爀䐀愀琀攀Ⰰഀ
਍ऀऀऀऀ　ഀ
਍ऀऀऀ昀爀漀洀 圀漀爀欀伀爀搀攀爀猀 圀伀ഀ
਍ऀऀऀ眀栀攀爀攀 嬀䤀搀崀 㴀 䀀伀爀搀攀爀䤀搀ഀ
਍ऀऀऀ愀渀搀 伀爀最䤀搀 㴀 䀀伀爀最䤀搀ഀ
਍ഀ
਍ऀऀऀ猀攀氀攀挀琀 䀀䤀琀攀洀䤀搀 㴀 猀挀漀瀀攀开椀搀攀渀琀椀琀礀⠀⤀ഀ
਍ഀ
਍ऀऀऀ椀渀猀攀爀琀 椀渀琀漀 嬀圀漀爀欀伀爀搀攀爀䤀渀猀瀀攀挀琀䤀琀攀洀猀崀⠀ഀ
਍ऀऀऀऀ嬀伀爀最䤀搀崀Ⰰ ഀ
਍ऀऀऀऀ嬀圀漀爀欀伀爀搀攀爀䤀搀崀Ⰰ ഀ
਍ऀऀऀऀ嬀圀漀爀欀伀爀搀攀爀䤀渀猀瀀攀挀琀䤀搀崀Ⰰ ഀ
਍ऀऀऀऀ嬀䤀琀攀洀䤀搀崀Ⰰ ഀ
਍ऀऀऀऀ嬀匀攀爀瘀椀挀攀刀攀猀甀氀琀䤀搀崀Ⰰ ഀ
਍ऀऀऀऀ嬀匀攀爀瘀椀挀攀䌀栀攀挀欀䤀搀崀Ⰰ ഀ
਍ऀऀऀऀ嬀刀攀瀀愀椀爀䤀琀攀洀䤀搀崀⤀ഀ
਍ऀऀऀ猀攀氀攀挀琀 ऀ䀀伀爀最䤀搀Ⰰഀ
਍ऀऀऀऀ䀀伀爀搀攀爀䤀搀Ⰰഀ
਍ऀऀऀऀ䀀䤀琀攀洀䤀搀Ⰰഀ
਍ऀऀऀऀ䤀䤀⸀嬀䤀搀崀Ⰰഀ
਍ऀऀऀऀ渀甀氀氀Ⰰഀ
਍ऀऀऀऀ渀甀氀氀Ⰰഀ
਍ऀऀऀऀ渀甀氀氀ഀ
਍ऀऀऀ昀爀漀洀 䤀渀猀瀀攀挀琀椀漀渀䤀琀攀洀猀 䤀䤀ഀ
਍ऀऀऀ椀渀渀攀爀 樀漀椀渀 䤀渀猀瀀攀挀琀匀挀栀攀搀䐀攀琀愀椀氀猀 䤀匀䐀ഀ
਍ऀऀऀ漀渀 䤀匀䐀⸀嬀䤀搀崀 㴀 䀀䤀渀猀瀀攀挀琀匀挀栀攀搀䐀攀琀愀椀氀䤀搀ഀ
਍ऀऀऀ愀渀搀 䤀匀䐀⸀䤀渀猀瀀攀挀琀椀漀渀䤀搀 㴀 䤀䤀⸀䤀渀猀瀀攀挀琀䤀搀 ഀ
਍ऀऀऀ愀渀搀 䤀匀䐀⸀伀爀最䤀搀 㴀 䀀伀爀最䤀搀ഀ
਍ऀऀऀ愀渀搀 䤀匀䐀⸀伀爀最䤀搀 㴀 䤀䤀⸀伀爀最䤀搀ഀ
਍ऀऀऀ愀渀搀 䤀䤀⸀戀琀䔀渀愀戀氀攀搀 㴀 ㄀ഀ
਍ऀऀऀ漀爀搀攀爀 戀礀 䤀䤀⸀䤀渀猀瀀攀挀琀䌀愀琀䤀搀Ⰰ 䤀䤀⸀琀椀渀琀伀爀搀攀爀 愀猀挀ഀ
਍ഀ
਍ऀऀऀ爀攀琀甀爀渀 䀀䤀琀攀洀䤀搀ഀ
਍ऀऀ攀渀搀ഀ
਍ऀऀ攀氀猀攀 ⴀⴀ 渀漀琀栀椀渀最ഀ
਍ऀऀ戀攀最椀渀ഀ
਍ऀऀऀ爀攀琀甀爀渀 ⴀ㄀ഀ
਍ऀऀ攀渀搀ഀ
਍ऀ攀渀搀ഀ
਍ഀ
਍ഀ
਍ഀ
਍ഀ
਍ഀ
਍䜀伀ഀ
਍匀䔀吀 儀唀伀吀䔀䐀开䤀䐀䔀一吀䤀䘀䤀䔀刀 伀䘀䘀 ഀ
਍䜀伀ഀ
਍匀䔀吀 䄀一匀䤀开一唀䰀䰀匀 伀一 ഀ
਍䜀伀ഀ
਍ഀ
਍�