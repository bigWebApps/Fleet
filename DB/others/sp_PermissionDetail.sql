SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sp_PermissionDetail
	(
		@Action char(1),
		@Id int,
		@vchName varchar(150),
		@chCode char(3)
	)
AS
	set nocount on
	
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
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
			insert into [Permissions]([vchName], [chCode])
			values(@vchName, @chCode)

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
				set 	[vchName] = @vchName
				where [Id]=@Id

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

