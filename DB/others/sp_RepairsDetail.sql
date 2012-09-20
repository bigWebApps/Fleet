SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER  PROCEDURE sp_RepairsDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int output,
		@RepairItemId int=null output,
		@WorkOrderId int=null output
	)
AS
	set nocount on
	
	if @Action = 'S'
	begin
		if not exists(select 'true' from Repairs where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			select 	@RepairItemId = RepairItemId,
				@WorkOrderId = WorkOrderId
			from 	Repairs
			where 	[Id] = @Id
			and 	OrgId = @OrgId
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
			insert into [Repairs](
				[OrgId], 
				[RepairItemId], 
				[WorkOrderId]
				)
			values(	@OrgId,
				@RepairItemId,
				@WorkOrderId
				)

			select @Id = scope_identity()

			return 0
		end
		else
		begin -- update
			if not exists(select 'true' from Repairs where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				update 	[Repairs]
				set 	[RepairItemId] = @RepairItemId,
					[WorkOrderId] = @WorkOrderId
				where 	[Id] = @Id
				and 	OrgId = @OrgId

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

