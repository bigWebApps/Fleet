SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

alter procedure sp_SelectSourceList
	@OrgId int,
	@OrderId int,
	@RepairId int
AS
	set nocount on
	declare @ItemId int
	
	select @ItemId = isnull(RM.ItemId, 0)
	from Repairs R
	inner join RepairMult RM
	on R.OrgId = @OrgId
	and R.[Id] = @RepairId
	and R.WorkOrderId = @OrderId
	and RM.OrgId = R.OrgId
	and RM.RepairId = @RepairId

	select 	'User''s Report' as ReasonName,
		RI.vchDesc as [Name]
	from 	WorkOrderReportedIssues RI
	where	RI.WorkOrderId = @OrderId
	and 	isnull(RI.RepairItemId, 0) = @ItemId
	and 	RI.OrgId = @OrgId
	union 	all
	select 	'Preventive Maintenance' as ReasonName,
		S.vchDesc as [Name]
	from 	WorkOrderPMItems PMI
	inner join PMSchedDetails SD
	on 	PMI.WorkOrderId = @OrderId
	and 	isnull(PMI.RepairItemId, 0) = @ItemId
	and 	PMI.OrgId = @OrgId
	and 	PMI.PMSchedDetailId = SD.[Id]
	and 	PMI.OrgId = SD.OrgId
	inner join PMServices S
	on 	SD.PMServiceId = S.[Id]
	and 	SD.OrgId = S.OrgId
	union 	all
	select 	'Inspection' as ReasonName,
		II.vchDesc as [Name]
	from 	WorkOrderInspectItems WII
	inner join InspectionItems II
	on 	WII.WorkOrderId = @OrderId
	and 	isnull(WII.RepairItemId, 0) = @ItemId
	and 	WII.OrgId = @OrgId
	and 	WII.ItemId = II.[Id]
	and 	WII.OrgId = II.OrgId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

