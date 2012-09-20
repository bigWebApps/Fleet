SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER   PROCEDURE sp_EquipmentDetail_Alt
	(
		@Action char(1),
		@OrgId int,
		@Id int,
		@PMScheduleId int=null OUTPUT,
		@vchPMSchedName varchar(25)=null OUTPUT,
		@InspectId int=null OUTPUT,
		@vchInspectName varchar(50)=null OUTPUT,
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
				@InspectId = E.InspectId,
				@vchInspectName = ISNULL(I.vchName, ''),
				@dmCurrentUnits = E.dmCurrentUnits
			from Equipments E
			left outer join PMSchedules PM 
			on PM.OrgId = @OrgId and PM.[Id] = E.PMScheduleId
			left outer join Inspections I 
			on I.OrgId = @OrgId and I.[Id] = E.InspectId
			where E.OrgId = @OrgId and E.[Id] = @Id
	
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
				[InspectId] = @InspectId,
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

