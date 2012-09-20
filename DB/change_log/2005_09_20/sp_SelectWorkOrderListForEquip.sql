SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 09/26/2005
-- Description: The procedure get all work orders list for input equipment with
-- full information of work orders including the serviced repaired
---------------------------------------------------------------------------
create procedure dbo.sp_SelectWorkOrderListForEquip
(
		@OrgId int,
		@vchEquipId varchar(50),
		@dtMinDate datetime,
		@dtMaxDate datetime,
		@TypeId int,
		@CategoryId int,
		@TechId int,
		@OperatorId int
)
as
	set nocount on

	declare @N int 
	declare @i int
	declare @j int
	declare @M int
	declare @Repairs varchar(8000)
	declare @IsDelete bit
	declare @Flag bit

	declare @Orders_t table(
		[Id] int identity(1, 1),
		OrderId int,
		Repairs varchar(8000)
		)	

	declare @Repairs_t table(
		[Id] int identity(1, 1),
		RepairId int,
		vchCatItem varchar(256),
		vchDesc varchar(4000),
		CatId int
		)

	insert into @Orders_t(OrderId)
	select WO.[Id]
	from WorkOrders WO
	inner join Equipments E
	on E.vchEquipId = @vchEquipId
	and E.OrgId = @OrgId
	and E.[Id] = WO.EquipId
	and WO.OrgId = E.OrgId
	and WO.btIsActive = 1
	and datediff(minute, @dtMinDate, dateadd(d, 1, dateadd(d, datediff(d, '', isnull(WO.dtClosed, WO.dtScheduled)), ''))) > 0 
	and datediff(minute, dateadd(d, datediff(d, '', isnull(WO.dtClosed, WO.dtScheduled)), ''), @dtMaxDate) > 0 
	inner join WorkOrderStatus WOS 
	on  WO.StatusId = WOS.[Id]
	left outer join WorkOrderOperatorStatus WOOS
	on WO.OperatorStatusId = WOOS.[Id]
	where (WO.TypeId = @TypeId or @TypeId = 0)
	and (isnull(WO.intTechId, 0) = @TechId or @TechId = 0)
	and (isnull(WO.intOperatorId, 0) = @OperatorId or @OperatorId = 0)
	order by WO.dtScheduled desc, WOS.vchStatus desc, WOOS.vchStatus desc

	select @i = 1, @j = 1, @N = scope_identity()

	while @i <= @N
	begin
		-- filter repair categories
		select @Repairs = '', @IsDelete = 1, @Flag = 0

		if exists(select 'true' 
			from Repairs R 
			inner join @Orders_t O
			on O.[Id] = @i
			and O.OrderId = R.WorkOrderId
			and R.OrgId = @OrgId)
		begin
			select @Repairs = '<table cellpadding="0" cellspacing="1" width="100%"><tr style="background-color:lightgrey"><td style="background-color:white" width="20px">&nbsp;&nbsp;&nbsp;&nbsp;</td><td width="120px">Category</td><td width="150px">Repair Item</td><td>Repair Description</td></tr>'

			insert into @Repairs_t(RepairId, vchCatItem, vchDesc, CatId)
			select 	R.[Id],
				'<td>' + isnull(RC.vchName, '') + '</td><td>' + isnull(RI.vchDesc, '') + '</td>',
				'<td>' + R.vchDesc + '</td>',
				RC.[Id]
			from Repairs R 
			inner join @Orders_t O
			on O.[Id] = @i
			and O.OrderId = R.WorkOrderId
			and R.OrgId = @OrgId
			left join RepairItems RI
			on R.RepairItemId = RI.[Id]
			and R.OrgId = RI.OrgId
			left join RepairCats RC
			on RI.CatId = RC.[Id]
			and R.OrgId = RC.OrgId
	
			select @M = scope_identity() + @j
	
			while @j < @M
			begin
				if @CategoryId <> 0 and @Flag = 0
				begin
					if exists(select 'true' 
						from @Repairs_t
						where [Id] = @j
						and CatId = @CategoryId)
					begin
						select @IsDelete = 0, @Flag = 1
					end	
				end
				else
					select @IsDelete = 0

				select @Repairs = @Repairs  + '<tr style="background-color:#F6F6F6"><td style="background-color:white"></td>' + vchCatItem + vchDesc + '</tr>'
				from @Repairs_t
				where [Id] = @j
	
				select @j = @j + 1
			end

			select @Repairs = @Repairs + '</table>'

			delete from @Repairs_t
		end
		else
		begin
			if @CategoryId = 0 select @IsDelete = 0
			select @Repairs = '&nbsp;'
		end

		if @IsDelete = 0
		begin
			update @Orders_t
			set Repairs = @Repairs
			where [Id] = @i
		end
		else
		begin
			delete 
			from @Orders_t
			where [Id] = @i
		end

		select @i = @i + 1
	end

	select 	O.[Id],
		O.Repairs,
		WO.[Id] as OrderId,
		WO.EquipId,
		WOT.vchName as TypeName,
		convert(varchar, year(WO.dtCreated)) + '-' + 
		convert(varchar, month(WO.dtCreated)) + '-' + 
		convert(varchar, day(WO.dtCreated)) + '-' + 
		convert(varchar, WO.WorkOrderNumber) as vchWorkOrderNumber,
		case when isnull(LT.vchFirstName, '') = '' then '' else LT.vchLastName + ', ' + LT.vchFirstName end as TechName,
		case when isnull(LO.vchFirstName, '') = '' then '' else LO.vchLastName + ', ' + LO.vchFirstName end as OperatorName,
		isnull(WOS.vchStatus, '') as StatusName,
		isnull(WOS.vchColor, '') as StatusColor,
		isnull(WOOS.vchStatus, '&nbsp;') as OperatorStatusName,
		isnull(WOOS.vchColor, 'lightgrey') as OperatorColor,
		convert(varchar, WO.dtScheduled) as ScheduledDate,
		case when isnull(WO.dtClosed, 0) = 0 then '' else convert(varchar, WO.dtClosed) end as CompletedDate 
	from WorkOrders WO
	inner join @Orders_t O
	on O.OrderId = WO.[Id]
	inner join WorkOrderStatus WOS 
	on  WO.StatusId = WOS.[Id]
	inner join WorkOrderTypes WOT
	on WOT.[Id] = WO.TypeId
	left outer join WorkOrderOperatorStatus WOOS
	on WO.OperatorStatusId = WOOS.[Id]
	left outer join Logins LT
	on WO.intTechid = LT.[Id]
	left outer join Logins LO
	on WO.intOperatorId = LO.[Id]
	order by O.[Id] asc


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

