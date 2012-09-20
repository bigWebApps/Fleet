SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_RepairExDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_RepairExDetail]
GO

CREATE procedure sp_RepairExDetail
	(
		@OrgId int,
		@OrderId int,
		@vchType varchar(25),
		@ItemId int,
		@RepairId int=null output,
		@RepairDesc varchar(4000)=null output,
		@RepairItemId int=null output,
		@RepairCatId int=null output
	)
as
	set nocount on
	-- @vchType = 'RI', 'PMI', 'II'
	if isnull(@vchType, '') = 'RI'
	begin
		if not exists(select 'true' from WorkOrderReportedIssues where [Id] = @ItemId and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			select top 1 @RepairId = RM.RepairId
			from RepairMult RM
			inner join WorkOrderReportedIssues  RI
			on RI.[Id] = @ItemId
			and RI.OrgId = @OrgId
			and RI.RepairItemId = RM.ItemId
			and RI.OrgId = RM.OrgId
			order by RM.[Id] desc
		end
	end
	if isnull(@vchType, '') = 'PMI'
	begin
		if not exists(select 'true' from WorkOrderPMItems where [Id] = @ItemId and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			select top 1 @RepairId = RM.RepairId
			from RepairMult RM
			inner join WorkOrderPMItems PMI
			on PMI.[Id] = @ItemId
			and PMI.OrgId = @OrgId
			and PMI.RepairItemId = RM.ItemId
			and PMI.OrgId = RM.OrgId
			order by RM.[Id] desc
		end
	end
	if isnull(@vchType, '') = 'II'
	begin
		if not exists(select 'true' from WorkOrderInspectItems where [Id] = @ItemId and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			select top 1 @RepairId = RM.RepairId
			from RepairMult RM
			inner join WorkOrderInspectItems II
			on II.[Id] = @ItemId
			and II.OrgId = @OrgId
			and II.RepairItemId = RM.ItemId
			and II.OrgId = RM.OrgId
			order by RM.[Id] desc
		end
	end
	if isnull(@RepairId, 0) <> 0 
	begin
		select 	@RepairDesc = R.vchDesc,
			@RepairItemId = isnull(R.RepairItemId, 0),
			@RepairCatId = isnull(RI.CatId, 0)
		from 	Repairs R
		left outer join RepairItems RI
		on RI.[Id] = isnull(R.RepairItemId, 0)
		and RI.OrgId = R.OrgId
		where R.[Id] = @RepairId
		and R.OrgId = @OrgId
		and R.WorkOrderId = @OrderId
	end
	else
	begin
		select 	@RepairId = 0, 
			@RepairDesc = '', 
			@RepairItemId = 0, 
			@RepairCatId  = 0
	end
	return 0
	

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

