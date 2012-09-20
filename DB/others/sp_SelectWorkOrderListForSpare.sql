SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

alter procedure sp_SelectEquipListForSpare
(
		@OrgId int,
		@OrderId int,
		@TypeId int output,
		@DepId int,
		@LocId int,
		@vchEquipID_Filter varchar(255)
)
as
	set nocount on
	
	create table #t_equip(
		[Id] int,
		[TypeId] int,
		[DeptId] int,
		[LocId] int
		)

	insert into #t_equip([Id], TypeId, DeptId, LocId)
	select [Id], TypeId, DeptId, LocId
	from Equipments
	where OrgId = @OrgId
	and vchEquipId like @vchEquipID_Filter

	if @OrderId <> 0
	begin
		select @TypeId = ISNULL(E.TypeId, 0)
		from Equipments E
		inner join WorkOrders WO
		on E.[Id] = WO.EquipId
		and WO.[Id] = @OrderId
		and WO.OrgId = E.OrgId
	end

	if @TypeId <> 0
	begin 
		delete from #t_equip
		where TypeId <> @TypeId or TypeId is null 
	end

	if @DepId <> 0
	begin
		delete from #t_equip
		where DeptId <> @DepId or DeptId is null
	end

	if @LocId <> 0
	begin
		delete from #t_equip
		where LocId <> @LocId or LocId is null
	end
	
	select 	E.[Id],
		isnull(E.vchEquipId, '') as EquipId,
		ET.vchName as TypeName,
		isnull(D.vchName, '') as DeptName,
		isnull(L.vchName, '') as LocName,
		isnull(EMa.vchMakeName, '') as MakeName, 
		isnull(EMo.vchModelName, '') as ModelName,
		case when isnull(E.AssignedTo, 0) = 0 then 'green' else 'red' end as Available,
		case when isnull(E.AssignedTo, 0) = 0 then 'True' else 'False' end as VisibleLink,
		case when isnull(E.AssignedTo, 0) = 0 then 'False' else 'True' end as UnVisibleLink
	from Equipments E
	inner join #t_equip TE
	on TE.[Id] = E.[Id]
	inner join EquipTypes ET
	on ET.OrgId = E.OrgId and ET.[Id] = E.TypeId
	left outer join EquipModels EMo
	on EMo.OrgId = @OrgId and EMo.[Id] = E.ModelId 
	left outer join EquipModelType EMT
	on EMT.OrgId = @OrgId and EMT.[Id] = EMo.TypeId
	left outer join EquipMakes EMa
	on EMa.OrgId = @OrgId and EMa.[Id] = EMT.MakeId
	left outer join Departments D
	on D.OrgId = @OrgId and D.[Id] = E.DeptId
	left outer join Locations L
	on L.OrgId = @OrgId and L.[Id] = E.LocId
	order by ET.[Id] asc, E.vchEquipId asc

	drop table #t_equip

	return 

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

