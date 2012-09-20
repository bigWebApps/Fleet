SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectEquipListForSpare2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectEquipListForSpare2]
GO


CREATE procedure sp_SelectEquipListForSpare2
(
		@OrgId int,
		@OrderId int
)
as
	set nocount on
	
	select 0 as [Id], 'none' as vchEquipId
	union all
	select [Id], vchEquipId
	from Equipments
	where isnull(bitSpare, 0) = 1
	and OrgId = @OrgId
	and isnull(TempOperatorId, 0) = 0
	and [Id] not in (
		select EquipId
		from WorkOrders
		where OrgId = @OrgId
		and [Id] = @OrderId
		union all
		select E.[Id]
		from Equipments E 
		inner join WorkOrders WO
		on WO.OrgId = @OrgId
		and WO.[id] = @OrderId
		and E.[Id] = WO.SpareEquipId
		and E.OrgId = WO.OrgId 
		)
	union all
	select E.[Id], E.vchEquipId
	from Equipments E
	inner join WorkOrders WO
	on WO.[Id] = @OrderId
	and WO.OrgId = @OrgId
	and E.[Id] = isnull(WO.SpareEquipId, 0)
	and E.OrgId = WO.OrgId
	return 


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

