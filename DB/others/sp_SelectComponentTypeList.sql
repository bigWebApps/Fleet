SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER  PROCEDURE sp_SelectComponentTypeList
	(
		@EquipId int
	)
AS
	set nocount on

	select distinct ECT_m.[Id], ECT_m.vchName
	from EquipComponentTypes ECT_m 
	where ECT_m.OrgId in (
		select OrgId
		from Equipment
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

