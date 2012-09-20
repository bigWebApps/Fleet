--
-- Script To Create dbo.sp_PMSchedDetailsDetail Procedure In largo.BFS_Beta
-- Generated Wednesday, June 28, 2006, at 11:09 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Creating dbo.sp_PMSchedDetailsDetail Procedure'
GO

SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, QUOTED_IDENTIFIER, CONCAT_NULL_YIELDS_NULL ON
GO

SET NUMERIC_ROUNDABORT OFF
GO

exec('create procedure dbo.sp_PMSchedDetailsDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int,
		@PMSchedId int=null output,
		@PMServiceId int=null output,
		@UnitMeasureId int=null output,
		@intDays int=null output,
		@dmUnits decimal(19, 8)=null output
	)
AS
	set nocount on

	if @Action = ''S''
	begin
		if not exists(select ''true'' from PMSchedDetails where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			select 	@PMSchedId = PMSchedId,
				@PMServiceId = PMServiceId,
				@UnitMeasureId = UnitMeasureId,
				@intDays = intDays,
				@dmUnits = dmUnits
			from PMSchedDetails
			where [Id] = @Id
			and OrgId = @OrgId

			return 0
		end
	end
	if @Action = ''D''
	begin
		if not exists(select ''true'' from PMSchedDetails where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			if exists(select top 1 ''true'' 
				from WorkOrderPMItems
				where OrgId = @OrgId
				and PMSchedDetailId = @Id)
			begin
				return -2
			end

			delete from PMSchedDetails
			where [Id] = @Id
			and OrgId = @OrgId
			
			return 0
		end
	end
	if @Action = ''U''
	begin
		if @Id = 0
		begin -- insert

			insert into [PMSchedDetails]([OrgId], [PMSchedId], [PMServiceId], [UnitMeasureId], [intDays], [dmUnits])
			values(@OrgId, @PMSchedId, @PMServiceId, @UnitMeasureId, @intDays, @dmUnits)

			return 0
		end
		else
		begin -- update
			if not exists(select ''true'' from PMSchedDetails where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				update 	PMSchedDetails
				set 	PMSchedId = @PMSchedId,
					PMServiceId = @PMServiceId,
					UnitMeasureId = @UnitMeasureId,
					intDays = @intDays,
					dmUnits = @dmUnits
				where 	[Id] = @Id
				and 	OrgId = @OrgId

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
   PRINT 'dbo.sp_PMSchedDetailsDetail Procedure Added Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Add dbo.sp_PMSchedDetailsDetail Procedure'
END
GO

--
-- Script To Create dbo.sp_SelectMeasuresList Procedure In largo.BFS_Beta
-- Generated Wednesday, June 28, 2006, at 11:09 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Creating dbo.sp_SelectMeasuresList Procedure'
GO

SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, QUOTED_IDENTIFIER, CONCAT_NULL_YIELDS_NULL ON
GO

SET NUMERIC_ROUNDABORT OFF
GO

exec('create procedure dbo.sp_SelectMeasuresList
as
	set nocount on
	select * 
	from UnitMeasures')
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectMeasuresList Procedure Added Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Add dbo.sp_SelectMeasuresList Procedure'
END
GO

--
-- Script To Create dbo.sp_SelectPMServicesListForSchedule Procedure In largo.BFS_Beta
-- Generated Wednesday, June 28, 2006, at 11:09 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Creating dbo.sp_SelectPMServicesListForSchedule Procedure'
GO

SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, QUOTED_IDENTIFIER, CONCAT_NULL_YIELDS_NULL ON
GO

SET NUMERIC_ROUNDABORT OFF
GO

exec('----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Last Modification Date: 06/28/2006
-- Description: Procedure is showing the preventive services for schedule 
---------------------------------------------------------------------------
CREATE procedure dbo.sp_SelectPMServicesListForSchedule
	(
		@OrgId int,
		@PMSchedId int
	)
as
	set nocount on

	select 	SD.[Id],
		SD.PMSchedId,
		S.vchDesc as ServiceName,
		UM.vchName as UnitMeasureName,
		SD.intDays as Days,
		convert(float, SD.dmUnits) as Units
	from PMSchedDetails SD
	inner join PMServices S
	on SD.PMSchedId = @PMSchedId
	and SD.OrgId = @OrgId
	and SD.PMServiceId = S.[Id]
	and SD.OrgID = S.OrgId
	inner join UnitMeasures UM
	on UM.[Id] = SD.UnitMeasureId')
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectPMServicesListForSchedule Procedure Added Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Add dbo.sp_SelectPMServicesListForSchedule Procedure'
END
GO