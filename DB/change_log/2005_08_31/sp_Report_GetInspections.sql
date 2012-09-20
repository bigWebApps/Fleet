SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Last Modification Date: 09/09/2005
-- Description: Procedure select inspections of current work order 
-- for the SQL RS reports
---------------------------------------------------------------------------
ALTER  procedure sp_Report_GetInspections
	(
		@OrgId int,
		@OrderId int
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
		tbl_InspectId int,
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
	
	insert @tbl2(tbl_InspectId)
	select WII.WorkOrderInspectId
	from WorkOrderInspectItems WII
	where WII.WorkOrderId = @OrderId
	and WII.OrgId = @OrgId
	group by WII.WorkOrderInspectId
	
	select @N = scope_identity()
	select @i = 1
	while @i <= @N 
	begin
		select @list = ''
	
		select @list = @list + ', ' + cast(t1.tbl_number as varchar)
		from @tbl t1
		inner join RepairMult RM
		on t1.tbl_RepairId = RM.RepairId
		inner join ( 
			select WII.RepairItemId
			from WorkOrderInspectItems WII
			inner join @tbl2 t2
			on t2.tbl_id = @i 
			and WII.WorkOrderInspectId = t2.tbl_InspectId
			group by WII.RepairItemId
			) G
		on RM.ItemId = G.RepairItemId
		if len(@list) > 0
		begin
			update @tbl2 
			set tbl_list = substring(@list, 3, len(@list)-2)
			where tbl_id = @i
		end
	
		select @i = @i + 1
	end
	
	select 	I.vchName as InspectionName,
		case when isnull(WOI.btIsProcessed, 0) = 0 then 'Incomplete' else 'Completed' end as StatusName,
		isnull(t2.tbl_list, '') as Repairs
	from WorkOrderInspections WOI
	inner join InspectSchedDetails ISD
	on WOI.WorkOrderId = @OrderId
	and WOI.OrgId = @OrgId
	and ISD.[Id] = WOI.InspectSchedDetailId
	and ISD.OrgId = WOI.OrgId
	inner join Inspections I
	on I.[Id] = ISD.InspectionId
	and I.OrgId = ISD.OrgId
	left join @tbl2 t2
	on t2.tbl_InspectId = WOI.[Id]
	

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

