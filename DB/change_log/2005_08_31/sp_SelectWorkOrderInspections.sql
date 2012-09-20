SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Last Modification Date: 09/09/2005
-- Description: Procedure select inspection of current work order 
---------------------------------------------------------------------------
ALTER   procedure sp_SelectWorkOrderInspections
	(
		@OrgId int,
		@OrderId int,
		@UserId int
	)
as
	set nocount on
	declare @btEnableLink bit

	select @btEnableLink = dbo.f_IsTechnician(@UserId)

	if exists(select 'true' 
		from WorkOrders 
		where [Id] = @OrderId 
		and OrgId = @OrgId
		and StatusId <> 2 
		)
	begin
		select @btEnableLink = 1
	end
	else
	begin
		select @btEnableLink = 0
	end

	select 	WOI.[Id],
		@OrderId as OrderId,
		case when isnull(WOI.btIsProcessed, 0) = 0 then 'images\Fail.gif' else 'images\Okay.gif' end as IsProcessed,
		I.vchName as InspectionName,
		case when isnull(WOI.btIsProcessed, 0) = 0 then 'Incomplete' else 'Completed' end as StatusName,
		case when isnull(WOI.btIsProcessed, 0) = 0 then '[complete]' else '[view]' end as LinkName,
		case when @btEnableLink = 1
			and isnull(WOI.btIsProcessed, 0) = 0 
			then 'True' 
			else 'False' 
		end as Access,
		case when @btEnableLink = 1
			and isnull(WOI.btIsProcessed, 0) = 0 
			then 'javascript:return confirm("Are you sure that you want to delete this item?")'
			else ''
		end as RemoveConfirmation,
		case when isnull(WO.StatusId, 0) = 3 
			then case when isnull(WO.OperatorStatusId, 0) = 0
				then 'javascript:return confirm("This work order is not currently Checked-In. Click OK to Check-In and Open this Work Order.")'
				else 'javascript:return confirm("This work order is not currently Open. Click OK to Open this Work Order.")'
			end
			else '' 
		end as Confirmation
	from WorkOrderInspections WOI
	inner join InspectSchedDetails ISD
	on WOI.WorkOrderId = @OrderId
	and WOI.OrgId = @OrgId
	and ISD.[Id] = WOI.InspectSchedDetailId
	and ISD.OrgId = WOI.OrgId
	inner join Inspections I
	on I.[Id] = ISD.InspectionId
	and I.OrgId = ISD.OrgId
	inner join WorkOrders WO
	on WOI.WorkOrderId = WO.[Id]
	and WOI.OrgId = WO.OrgId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

