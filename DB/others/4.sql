--exec sp_SelectWorkOrderListForDate 1, '2004-12-02', '2004-12-03'
--select * from WorkOrders
	
	declare @dtCreated datetime
	select @dtCreated = getdate()
	
	select *
	from WorkOrders
	where datediff(minute, dateadd(d, datediff(d, '', @dtCreated), ''), dtCreated) > 0 
	and datediff(minute, dtCreated, dateadd(day, 1, dateadd(d, datediff(d, '', @dtCreated), ''))) > 0 
