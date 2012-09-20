SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectWorkOrderListForTech]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectWorkOrderListForTech]
GO




----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 02/20/2006
-- Description: The procedure get all work orders list where Technician is @TechId
---------------------------------------------------------------------------
CREATE procedure dbo.sp_SelectWorkOrderListForTech
(
		@OrgId int,
		@TechId int
)
as
	set nocount on

	select 	WO.[Id],
		WO.EquipId,
		convert(varchar, year(WO.dtCreated)) + '-' + 
		convert(varchar, month(WO.dtCreated)) + '-' + 
		convert(varchar, day(WO.dtCreated)) + '-' + 
		convert(varchar, WO.WorkOrderNumber) as vchWorkOrderNumber,
		WOT.vchName as TypeName,
		case when isnull(LO.vchFirstName, '') = '' then '' else LO.vchLastName + ', ' + LO.vchFirstName end as OperatorName,
		isnull(WOS.vchStatus, '') as StatusName,
		isnull(WOS.vchColor, '') as StatusColor,
		isnull(WOOS.vchStatus, '&nbsp;') as OperatorStatusName,
		isnull(WOOS.vchColor, 'lightgrey') as OperatorColor,
		convert(varchar, WO.dtScheduled) as ScheduledDate,
		case when WO.StatusId = 3 then 'True' else 'False' end as IsNobody
	from WorkOrders WO
	inner join WorkOrderTypes WOT
	on WOT.[Id] = WO.TypeId
	and isnull(WO.intTechId, 0) = @TechId
	and isnull(WO.OperatorStatusId, 0) <> 2
	and WO.OrgId = @OrgId
	inner join WorkOrderStatus WOS 
	on  WO.StatusId = WOS.[Id]
	left outer join WorkOrderOperatorStatus WOOS
	on WO.OperatorStatusId = WOOS.[Id]
	left outer join Logins LO
	on WO.intOperatorId = LO.[Id]
	order by WO.dtScheduled asc





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

