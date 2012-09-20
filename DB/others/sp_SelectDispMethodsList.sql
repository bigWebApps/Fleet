SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_SelectDispMethodsList
	(
		@OrgId int
	)
AS
	set nocount on

	select [Id], vchName 
	from EquipDisposalMethods
	where OrgId = @OrgId
	and btActive = 1

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

