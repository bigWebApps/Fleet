SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectPartsUsedForOrder]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectPartsUsedForOrder]
GO

CREATE procedure sp_SelectPartsUsedForOrder
	(
		@OrgId int,
		@OrderId int,
		@UserId int
	)
AS
	set nocount on
	declare @btEnableLink bit
	select @btEnableLink = dbo.f_IsTechnician(@UserId)
	select 	PU.[Id],
		PU.RepairId,
		@OrderId as OrderId,
		PU.intQty as Qty, 
		PU.vchStock as Stock,
		PU.vchDesc as [Desc],
		PU.dmCost as Cost,
		case when @btEnableLink = 1 and WO.StatusId <> 2 and WO.StatusId <> 3 and WO.StatusId <> 6 then 'True' else 'False' end as Access
	from	PartsUsed PU
	inner join WorkOrders WO
	on 	WO.[Id] = @OrderId
	and 	WO.OrgId = @OrgId
	where 	PU.OrgId = @OrgId
	and 	PU.RepairId in (
		select R.[Id]
		from Repairs R
		where R.WorkOrderId = @OrderId
		and R.OrgId = @OrgId
		)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

