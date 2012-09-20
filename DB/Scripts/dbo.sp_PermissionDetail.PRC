SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PermissionDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PermissionDetail]
GO

CREATE  PROCEDURE sp_PermissionDetail
	(
		@Action char(1),
		@Id int,
		@vchName varchar(150)=null output,
		@chCode char(3)=null output
	)
AS
	set nocount on
	
	if @Action = 'S'
	begin
		if not exists(select 'true' from [Permissions] where [Id] = @Id)
		begin
			return -1
		end
		else
		begin
			select 	@vchName = isnull(vchName, ''),
				@chCode = isnull(chCode, '')
			from [Permissions]
			where [Id] = @Id
			return 0
		end
	end
	if @Action = 'D'
	begin
		if not exists(select 'true' from [Permissions] where [Id] = @Id)
		begin
			return -1
		end
		else
		begin
			delete from Pages_Permissions
			where PermissionId = @Id
			delete from [Permissions]
			where [Id] = @Id
			return 0
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
			insert into [Permissions]([vchName], [chCode])
			values(isnull(@vchName, ''), isnull(@chCode, ''))
			return 0
		end
		else
		begin -- update
			if not exists(select 'true' from [Permissions] where [Id] = @Id)
			begin
				return -1
			end
			else
			begin
				update 	[Permissions]
				set 	[vchName] = isnull(@vchName, '')
				where [Id]=@Id
				return 0
			end
		end
	end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

