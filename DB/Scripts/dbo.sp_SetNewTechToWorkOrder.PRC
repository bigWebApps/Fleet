SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SetNewTechToWorkOrder]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SetNewTechToWorkOrder]
GO



----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 02/21/2006
-- Description: Setting a new technician for work order
---------------------------------------------------------------------------
CREATE procedure dbo.sp_SetNewTechToWorkOrder
(
	@OrgId int,
	@OrderId int,
	@intTechId int=null,
	@dtCurrentDate datetime,
	@UpdatedLoginId int
)
as
	set nocount on
	
	update 	WorkOrders
	set 	intTechId = isnull(@intTechId, 0),
		intUpdatedBy = isnull(@UpdatedLoginId, 0),
		dtUpdated = @dtCurrentDate
	where 	[Id] = @OrderId
	and 	OrgId = @OrgId

	return


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

