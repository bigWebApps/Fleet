SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[T_FleetPro_WorkOrderOperatorStatus_DTrig]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[T_FleetPro_WorkOrderOperatorStatus_DTrig]
GO

create trigger T_FleetPro_WorkOrderOperatorStatus_DTrig on dbo.WorkOrderOperatorStatus for delete as
	set nocount on
	raiserror 44445 'You cannot delete this system data. It is protected data.'
        rollback transaction

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

