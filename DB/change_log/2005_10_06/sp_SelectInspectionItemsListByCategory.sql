SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 10/18/2005 
-- Description: Procedure select the inspection items of inspection category
---------------------------------------------------------------------------
create procedure dbo.sp_SelectInspectionItemsListByCategory
	(
		@OrgId int,
		@InspectionId int,
		@CategoryId int
	)
AS
	set nocount on

	declare @MaxPosition int

	select @MaxPosition = max(tintOrder)
	from InspectionItems II
	where II.InspectId = @InspectionId
	and II.OrgId = @OrgId
	and II.InspectCatId = @CategoryId

 	select 	II.[Id],
		'admin_inspection_item_edit.aspx?id=' + convert(varchar, @InspectionId) + '&itemid=' + convert(varchar, II.[Id]) as Link,
		II.vchDesc as ItemName,
		II.tintOrder as Position,
		'javascript:Reorder(this, ' + convert(varchar, (II.tintOrder - 1)) + ', ' + convert(varchar, @MaxPosition) + ');' as CallProcedure,
		 dbo.f_GetPositionOptions(II.tintOrder, @MaxPosition) as Options
	from InspectionItems II
	where II.InspectId = @InspectionId
	and II.OrgId = @OrgId
	and II.InspectCatId = @CategoryId
	order by II.tintOrder asc

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

