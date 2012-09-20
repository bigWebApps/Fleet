SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectEquipListByOperatorActivate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectEquipListByOperatorActivate]
GO


CREATE procedure dbo.sp_SelectEquipListByOperatorActivate
	(
		@OrgId int,
		@UserId int
	)
as
	set nocount on

	declare @i int
	declare @N int
	declare @j int
	declare @M int
	declare @vchWorkOrders varchar(8000)
	declare @EquipId int
	declare @tblEquips table (
		tbl_Id int identity(1, 1),
		tbl_EquipId int,
		tbl_WorkOrders varchar(8000)
		)

	declare @tblWorkOrders table (
		tbl_Id int identity(1, 1),
		tbl_OrderId int
		)

	insert into @tblEquips(tbl_EquipId)
	select E.[Id]
	from Equipments E
	where isnull(E.EquipOperatorId, 0) = @UserId
	and E.OrgId = @OrgId

	select @N = scope_identity(), @i = 1

	while @i <= @N
	begin
		select @vchWorkOrders = '', @EquipId = tbl_EquipId
		from @tblEquips
		where tbl_Id = @i

		if exists(select 'true' 
			from WorkOrders 
			where EquipId = @EquipId 
			and OrgId = @OrgId 
			and isnull(OperatorStatusId, 0) <> 2)
		begin
			select @vchWorkOrders = '<table cellpadding="0" cellspacing="1" width="100%"><tr style="background-color:lightgrey"><td style="background-color:white" width="20px">&nbsp;&nbsp;&nbsp;&nbsp;</td><td nowrap>Work Order Id</td><td>Status</td><td nowrap>Operator Status</td><td nowrap>Scheduled Date</td></tr>'
			
			insert into @tblWorkOrders(tbl_OrderId)
			select [Id]
			from WorkOrders
			where EquipId = @EquipId 
			and OrgId = @OrgId 
			and isnull(OperatorStatusId, 0) <> 2

			select @j = 1, @M = scope_identity()

			while @j <= @M 
			begin
				select 	@vchWorkOrders = @vchWorkOrders + '<tr style="background-color:#F6F6F6"><td style="background-color:white" width="20px">&nbsp;&nbsp;&nbsp;&nbsp;</td><td nowrap width="80px">' + 
					convert(varchar, year(WO.dtCreated)) + '-' + 
					convert(varchar, month(WO.dtCreated)) + '-' + 
					convert(varchar, day(WO.dtCreated)) + '-' + 
					convert(varchar, WO.WorkOrderNumber)+ 
					'</td><td width="100px">' + 
					isnull(WOS.vchStatus, 'Unknown') + 
					'</td><td nowrap width="100px">' + 
					isnull(WOOS.vchStatus, '') + 
					'</td><td nowrap>' + 
					convert(varchar, WO.dtScheduled) +
					'</td></tr>'
				from WorkOrders WO
				inner join @tblWorkOrders tbl
				on tbl.tbl_Id = @j 
				and tbl.tbl_OrderId = WO.[Id]
				and WO.OrgId = @OrgId
				and WO.btIsActive = 1
				inner join WorkOrderStatus WOS
				on WO.StatusId = WOS.[Id]
				left outer join WorkOrderOperatorStatus WOOS
				on WO.OperatorStatusId = WOOS.[Id]

				select @j = @j + 1
			end

			select @vchWorkOrders = @vchWorkOrders + '</table>'
		end

		update @tblEquips
		set tbl_WorkOrders = @vchWorkOrders
		where tbl_Id = @i 

		select @i = @i + 1
	end

	select 	E.[Id],
		ISNULL(E.vchEquipId, '') as EquipId,
		ET.vchName as TypeName,
		ISNULL(EMa.vchMakeName, '') as MakeName, 
		ISNULL(EMo.vchModelName, '') as ModelName,
		E.intYear as [Year],
		tbl.tbl_WorkOrders as WorkOrders,
		case when isnull(tbl.tbl_WorkOrders, '') = '' then 'True' else 'False' end as IsNobody
	from Equipments E
	inner join @tblEquips tbl
	on E.[Id] = tbl.tbl_EquipId
	and E.OrgId = @OrgId
	inner join EquipTypes ET
	on ET.[Id] = E.TypeId
	and ET.OrgId = E.OrgId
	left outer join EquipModels EMo
	on EMo.OrgId = @OrgId and EMo.[Id] = E.ModelId 
	left outer join EquipModelType EMT
	on EMT.OrgId = @OrgId and EMT.[Id] = EMo.TypeId
	left outer join EquipMakes EMa
	on EMa.OrgId = @OrgId and EMa.[Id] = EMT.MakeId
	order by ET.[Id] asc, E.vchEquipId asc


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

