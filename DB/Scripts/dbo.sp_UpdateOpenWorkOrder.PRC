SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_UpdateOpenWorkOrder]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_UpdateOpenWorkOrder]
GO



CREATE procedure dbo.sp_UpdateOpenWorkOrder
	(
		@OrgId int,
		@Id int,
		@intTechId int,
		@dmCurrentUnits decimal(19,8),
		@vchDropedOffBy varchar(50),
		@UserId int,
		@dtCurrentDate datetime
	)
as
	set nocount on
	declare @EquipId int
	
	if not exists(select 'true' from WorkOrders where OrgId=@OrgId and [Id]=@Id)
	begin
		return -1
	end
	else
	begin
		select 	@EquipId = EquipId 
		from 	[WorkOrders]
		where 	[Id] = @Id
		and 	[OrgId] = @OrgId 

		if exists(select 'true' 
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
				[dtUpdated] = @dtCurrentDate
			where 	[Id] = @Id
			and 	[OrgId] = @OrgId 
	
			update WorkOrderInspections
			set TechId = @intTechId
			where WorkOrderId = @Id
			and OrgId = @OrgId
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
		
				update 	[WorkOrders]
				set 	[dmMileage] = @dmCurrentUnits
				where 	[Id] = @Id
				and 	[OrgId] = @OrgId 
			end
			return 0
		end
	end



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

