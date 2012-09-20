SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create procedure dbo.sp_SelectHolidaysList
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

