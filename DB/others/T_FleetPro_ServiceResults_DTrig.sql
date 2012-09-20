SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


create trigger T_FleetPro_ServiceResults_DTrig on [ServiceResults] for delete as
	set nocount on
	raiserror 44445 'You cannot delete this system data. It is protected data.'
        rollback transaction


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

