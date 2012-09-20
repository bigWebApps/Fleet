SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectMakesList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectMakesList]
GO

CREATE   PROCEDURE sp_SelectMakesList
	(
		@OrgId int,
		@btIsComponent bit,
		@intTypeId int
	)
AS
	set nocount on
	select distinct EM.[Id], EM.vchMakeName
	from EquipMakes EM
	inner join EquipModelType EMT
	on EM.[Id] = EMT.[MakeId]
	and EM.OrgId = EMT.OrgId
	and EMT.btIsComponent = @btIsComponent
	and EMT.intTypeId = @intTypeId
	and EMT.OrgId = @OrgId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

