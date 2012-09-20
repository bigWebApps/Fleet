SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER  procedure sp_SelectRepairsListFromWorkOrder
	(
		@OrgId int,
		@OrderId int,
		@CatId int,
		@vchEquipId varchar(50)=null output
	)
as
	set nocount on

	declare @ind int
	declare @EquipId int

	declare @tbl table (
		rep_id int, 
		tbl_number int default(0)
		)

	select 	@EquipId = E.[Id],
		@vchEquipId = E.vchEquipId
	from Equipments E
	inner join WorkOrders WO
	on WO.[Id] = @OrderId
	and WO.OrgId = @OrgId
	and WO.EquipId = E.[Id]
	and WO.OrgId = E.OrgId
	
	insert @tbl(rep_id)
	select ERR.RepairItemId
	from EquipReportedRepairs ERR
	inner join RepairItems RI
	on ERR.OrderId = @OrderId
	and ERR.OrgId = @OrgId
	and ERR.RepairItemId = RI.[Id]
	and ERR.OrgId = RI.OrgId

	select @ind = 0

	update @tbl
	set @ind = tbl_number = @ind + 1

	select 	tmp.tbl_number as ReportNumber,
		ERR.[Id],
		ERR.vchSpecificDesc,
		ERR.RepairItemId,
		RI.vchDesc,
		RC.vchName as CategoryName,
		RI.dtReported,
		RS.vchDesc as StatusName
	from EquipReportedRepairs ERR
	inner join RepairItems RI
	on ERR.OrderId = @OrderId
	and ERR.OrgId = @OrgId
	and ERR.RepairItemId = RI.[Id]
	and ERR.OrgId = RI.OrgId
	inner join RepairCats RC
	on RC.[Id] = RI.CatId
	and RC.OrgId = RI.OrgId
	inner join @tbl tmp
	on tmp.rep_id = ERR.RepairItemId
	inner join RepairStatus RS
	on RS.[Id] = ERR.StatusId

	if @CatId = 0
	begin -- showing the unassigned repair without filter
		select 	RI.[Id],
			RI.vchDesc,
			RC.vchName as CategoryName,
			RI.dtReported
		from RepairItems RI
		inner join RepairCats RC
		on RC.[Id] = RI.CatId
		and RI.OrgId = @OrgId
		and RC.OrgId = RI.OrgId
		where RI.[Id] not in (
			select ERR.RepairItemId
			from EquipReportedRepairs ERR
			inner join RepairItems RI2
			on ERR.OrderId = @OrderId
			and ERR.OrgId = @OrgId
			and ERR.RepairItemId = RI2.[Id]
			and ERR.OrgId = RI2.OrgId
			or (ERR.EquipId = @EquipId 
				and ERR.OrgId = @OrgId
				and ERR.StatusId = 3
				)
			)
		order by RC.vchName asc
	end 
	else
	begin -- showing the unassigned repair with Category filter
		select 	RI.[Id],
			RI.vchDesc,
			RC.vchName as CategoryName,
			RI.dtReported
		from RepairItems RI
		inner join RepairCats RC
		on RI.[CatId] = @CatId
		and RC.[Id] = RI.CatId
		and RI.OrgId = @OrgId
		and RC.OrgId = RI.OrgId
		where RI.[Id] not in (
			select ERR.RepairItemId
			from EquipReportedRepairs ERR
			inner join RepairItems RI2
			on ERR.OrderId = @OrderId
			and ERR.OrgId = @OrgId
			and RI2.[CatId] = @CatId
			and ERR.RepairItemId = RI2.[Id]
			and ERR.OrgId = RI2.OrgId
			or (ERR.EquipId = @EquipId 
				and ERR.OrgId = @OrgId
				and ERR.StatusId = 3
				)
			)
		order by RC.vchName asc	
	end 
	
	select 	ERR.[Id],
		convert(varchar, year(WO.dtCreated)) + '-' + 
		convert(varchar, month(WO.dtCreated)) + '-' + 
		convert(varchar, day(WO.dtCreated)) + '-' + 
		convert(varchar, WO.WorkOrderNumber) as vchWorkOrderNumber,
		RI.[Id] as RepairItemId,
		RI.vchDesc,
		RC.vchName as CategoryName,
		ERR.dtUpdated
	from EquipReportedRepairs ERR
	inner join Equipments E
	on ERR.EquipId = @EquipId
	and ERR.OrgId = @OrgId
	and ERR.OrderId <> @OrderId
	and ERR.StatusId = 3
	and E.[Id] = ERR.EquipId
	and E.OrgId = ERR.OrgId
	inner join RepairItems RI
	on ERR.RepairItemId = RI.[Id]
	and ERR.OrgId = RI.OrgId
	inner join RepairCats RC
	on RI.[CatId] = RC.[Id]
	inner join WorkOrders WO
	on WO.[Id] = ERR.OrderId
	and WO.OrgId = ERR.OrgId
	order by RC.vchName asc	





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

