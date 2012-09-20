SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER  PROCEDURE sp_EquipPMService
	(
		@OrgId int,
		@OrderId int,
		@SchedDetailId int,
		@EquipId int=null output,
		@vchEquipId varchar(50)=null output,
		@vchServiceName varchar(50)=null output,
		@PMStatus int=null output
	)
AS
	set nocount on
	
	if not exists(select 'true' from WorkOrders where [Id] = @OrderId and OrgId = @OrgId)
	begin
		return -1
	end
	else
	begin
		if not exists(select 'true' from PMSchedDetails where [Id] = @OrderId and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			select 	@EquipId = E.[Id],
				@vchEquipId = E.vchEquipId,
				@vchServiceName = S.vchDesc
			from WorkOrders WO
			inner join Equipments E 
			on WO.[Id] = @OrderId
			and WO.OrgId = @OrgId
			and WO.EquipId = E.[Id]
			and WO.OrgId = E.OrgId
			left outer join PMSchedDetails SD
			on SD.[Id] = @SchedDetailId
			and SD.OrgId = @OrgId
			inner join PMServices S
			on S.[Id] = SD.PMServiceId
			and S.OrgId = SD.OrgId
			
			if exists(select 'true' 
				from PMSchedDetails 
				where [Id] = @SchedDetailId 
				and OrgId = @OrgId 
				and isnull(intDays, 0) = 0
				and isnull(dmUnits, 0.0) = 0.0
				)
			begin -- nothing status
				select @PMStatus = 0
			end

			if exists(select 'true' 
				from PMSchedDetails 
				where [Id] = @SchedDetailId 
				and OrgId = @OrgId 
				and isnull(intDays, 0) <> 0
				and isnull(dmUnits, 0.0) = 0.0
				)
			begin -- Days status
				select @PMStatus = 1
			end

			if exists(select 'true' 
				from PMSchedDetails 
				where [Id] = @SchedDetailId 
				and OrgId = @OrgId 
				and isnull(intDays, 0) = 0
				and isnull(dmUnits, 0.0) <> 0.0
				)
			begin -- Units status
				select @PMStatus = 2
			end

			if exists(select 'true' 
				from PMSchedDetails 
				where [Id] = @SchedDetailId 
				and OrgId = @OrgId 
				and isnull(intDays, 0) <> 0
				and isnull(dmUnits, 0.0) <> 0.0
				)
			begin -- Both status
				select @PMStatus = 3
			end

			select @PMStatus = isnull(@PMStatus, 0)

			return 0
		end
	end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

