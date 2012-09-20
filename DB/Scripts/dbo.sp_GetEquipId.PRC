SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GetEquipId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GetEquipId]
GO


----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 09/15/2005 
-- Description: The procedure search the equipment by his Equip Id string
---------------------------------------------------------------------------
CREATE procedure sp_GetEquipId
	(
		@OrgId int,
		@vchEquipId varchar(50),
		@EquipId int=null output,
		@vchEquipType varchar(50)=null output,
		@vchMakeModelName varchar(101)=null output,
		@intYear int=null output
	)
as
	set nocount on
	
	select @EquipId = 0

	select @EquipId = isnull([Id], 0)
	from Equipments
	where vchEquipId = @vchEquipId
	and OrgId = @OrgId
	and [Id] not in (
		select EquipId
		from WorkOrders
		where OperatorStatusId = 1
		and OrgId = @OrgId
		)

	if @EquipId <> 0
	begin
		select 	@vchEquipType = ET.vchName,
			@vchMakeModelName = isnull(EMa.vchMakeName, '') + '/' + isnull(EMo.vchModelName, ''),
			@intYear = E.intYear
		from Equipments E
		inner join EquipTypes ET
		on E.[Id] = @EquipId
		and E.OrgId = @OrgId 
		and E.TypeId = ET.[Id]
		and E.OrgId = ET.OrgId
		left outer join EquipModels EMo
		on EMo.OrgId = @OrgId 
		and EMo.[Id] = E.ModelId 
		left outer join EquipModelType EMT
		on EMT.OrgId = @OrgId 
		and EMT.[Id] = EMo.TypeId
		left outer join EquipMakes EMa
		on EMa.OrgId = @OrgId 
		and EMa.[Id] = EMT.MakeId
	end




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

