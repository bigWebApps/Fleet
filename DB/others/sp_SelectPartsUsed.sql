SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

alter procedure sp_SelectPartsUsed
	(
		@OrgId int,
		@RepairId int
	)
AS
	set nocount on

	select 	[Id],
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

