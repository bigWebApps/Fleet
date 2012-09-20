SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectHolidaysList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectHolidaysList]
GO



CREATE  procedure dbo.sp_SelectHolidaysList
	(
		@OrgId int
	)
as
	set nocount on
	select 	[Id],
		dtStartDate,
		dtEndDate,
		vchDesc,
		intPercentOff
	from Holidays
	where Orgid = @OrgId
	order by dtStartDate asc, dtEndDate asc


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

