SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectInspectionsListForWorkOrder]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectInspectionsListForWorkOrder]
GO


----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 09/09/2005 
-- Description: The procedure select inspection list for the work order
---------------------------------------------------------------------------
CREATE  procedure sp_SelectInspectionsListForWorkOrder
	(
		@OrderId int,
		@OrgId int
	)
as
	set nocount on
	declare @EquipId int

	select 	@EquipId = EquipId
	from 	WorkOrders 
	where 	[Id] = @OrderId
	and 	OrgId = @OrgId

	select 	ISD.[Id],
		isnull(WOI.[Id], 0) as ItemId,
		@OrderId as WorkOrderId,
		isnull(EIH.[Id], 0) as HistoryId,
		case when isnull(WOI.[Id], 0) = 0 then 'False' else 'True' end as IsChecked,
		case when isnull(WOI.btIsProcessed, 0) = 0 then 'True' else 'False' end  as IsCompeted,
		I.vchName,
		case when isnull(EIH.[Id], 0) = 0 then 'No Service History'
		else 	case when (ISD.TargetDaysOut - datediff(day, EIH.dtDate, getdate())) > 0 then 
				case when ISD.MinimumDaysOut > datediff(day, EIH.dtDate, getdate()) then 'Okay' 
				else 'Due Soon' end 
			else 'Due' end
		end as StatusName,
		case when isnull(EIH.[Id], 0) = 0 then ''
		else convert(varchar, dateadd(day, (ISD.TargetDaysOut - datediff(day, EIH.dtDate, getdate())), getdate()), 101)
		end as DateDue,
		ISD.TargetDaysOut as TargetDaysOut,
		ISD.MinimumDaysOut as MinimumDaysOut,
		ISD.MaximumDaysOut as MaximumDaysOut,
		case when isnull(EIH.[Id], 0) = 0 then ''
		else convert(varchar, EIH.dtDate, 101)
		end as DateLastInspected,
		case when isnull(EIH.[Id], 0) <> 0 then 'False' else 'True' end as VisibleLink,
		case when isnull(EIH.[Id], 0) <> 0 then 	
			case when (ISD.TargetDaysOut - datediff(day, EIH.dtDate, getdate())) > 0
			then 'black' else 'red' end
		else 'red' end as Color
	from InspectSchedDetails ISD
	inner join Equipments E 
	on E.[Id] = @EquipId
	and E.OrgId = @OrgId
	and ISD.InspectSchedId = E.InspectScheduleId
	and ISD.OrgId = E.OrgId
	inner join InspectSchedules [IS]
	on ISD.InspectSchedId = [IS].[Id]
	and ISD.OrgId = [IS].OrgId
	inner join Inspections I
	on I.[Id] = ISD.InspectionId
	and I.OrgId = ISD.OrgId
	left join EquipInspectHistory EIH
	on EIH.EquipId = @EquipId
	and ISD.OrgId = EIH.OrgId
	and ISD.[Id] = EIH.InspectSchedDetailId
	and EIH.[Id] in ( 
		select EIH_D.[Id]
		from EquipInspectHistory EIH_D
		inner join (
			select max([Id]) as m, InspectSchedDetailId
			from EquipInspectHistory
			where EquipId = @EquipId
			and OrgId = @OrgId
			group by InspectSchedDetailId
			) EIH_G
		on EIH_D.InspectSchedDetailId = EIH_G.InspectSchedDetailId
		and EIH_D.[Id] = EIH_G.m
		)
	left outer join WorkOrderInspections WOI
	on WOI.InspectSchedDetailId = ISD.[Id]
	and WOI.OrgId = ISD.OrgId
	and WOI.WorkOrderId = @OrderId
	order by ISD.[Id] asc




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

