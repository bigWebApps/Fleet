SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_EquipmentDetail_Temp
	(
		@Action char(1),
		@OrgId int,
		@Id int,
		@vchType varchar(50) OUTPUT,
		@intTypeId int=null OUTPUT,
		@vchAssignedTo varchar(100)=null OUTPUT,
		@intAssignedTo int=null OUTPUT,
		@vchStatus varchar(50)=null OUTPUT,
		@intStatusId int=null OUTPUT,
		@vchPMSched varchar(25)=null OUTPUT,
		@intPMSched int=null OUTPUT,
		@vchInspect varchar(50)=null OUTPUT,
		@intInspectId int=null OUTPUT,
		@intCurrentUnits int=null OUTPUT,
		@dtInService smalldatetime=null OUTPUT,
		@dtAquired smalldatetime=null OUTPUT,
		@vchPurOrgContact varchar(50)=null OUTPUT,
		@smPurAmount smallmoney=null OUTPUT,
		@intPurUnits int=null OUTPUT,
		@vchPurNotes varchar(250)=null OUTPUT,
		@dtOutOfService smalldatetime=null OUTPUT,
		@dtDisposed smalldatetime=null OUTPUT,
		@vchDispOrgContact varchar(50)=null OUTPUT,
		@smDispAmount smallmoney=null OUTPUT,
		@intDispUnits int=null OUTPUT,
		@vchDispNotes varchar(250)=null OUTPUT,
		@vchDispMethod varchar(25)=null OUTPUT,
		@intDispMethod int=null OUTPUT
	)
AS
	set nocount on

	if @Action = 'S'
	begin
		if not exists(select 'true' from Equipment where OrgId=@OrgId and [Id]=@Id)
		begin
			return -1
		end
		else
		begin
			select 	@vchType = ISNULL(et.vchName, ''),
				@intTypeId = e.TypeId,
				@vchAssignedTo = l.vchLastName+', '+l.vchFirstName,
				@intAssignedTo = e.AssignedTo,
				@vchStatus = ISNULL(es.vchName, ''),
				@intStatusId = e.StatusId,
				@vchPMSched=ISNULL(pm.vchName, ''),
				@intPMSched = ISNULL(e.PMSchedId, 0),
				@vchInspect=ISNULL(i.vchName, ''),
				@intInspectId = ISNULL(e.InspectId, 0),
				@intCurrentUnits= e.intCurrentUnits,
				@dtInService = e.dtInservice,
				@dtAquired = e.dtAquired,
				@vchPurOrgContact = ISNULL(e.vchPurOrgContact, ''), 
				@smPurAmount = e.smPurAmount,
				@intPurUnits = e.intPurUnits,
				@vchPurNotes = ISNULL(e.vchPurNotes, ''),
				@dtOutOfService = e.dtOutOfService,
				@dtDisposed = e.dtDisposed,
				@vchDispOrgContact = ISNULL(e.vchDispOrgContact, ''), 
				@smDispAmount = e.smDispAmount, 
				@intDispUnits = e.intDispUnits,
				@vchDispNotes= ISNULL(e.vchDispNotes, ''), 
				@vchDispMethod = edm.vchName,
				@intDispMethod = e.intDispMethod
			from Equipment e
			left outer join EquipTypes et ON et.OrgId=@OrgId AND et.Id=e.TypeId
			left outer join EquipDisposalMethods edm ON edm.OrgId = @OrgId AND edm.Id = e.intDispMethod
			left outer join Logins l ON l.[Id] = e.AssignedTo
			left outer join EquipStatus es ON es.id=e.StatusId
			left outer join PMSchedules pm ON pm.OrgId=@OrgId AND pm.id=e.PMSchedId
			left outer join Inspections i ON i.OrgId=@OrgId AND i.Id=e.InspectId
			where e.OrgId=@OrgId AND e.Id=@Id
	
			return 0
		end
	end
	if @Action = 'U'
	begin
		if not exists(select 'true' from Equipment where OrgId=@OrgId and [Id]=@Id)
		begin
			return -1
		end
		else
		begin
			if ISNULL(@intAssignedTo, 0) = 0 
			begin
				return 1
			end
			else
			begin
				if ISNULL(@intPMSched, 0) = 0 or ISNULL(@intInspectId, 0) = 0
				begin
					update 	[Equipment]
					set 	[OrgId] = @OrgId, 
						[AssignedTo] = @intAssignedTo,
						[intCurrentUnits] = @intCurrentUnits, 
						[TypeId] = @intTypeId, 
						[dtInservice] = @dtInService, 
						[dtAquired] = @dtAquired, 
						[vchPurOrgContact] = @vchPurOrgContact, 
						[intPurUnits] = @intPurUnits, 
						[smPurAmount] = @smPurAmount, 
						[vchPurNotes] = @vchPurNotes, 
						[StatusId] = @intStatusId, 
						[dtOutOfService] = @dtOutOfService, 
						[dtDisposed] = @dtDisposed, 
						[vchDispOrgContact] = @vchDispOrgContact,
						[intDispUnits] = @intDispUnits, 
						[smDispAmount] = @smDispAmount,
						[vchDispNotes] = @vchDispNotes, 
						[intDispMethod] = @intDispMethod
					where 	OrgId = @OrgId 
					and 	[Id] = @Id
				end
				else
				begin
					update 	[Equipment]
					set 	[OrgId] = @OrgId, 
						[AssignedTo] = @intAssignedTo,
						[PMSchedId] = @intPMSched, 
						[InspectId] = @intInspectId, 
						[intCurrentUnits] = @intCurrentUnits, 
						[TypeId] = @intTypeId, 
						[dtInservice] = @dtInService, 
						[dtAquired] = @dtAquired, 
						[vchPurOrgContact] = @vchPurOrgContact, 
						[intPurUnits] = @intPurUnits, 
						[smPurAmount] = @smPurAmount, 
						[vchPurNotes] = @vchPurNotes, 
						[StatusId] = @intStatusId, 
						[dtOutOfService] = @dtOutOfService, 
						[dtDisposed] = @dtDisposed, 
						[vchDispOrgContact] = @vchDispOrgContact,
						[intDispUnits] = @intDispUnits, 
						[smDispAmount] = @smDispAmount,
						[vchDispNotes] = @vchDispNotes, 
						[intDispMethod] = @intDispMethod
					where 	OrgId = @OrgId 
					and 	[Id] = @Id
				end

				return 0
			end
		end
	end
	return 0
	









GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

