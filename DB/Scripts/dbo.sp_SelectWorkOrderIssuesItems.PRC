SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectWorkOrderIssuesItems]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectWorkOrderIssuesItems]
GO



----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Last Modification Date: 06/27/2005
-- Description: Procedure is showing all issues for current work order:
-- reported Issues, PM Items and Inspections and Inspection Items
---------------------------------------------------------------------------
CREATE  procedure sp_SelectWorkOrderIssuesItems
	(
		@OrgId int,
		@OrderId int
	)
as
	set nocount on
	declare @list varchar(8000)
	declare @i int
	declare @N int
	declare @tbl table (
		tbl_id int identity(1, 1),
		tbl_ItemId int,
		tbl_list varchar(8000) default('')
		)

	insert @tbl(tbl_ItemId)
	select distinct RepairItemId 
	from (	select RI.RepairItemId
		from WorkOrderReportedIssues RI
		where RI.WorkOrderId = @OrderId
		and RI.OrgId = @OrgId
		and isnull(RI.RepairItemId, 0) <> 0
		group by RI.RepairItemId	
		union all
		select PMI.RepairItemId
		from WorkOrderPMItems PMI
		where PMI.WorkOrderId = @OrderId
		and PMI.OrgId = @OrgId
		and isnull(PMI.RepairItemId, 0) <> 0
		group by PMI.RepairItemId
		union all
		select WII.RepairItemId
		from WorkOrderInspectItems WII
		where WII.WorkOrderId = @OrderId
		and WII.OrgId = @OrgId
		and isnull(WII.RepairItemId, 0) <> 0
		group by WII.RepairItemId
		) as RepairItems
	
	select @N = scope_identity()
	select @i = 1

	while @i <= @N 
	begin
		select @list = ''
		select @list = @list + '<br>' + isnull(R.vchDesc, '')
		from @tbl t
		inner join RepairMult RM
		on t.tbl_id = @i 
		and RM.ItemId = t.tbl_ItemId
		and RM.OrgId = @OrgId
		inner join Repairs R
		on R.[Id] = RM.RepairId
		and R.OrgId = RM.OrgId
		if len(@list) > 0
		begin
			update @tbl
			set tbl_list = substring(@list, 5, len(@list)-4)
			where tbl_id = @i
		end
		select @i = @i + 1
	end

	-- reported issues 
	select 	RC.vchName as CategoryName,
		case when isnull(RI.ServiceCheckId, 0) <> 3
			then isnull(SC.vchDesc, '')
			else isnull(SC.vchDesc, '') + ' - ' + isnull(SR.vchDesc, 'Non-Serviced')
		end as SummaryName,
		RI.vchDesc as IssuesName,
		isnull(t.tbl_list, '') as RepairNotes
	from WorkOrderReportedIssues RI
	inner join RepairCats RC
	on RI.WorkOrderId = @OrderId
	and RI.OrgId = @OrgId
	and RI.RepairCatId = RC.[Id]
	and RI.OrgId = RC.OrgId
	inner join WorkOrders WO
	on WO.[Id] = RI.WorkOrderId
	and WO.OrgId = RI.OrgId
	left outer join ServiceChecks SC
	on SC.[Id] = isnull(RI.ServiceCheckId, 0)
	and SC.btInspectOnly = 0
	left outer join ServiceResults SR
	on SR.[Id] = isnull(RI.ServiceResultId, 0)
	left outer join @tbl t
	on RI.RepairItemId = t.tbl_ItemId

	-- pm items
	select 	RC.vchName as CategoryName,
		case when isnull(PMI.ServiceCheckId, 0) <> 3
			then isnull(SC.vchDesc, '')
			else isnull(SC.vchDesc, '') + ' - ' + isnull(SR.vchDesc, 'Non-Serviced')
		end as SummaryName,
		S.vchDesc as ServiceName,
		isnull(t.tbl_list, '') as RepairNotes
	from WorkOrderPMItems PMI
	inner join PMSchedDetails SD
	on PMI.WorkOrderId = @OrderId
	and PMI.OrgId = @OrgId
	and PMI.PMSchedDetailId = SD.[Id]
	and PMI.OrgId = SD.OrgId
	inner join WorkOrders WO
	on WO.[Id] = PMI.WorkOrderId
	and WO.OrgId = PMI.OrgId
	inner join PMServices S
	on S.[Id] = SD.PMServiceId
	and S.OrgId = SD.OrgId
	left outer join RepairCats RC
	on RC.[Id] = S.RepairCatId
	and RC.OrgId = S.OrgId
	left outer join ServiceChecks SC
	on SC.[Id] = isnull(PMI.ServiceCheckId, 0)
	and SC.btInspectOnly = 0
	left outer join ServiceResults SR
	on SR.[Id] = isnull(PMI.ServiceResultId, 0)
	left outer join @tbl t
	on PMI.RepairItemId = t.tbl_ItemId
	order by RC.[Id], S.[Id]

	-- inspection items 
	select 	I.vchName as InspectionName,
		IC.vchName as CategoryName,
		case when isnull(WOII.ServiceCheckId, 0) <> 3
			then isnull(SC.vchDesc, '')
			else isnull(SC.vchDesc, '') + ' - ' + isnull(SR.vchDesc, 'Non-Serviced')
		end as SummaryName,
		II.vchDesc as InspectionItemName,
		isnull(t.tbl_list, '') as RepairNotes
	from WorkOrderInspectItems WOII
	inner join WorkOrderInspections WOI
	on WOI.WorkOrderId = @OrderId
	and WOI.OrgId = @OrgId
	and WOI.[Id] = WOII.WorkOrderInspectId
	and WOI.OrgId = WOII.ORgId
	and isnull(WOII.ServiceCheckId, 0) = 3
	and isnull(WOII.ServiceResultId, 0) > 0
	inner join InspectionItems II
	on II.[Id] = WOII.ItemId
	and II.OrgId = WOII.OrgId
	inner join InspectCats IC
	on IC.[Id] = II.InspectCatId
	and IC.OrgId = II.OrgId
	inner join InspectSchedDetails ISD
	on ISD.[Id] = WOI.InspectSchedDetailId
	and ISD.OrgId = WOI.OrgId
	inner join Inspections I
	on I.[Id] = ISD.InspectionId
	and I.OrgId = ISD.OrgId
	inner join WorkOrders WO
	on WOI.WorkOrderId = WO.[Id]
	and WOI.OrgId = WO.OrgId
	left outer join ServiceChecks SC
	on SC.[Id] = isnull(WOII.ServiceCheckId, 0)
	and SC.btInspectOnly = 0
	left outer join ServiceResults SR
	on SR.[Id] = isnull(WOII.ServiceResultId, 0)
	left outer join @tbl t
	on WOII.RepairItemId = t.tbl_ItemId

	-- inspections
	select 	I.vchName as InspectionName,
		case when isnull(WOI.btIsProcessed, 0) = 0 then 'Incomplete' else 'Completed' end as StatusName
	from WorkOrderInspections WOI
	inner join InspectSchedDetails ISD
	on WOI.WorkOrderId = @OrderId
	and WOI.OrgId = @OrgId
	and ISD.[Id] = WOI.InspectSchedDetailId
	and ISD.OrgId = WOI.OrgId
	inner join Inspections I
	on I.[Id] = ISD.InspectionId
	and I.OrgId = ISD.OrgId
	inner join WorkOrders WO
	on WOI.WorkOrderId = WO.[Id]
	and WOI.OrgId = WO.OrgId




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

