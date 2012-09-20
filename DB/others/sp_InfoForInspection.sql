SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER   procedure sp_InfoForInspection
	(
		@OrgId int,
		@WorkOrderId int,
		@InspectId int,
		@vchInspectName varchar(50)=null output,
		@vchInspectPeriod varchar(50)=null output,
		@vchEquipId varchar(50)=null output,
		@vchEquipMake varchar(50)=null output,
		@vchEquipModel varchar(50)=null output
	)
AS
	set nocount on

	if not exists(select 'true' from WorkOrderInspections where [Id] = @InspectId and WorkOrderId = @WorkOrderId and OrgId = @OrgId)
	begin
		return -1
	end
	else
	begin
		select 	@vchInspectName = I.vchName,
			@vchInspectPeriod = convert(varchar, intFrequencyDays) + ' days',
			@vchEquipId = isnull(E.vchEquipId, 'unknown'),
			@vchEquipMake = isnull(EMa.vchMakeName, 'unknown'),
			@vchEquipModel = isnull(EMo.vchModelName, 'unknown')
		from WorkOrderInspections WI
		inner join Inspections I
		on WI.[Id] = @InspectId 
		and WI.WorkOrderId = @WorkOrderId 
		and WI.OrgId = @OrgId
		and WI.InspectId = I.[Id]
		and WI.OrgId = I.OrgId
		inner join WorkOrders WO
		on WO.[Id] = WI.WorkOrderId
		and WO.OrgId = WI.OrgId
		inner join Equipments E
		on E.[Id] = WO.EquipId
		and E.OrgId = WO.OrgId
		left join EquipModels EMo 
		on EMo.[Id] = E.ModelId
		and EMo.OrgId = E.OrgId
		inner join EquipModelType EMT
		on EMT.[Id] = EMo.TypeId
		and EMT.OrgId = EMo.OrgId
		inner join EquipMakes EMa 
		on EMa.[Id] = EMT.MakeId
		and EMa.OrgId = EMT.OrgId

		if exists(select 'true' from WorkOrderInspections where [Id] = @InspectId and WorkOrderId = @WorkOrderId and OrgId = @OrgId and btIsProcessed = 1)
		begin
			return 1
		end
		else
		begin 
			if exists(select 'true' from WorkOrders where [Id] = @WorkOrderId and OrgId = @OrgId and StatusId = 3)
			begin
				return 1
			end
			else
			begin
				return 0
			end
		end
	end




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

