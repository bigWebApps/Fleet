SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectFutureWorkOrderPMItems]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectFutureWorkOrderPMItems]
GO



CREATE  procedure sp_SelectFutureWorkOrderPMItems
	(
		@OrgId int,
		@OrderId int
	)
as
	set nocount on
	
	select 	PMI.[Id],
		convert(varchar, year(WO.dtCreated)) + '-' + 
		convert(varchar, month(WO.dtCreated)) + '-' + 
		convert(varchar, day(WO.dtCreated)) + '-' + 
		convert(varchar, WO.WorkOrderNumber) as vchWorkOrderNumber,
		case when isnull(CPMI.[Id], 0) = 0 then 'True' else 'False' end as VisibleAssign,
		S.vchDesc as vchDesc,
		RC.vchName as CategoryName,
		PMI.dtReport as ReportDate
	from WorkOrderPMItems PMI
	inner join PMSchedDetails SD
	on PMI.WorkOrderId <> @OrderId
	and isnull(PMI.WorkOrderId, 0) <> 0
	and PMI.OrgId = @OrgId
	and PMI.PMSchedDetailId = SD.[Id]
	and PMI.OrgId = SD.OrgId
	inner join WorkOrders WO
	on WO.[Id] = PMI.WorkOrderId
	and WO.OrgId = PMI.OrgId
	and WO.StatusId = 3
	and WO.EquipId in (
		select EquipId
		from WorkOrders
		where [Id] = @OrderId
		and OrgId = @OrgId
		)
	and isnull(WO.OperatorStatusId, 0) = 0
	inner join PMServices S
	on S.[Id] = SD.PMServiceId
	and S.OrgId = SD.OrgId
	left outer join RepairCats RC
	on RC.[Id] = S.RepairCatId
	and RC.OrgId = S.OrgId
	left outer join WorkOrderPMItems CPMI
	on CPMI.WorkOrderId = @OrderId
	and CPMI.OrgId = @OrgId
	and CPMI.PMSchedDetailId = PMI.PMSchedDetailId
	order by PMI.dtReport asc, RC.vchName asc





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

