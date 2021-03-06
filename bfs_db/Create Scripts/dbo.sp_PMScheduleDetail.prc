SET QUOTED_IDENTIFIER ON ਍ഀ
GO਍ഀ
SET ANSI_NULLS ON ਍ഀ
GO਍ഀ
਍ഀ
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PMScheduleDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)਍ഀ
drop procedure [dbo].[sp_PMScheduleDetail]਍ഀ
GO਍ഀ
਍ഀ
਍ഀ
create procedure dbo.sp_PMScheduleDetail਍ഀ
	(਍ഀ
		@Action char(1),਍ഀ
		@OrgId int,਍ഀ
		@Id int,਍ഀ
		@vchName varchar(255)=null output਍ഀ
	)਍ഀ
AS਍ഀ
	set nocount on਍ഀ
਍ഀ
	if @Action = 'S'਍ഀ
	begin਍ഀ
		if not exists(select 'true' from PMSchedules where [Id] = @Id and OrgId = @OrgId)਍ഀ
		begin਍ഀ
			return -1਍ഀ
		end਍ഀ
		else਍ഀ
		begin਍ഀ
			select @vchName = vchName਍ഀ
			from PMSchedules਍ഀ
			where [Id] = @Id਍ഀ
			and OrgId = @OrgId਍ഀ
		end਍ഀ
	end਍ഀ
	if @Action = 'D'਍ഀ
	begin਍ഀ
		if not exists(select 'true' from PMSchedules where [Id] = @Id and OrgId = @OrgId)਍ഀ
		begin਍ഀ
			return -1਍ഀ
		end਍ഀ
		else਍ഀ
		begin਍ഀ
			if exists(select top 1 'true'਍ഀ
				from Equipments ਍ഀ
				where OrgId = @OrgId਍ഀ
				and PMScheduleId = @Id਍ഀ
				)਍ഀ
			begin਍ഀ
				return -3਍ഀ
			end਍ഀ
਍ഀ
			if exists(select top 1 'true' ਍ഀ
				from WorkOrderPMItems਍ഀ
				where OrgId = @OrgId਍ഀ
				and PMSchedDetailId in (਍ഀ
					select [Id]਍ഀ
					from PMSchedDetails਍ഀ
					where PMSchedId = @Id਍ഀ
					and OrgId = @OrgId਍ഀ
					)਍ഀ
				)਍ഀ
			begin਍ഀ
				return -2਍ഀ
			end਍ഀ
਍ഀ
			delete from PMSchedules਍ഀ
			where [Id] = @Id਍ഀ
			and OrgId = @OrgId਍ഀ
			਍ഀ
			return 0਍ഀ
		end਍ഀ
	end਍ഀ
	if @Action = 'U'਍ഀ
	begin਍ഀ
		if @Id = 0਍ഀ
		begin -- insert਍ഀ
			insert into PMSchedules([OrgId], [vchName])਍ഀ
			values(@OrgId, isnull(@vchName, ''))਍ഀ
਍ഀ
			return 0਍ഀ
		end਍ഀ
		else਍ഀ
		begin -- update਍ഀ
			if not exists(select 'true' from PMSchedules where [Id] = @Id and OrgId = @OrgId)਍ഀ
			begin਍ഀ
				return -1਍ഀ
			end਍ഀ
			else਍ഀ
			begin਍ഀ
				update 	PMSchedules ਍ഀ
				set 	vchName = isnull(@vchName, '')਍ഀ
				where 	[Id] = @Id਍ഀ
				and OrgId = @OrgId਍ഀ
਍ഀ
				return 0਍ഀ
			end਍ഀ
		end਍ഀ
	end਍ഀ
	return 0਍ഀ
਍ഀ
਍ഀ
਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER OFF ਍ഀ
GO਍ഀ
SET ANSI_NULLS ON ਍ഀ
GO਍ഀ
਍ഀ
