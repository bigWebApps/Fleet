SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectInspectionItemsList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectInspectionItemsList]
GO




----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 10/13/2005 
-- Description: The procedure select all inspection items of inspection
---------------------------------------------------------------------------
CREATE   procedure dbo.sp_SelectInspectionItemsList
	(
		@OrgId int,
		@InspectionId int,
		@InspectionName varchar(50)=null output
	)
AS
	set nocount on

	select @InspectionName = vchName
	from Inspections 
	where [Id] = @InspectionId
	and OrgId = @OrgId

	select 	Link,
		[Text],
		OrderText,
		ItemId, 
		CatId,
		Type,
		OrderBy,
		GlobalOrder,
		ItemName,
		CellColor,
		BorderStyle
	from (
		select distinct
			'admin_inspection_category_edit.aspx?id=' + convert(varchar, @InspectionId) + '&catid=' + convert(varchar, IC.[Id]) as Link,
			'Category Edit' as [Text],
			convert(varchar, IC.tintOrder) as OrderText,
			IC.tintOrder as OrderBy,
			IC.tintOrder as GlobalOrder,
			IC.[Id] as ItemId,
			IC.[Id] as CatId,
			0 as Type,
			IC.vchName as ItemName,
			'#CCCCCC' as CellColor,
			'solid' as BorderStyle
		from InspectCats IC
		where IC.InspectId = @InspectionId
		and IC.OrgId = @OrgId
		union all
	 	select 	'admin_inspection_item_edit.aspx?id=' + convert(varchar, @InspectionId) + '&itemid=' + convert(varchar, II.[Id]) as Link,
			'Edit' as [Text],
			'' as OrderText,
			II.tintOrder as OrderBy,
			IC.tintOrder as GlobalOrder,
			II.[Id] as ItemId,
			II.InspectCatId as CatId,
			1 as Type,
			II.vchDesc as ItemName,
			'#FFFFCC' as CellColor,
			'none' as BorderStyle
		from InspectionItems II
		inner join InspectCats IC
		on II.InspectId = @InspectionId
		and II.OrgId = @OrgId
		and IC.[Id] = II.InspectCatId
		and IC.OrgId = II.OrgId
		) G
	order by G.GlobalOrder, G.[CatId], G.Type, G.OrderBy asc




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

