SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


alter PROCEDURE sp_PreventiveMaintItemsDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int output,
		@WorkOrderId int=null output,
		@PMSchedDetailId int=null output,
		@ServiceResultId int=null output,
		@dtReport datetime=null output
	)
AS
	set nocount on
	
	if @Action = 'S'
	begin
		if not exists(select 'true' from PreventiveMaintItems where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			select 	@WorkOrderId = WorkOrderId,
				@PMSchedDetailId = PMSchedDetailId,
				@ServiceResultId = ServiceResultId,
				@dtReport = dtReport
			from PreventiveMaintItems
			where [Id] = @Id
			and OrgId = @OrgId

			return 0
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
			
			insert into [PreventiveMaintItems](
				[OrgId], 
				[WorkOrderId], 
				[PMSchedDetailId], 
				[ServiceResultId],
				[dtReport]
				)
			values(
				@OrgId,
				@WorkOrderId,
				@PMSchedDetailId,
				@ServiceResultId,
				getdate()
				)
			select @Id = scope_identity()

			return 0
		end
		else
		begin -- update
			if not exists(select 'true' from PreventiveMaintItems where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				update 	[PreventiveMaintItems]
				set 	[WorkOrderId]=@WorkOrderId,
					[PMSchedDetailId]=@PMSchedDetailId,
					[dtReport]=@dtReport
				where 	[Id] = @Id
				and 	OrgId = @OrgId
				
				return 0
			end
		end
	end
	if @Action = 'D'
	begin
		if not exists(select 'true' from PreventiveMaintItems where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			delete from PreventiveMaintItems
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

