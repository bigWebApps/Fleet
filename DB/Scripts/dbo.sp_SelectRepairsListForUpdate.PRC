SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectRepairsListForUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectRepairsListForUpdate]
GO

CREATE procedure sp_SelectRepairsListForUpdate
	@OrgId int,
	@OrderId int,
	@vchType varchar(25),
	@ItemId int
as
	set nocount on
	if @vchType = 'RI'
	begin
		select 	R.[Id],
			case when isnull(RM.ItemId, 0) = isnull(WORI.RepairItemId, -1) then 'True' else 'False' end as Associated,
			isnull(RC.vchName, '') as CatName,
			isnull(RI.vchDesc, '') as ItemName,
			isnull(R.vchDesc, '') as RepairDesc
		from Repairs R
		inner join WorkOrders WO
		on R.WorkOrderId = @OrderId
		and R.OrgId = @OrgId
		and WO.[Id] = R.WorkOrderId
		and WO.OrgId = R.OrgId
		left outer join RepairItems RI
		on isnull(R.RepairItemId, 0) = RI.[Id]
		and R.OrgId = RI.OrgId
		left outer join RepairCats RC
		on RC.[Id] = RI.CatId
		and RC.OrgId = RI.OrgId
		left outer join WorkOrderReportedIssues WORI
		on WORI.WorkOrderId = @OrderId
		and WORI.[Id] = @ItemId 
		and WORI.OrgId = R.OrgId
		left outer join RepairMult RM
		on RM.RepairId = R.[Id]
		and RM.ItemId = WORI.RepairItemId
		and RM.OrgId = R.OrgId
		order by RC.[Id], RI.[Id], R.[Id] asc
	end
	if @vchType = 'PMI'
	begin
		select 	R.[Id],
			case when isnull(RM.ItemId, 0) = isnull(WOPMI.RepairItemId, -1) then 'True' else 'False' end as Associated,
			isnull(RC.vchName, '') as CatName,
			isnull(RI.vchDesc, '') as ItemName,
			isnull(R.vchDesc, '') as RepairDesc
		from Repairs R
		inner join WorkOrders WO
		on R.WorkOrderId = @OrderId
		and R.OrgId = @OrgId
		and WO.[Id] = R.WorkOrderId
		and WO.OrgId = R.OrgId
		left outer join RepairItems RI
		on isnull(R.RepairItemId, 0) = RI.[Id]
		and R.OrgId = RI.OrgId
		left outer join RepairCats RC
		on RC.[Id] = RI.CatId
		and RC.OrgId = RI.OrgId
		left outer join WorkOrderPMItems WOPMI
		on WOPMI.WorkOrderId = @OrderId
		and WOPMI.[Id] = @ItemId 
		and WOPMI.OrgId = R.OrgId
		left outer join RepairMult RM
		on RM.RepairId = R.[Id]
		and RM.ItemId = WOPMI.RepairItemId
		and RM.OrgId = R.OrgId
		order by RC.[Id], RI.[Id], R.[Id] asc
	end
	if @vchType = 'II'
	begin
		select R.[Id],
			case when isnull(RM.ItemId, 0) = isnull(WOII.RepairItemId, -1) then 'True' else 'False' end as Associated,
			isnull(RC.vchName, '') as CatName,
			isnull(RI.vchDesc, '') as ItemName,
			isnull(R.vchDesc, '') as RepairDesc
		from Repairs R
		inner join WorkOrders WO
		on R.WorkOrderId = @OrderId
		and R.OrgId = @OrgId
		and WO.[Id] = R.WorkOrderId
		and WO.OrgId = R.OrgId
		left outer join RepairItems RI
		on isnull(R.RepairItemId, 0) = RI.[Id]
		and R.OrgId = RI.OrgId
		left outer join RepairCats RC
		on RC.[Id] = RI.CatId
		and RC.OrgId = RI.OrgId
		left outer join WorkOrderInspectItems WOII
		on WOII.WorkOrderId = @OrderId
		and WOII.[Id] = @ItemId 
		and WOII.OrgId = R.OrgId
		left outer join RepairMult RM
		on RM.RepairId = R.[Id]
		and WOII.RepairItemId = RM.ItemId
		and RM.OrgId = R.OrgId
		order by RC.[Id], RI.[Id], R.[Id] asc
	end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

