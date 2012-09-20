SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectRepairsList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectRepairsList]
GO

CREATE   procedure sp_SelectRepairsList
	@OrgId int,
	@OrderId int,
	@UserId int
as
	set nocount on
	declare @btEnableLink bit
	select @btEnableLink = dbo.f_IsTechnician(@UserId)
	if exists(select 'true' 
		from WorkOrders 
		where [Id] = @OrderId 
		and OrgId = @OrgId
		and StatusId <> 2 
		and StatusId <> 3 
		and StatusId <> 6 
		)
	begin
		select @btEnableLink = 1
	end
	else
	begin
		select @btEnableLink = 0
	end
	select 	R.[Id],
		R.WorkOrderId as OrderId,
		isnull(RC.vchName, '') as CatName,
		isnull(RI.vchDesc, '') as ItemName,
		isnull(R.vchDesc, '') as RepairDesc,
		case when @btEnableLink = 1
			then 'True' 
			else 'False' 
		end as Access,
		case when @btEnableLink = 1 
			and not exists(select 'true' 
				from RepairMult RM 
				inner join WorkOrderInspectItems II
				on RM.RepairId = R.[Id]
				and RM.OrgId = R.OrgId
				and II.RepairItemId = RM.ItemId
				and II.OrgId = RM.OrgId
				inner join WorkOrderInspections I
				on I.[Id] = II.WorkOrderInspectId
				and I.OrgId = II.OrgId
				and I.btIsProcessed = 1
				)
			then 'True'
			else 'False'
		end as EnableRemoveButton,
		case when @btEnableLink = 1 
			and not exists(select 'true' 
				from RepairMult RM 
				inner join WorkOrderInspectItems II
				on RM.RepairId = R.[Id]
				and RM.OrgId = R.OrgId
				and II.RepairItemId = RM.ItemId
				and II.OrgId = RM.OrgId
				inner join WorkOrderInspections I
				on I.[Id] = II.WorkOrderInspectId
				and I.OrgId = II.OrgId
				and I.btIsProcessed = 1
				)
			then 'javascript:return confirm("Are you sure that you want to delete this item?")'
			else ''
		end as RemoveConfirmation
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

