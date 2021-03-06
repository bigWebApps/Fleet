SET QUOTED_IDENTIFIER ON ਍ഀ
GO਍ഀ
SET ANSI_NULLS ON ਍ഀ
GO਍ഀ
਍ഀ
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectEquipListByUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)਍ഀ
drop procedure [dbo].[sp_SelectEquipListByUser]਍ഀ
GO਍ഀ
਍ഀ
਍ഀ
਍ഀ
create procedure dbo.sp_SelectEquipListByUser਍ഀ
	(਍ഀ
		@OrgId int,਍ഀ
		@UserId int਍ഀ
	)਍ഀ
as਍ഀ
	set nocount on਍ഀ
	select 	E.[Id],਍ഀ
		ISNULL(E.vchEquipId, '') as EquipId,਍ഀ
		ET.vchName as TypeName,਍ഀ
		ISNULL(EMa.vchMakeName, '') as MakeName, ਍ഀ
		ISNULL(EMo.vchModelName, '') as ModelName,਍ഀ
		E.intYear as [Year]਍ഀ
	from Equipments E਍ഀ
	inner join EquipTypes ET਍ഀ
	on E.OrgId = @OrgId਍ഀ
	and isnull(E.EquipOperatorId, 0) = @UserId਍ഀ
	and ET.[Id] = E.TypeId਍ഀ
	and ET.OrgId = E.OrgId਍ഀ
	left outer join EquipModels EMo਍ഀ
	on EMo.OrgId = @OrgId and EMo.[Id] = E.ModelId ਍ഀ
	left outer join EquipModelType EMT਍ഀ
	on EMT.OrgId = @OrgId and EMT.[Id] = EMo.TypeId਍ഀ
	left outer join EquipMakes EMa਍ഀ
	on EMa.OrgId = @OrgId and EMa.[Id] = EMT.MakeId਍ഀ
	order by ET.[Id] asc, E.vchEquipId asc਍ഀ
਍ഀ
਍ഀ
਍ഀ
਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER OFF ਍ഀ
GO਍ഀ
SET ANSI_NULLS ON ਍ഀ
GO਍ഀ
਍ഀ
