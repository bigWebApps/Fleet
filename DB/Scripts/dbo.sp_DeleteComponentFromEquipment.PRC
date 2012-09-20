SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_DeleteComponentFromEquipment]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_DeleteComponentFromEquipment]
GO

CREATE PROCEDURE sp_DeleteComponentFromEquipment
	(
		@OrgId int,
		@Id int
	)
AS
	set nocount on
	declare @DataId int
	select @DataId = DataId
	from EquipComponents
	where OrgId = @OrgId
	and [Id] = @Id 
	delete from EquipComponents
	where OrgId = @OrgId
	and [Id] = @Id 
	delete from EquipData
	where [Id] = @DataId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

