use FleetPro_Test
declare @EquipId int
declare @OrgId int
declare @i int 
declare @N int
declare @curMeasureId int

declare @EquipMeasureId int
declare @EquipDispUnits int
declare @EquipDisposed datetime
declare @EquipCurUnits int
declare @CurDate datetime

select @EquipId = 1

declare @tbl table (
	tbl_id int identity(1, 1), 
	tbl_SchedDetailId int,
	tbl_MeasureId int,
	tbl_Usched int,
	tbl_Uwas int,
	tbl_Ucur int,
	tbl_U int
	)

select 	@OrgId = E.OrgId,
	@EquipMeasureId = ET.MeasureId,
	@EquipDispUnits = E.intDispUnits,
	@EquipDisposed = E.dtDisposed,
	@EquipCurUnits = E.intCurrentUnits,
	@CurDate = getdate()
from EquipTypes ET
inner join Equipments E
on E.TypeId = ET.[Id]
and E.OrgId = ET.OrgId
and E.[Id] = @EquipId	

-- 1. Определяем сервисы которые должня обслужится для данного типа оборудования, 
-- для этого используем связку Equipments -> PMSchedules - > PMSchedDetails - > PMServices
-- Мы берем только те сервисы которое имеют меру такую же как у оборудования и так же те 
-- сервисы которые имеют меру в днях.
-- 2. Для каждого сервиса смотрим расписание его обслуживания, и берем оттуда
-- данное о количество пробега через которое тот сервис должен обслужитваться.
-- Для этого служит поле MeasureId и intUnits в таблице PMSchedDetials. (Usched)

insert into @tbl(tbl_SchedDetailId, tbl_MeasureId, tbl_Usched)
select PMD.[Id], PMD.MeasureId, PMD.intUnits
from PMSchedDetails PMD
inner join PMSchedules PMS
on PMD.PMSchedId = PMS.[Id]
and PMD.OrgId = PMS.OrgId
and PMD.MeasureId in (@EquipMeasureId, 3)
inner join Equipments E
on E.[Id] = @EquipId
and E.OrgId = @OrgId
and PMS.[Id] = E.PMScheduleId
and PMS.OrgId = E.OrgId

select @N = scope_identity()

-- 3. Далее вычисляем какой был пробег у оборудования, когда эти сервисы были 
-- обслуженны в полследний раз на данном оборудовании. (Uwas)
-- Если данный сервис был обслужен для данного оборудования, то мы берем эти данные 
-- из EquipPMHistory, если же такие сервисы ни разу не обслуживались то мы берем данные 
-- о пробеге из таблицы оборудования
-- 4. Вычисляем текущую велечину пробега у оборудования. 
-- Если сервис имеет меру в днях, то берем текущую системную дату. Если же 
-- сервисы имееют другую меру, то берем данные из поля intCurrentUnits. Это значение - Ucur.
select @i = 0
while @i <= @N
begin
	select @i = @i + 1

	if exists(select 'true' 
		from EquipPMHistory 
		where OrgId = @OrgId 
		and EquipId = @EquipId 
		and PMSchedDetailId in (
			select tbl_SchedDetailId
			from @tbl 
			where tbl_id = @i
			)
		)
	begin -- take from EquipPMHistory table 
		if exists(select 'true' from @tbl where tbl_id = @i and tbl_MeasureId = 3)
		begin -- using the date fields
			update 	@tbl 
			set tbl_Uwas = datediff(day, '1900-01-01', EH.dtDate),
			    tbl_Ucur = datediff(day, '1900-01-01', getdate())
			from EquipPMHistory EH 
			where tbl_id = @i 
			and EH.OrgId = @OrgId
			and EH.EquipId = @EquipId 
			and EH.PMSchedDetailId = tbl_SchedDetailId
		end
		else
		begin -- using units fields
			update @tbl 
			set tbl_Uwas = EH.intUnits,
			    tbl_Ucur = (select intCurrentUnits from Equipments where OrgId = @OrgId and [Id] = @EquipId)
			from EquipPMHistory EH 
			where tbl_id = @i 
			and EH.OrgId = @OrgId
			and EH.EquipId = @EquipId 
			and EH.PMSchedDetailId = tbl_SchedDetailId
		end
	end 
	else 
	begin -- take from Equipments table from Disposal fields 
		if exists(select 'true' from @tbl where tbl_id = @i and tbl_MeasureId = 3)
		begin -- using the date fields
			update @tbl 
			set tbl_Uwas = datediff(day, '1900-01-01', E.dtDisposed),
			    tbl_Ucur = datediff(day, '1900-01-01', getdate())
			from Equipments E 
			where tbl_id = @i 
			and E.OrgId = @OrgId
			and E.[Id] = @EquipId
		end
		else
		begin -- using units fields
			update @tbl
			set tbl_Uwas = E.intDispUnits,
			    tbl_Ucur = intCurrentUnits
			from Equipments E 
			where tbl_id = @i 
			and E.OrgId = @OrgId
			and E.[Id] = @EquipId 
		end
	end 
end

-- 5. Теперь просто вычисляем для каждого сервиса пробег который ему остется до 
-- обслуживания с помошью формулы: U = Usched - (Ucur - Uwas). Так же сразу же 
-- вычесляем статус PM, для этого нам поможет поле intAlertCount в таблице 
-- Measures. В нем хранится количество пробега в течении которого пользователю 
-- сообщеается что данный сервис имеет статус "Due Soon". (если U <= intAlertCount)
-- Если занение U имеет отрицательный результат то тогда статус этого сервиса 
-- будет "OverDue", в остальном случает статус будет "Due".

update @tbl 
set tbl_U = tbl_Usched - (tbl_Ucur - tbl_Uwas)

select 	PMS.[Id], 
	PMS.vchDesc,
	case when tbl.tbl_U > 0 then 
		case when tbl.tbl_U > M.intAlertCount then 'Due'
		else 'Due Soon' end
	else 'OverDue' end as StatusName,
	case when tbl.tbl_MeasureId = 3 then null 
	else tbl.tbl_U end as UnitsDue,
	case when tbl.tbl_MeasureId = 3 then dateadd(day, tbl.tbl_U, getdate())
	else null end as DateDue,
	case when tbl.tbl_MeasureId = 3 then null
	else convert(varchar, tbl_Usched) + ' ' + M.vchName end as UnitsInteval,
	case when tbl.tbl_MeasureId = 3 then convert(varchar, tbl_Usched) + ' days'
	else '' end as TimeInterval,
	case when tbl.tbl_MeasureId = 3 then null
	else
		case when isnull(EH.[Id], 0) <> 0 then convert(varchar, EH.intUnits) + ' ' + M.vchName
		else convert(varchar, E.intDispUnits) + ' ' + M.vchName end
	end as UnitsLastServiced,

	case when tbl.tbl_MeasureId = 3 then 
		case when isnull(EH.[Id], 0) <> 0 then EH.dtDate
		else E.dtDisposed end
	else null end as DateLastServiced
from PMServices PMS
inner join PMSchedDetails PMSD
on PMSD.PMServiceId = PMS.[Id]
and PMSD.OrgId = PMS.OrgId
left join EquipPMHistory EH
on EH.EquipId = @EquipId
and EH.PMSchedDetailId = PMSD.[Id]
and EH.OrgId = PMSD.OrgId
inner join @tbl tbl
on tbl.tbl_SchedDetailId = PMSD.[Id]
inner join Measures M
on tbl.tbl_MeasureId = M.[Id]
inner join Equipments E 
on E.[Id] = @EquipId
and E.OrgId = @OrgId
