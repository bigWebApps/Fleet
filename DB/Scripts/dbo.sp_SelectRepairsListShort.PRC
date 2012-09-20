SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectRepairsListShort]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectRepairsListShort]
GO

create procedure sp_SelectRepairsListShort
	@OrgId int,
	@OrderId int
AS
	set nocount on
	select 	0 as [Id], 
		'<New Repair>' as RepairDesc
	union all
	select  R.[Id],
		case when len(R.vchDesc) > 25 
			then (substring(R.vchDesc, 0, (case when charindex(space(1), R.vchDesc, 25) = 0 then len(R.vchDesc) + 1 else charindex(space(1), R.vchDesc, 25) end)) + space(1) + (case when charindex(space(1), R.vchDesc, 25) <> 0 then '...' else '' end))
			else R.vchDesc 
		end as RepairDesc
	from Repairs R
	inner join RepairItems RI
	on R.WorkOrderId = @OrderId
	and R.OrgId = @OrgId
	and isnull(R.RepairItemId, 0) = RI.[Id]
	and R.OrgId = RI.OrgId
	inner join RepairCats RC
	on RC.[Id] = RI.CatId
	and RC.OrgId = RI.OrgId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

