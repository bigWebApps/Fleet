SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 09/06/2005 
-- Description: The Procedure is selecting the list of the Inspection Schedules
---------------------------------------------------------------------------
create procedure dbo.sp_SelectInspectSchedulesList
	(
		@OrgId int
	)
AS
	set nocount on

	select 	[Id],
		vchName
	from InspectSchedules
	where OrgId = @OrgId
	

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

