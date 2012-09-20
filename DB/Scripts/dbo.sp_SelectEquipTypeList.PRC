SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectEquipTypeList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectEquipTypeList]
GO

CREATE PROCEDURE sp_SelectEquipTypeList
	(
		@OrgId int
	)
AS
	set nocount on
	select [Id], [vchName]
	from EquipTypes
	where OrgId = @OrgId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

