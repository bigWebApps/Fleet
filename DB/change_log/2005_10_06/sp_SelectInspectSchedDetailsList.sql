SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 10/23/2005 
-- Description: procedure select the details list of the Inspection Schedule
---------------------------------------------------------------------------
create procedure dbo.sp_SelectInspectSchedDetailsList
	(
		@OrgId int,
		@InspectSchedId int,
		@ScheduleName varchar(50)=null output
	)
as
	set nocount on

	select @ScheduleName = vchName
	from InspectSchedules
	where [Id] = @InspectSchedId
	and OrgId = @OrgId

	select 	ISD.[Id],
		@InspectSchedId as InspectSchedId,
		I.vchName as InspectionName,
		ISD.TargetDaysOut,
		ISD.MinimumDaysOut,
		ISD.MaximumDaysOut
	from 	InspectSchedDetails ISD
	inner join Inspections I
	on	ISD.InspectSchedId = @InspectSchedId
	and 	ISD.OrgId = @OrgId
	and 	ISD.InspectionId = I.[Id]
	and 	ISD.ORgId = I.OrgId


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

