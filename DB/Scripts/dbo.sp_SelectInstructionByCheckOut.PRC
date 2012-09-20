SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectInstructionByCheckOut]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectInstructionByCheckOut]
GO

create procedure sp_SelectInstructionByCheckOut
(
		@OrgId int,
		@OrderId int
)
AS
	set nocount on
	select OI.vchNote 
	from OperatorInstructions OI
	where OI.OrgId = @OrgId
	and OI.TypeId in (
		select 1 as TypeId
		union all
		select case when isnull(WO.SpareEquipId, 0) > 0 then 8 else 0 end as TypeId
		from WorkOrders WO
		where WO.[Id] = @OrderId
		and WO.OrgId = @OrgId
		)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

