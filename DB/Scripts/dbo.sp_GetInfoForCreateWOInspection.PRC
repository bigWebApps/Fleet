SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GetInfoForCreateWOInspection]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GetInfoForCreateWOInspection]
GO


----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 09/16/2005 
-- Description: Procedure give the information for screen of creating Work Order 
-- with Inspection (Equipment info, inspection info, schedule info, etc)
---------------------------------------------------------------------------
create procedure dbo.sp_GetInfoForCreateWOInspection
	(
		@OrgId int,
		@EquipId int,
		@InspectSchedDetailId int,
		@vchEquipId varchar(50)=null output,
		@vchType varchar(50)=null output,
		@vchInspectScheduleName varchar(50)=null output,
		@vchInspectName varchar(50)=null output,
		@vchStatus varchar(50)=null output,
		@vchLastInspection varchar(50)=null output,
		@vchDatesRange varchar(50)=null output
	)
as
	set nocount on
	if not exists(select 'true'
		from InspectSchedDetails ISD
		inner join Equipments E
		on E.[Id] = @EquipId
		and E.OrgId = @OrgId
		and ISD.[Id] = @InspectSchedDetailId
		and ISD.[InspectSchedId] = E.InspectScheduleId
		and ISD.OrgId = E.OrgId
		)
	begin
		return -1
	end
	else
	begin
		select 	@vchEquipId = E.vchEquipId,
			@vchType = (select vchName from WorkOrderTypes where [Id] = 1),
			@vchInspectScheduleName = _IS.vchName,
			@vchInspectName = I.vchName,
			@vchStatus = (case when isnull(EIH.[Id], 0) = 0 then 'No Service History'
				else case when (ISD.TargetDaysOut - datediff(day, EIH.dtDate, getdate())) > 0 then 
						case when ISD.MinimumDaysOut > datediff(day, EIH.dtDate, getdate()) then 'Okay' 
						else 'Due Soon' end 
					else 'Due' end
				end),
			@vchLastInspection = (case when isnull(EIH.[Id], 0) = 0 then ''
				else convert(varchar, EIH.dtDate, 101)
				end),
			@vchDatesRange = (case when isnull(EIH.[Id], 0) = 0 then ''
				else convert(varchar, dateadd(d, ISD.MinimumDaysOut, EIH.dtDate), 101) + ' - ' + convert(varchar, dateadd(d, ISD.MaximumDaysOut, EIH.dtDate), 101)
				end)
		from InspectSchedDetails ISD
		inner join Equipments E
		on E.[Id] = @EquipId
		and E.OrgId = @OrgId
		and ISD.[Id] = @InspectSchedDetailId
		and ISD.[InspectSchedId] = E.InspectScheduleId
		and ISD.OrgId = E.OrgId
		inner join InspectSchedules _IS
		on _IS.[Id] = E.InspectScheduleId
		and _IS.OrgId = E.OrgId
		inner join  Inspections I
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

		if exists(select 'true' 
			from WorkOrders WO 
			inner join WorkOrderInspections WOI 
			on WO.EquipId = @EquipId
			and WO.OrgId = @OrgId
			and WO.[Id] = WOI.WorkOrderId
			and WO.OrgId = WOI.OrgId
			and WO.StatusId = 3)
			return 1
		else	return 0
	end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

