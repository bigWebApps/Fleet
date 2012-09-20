SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

create view dbo.v_TempOperatorsAssignment
as

	select 	E.[Id] as [Id],
		E.OrgId as OrgId,
		(select top 1 dtUpdated from EquipAssignLogs where IsTemp = 1 and EquipId = E.[Id] and AssignedTo = E.TempOperatorId and OrgId = E.OrgId order by dtUpdated desc) as dtUpdated,
		isnull((select top 1 vchNote from EquipAssignLogs where IsTemp = 1 and EquipId = E.[Id] and AssignedTo = E.TempOperatorId and OrgId = E.OrgId order by dtUpdated desc), '&#60No Assignment History&#62') as vchNote,
		(select top 1 AssignedTo from EquipAssignLogs where IsTemp = 1 and EquipId = E.[Id] and AssignedTo = E.TempOperatorId and OrgId = E.OrgId order by dtUpdated desc) as AssignedTo,
		(select top 1 AssignedBy from EquipAssignLogs where IsTemp = 1 and EquipId = E.[Id] and AssignedTo = E.TempOperatorId and OrgId = E.OrgId order by dtUpdated desc) as AssignedBy
	from Equipments E 
	where isnull(E.TempOperatorId, 0) <> 0


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

