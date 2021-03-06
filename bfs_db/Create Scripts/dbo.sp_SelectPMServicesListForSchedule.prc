SET QUOTED_IDENTIFIER ON ਍ഀ
GO਍ഀ
SET ANSI_NULLS ON ਍ഀ
GO਍ഀ
਍ഀ
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectPMServicesListForSchedule]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)਍ഀ
drop procedure [dbo].[sp_SelectPMServicesListForSchedule]਍ഀ
GO਍ഀ
਍ഀ
਍ഀ
਍ഀ
----------------------------------------------------------------------------਍ഀ
-- Author: Alexey Gavrilov਍ഀ
-- Last Modification Date: 06/28/2006਍ഀ
-- Description: Procedure is showing the preventive services for schedule ਍ഀ
---------------------------------------------------------------------------਍ഀ
CREATE procedure sp_SelectPMServicesListForSchedule਍ഀ
	(਍ഀ
		@OrgId int,਍ഀ
		@PMSchedId int਍ഀ
	)਍ഀ
as਍ഀ
	set nocount on਍ഀ
਍ഀ
	select 	SD.[Id],਍ഀ
		SD.PMSchedId,਍ഀ
		S.vchDesc as ServiceName,਍ഀ
		UM.vchName as UnitMeasureName,਍ഀ
		SD.intDays as Days,਍ഀ
		convert(float, SD.dmUnits) as Units਍ഀ
	from PMSchedDetails SD਍ഀ
	inner join PMServices S਍ഀ
	on SD.PMSchedId = @PMSchedId਍ഀ
	and SD.OrgId = @OrgId਍ഀ
	and SD.PMServiceId = S.[Id]਍ഀ
	and SD.OrgID = S.OrgId਍ഀ
	inner join UnitMeasures UM਍ഀ
	on UM.[Id] = SD.UnitMeasureId਍ഀ
਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER OFF ਍ഀ
GO਍ഀ
SET ANSI_NULLS ON ਍ഀ
GO਍ഀ
਍ഀ
