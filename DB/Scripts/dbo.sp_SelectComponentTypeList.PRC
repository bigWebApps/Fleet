SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectComponentTypeList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectComponentTypeList]
GO

CREATE   PROCEDURE sp_SelectComponentTypeList
	(
		@EquipId int
	)
AS
	set nocount on
	select distinct ECT_m.[Id], ECT_m.vchName
	from EquipComponentTypes ECT_m 
	where ECT_m.OrgId in (
		select OrgId
		from Equipments
		where [Id] = @EquipId
		)
	and ECT_m.[Id] not in (
		select ECT.[Id]
		from EquipComponents EC
		inner join EquipComponentTypes ECT
		on EC.[TypeId] = ECT.[Id]
		where EC.EquipId = @EquipId
		)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

