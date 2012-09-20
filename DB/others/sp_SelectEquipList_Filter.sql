SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER  procedure sp_SelectEquipList_Filter
	(
		@OrgId int,
		@TypeId int,
		@DepId int,
		@LocId int,
		@UserId int,
		@bitSelect bit,
		@vchEquipID_Filter varchar(255)
	)
as
	set nocount on

	create table #t_equip(
		[Id] int,
		[TypeId] int,
		[DeptId] int,
		[LocId] int,
		[UserId] int
		)

	insert into #t_equip([Id], TypeId, DeptId, LocId, UserId)
	select [Id], TypeId, DeptId, LocId, AssignedTo
	from Equipments
	where OrgId = @OrgId
	and vchEquipId like '%' + @vchEquipID_Filter + '%'
	and isnull(AssignedTo, 0) <> 0

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

	if @UserId <> 0
	begin
		delete from #t_equip
		where UserId <> @UserId or UserId is null
	end
	
	select 	E.[Id],
		case when @bitSelect = 0 then 'wo_existingWorkOrders.aspx?id=' + convert(varchar, E.[Id]) else 'manageIssues.aspx?id=' + convert(varchar, E.[Id]) end as Navigation,
		isnull(E.vchEquipId, '') as EquipId,
		ET.vchName as TypeName,
		isnull(cast(E.intYear as varchar(25)), '') as [Year], 
		isnull(E.vchVinSerial, '') as VinSerial,
		isnull(E.vchFuelCode, '') as FuelCode,
		isnull(D.vchName, '') as DeptName,
		isnull(L.vchName, '') as LocName,
		case when isnull(La.vchFirstName, '') = '' then 'Unassigned' else La.vchLastName + ', ' + La.vchFirstName end as AssignedTo,
		isnull(EMa.vchMakeName, '') as MakeName, 
		isnull(EMo.vchModelName, '') as ModelName
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
	left outer join Logins La
	on La.[Id] = E.AssignedTo
	order by ET.[Id] asc, E.vchEquipId asc

	drop table #t_equip

	return 


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

