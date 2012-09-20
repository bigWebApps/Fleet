SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create PROCEDURE sp_ReportedIssueDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int output,
		@EquipId int=null output,
		@vchDesc varchar(4000)=null output,
		@WorkOrderId int=null output,
		@LastWorkOrderId int=null output,
		@RepairCatId int=null output,
		@ServiceResultId int=null output,
		@dtReport datetime=null output
	)
AS
	set nocount on
	
	if @Action = 'S'
	begin
		if not exists(select 'true' from ReportedIssues where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			select 	@vchDesc = vchDesc,
				@WorkOrderId = WorkOrderId,
				@LastWorkOrderId = LastWorkOrderId,
				@EquipId = EquipId,
				@RepairCatId = RepairCatId,
				@ServiceResultId = ServiceResultId,
				@dtReport = dtReport
			from ReportedIssues 
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
			where [Id] = @WorkOrderId
			and OrgId = @OrgId

			insert into ReportedIssues(
				[OrgId], 
				[EquipId], 
				[vchDesc], 
				[WorkOrderId], 
				[LastWorkOrderId], 
				[RepairCatId], 
				[ServiceResultId], 
				[dtReport]
				)
			values(
				@OrgId,
				@EquipId,
				@vchDesc,
				@WorkOrderId,
				null, 
				@RepairCatId,
				@ServiceResultId,
				getdate()
				)
			select @Id = scope_identity()

			return 0
		end
		else
		begin -- update
			if not exists(select 'true' from ReportedIssues where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				update 	ReportedIssues
				set 	[EquipId] = @EquipId,
					[vchDesc] = @vchDesc,
					[WorkOrderId] = @WorkOrderId,
					[LastWorkOrderId] = @LastWorkOrderId,
					[RepairCatId] = @RepairCatId,
					[ServiceResultId] = @ServiceResultId,
					[dtReport] = @dtReport
				where 	[Id] = @Id
				and 	OrgId = @OrgId
				
				return 0
			end
		end
	end
	if @Action = 'D'
	begin
		if not exists(select 'true' from ReportedIssues where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			delete from ReportedIssues
			where [Id] = @Id
			and OrgId = @OrgId
	
			return 0
		end
	end



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

