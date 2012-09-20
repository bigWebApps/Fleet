SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER procedure sp_SigningWorkOrderClose
	(
		@OrgId int,
		@OrderId int,
		@chInitials char(3),
		@vchPIN varchar(10),
		@vchCleanliness varchar(1000),
		@dtCurrentDate datetime
	)
AS
	set nocount on
	
	if exists(select 'true' from Logins where Initials = @chInitials and PIN = @vchPIN)
	begin
		-- create a new unserviced reported issues 

		insert into WorkOrderReportedIssues(
			[OrgId], 
			[EquipId], 
			[vchDesc], 
			[WorkOrderId], 
			[LastWorkOrderId], 
			[RepairCatId], 
			[ServiceResultId], 
			[ServiceCheckId], 
			[RepairItemId], 
			[dtReport])
		select 	RI.OrgId, 
			RI.EquipId, 
			RI.vchDesc + ' (item copied from work order #' + convert(varchar, year(WO.dtCreated)) + '-' + convert(varchar, month(WO.dtCreated)) + '-' + convert(varchar, day(WO.dtCreated)) + '-' + convert(varchar, WO.WorkOrderNumber) + ')',
			null, 
			RI.WorkOrderId, 
			RI.RepairCatId,
			null, 
			null, 
			null, 
			RI.dtReport
		from WorkOrderReportedIssues RI
		inner join WorkOrders WO
		on 	RI.WorkOrderId = @OrderId
		and 	RI.OrgId = @OrgId
		and 	isnull(RI.ServiceCheckId, 0) = 3
		and 	isnull(RI.ServiceResultId, 0) = 0
		and 	RI.WorkOrderId = WO.[Id]
		and 	RI.OrgId = WO.OrgId
		
		-- change status
		update 	WorkOrders
		set 	StatusId = 2,
			dtClosed = @dtCurrentDate,
			vchCleanliness = @vchCleanliness
		where 	[Id] = @OrderId
		and 	OrgId = @OrgId

		-- sign to close
		insert into [SignedDocuments](
			[OrgId], 
			[UserId], 
			[DocumentId], 
			[DocumentTypeId], 
			[dtSignDate]
			)
		select 	@OrgId,
			L.[Id],
			@OrderId,
			4,
			@dtCurrentDate
		from Logins L 
		where L.Initials = @chInitials 
		and L.PIN = @vchPIN
		return 0
	end
	else
	begin
		return -1
	end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

