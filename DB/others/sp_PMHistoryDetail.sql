SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER PROCEDURE sp_PMHistoryDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int output,
		@EquipId int=null output,
		@vchEquipId varchar(50)=null output,
		@dtDate datetime=null output,
		@PMSchedDetailId int=null output,
		@dmUnits decimal(19, 8)=null output,
		@WorkOrderId int=null output,
		@vchServiceName varchar(50)=null output,
		@PMStatus int=null output
	)
AS
	set nocount on
	
	if @Action = 'S'
	begin
		if isnull(@Id, 0) = 0
		begin
			if not exists(select 'true' from WorkOrders where [Id] = @WorkOrderId and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				select 	@EquipId = isnull(E.[Id], 0),
					@vchEquipId = isnull(E.vchEquipId, ''),
					@vchServiceName = isnull(S.vchDesc, ''),
					@dtDate = getdate(),
					@dmUnits = 0.0
				from WorkOrders WO
				inner join Equipments E 
				on WO.[Id] = @WorkOrderId
				and WO.OrgId = @OrgId
				and WO.EquipId = E.[Id]
				and WO.OrgId = E.OrgId
				left outer join PMSchedDetails SD
				on SD.[Id] = @PMSchedDetailId
				and SD.OrgId = @OrgId
				inner join PMServices S
				on S.[Id] = SD.PMServiceId
				and S.OrgId = SD.OrgId
			end
		end 
		else
		begin
			if not exists(select 'true' from EquipPMHistory where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				select 	@EquipId = isnull(EH.EquipId, 0),
					@vchEquipId = isnull(E.vchEquipId, ''),
					@vchServiceName = isnull(S.vchDesc, ''),
					@dtDate = isnull(EH.dtDate, getdate()),
					@PMSchedDetailId = isnull(EH.PMSchedDetailId, 0),
					@dmUnits = isnull(EH.dmUnits, 0.0),
					@WorkOrderId = isnull(EH.WorkOrderId, 0)
				from EquipPMHistory EH
				left join Equipments E 
				on E.[Id] = EH.EquipId
				and E.OrgId = EH.OrgId
				left outer join PMSchedDetails SD
				on SD.[Id] = EH.PMSchedDetailId
				and SD.OrgId = EH.OrgId
				inner join PMServices S
				on S.[Id] = SD.PMServiceId
				and S.OrgId = SD.OrgId
				where EH.[Id] = @Id
				and EH.OrgId = @OrgId
			end
		end
		
		if exists(select 'true' 
			from PMSchedDetails 
			where [Id] = @PMSchedDetailId
			and OrgId = @OrgId 
			and isnull(intDays, 0) = 0
			and isnull(dmUnits, 0.0) = 0.0
			)
		begin -- nothing status
			select @PMStatus = 0
		end

		if exists(select 'true' 
			from PMSchedDetails 
			where [Id] = @PMSchedDetailId
			and OrgId = @OrgId 
			and isnull(intDays, 0) <> 0
			and isnull(dmUnits, 0.0) = 0.0
			)
		begin -- Days status
			select @PMStatus = 1
		end

		if exists(select 'true' 
			from PMSchedDetails 
			where [Id] = @PMSchedDetailId
			and OrgId = @OrgId 
			and isnull(intDays, 0) = 0
			and isnull(dmUnits, 0.0) <> 0.0
			)
		begin -- Units status
			select @PMStatus = 2
		end

		if exists(select 'true' 
			from PMSchedDetails 
			where [Id] = @PMSchedDetailId
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
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
			insert into [EquipPMHistory](
				[OrgId], 
				[EquipId], 
				[dtDate], 
				[PMSchedDetailId], 
				[dmUnits], 
				[WorkOrderId]
				)
			values(	@OrgId,
				@EquipId,
				@dtDate,
				@PMSchedDetailId,
				@dmUnits,
				@WorkOrderId
				)
			select @Id = scope_identity()

			return 0
		end
		else
		begin -- update
			if not exists(select 'true' from EquipPMHistory where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				update 	EquipPMHistory
				set 	[EquipId]=@EquipId,
					[dtDate]=@dtDate,
					[PMSchedDetailId]=@PMSchedDetailId,
					[dmUnits]=@dmUnits,
					[WorkOrderId]=@WorkOrderId
				where 	[OrgId]=@OrgId
				and 	[Id]=@Id

				return 0
			end
		end
	end
	return 0





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

