SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER procedure sp_Report_GetInspectionItems
	(
		@OrgId int,
		@OrderId int,
		@InspectId int
	)
as
	set nocount on
	declare @ind int
	declare @list varchar(50)
	declare @i int
	declare @N int
	
	declare @tbl table (
		tbl_RepairId int, 
		tbl_number int default(0)
		)
	
	declare @tbl2 table (
		tbl_id int identity(1, 1),
		tbl_ItemId int,
		tbl_list varchar(50) default('')
		)
	
	insert @tbl(tbl_RepairId)
	select [Id]
	from Repairs
	where WorkOrderId = @OrderId
	and OrgId = @OrgId
	order by [Id]
	
	select @ind = 0
	
	update @tbl
	set @ind = tbl_number = @ind + 1
	
	insert @tbl2(tbl_ItemId)
	select WII.RepairItemId
	from WorkOrderInspectItems WII
	where WII.WorkOrderId = @OrderId
	and WII.WorkOrderInspectId = @InspectId
	and WII.OrgId = @OrgId
	and isnull(WII.RepairItemId, 0) <> 0
	group by WII.RepairItemId
	select @N = scope_identity()
	select @i = 1
	while @i <= @N 
	begin
		select @list = ''
	
		select @list = @list + ', ' + cast(t1.tbl_number as varchar)
		from @tbl2 t2
		inner join RepairMult RM
		on t2.tbl_id = @i 
		and RM.ItemId = t2.tbl_ItemId
		inner join @tbl t1
		on t1.tbl_RepairId = RM.RepairId
	
		update @tbl2 
		set tbl_list = substring(@list, 3, len(@list)-2)
		where tbl_id = @i
		and len(@list) > 0
	
		select @i = @i + 1
	end
	
	select 	ItemId, 
		CatId,
		Type,
		OrderBy,
		ItemName,
		CellColor,
		BorderStyle,
		CheckStatusName,
		ResultStatusName,
		Repairs
	from (
		select 	IC.tintOrder as OrderBy,
			IC.[Id] as ItemId,
			IC.[Id] as CatId,
			0 as Type,
			IC.vchName as ItemName,
			'#CCCCCC' as CellColor,
			'None' as BorderStyle,
			'' as CheckStatusName,
			'' as ResultStatusName,
			'' as Repairs
		from InspectCats IC
		inner join InspectSchedDetails ISD
		on ISD.OrgId = @OrgId
		and IC.[InspectId] = ISD.InspectionId
		and IC.OrgId = ISD.OrgId
		inner join WorkOrderInspections WOI
		on WOI.[Id] = @InspectId
		and WOI.InspectSchedDetailId = ISD.[Id]
		and WOI.OrgId = ISD.OrgId
		and WOI.WorkOrderId = @OrderId
		union all
	 	select 	II.tintOrder as OrderBy,
			II.[Id] as ItemId,
			II.InspectCatId as CatId,
			1 as Type,
			II.vchDesc as ItemName,
			'#FFFFFF' as CellColor,
			'Solid' as BorderStyle,
			isnull(SC.vchDesc, 'Unchecked') as CheckStatusName,
			case when isnull(WII.ServiceCheckId, 0) <> 3
					then ''
					else isnull(SR.vchDesc, 'No result')
			end as ResultStatusName,
			isnull(t2.tbl_list, '') as Repairs
		from WorkOrderInspectItems WII
		inner join InspectionItems II
		on WII.WorkOrderInspectId = @InspectId
		and WII.WorkOrderId = @OrderId
		and WII.OrgId = @OrgId
		and WII.ItemId = II.[Id]
		and WII.OrgId = II.OrgId
		left outer join ServiceChecks SC
		on SC.[Id] = WII.ServiceCheckId
		left outer join ServiceResults SR
		on SR.[Id] = WII.ServiceResultId
		left outer join @tbl2 t2
		on WII.RepairItemId = t2.tbl_ItemId
		) G
	order by G.[CatId], G.Type, G.OrderBy asc

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

