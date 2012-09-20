SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create procedure dbo.sp_InspectScheduleDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int,
		@vchName varchar(50)=null output
	)
AS
	set nocount on

	if @Action = 'S'
	begin
		if not exists(select 'true' from InspectSchedules where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			select @vchName = vchName
			from InspectSchedules
			where [Id] = @Id
			and OrgId = @OrgId
		end
	end
	if @Action = 'D'
	begin
		if not exists(select 'true' from InspectSchedules where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			if exists(select top 1 'true'
				from Equipments 
				where OrgId = @OrgId
				and InspectScheduleId = @Id
				)
			begin
				return -3
			end

			if exists(select top 1 'true' 
				from WorkOrderInspections
				where OrgId = @OrgId
				and InspectSchedDetailId in (
					select [Id]
					from InspectSchedDetails
					where InspectSchedId = @Id
					and OrgId = @OrgId
					)
				)
			begin
				return -2
			end

			delete from InspectSchedules
			where [Id] = @Id
			and OrgId = @OrgId
			
			return 0
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
			insert into InspectSchedules([OrgId], [vchName])
			values(@OrgId, isnull(@vchName, ''))

			return 0
		end
		else
		begin -- update
			if not exists(select 'true' from InspectSchedules where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				update 	InspectSchedules 
				set 	vchName = isnull(@vchName, '')
				where 	[Id] = @Id
				and OrgId = @OrgId

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

