SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SetRoadsideWorkOrder]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SetRoadsideWorkOrder]
GO



----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 07/27/2005
-- Description: creating of the Work Order for Roadside Repair
---------------------------------------------------------------------------
CREATE  procedure sp_SetRoadsideWorkOrder
(
	@OrgId int,
	@EquipId int,
	@TechId int,
	@dtCurrentDate datetime,
	@UserId int,
	@OrderId int output
)
as
	set nocount on

	declare @WorkOrderNumber int
	declare @intOperatorId int
	declare @DataId int

	if @OrderId = 0
	begin
		select @WorkOrderNumber = isnull(max(WorkOrderNumber), 0) + 1
		from WorkOrders
		where datediff(minute, dateadd(d, datediff(d, '', @dtCurrentDate), ''), dtCreated) > 0
		and datediff(minute, dtCreated, dateadd(day, 1, dateadd(d, datediff(d, '', @dtCurrentDate), ''))) > 0
	

		if exists(select 'true' 
			from Equipments 
			where [Id] = @EquipId
			and OrgId = @OrgId
			and isnull(EquipOperatorId, 0) = 0
			and isnull(TempOperatorId, 0) = 0)
			select @intOperatorId = @TechId
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
			[OperatorStatusId],
			[DataId],
			[btIsActive], 
			[intOperatorId], 
			[intTechId],
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
			3,
			3,
			null,
			@DataId,
			1,
			@intOperatorId,
			@TechId,
			@dtCurrentDate,
			@UserId,
			@dtCurrentDate,
			@UserId,
			@dtCurrentDate
			)
	
		select @OrderId = scope_identity()
	end

	return






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

