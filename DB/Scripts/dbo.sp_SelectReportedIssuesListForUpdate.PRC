SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectReportedIssuesListForUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectReportedIssuesListForUpdate]
GO



CREATE  procedure dbo.sp_SelectReportedIssuesListForUpdate
	@OrgId int,
	@OrderId int,
	@InspectionItemId int
as
	set nocount on

	declare @InspectRepairItemId int
	declare @i int
	declare @N int

	declare @tblRepairs table (
		[Id] int identity(1, 1),
		RepairId int,
		ItemId int,
		Checked bit
		)

	select @InspectRepairItemId = RepairItemId
	from WorkOrderInspectItems II
	where II.WorkOrderId = @OrderId
	and II.[Id] = @InspectionItemId
	and II.OrgId = @OrgId
	
	insert into @tblRepairs(RepairId, ItemId)
	select RM.RepairId, RM.ItemId
	from RepairMult RM
	inner join Repairs R
	on RM.OrgId = @OrgId
	and RM.ItemId in (
		select RepairItemId
		from WorkOrderReportedIssues RI
		where RI.WorkOrderId = @OrderId
		and RI.OrgId = @OrgId
		)
	and RM.RepairId = R.[Id]
	and RM.OrgId = R.OrgId

	select @i = 1, @N = scope_identity()
	while @i <= @N 
	begin
		if exists(select 'true'
			from RepairMult RM
			where RM.RepairId in (
				select RepairId 
				from @tblRepairs 
				where [Id] = @i 
				)
			and RM.ItemId = @InspectRepairItemId
			)
		begin
			update @tblRepairs 
			set Checked = 1
			where [Id] = @i 
		end
		else
		begin
			update @tblRepairs 
			set Checked = 0
			where [Id] = @i 
		end
		select @i = @i + 1
	end

	select distinct 
		RI.[Id],
		case when isnull(tR.Checked, 0) = 1 then 'True' else 'False' end as Associated,
		isnull(RC.vchName, '') as CatName,
		case when isnull(RI.ServiceCheckId, 0) <> 3
			then isnull(SC.vchDesc, '')
			else isnull(SC.vchDesc, '') + ' - ' + isnull(SR.vchDesc, 'Non-Serviced')
		end as StatusName,
		isnull(RI.vchDesc, '') as IssueName
	from WorkOrderReportedIssues RI
	inner join RepairCats RC
	on RI.WorkOrderId = @OrderId
	and RI.OrgId = @OrgId
	and RI.RepairCatId = RC.[Id]
	and RI.OrgId = RC.OrgId
	left outer join ServiceChecks SC
	on isnull(RI.ServiceCheckId, 0) = SC.[Id]
	left outer join ServiceResults SR
	on isnull(RI.ServiceResultId, 0) = SR.[Id]
	left outer join @tblRepairs tR
	on tR.ItemId = isnull(RI.RepairItemId, 0)



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

