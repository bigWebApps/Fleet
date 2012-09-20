SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_EquipmentDetail_Alt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_EquipmentDetail_Alt]
GO



----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 09/06/2005 
-- Description: The Procedure is getting and changing the alternative 
-- equipment properties
---------------------------------------------------------------------------
CREATE  procedure sp_EquipmentDetail_Alt
	(
		@Action char(1),
		@OrgId int,
		@Id int,
		@PMScheduleId int=null OUTPUT,
		@vchPMSchedName varchar(25)=null OUTPUT,
		@InspectScheduleId int=null OUTPUT,
		@vchInspectScheduleName varchar(50)=null OUTPUT,
		@dmCurrentUnits decimal(19,8)=null OUTPUT,
		@intUpdatedBy int=null OUTPUT
	)
AS
	set nocount on
	if @Action = 'S'
	begin
		if not exists(select 'true' from Equipments where OrgId=@OrgId and [Id]=@Id)
		begin
			return -1
		end
		else
		begin
			select 	@PMScheduleId = E.PMScheduleId,
				@vchPMSchedName = ISNULL(PM.vchName, ''),
				@InspectScheduleId = E.InspectScheduleId,
				@vchInspectScheduleName = ISNULL([IS].vchName, ''),
				@dmCurrentUnits = E.dmCurrentUnits
			from Equipments E
			left outer join PMSchedules PM 
			on PM.OrgId = @OrgId 
			and PM.[Id] = E.PMScheduleId
			left outer join InspectSchedules [IS] 
			on [IS].OrgId = @OrgId 
			and [IS].[Id] = E.InspectScheduleId
			where E.OrgId = @OrgId 
			and E.[Id] = @Id
	
			return 0
		end
	end
	if @Action = 'U'
	begin
		if not exists(select 'true' from Equipments where OrgId=@OrgId and [Id]=@Id)
		begin
			return -1
		end
		else
		begin
			insert into [EquipUnitLogs](
				[OrgId], 
				[EquipId], 
				[LogTypeId], 
				[dtDate], 
				[dmUnits]
				)
			values(
				@OrgId, 
				@Id,
				2,
				getdate(),
				@dmCurrentUnits
				)
			update 	[Equipments]
			set 	[PMScheduleId] = @PMScheduleId,
				[InspectScheduleId] = @InspectScheduleId,
				[dmCurrentUnits] = @dmCurrentUnits,
				[intUpdatedBy] = @intUpdatedBy,
				[dtUpdated] = getdate()
			where 	[OrgId] = @OrgId 
			and 	[Id] = @Id
			return 0
		end
	end
	return 0



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

