SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Report_GetPMItems]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Report_GetPMItems]
GO


CREATE     procedure sp_Report_GetPMItems
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
	select PMI.RepairItemId
	from WorkOrderPMItems PMI
	where PMI.WorkOrderId = @OrderId
	and PMI.OrgId = @OrgId
	and isnull(PMI.RepairItemId, 0) <> 0
	group by PMI.RepairItemId
	
	select @N = scope_identity()
	select @i = 1
	
	while @i <= @N 
	begin
		select @list = ''
	
		select @list = @list + ', ' + cast(t1.tbl_number as varchar)
		from @tbl2 t2, RepairMult RM
		inner join @tbl t1
		on t1.tbl_RepairId = RM.RepairId
		where t2.tbl_id = @i 
		and RM.ItemId = t2.tbl_ItemId
	
		update @tbl2 
		set tbl_list = substring(@list, 3, len(@list)-2)
		where tbl_id = @i
		and len(@list) > 0
	
		select @i = @i + 1
	end
	
	select 	S.vchDesc as ServiceName,
		RC.vchName as CatName,
		isnull(SC.vchDesc, 'Unchecked') as CheckStatusName,
		case when isnull(PMI.ServiceCheckId, 0) <> 3
			then ''
			else isnull(SR.vchDesc, 'No result')
		end as ResultStatusName,
		isnull(t2.tbl_list, '') as Repairs
	from WorkOrderPMItems PMI
	inner join PMSchedDetails SD
	on PMI.WorkOrderId = @OrderId
	and PMI.OrgId = @OrgId
	and PMI.PMSchedDetailId = SD.[Id]
	and PMI.OrgId = SD.OrgId
	inner join PMServices S
	on S.[Id] = SD.PMServiceId
	and S.OrgId = SD.OrgId
	left outer join RepairCats RC
	on RC.[Id] = S.RepairCatId
	and RC.OrgId = S.OrgId
	left outer join ServiceChecks SC
	on SC.[Id] = PMI.ServiceCheckId
	and SC.btInspectOnly = 0
	left outer join ServiceResults SR
	on SR.[Id] = PMI.ServiceResultId
	left outer join @tbl2 t2
	on PMI.RepairItemId = t2.tbl_ItemId
	order by RC.[Id], S.[Id] asc


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

