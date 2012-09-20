SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create function f_GetUniversalUnits
(
	@PMServiceId int,
	@EquipId int,
	@dtDate datetime, -- current date of Equipment
	@intUnits int -- current units of Equipment
--	@ErrorCode bit=0 output
)
returns int
as
begin
	declare @iResult int
	declare @PMMeasureId int
	declare @EquipMeasureId int
	declare @EquipDispUnits int
	declare @EquipDisposed datetime

	select 	@EquipMeasureId = ET.MeasureId,
		@EquipDispUnits = E.intDispUnits,
		@EquipDisposed = E.dtDisposed
	from EquipTypes ET
	inner join Equipments E
	on E.TypeId = ET.[Id]
	and E.OrgId = ET.OrgId
	and E.[Id] = @EquipId	
	
	if @MeasureId = 1 -- current Miles
	begin
		if @EquipMeasureId = 1 -- Equipment Miles
		begin -- getting miles
			select @iResult = @intUnits - @EquipDispUnits
		end
		if @EquipMeasureId = 2 -- Equipment Kilometers
		begin -- convert Kilometers to Miles
			select @iResult = @intUnits - cast((0.621371192237334*@EquipDispUnits) as numeric)
		end
		if @EquipMeasureId = 3 -- Equipment Days
		begin -- getting the service days
			select @iResult = @intUnits
		end
		if @EquipMeasureId = 4 -- Equipment Hours
		begin -- getting the service hours
			select @iResult = @intUnits
		end
	end

	if @MeasureId = 2 -- Kilometers
	begin
		if @EquipMeasureId = 1 -- Equipment Miles
		begin -- convert Miles to Kilometers
			select @iResult = @intUnits - cast((1.609344*@EquipDispUnits) as numeric)
		end
		if @EquipMeasureId = 2 -- Equipment Kilometers
		begin -- getting Kilometers
			select @iResult = @intUnits - @EquipDispUnits
		end
		if @EquipMeasureId = 3 -- Equipment Days
		begin -- getting the service days
			select @iResult = @intUnits
		end
		if @EquipMeasureId = 4 -- Equipment Hours
		begin -- getting the service hours
			select @iResult = @intUnits
		end
	end
	
	if @MeasureId = 3 -- Days
	begin
		if @EquipMeasureId = 1 -- Equipment Miles
		begin -- getting the service miles
			select @iResult = @intUnits
		end
		if @EquipMeasureId = 2 -- Equipment Kilometers
		begin -- convert Kilometers to Miles
			select @iResult = @intUnits 
		end
		if @EquipMeasureId = 3 -- Equipment Days
		begin -- getting the service days
			select @iResult = datediff(day, @EquipDisposed, @dtDate)
		end
		if @EquipMeasureId = 4 -- Equipment Hours
		begin -- getting the service hours
			select @iResult = @intUnits
		end
	end

	if @MeasureId = 4 -- Hours
	begin
		select @iResult = datediff(hour, @dtStartDate, @dtFinishDate)
	end

	return @iResult
end
