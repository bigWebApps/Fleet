SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


create procedure dbo.sp_InspectSchedDetailDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int,
		@InspectSchedId int,
		@ScheduleName varchar(50)=null output,
		@InspectionId int=null output,
		@TargetDaysOut int=null output,
		@MinimumDaysOut int=null output,
		@MaximumDaysOut int=null output
	)
AS
	set nocount on

	if @Action = 'S'
	begin
		if @Id = 0
		begin
			select 	@ScheduleName = vchName
			from 	InspectSchedules
			where 	[Id] = @InspectSchedId
			and 	OrgId = @OrgId
		end
		else
		begin
			if not exists(select 'true' from InspectSchedDetails where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				select 	@ScheduleName = S.vchName,
					@InspectionId = ISD.InspectionId,
					@TargetDaysOut = ISD.TargetDaysOut,
					@MinimumDaysOut = ISD.MinimumDaysOut,
					@MaximumDaysOut = ISD.MaximumDaysOut
				from 	InspectSchedDetails ISD
				inner join InspectSchedules S
				on 	ISD.[Id] = @Id
				and 	ISD.OrgId = @OrgId
				and 	ISD.InspectSchedId = @InspectSchedId
				and 	ISD.InspectSchedId = S.[Id]
				and 	ISD.OrgId = S.OrgId
			end
		end
	end
	if @Action = 'D'
	begin
		if not exists(select 'true' from InspectSchedDetails where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			if exists(select top 1 'true' 
				from WorkOrderInspections
				where OrgId = @OrgId
				and InspectSchedDetailId = @Id
				)
			begin
				return -2
			end

			delete from InspectSchedDetails
			where [Id] = @Id
			and OrgId = @OrgId
			
			return 0
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
			insert into [InspectSchedDetails](
				[OrgId], 
				[InspectSchedId], 
				[InspectionId], 
				[TargetDaysOut], 
				[MinimumDaysOut], 
				[MaximumDaysOut])
			values(	@OrgId,
				@InspectSchedId, 
				@InspectionId,
				@TargetDaysOut,
				@MinimumDaysOut,
				@MaximumDaysOut
				)
			return 0
		end
		else
		begin -- update
			if not exists(select 'true' from InspectSchedDetails where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				update 	InspectSchedDetails 
				set 	TargetDaysOut = @TargetDaysOut,
					MinimumDaysOut = @MinimumDaysOut,
					MaximumDaysOut = @MaximumDaysOut
				where 	[Id] = @Id
				and 	OrgId = @OrgId

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

