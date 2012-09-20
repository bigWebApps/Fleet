SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER procedure sp_SelectReportedIssueListsForWorkOrder
	(
		@OrgId int,
		@OrderId int,
		@vchEquipId varchar(50)=null output
	)
as
	set nocount on
	declare @ind int
	declare @EquipId int
	declare @tbl table (
		tbl_id int, 
		tbl_number int default(0)
		)
	-- getting the Equipment Id
	select 	@EquipId = E.[Id],
		@vchEquipId = ISNULL(E.vchEquipId, '')
	from Equipments E
	inner join WorkOrders WO
	on WO.[Id] = @OrderId
	and WO.OrgId = @OrgId
	and WO.EquipId = E.[Id]
	and WO.OrgId = E.OrgId
	
	-- getting the Reported Issues list for work order, 1th table
	insert @tbl(tbl_id)
	select [Id]
	from WorkOrderReportedIssues
	where WorkOrderId = @OrderId
	and OrgId = @OrgId
	and EquipId = @EquipId

	select @ind = 0

	update @tbl
	set @ind = tbl_number = @ind + 1

	select 	tmp.tbl_number as ReportNumber,
		RI.[Id],
		RI.RepairCatId,
		RC.vchName as CategoryName,
		RI.vchDesc,
		RI.dtReport as ReportDate
	from WorkOrderReportedIssues RI
	inner join RepairCats RC
	on RI.WorkOrderId = @OrderId
	and RI.OrgId = @OrgId
	and RI.EquipId = @EquipId
	and RI.RepairCatId = RC.[Id]
	and RI.OrgId = RC.OrgId
	inner join @tbl tmp
	on tmp.tbl_id = RI.[Id]
	order by tmp.tbl_number asc, RC.vchName asc

	-- getting the old Reported Issues list for Equipment, 2th table
	select 	RI.[Id],
		case when isnull(RI.LastWorkOrderId, 0) = 0 then 
			'none'
		else	convert(varchar, year(WO.dtCreated)) + '-' + 
			convert(varchar, month(WO.dtCreated)) + '-' + 
			convert(varchar, day(WO.dtCreated)) + '-' + 
			convert(varchar, WO.WorkOrderNumber) 
		end as vchWorkOrderNumber,
		RI.vchDesc,
		RC.vchName as CategoryName,
		RI.dtReport as ReportDate
	from WorkOrderReportedIssues RI
	inner join Equipments E
	on RI.EquipId = @EquipId
	and isnull(RI.WorkOrderId, 0) = 0
	and RI.OrgId = @OrgId
	and E.[Id] = RI.EquipId
	and E.OrgId = RI.OrgId
	inner join RepairCats RC
	on RI.RepairCatId = RC.[Id]
	and RI.OrgId = RC.OrgId
	left outer join WorkOrders WO
	on WO.[Id] = isnull(RI.LastWorkOrderId, 0)
	and WO.OrgId = RI.OrgId
	order by RC.vchName asc

	select 	RI.[Id],
		convert(varchar, year(WO.dtCreated)) + '-' + 
		convert(varchar, month(WO.dtCreated)) + '-' + 
		convert(varchar, day(WO.dtCreated)) + '-' + 
		convert(varchar, WO.WorkOrderNumber) as vchWorkOrderNumber,
		RI.vchDesc,
		RC.vchName as CategoryName,
		RI.dtReport as ReportDate,
		WO.dtScheduled as ScheduledDate
	from WorkOrderReportedIssues RI
	inner join Equipments E
	on RI.EquipId = @EquipId
	and RI.WorkOrderId <> @OrderId
	and isnull(RI.WorkOrderId, 0) <> 0
	and RI.OrgId = @OrgId
	and E.[Id] = RI.EquipId
	and E.OrgId = RI.OrgId
	inner join WorkOrders WO
	on WO.[Id] = RI.WorkOrderId
	and WO.OrgId = RI.OrgId
	and WO.StatusId = 3
	and isnull(WO.OperatorStatusId, 0) = 0
	inner join RepairCats RC
	on RI.RepairCatId = RC.[Id]
	and RI.OrgId = RC.OrgId
	order by RI.dtReport asc, RC.vchName asc





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

