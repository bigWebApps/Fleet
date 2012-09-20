SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 10/23/2005 
-- Description: Procedure select the list of the Inspection Schedules
---------------------------------------------------------------------------
ALTER  procedure dbo.sp_SelectInspectSchedulesList
	(
		@OrgId int
	)
AS
	set nocount on

	select 	[Id],
		vchName
	from 	InspectSchedules 
	where 	OrgId = @OrgId


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

