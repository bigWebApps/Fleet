SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectPMSchedPMServicesList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectPMSchedPMServicesList]
GO


CREATE procedure dbo.sp_SelectPMSchedPMServicesList
	(
		@OrgId int,
		@InspectItemId int
	)
as
	set nocount on

	select [Id], vchName 
	from PMSchedules
	where OrgId = @OrgId

	select SD.[Id], S.vchDesc, SD.PMSchedId
	from PMServices S
	inner join PMSchedDetails SD
	on S.OrgId = @OrgId
	and S.OrgId = SD.OrgId
	and S.[Id] = PMServiceId
	where SD.[Id] not in (
		select PMSchedDetailId
		from InspectionItems_PMSchedDetails
		where InspectItemId = @InspectItemId
		and OrgId = @OrgId
		)



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

