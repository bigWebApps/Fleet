SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectFutureWorkOrderInspections]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectFutureWorkOrderInspections]
GO


----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 09/09/2005 
-- Description: The procedure select inspection list of the future work order
---------------------------------------------------------------------------
CREATE  procedure sp_SelectFutureWorkOrderInspections
	(
		@OrgId int,
		@OrderId int
	)
as
	set nocount on
	
	select 	II.[Id],
		convert(varchar, year(WO.dtCreated)) + '-' + 
		convert(varchar, month(WO.dtCreated)) + '-' + 
		convert(varchar, day(WO.dtCreated)) + '-' + 
		convert(varchar, WO.WorkOrderNumber) as vchWorkOrderNumber,
		case when isnull(CII.[Id], 0) = 0 then 'True' else 'False' end as VisibleAssign,
		I.vchName as vchDesc,
		WO.dtScheduled as ScheduledDate,
		II.dtReport as ReportDate
	from WorkOrderInspections II
	inner join InspectSchedDetails ISD
	on II.WorkOrderId <> @OrderId
	and isnull(II.WorkOrderId, 0) <> 0
	and II.OrgId = @OrgId
	and II.InspectSchedDetailId = ISD.[Id]
	and II.OrgId = ISD.OrgId
	inner join Inspections I
	on I.[Id] = ISD.InspectionId
	and I.OrgId = ISD.OrgId
	inner join WorkOrders WO
	on WO.[Id] = II.WorkOrderId
	and WO.OrgId = II.OrgId
	and WO.StatusId = 3
	and WO.EquipId in (
		select EquipId
		from WorkOrders
		where [Id] = @OrderId
		and OrgId = @OrgId
		)
	and isnull(WO.OperatorStatusId, 0) = 0
	left outer join WorkOrderInspections CII
	on CII.WorkOrderId = @OrderId
	and CII.OrgId = @OrgId
	and CII.InspectSchedDetailId = II.InspectSchedDetailId
	order by II.dtReport asc, II.InspectSchedDetailId asc




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

