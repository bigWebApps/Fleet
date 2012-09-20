SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SetRepairResult]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SetRepairResult]
GO

CREATE  procedure sp_SetRepairResult
	(
		@OrgId int,
		@OrderId int,
		@vchType varchar(25),
		@ServiceResultId int,
		@ItemId int,
		@RepairId int=null output,
		@RepairDesc varchar(4000)=null output,
		@RepairItemId int=null output,
		@RepairCatId int=null output
	)
as
-- SP is adding repair and refresh the ServiceResultId status into source table
-- if @RepairId = 0 then we create a new repair and new record into RepairMult
-- i.e. it is meaning the repair is new, if RepairId not equal zero then
-- it mean the relationship between two issues (sorces) and one repair 
-- then we get ItemId from RepairMult and set it into RepairItemId of source
-- and we get out  the information about repair of @RepairId
	set nocount on
	declare @MultItemId int
	if isnull(@RepairId, 0) = 0
	begin
		if @RepairItemId = 0
		begin
			select @RepairItemId = null
		end
		insert into Repairs(
			OrgId,
			RepairItemId,
			WorkOrderId,
			vchDesc
			)
		values( 
			@OrgId,
			@RepairItemId,
			@OrderId,
			isnull(@RepairDesc, '')
			)
		select @RepairId = scope_identity()
	
		select @MultItemId = max(ItemId) + 1
		from RepairMult
		where OrgId = @OrgId
	
		insert into [RepairMult](
			[OrgId], 
			[ItemId], 
			[RepairId]
			)
		values(
			@OrgId,
			@MultItemId,
			@RepairId
			)
	end
	else
	begin -- else we modify the RepairItemId column of WorkOrderPMItems table
		select top 1 @MultItemId = ItemId
		from RepairMult
		where OrgId = @OrgId
		and RepairId = @RepairId
	end
	if isnull(@vchType, '') = 'RI'
	begin
		update 	WorkOrderReportedIssues
		set 	ServiceResultId = @ServiceResultId,
			RepairItemId = @MultItemId
		where 	[Id] = @ItemId
		and 	OrgId = @OrgId
		and 	WorkOrderId = @OrderId
	end
	if isnull(@vchType, '') = 'PMI'
	begin
		update 	WorkOrderPMItems
		set 	ServiceResultId = @ServiceResultId,
			RepairItemId = @MultItemId
		where 	[Id] = @ItemId
		and 	OrgId = @OrgId
		and 	WorkOrderId = @OrderId
		-- in history table is keeping the last check of detail
		-- if the record already there then editing else adding
		if not exists(select 'true' 
			from EquipPMHistory EH 
			inner join WorkOrderPMItems PMI 
			on 	PMI.[Id] = @ItemId 
			and 	PMI.OrgId = @OrgId
			and 	PMI.WorkOrderId = @OrderId
			and 	EH.WorkOrderid = PMI.WorkOrderId
			and 	EH.OrgId = PMI.OrgId
			and 	EH.PMSchedDetailId = PMI.PMSchedDetailId
			)
		begin -- insert history
			insert into EquipPMHistory (
				OrgId, 
				EquipId,
				dtDate,
				PMSchedDetailId,
				dmUnits,
				WorkOrderId
				)
			select 	@OrgId,
				WO.EquipId,
				getdate(),
				PMI.PMSchedDetailId,
				WO.dmMileage,
				@OrderId
			from 	WorkOrders WO
			inner join WorkOrderPMItems PMI
			on 	WO.[Id] = @OrderId
			and 	WO.OrgId = @OrgId
			and 	PMI.WorkOrderId = WO.[Id]
			and  	PMI.OrgId = WO.OrgId
			and 	PMI.[Id] = @ItemId
		end
		else
		begin -- update history
			update 	EquipPMHistory
			set 	dtDate = getdate(),
				dmUnits = WO.dmMileage
			from 	WorkOrders WO
			inner join WorkOrderPMItems PMI
			on 	WO.[Id] = @OrderId
			and 	WO.OrgId = @OrgId
			and 	PMI.WorkOrderId = WO.[Id]
			and  	PMI.OrgId = WO.OrgId
			and 	PMI.[Id] = @ItemId
			where 	EquipPMHistory.EquipId = WO.Equipid
			and	EquipPMHistory.OrgId = WO.OrgId
			and	EquipPMHistory.PMSchedDetailId = PMI.PMSchedDetailId
			and 	EquipPMHistory.WorkOrderId = PMI.WorkOrderId
		end
	end
	if isnull(@vchType, '') = 'II'
	begin
		update 	WorkOrderInspectItems
		set 	ServiceResultId = @ServiceResultId,
			RepairItemId = @MultItemId
		where 	[Id] = @ItemId
		and 	OrgId = @OrgId
		and 	WorkOrderId = @OrderId
	end
	select 	@RepairDesc = R.vchDesc,
		@RepairItemId = isnull(R.RepairItemId, 0),
		@RepairCatId = isnull(RI.CatId, 0)
	from Repairs R
	left outer join RepairItems RI
	on R.RepairItemId = RI.[Id]
	and R.OrgId = RI.OrgId
	where R.[Id] = @RepairId
	and R.OrgId = @OrgId
	return 0
	

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

