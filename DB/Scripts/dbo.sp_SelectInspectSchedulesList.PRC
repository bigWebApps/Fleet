SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectInspectSchedulesList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectInspectSchedulesList]
GO



----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 10/23/2005 
-- Description: Procedure select the list of the Inspection Schedules
---------------------------------------------------------------------------
CREATE  procedure dbo.sp_SelectInspectSchedulesList
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

