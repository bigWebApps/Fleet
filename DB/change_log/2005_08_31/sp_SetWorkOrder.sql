SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 06/06/2005
-- Description: selecting or creating of the Work Order for current Equipment
-- if for current equipment there aren't the scheduled work order then 
-- it will be created. If there are one work order then select him.
-- If them more than one then we are selecting the one that has 
-- the scheduled time by closer to the current moment.
---------------------------------------------------------------------------
ALTER procedure sp_SetWorkOrder
(
	@OrgId int,
	@EquipId int,
	@dtCurrentDate datetime,
	@dmCurrentUnits decimal(19, 8),
	@UserId int,
	@OrderId int output
)
as
	set nocount on
	declare @Count int
	declare @WorkOrderNumber int
	declare @intOperatorId int
	declare @DataId int
	if @OrderId = 0
	begin
		select @Count = count([Id])
		from WorkOrders WO
		where WO.StatusId = 3
		and isnull(WO.OperatorStatusId, 0) = 0
		and WO.EquipId = @EquipId
		and datediff(minute, WO.dtScheduled, dateadd(d, 2, dateadd(d, datediff(d, '', @dtCurrentDate), ''))) > 0 

		if isnull(@Count, 0) = 0
		begin -- to create a new work order
	
			select @WorkOrderNumber = isnull(max(WorkOrderNumber), 0) + 1
			from WorkOrders
			where datediff(minute, dateadd(d, datediff(d, '', @dtCurrentDate), ''), dtCreated) > 0
			and datediff(minute, dtCreated, dateadd(day, 1, dateadd(d, datediff(d, '', @dtCurrentDate), ''))) > 0
		
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
				@UserId,
				@dtCurrentDate,
				@UserId,
				@dtCurrentDate,
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
				2,
				3,
				@DataId,
				1,
				@intOperatorId,
				@dtCurrentDate,
				@UserId,
				@dtCurrentDate,
				@UserId,
				@dtCurrentDate
				)
		
			select @OrderId = scope_identity()
		end
		else
		begin
			if isnull(@Count, 0) > 1
			begin -- to define the needed order 
				select top 1 @OrderId = [Id]
				from WorkOrders
				where StatusId = 3
				and isnull(OperatorStatusId, 0) = 0
				and EquipId = @EquipId
				and datediff(minute, dtScheduled, dateadd(d, 2, dateadd(d, datediff(d, '', @dtCurrentDate), ''))) > 0
				order by dtScheduled asc
			end
			else
			begin -- select current order
	
				select @OrderId = [Id]
				from WorkOrders
				where StatusId = 3
				and isnull(OperatorStatusId, 0) = 0
				and datediff(minute, dtScheduled, dateadd(d, 2, dateadd(d, datediff(d, '', @dtCurrentDate), ''))) > 0
				and EquipId = @EquipId
			end
		end
	end
	if exists(select 'true' 
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
			@dtCurrentDate,
			@dmCurrentUnits
			)
	
		update Equipments
		set dmCurrentUnits = @dmCurrentUnits
		where [Id] = @EquipId
		and OrgId = @OrgId

		update 	WorkOrders
		set 	dmMileage = @dmCurrentUnits,
			intUpdatedBy = @UserId, 
			dtUpdated = @dtCurrentDate
		where 	[Id] = @OrderId
		and 	OrgId = @OrgId
	end
	return


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

