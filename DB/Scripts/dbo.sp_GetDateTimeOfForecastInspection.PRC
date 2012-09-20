SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GetDateTimeOfForecastInspection]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GetDateTimeOfForecastInspection]
GO



----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 09/15/2005 
-- Description: The Procedure get date for next inspection for current equipment
---------------------------------------------------------------------------
CREATE   procedure sp_GetDateTimeOfForecastInspection
	(
		@OrgId int,
		@InspectSchedDetailId int,
		@EquipId int,
		@dtTodayDate datetime,
		@iError int=null output,
		@dtResultDate datetime=null output
	)
as
	set nocount on

	declare @dtLastDate datetime
	declare @dtCurrentDate datetime
	declare @dtTargetDate datetime
	declare @dtMaxDate datetime
	declare @dtMinDate datetime
	declare @dtLimitDate datetime
	declare @ServiceDays decimal(9, 2)
	declare @EquipCount int
--	declare @WOCount int
	declare @CurrentWOCount int
	declare @OWOPD decimal(18, 8)
	declare @i int 
	declare @IsStep bit
	declare @intStep int
	declare @index int
	declare @AvailableDays int
	
	declare @calendar table (
		[Id] int identity(1,1),
		dtDate datetime,
		intPercent decimal(9, 2),
		intCountWO decimal(9, 2)
		)
	
	--  get the Current Date. the current date of inspection take from last date
	-- of serviced inspection for current equipment. if inspection not has history 
	-- take todays date
	
	if not exists(select 'true'
		from InspectSchedDetails ISD
		inner join Equipments E
		on E.[Id] = @EquipId
		and E.OrgId = @OrgId
		and ISD.[Id] = @InspectSchedDetailId
		and ISD.[InspectSchedId] = E.InspectScheduleId
		and ISD.OrgId = E.OrgId
		)
	begin
		select @iError = 147
		return -1
	end

	select @dtTodayDate = dateadd(d, datediff(d, '', @dtTodayDate), '')

	select @dtLastDate = EIH_D.dtDate
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
	
	select @dtLastDate = dateadd(d, datediff(d, '', isnull(@dtLastDate, @dtTodayDate)), '')
	
	-- get source data
	select 	@dtTargetDate = dateadd(d, TargetDaysOut, @dtLastDate),
		@dtMaxDate = dateadd(d, MaximumDaysOut+1, @dtLastDate),
		@dtMinDate = dateadd(d, MinimumDaysOut, @dtLastDate),
		@dtLimitDate = dateadd(d, MaximumDaysOut+1, @dtTodayDate)
	from InspectSchedDetails
	where [Id] = @InspectSchedDetailId
	and OrgId = @OrgId


	if @dtTodayDate >= @dtMinDate
	begin	
		select @dtMinDate = dateadd(d, datediff(d, '', @dtTodayDate), '')
	end

	if @dtTodayDate >= @dtTargetDate 
	begin	
		select 	@dtMaxDate = dateadd(d, datediff(d, @dtTargetDate, @dtMaxDate), dateadd(d, datediff(d, '', @dtTodayDate), '')),
			@dtTargetDate = dateadd(d, datediff(d, '', @dtTodayDate), '')
	end 

	if @dtTodayDate >= @dtMaxDate
	begin	
		select @dtMaxDate = dateadd(d, MaximumDaysOut - TargetDaysOut, dateadd(d, datediff(d, '', @dtTodayDate), ''))
		from InspectSchedDetails
		where [Id] = @InspectSchedDetailId
		and OrgId = @OrgId
	end

	-- calculate Equipment Count
	select @EquipCount = count(E.[Id])
	from Equipments E
	where E.InspectScheduleId in (
		select InspectSchedId
		from InspectSchedDetails
		where [Id] = @InspectSchedDetailId
		and OrgId = @OrgId
		)
	and E.OrgId = @OrgId

