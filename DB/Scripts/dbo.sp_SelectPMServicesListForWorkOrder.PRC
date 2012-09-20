SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectPMServicesListForWorkOrder]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectPMServicesListForWorkOrder]
GO


----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Last Modification Date: 06/27/2005
-- Description: Procedure is showing the preventive services for Equipment 
-- with status of due times and due mileage for Preventive Maintenance
---------------------------------------------------------------------------
CREATE   procedure sp_SelectPMServicesListForWorkOrder
	(
		@OrderId int,
		@OrgId int,
		@EquipCurUnits decimal(19, 8)=null output,
		@CurDate datetime=null output
	)
as
	set nocount on
	declare @EquipId int
	declare @i int 
	declare @N int
	declare @curMeasureId int
	
	declare @EquipMeasureId int
		
	declare @tbl table (
		tbl_id int identity(1, 1), 
		tbl_SchedDetailId int,
		tbl_MeasureId int,
		tbl_Usched decimal(19, 8),
		tbl_U decimal(19, 8),
		tbl_Dsched int,
		tbl_D int,
		tbl_StatusName varchar(25),
		tbl_UnitsVisible varchar(25),
		tbl_DaysVisible varchar(25)
		)
	select @EquipId = EquipId
	from WorkOrders 
	where [Id] = @OrderId
	and OrgId = @OrgId
	select 	@EquipMeasureId = ET.UnitMeasureId,
		@EquipCurUnits = E.dmCurrentUnits,
		@CurDate = getdate()
	from EquipTypes ET
	inner join Equipments E
	on E.TypeId = ET.[Id]
	and E.OrgId = ET.OrgId
	and E.[Id] = @EquipId	
	
	-- 1. Defining the services which need be serviced for current equipment type. 
	-- for it use the relationship between Equipments -> PMSchedules - > PMSchedDetails - > PMServices
	-- We take services that has same measure as in Equipment and services with days measure.
	
	-- 2. We search the schedule of service for every service, take from there data about the mileage 
	-- and calculate how much units there untill Due day with using the MeasureId and dmUnits fields into PMSchedDetials table (Usched).
	-- Also we search and calculate how many days there till the service with using the intDays field into PMSchedDetials table. (Dsched)
	
	insert into @tbl(tbl_SchedDetailId, tbl_MeasureId, tbl_Usched, tbl_Dsched)
	select PMD.[Id], PMD.UnitMeasureId, PMD.dmUnits, PMD.intDays
	from PMSchedDetails PMD
	inner join PMSchedules PMS
	on PMD.PMSchedId = PMS.[Id]
	and PMD.OrgId = PMS.OrgId
	and PMD.UnitMeasureId = @EquipMeasureId
	inner join Equipments E
	on E.[Id] = @EquipId
	and E.OrgId = @OrgId
	and PMS.[Id] = E.PMScheduleId
	and PMS.OrgId = E.OrgId
	
	select @N = scope_identity()
	
	-- 3. Next, we calculate the equipment mileage when these services were serviced in last time on this equipment. (Uwas)
	-- If this service was serviced for current equipment then we take this data from EquipPMHistory table 
	-- if this service hasn't history of service then we don't show data about last service and this record will has a red color.
	-- 4. We calculate a current value of equipment mileage. For measure in days 
	-- we take current system date and subtract from his the date from dtDate field 
	-- of EquipPMHistory table.  We receive days amount (Dcur_was). For other 
	-- we take data from intCurrentUnits field. (Ucur)
	-- 5. Now we calculate for each service the mileage which remains up to 
	-- PM service with using formula: U = Usched - (Ucur - Uwas).
	-- Also we get the PM status with helping  the intAlertCount field 
	-- in the Measures table. This table keep a difference between 
	-- "Due Soon" and "Due" statuses in mileage. (if U <= intAlertCount)
	-- If U < 0 then status of current service will be 'Due' or else 'Okay'.
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
			if exists(select 'true' from @tbl where tbl_id = @i and isnull(tbl_Usched, 0.0) = 0.0 and isnull(tbl_Dsched, 0.0) <> 0.0)
			begin -- only Days
				update @tbl 
				set tbl_U = null,
				    tbl_D = tbl_Dsched - datediff(day, EH.dtDate, getdate()),
			    	    tbl_StatusName = (case when (tbl_Dsched - datediff(day, EH.dtDate, getdate())) > 0 then case when (tbl_Dsched - datediff(day, EH.dtDate, getdate())) > 7 then 'Okay' else 'Due Soon' end else 'Due' end),
				    tbl_UnitsVisible = 'False',
				    tbl_DaysVisible = 'True'
				from EquipPMHistory EH 
				where tbl_id = @i 
				and EH.OrgId = @OrgId
				and EH.EquipId = @EquipId 
				and EH.PMSchedDetailId = tbl_SchedDetailId
			end
			if exists(select 'true' from @tbl where tbl_id = @i and isnull(tbl_Usched, 0.0) <> 0.0 and isnull(tbl_Dsched, 0.0) = 0.0)
			begin -- only Units
				update @tbl 
				set tbl_U = tbl_Usched - (@EquipCurUnits - EH.dmUnits),
				    tbl_D = null,
			    	    tbl_StatusName = (
					case when (tbl_Usched - (@EquipCurUnits - EH.dmUnits)) > 0 then 
						case when (tbl_Usched - (@EquipCurUnits - EH.dmUnits)) > (select M.dmAlertCount from UnitMeasures M where M.[Id] = tbl_MeasureId) then 'Okay' 
						else 'Due Soon' end 
					else 'Due' end
					),
				    tbl_UnitsVisible = 'True',
				    tbl_DaysVisible = 'False'
				from EquipPMHistory EH 
				where tbl_id = @i 
				and EH.OrgId = @OrgId
				and EH.EquipId = @EquipId 
				and EH.PMSchedDetailId = tbl_SchedDetailId
			end
			if exists(select 'true' from @tbl where tbl_id = @i and isnull(tbl_Usched, 0.0) <> 0.0 and isnull(tbl_Dsched, 0.0) <> 0.0)
			begin -- both Units and Days
				update @tbl 
				set tbl_U = tbl_Usched - (@EquipCurUnits - EH.dmUnits),
				    tbl_D = tbl_Dsched - datediff(day, EH.dtDate, getdate()),
				    tbl_UnitsVisible = 'True',
				    tbl_DaysVisible = 'True'
				from EquipPMHistory EH 
				where tbl_id = @i 
				and EH.OrgId = @OrgId
				and EH.EquipId = @EquipId 
				and EH.PMSchedDetailId = tbl_SchedDetailId
				update @tbl 
				set tbl_StatusName = (
					case when tbl_U > 0 then 
						case when tbl_D > 0 then 
							case when tbl_U > M.dmAlertCount and tbl_D > 7 then 'Okay' 
							else 'Due Soon' end 
						else 'Due' end 
					else 'Due' end
					)
				from UnitMeasures M 
				where tbl_id = @i 
				and M.[Id] = tbl_MeasureId
				
			end
			if exists(select 'true' from @tbl where tbl_id = @i and isnull(tbl_Usched, 0.0) = 0.0 and isnull(tbl_Dsched, 0.0) = 0.0)
			begin -- nothing
				update @tbl
				set tbl_U = tbl_Usched,
				    tbl_D = tbl_Dsched,
			    	    tbl_StatusName = 'No Service History',
				    tbl_UnitsVisible = 'False',
				    tbl_DaysVisible = 'False'
				where tbl_id = @i
			end
		end 
		else 
		begin -- skip the service
			update @tbl
			set tbl_U = tbl_Usched,
			    tbl_D = tbl_Dsched,
			    tbl_StatusName = 'No Service History',
			    tbl_UnitsVisible = 'True',
			    tbl_DaysVisible = 'True'
			where tbl_id = @i
		end
	end
	
	-- 6. print given items on screen
	select 	@OrderId as WorkOrderId,
		PMSD.[Id], 
		PMS.[Id] as ServiceId,
		isnull(PMI.[Id], 0) as ItemId,
		isnull(EH.[Id], 0) as HistoryId,
		case when isnull(PMI.[Id], 0) = 0 then 'False' else 'True' end as IsChecked,
		RC.vchName as CatName,
		PMS.vchDesc,
		M.vchName as MeasureName,
		tbl_StatusName as StatusName,
		case when isnull(tbl.tbl_U, 0.0) <> 0.0 then convert(varchar, cast(tbl.tbl_U as float)) + ' ' + M.vchName else '' end as UnitsDue,
		convert(varchar, dateadd(day, tbl.tbl_D, getdate()), 101) as DateDue,
		convert(varchar, cast(tbl_Usched as float)) + ' ' + isnull(M.vchName, '') as UnitsInteval,
		cast(tbl_Dsched as varchar) + ' days' as TimeInterval,
		cast(isnull(EH.dmUnits, 0.0) as float) as UnitsLastServiced,
		convert(varchar, isnull(EH.dtDate, getdate()), 101) as DateLastServiced,
		tbl_UnitsVisible as UnitsVisible,
		tbl_DaysVisible as DaysVisible,
		case when isnull(EH.[Id], 0) <> 0 then tbl_UnitsVisible
		else 'False' end as UnitsVisibleLast,
		case when isnull(EH.[Id], 0) <> 0 then tbl_DaysVisible
		else 'False' end as DaysVisibleLast,
		case when isnull(EH.[Id], 0) <> 0 then 'False' else 'True' end as VisibleLastLink,
		case when isnull(EH.[Id], 0) = 0 or tbl.tbl_StatusName = 'Due' then 'red' else 'black' end as Color
	from PMServices PMS
	inner join PMSchedDetails PMSD
	on PMSD.PMServiceId = PMS.[Id]
	and PMSD.OrgId = PMS.OrgId
	left outer join RepairCats RC
	on RC.[Id] = PMS.RepairCatId
	and RC.OrgId = PMS.OrgId
	left join EquipPMHistory  EH
	on EH.EquipId = @EquipId
	and EH.OrgId = @OrgId
	and PMSD.[Id] = EH.PMSchedDetailId
	and EH.[Id] in ( 
		select EH_D.[Id]
		from EquipPMHistory EH_D
		inner join (
			select max([Id]) m, PMSchedDetailId
			from EquipPMHistory
			where EquipId = @EquipId
			and OrgId = @OrgId
			group by PMSchedDetailId
			) EH_G
		on EH_D.PMSchedDetailId = EH_G.PMSchedDetailId
		and EH_D.[Id] = EH_G.m
		)
	inner join @tbl tbl
	on tbl.tbl_SchedDetailId = PMSD.[Id]
	inner join UnitMeasures M
	on tbl.tbl_MeasureId = M.[Id]
	inner join Equipments E 
	on E.[Id] = @EquipId
	and E.OrgId = @OrgId
	left outer join WorkOrderPMItems PMI
	on PMSD.[Id] = PMI.PMSchedDetailId
	and PMSD.OrgId = PMI.OrgId
	and PMI.WorkOrderId = @OrderId
	order by RC.[Id], PMS.[Id] asc


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

