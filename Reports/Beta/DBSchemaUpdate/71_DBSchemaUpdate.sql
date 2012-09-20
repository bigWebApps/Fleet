--
-- Script To Create dbo.sp_PMScheduleDetail Procedure In largo.BFS_Beta
-- Generated Friday, June 23, 2006, at 09:21 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Creating dbo.sp_PMScheduleDetail Procedure'
GO

SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, QUOTED_IDENTIFIER, CONCAT_NULL_YIELDS_NULL ON
GO

SET NUMERIC_ROUNDABORT OFF
GO

exec('create procedure dbo.sp_PMScheduleDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int,
		@vchName varchar(255)=null output
	)
AS
	set nocount on

	if @Action = ''S''
	begin
		if not exists(select ''true'' from PMSchedules where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			select @vchName = vchName
			from PMSchedules
			where [Id] = @Id
			and OrgId = @OrgId
		end
	end
	if @Action = ''D''
	begin
		if not exists(select ''true'' from PMSchedules where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			if exists(select top 1 ''true''
				from Equipments 
				where OrgId = @OrgId
				and PMScheduleId = @Id
				)
			begin
				return -3
			end

			if exists(select top 1 ''true'' 
				from WorkOrderPMItems
				where OrgId = @OrgId
				and PMSchedDetailId in (
					select [Id]
					from PMSchedDetails
					where PMSchedId = @Id
					and OrgId = @OrgId
					)
				)
			begin
				return -2
			end

			delete from PMSchedules
			where [Id] = @Id
			and OrgId = @OrgId
			
			return 0
		end
	end
	if @Action = ''U''
	begin
		if @Id = 0
		begin -- insert
			insert into PMSchedules([OrgId], [vchName])
			values(@OrgId, isnull(@vchName, ''''))

			return 0
		end
		else
		begin -- update
			if not exists(select ''true'' from PMSchedules where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				update 	PMSchedules 
				set 	vchName = isnull(@vchName, '''')
				where 	[Id] = @Id
				and OrgId = @OrgId

				return 0
			end
		end
	end
	return 0')
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_PMScheduleDetail Procedure Added Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Add dbo.sp_PMScheduleDetail Procedure'
END
GO

--
-- Script To Create dbo.sp_PMServiceDetail Procedure In largo.BFS_Beta
-- Generated Friday, June 23, 2006, at 09:21 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Creating dbo.sp_PMServiceDetail Procedure'
GO

SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, QUOTED_IDENTIFIER, CONCAT_NULL_YIELDS_NULL ON
GO

SET NUMERIC_ROUNDABORT OFF
GO

exec('CREATE  procedure dbo.sp_PMServiceDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int,
		@RepairCatId int=null output,
		@vchDesc varchar(100)=null output
	)
AS
	set nocount on

	if @Action = ''S''
	begin
		if not exists(select ''true'' from PMServices where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			select 	@RepairCatId = RepairCatId,
				@vchDesc = vchDesc
			from 	PMServices
			where 	[Id] = @Id
			and 	OrgId = @OrgId
		end
	end
	if @Action = ''D''
	begin
		if not exists(select ''true'' from PMServices where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			if exists(select ''true'' 
				from PMSchedDetails
				where PMServiceId = @Id
				and OrgId = @OrgId
				)
			begin
				return -2
			end

			delete from PMServices
			where [Id] = @Id
			and OrgId = @OrgId
			
			return 0
		end
	end
	if @Action = ''U''
	begin
		if @Id = 0
		begin -- insert
			insert into PMServices([OrgId], [RepairCatId], [vchDesc], [btRequiresRepair])
			values(@OrgId, @RepairCatId, isnull(@vchDesc, ''''), 0)

			return 0
		end
		else
		begin -- update
			if not exists(select ''true'' from PMServices where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				update 	PMServices 
				set 	RepairCatId = @RepairCatId,
					vchDesc = isnull(@vchDesc, '''')
				where 	[Id] = @Id
				and OrgId = @OrgId

				return 0
			end
		end
	end
	return 0')
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_PMServiceDetail Procedure Added Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Add dbo.sp_PMServiceDetail Procedure'
END
GO

--
-- Script To Create dbo.sp_SelectPMServicesList Procedure In largo.BFS_Beta
-- Generated Friday, June 23, 2006, at 09:21 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Creating dbo.sp_SelectPMServicesList Procedure'
GO

SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, QUOTED_IDENTIFIER, CONCAT_NULL_YIELDS_NULL ON
GO

SET NUMERIC_ROUNDABORT OFF
GO

exec('CREATE  procedure dbo.sp_SelectPMServicesList
	(
		@OrgId int
	)
AS
	set nocount on

	select 	PM.[Id], 
		PM.RepairCatId, 
		RC.vchName as CatName, 
		PM.vchDesc as ServiceName
	from PMServices PM
	inner join RepairCats RC
	on PM.OrgId = @OrgId
	and PM.RepairCatId = RC.[Id]
	and PM.OrgId = RC.OrgId
	order by RC.[Id] asc, PM.vchDesc asc')
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectPMServicesList Procedure Added Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Add dbo.sp_SelectPMServicesList Procedure'
END
GO

--
-- Script To Create dbo.sp_SelectRepairCatsList Procedure In largo.BFS_Beta
-- Generated Friday, June 23, 2006, at 09:21 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Creating dbo.sp_SelectRepairCatsList Procedure'
GO

SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, QUOTED_IDENTIFIER, CONCAT_NULL_YIELDS_NULL ON
GO

SET NUMERIC_ROUNDABORT OFF
GO

exec('create procedure dbo.sp_SelectRepairCatsList
	(
		@OrgId int
	)
AS
	set nocount on

	select 	[Id],
		vchName,
		isnull(vchDesc, '''')
	from RepairCats
	where OrgId = @OrgId')
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectRepairCatsList Procedure Added Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Add dbo.sp_SelectRepairCatsList Procedure'
END
GO