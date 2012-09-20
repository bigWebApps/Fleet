SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_LoginsDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_LoginsDetail]
GO



CREATE  procedure dbo.sp_LoginsDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int output,
		@vchFirstName varchar(50)=null output,
		@vchLastName varchar(50)=null output,
		@btActive bit=null output,
		@chInitials char(3)=null output,
		@vchEmail varchar(50)=null output,
		@vchTypeName varchar(50)=null output,
		@dtCreated datetime=null output,
		@UpdatedLoginId int=null
	)
AS
	set nocount on
	
	if @Action = 'S'
	begin
		if not exists(select 'true' 
			from Logins L
			inner join Logins_Orgs LO
			on L.[Id] = @Id
			and LO.UserId = L.[Id]
			and LO.OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			select 	@vchFirstName = L.vchFirstName,
				@vchLastName = L.vchLastName,
				@chInitials = L.Initials,
				@vchEmail = L.vchEmail,
				@btActive = L.btActive,
				@vchTypeName = (
					select case when count(LUT.[Id]) > 1 
						then 'Technician/Operator'
						else (	case when min(LUT.[UserTypeId])=1 
							then 'Technician'
							else 'Operator'
							end
							)
						end 
					from Logins_UserTypes LUT
					where LUT.UserId = L.[Id]),
				@dtCreated = L.dtCreated
			from Logins L
			inner join Logins_Orgs LO
			on L.[Id] = @Id
			and LO.UserId = L.[Id]
			and LO.OrgId = @OrgId
			return 0
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert

			insert into [Logins](
				[vchFirstName], 
				[vchLastName], 
				[vchEmail], 
				[vchPass], 
				[btActive], 
				[Initials], 
				[PIN], 
				[dtCreated], 
				[CreatedLoginId], 
				[dtUpdated], 
				[UpdatedLoginId], 
				[salt]
				)
			values(	@vchFirstName,
				@vchLastName,
				@vchEmail,
				'',
				1,
				@chInitials,
				'',
				@dtCreated, 
				@UpdatedLoginId, 
				@dtCreated, 
				@UpdatedLoginId, 
				''
				)
			
			select @Id = scope_identity()
			
			insert into [Logins_Orgs]([UserId], [OrgId])
			values(@Id, @OrgId)
			
		end
		else
		begin -- update
			if not exists(select 'true' from Logins L inner join Logins_Orgs LO on L.[Id] = LO.UserId and L.[Id] = @Id and LO.OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				-- updating user info
				update 	[Logins]
				set 	[vchFirstName] = @vchFirstName,
					[vchLastName] = @vchLastName,
					[vchEmail] = @vchEmail,
					[dtUpdated] = @dtCreated, 
					[UpdatedLoginId] = @UpdatedLoginId
				where 	[Id] = @Id

			end
		end

		-- updatng the user type
		if @vchTypeName = 'Technician/Operator'
		begin
			if not exists(select 'true'
				from Logins_UserTypes
				where UserId = @Id
				and UserTypeId in (1,2)
				having count([Id]) = 2
				)
			begin
				-- need update
				delete 
				from Logins_UserTypes 
				where UserId = @Id
				insert into Logins_UserTypes(UserId, UserTypeId)
				select @Id, 1
				union all 
				select @Id, 2
			end
		end
		if @vchTypeName = 'Technician'
		begin
			if not exists(select 'true'
				from Logins_UserTypes
				where 2 not in (
					select count([Id])
					from Logins_UserTypes
					where UserId = @Id
					)
				and UserTypeId = 1
				and UserId = @Id
				)
			begin
				delete 
				from Logins_UserTypes 
				where UserId = @Id
				insert into Logins_UserTypes(UserId, UserTypeId)
				select @Id, 1
			end
		end
		if @vchTypeName = 'Operator'
		begin
			if not exists(select 'true'
				from Logins_UserTypes
				where 2 not in (
					select count([Id])
					from Logins_UserTypes
					where UserId = @Id
					)
				and UserTypeId = 2
				and UserId = @Id
				)
			begin
				delete 
				from Logins_UserTypes 
				where UserId = @Id
				insert into Logins_UserTypes(UserId, UserTypeId)
				select @Id, 2
			end
		end

		return 0
	end




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

