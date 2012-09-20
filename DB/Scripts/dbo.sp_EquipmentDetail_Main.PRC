SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_EquipmentDetail_Main]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_EquipmentDetail_Main]
GO


CREATE procedure sp_EquipmentDetail_Main
	(
		@Action char(1),
		@OrgId int,
		@Id int,
		@TypeId int=null OUTPUT,
		@vchTypeName varchar(50)=null OUTPUT,
		@ModelId int=null OUTPUT,
		@vchMakeModelName varchar(101)=null OUTPUT,
		@intYear int=null OUTPUT,
		@EquipOperatorId int=null OUTPUT,
		@TempOperatorId int=null output,
		@vchEquipOperator varchar(102)=null OUTPUT,
		@vchTempOperator varchar(102)=null OUTPUT,
		@DeptId int=null OUTPUT,
		@vchDeptName varchar(25)=null OUTPUT,
		@LocId int=null OUTPUT,
		@vchLocName varchar(50)=null OUTPUT,
		@bitSpare bit=null OUTPUT,
		@vchFuelCode varchar(20)=null OUTPUT,
		@vchEquipId varchar(50)=null OUTPUT,
		@vchVinSerial varchar(50)=null OUTPUT,
		@vchPlateNumber varchar(50)=null OUTPUT,
		@dmCurrentUnits decimal(19,8)=null OUTPUT,
		@intCreatedBy int=null OUTPUT,
		@vchCreatedBy varchar(102)=null OUTPUT,
		@dtCreated datetime=null OUTPUT,
		@intUpdatedBy int=null OUTPUT,
		@vchUpdatedBy varchar(102)=null OUTPUT,
		@dtUpdated datetime=null OUTPUT
	)
