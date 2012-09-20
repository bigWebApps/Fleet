SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectReportedIssueListsForEquipment]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectReportedIssueListsForEquipment]
GO

CREATE  procedure sp_SelectReportedIssueListsForEquipment
	(
		@OrgId int,
		@EquipId int
	)
as
	set nocount on
	-- Assigned issues list
	select 	RI.[Id],
		WO.[Id] as OrderId,
		RC.vchName as Caterogy,
		RI.vchDesc as [Name],
		RI.dtReport as ReportDate,
		convert(varchar, year(WO.dtCreated)) + '-' + convert(varchar, month(WO.dtCreated)) + '-' + convert(varchar, day(WO.dtCreated)) + '-' + convert(varchar, WO.WorkOrderNumber) as WorkOrderNumber,
		WOS.vchColor as StatusColor,
		WOS.vchStatus as Status,
		isnull(WOOS.vchStatus, '') as OperatorStatusName,
		isnull(WOOS.vchColor, 'lightgrey') as OperatorColor
	from WorkOrderReportedIssues RI
	inner join RepairCats RC
	on RI.EquipId = @EquipId
	and RI.OrgId = @OrgId
	and RI.RepairCatId = RC.[Id]
	and RI.OrgId = RC.OrgId
	inner join WorkOrders WO
	on isnull(RI.WorkOrderId, 0) = WO.[Id]
	and RI.OrgId = WO.OrgId
	inner join WorkOrderStatus WOS
	on WO.StatusId = WOS.[Id]
	left outer join WorkOrderOperatorStatus WOOS
	on WO.OperatorStatusId = WOOS.[Id]
	order by WO.[Id] asc, RC.vchName asc, RI.vchDesc asc
	-- Unassinged issues list
	select 	RI.[Id],
		RC.vchName as Caterogy,
		RI.vchDesc as [Name],
		RI.dtReport as ReportDate
	from WorkOrderReportedIssues RI
	inner join RepairCats RC
	on RI.EquipId = @EquipId
	and isnull(RI.WorkOrderId, 0) = 0
	and RI.OrgId = @OrgId
	and RI.RepairCatId = RC.[Id]
	and RI.OrgId = RC.OrgId
	order by RC.vchName asc, RI.vchDesc asc

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

