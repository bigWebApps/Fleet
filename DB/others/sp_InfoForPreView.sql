SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER  PROCEDURE sp_InfoForPreView
	(
		@OrgId int,
		@WorkOrderId int,
		@vchWorkOrderId varchar(25)=null output,
		@vchEquipId varchar(50)=null output,
		@vchWODetails varchar(4000)=null output,
		@vchEquipDetails varchar(4000)=null output
	)
AS
	set nocount on

	if not exists(select 'true' from WorkOrders where [Id] = @WorkOrderId and OrgId = @OrgId)
	begin
		return -1
	end
	else
	begin
		-- data for preview 
		-- Equipment Id string
		-- Current Units and Measure for current units
		-- Status, if status - 7 then Schedure
		-- Is staying
		-- Is Spare, if yes them Spare Equip Id
		-- Assigned tech
		-- and other data of equipment
		select 	@vchWorkOrderId = convert(varchar, year(WO.dtCreated)) + '-' + 
					convert(varchar, month(WO.dtCreated)) + '-' + 
					convert(varchar, day(WO.dtCreated)) + '-' + 
					convert(varchar, WO.WorkOrderNumber),
			@vchEquipId = E.vchEquipId,
			@vchEquipDetails = 'The Equipment type is ' + isnull(ET.vchName, 'unknown') + '; <br>',
			@vchEquipDetails = @vchEquipDetails + 'Make - "' + isnull(EMa.vchMakeName, 'unknown') + '" / Model - "' + isnull(EMo.vchModelName, 'unknown') + '" / Year - "' + convert(varchar,E.intYear) + '"; <br>',
			@vchEquipDetails = @vchEquipDetails + 'The current units for equipment is ' + convert(varchar, cast(isnull(E.dmCurrentUnits, 0.0) as decimal(19, 2))) + ' ' + isnull(UM.vchName, ''),
			@vchWODetails = 'The work order has a ' + (case when isnull(WO.StatusId, 0) = 3 then WOS.vchStatus + ' status, date is ' + convert(varchar, WO.dtScheduled) else WOS.vchStatus + ' status' end) + '; <br>', 
			@vchWODetails = @vchWODetails + 'The operator ' + (case when isnull(WO.bitStaying, 0) = 0 then 'ain''t' else 'are' end) + ' staying for service; <br>',
			@vchWODetails = @vchWODetails + (case when isnull(WO.SpareEquipId, 0) = 0 then 'The operator ain''t taking the spare equipment' else 'The operator are taking the spare equipment "' + isnull(SpE.vchEquipId, 'unknown') + '" instead of serving equipment' end) + '; <br>',
			@vchWODetails = @vchWODetails + (case when isnull(WO.intTechId, 0) = 0 then 'The work order wasn''t assigned' else 'The work order was assigned for technician ' + L.vchFirstName + ' ' + L.vchLastName end) + '. <br>' 
		from WorkOrders WO
		inner join WorkOrderStatus WOS
		on WO.[Id] = @WorkOrderId
		and WO.OrgId = @OrgId
		and WOS.[Id] = WO.StatusId
		inner join Equipments E 
		on WO.[EquipId] = E.[Id]
		and WO.OrgId = E.OrgId
		inner join EquipTypes ET
		on E.TypeId = ET.[Id]
		and E.OrgId = ET.OrgId
		left join UnitMeasures UM
		on ET.UnitMeasureId = UM.[Id]
		left join Equipments SpE -- spare equipment
		on WO.SpareEquipId = SpE.[Id]
		and WO.OrgId = SpE.[OrgId]
		left join Logins L
		on L.[Id] = WO.intTechId
		left join EquipModels EMo 
		on EMo.[Id] = E.ModelId
		and EMo.OrgId = E.OrgId
		inner join EquipModelType EMT
		on EMT.[Id] = EMo.TypeId
		and EMT.OrgId = EMo.OrgId
		inner join EquipMakes EMa 
		on EMa.[Id] = EMT.MakeId
		and EMa.OrgId = EMT.OrgId
	
		if exists(select 'true' from WorkOrders where [Id] = @WorkOrderId and OrgId = @OrgId and btIsActive = 1)
		begin
			return 1
		end
		else
		begin 
			return 0
		end
	end






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

