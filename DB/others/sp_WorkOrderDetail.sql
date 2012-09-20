SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER  procedure sp_WorkOrderDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int,
		@WorkOrderNumber int=null output,
		@EquipId int=null output,
		@vchEquipId varchar(50)=null output,
		@vchEquipTypeName varchar(50)=null output,
		@vchEquipMakeModel varchar(102)=null output,
		@vchEquipYear varchar(25)=null output,
		@SpareEquipId int=null output,
		@vchSpareEquipId varchar(50)=null output,
		@StatusId int=null OUTPUT,
		@vchStatus varchar(25)=null OUTPUT,
		@DataId int=null OUTPUT,
		@btIsActive bit=null output,
		@vchDesc varchar(8000)=null output,
		@intOperatorId int=null OUTPUT,
		@vchOperatorName varchar(102)=null OUTPUT,
		@intTechId int=null OUTPUT,
		@vchTechName varchar(102)=null OUTPUT,
		@dmMileage decimal(19,8)=null OUTPUT,
		@bitStaying int=null OUTPUT,
		@vchDropedOffBy varchar(50)=null OUTPUT,
		@vchReleasedTo varchar(50)=null OUTPUT,
		@vchCleanliness varchar(1000)=null output,
		@dtScheduled datetime=null OUTPUT,
		@dtArrival datetime=null OUTPUT,
		@dtOpened datetime=null OUTPUT,
		@dtCompleted datetime=null OUTPUT,
		@dtClosed datetime=null OUTPUT,
		@dtDeparture datetime=null OUTPUT,
		@intCreatedBy int=null OUTPUT,
		@vchCreatedBy varchar(102)=null OUTPUT,
		@dtCreated datetime=null OUTPUT,
		@intUpdatedBy int=null OUTPUT,
		@vchUpdatedBy varchar(102)=null OUTPUT,
		@dtUpdated datetime=null OUTPUT,
		@btWizardUpdate bit
	)
