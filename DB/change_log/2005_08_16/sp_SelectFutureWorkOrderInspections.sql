SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


create procedure dbo.sp_SelectFutureWorkOrderInspections
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
		II.dtReport as ReportDate
	from WorkOrderInspections II
	inner join Inspections I
	on II.WorkOrderId <> @OrderId
	and isnull(II.WorkOrderId, 0) <> 0
	and II.OrgId = @OrgId
	and II.InspectId = I.[Id]
	and II.OrgId = I.OrgId
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
	and CII.InspectId = II.InspectId
	order by II.dtReport asc, II.InspectId asc


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

