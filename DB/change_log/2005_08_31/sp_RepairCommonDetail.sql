SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 9/2/2004 
-- Description: The procedure add, edit, select and delete a repair
---------------------------------------------------------------------------
ALTER procedure sp_RepairCommonDetail
	(
		@Action char(1),
		@OrgId int,
		@OrderId int,
		@RepairId int,
		@RepairDesc varchar(4000)=null output,
		@RepairItemId int=null output,
		@RepairCatId int=null output
	)
as
	set nocount on
	declare @ItemId int
	declare @CountSource int
	declare @i int
	declare @N int
	declare @tbl table(
		[Id] int identity(1, 1),
		ItemId int
		)
	if isnull(@Action, '') = 'S'
	begin
		select 	@RepairDesc = R.vchDesc,
			@RepairItemId = isnull(R.RepairItemId, 0),
			@RepairCatId  = isnull(RI.CatId, 0)
		from 	Repairs R
		left outer join RepairItems RI
		on RI.[Id] = isnull(R.RepairItemId, 0)
		and RI.OrgId = R.OrgId
		where R.[Id] = @RepairId
		and R.OrgId = @OrgId
		and R.WorkOrderId = @OrderId

		select 	@RepairDesc = isnull(@RepairDesc, ''), 
			@RepairItemId = isnull(@RepairItemId, 0),
			@RepairCatId  = isnull(@RepairCatId, 0)

		return 0
	end
	
	if isnull(@Action, '') = 'U'
	begin
		if not exists(select 'true' from Repairs where [Id] = @RepairId and OrgId = @OrgId and WorkOrderId = @OrderId)
		begin
			return -1
		end
		else
		begin
			if @RepairItemId = 0
			begin
				select @RepairItemId = null
			end

			update 	Repairs
			set 	RepairItemId = @RepairItemId,
				vchDesc = @RepairDesc
			where 	[Id] = @RepairId
			and 	OrgId = @OrgId
			and 	WorkOrderId = @OrderId
			return 0
		end
	end
	if isnull(@Action, '') = 'D'
	begin
		if not exists(select 'true' from Repairs where [Id] = @RepairId and OrgId = @OrgId and WorkOrderId = @OrderId)
		begin
			return -1
		end
		else
		begin
			insert into @tbl(ItemId)
			select isnull(ItemId, 0)
			from RepairMult
			where RepairId = @RepairId 
			and OrgId = @OrgId 
			select @i = 1, @N = scope_identity()
			while @i <= @N
			begin
				select @CountSource = count(RM.[Id])
				from RepairMult RM
				inner join @tbl tbl
				on tbl.[Id] = @i
				and RM.OrgId = @OrgId 
				and RM.ItemId = tbl.ItemId
	
				if @CountSource < 2
				begin -- processing all sources for set NULL to RepairItemId
					update 	WorkOrderReportedIssues
					set 	ServiceResultId = null,
						ServiceCheckId = null,
						RepairItemId = null
					from 	@tbl tbl, WorkOrderReportedIssues RI
					where	tbl.[Id] = @i
					and  	RI.RepairItemId = tbl.ItemId
					and 	RI.WorkOrderId = @OrderId
					and 	RI.OrgId = @OrgId
	
					update 	WorkOrderPMItems
					set 	ServiceResultId = null,
						ServiceCheckId = null,
						RepairItemId = null
					from 	@tbl tbl, WorkOrderPMItems PMI
					where	tbl.[Id] = @i
					and  	PMI.RepairItemId = tbl.ItemId
					and 	PMI.WorkOrderId = @OrderId
					and 	PMI.OrgId = @OrgId
	
					update 	WorkOrderInspectItems
					set 	ServiceResultId = null,
						ServiceCheckId = null,
						RepairItemId = null
					from 	@tbl tbl, WorkOrderInspectItems II
					where	tbl.[Id] = @i
					and  	II.RepairItemId = tbl.ItemId
					and 	II.WorkOrderId = @OrderId
					and 	II.OrgId = @OrgId
				end
				select @i = @i + 1
			end
			delete from RepairMult
			where RepairId = @RepairId 
			and OrgId = @OrgId 
			
			delete from PartsUsed 
			where RepairId = @RepairId
			and OrgId = @OrgId
			delete from Repairs
			where [Id] = @RepairId 
			and OrgId = @OrgId 
			and WorkOrderId = @OrderId
			return 0
		end
	end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