AS
	set nocount on
	declare @DataId int
	declare @ReturnId int
	declare @step int
	declare @N int
	create table #default(
		[Id] int identity(1,1),
		ComponentId int
		)
	if @Action = 'S'
	begin
		if not exists(select 'true' from Equipments where OrgId=@OrgId and [Id]=@Id)
		begin
			return -1
		end
		else
		begin
			select 	@TypeId = E.TypeId,
				@vchTypeName = ISNULL(ET.vchName, ''),
				@ModelId = E.ModelId,
				@vchMakeModelName = ISNULL(EMa.vchMakeName, '') + '/' + ISNULL(EMo.vchModelName, ''),
				@intYear = E.intYear,
				@EquipOperatorId = E.EquipOperatorId,
				@vchEquipOperator = (select case when isnull(La.vchFirstName, '') = '' then '' else La.vchLastName + ', ' + La.vchFirstName end),
				@TempOperatorId = E.TempOperatorId,
				@vchTempOperator = (select case when isnull(Lt.vchFirstName, '') = '' then '' else Lt.vchLastName + ', ' + Lt.vchFirstName end),
				@DeptId = E.DeptId,
				@vchDeptName = ISNULL(D.vchName, ''),
				@LocId = E.LocId, 
				@vchLocName = ISNULL(L.vchName, ''),
				@bitSpare = ISNULL(E.bitSpare, 0),
				@vchFuelCode = ISNULL(E.vchFuelCode, ''),
				@vchEquipId = ISNULL(E.vchEquipId, ''),
				@vchVinSerial = ISNULL(E.vchVinSerial, ''),
				@vchPlateNumber = ISNULL(E.vchPlateNumber, ''),
				@dmCurrentUnits = E.dmCurrentUnits,
				@intCreatedBy = E.intCreatedBy,
				@vchCreatedBy = (select case when isnull(Lc.vchFirstName, '') = '' then '' else Lc.vchLastName + ', ' + Lc.vchFirstName end),
				@dtCreated = E.dtCreated,
				@intUpdatedBy = E.intUpdatedBy,
				@vchUpdatedBy = (select case when isnull(Lu.vchFirstName, '') = '' then '' else Lu.vchLastName + ', ' + Lu.vchFirstName end),
				@dtUpdated = E.dtUpdated
			from Equipments E
			inner join EquipTypes ET 
			on ET.OrgId = @OrgId and ET.[Id] = E.TypeId
			and E.OrgId = @OrgId and E.[Id] = @Id
			left outer join EquipModels EMo
			on EMo.OrgId = @OrgId and EMo.[Id] = E.ModelId 
			left outer join EquipModelType EMT
			on EMT.OrgId = @OrgId and EMT.[Id] = EMo.TypeId
			left outer join EquipMakes EMa
			on EMa.OrgId = @OrgId and EMa.[Id] = EMT.MakeId
			left outer join Logins La
			on La.[Id] = E.EquipOperatorId
			left outer join Logins Lt
			on Lt.[Id] = E.TempOperatorId
			left outer join Departments D
			on D.OrgId = @OrgId and D.[Id] = E.DeptId
			left outer join Locations L
			on L.OrgId = @OrgId and L.[Id] = E.LocId
			left outer join Logins Lc
			on Lc.[Id] = E.intCreatedBy
			left outer join Logins Lu
			on Lu.[Id] = E.intUpdatedBy
	
			return 0
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
			-- insert EquipData and Equipment
			insert into [EquipData](
				[OrgId], 
				[intCreatedBy], 
				[dtCreated], 
				[intUpdatedBy], 
				[dtUpdated], 
				[vchOrdering], 
				[ftItemOrder], 
				[intSize]
				)
			values(
				@OrgId,
				@intCreatedBy,
				getutcdate(),
				@intUpdatedBy,
				getutcdate(),
				null, 
				null, 
				0
				)
			select @DataId = scope_identity()
			insert into [Equipments](
				[OrgId],
				[TypeId],
				[ModelId],
				[intYear],
				[EquipOperatorId],
				[TempOperatorId],
				[DeptId],
				[LocId],
				[DataId],
				[bitSpare],
				[vchFuelCode],
				[vchEquipId],
				[vchVinSerial],
				[vchPlateNumber],
				[intCreatedBy],
				[dtCreated],
				[intUpdatedBy],
				[dtUpdated]
				)
			values(
				@OrgId,
				@TypeId,
				@ModelId,
				@intYear,
				@EquipOperatorId,
				@TempOperatorId,
				@DeptId,
				@LocId,
				@DataId,
				@bitSpare,
				@vchFuelCode,
				@vchEquipId,
				@vchVinSerial,
				@vchPlateNumber,
				@intCreatedBy,
				getdate(),
				@intUpdatedBy,
				getdate()
				)
			select @ReturnId = scope_identity()
			insert into #default(ComponentId)
			select 	ComponentTypeId
			from 	EquipComponentDefault
			where 	EquipmentTypeId = @TypeId
			and 	OrgId = @OrgId
			select @step = 0
			select @N = count([Id]) from #default
			while @step < @N
			begin
				select @step = @step + 1
				-- insert data in the custom fields for Components
				insert into [EquipData]([OrgId], [intCreatedBy], [dtCreated], [intUpdatedBy], [dtUpdated], [vchOrdering], [ftItemOrder], [intSize])
				values(@OrgId, @intCreatedBy,	getutcdate(), @intUpdatedBy, getutcdate(), null, null, 0)
				select @DataId = scope_identity()
				-- insert default components
				insert into [EquipComponents](
					[OrgId], 
					[TypeId], 
					[EquipId], 
					[DataId], 
					[btActive]
					)
				select 	@OrgId,
					ComponentId, 
					@ReturnId, 
					@DataId,
					1
				from #default
				where [Id] = @step
			end
			return @ReturnId
		end
		else
		begin -- update Equipment
			if not exists(select 'true' from Equipments where OrgId=@OrgId and [Id]=@Id)
			begin
				return -1
			end
			else
			begin
				update 	[Equipments]
				set 	[OrgId] = @OrgId,
					[ModelId] = @ModelId,
					[intYear] = @intYear,
					[DeptId] = @DeptId,
					[LocId] = @LocId,
					[bitSpare] = @bitSpare,
					[vchFuelCode] = @vchFuelCode,
					[vchEquipId] = @vchEquipId,
					[vchVinSerial] = @vchVinSerial,
					[vchPlateNumber] = @vchPlateNumber,
					[intUpdatedBy] = @intUpdatedBy,
					[dtUpdated] = getdate()
				where 	OrgId = @OrgId 
				and 	[Id] = @Id
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

