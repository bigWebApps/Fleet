SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectPartsUsed]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectPartsUsed]
GO

CREATE  procedure sp_SelectPartsUsed
	(
		@OrgId int,
		@RepairId int
	)
AS
	set nocount on
	select 	[Id],
		0 as IsNew,
		0 as IsDeleted,
		intQty as Qty, 
		vchStock as Stock,
		vchDesc as [Desc],
		dmCost as Cost
	from	PartsUsed
	where 	RepairId = @RepairId
	and 	OrgId = @OrgId
	

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