--	select @WOCount = count(WO.[Id])
--	from WorkOrders WO
--	where WO.OrgId = @OrgId
--	and WO.StatusId <> 2
--	and WO.dtScheduled between @dtMinDate and @dtMaxDate
	
	select @i = 0, @ServiceDays = 0
	
	declare @dtTmpDate datetime
	declare @intTmpPercent decimal(9, 2)
	
	-- calculate Service Days
	while @i < datediff(d, @dtTodayDate, @dtLimitDate)
	begin
		select @dtTmpDate = dateadd(d, @i, @dtTodayDate)
	
		-- and subtrack sundays and saturdays
		if datepart(dw, @dtTmpDate) <> 1 
			and datepart(dw, @dtTmpDate) <> 7
		begin
			select @CurrentWOCount = count([Id])
			from WorkOrders WO
			where WO.OrgId = @OrgId
			and WO.StatusId <> 2
			and WO.dtScheduled between @dtTmpDate and dateadd(d, 1, @dtTmpDate)
	
			-- subtrack the holidays from service days
			if exists(select 'true' from Holidays
				where @dtTmpDate between dtStartDate and dtEndDate)
			begin
				select top 1 @intTmpPercent = (1 - convert(decimal,intPercentOff)/100.00)
				from Holidays
				where @dtTmpDate between dtStartDate and dtEndDate 
				order by intPercentOff desc
	
				select @ServiceDays = @ServiceDays + @intTmpPercent
				
				insert into @calendar(dtDate, intPercent, intCountWO)
				values (@dtTmpDate, @intTmpPercent, @CurrentWOCount)
			end	
			else
			begin
				select @ServiceDays = @ServiceDays + 1
	
				insert into @calendar(dtDate, intPercent, intCountWO)
				select @dtTmpDate, 1, convert(decimal, @CurrentWOCount)
			end
		end
	
		select @i = @i + 1
	end
	
	delete from @calendar where intPercent = 0.0
	or (dateadd(s, 1, dtDate) between @dtTodayDate and @dtMinDate)
	or (dateadd(s, 1, dtDate) between @dtMaxDate and @dtLimitDate)
	
	select @AvailableDays = count([Id]) from @calendar

	if @ServiceDays = 0.0 or @AvailableDays = 0
	begin
		select @iError = 149;
		select @dtResultDate = dbo.f_GetFreeTime(@dtTargetDate)
		return 2
	end
	
	select @OWOPD = @EquipCount/@ServiceDays
--	select @OWOPD = @WOCount/@ServiceDays
	
	if exists(select 'true' from (
			select 2*count([Id]) as CountTech
			from Logins_UserTypes 
			where UserTypeId = 1 
			) LUT where LUT.CountTech < @OWOPD)
	begin
		select @iError = 150
		return -1
	end
	
--	select @EquipCount as EquipCount, @ServiceDays as ServiceDays, @OWOPD as OWOPD, @dtLastDate as LastDate, @dtTargetDate as TargetDate, @dtMaxDate as MaximumDate, @dtMinDate as MinimumDate
	
	select @IsStep = 0, @intStep = 1, @index = 1
	
	select @dtCurrentDate = @dtTargetDate
	
	while @IsStep = 0
	begin
	--	select dtDate, intPercent*@OWOPD as intPercent, intCountWO from @calendar where dtDate = @dtCurrentDate
	
		if exists(select 'true' from @calendar where dtDate = @dtCurrentDate)
		begin	
			if exists(select 'true' 
				from @calendar 
				where dtDate = @dtCurrentDate
				and intPercent*@OWOPD > intCountWO)
				begin
					select 	@IsStep = 1,
						@dtResultDate = dbo.f_GetFreeTime(@dtCurrentDate)
				end
		end
	
		select @dtCurrentDate = dateadd(d, @intStep, @dtCurrentDate)
	
		if @intStep = 1
		begin
			-- from Target Day to Maximum Day
			if @dtCurrentDate > @dtMaxDate
			begin
				select 	@intStep = -1, 
					@dtCurrentDate = @dtTargetDate
			end
		end
		if @intStep = -1
		begin
			-- from Target Day to Minimum Day
			if @dtCurrentDate < @dtMinDate
			begin
				select 	@intStep = 1,
					@dtCurrentDate = @dtTargetDate,
					@OWOPD = @OWOPD + 1
			end
		end
	
		select @index = @index + 1
		if @index > 100
		begin
			select @iError = 151;
			select @IsStep = 1
			return -1
		end
	end 

	-- check for including of the current equipment to current inspection schedule
	if exists(select 'true' 
		from WorkOrders WO 
		inner join WorkOrderInspections WOI 
		on WO.EquipId = @EquipId
		and WO.OrgId = @OrgId
		and WO.[Id] = WOI.WorkOrderId
		and WO.StatusId <> 2
		and WO.OrgId = WOI.OrgId
		and WO.dtScheduled between @dtMinDate and @dtMaxDate)
	begin
		select @iError = 148
		return 1
	end
	else
	begin
		select @iError = 0;
		return 0
	end




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

