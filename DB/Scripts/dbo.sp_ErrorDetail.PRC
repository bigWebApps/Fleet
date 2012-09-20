SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ErrorDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ErrorDetail]
GO

CREATE PROCEDURE sp_ErrorDetail
	(
		@Action char(1),
		@Id int,
		@UserId int=null output,
		@vchUserName varchar(102)=null output,
		@UserOrgId int=null output,
		@vchOrgName varchar(50)=null output,
		@vchErrorName varchar(1024)=null output,
		@vchPageName varchar(150)=null output,
		@dtCreated datetime=null output,
		@vchDesc varchar(4000)=null output
	)
AS
	set nocount on
	
	if @Action = 'S'
	begin
		if not exists(select 'true' from Errors where [Id] = @Id)
		begin
			return -1
		end
		else
		begin
			select 	@UserId = E.UserId,
				@vchUserName = isnull(L.vchLastName, 'Unknown') + ', ' + isnull(L.vchFirstName, 'Unknown'),
				@UserOrgId = E.UserOrgId,
				@vchOrgName = O.vchName,
				@vchErrorName = E.vchErrorName,
				@vchPageName = E.vchPageName,
				@dtCreated = E.dtCreated,
				@vchDesc = E.vchDesc
			from Errors E
			inner join Orgs O
			on O.[Id] = E.UserOrgId
			and E.[Id] = @Id
			left outer join Logins L
			on L.[Id] = E.UserId
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
			insert into [Errors](
				[UserId], 
				[UserOrgId], 
				[vchPageName], 
				[vchErrorName],
				[dtCreated], 
				[vchDesc]
				)
			values(
				@UserId,
				@UserOrgId,
				@vchPageName,
				@vchErrorName,
				@dtCreated,
				@vchDesc
				)
			return scope_identity()
		end
		else
		begin -- update
			if not exists(select 'true' from Errors where [Id] = @Id)
			begin
				return -1
			end
			else
			begin
				update 	[Errors]
				set 	[UserId]=@UserId,
					[UserOrgId]=@UserOrgId,
					[vchPageName]=@vchPageName,
					[vchErrorName]=@vchErrorName,
					[dtCreated]=@dtCreated,
					[vchDesc]=@vchDesc
				where 	[Id]=@Id
				return @Id
			end
		end
	end
	return 0

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

