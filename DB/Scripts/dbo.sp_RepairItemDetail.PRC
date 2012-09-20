SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_RepairItemDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_RepairItemDetail]
GO

CREATE   PROCEDURE sp_RepairItemDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int output,
		@CatId int=null output,
		@vchDesc varchar(1000)=null output
	)
AS
	set nocount on
	
	if @Action = 'S'
	begin
		if not exists(select 'true' from RepairItems where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			select 	@CatId = CatId,
				@vchDesc = vchDesc
			from 	RepairItems
			where 	[Id] = @Id
			and 	OrgId = @OrgId
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
			insert into [RepairItems](
				[OrgId], 
				[CatId], 
				[vchDesc]
				)
			values(	@OrgId,
				@CatId,
				@vchDesc
				)
			select @Id = scope_identity()
			return 0
		end
		else
		begin -- update
			if not exists(select 'true' from RepairItems where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				update 	[RepairItems]
				set 	[CatId] = isnull(@CatId, CatId),
					[vchDesc] = isnull(@vchDesc, vchDesc)
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

