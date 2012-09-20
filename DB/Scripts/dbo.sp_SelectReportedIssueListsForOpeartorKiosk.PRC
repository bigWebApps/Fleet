SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectReportedIssueListsForOpeartorKiosk]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectReportedIssueListsForOpeartorKiosk]
GO

create procedure sp_SelectReportedIssueListsForOpeartorKiosk
	(
		@OrgId int,
		@EquipId int,
		@OrderId int
	)
as
	set nocount on
	select 	RC.vchName as CategoryName,
		case when isnull(RI.WorkOrderId, 0) <> 0 then 'Assigned' else 'Unassigned' end as StatusName,
		RI.vchDesc as vchDesc,
		RI.dtReport as ReportDate
	from WorkOrderReportedIssues RI
	inner join RepairCats RC
	on RI.EquipId = @EquipId
	and (isnull(RI.WorkOrderId, 0) = @OrderId or isnull(RI.WorkOrderId, 0) = 0)
	and RI.OrgId = @OrgId
	and RI.RepairCatId = RC.[Id]
	and RI.OrgId = RC.OrgId
	order by RC.vchName asc, RI.vchDesc asc

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

