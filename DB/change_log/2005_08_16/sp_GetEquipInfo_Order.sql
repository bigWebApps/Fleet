SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER  procedure sp_GetEquipInfo_Order
	(
		@OrgId int,
		@OrderId int,
		@EquipId int=null output,
		@vchEquipId varchar(50)=null output,
		@vchEquipType varchar(50)=null output,
		@vchMakeModelName varchar(101)=null output,
		@vchYear varchar(50)=null output
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
			@vchYear = convert(varchar, E.intYear)
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
						
		return 0
	end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

