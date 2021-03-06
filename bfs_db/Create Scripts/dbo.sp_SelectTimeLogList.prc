SET QUOTED_IDENTIFIER ON ਍ഀ
GO਍ഀ
SET ANSI_NULLS ON ਍ഀ
GO਍ഀ
਍ഀ
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectTimeLogList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)਍ഀ
drop procedure [dbo].[sp_SelectTimeLogList]਍ഀ
GO਍ഀ
਍ഀ
਍ഀ
਍ഀ
਍ഀ
CREATE  procedure dbo.sp_SelectTimeLogList਍ഀ
	(਍ഀ
		@OrgId int,਍ഀ
		@OrderId int=null,਍ഀ
		@TechId int=null,਍ഀ
		@vchTotalHours varchar(50)=null output,਍ഀ
		@vchTotalCosts varchar(50)=null output਍ഀ
	)਍ഀ
as਍ഀ
	set nocount on਍ഀ
਍ഀ
	declare @vchHours varchar(25)਍ഀ
	declare @vchMinutes varchar(25)਍ഀ
	਍ഀ
	-- select from the Work Order Details਍ഀ
	if isnull(@TechId, 0) = 0 and isnull(@OrderId, 0) <> 0਍ഀ
	begin਍ഀ
		select 	TL.[Id], ਍ഀ
			TL.[OrderId], ਍ഀ
			convert(varchar, year(WO.dtCreated)) + '-' + ਍ഀ
			convert(varchar, month(WO.dtCreated)) + '-' + ਍ഀ
			convert(varchar, day(WO.dtCreated)) + '-' + ਍ഀ
			convert(varchar, WO.WorkOrderNumber) as WorkOrder,਍ഀ
			isnull(TL.[RepairId], 0) as RepairId,਍ഀ
			isnull(R.vchDesc, '') as RepairName,਍ഀ
			TL.[TechId], ਍ഀ
			isnull(L.vchLastName, '') + ', ' + isnull(L.vchFirstName, '') as TechName,਍ഀ
			TL.[dtStartTime], ਍ഀ
			TL.[dtStopTime], ਍ഀ
			convert(varchar, datepart(hh, dateadd(mi, convert(money, TL.dmHours*60), '1900-01-01'))) + ':' + convert(varchar, datepart(mi, dateadd(mi, convert(money, TL.dmHours*60), '1900-01-01'))) as Hours, ਍ഀ
			convert(decimal(19, 2), TL.[dmHourlyRate]) as HourlyRate,਍ഀ
			isnull(TL.[vchNote], '') as vchNote,਍ഀ
			TL.dtCreatedDate਍ഀ
		from [TimeLog] TL਍ഀ
		inner join Logins L਍ഀ
		on TL.TechId = L.[Id]਍ഀ
		and TL.OrderId = @OrderId਍ഀ
		and TL.OrgId = @OrgId਍ഀ
		inner join WorkOrders WO਍ഀ
		on WO.[Id] = TL.OrderId਍ഀ
		and WO.OrgId = TL.OrgId਍ഀ
		left outer join Repairs R ਍ഀ
		on R.[Id] = TL.RepairId਍ഀ
		and R.OrgId = TL.OrgId਍ഀ
		order by TL.dtStartTime asc, TL.dtStopTime asc਍ഀ
਍ഀ
		select 	@vchHours = convert(varchar, datepart(hh, dateadd(mi, sum(dmHours)*60, '1900-01-01'))),਍ഀ
			@vchMinutes = convert(varchar, datepart(mi, dateadd(mi, sum(dmHours)*60, '1900-01-01'))),਍ഀ
			@vchTotalCosts = convert(varchar, convert(decimal(19, 2), sum(dmHours*dmHourlyRate)))਍ഀ
		from TimeLog਍ഀ
		where OrderId = @OrderId਍ഀ
		and OrgId = @OrgId਍ഀ
	end਍ഀ
਍ഀ
	-- select from the Technician Detail਍ഀ
	if isnull(@TechId, 0) <> 0 and isnull(@OrderId, 0) = 0਍ഀ
	begin਍ഀ
		select 	TL.[Id], ਍ഀ
			TL.[OrderId], ਍ഀ
			convert(varchar, year(WO.dtCreated)) + '-' + ਍ഀ
			convert(varchar, month(WO.dtCreated)) + '-' + ਍ഀ
			convert(varchar, day(WO.dtCreated)) + '-' + ਍ഀ
			convert(varchar, WO.WorkOrderNumber) as WorkOrder,਍ഀ
			isnull(TL.[RepairId], 0) as RepairId,਍ഀ
			isnull(R.vchDesc, '') as RepairName,਍ഀ
			TL.[TechId], ਍ഀ
			isnull(L.vchLastName, '') + ', ' + isnull(L.vchFirstName, '') as TechName,਍ഀ
			TL.[dtStartTime], ਍ഀ
			TL.[dtStopTime], ਍ഀ
			convert(varchar, datepart(hh, dateadd(mi, convert(money, TL.dmHours*60), '1900-01-01'))) + ':' + convert(varchar, datepart(mi, dateadd(mi, convert(money, TL.dmHours*60), '1900-01-01'))) as Hours, ਍ഀ
			convert(decimal(19, 2), TL.[dmHourlyRate]) as HourlyRate,਍ഀ
			isnull(TL.[vchNote], '') as vchNote,਍ഀ
			TL.dtCreatedDate਍ഀ
		from [TimeLog] TL਍ഀ
		inner join Logins L਍ഀ
		on TL.TechId = @TechId਍ഀ
		and TL.TechId = L.[Id]਍ഀ
		and TL.OrgId = @OrgId਍ഀ
		inner join WorkOrders WO਍ഀ
		on WO.[Id] = TL.OrderId਍ഀ
		and WO.OrgId = TL.OrgId਍ഀ
		left outer join Repairs R ਍ഀ
		on R.[Id] = TL.RepairId਍ഀ
		and R.OrgId = TL.OrgId਍ഀ
		order by TL.dtStartTime asc, TL.dtStopTime asc਍ഀ
