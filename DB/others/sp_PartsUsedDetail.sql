SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

alter PROCEDURE sp_PartsUsedDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int output,
		@RepairId int=null output,
		@intQty int=null output,
		@vchStock varchar(50)=null output,
		@vchDesc varchar(1024)=null output,
		@dmCost decimal(18, 2)=null output
	)
AS
	set nocount on
	
	if @Action = 'S'
	begin
		if not exists(select 'true' from PartsUsed where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			select 	@RepairId = RepairId,
				@intQty = intQty,
				@vchStock = vchStock,
				@vchDesc = vchDesc,
				@dmCost = dmCost
			from 	PartsUsed
			where 	[Id] = @Id
			and 	OrgId = @OrgId

			return 0
		end
	end

	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
			insert into [PartsUsed](
				OrgId, 
				RepairId,
				intQty,
				vchStock,
				vchDesc,
				dmCost
				)
			values(	
				@OrgId,
				@RepairId,
				@intQty,
				@vchStock,
				@vchDesc,
				isnull(@dmCost, 0.0)
				)

			select @Id = scope_identity()

			return 0
		end
		else
		begin -- update
			if not exists(select 'true' from PartsUsed where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				update 	PartsUsed
				set 	RepairId = isnull(@RepairId, RepairId),
					intQty = isnull(@intQty, intQty),
					vchStock = isnull(@vchStock, vchStock),
					vchDesc = isnull(@vchDesc, vchDesc),
					dmCost = isnull(@dmCost, dmCost)
				where 	[Id] = @Id
				and 	OrgId = @OrgId

				return 0
			end
		end
	end

	if @Action = 'D'
	begin
		if not exists(select 'true' from PartsUsed where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			delete from PartsUsed 
			where [Id] = @Id 
			and OrgId = @OrgId
		end
	end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

