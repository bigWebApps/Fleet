SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GetInfoForCheckIn]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GetInfoForCheckIn]
GO

CREATE  procedure sp_GetInfoForCheckIn
	(
		@OrgId int,
		@EquipId int,
		@OrderId int=null,
		@vchEquipId varchar(50)=null output,
		@dmCurrentUnits decimal(19,8)=null output,
		@vchMeasure varchar(255)=null output,
		@StatusId int=null output,
		@dtScheduled datetime=null output,
		@dtArrival datetime=null output,
		@bitStaying bit=null output,
		@vchDropedOffBy varchar(50)=null output,
		@bitSpare bit=null output,
		@TechId int=null output
	)
as
	set nocount on
-- нужно вставить при выполнения Check In
/*
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
*/
	if isnull(@OrderId, 0) <> 0
	begin -- editing mode
		if not exists(select 'true' from WorkOrders where [Id] = @OrderId and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			select 	@vchEquipId = E.vchEquipId,
				@dmCurrentUnits = isnull(E.dmCurrentUnits, 0.0),
				@vchMeasure = isnull(UM.vchName, ''),
				@StatusId = WO.StatusId,
				@dtScheduled = WO.dtScheduled,
				@dtArrival = WO.dtArrival,
				@bitStaying = WO.bitStaying,
				@vchDropedOffBy = isnull(WO.vchDropedOffBy, ''),
				@bitSpare = (case when isnull(WO.SpareEquipId, 0) = 0 then 0 else 1 end),
				@TechId = isnull(WO.intTechId, 0)
			from WorkOrders WO
			inner join Equipments E 
			on WO.[Id] = @OrderId
			and WO.OrgId = @OrgId
			and WO.[EquipId] = E.[Id]
			and WO.OrgId = E.OrgId
			inner join EquipTypes ET
			on E.TypeId = ET.[Id]
			and E.OrgId = ET.OrgId
			left join UnitMeasures UM
			on ET.UnitMeasureId = UM.[Id]
		end
	end
	else
	begin -- adding mode
		if not exists(select 'true' from Equipments E 
					inner join EquipTypes ET
					on E.[Id] = @EquipId
					and E.OrgId = @OrgId
					and E.TypeId = ET.[Id]
					and E.OrgId = ET.OrgId)
		begin
			return -1
		end 
		else
		begin
			select 	@vchEquipId = E.[vchEquipId], 
				@vchMeasure = isnull(UM.vchName, ''),
				@dmCurrentUnits = isnull(E.dmCurrentUnits, 0.0),
				@StatusId = 1,
				@dtScheduled = null,
				@dtArrival = null,
				@bitStaying = null,
				@vchDropedOffBy = '',
				@bitSpare = null,
				@TechId = 0
			from Equipments E
			inner join EquipTypes ET
			on E.[Id] = @EquipId
			and E.OrgId = @OrgId
			and E.TypeId = ET.[Id]
			and E.OrgId = ET.OrgId
			left join UnitMeasures UM
			on ET.UnitMeasureId = UM.[Id]
			
			return 0
		end 
	end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

