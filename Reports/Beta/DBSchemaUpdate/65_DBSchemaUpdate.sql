--
-- Script To Update dbo.sp_GetTechnicianInfo Procedure In largo.BFS_Beta
-- Generated Thursday, June 15, 2006, at 11:36 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Updating dbo.sp_GetTechnicianInfo Procedure'
GO

SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, QUOTED_IDENTIFIER, CONCAT_NULL_YIELDS_NULL ON
GO

SET NUMERIC_ROUNDABORT OFF
GO


IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
exec('ALTER procedure dbo.sp_GetTechnicianInfo
(
	@OrgId int,
	@OrderId int,
	@TechId int=null output,
	@dmHourlyRate decimal(18, 9)=null output
)
as
	set nocount on


	if isnull(@TechId, 0) = 0
	begin
		if exists(select ''true'' from WorkOrders where [Id] = @OrderId and OrgId = @OrgId and isnull(intTechId, 0) <> 0)
		begin
			select 	@TechId = L.[Id],
				@dmHourlyRate = isnull(L.dmHourlyRate, 0.0)
			from Logins L
			inner join WorkOrders WO
			on WO.[Id] = @OrderId
			and WO.OrgId = @OrgId
			and WO.intTechId = L.[Id]
	
			return 1
		end
		else
		begin
			return -1
		end
	end
	else
	begin
		if exists(select ''true'' from Logins where [Id] = @TechId)
		begin
			select @dmHourlyRate = dmHourlyRate
			from Logins
			where [Id] = @TechId

			return 1
		end
		else
		begin
			return -1
		end
	end')
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_GetTechnicianInfo Procedure Updated Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Update dbo.sp_GetTechnicianInfo Procedure'
END
GO