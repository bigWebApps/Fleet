SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GetInfoForWorkOrder]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GetInfoForWorkOrder]
GO

CREATE procedure sp_GetInfoForWorkOrder
	(
		@OrgId int,
		@EquipId int,
		@OrderId int=null,
		@TypeId int=null output,
		@vchEquipId varchar(50)=null output,
		@dtScheduled datetime=null output,
		@vchNote varchar(8000)=null output
	)
as
	set nocount on
	if isnull(@OrderId, 0) <> 0
	begin -- editing mode
		if not exists(select 'true' from WorkOrders where [Id] = @OrderId and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			select 	@vchEquipId = E.vchEquipId,
				@dtScheduled = WO.dtScheduled,
				@TypeId = WO.TypeId,
				@vchNote = isnull(N.vchDesc, '')
			from WorkOrders WO
			inner join Equipments E 
			on WO.[Id] = @OrderId
			and WO.OrgId = @OrgId
			and WO.[EquipId] = E.[Id]
			and WO.OrgId = E.OrgId
			left outer join Notes N
			on N.TypeId = 1 -- Clerk's Note
			and N.ItemId = WO.[Id]
			and N.OrgId = WO.OrgId
		end
	end
	else
	begin -- adding mode
		if not exists(select 'true' 
			from Equipments E 
			where E.[Id] = @EquipId 
			and E.OrgId = @OrgId)
		begin
			return -1
		end 
		else
		begin
			select 	@vchEquipId = E.[vchEquipId], 
				@TypeId = 0,
				@dtScheduled = null,
				@vchNote = ''
			from Equipments E
			where E.[Id] = @EquipId
			and E.OrgId = @OrgId
			
			return 0
		end 
	end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

