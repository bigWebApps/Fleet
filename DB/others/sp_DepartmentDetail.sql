SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_LocationDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int output,
		@vchName varchar(25) output
	)
AS
	set nocount on
	
	if @Action = 'S'
	begin
		if not exists(select 'true' from Locations where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			select @vchName = vchName 
			from Locations
			where [Id] = @Id
			and OrgId = @OrgId
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
			insert into [Locations]([OrgId], [vchName])
			values(@OrgId, @vchName)

			select @Id = scope_identity()

			return 0
		end
		else
		begin -- update
			if not exists(select 'true' from Locations where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				update 	Locations
				SET 	OrgId = @OrgId, 
					vchName = @vchName
				where 	[Id]=@Id
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

