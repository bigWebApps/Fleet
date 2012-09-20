SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

alter PROCEDURE sp_EquipReportedRepairsDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int output,
		@vchSpecificDesc varchar(2000)=null output,
		@StatusId int=null output,
		@OrderId int=null output,
		@EquipId int=null output,
		@RepairItemId int=null output,
		@ReasonId int=null output,
		@dtCreated datetime=null output,
		@dtUpdated datetime=null output
	)
AS
	set nocount on
	
	if @Action = 'S'
	begin
		if not exists(select 'true' from EquipReportedRepairs where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			select 	@vchSpecificDesc = vchSpecificDesc,
				@StatusId = StatusId,
				@OrderId = OrderId,
				@EquipId = EquipId,
				@RepairItemId = RepairItemId,
				@ReasonId = ReasonId,
				@dtCreated = dtCreated,
				@dtUpdated = dtUpdated
			from EquipReportedRepairs 
			where [Id] = @Id
			and OrgId = @OrgId

			return 0
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
			select @EquipId = EquipId
			from WorkOrders
			where [Id] = @OrderId
			and OrgId = @OrgId

			insert into EquipReportedRepairs(
				[OrgId], 
				[vchSpecificDesc], 
				[StatusId], 
				[OrderId], 
				[EquipId], 
				[RepairItemId], 
				[ReasonId], 
				[dtCreated], 
				[dtUpdated]
				)
			values(
				@OrgId,
				@vchSpecificDesc,
				@StatusId,
				@OrderId,
				@EquipId,
				@RepairItemId,
				@ReasonId,
				getdate(),
				getdate()
				)			
			select @Id = scope_identity()

			return 0
		end
		else
		begin -- update
			if not exists(select 'true' from EquipReportedRepairs where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				update 	[EquipReportedRepairs]
				set 	[vchSpecificDesc] = @vchSpecificDesc,
					[StatusId] = @StatusId,
					[OrderId] = @OrderId,
					[EquipId] = @EquipId,
					[RepairItemId] = @RepairItemId,
					[ReasonId] = @ReasonId,
					[dtUpdated] = getdate()
				where 	[Id] = @Id
				and 	OrgId = @OrgId
				return 0
			end
		end
	end
	if @Action = 'D'
	begin
		if not exists(select 'true' from EquipReportedRepairs where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			delete from [EquipReportedRepairs]
			where [Id] = @Id
			and OrgId = @OrgId
		end
	end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

