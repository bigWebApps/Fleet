SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


create procedure dbo.sp_UpdatePositionInspectItem
	(
		@OrgId int,
		@InspectId int,
		@InspectItemId int,
		@Position int
	)
AS
	set nocount on
	
	update 	InspectionItems
	set 	tintOrder = convert(tinyint, @Position)
	where 	[Id] = @InspectItemId 
	and 	InspectId = @InspectId 
	and 	OrgId = @OrgId

	return 0

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

