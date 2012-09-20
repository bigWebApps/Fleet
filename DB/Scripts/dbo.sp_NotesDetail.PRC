SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_NotesDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_NotesDetail]
GO

CREATE   procedure sp_NotesDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int output,
		@TypeId int=null output,
		@ItemId int=null output,
		@UserId int=null output,
		@dtCreated datetime=null output,
		@vchDesc varchar(8000)=null output
	)
AS
	set nocount on
	if @Action = 'S'
	begin
		if @Id = 0
		begin
			select top 1 @Id = [Id],
				@UserId = UserId,
				@vchDesc = vchDesc,
				@dtCreated = dtCreated
			from Notes
			where TypeId = @TypeId
			and ItemId = @ItemId
			and OrgId = @OrgId
			if isnull(@Id, 0) <> 0
				return 0
			else
				return -1
		end
		else
		begin
			if not exists(select 'true' from Notes where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				select 	@TypeId = TypeId,
					@ItemId = ItemId,
					@UserId = UserId,
					@vchDesc = vchDesc,
					@dtCreated = dtCreated
				from Notes
				where [Id] = @Id
				and OrgId = @OrgId
				return 0
			end
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
			insert into Notes(
				[OrgId], 
				[TypeId], 
				[ItemId],
				[UserId], 
				[vchDesc],
				[dtCreated]
				)
			values(	@OrgId,
				@TypeId,
				@ItemId,
				@UserId,
				@vchDesc,
				@dtCreated
				)
			select @Id =  scope_identity()
			return 0
		end
		else
		begin -- update
			if not exists(select 'true' from Notes where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				update 	[Notes]
				set 	[TypeId] = @TypeId,
					[ItemId] = @ItemId,
					[UserId] = @UserId,
					[vchDesc] = @vchDesc,
					[dtCreated] = @dtCreated
				where 	[Id] = @Id
				and	OrgId = @OrgId
				return 0
			end
		end
	end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

