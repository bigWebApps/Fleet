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
		@vchVinSerial varchar(50)=null OUTPUT,
		@SpareEquipId int=null output,
		@vchSpareEquipId varchar(50)=null output,
		@TypeId int=null output,
		@vchType varchar(50)=null output,
		@StatusId int=null OUTPUT,
		@vchStatus varchar(50)=null OUTPUT,
		@OperatorStatusId int=null output,
		@vchOperatorStatus varchar(50)=null output,
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
				@vchVinSerial = ISNULL(E.vchVinSerial, ''),
				@TypeId = WO.TypeId,
				@vchType = WOT.vchName,
				@StatusId = WO.[StatusId], 
				@vchStatus = WOS.vchStatus,
				@OperatorStatusId = isnull(WO.OperatorStatusId, 0),
				@vchOperatorStatus = isnull(WOOS.vchStatus, ''),
				@SpareEquipId = isnull(WO.SpareEquipId, 0),
				@vchSpareEquipId = isnull(SpE.vchEquipId, 'none'),
				@DataId = WO.[DataId], 
				@btIsActive = WO.btIsActive,
				@intOperatorId = isnull(WO.[intOperatorId], 0),
				@vchOperatorName = (select case when isnull(WO.[intOperatorId], 0) = 0 then '' else LOP.vchLastName + ', ' + LOP.vchFirstName end),
				@intTechId = isnull(WO.[intTechId], 0), 
				@vchTechName = (select case when isnull(WO.[intTechId], 0) = 0 then '' else LOT.vchLastName + ', ' + LOT.vchFirstName end),
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
			inner join WorkOrderTypes WOT
			on 	WO.TypeId = WOT.[Id]
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
			left outer join WorkOrderOperatorStatus WOOS
			on 	WO.OperatorStatusId = WOOS.[Id]
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
				[TypeId],
				[StatusId], 
				[DataId],
				[btIsActive],
				[intOperatorId], 
				[dtScheduled], 
				[intCreatedBy], 
				[dtCreated], 
				[intUpdatedBy], 
				[dtUpdated]
				)
			values(
				@OrgId, 
				@WorkOrderNumber,
				@EquipId,
				@TypeId,
				@StatusId,
				@DataId,
				1,
				@intOperatorId,
				@dtScheduled,
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
					set 	[TypeId] = @TypeId,
						[dtScheduled] = @dtScheduled,
						[intUpdatedBy] = @intUpdatedBy,
						[dtUpdated] = @dtUpdated
					where 	[OrgId] = @OrgId 
					and 	[Id] = @Id
				end
				else
				begin -- update for wo_editWorkOrder.aspx
					update 	[WorkOrders]
					set 	[TypeId] = @TypeId,
						[intTechId] = @intTechId,
						[bitStaying] = isnull(@bitStaying, bitStaying),
						[vchDropedOffBy] = @vchDropedOffBy,
						[vchReleasedTo] = @vchReleasedTo,
						[vchCleanliness] = @vchCleanliness,
						[dtScheduled] = isnull(@dtScheduled, dtScheduled),
						[intUpdatedBy] = isnull(@intUpdatedBy, intUpdatedBy),
						[dtUpdated] = @dtUpdated
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

