SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectInstructionByReOpen]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectInstructionByReOpen]
GO


create procedure dbo.sp_SelectInstructionByReOpen
		@OrgId int
as
	set nocount on

	select OI.vchNote 
	from OperatorInstructions OI, OperatorInstructionTypes OIT
	where OI.OrgId = @OrgId
	and OI.TypeId = OIT.[Id]
	and OIT.vchName = 'ReOpen/Global'


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