਍ഀ
		select 	@vchHours = convert(varchar, datepart(hh, dateadd(mi, sum(dmHours)*60, '1900-01-01'))),਍ഀ
			@vchMinutes = convert(varchar, datepart(mi, dateadd(mi, sum(dmHours)*60, '1900-01-01'))),਍ഀ
			@vchTotalCosts = convert(varchar, convert(decimal(19, 2), sum(dmHours*dmHourlyRate)))਍ഀ
		from TimeLog਍ഀ
		where TechId = @TechId਍ഀ
		and OrgId = @OrgId਍ഀ
	end਍ഀ
਍ഀ
	-- another select਍ഀ
	if isnull(@TechId, 0) <> 0 and isnull(@OrderId, 0) <> 0਍ഀ
	begin਍ഀ
		select 	TL.[Id], ਍ഀ
			TL.[OrderId], ਍ഀ
			convert(varchar, year(WO.dtCreated)) + '-' + ਍ഀ
			convert(varchar, month(WO.dtCreated)) + '-' + ਍ഀ
			convert(varchar, day(WO.dtCreated)) + '-' + ਍ഀ
			convert(varchar, WO.WorkOrderNumber) as WorkOrder,਍ഀ
			isnull(TL.[RepairId], 0) as RepairId,਍ഀ
			isnull(R.vchDesc, '') as RepairName,਍ഀ
			TL.[TechId], ਍ഀ
			isnull(L.vchLastName, '') + ', ' + isnull(L.vchFirstName, '') as TechName,਍ഀ
			TL.[dtStartTime], ਍ഀ
			TL.[dtStopTime], ਍ഀ
			convert(varchar, datepart(hh, dateadd(mi, convert(money, TL.dmHours*60), '1900-01-01'))) + ':' + convert(varchar, datepart(mi, dateadd(mi, convert(money, TL.dmHours*60), '1900-01-01'))) as Hours, ਍ഀ
			convert(decimal(19, 2), TL.[dmHourlyRate]) as HourlyRate,਍ഀ
			isnull(TL.[vchNote], '') as vchNote,਍ഀ
			TL.dtCreatedDate਍ഀ
		from [TimeLog] TL਍ഀ
		inner join Logins L਍ഀ
		on TL.TechId = @TechId਍ഀ
		and TL.OrderId = @OrderId਍ഀ
		and TL.TechId = L.[Id]਍ഀ
		and TL.OrgId = @OrgId਍ഀ
		inner join WorkOrders WO਍ഀ
		on WO.[Id] = TL.OrderId਍ഀ
		and WO.OrgId = TL.OrgId਍ഀ
		left outer join Repairs R ਍ഀ
		on R.[Id] = TL.RepairId਍ഀ
		and R.OrgId = TL.OrgId਍ഀ
		order by TL.dtStartTime asc, TL.dtStopTime asc਍ഀ
਍ഀ
		select 	@vchHours = convert(varchar, datepart(hh, dateadd(mi, sum(dmHours)*60, '1900-01-01'))),਍ഀ
			@vchMinutes = convert(varchar, datepart(mi, dateadd(mi, sum(dmHours)*60, '1900-01-01'))),਍ഀ
			@vchTotalCosts = convert(varchar, convert(decimal(19, 2), sum(dmHours*dmHourlyRate)))਍ഀ
		from TimeLog਍ഀ
		where TechId = @TechId਍ഀ
		and OrderId = @OrderId਍ഀ
		and OrgId = @OrgId਍ഀ
	end਍ഀ
਍ഀ
	if len(@vchHours) = 1 select @vchHours = '0' + @vchHours਍ഀ
	if len(@vchMinutes) = 1 select @vchMinutes = @vchMinutes + '0'਍ഀ
	select 	@vchTotalHours = @vchHours + ':' + @vchMinutes,਍ഀ
		@vchTotalCosts = '$' + @vchTotalCosts਍ഀ
਍ഀ
਍ഀ
਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER OFF ਍ഀ
GO਍ഀ
SET ANSI_NULLS ON ਍ഀ
GO਍ഀ
਍ഀ
