SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GetEquipSearch]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GetEquipSearch]
GO



----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 02/03/2006
-- Description: The procedure search the equipment by his Equip Id string
---------------------------------------------------------------------------
create procedure dbo.sp_GetEquipSearch
	(
		@OrgId int,
		@vchEquipId varchar(50),
		@EquipId int=null output
	)
as
	set nocount on
	
	select @EquipId = 0

	select @EquipId = isnull([Id], 0)
	from Equipments
	where vchEquipId = @vchEquipId
	and OrgId = @OrgId

	return @EquipId


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

