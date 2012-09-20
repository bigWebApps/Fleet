SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GetSpareEquip]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GetSpareEquip]
GO

create procedure sp_GetSpareEquip
	(
		@OrgId int,
		@OrderId int,
		@SpareEquipId int=null output,
		@vchSpareEquipId varchar(50)=null output,
		@vchSpareEquipType varchar(50)=null output
	)
as
	set nocount on
	if not exists(select 'true' from WorkOrders where [Id] = @OrderId and OrgId = @OrgId)
	begin
		return -1
	end
	else
	begin
		if exists(select 'true' from WorkOrders where [Id] = @OrderId and OrgId = @OrgId and isnull(SpareEquipId, 0) = 0)
		begin
			return 1
		end
		else
		begin
			select 	@SpareEquipId = WO.SpareEquipId,
				@vchSpareEquipId = E.vchEquipId,
				@vchSpareEquipType = ET.vchName
			from 	WorkOrders WO
			inner join Equipments E
			on 	WO.[Id] = @OrderId
			and 	WO.OrgId = @OrgId
			and 	E.[Id] = WO.SpareEquipId
			and 	E.OrgId = WO.OrgId
			inner join EquipTypes ET
			on 	E.TypeId = ET.[Id]
			and 	E.OrgId = ET.OrgId
			return 0
		end
	end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

