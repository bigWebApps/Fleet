SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER  procedure dbo.sp_GetEquipInfo_Alt
	(
		@OrgId int,
		@Id int,
		@vchEquipId varchar(50)=null output,
		@vchEquipType varchar(50)=null output,
		@vchMakeModelName varchar(101)=null output,
		@intYear int=null output,
		@dmCurrentUnits decimal(19, 8)=null output,
		@vchMeasureName varchar(255)=null output
	)
as
	set nocount on
	
	if not exists(select 'true' from Equipments where [Id] = @Id and OrgId = @OrgId)
	begin
		return -1
	end
	else
	begin
		select 	@vchEquipId = isnull(E.vchEquipId, ''),
			@vchEquipType = ET.vchName,
			@vchMakeModelName = isnull(EMa.vchMakeName, '') + '/' + isnull(EMo.vchModelName, ''),
			@intYear = isnull(E.intYear, 0),
			@dmCurrentUnits = isnull(E.dmCurrentUnits, 0.0),
			@vchMeasureName = isnull(UM.vchName, 'miles')
		from Equipments E
		inner join EquipTypes ET
		on E.[Id] = @Id 
		and E.OrgId = @OrgId
		and E.TypeId = ET.[Id]
		and E.OrgId = ET.OrgId
		inner join UnitMeasures UM
		on ET.UnitMeasureId = UM.[Id]
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

