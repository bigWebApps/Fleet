--
-- Script To Update dbo.sp_OperatorInstructionsDetail Procedure In largo.BFS_Beta
-- Generated Thursday, June 22, 2006, at 06:42 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Updating dbo.sp_OperatorInstructionsDetail Procedure'
GO

SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, QUOTED_IDENTIFIER, CONCAT_NULL_YIELDS_NULL ON
GO

SET NUMERIC_ROUNDABORT OFF
GO


IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
exec('ALTER procedure dbo.sp_OperatorInstructionsDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int output,
		@TypeId int=null output,
		@vchNote varchar(8000)=null output
	)
AS
	set nocount on
	if @Action = ''S''
	begin
		if not exists(select ''true'' from OperatorInstructions where [Id] = @Id and OrgId = @OrgId)
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
	if @Action = ''U''
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

			return 0
		end
		else
		begin -- update
			if not exists(select ''true'' from OperatorInstructions where [Id] = @Id and OrgId = @OrgId)
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
	if @Action = ''D''
	begin
		if not exists(select ''true'' from OperatorInstructions where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			delete	
			from	[OperatorInstructions]
			where 	[Id] = @Id
			and	OrgId = @OrgId

			return 0
		end
	end

	return 0')
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_OperatorInstructionsDetail Procedure Updated Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Update dbo.sp_OperatorInstructionsDetail Procedure'
END
GO