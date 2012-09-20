SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectEquipInspectList_Filter]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectEquipInspectList_Filter]
GO


----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 09/16/2005 
-- Description: The procedure select equipment list with them inspections
---------------------------------------------------------------------------
CREATE  procedure dbo.sp_SelectEquipInspectList_Filter
	(
		@OrgId int,
		@TypeId int,
		@DepId int,
		@LocId int,
		@IsSpare int,
		@UserId int,
		@vchEquipID_Filter varchar(255)
	)
as
	set nocount on
	create table #t_equip(
		[Id] int,
		[TypeId] int,
		[DeptId] int,
		[LocId] int,
		[UserId] int,
		[TypeEquipId] int,
		[NumEquipId] int
		)

	insert into #t_equip([Id], TypeId, DeptId, LocId, UserId, TypeEquipId, NumEquipId)
	select [Id], TypeId, DeptId, LocId, EquipOperatorId, isnumeric(vchEquipId),
		case when isnumeric(vchEquipId) = 1 then convert(int, vchEquipId) else 99999 end
	from Equipments
	where OrgId = @OrgId
	and vchEquipId like @vchEquipID_Filter

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

	select 	E.[Id] as EquipId,
		ISD.[Id] as ItemId,
		isnull(E.vchEquipId, '') as vchEquipId,
		I.vchName as InspectionName,
		case when isnull(EIH.[Id], 0) = 0 then 'No Service History'
		else 	case when (ISD.TargetDaysOut - datediff(day, EIH.dtDate, getdate())) > 0 then 
				case when ISD.MinimumDaysOut > datediff(day, EIH.dtDate, getdate()) then 'Okay' 
				else 'Due Soon' end 
			else 'Due' end
		end as StatusName,
		case when isnull(EIH.[Id], 0) = 0 then ''
		else convert(varchar, EIH.dtDate, 101)
		end as DateLastInspected,
		case when isnull(EIH.[Id], 0) = 0 then ''
		else convert(varchar, dateadd(d, ISD.MinimumDaysOut, EIH.dtDate), 101) + ' - ' + convert(varchar, dateadd(d, ISD.MaximumDaysOut, EIH.dtDate), 101)
		end as DatesRange,
		case when isnull(EIH.[Id], 0) = 0 then 0 else 1 end as IsHistory,
		case when isnull(EIH.[Id], 0) <> 0 then 	
			case when (ISD.TargetDaysOut - datediff(day, EIH.dtDate, getdate())) > 0
			then 'black' else 'red' end
		else 'red' end as Color,
		(select top 1 convert(varchar, year(WO.dtCreated)) + '-' + 
				convert(varchar, month(WO.dtCreated)) + '-' + 
				convert(varchar, day(WO.dtCreated)) + '-' + 
 				convert(varchar, WO.WorkOrderNumber) + '<font style="text-decoration:none">&nbsp;[' +
				convert(varchar, WO.dtScheduled, 107) + ']</font>'
			from WorkOrders WO 
			inner join WorkOrderInspections WOI 
			on WO.EquipId = E.[Id] 
			and WO.OrgId = E.OrgId
			and WOI.WorkOrderId = WO.[Id] 
			and WOI.InspectSchedDetailId = ISD.[Id]
			and WOI.OrgId = ISD.OrgId
			and WO.StatusId = 3
			order by WO.dtScheduled asc) as WorkOrder,
		(select top 1 WO.[Id] 
			from WorkOrders WO 
			inner join WorkOrderInspections WOI 
			on WO.EquipId = E.[Id] 
			and WO.OrgId = E.OrgId
			and WOI.WorkOrderId = WO.[Id] 
			and WOI.InspectSchedDetailId = ISD.[Id]
			and WOI.OrgId = ISD.OrgId
			and WO.StatusId = 3
			order by WO.dtScheduled asc) as WorkOrderId
	from Equipments E
	inner join #t_equip TE
	on TE.[Id] = E.[Id]
	inner join EquipTypes ET
	on ET.OrgId = E.OrgId 
	and ET.[Id] = E.TypeId
	and convert(int, E.bitSpare) <> @IsSpare
	inner join InspectSchedules [IS]
	on [IS].[Id] = E.InspectScheduleId
	and [IS].OrgId = E.OrgId
	inner join InspectSchedDetails ISD
	on ISD.InspectSchedId = [IS].[Id] 
	and ISD.OrgId = [IS].OrgId
	inner join Inspections I
	on I.[Id] = ISD.InspectionId
	and I.OrgId = ISD.OrgId
	left join EquipInspectHistory EIH
	on EIH.EquipId = E.[Id]
	and ISD.OrgId = EIH.OrgId
	and ISD.[Id] = EIH.InspectSchedDetailId
	and EIH.[Id] in ( 
		select EIH_D.[Id]
		from EquipInspectHistory EIH_D
		inner join (
			select max([Id]) as m, InspectSchedDetailId
			from EquipInspectHistory
			where EquipId = E.[Id]
			and OrgId = E.OrgId
			group by InspectSchedDetailId
			) EIH_G
		on EIH_D.InspectSchedDetailId = EIH_G.InspectSchedDetailId
		and EIH_D.[Id] = EIH_G.m
		)
	order by IsHistory desc, StatusName asc, ET.[Id] asc, TE.TypeEquipId desc, TE.NumEquipId asc, E.vchEquipId asc

	drop table #t_equip
	return 







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

