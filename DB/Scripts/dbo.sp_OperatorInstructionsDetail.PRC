SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_OperatorInstructionsDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_OperatorInstructionsDetail]
GO

create procedure sp_OperatorInstructionsDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int output,
		@TypeId int=null output,
		@vchNote varchar(8000)=null output
	)
AS
	set nocount on
	if @Action = 'S'
	begin
		if not exists(select 'true' from OperatorInstructions where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			if @Id = 0
			begin
				select top 1 @Id = [Id],
					@vchNote = vchNote
				from OperatorInstructions
				where TypeId = @TypeId
				and OrgId = @OrgId
			end
			else
			begin
				select 	@TypeId = TypeId,
					@vchNote = vchNote
				from OperatorInstructions
				where [Id] = @Id
				and OrgId = @OrgId
			end
			return 0
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
			insert into OperatorInstructions(
				[OrgId], 
				[TypeId], 
				[vchNote]
				)
			values(	@OrgId,
				@TypeId,
				@vchNote
				)
			select @Id =  scope_identity()
			return -1
		end
		else
		begin -- update
			if not exists(select 'true' from OperatorInstructions where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				update 	[OperatorInstructions]
				set 	[TypeId] = @TypeId,
					[vchNote] = @vchNote
				where 	[Id] = @Id
				and	OrgId = @OrgId
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