as
	set nocount on
	
	if @Action = 'S'
	begin
		if not exists(select 'true' from WorkOrders where OrgId=@OrgId and [Id]=@Id)
		begin
			return -1
		end
		else
		begin
			select 	@WorkOrderNumber = WO.[WorkOrderNumber], 
				@EquipId = WO.[EquipId], 
				@vchEquipId = E.vchEquipId,
				@vchEquipTypeName = isnull(ET.vchName, 'unknown'),
				@vchEquipMakeModel = isnull(EMa.vchMakeName, 'unknown') + '/' + isnull(EMo.vchModelName, 'unknown'),
				@vchEquipYear = isnull(E.intYear, 0),
				@StatusId = WO.[StatusId], 
				@vchStatus = WOS.vchStatus,
				@SpareEquipId = convert(varchar, isnull(WO.SpareEquipId, 0)),
				@vchSpareEquipId = isnull(SpE.vchEquipId, 'none'),
				@DataId = WO.[DataId], 
				@btIsActive = WO.btIsActive,
				@vchDesc = WO.vchDesc,
				@intOperatorId = isnull(WO.[intOperatorId], 0),
				@vchOperatorName = (select case when isnull(WO.[intOperatorId], 0) = 0 then 'Unassigned' else LOP.vchLastName + ', ' + LOP.vchFirstName end),
				@intTechId = isnull(WO.[intTechId], 0), 
				@vchTechName = (select case when isnull(WO.[intTechId], 0) = 0 then 'Unassigned' else LOT.vchLastName + ', ' + LOT.vchFirstName end),
				@dmMileage = isnull(WO.[dmMileage], 0.0), 
				@bitStaying = WO.[bitStaying], 
				@vchDropedOffBy = isnull(WO.[vchDropedOffBy], ''), 
				@vchReleasedTo = isnull(WO.[vchReleasedTo], ''), 
				@vchCleanliness = isnull(WO.[vchCleanliness], ''),
				@dtScheduled = WO.[dtScheduled],
				@dtArrival = WO.[dtArrival],
				@dtOpened = WO.[dtOpened],
				@dtCompleted = WO.dtCompleted,
				@dtClosed = WO.[dtClosed],
				@dtDeparture = WO.[dtDeparture],
				@intCreatedBy = WO.[intCreatedBy],
				@dtCreated = WO.[dtCreated],
				@vchCreatedBy = ISNULL(LOC.vchLastName, 'Unknown') + ', ' + ISNULL(LOC.vchFirstName, 'Unknown'),
				@intUpdatedBy = WO.[intUpdatedBy],
				@vchUpdatedBy = ISNULL(LOU.vchLastName, 'Unknown') + ', ' + ISNULL(LOU.vchFirstName, 'Unknown'),
				@dtUpdated = WO.[dtUpdated]
			from [WorkOrders] WO
			inner join Equipments E
			on 	WO.EquipId = E.[Id]
			and 	WO.OrgId = E.OrgId
			and 	WO.OrgId = @OrgId
			and 	WO.[Id] = @Id
			inner join EquipTypes ET
			on 	E.TypeId = ET.[Id]
			and 	E.OrgId = ET.OrgId
			left outer join EquipModels EMo
			on 	EMo.OrgId = @OrgId 
			and 	EMo.[Id] = E.ModelId 
			left outer join EquipModelType EMT
			on 	EMT.OrgId = @OrgId 
			and 	EMT.[Id] = EMo.TypeId
			left outer join EquipMakes EMa
			on 	EMa.OrgId = @OrgId 
			and 	EMa.[Id] = EMT.MakeId
			left outer join Equipments SpE
			on 	isnull(WO.SpareEquipId, 0) = SpE.[Id]
			and 	WO.OrgId = SpE.OrgId
			inner join WorkOrderStatus WOS
			on 	WO.StatusId = WOS.[Id]
			left outer join Logins LOP
			on 	WO.intOperatorId = LOP.[Id]
			left outer join Logins LOT
			on 	WO.intTechId = LOT.[Id]
			left outer join Logins LOC
			on 	WO.intCreatedBy = LOC.[Id]
			left outer join Logins LOU
			on 	WO.intUpdatedBy = LOU.[id]

			return 0
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin 
			-- insert Work Order and EquipData
			select @WorkOrderNumber = isnull(max(WorkOrderNumber), 0) + 1
			from WorkOrders
			where datediff(minute, dateadd(d, datediff(d, '', @dtCreated), ''), dtCreated) > 0
			and datediff(minute, dtCreated, dateadd(day, 1, dateadd(d, datediff(d, '', @dtCreated), ''))) > 0

			select @intOperatorId = AssignedTo
			from Equipments
			where [Id] = @EquipId
			and OrgId = @OrgId

			insert into [EquipUnitLogs](
				[OrgId], 
				[EquipId], 
				[LogTypeId], 
				[dtDate], 
				[dmUnits]
				)
			values(
				@OrgId, 
				@EquipId,
				1,
				@dtCreated,
				@dmMileage
				)

			update Equipments
			set dmCurrentUnits = @dmMileage
			where [Id] = @EquipId
			and OrgId = @OrgId

			insert into [EquipData](
				[OrgId], 
				[intCreatedBy], 
				[dtCreated], 
				[intUpdatedBy], 
				[dtUpdated], 
				[vchOrdering], 
				[ftItemOrder], 
				[intSize]
				)
			values(
				@OrgId,
				@intCreatedBy,
				@dtCreated,
				@intUpdatedBy,
				@dtCreated,
				null, 
				null, 
				0
				)
			select @DataId = scope_identity()
			
			insert into [WorkOrders](
				[OrgId], 
				[WorkOrderNumber], 
				[EquipId], 
				[SpareEquipId],
				[StatusId], 
				[DataId], 
				[intOperatorId], 
				[intTechId], 
				[dmMileage], 
				[bitStaying], 
				[vchDropedOffBy], 
				[vchReleasedTo],
				[vchCleanliness],
				[dtScheduled], 
				[dtArrival], 
				[dtOpened], 
				[dtCompleted],
				[dtClosed], 
				[dtDeparture], 
				[intCreatedBy], 
				[dtCreated], 
				[intUpdatedBy], 
				[dtUpdated]
				)
			values(
				@OrgId, 
				@WorkOrderNumber,
				@EquipId,
				@SpareEquipId,
				@StatusId,
				@DataId,
				@intOperatorId,
				@intTechId,
				@dmMileage,
				@bitStaying,
				@vchDropedOffBy,
				@vchReleasedTo,
				@vchCleanliness,
				@dtScheduled,
				@dtArrival,
				@dtOpened,
				@dtCompleted,
				@dtClosed,
				@dtDeparture,
				@intCreatedBy,
				@dtCreated,
				@intUpdatedBy,
				@dtCreated
				)

			return scope_identity()
			
		end
		else
		begin -- update Work Order
			if not exists(select 'true' from WorkOrders where OrgId=@OrgId and [Id]=@Id)
			begin
				return -1
			end
			else
			begin
				if isnull(@btWizardUpdate, 0) = 1
				begin -- update for wo_editAddInfo.aspx screen

					update 	[WorkOrders]
					set 	[intTechId] = @intTechId,
						[StatusId] = @StatusId,
						[dmMileage] = @dmMileage,
						[bitStaying] = @bitStaying,
						[vchDropedOffBy] = @vchDropedOffBy,
						[dtScheduled] = @dtScheduled,
						[dtArrival] = @dtArrival,
						[intUpdatedBy] = @intUpdatedBy,
						[dtUpdated] = getdate()
					where 	[OrgId] = @OrgId 
					and 	[Id] = @Id
			
					update WorkOrderInspections
					set TechId = @intTechId
					where WorkOrderId = @Id
					and OrgId = @OrgId

					update Equipments
					set dmCurrentUnits = @dmMileage
					from WorkOrders WO
					where WO.OrgId = @OrgId
					and WO.[Id] = @Id
					and Equipments.[Id] = WO.EquipId
	
					insert into [EquipUnitLogs](
						[OrgId], 
						[EquipId], 
						[LogTypeId], 
						[dtDate], 
						[dmUnits]
						)
					select 	OrgId, 
						EquipId,
						1,
						getdate(),
						dmMileage
					from 	WorkOrders
					where 	[OrgId] = @OrgId 
					and 	[Id] = @Id

				end
				else
				begin -- update for wo_editWorkOrder.aspx

					-- if the spare is updating then assign the spare equipment
					declare @SpareEquipIdFrom int
					declare @intAssignedTo int

					select 	@SpareEquipIdFrom = SpareEquipId,
						@intAssignedTo = intOperatorId
					from 	[WorkOrders]
					where 	[OrgId] = @OrgId 
					and 	[Id] = @Id

					if isnull(@SpareEquipIdFrom, 0) <> isnull(@SpareEquipId, 0)
					begin -- assign or unassign the spare equipment 
						if isnull(@SpareEquipIdFrom, 0) <> 0
						begin -- unassign the old spare equipment

							insert into EquipAssignLogs (OrgId, EquipId, AssignedFrom, AssignedTo, AssignedBy, vchNote, dtUpdated) 
							select @OrgId, @SpareEquipIdFrom, AssignedTo, null, @intUpdatedBy, 'checking in the spare equipment', getdate()
							from Equipments
							where [Id] = @SpareEquipIdFrom
							and OrgId = @OrgId

							update Equipments
							set AssignedTo = null
							where [Id] = @SpareEquipIdFrom
							and OrgId = @OrgId
						end

						if isnull(@SpareEquipId, 0) <> 0
						begin -- assign the new spare equipment
		
							insert into EquipAssignLogs (OrgId, EquipId, AssignedFrom, AssignedTo, AssignedBy, vchNote, dtUpdated) 
							select @OrgId, @SpareEquipId, AssignedTo, @intAssignedTo, @intUpdatedBy, 'checking out the spare equipment', getdate()
							from Equipments
							where [Id] = @SpareEquipId
							and OrgId = @OrgId

							update Equipments
							set AssignedTo = @intAssignedTo 
							where OrgId = @OrgId 
							and [Id] = @SpareEquipId
						end
					end

					-- updating the order
					update 	[WorkOrders]
					set 	[StatusId] = isnull(@StatusId, StatusId),
						[SpareEquipId] = @SpareEquipId,
						[intTechId] = @intTechId,
						[bitStaying] = isnull(@bitStaying, bitStaying),
						[vchDropedOffBy] = @vchDropedOffBy,
						[vchReleasedTo] = @vchReleasedTo,
						[vchCleanliness] = @vchCleanliness,
						[dtScheduled] = isnull(@dtScheduled, dtScheduled),
						[dtArrival] = @dtArrival,
						[dtDeparture] = @dtDeparture,
						[intUpdatedBy] = isnull(@intUpdatedBy, intUpdatedBy),
						[dtUpdated] = getdate()
					where 	[OrgId]=@OrgId 
					and 	[Id]=@Id

					update WorkOrderInspections
					set TechId = @intTechId
					where WorkOrderId = @Id
					and OrgId = @OrgId

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

