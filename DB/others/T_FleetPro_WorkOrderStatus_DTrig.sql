SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create trigger T_FleetPro_WorkOrderStatus_DTrig on [WorkOrderStatus] for delete as
	set nocount on
	raiserror 44445 'You cannot delete this system data. It is protected data.'
        rollback transaction


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

