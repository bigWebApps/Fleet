SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_DeleteWorkOrder]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_DeleteWorkOrder]
GO


create procedure dbo.sp_DeleteWorkOrder
	(
		@OrgId int,
		@OrderId int,
		@UserId int,
		@dtCurrentDate datetime
	)
as
	set nocount on
	declare @SpareEquipId int
	declare @tbl table (DataId int)

	if not exists(select 'true' 
			from WorkOrders 
			where [Id] = @OrderId 
			and OrgId = @OrgId)
		return -1
	else
	begin
		-- reset Spare if is there
		select @SpareEquipId = isnull(SpareEquipId, 0)
		from WorkOrders 
		where [Id] = @OrderId 
		and OrgId = @OrgId

		if @SpareEquipId <> 0
		begin
			insert into EquipAssignLogs (
				OrgId, 
				EquipId, 
				IsTemp,
				AssignedFrom, 
				AssignedTo, 
				AssignedBy, 
				vchNote, 
				dtUpdated) 
			select 	@OrgId, 
				@SpareEquipId, 
				1,
				TempOperatorId, 
				null, 
				@UserId, 
				'checking in the spare equipment during deleting order', 
				@dtCurrentDate
			from Equipments
			where [Id] = @SpareEquipId
			and OrgId = @OrgId
	
			update Equipments
			set TempOperatorId = null
			where [Id] = @SpareEquipId
			and OrgId = @OrgId
		end

		-- unassign reported issues
		update WorkOrderReportedIssues
		set WorkOrderId = null
		where WorkOrderId = @OrderId
		and OrgId = @OrgId

		-- delete information
		delete from WorkOrderPMItems
		where WorkOrderId = @OrderId
		and OrgId = @OrgId

		delete from WorkOrderInspectItems
		where WorkOrderId = @OrderId
		and OrgId = @OrgId

		delete from WorkOrderInspections
		where WorkOrderId = @OrderId
		and OrgId = @OrgId

		insert into @tbl(DataId)
		select DataId 
		from WorkOrders
		where [Id] = @OrderId
		and OrgId = @OrgId

		delete from WorkOrders
		where [Id] = @OrderId
		and OrgId = @OrgId
		
		delete from EquipData 
		where OrgId = @OrgId
		and [Id] in (
			select DataId
			from @tbl
			)
		
		delete from Notes
		where ItemId = @OrderId
		and TypeId in (1, 2)
		and OrgId = @OrgId

		delete from SignedDocuments
		where DocumentId = @OrderId
		and OrgId = @OrgId
		and DocumentTypeId in (1, 5)

		return 0
	end



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

