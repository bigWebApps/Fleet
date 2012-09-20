SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



ALTER  PROCEDURE sp_LoginsDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int,
		@vchFirstName varchar(50)=null output,
		@vchLastName varchar(50)=null output,
		@vchEmail varchar(50)=null output,
		@UpdatedLoginId int=null
	)
AS
	set nocount on
	
	if @Action = 'S'
	begin
		if not exists(select 'true' from Logins where [Id] = @Id)
		begin
			return -1
		end
		else
		begin
			select 	@vchFirstName = L.vchFirstName,
				@vchLastName = L.vchLastName,
				@vchEmail = L.vchEmail
			from Logins L
			where L.[Id] = @Id

			return 0
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
--			insert into [Locations]([OrgId], [vchName])
--			values(@OrgId, @vchName)

--			return scope_identity()

			return 0
		end
		else
		begin -- update
			if not exists(select 'true' from Logins L inner join Logins_Orgs LO on L.[Id] = LO.UserId and L.[Id] = @Id and LO.OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
--				update 	Locations
--				SET 	OrgId = @OrgId, 
--					vchName = @vchName
--				where 	[Id]=@Id
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

