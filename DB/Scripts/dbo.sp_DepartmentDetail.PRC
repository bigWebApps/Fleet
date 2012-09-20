SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_DepartmentDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_DepartmentDetail]
GO

CREATE PROCEDURE sp_DepartmentDetail
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
		if not exists(select 'true' from Departments where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			select @vchName = vchName 
			from Departments
			where [Id] = @Id
			and OrgId = @OrgId
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
			insert into [Departments]([OrgId], [vchName])
			values(@OrgId, @vchName)
			select @Id = scope_identity()
			return 0
		end
		else
		begin -- update
			if not exists(select 'true' from Departments where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				update 	[Departments]
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

