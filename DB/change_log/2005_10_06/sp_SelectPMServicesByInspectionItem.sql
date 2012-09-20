SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


create procedure dbo.sp_SelectPMServicesByInspectionItem
	(
		@OrgId int,
		@InspectItemId int
	)
as
	set nocount on

	select 	IISD.[Id], 
		S.vchDesc as ServiceName, 
		SH.vchName as ScheduleName
	from InspectionItems_PMSchedDetails IISD
	inner join PMSchedDetails SD
	on IISD.InspectItemId = @InspectItemId
	and IISD.OrgId = @OrgId
	and SD.OrgId = IISD.OrgId
	and SD.[Id] = IISD.PMSchedDetailId
	inner join PMSchedules SH
	on SH.[Id] = SD.PMSchedId
	and SH.OrgId = SD.OrgId
	inner join PMServices S
	on S.[Id] = SD.PMServiceId
	and S.OrgId = SD.OrgId


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

