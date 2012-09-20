SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ClearDatabase]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ClearDatabase]
GO


create procedure sp_ClearDatabase
	@OrgId int
as
	set nocount on

	declare @tbl table (DataId int)

	delete from EquipInspectHistory
	where OrgId = @OrgId

	delete from EquipPMHistory
	where OrgId = @OrgId

	delete from WorkOrderInspectItems
	where OrgId = @OrgId

	delete from WorkOrderInspections
	where OrgId = @OrgId

	delete from WorkOrderPMItems
	where OrgId = @OrgId

	delete from WorkOrderReportedIssues
	where OrgId = @OrgId

	delete from EquipAssignLogs
	where OrgId = @OrgId

	delete from EquipUnitLogs
	where OrgId = @OrgId

	delete from Errors

	delete from PartsUsed
	where OrgId = @OrgId

	delete from RepairMult
	where OrgId = @OrgId

	delete from Repairs
	where OrgId = @OrgId

	insert into @tbl(DataId)
	select DataId 
	from WorkOrders
	where OrgId = @OrgId

	delete from WorkOrders
	where OrgId = @OrgId
	
	delete from EquipData 
	where OrgId = @OrgId
	and [Id] in (
		select DataId
		from @tbl
		)
	
	delete from Notes
	where OrgId = @OrgId

	delete from SignedDocuments
	where OrgId = @OrgId

	update Equipments
	set dmCurrentUnits = 0.0
	where OrgId = @OrgId

	return 0


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

