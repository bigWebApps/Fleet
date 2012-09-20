--
-- Script To Update dbo.sp_SelectInspectionsListForWorkOrder Procedure In largo.BFS_Beta
-- Generated Saturday, August 5, 2006, at 01:17 PM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Updating dbo.sp_SelectInspectionsListForWorkOrder Procedure'
GO

SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, QUOTED_IDENTIFIER, CONCAT_NULL_YIELDS_NULL ON
GO

SET NUMERIC_ROUNDABORT OFF
GO


IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
exec('----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 09/09/2005 
-- Description: The procedure select inspection list for the work order
---------------------------------------------------------------------------
ALTER  procedure dbo.sp_SelectInspectionsListForWorkOrder
	(
		@OrderId int,
		@OrgId int,
		@CurDate datetime
	)
as
	set nocount on
	declare @EquipId int

	select 	@EquipId = EquipId
	from 	WorkOrders 
	where 	[Id] = @OrderId
	and 	OrgId = @OrgId

	select 	ISD.[Id],
		isnull(WOI.[Id], 0) as ItemId,
		@OrderId as WorkOrderId,
		isnull(EIH.[Id], 0) as HistoryId,
		case when isnull(WOI.[Id], 0) = 0 then ''False'' else ''True'' end as IsChecked,
		case when isnull(WOI.btIsProcessed, 0) = 0 then ''True'' else ''False'' end  as IsCompeted,
		I.vchName,
		case when isnull(EIH.[Id], 0) = 0 then ''No Service History''
		else 	case when (ISD.TargetDaysOut - datediff(day, EIH.dtDate, @CurDate)) > 0 then 
				case when ISD.MinimumDaysOut > datediff(day, EIH.dtDate, @CurDate) then ''Okay'' 
				else ''Due Soon'' end 
			else ''Due'' end
		end as StatusName,
		case when isnull(EIH.[Id], 0) = 0 then ''''
		else convert(varchar, dateadd(day, (ISD.TargetDaysOut - datediff(day, EIH.dtDate, @CurDate)), @CurDate), 101)
		end as DateDue,
		ISD.TargetDaysOut as TargetDaysOut,
		ISD.MinimumDaysOut as MinimumDaysOut,
		ISD.MaximumDaysOut as MaximumDaysOut,
		case when isnull(EIH.[Id], 0) = 0 then ''''
		else convert(varchar, EIH.dtDate, 101)
		end as DateLastInspected,
		case when isnull(EIH.[Id], 0) <> 0 then ''False'' else ''True'' end as VisibleLink,
		case when isnull(EIH.[Id], 0) <> 0 then 	
			case when (ISD.TargetDaysOut - datediff(day, EIH.dtDate, @CurDate)) > 0
			then ''black'' else ''red'' end
		else ''red'' end as Color
	from InspectSchedDetails ISD
	inner join Equipments E 
	on E.[Id] = @EquipId
	and E.OrgId = @OrgId
	and ISD.InspectSchedId = E.InspectScheduleId
	and ISD.OrgId = E.OrgId
	inner join InspectSchedules [IS]
	on ISD.InspectSchedId = [IS].[Id]
	and ISD.OrgId = [IS].OrgId
	inner join Inspections I
	on I.[Id] = ISD.InspectionId
	and I.OrgId = ISD.OrgId
	left join EquipInspectHistory EIH
	on EIH.EquipId = @EquipId
	and ISD.OrgId = EIH.OrgId
	and ISD.[Id] = EIH.InspectSchedDetailId
	and EIH.[Id] in ( 
		select EIH_D.[Id]
		from EquipInspectHistory EIH_D
		inner join (
			select max([Id]) as m, InspectSchedDetailId
			from EquipInspectHistory
			where EquipId = @EquipId
			and OrgId = @OrgId
			group by InspectSchedDetailId
			) EIH_G
		on EIH_D.InspectSchedDetailId = EIH_G.InspectSchedDetailId
		and EIH_D.[Id] = EIH_G.m
		)
	left outer join WorkOrderInspections WOI
	on WOI.InspectSchedDetailId = ISD.[Id]
	and WOI.OrgId = ISD.OrgId
	and WOI.WorkOrderId = @OrderId
	order by ISD.[Id] asc')
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectInspectionsListForWorkOrder Procedure Updated Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Update dbo.sp_SelectInspectionsListForWorkOrder Procedure'
END
GO

--
-- Script To Update dbo.sp_SigningInspection Procedure In largo.BFS_Beta
-- Generated Saturday, August 5, 2006, at 01:17 PM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Updating dbo.sp_SigningInspection Procedure'
GO

SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, QUOTED_IDENTIFIER, CONCAT_NULL_YIELDS_NULL ON
GO

SET NUMERIC_ROUNDABORT OFF
GO


IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
exec('----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Last Modification Date: 09/09/2005
-- Description: Procedure sign the inspection from technician
---------------------------------------------------------------------------
ALTER  procedure dbo.sp_SigningInspection
	(
		@OrgId int,
		@WorkOrderId int,
		@InspectId int,
		@chInitials char(3),
		@vchPIN varchar(10),
		@dtCurrentDate datetime
	)
AS
	set nocount on
	declare @CountItems int
	
	if exists(select ''true'' from Logins where Initials = @chInitials and PIN = @vchPIN)
	begin
		select @CountItems = count([Id])
		from WorkOrderInspectItems 
		where WorkOrderInspectId = @InspectId
		and WorkOrderId = @WorkOrderId
		and OrgId = @OrgId
		and (	isnull(ServiceCheckId, 0) = 0 
			or (	isnull(ServiceCheckId, 0) = 3 
				and isnull(ServiceResultId, 0) = 0
				)
			)
		if @CountItems > 0 -- if there are uncompleted items 
		begin 
			return -2
		end
		else
		begin
			update WorkOrderInspections
			set btIsProcessed = 1
			where [Id] = @InspectId
			and WorkOrderId = @WorkOrderId
			and OrgId = @OrgId
	
			insert into [SignedDocuments](
				[OrgId], 
				[UserId], 
				[DocumentId], 
				[DocumentTypeId], 
				[dtSignDate]
				)
			select 	@OrgId,
				L.[Id],
				@InspectId,
				2,
				@dtCurrentDate
			from Logins L 
			where L.Initials = @chInitials 
			and L.PIN = @vchPIN
			-- the history table is keeping the inspection history 
			-- of equipment
			insert into EquipInspectHistory (
				OrgId, 
				EquipId,
				dtDate,
				InspectSchedDetailId,
				WorkOrderId
				)
			select	@OrgId,
				WO.EquipId,
				@dtCurrentDate,
				ISD.[Id],
				@WorkOrderId
			from 	WorkOrderInspections WI
			inner join WorkOrders WO
			on WI.[Id] = @InspectId
			and WI.WorkOrderId = @WorkOrderId
			and WI.OrgId = @OrgId
			and WI.WorkOrderId = WO.[Id]
			and WI.OrgId = WO.OrgId
			inner join InspectSchedDetails ISD
			on ISD.[Id] = WI.InspectSchedDetailId
			and ISD.OrgId = WI.OrgId
	
			return 0
		end
	end
	else
	begin
		return -1
	end')
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SigningInspection Procedure Updated Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Update dbo.sp_SigningInspection Procedure'
END
GO

--
-- Script To Update dbo.sp_SigningWorkOrderOpen Procedure In largo.BFS_Beta
-- Generated Saturday, August 5, 2006, at 01:17 PM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Updating dbo.sp_SigningWorkOrderOpen Procedure'
GO

SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, QUOTED_IDENTIFIER, CONCAT_NULL_YIELDS_NULL ON
GO

SET NUMERIC_ROUNDABORT OFF
GO


IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
exec('ALTER   procedure dbo.sp_SigningWorkOrderOpen
	(
		@OrgId int,
		@WorkOrderId int,
		@chInitials char(3),
		@vchPIN varchar(10),
		@dtCurrentDate datetime
	)
AS
	set nocount on

	if exists(select ''true'' from Logins where Initials = @chInitials and PIN = @vchPIN)
	begin
		if exists(select ''true'' from WorkOrders where [Id] = @WorkOrderId and OrgId = @OrgId)
		begin

			select @dtCurrentDate = dtOpened
			from WorkOrders
			where 	[Id] = @WorkOrderId
			and 	OrgId = @OrgId

			update 	WorkOrders
			set 	StatusId = 1
			where 	[Id] = @WorkOrderId
			and 	OrgId = @OrgId
	
			insert into [SignedDocuments](
				[OrgId], 
				[UserId], 
				[DocumentId], 
				[DocumentTypeId], 
				[dtSignDate]
				)
			select 	@OrgId,
				L.[Id],
				@WorkOrderId,
				5,
				@dtCurrentDate
			from Logins L 
			where L.Initials = @chInitials 
			and L.PIN = @vchPIN
	
			return 0
		end
		else
		begin
			return -2
		end
	end
	else
	begin
		return -1
	end')
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SigningWorkOrderOpen Procedure Updated Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Update dbo.sp_SigningWorkOrderOpen Procedure'
END
GO

--
-- Script To Update dbo.sp_UpdateInspections Procedure In largo.BFS_Beta
-- Generated Saturday, August 5, 2006, at 01:17 PM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Updating dbo.sp_UpdateInspections Procedure'
GO

SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, QUOTED_IDENTIFIER, CONCAT_NULL_YIELDS_NULL ON
GO

SET NUMERIC_ROUNDABORT OFF
GO


IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
exec('----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 09/09/2005 
-- Description: The procedure add/delete inspection to the work order
---------------------------------------------------------------------------
ALTER  procedure dbo.sp_UpdateInspections
	(
		@btChecked bit,
		@OrgId int,
		@OrderId int,
		@ItemId int=null,
		@InspectSchedDetailId int,
		@CurrDate datetime
	)
AS
	set nocount on
	declare @tbl table ([Id] int identity(1,1), RepairItemId int)
	declare @tbl2 table (RepairId int)
	declare @IsDelete bit
	declare @i int, @N int, @j int, @M int
	
	if isnull(@btChecked, 0) = 0
	begin -- remove inspection or nothing
		if exists(select ''true'' from WorkOrderInspections where [Id] = isnull(@ItemId, 0) and OrgId = @OrgId)
		begin -- unchecked [delete item and his sub-items]
			-- define all RepairItemIds related to the Inspection

			insert into @tbl(RepairItemId)
			select RepairItemId
			from WorkOrderInspectItems
			where WorkOrderInspectId = isnull(@ItemId, 0)
			and OrgId = @OrgId
			and isnull(RepairItemId, 0) <> 0
			
			-- processing all repairs, if repair has the other sources 
			-- as PM items or Issues then we don''t delete this repair
			-- or else we delete records of RepairMult, PartsUsed and
			-- Repairs tables
			select @i = 1, @N = scope_identity()
			while @i <= @N
			begin
				select @IsDelete = 1
				if exists(select ''true'' 
					from WorkOrderPMItems PMI
					inner join @tbl tmp
					on PMI.OrgId = @OrgId
					and PMI.WorkOrderId = @OrderId
					and PMI.RepairItemId = tmp.RepairItemId
					and tmp.[Id] = @i
					)
				begin
					select @IsDelete = 0
				end
				if exists(select ''true'' 
					from WorkOrderReportedIssues RI
					inner join @tbl tmp 
					on RI.OrgId = @OrgId
					and RI.WorkOrderId = @OrderId
					and RI.RepairItemId = tmp.RepairItemId
					and tmp.[Id] = @i
					)
				begin
					select @IsDelete = 0
				end

				if @IsDelete = 1
				begin -- deleting the relate records
					insert into @tbl2(RepairId)
					select RepairId
					from RepairMult
					where OrgId = @OrgId
					and ItemId in (
						select RepairItemId
						from @tbl
						where [Id] = @i
						)
					select @j = 1, @M = scope_identity()

					delete from RepairMult
					where OrgId = @OrgId
					and ItemId in (
						select RepairItemId
						from @tbl
						where [Id] = @i
						)

					-- deleting all repairs, if repair has other issues (or other item) 
					-- then don''t delete it
					while @j <= @M
					begin
						if not exists(select ''true'' 
							from RepairMult 
							where OrgId = @OrgId 
							and RepairId in (
								select RepairId
								from @tbl2
								where [Id] = @j
								)
							)
						begin
							delete from PartsUsed
							where OrgId = @OrgId
							and RepairId in (
								select RepairId
								from @tbl2
								where [Id] = @j
								)
			
							delete from Repairs
							where OrgId = @OrgId
							and [Id] in (
								select RepairId
								from @tbl2
								where [Id] = @j
								)
						end
						select @j = @j + 1
					end
				end

				select @i = @i + 1
			end

			-- delete inspection items
			delete from WorkOrderInspectItems
			where [WorkOrderInspectId] = @ItemId
			and WorkOrderId = @OrderId
			and OrgId = @OrgId

			-- delete inspection
			delete from WorkOrderInspections
			where [Id] = @ItemId
			and WorkOrderId = @OrderId
			and OrgId = @OrgId
			return 0
		end
		else -- nothing
		begin
			return -1
		end
	end
	else
	begin -- add inspection or nothing

		if not exists(select ''true'' from WorkOrderInspections where [Id] = isnull(@ItemId, 0) and OrgId = @OrgId)
		begin -- checked [insert item and his sub-items]
			insert into WorkOrderInspections(
				[OrgId], 
				[WorkOrderId], 
				[InspectSchedDetailId],
				[TechId],
				[dtReport],
				[btIsProcessed]
				)
			select	@OrgId,
				@OrderId,
				@InspectSchedDetailId,
				WO.intTechId,
				@CurrDate,
				0
			from WorkOrders WO
			where [Id] = @OrderId
			and OrgId = @OrgId

			select @ItemId = scope_identity()

			insert into [WorkOrderInspectItems](
				[OrgId], 
				[WorkOrderId], 
				[WorkOrderInspectId], 
				[ItemId], 
				[ServiceResultId], 
				[ServiceCheckId], 
				[RepairItemId])
			select 	@OrgId,
				@OrderId,
				@ItemId,
				II.[Id],
				null,
				null,
				null
			from InspectionItems II
			inner join InspectSchedDetails ISD
			on ISD.[Id] = @InspectSchedDetailId
			and ISD.InspectionId = II.InspectId 
			and ISD.OrgId = @OrgId
			and ISD.OrgId = II.OrgId
			and II.btEnabled = 1
			order by II.InspectCatId, II.tintOrder asc

			return @ItemId
		end
		else -- nothing
		begin
			return -1
		end
	end')
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_UpdateInspections Procedure Updated Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Update dbo.sp_UpdateInspections Procedure'
END
GO

--
-- Script To Update dbo.sp_UpdateOpenWorkOrder Procedure In largo.BFS_Beta
-- Generated Saturday, August 5, 2006, at 01:17 PM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Updating dbo.sp_UpdateOpenWorkOrder Procedure'
GO

SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, QUOTED_IDENTIFIER, CONCAT_NULL_YIELDS_NULL ON
GO

SET NUMERIC_ROUNDABORT OFF
GO


IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
exec('ALTER procedure dbo.sp_UpdateOpenWorkOrder
	(
		@OrgId int,
		@Id int,
		@intTechId int,
		@dmCurrentUnits decimal(19,8),
		@vchDropedOffBy varchar(50),
		@UserId int,
		@dtOpened datetime,
		@dtCurrentDate datetime
	)
as
	set nocount on
	declare @EquipId int
	
	if not exists(select ''true'' from WorkOrders where OrgId=@OrgId and [Id]=@Id)
	begin
		return -1
	end
	else
	begin
		select 	@EquipId = EquipId 
		from 	[WorkOrders]
		where 	[Id] = @Id
		and 	[OrgId] = @OrgId 

		if exists(select ''true'' 
			from WorkOrders 
			where EquipId = @EquipId
			and [OrgId] = @OrgId 
			and StatusId in (1, 4, 5, 6))
		begin
			return -2
		end
		else
		begin
			update 	[WorkOrders]
			set 	[intTechId] = @intTechId,
				[vchDropedOffBy] = @vchDropedOffBy,
				[intUpdatedBy] = isnull(@UserId, intUpdatedBy),
				[dtOpened] = @dtOpened,
				[dtUpdated] = @dtCurrentDate
			where 	[Id] = @Id
			and 	[OrgId] = @OrgId 
	
			update WorkOrderInspections
			set TechId = @intTechId
			where WorkOrderId = @Id
			and OrgId = @OrgId
			if exists(select ''true'' 
				from Equipments 
				where [Id] = @EquipId
				and OrgId = @OrgId 
				and dmCurrentUnits < @dmCurrentUnits
				)
			begin
				-- update the current units of equipment 
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
					@dtOpened,
					@dmCurrentUnits
					)
		
				update Equipments
				set dmCurrentUnits = @dmCurrentUnits
				where [Id] = @EquipId
				and OrgId = @OrgId
		
				update 	[WorkOrders]
				set 	[dmMileage] = @dmCurrentUnits
				where 	[Id] = @Id
				and 	[OrgId] = @OrgId 
			end
			return 0
		end
	end')
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_UpdateOpenWorkOrder Procedure Updated Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Update dbo.sp_UpdateOpenWorkOrder Procedure'
END
GO

--
-- Script To Update dbo.sp_WorkOrderDetail Procedure In largo.BFS_Beta
-- Generated Saturday, August 5, 2006, at 01:17 PM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Updating dbo.sp_WorkOrderDetail Procedure'
GO

SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, QUOTED_IDENTIFIER, CONCAT_NULL_YIELDS_NULL ON
GO

SET NUMERIC_ROUNDABORT OFF
GO


IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
exec('----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 06/06/2005
-- Description: The procedure get information about work order and his 
-- equipment, update work order and ALTER  a new work order
---------------------------------------------------------------------------
ALTER procedure dbo.sp_WorkOrderDetail
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
	
	if @Action = ''S''
	begin
		if not exists(select ''true'' from WorkOrders where OrgId=@OrgId and [Id]=@Id)
		begin
			return -1
		end
		else
		begin
			select 	@WorkOrderNumber = WO.[WorkOrderNumber], 
				@EquipId = WO.[EquipId], 
				@vchEquipId = E.vchEquipId,
				@vchEquipTypeName = isnull(ET.vchName, ''unknown''),
				@vchEquipMakeModel = isnull(EMa.vchMakeName, ''unknown'') + ''/'' + isnull(EMo.vchModelName, ''unknown''),
				@vchEquipYear = isnull(E.intYear, 0),
				@vchVinSerial = ISNULL(E.vchVinSerial, ''''),
				@TypeId = WO.TypeId,
				@vchType = WOT.vchName,
				@StatusId = WO.[StatusId], 
				@vchStatus = WOS.vchStatus,
				@OperatorStatusId = isnull(WO.OperatorStatusId, 0),
				@vchOperatorStatus = isnull(WOOS.vchStatus, ''''),
				@SpareEquipId = isnull(WO.SpareEquipId, 0),
				@vchSpareEquipId = isnull(SpE.vchEquipId, ''none''),
				@DataId = WO.[DataId], 
				@btIsActive = WO.btIsActive,
				@intOperatorId = isnull(WO.[intOperatorId], 0),
				@vchOperatorName = (select case when isnull(WO.[intOperatorId], 0) = 0 then '''' else LOP.vchLastName + '', '' + LOP.vchFirstName end),
				@intTechId = isnull(WO.[intTechId], 0), 
				@vchTechName = (select case when isnull(WO.[intTechId], 0) = 0 then '''' else LOT.vchLastName + '', '' + LOT.vchFirstName end),
				@dmMileage = isnull(WO.[dmMileage], 0.0), 
				@bitStaying = WO.[bitStaying], 
				@vchDropedOffBy = isnull(WO.[vchDropedOffBy], ''''), 
				@vchReleasedTo = isnull(WO.[vchReleasedTo], ''''), 
				@vchCleanliness = isnull(WO.[vchCleanliness], ''''),
				@dtScheduled = WO.[dtScheduled],
				@dtArrival = WO.[dtArrival],
				@dtOpened = WO.[dtOpened],
				@dtCompleted = WO.dtCompleted,
				@dtClosed = WO.[dtClosed],
				@dtDeparture = WO.[dtDeparture],
				@intCreatedBy = WO.[intCreatedBy],
				@dtCreated = WO.[dtCreated],
				@vchCreatedBy = ISNULL(LOC.vchLastName, ''Unknown'') + '', '' + ISNULL(LOC.vchFirstName, ''Unknown''),
				@intUpdatedBy = WO.[intUpdatedBy],
				@vchUpdatedBy = ISNULL(LOU.vchLastName, ''Unknown'') + '', '' + ISNULL(LOU.vchFirstName, ''Unknown''),
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
	if @Action = ''U''
	begin
		if @Id = 0
		begin 
			-- insert Work Order and EquipData
			select @WorkOrderNumber = isnull(max(WorkOrderNumber), 0) + 1
			from WorkOrders
			where datediff(minute, dateadd(d, datediff(d, '''', @dtCreated), ''''), dtCreated) > 0
			and datediff(minute, dtCreated, dateadd(day, 1, dateadd(d, datediff(d, '''', @dtCreated), ''''))) > 0

			if exists(select ''true'' 
				from Equipments 
				where [Id] = @EquipId
				and OrgId = @OrgId
				and isnull(EquipOperatorId, 0) = 0
				and isnull(TempOperatorId, 0) = 0)
				select @intOperatorId = isnull(@intUpdatedBy, 6)
			else
				select @intOperatorId = (case when isnull(EquipOperatorId, 0) = 0 then TempOperatorId else EquipOperatorId end)
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
			if not exists(select ''true'' from WorkOrders where OrgId=@OrgId and [Id]=@Id)
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
						[dtArrival] = isnull(@dtArrival, dtArrival),
						[dtOpened] = isnull(@dtOpened, dtOpened),
						[dtClosed] = isnull(@dtClosed, dtClosed),
						[dtDeparture] = isnull(@dtDeparture, dtDeparture),
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
	return 0')
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_WorkOrderDetail Procedure Updated Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Update dbo.sp_WorkOrderDetail Procedure'
END
GO