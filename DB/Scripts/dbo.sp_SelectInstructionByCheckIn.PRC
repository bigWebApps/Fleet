SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectInstructionByCheckIn]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectInstructionByCheckIn]
GO


CREATE  procedure sp_SelectInstructionByCheckIn
(
		@OrgId int,
		@OrderId int,
		@btPrint bit=null output
)
AS
	set nocount on
	select OI.vchNote 
	from OperatorInstructions OI
	where OI.OrgId = @OrgId
	and OI.TypeId in (
		select 3 as TypeId
		union all
		select case when isnull(WO.bitStaying, 0) > 0 then 4 else 0 end as TypeId
		from WorkOrders WO
		where WO.[Id] = @OrderId
		and WO.OrgId = @OrgId
		union all
		select case when isnull(WO.SpareEquipId, 0) > 0 then 5 else 0 end as TypeId
		from WorkOrders WO
		where WO.[Id] = @OrderId
		and WO.OrgId = @OrgId
		)
	order by OI.TypeId asc, OI.[Id] asc

	select @btPrint	= btPrint
	from Orgs
	where [Id] = @OrgId


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

