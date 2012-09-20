SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER   procedure sp_SelectRepairsList
	@OrgId int,
	@OrderId int,
	@UserId int
as
	set nocount on

	declare @btEnableLink bit

	select @btEnableLink = dbo.f_IsTechnician(@UserId)

	select 	R.[Id],
		R.WorkOrderId as OrderId,
		isnull(RC.vchName, '') as CatName,
		isnull(RI.vchDesc, '') as ItemName,
		isnull(R.vchDesc, '') as RepairDesc,
		case when @btEnableLink = 1 and WO.StatusId <> 2 and WO.StatusId <> 3 and WO.StatusId <> 6 then 'True' else 'False' end as Access
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
	
	







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

