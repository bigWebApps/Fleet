SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 09/06/2005 
-- Description: Procedure is getting the information for Inspection Detail 
-- screen (inspection info, inspection schedule info, equipment info)
---------------------------------------------------------------------------
ALTER procedure sp_GetInfoForInspection
	(
		@OrgId int,
		@WorkOrderId int,
		@InspectId int,
		@vchInspectName varchar(50)=null output,
		@vchInspectScheduleName varchar(50)=null output,
		@intInspectTargetDays int=null output,
		@InspectSchedDetailId int=null output,
		@EquipId int=null output,
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
			@vchInspectScheduleName = [IS].vchName,
			@intInspectTargetDays = ISD.TargetDaysOut,
			@InspectSchedDetailId = ISD.[Id],
			@EquipId = E.[Id],
			@vchEquipId = isnull(E.vchEquipId, 'unknown'),
			@vchEquipMake = isnull(EMa.vchMakeName, 'unknown'),
			@vchEquipModel = isnull(EMo.vchModelName, 'unknown')
		from WorkOrderInspections WI
		inner join InspectSchedDetails ISD
		on WI.[Id] = @InspectId 
		and WI.WorkOrderId = @WorkOrderId 
		and WI.OrgId = @OrgId
		and WI.InspectSchedDetailId = ISD.[Id]
		and WI.OrgId = ISD.OrgId
		inner join InspectSchedules [IS]
		on ISD.InspectSchedId = [IS].[Id]
		and ISD.OrgId = [IS].OrgId
		inner join Inspections I
		on I.[Id] = ISD.InspectionId
		and I.OrgId = ISD.OrgId
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

