SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


create procedure dbo.sp_SelectEquipListByOperator2
	(
		@OrgId int,
		@UserId int,
		@dtCurrentDate datetime
	)
as
	set nocount on

	declare @ActiveEquips table (
		OrderId int,
		EquipId int
		)

	insert into @ActiveEquips(OrderId, EquipId)
	select 	WO.[Id],
		WO.EquipId
	from WorkOrders WO
	inner join WorkOrderStatus WOS
	on WO.StatusId = WOS.[Id]
	and WO.OrgId = @OrgId
	and WO.btIsActive = 1
	and isnull(WO.OperatorStatusId, 0) <> 2
	and datediff(minute, WO.dtScheduled, dateadd(d, 2, dateadd(d, datediff(d, '', @dtCurrentDate), ''))) > 0 

	-- если оборудование активно то выбираем ok_mainDetail.aspx?id=OrderId
	-- если нет то ok_selectEquipment.aspx?orderid=0&equipid=EquipId
	select 	case when exists(select 'true' from @ActiveEquips where EquipId = E.[Id]) 
			then (select top 1 'ok_mainDetails.aspx?id=' + convert(varchar, OrderId) from @ActiveEquips where EquipId = E.[Id])
			else 'ok_selectEquipment.aspx?orderid=0&equipid=' + convert(varchar, E.[Id])
		end as vchLink,
		E.[Id],
		ISNULL(E.vchEquipId, '') as EquipId,
		ET.vchName as TypeName,
		ISNULL(EMa.vchMakeName, '') as MakeName, 
		ISNULL(EMo.vchModelName, '') as ModelName,
		E.intYear as [Year]
	from Equipments E
	inner join EquipTypes ET
	on E.OrgId = @OrgId
	and isnull(E.EquipOperatorId, 0) = @UserId
	and ET.[Id] = E.TypeId
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

