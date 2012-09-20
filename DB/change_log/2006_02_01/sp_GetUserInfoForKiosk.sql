SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




ALTER   procedure dbo.sp_GetUserInfoForKiosk
(
	@OrgId int,
	@UserId int,
	@dtCurrentDate datetime,
	@EquipId int=null output
)
as
	set nocount on

	declare @CountEquip int
	declare @ActiveEquips table (
		EquipId int
		)

	if exists(select 'true' from Logins where [Id] = @UserId)
	begin
		insert into @ActiveEquips(EquipId)
		select distinct WO.EquipId
		from WorkOrders WO
		inner join SignedDocuments SD
		on WO.StatusId <> 2
		and isnull(WO.OperatorStatusId, 0) = 1
		and WO.OrgId = @OrgId
		and WO.btIsActive = 1
		and SD.DocumentId = WO.[Id]
		and SD.DocumentTypeId = 1
		and SD.UserId = @UserId
		and SD.OrgId = WO.OrgId

		insert into @ActiveEquips(EquipId)
		select distinct WO.EquipId
		from WorkOrders WO
		inner join SignedDocuments SD
		on WO.StatusId = 2
		and WO.dtClosed between dateadd(d, -1, dateadd(d, datediff(d, '', @dtCurrentDate), '')) and dateadd(d, datediff(d, '', dateadd(d, 1, @dtCurrentDate)), '')
		and WO.OrgId = @OrgId
		and WO.btIsActive = 1
		and SD.DocumentId = WO.[Id]
		and SD.DocumentTypeId = 1
		and SD.UserId = @UserId
		and SD.OrgId = WO.OrgId

		insert into @ActiveEquips(EquipId)
		select E.[Id]
		from Equipments E 
		where E.EquipOperatorId = @UserId	
		and E.OrgId = @OrgId
		and E.[Id] not in (
			select WO.EquipId
			from WorkOrders WO
			where isnull(WO.OperatorStatusId, 0) <> 2
			and WO.OrgId = E.OrgId
			union all
			select EquipId
			from @ActiveEquips
			)

--		select * from @ActiveEquips

		select @CountEquip = count(EquipId), @EquipId = 0
		from @ActiveEquips

		if @CountEquip < 1
		begin
			return 0
		end

		if @CountEquip = 1
		begin
			select top 1 @EquipId = EquipId
			from @ActiveEquips

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

