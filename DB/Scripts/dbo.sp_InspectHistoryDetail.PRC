SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_InspectHistoryDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_InspectHistoryDetail]
GO




----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 09/06/2005 
-- Description: Procedure select/add/edit the history of the Inspection 
---------------------------------------------------------------------------
CREATE   PROCEDURE sp_InspectHistoryDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int output,
		@EquipId int=null output,
		@vchEquipId varchar(50)=null output,
		@dtDate datetime=null output,
		@InspectSchedDetailId int=null output,
		@WorkOrderId int=null output,
		@vchInspectionName varchar(50)=null output,
		@vchInspectScheduleName varchar(50)=null output
	)
AS
	set nocount on
	
	if @Action = 'S'
	begin
		if isnull(@Id, 0) = 0
		begin
			if not exists(select 'true' from WorkOrders where [Id] = @WorkOrderId and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				select 	@EquipId = isnull(E.[Id], 0),
					@vchEquipId = isnull(E.vchEquipId, ''),
					@vchInspectionName = isnull(I.vchName, ''),
					@vchInspectScheduleName = isnull([IS].vchName, ''),
					@dtDate = getdate()
				from WorkOrders WO
				inner join Equipments E 
				on WO.[Id] = @WorkOrderId
				and WO.OrgId = @OrgId
				and WO.EquipId = E.[Id]
				and WO.OrgId = E.OrgId
				left outer join InspectSchedules [IS]
				on [IS].[Id] = E.InspectScheduleId
				and [IS].OrgId = E.OrgId
				left outer join InspectSchedDetails ISD
				on ISD.InspectSchedId = [IS].[Id]
				and ISD.[Id] = @InspectSchedDetailId
				and ISD.OrgId = WO.OrgId
				left outer join Inspections I
				on I.[Id] = ISD.InspectionId
				and I.OrgId = ISD.OrgId
			end
		end 
		else
		begin
			if not exists(select 'true' from EquipInspectHistory where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				select 	@EquipId = isnull(EH.EquipId, 0),
					@vchEquipId = isnull(E.vchEquipId, ''),
					@vchInspectionName = isnull(I.vchName, ''),
					@vchInspectScheduleName = isnull([IS].vchName, ''),
					@dtDate = isnull(EH.dtDate, getdate()),
					@InspectSchedDetailId = isnull(EH.InspectSchedDetailId, 0),
					@WorkOrderId = isnull(EH.WorkOrderId, 0)
				from EquipInspectHistory EH
				left join Equipments E 
				on E.[Id] = EH.EquipId
				and E.OrgId = EH.OrgId
				left join InspectSchedDetails ISD
				on ISD.[Id] = EH.InspectSchedDetailId
				and ISD.OrgId = EH.OrgId
				left outer join InspectSchedules [IS]
				on [IS].[Id] = ISD.InspectSchedId
				and [IS].OrgId = ISD.OrgId
				left outer join Inspections I
				on I.[Id] = ISD.InspectionId
				and I.OrgId = ISD.OrgId
				where EH.[Id] = @Id
				and EH.OrgId = @OrgId
			end
		end
		
		return 0
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
			insert into [EquipInspectHistory](
				[OrgId], 
				[EquipId], 
				[dtDate], 
				[InspectSchedDetailId], 
				[WorkOrderId]
				)
			values(
				@OrgId,
				@EquipId,
				@dtDate,
				@InspectSchedDetailId,
				@WorkOrderId
				)
			select @Id = scope_identity()
			return 0
		end
		else
		begin -- update
			if not exists(select 'true' from EquipInspectHistory where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				update 	EquipInspectHistory
				set 	[EquipId] = @EquipId,
					[dtDate] = @dtDate,
					[InspectSchedDetailId] = @InspectSchedDetailId,
					[WorkOrderId] = @WorkOrderId
				where 	[OrgId] = @OrgId
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

