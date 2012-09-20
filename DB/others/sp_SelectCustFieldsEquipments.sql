SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sp_SelectCustFieldsEquipments
	(
		@OrgId int,
		@ErrorCode int OUTPUT 
	)
AS
	SET NOCOUNT ON

	select * 
	from CustFieldDef
	where btIsComponent = 0
	and OrgId = @OrgId
	
	select @ErrorCode=@@ERROR
	
	RETURN 

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

