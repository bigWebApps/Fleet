SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


create procedure dbo.sp_GetUserInfoForKiosk
(
	@OrgId int,
	@UserId int,
	@EquipId int=null output
)
as
	set nocount on

	declare @CountEquip int

	if exists(select 'true' from Logins where [Id] = @UserId)
	begin
		select @CountEquip = count([Id]), @EquipId = 0
		from Equipments 
		where OrgId = @OrgId
		and EquipOperatorId = @UserId

		if @CountEquip < 1
		begin
			return 0
		end

		if @CountEquip = 1
		begin
			select @EquipId = [Id]
			from Equipments 
			where OrgId = @OrgId
			and EquipOperatorId = @UserId

			return 1
		end

		if @CountEquip > 1
		begin
			return 2
		end
	end
	else
	begin
		return -1
	end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

