SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER  procedure sp_RepairCommonDetail
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

	if isnull(@Action, '') = 'S'
	begin
		if not exists(select 'true' from Repairs where [Id] = @RepairId and OrgId = @OrgId and WorkOrderId = @OrderId)
		begin
			return -1
		end
		else
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
	
			return 0
		end
	end
	
	if isnull(@Action, '') = 'U'
	begin
		if not exists(select 'true' from Repairs where [Id] = @RepairId and OrgId = @OrgId and WorkOrderId = @OrderId)
		begin
			return -1
		end
		else
		begin
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
			
			select @ItemId = isnull(ItemId, 0)
			from RepairMult
			where RepairId = @RepairId 
			and OrgId = @OrgId 

			select @CountSource = count([Id])
			from RepairMult
			where ItemId = @ItemId 
			and OrgId = @OrgId 

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

			if @CountSource < 2
			begin -- processing all sources for set NULL to RepairItemId
				update 	WorkOrderReportedIssues
				set 	ServiceResultId = null,
					ServiceCheckId = null,
					RepairItemId = null
				where 	RepairItemId = @ItemId
				and 	WorkOrderId = @OrderId
				and 	OrgId = @OrgId

				update 	WorkOrderPMItems
				set 	ServiceResultId = null,
					ServiceCheckId = null,
					RepairItemId = null
				where 	RepairItemId = @ItemId
				and 	WorkOrderId = @OrderId
				and 	OrgId = @OrgId

				update 	WorkOrderInspectItems
				set 	ServiceResultId = null,
					ServiceCheckId = null,
					RepairItemId = null
				where 	RepairItemId = @ItemId
				and 	WorkOrderId = @OrderId
				and 	OrgId = @OrgId
			end

			return 0
		end
	end



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

