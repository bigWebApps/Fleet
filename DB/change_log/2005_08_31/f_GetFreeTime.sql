SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create function dbo.f_GetFreeTime
	(@dtDate datetime) returns datetime
as
begin
	declare @IsResult bit
	declare @dtCurrentDate datetime

	select 	@IsResult = 0, 
	@dtCurrentDate = dateadd(hh, 8, dateadd(d, datediff(d, '', @dtDate), ''))
	
	while @IsResult = 0
	begin
	if not exists(select 'true' 
		from WorkOrders 
		where dtScheduled between @dtCurrentDate
		and dateadd(s, -1, dateadd(hh, 1, @dtCurrentDate)))
	begin
		select @IsResult = 1
	end
	else
	begin
		select @dtCurrentDate = dateadd(hh, 1, @dtCurrentDate)
		if datename(hh, @dtCurrentDate) = 12
			select @dtCurrentDate = dateadd(hh, 2, @dtCurrentDate)
		if datename(hh, @dtCurrentDate) = 18
		begin
			select @dtCurrentDate = dateadd(hh, -9, @dtCurrentDate)
			select @IsResult = 1
		end
	end
	end
	
	return @dtCurrentDate
end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

