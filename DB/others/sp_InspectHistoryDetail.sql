SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create PROCEDURE sp_InspectHistoryDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int output,
		@EquipId int=null output,
		@vchEquipId varchar(50)=null output,
		@dtDate datetime=null output,
		@InspectionId int=null output,
		@WorkOrderId int=null output,
		@vchInspectionName varchar(50)=null output
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
					@dtDate = getdate()
				from WorkOrders WO
				inner join Equipments E 
				on WO.[Id] = @WorkOrderId
				and WO.OrgId = @OrgId
				and WO.EquipId = E.[Id]
				and WO.OrgId = E.OrgId
				left outer join Inspections I
				on I.[Id] = @InspectionId
				and I.OrgId = @OrgId
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
					@dtDate = isnull(EH.dtDate, getdate()),
					@InspectionId = isnull(EH.InspectionId, 0),
					@WorkOrderId = isnull(EH.WorkOrderId, 0)
				from EquipInspectHistory EH
				left join Equipments E 
				on E.[Id] = EH.EquipId
				and E.OrgId = EH.OrgId
				left outer join Inspections I
				on I.[Id] = EH.InspectionId
				and I.OrgId = EH.OrgId
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
				[InspectionId], 
				[WorkOrderId]
				)
			values(
				@OrgId,
				@EquipId,
				@dtDate,
				@InspectionId,
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
				set 	[EquipId]=@EquipId,
					[dtDate]=@dtDate,
					[InspectionId]=@InspectionId,
					[WorkOrderId]=@WorkOrderId
				where 	[OrgId]=@OrgId
				and 	[Id]=@Id

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

