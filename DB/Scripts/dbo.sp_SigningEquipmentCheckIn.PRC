SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SigningEquipmentCheckIn]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SigningEquipmentCheckIn]
GO


CREATE  procedure sp_SigningEquipmentCheckIn
	(
		@OrgId int,
		@OrderId int,
		@chInitials char(3),
		@vchPIN varchar(10),
		@dmCurrentUnits decimal(19,8),
		@btStaying bit,
		@vchDropedOffBy varchar(50),
		@dtCurrentDate datetime,
		@UserId int=null output
	)
AS
	set nocount on
	declare @EquipId int
	select @UserId = [Id] 
	from Logins 
	where Initials = @chInitials 
	and PIN = @vchPIN
	select 	@EquipId = EquipId 
	from 	[WorkOrders]
	where 	[Id] = @OrderId
	and 	[OrgId] = @OrgId 
	if isnull(@UserId, 0) <> 0 and isnull(@EquipId, 0) <> 0
	begin
		update 	WorkOrders
		set 	OperatorStatusId = 1,
			dtArrival = @dtCurrentDate,
			[vchDropedOffBy] = @vchDropedOffBy,
			bitStaying = @btStaying,
			intUpdatedBy = @UserId,
			dtUpdated = @dtCurrentDate
		where 	[Id] = @OrderId
		and 	OrgId = @OrgId
		if exists(select 'true' 
			from Equipments 
			where [Id] = @EquipId
			and OrgId = @OrgId 
			and dmCurrentUnits < @dmCurrentUnits
			)
		begin
			-- update the current units of equipment 
			insert into [EquipUnitLogs](
				[OrgId], 
				[EquipId], 
				[LogTypeId], 
				[dtDate], 
				[dmUnits]
				)
			values(
				@OrgId, 
				@EquipId,
				1,
				@dtCurrentDate,
				@dmCurrentUnits
				)
	
			update Equipments
			set dmCurrentUnits = @dmCurrentUnits
			where [Id] = @EquipId
			and OrgId = @OrgId
	
			update 	[WorkOrders]
			set 	[dmMileage] = @dmCurrentUnits
			where 	[Id] = @OrderId
			and 	[OrgId] = @OrgId 
		end
		insert into [SignedDocuments](
			[OrgId], 
			[UserId], 
			[DocumentId], 
			[DocumentTypeId], 
			[dtSignDate]
			)
		values	(
			@OrgId,
			@UserId,
			@OrderId,
			1,
			@dtCurrentDate
			)
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

