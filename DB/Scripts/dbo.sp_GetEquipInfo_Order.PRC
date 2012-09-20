SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GetEquipInfo_Order]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GetEquipInfo_Order]
GO




----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 09/28/2005 
-- Description: The procedure get equipment information from current Work Order
---------------------------------------------------------------------------
CREATE  procedure dbo.sp_GetEquipInfo_Order
	(
		@OrgId int,
		@OrderId int,
		@EquipId int=null output,
		@vchEquipId varchar(50)=null output,
		@vchEquipType varchar(50)=null output,
		@vchMakeModelName varchar(101)=null output,
		@vchYear varchar(50)=null output,
		@vchOperatorLastName varchar(50)=null output,
		@dtFutureInspectionDate datetime=null output
	)
as
	set nocount on

	if not exists(select 'true' 
		from Equipments E 
		inner join WorkOrders WO 
		on WO.[Id] = @OrderId 
		and WO.OrgId = @OrgId 
		and E.[Id] = WO.EquipId 
		and E.OrgId = WO.OrgId)
	begin
		return -1
	end
	else
	begin
		select 	@EquipId = E.[Id],
			@vchEquipId = isnull(E.vchEquipId, ''),
			@vchEquipType = ET.vchName,
			@vchMakeModelName = isnull(EMa.vchMakeName, '') + '/' + isnull(EMo.vchModelName, ''),
			@vchYear = convert(varchar, E.intYear),
			@vchOperatorLastName = isnull(L.vchLastName, '')
		from Equipments E
		inner join WorkOrders WO 
		on WO.[Id] = @OrderId 
		and WO.OrgId = @OrgId 
		and E.[Id] = WO.EquipId 
		and E.OrgId = WO.OrgId
		inner join EquipTypes ET
		on E.TypeId = ET.[Id]
		and E.OrgId = ET.OrgId
		left outer join EquipModels EMo
		on EMo.OrgId = @OrgId and EMo.[Id] = E.ModelId 
		left outer join EquipModelType EMT
		on EMT.OrgId = @OrgId and EMT.[Id] = EMo.TypeId
		left outer join EquipMakes EMa
		on EMa.OrgId = @OrgId and EMa.[Id] = EMT.MakeId
		left outer join Logins L
		on L.[Id] = E.EquipOperatorId

		select top 1 @dtFutureInspectionDate = WO.dtScheduled
		from WorkOrders WO 
		inner join WorkOrderInspections WOI 
		on WO.EquipId = @EquipId
		and WO.[Id] <> @OrderId
		and WO.StatusId = 3
		and WO.OrgId = @OrgId
		and WOI.WorkOrderId = WO.[Id] 
		and WOI.OrgId = @OrgId
		order by WO.dtScheduled asc
						
		return 0
	end





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

