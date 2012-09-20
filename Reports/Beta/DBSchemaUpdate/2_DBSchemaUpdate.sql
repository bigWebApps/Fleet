--
-- Script To Delete dbo.T_FleetPro_DataTypes_DTrig Trigger In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.T_FleetPro_DataTypes_DTrig Trigger'
GO

DROP TRIGGER [dbo].[T_FleetPro_DataTypes_DTrig]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.T_FleetPro_DataTypes_DTrig Trigger Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.T_FleetPro_DataTypes_DTrig Trigger'
END
GO--
-- Script To Delete dbo.T_FleetPro_DocumentTypes_DTrig Trigger In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.T_FleetPro_DocumentTypes_DTrig Trigger'
GO

DROP TRIGGER [dbo].[T_FleetPro_DocumentTypes_DTrig]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.T_FleetPro_DocumentTypes_DTrig Trigger Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.T_FleetPro_DocumentTypes_DTrig Trigger'
END
GO

--
-- Script To Delete dbo.T_FleetPro_FieldTypes_DTrig Trigger In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.T_FleetPro_FieldTypes_DTrig Trigger'
GO

DROP TRIGGER [dbo].[T_FleetPro_FieldTypes_DTrig]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.T_FleetPro_FieldTypes_DTrig Trigger Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.T_FleetPro_FieldTypes_DTrig Trigger'
END
GO

--
-- Script To Delete dbo.T_FleetPro_NoteTypes_DTrig Trigger In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.T_FleetPro_NoteTypes_DTrig Trigger'
GO

DROP TRIGGER [dbo].[T_FleetPro_NoteTypes_DTrig]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.T_FleetPro_NoteTypes_DTrig Trigger Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.T_FleetPro_NoteTypes_DTrig Trigger'
END
GO

--
-- Script To Delete dbo.T_FleetPro_Orgs_DTrig Trigger In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.T_FleetPro_Orgs_DTrig Trigger'
GO

DROP TRIGGER [dbo].[T_FleetPro_Orgs_DTrig]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.T_FleetPro_Orgs_DTrig Trigger Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.T_FleetPro_Orgs_DTrig Trigger'
END
GO

--
-- Script To Delete dbo.T_FleetPro_ReOpenCategories_DTrig Trigger In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.T_FleetPro_ReOpenCategories_DTrig Trigger'
GO

DROP TRIGGER [dbo].[T_FleetPro_ReOpenCategories_DTrig]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.T_FleetPro_ReOpenCategories_DTrig Trigger Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.T_FleetPro_ReOpenCategories_DTrig Trigger'
END
GO

--
-- Script To Delete dbo.T_FleetPro_ServiceChecks_DTrig Trigger In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.T_FleetPro_ServiceChecks_DTrig Trigger'
GO

DROP TRIGGER [dbo].[T_FleetPro_ServiceChecks_DTrig]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.T_FleetPro_ServiceChecks_DTrig Trigger Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.T_FleetPro_ServiceChecks_DTrig Trigger'
END
GO

--
-- Script To Delete dbo.T_FleetPro_ServiceResults_DTrig Trigger In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.T_FleetPro_ServiceResults_DTrig Trigger'
GO

DROP TRIGGER [dbo].[T_FleetPro_ServiceResults_DTrig]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.T_FleetPro_ServiceResults_DTrig Trigger Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.T_FleetPro_ServiceResults_DTrig Trigger'
END
GO

--
-- Script To Delete dbo.T_FleetPro_Measures_DTrig Trigger In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.T_FleetPro_Measures_DTrig Trigger'
GO

DROP TRIGGER [dbo].[T_FleetPro_Measures_DTrig]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.T_FleetPro_Measures_DTrig Trigger Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.T_FleetPro_Measures_DTrig Trigger'
END
GO

--
-- Script To Delete dbo.T_FleetPro_UserTypes_DTrig Trigger In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.T_FleetPro_UserTypes_DTrig Trigger'
GO

DROP TRIGGER [dbo].[T_FleetPro_UserTypes_DTrig]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.T_FleetPro_UserTypes_DTrig Trigger Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.T_FleetPro_UserTypes_DTrig Trigger'
END
GO

--
-- Script To Delete dbo.T_FleetPro_WorkOrderOperatorStatus_DTrig Trigger In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.T_FleetPro_WorkOrderOperatorStatus_DTrig Trigger'
GO

DROP TRIGGER [dbo].[T_FleetPro_WorkOrderOperatorStatus_DTrig]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.T_FleetPro_WorkOrderOperatorStatus_DTrig Trigger Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.T_FleetPro_WorkOrderOperatorStatus_DTrig Trigger'
END
GO

--
-- Script To Delete dbo.T_FleetPro_WorkOrderStatus_DTrig Trigger In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.T_FleetPro_WorkOrderStatus_DTrig Trigger'
GO

DROP TRIGGER [dbo].[T_FleetPro_WorkOrderStatus_DTrig]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.T_FleetPro_WorkOrderStatus_DTrig Trigger Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.T_FleetPro_WorkOrderStatus_DTrig Trigger'
END
GO

--
-- Script To Delete dbo.T_FleetPro_WorkOrderTypes_DTrig Trigger In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.T_FleetPro_WorkOrderTypes_DTrig Trigger'
GO

DROP TRIGGER [dbo].[T_FleetPro_WorkOrderTypes_DTrig]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.T_FleetPro_WorkOrderTypes_DTrig Trigger Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.T_FleetPro_WorkOrderTypes_DTrig Trigger'
END
GO

--
-- Script To Delete dbo.CustFieldDef Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.CustFieldDef Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[CustFieldDef]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.CustFieldDef Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.CustFieldDef Table'
END
GO

--
-- Script To Delete dbo.Notes Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.Notes Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[Notes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.Notes Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.Notes Table'
END
GO

--
-- Script To Delete dbo.NoteTypes Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.NoteTypes Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Notes_NoteTypes')
      ALTER TABLE [dbo].[Notes] DROP CONSTRAINT [FK_Notes_NoteTypes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[NoteTypes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.NoteTypes Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.NoteTypes Table'
END
GO

--
-- Script To Delete dbo.DataTypes Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.DataTypes Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_CustFieldDef_DataTypes')
      ALTER TABLE [dbo].[CustFieldDef] DROP CONSTRAINT [FK_CustFieldDef_DataTypes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_NoteTypes_DataTypes')
      ALTER TABLE [dbo].[NoteTypes] DROP CONSTRAINT [FK_NoteTypes_DataTypes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[DataTypes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.DataTypes Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.DataTypes Table'
END
GO

--
-- Script To Delete dbo.EquipInspectHistory Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.EquipInspectHistory Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[EquipInspectHistory]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.EquipInspectHistory Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.EquipInspectHistory Table'
END
GO

--
-- Script To Delete dbo.EquipPMHistory Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.EquipPMHistory Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[EquipPMHistory]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.EquipPMHistory Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.EquipPMHistory Table'
END
GO

--
-- Script To Delete dbo.EquipUnitLogs Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.EquipUnitLogs Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[EquipUnitLogs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.EquipUnitLogs Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.EquipUnitLogs Table'
END
GO

--
-- Script To Delete dbo.WorkOrderReportedIssues Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.WorkOrderReportedIssues Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[WorkOrderReportedIssues]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.WorkOrderReportedIssues Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.WorkOrderReportedIssues Table'
END
GO

--
-- Script To Delete dbo.ReOpenLogs Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.ReOpenLogs Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[ReOpenLogs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.ReOpenLogs Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.ReOpenLogs Table'
END
GO

--
-- Script To Delete dbo.PartsUsed Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.PartsUsed Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[PartsUsed]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.PartsUsed Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.PartsUsed Table'
END
GO

--
-- Script To Delete dbo.RepairMult Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.RepairMult Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[RepairMult]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.RepairMult Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.RepairMult Table'
END
GO

--
-- Script To Delete dbo.Repairs Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.Repairs Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_PartsUsed_Repairs')
      ALTER TABLE [dbo].[PartsUsed] DROP CONSTRAINT [FK_PartsUsed_Repairs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_RepairMult_Repairs')
      ALTER TABLE [dbo].[RepairMult] DROP CONSTRAINT [FK_RepairMult_Repairs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[Repairs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.Repairs Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.Repairs Table'
END
GO

--
-- Script To Delete dbo.WorkOrderInspectItems Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.WorkOrderInspectItems Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[WorkOrderInspectItems]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.WorkOrderInspectItems Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.WorkOrderInspectItems Table'
END
GO

--
-- Script To Delete dbo.WorkOrderInspections Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.WorkOrderInspections Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_WorkOrderInspectItems_WorkOrderInspections')
      ALTER TABLE [dbo].[WorkOrderInspectItems] DROP CONSTRAINT [FK_WorkOrderInspectItems_WorkOrderInspections]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[WorkOrderInspections]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.WorkOrderInspections Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.WorkOrderInspections Table'
END
GO

--
-- Script To Delete dbo.WorkOrderPMItems Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.WorkOrderPMItems Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[WorkOrderPMItems]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.WorkOrderPMItems Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.WorkOrderPMItems Table'
END
GO

--
-- Script To Delete dbo.WorkOrders Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.WorkOrders Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_ReOpenLogs_WorkOrders')
      ALTER TABLE [dbo].[ReOpenLogs] DROP CONSTRAINT [FK_ReOpenLogs_WorkOrders]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Repairs_WorkOrders')
      ALTER TABLE [dbo].[Repairs] DROP CONSTRAINT [FK_Repairs_WorkOrders]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_WorkOrderInspections_WorkOrders')
      ALTER TABLE [dbo].[WorkOrderInspections] DROP CONSTRAINT [FK_WorkOrderInspections_WorkOrders]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_WorkOrderPMItems_WorkOrders')
      ALTER TABLE [dbo].[WorkOrderPMItems] DROP CONSTRAINT [FK_WorkOrderPMItems_WorkOrders]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_WorkOrderReportedIssues_WorkOrders')
      ALTER TABLE [dbo].[WorkOrderReportedIssues] DROP CONSTRAINT [FK_WorkOrderReportedIssues_WorkOrders]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_WorkOrderReportedIssues_WorkOrders1')
      ALTER TABLE [dbo].[WorkOrderReportedIssues] DROP CONSTRAINT [FK_WorkOrderReportedIssues_WorkOrders1]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[WorkOrders]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.WorkOrders Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.WorkOrders Table'
END
GO

--
-- Script To Delete dbo.Equipments Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.Equipments Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_EquipInspectHistory_Equipments')
      ALTER TABLE [dbo].[EquipInspectHistory] DROP CONSTRAINT [FK_EquipInspectHistory_Equipments]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_EquipPMHistory_Equipments')
      ALTER TABLE [dbo].[EquipPMHistory] DROP CONSTRAINT [FK_EquipPMHistory_Equipments]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_EquipUnitLogs_Equipments')
      ALTER TABLE [dbo].[EquipUnitLogs] DROP CONSTRAINT [FK_EquipUnitLogs_Equipments]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_WorkOrderReportedIssues_Equipments')
      ALTER TABLE [dbo].[WorkOrderReportedIssues] DROP CONSTRAINT [FK_WorkOrderReportedIssues_Equipments]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_WorkOrders_Equipments')
      ALTER TABLE [dbo].[WorkOrders] DROP CONSTRAINT [FK_WorkOrders_Equipments]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[Equipments]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.Equipments Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.Equipments Table'
END
GO

--
-- Script To Delete dbo.Departments Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.Departments Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Equipments_Departments')
      ALTER TABLE [dbo].[Equipments] DROP CONSTRAINT [FK_Equipments_Departments]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[Departments]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.Departments Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.Departments Table'
END
GO

--
-- Script To Delete dbo.SignedDocuments Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.SignedDocuments Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[SignedDocuments]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.SignedDocuments Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.SignedDocuments Table'
END
GO

--
-- Script To Delete dbo.DocumentTypes Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.DocumentTypes Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_SignedDocuments_DocumentTypes')
      ALTER TABLE [dbo].[SignedDocuments] DROP CONSTRAINT [FK_SignedDocuments_DocumentTypes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[DocumentTypes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.DocumentTypes Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.DocumentTypes Table'
END
GO

--
-- Script To Delete dbo.EquipAssignLogs Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.EquipAssignLogs Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[EquipAssignLogs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.EquipAssignLogs Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.EquipAssignLogs Table'
END
GO

--
-- Script To Delete dbo.EquipComponentDefault Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.EquipComponentDefault Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[EquipComponentDefault]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.EquipComponentDefault Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.EquipComponentDefault Table'
END
GO

--
-- Script To Delete dbo.EquipComponents Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.EquipComponents Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[EquipComponents]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.EquipComponents Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.EquipComponents Table'
END
GO

--
-- Script To Delete dbo.EquipComponentTypes Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.EquipComponentTypes Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_EquipComponentDefault_EquipComponentTypes1')
      ALTER TABLE [dbo].[EquipComponentDefault] DROP CONSTRAINT [FK_EquipComponentDefault_EquipComponentTypes1]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_EquipComponents_EquipComponentTypes')
      ALTER TABLE [dbo].[EquipComponents] DROP CONSTRAINT [FK_EquipComponents_EquipComponentTypes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[EquipComponentTypes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.EquipComponentTypes Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.EquipComponentTypes Table'
END
GO

--
-- Script To Delete dbo.EquipData Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.EquipData Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_EquipComponents_EquipData')
      ALTER TABLE [dbo].[EquipComponents] DROP CONSTRAINT [FK_EquipComponents_EquipData]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Equipments_EquipData')
      ALTER TABLE [dbo].[Equipments] DROP CONSTRAINT [FK_Equipments_EquipData]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_WorkOrders_EquipData')
      ALTER TABLE [dbo].[WorkOrders] DROP CONSTRAINT [FK_WorkOrders_EquipData]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[EquipData]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.EquipData Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.EquipData Table'
END
GO

--
-- Script To Delete dbo.EquipDisposalMethods Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.EquipDisposalMethods Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Equipments_EquipDisposalMethods')
      ALTER TABLE [dbo].[Equipments] DROP CONSTRAINT [FK_Equipments_EquipDisposalMethods]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[EquipDisposalMethods]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.EquipDisposalMethods Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.EquipDisposalMethods Table'
END
GO

--
-- Script To Delete dbo.EquipModels Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.EquipModels Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Equipments_EquipModels')
      ALTER TABLE [dbo].[Equipments] DROP CONSTRAINT [FK_Equipments_EquipModels]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[EquipModels]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.EquipModels Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.EquipModels Table'
END
GO

--
-- Script To Delete dbo.EquipModelType Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.EquipModelType Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_EquipModels_EquipModelType1')
      ALTER TABLE [dbo].[EquipModels] DROP CONSTRAINT [FK_EquipModels_EquipModelType1]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[EquipModelType]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.EquipModelType Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.EquipModelType Table'
END
GO

--
-- Script To Delete dbo.EquipMakes Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.EquipMakes Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_EquipModelType_EquipMakes')
      ALTER TABLE [dbo].[EquipModelType] DROP CONSTRAINT [FK_EquipModelType_EquipMakes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[EquipMakes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.EquipMakes Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.EquipMakes Table'
END
GO

--
-- Script To Delete dbo.EquipStatus Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.EquipStatus Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[EquipStatus]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.EquipStatus Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.EquipStatus Table'
END
GO

--
-- Script To Delete dbo.EquipTypes Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.EquipTypes Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_EquipComponentDefault_EquipTypes')
      ALTER TABLE [dbo].[EquipComponentDefault] DROP CONSTRAINT [FK_EquipComponentDefault_EquipTypes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Equipments_EquipTypes')
      ALTER TABLE [dbo].[Equipments] DROP CONSTRAINT [FK_Equipments_EquipTypes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[EquipTypes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.EquipTypes Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.EquipTypes Table'
END
GO

--
-- Script To Delete dbo.EquipUnitLogTypes Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.EquipUnitLogTypes Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_EquipUnitLogs_EquipUnitLogTypes')
      ALTER TABLE [dbo].[EquipUnitLogs] DROP CONSTRAINT [FK_EquipUnitLogs_EquipUnitLogTypes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[EquipUnitLogTypes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.EquipUnitLogTypes Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.EquipUnitLogTypes Table'
END
GO

--
-- Script To Delete dbo.Errors Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.Errors Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[Errors]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.Errors Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.Errors Table'
END
GO

--
-- Script To Delete dbo.FieldTypes Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.FieldTypes Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_CustFieldDef_FieldTypes')
      ALTER TABLE [dbo].[CustFieldDef] DROP CONSTRAINT [FK_CustFieldDef_FieldTypes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[FieldTypes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.FieldTypes Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.FieldTypes Table'
END
GO

--
-- Script To Delete dbo.Groups_Permissions Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.Groups_Permissions Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[Groups_Permissions]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.Groups_Permissions Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.Groups_Permissions Table'
END
GO

--
-- Script To Delete dbo.Logins_Groups Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.Logins_Groups Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[Logins_Groups]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.Logins_Groups Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.Logins_Groups Table'
END
GO

--
-- Script To Delete dbo.Groups Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.Groups Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Group_Permissions_Groups')
      ALTER TABLE [dbo].[Groups_Permissions] DROP CONSTRAINT [FK_Group_Permissions_Groups]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Logins_Groups_Groups')
      ALTER TABLE [dbo].[Logins_Groups] DROP CONSTRAINT [FK_Logins_Groups_Groups]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[Groups]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.Groups Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.Groups Table'
END
GO

--
-- Script To Delete dbo.Holidays Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.Holidays Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[Holidays]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.Holidays Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.Holidays Table'
END
GO

--
-- Script To Delete dbo.InspectionItems_PMSchedDetails Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.InspectionItems_PMSchedDetails Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[InspectionItems_PMSchedDetails]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.InspectionItems_PMSchedDetails Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.InspectionItems_PMSchedDetails Table'
END
GO

--
-- Script To Delete dbo.InspectionItems Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.InspectionItems Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_InspectionItems_PMSchedDetails_InspectionItems')
      ALTER TABLE [dbo].[InspectionItems_PMSchedDetails] DROP CONSTRAINT [FK_InspectionItems_PMSchedDetails_InspectionItems]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_WorkOrderInspectItems_InspectionItems')
      ALTER TABLE [dbo].[WorkOrderInspectItems] DROP CONSTRAINT [FK_WorkOrderInspectItems_InspectionItems]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[InspectionItems]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.InspectionItems Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.InspectionItems Table'
END
GO

--
-- Script To Delete dbo.InspectCats Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.InspectCats Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_InspectionItems_InspectionGroups')
      ALTER TABLE [dbo].[InspectionItems] DROP CONSTRAINT [FK_InspectionItems_InspectionGroups]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[InspectCats]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.InspectCats Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.InspectCats Table'
END
GO

--
-- Script To Delete dbo.InspectSchedDetails Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.InspectSchedDetails Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_EquipInspectHistory_InspectSchedules')
      ALTER TABLE [dbo].[EquipInspectHistory] DROP CONSTRAINT [FK_EquipInspectHistory_InspectSchedules]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_WorkOrderInspections_InspectSchedDetails')
      ALTER TABLE [dbo].[WorkOrderInspections] DROP CONSTRAINT [FK_WorkOrderInspections_InspectSchedDetails]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[InspectSchedDetails]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.InspectSchedDetails Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.InspectSchedDetails Table'
END
GO

--
-- Script To Delete dbo.Inspections Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.Inspections Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_InspectionGroups_Inspections')
      ALTER TABLE [dbo].[InspectCats] DROP CONSTRAINT [FK_InspectionGroups_Inspections]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_InspectSchedDetails_Inspections')
      ALTER TABLE [dbo].[InspectSchedDetails] DROP CONSTRAINT [FK_InspectSchedDetails_Inspections]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[Inspections]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.Inspections Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.Inspections Table'
END
GO

--
-- Script To Delete dbo.InspectSchedules Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.InspectSchedules Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Equipments_InspectSchedules')
      ALTER TABLE [dbo].[Equipments] DROP CONSTRAINT [FK_Equipments_InspectSchedules]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_InspectSchedDetails_InspectSchedules')
      ALTER TABLE [dbo].[InspectSchedDetails] DROP CONSTRAINT [FK_InspectSchedDetails_InspectSchedules]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[InspectSchedules]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.InspectSchedules Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.InspectSchedules Table'
END
GO

--
-- Script To Delete dbo.Locations Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.Locations Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Equipments_Locations')
      ALTER TABLE [dbo].[Equipments] DROP CONSTRAINT [FK_Equipments_Locations]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[Locations]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.Locations Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.Locations Table'
END
GO

--
-- Script To Delete dbo.Logins_Orgs Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.Logins_Orgs Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[Logins_Orgs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.Logins_Orgs Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.Logins_Orgs Table'
END
GO

--
-- Script To Delete dbo.Logins_UserTypes Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.Logins_UserTypes Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[Logins_UserTypes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.Logins_UserTypes Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.Logins_UserTypes Table'
END
GO

--
-- Script To Delete dbo.Logins Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.Logins Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Equipments_Logins_CreatedBy')
      ALTER TABLE [dbo].[Equipments] DROP CONSTRAINT [FK_Equipments_Logins_CreatedBy]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Equipments_Logins_Equip')
      ALTER TABLE [dbo].[Equipments] DROP CONSTRAINT [FK_Equipments_Logins_Equip]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Equipments_Logins_Temp')
      ALTER TABLE [dbo].[Equipments] DROP CONSTRAINT [FK_Equipments_Logins_Temp]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Equipments_Logins_UpdatedBy')
      ALTER TABLE [dbo].[Equipments] DROP CONSTRAINT [FK_Equipments_Logins_UpdatedBy]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Errors_Logins')
      ALTER TABLE [dbo].[Errors] DROP CONSTRAINT [FK_Errors_Logins]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Logins_Groups_Logins')
      ALTER TABLE [dbo].[Logins_Groups] DROP CONSTRAINT [FK_Logins_Groups_Logins]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Logins_Orgs_Logins')
      ALTER TABLE [dbo].[Logins_Orgs] DROP CONSTRAINT [FK_Logins_Orgs_Logins]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Logins_UserTypes_Logins')
      ALTER TABLE [dbo].[Logins_UserTypes] DROP CONSTRAINT [FK_Logins_UserTypes_Logins]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Notes_Logins')
      ALTER TABLE [dbo].[Notes] DROP CONSTRAINT [FK_Notes_Logins]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_ReOpenLogs_Operators')
      ALTER TABLE [dbo].[ReOpenLogs] DROP CONSTRAINT [FK_ReOpenLogs_Operators]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_ReOpenLogs_Technicians')
      ALTER TABLE [dbo].[ReOpenLogs] DROP CONSTRAINT [FK_ReOpenLogs_Technicians]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_SignedDocuments_Logins')
      ALTER TABLE [dbo].[SignedDocuments] DROP CONSTRAINT [FK_SignedDocuments_Logins]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_WorkOrders_Logins')
      ALTER TABLE [dbo].[WorkOrders] DROP CONSTRAINT [FK_WorkOrders_Logins]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[Logins]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.Logins Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.Logins Table'
END
GO

--
-- Script To Delete dbo.OperatorInstructions Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.OperatorInstructions Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[OperatorInstructions]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.OperatorInstructions Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.OperatorInstructions Table'
END
GO

--
-- Script To Delete dbo.OperatorInstructionTypes Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.OperatorInstructionTypes Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[OperatorInstructionTypes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.OperatorInstructionTypes Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.OperatorInstructionTypes Table'
END
GO

--
-- Script To Delete dbo.Vendors Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.Vendors Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[Vendors]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.Vendors Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.Vendors Table'
END
GO

--
-- Script To Delete dbo.Orgs Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.Orgs Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_CustFieldDef_Orgs')
      ALTER TABLE [dbo].[CustFieldDef] DROP CONSTRAINT [FK_CustFieldDef_Orgs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Departments_Orgs')
      ALTER TABLE [dbo].[Departments] DROP CONSTRAINT [FK_Departments_Orgs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_EquipComponents_Orgs')
      ALTER TABLE [dbo].[EquipComponents] DROP CONSTRAINT [FK_EquipComponents_Orgs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_EquipComponentTypes_Orgs1')
      ALTER TABLE [dbo].[EquipComponentTypes] DROP CONSTRAINT [FK_EquipComponentTypes_Orgs1]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_EquipData_Orgs')
      ALTER TABLE [dbo].[EquipData] DROP CONSTRAINT [FK_EquipData_Orgs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_EquipMakes_Orgs')
      ALTER TABLE [dbo].[EquipMakes] DROP CONSTRAINT [FK_EquipMakes_Orgs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Equipments_Orgs')
      ALTER TABLE [dbo].[Equipments] DROP CONSTRAINT [FK_Equipments_Orgs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_EquipModels_Orgs')
      ALTER TABLE [dbo].[EquipModels] DROP CONSTRAINT [FK_EquipModels_Orgs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_EquipModelType_Orgs')
      ALTER TABLE [dbo].[EquipModelType] DROP CONSTRAINT [FK_EquipModelType_Orgs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_EquipTypes_Orgs')
      ALTER TABLE [dbo].[EquipTypes] DROP CONSTRAINT [FK_EquipTypes_Orgs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Errors_Orgs')
      ALTER TABLE [dbo].[Errors] DROP CONSTRAINT [FK_Errors_Orgs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Inspections_Orgs')
      ALTER TABLE [dbo].[Inspections] DROP CONSTRAINT [FK_Inspections_Orgs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Locations_Orgs')
      ALTER TABLE [dbo].[Locations] DROP CONSTRAINT [FK_Locations_Orgs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Logins_Orgs_Orgs')
      ALTER TABLE [dbo].[Logins_Orgs] DROP CONSTRAINT [FK_Logins_Orgs_Orgs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Vendors_Orgs')
      ALTER TABLE [dbo].[Vendors] DROP CONSTRAINT [FK_Vendors_Orgs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[Orgs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.Orgs Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.Orgs Table'
END
GO

--
-- Script To Delete dbo.Pages_Permissions Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.Pages_Permissions Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[Pages_Permissions]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.Pages_Permissions Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.Pages_Permissions Table'
END
GO

--
-- Script To Delete dbo.Pages Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.Pages Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Pages_Permissions_Pages')
      ALTER TABLE [dbo].[Pages_Permissions] DROP CONSTRAINT [FK_Pages_Permissions_Pages]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[Pages]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.Pages Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.Pages Table'
END
GO

--
-- Script To Delete dbo.Permissions Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.Permissions Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Group_Permissions_Permissions')
      ALTER TABLE [dbo].[Groups_Permissions] DROP CONSTRAINT [FK_Group_Permissions_Permissions]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Pages_Permissions_Permissions')
      ALTER TABLE [dbo].[Pages_Permissions] DROP CONSTRAINT [FK_Pages_Permissions_Permissions]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[Permissions]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.Permissions Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.Permissions Table'
END
GO

--
-- Script To Delete dbo.PMSchedDetails Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.PMSchedDetails Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_EquipPMHistory_PMSchedDetails')
      ALTER TABLE [dbo].[EquipPMHistory] DROP CONSTRAINT [FK_EquipPMHistory_PMSchedDetails]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_InspectionItems_PMSchedDetails_PMSchedDetails')
      ALTER TABLE [dbo].[InspectionItems_PMSchedDetails] DROP CONSTRAINT [FK_InspectionItems_PMSchedDetails_PMSchedDetails]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_WorkOrderPMItems_PMSchedDetails')
      ALTER TABLE [dbo].[WorkOrderPMItems] DROP CONSTRAINT [FK_WorkOrderPMItems_PMSchedDetails]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[PMSchedDetails]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.PMSchedDetails Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.PMSchedDetails Table'
END
GO

--
-- Script To Delete dbo.PMSchedules Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.PMSchedules Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Equipments_PMSchedules')
      ALTER TABLE [dbo].[Equipments] DROP CONSTRAINT [FK_Equipments_PMSchedules]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_PMSchedDetails_PMSchedules')
      ALTER TABLE [dbo].[PMSchedDetails] DROP CONSTRAINT [FK_PMSchedDetails_PMSchedules]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[PMSchedules]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.PMSchedules Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.PMSchedules Table'
END
GO

--
-- Script To Delete dbo.PMServices Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.PMServices Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_PMSchedDetails_PMServices')
      ALTER TABLE [dbo].[PMSchedDetails] DROP CONSTRAINT [FK_PMSchedDetails_PMServices]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[PMServices]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.PMServices Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.PMServices Table'
END
GO

--
-- Script To Delete dbo.ReOpenCategories Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.ReOpenCategories Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_ReOpenLogs_ReOpenCategories')
      ALTER TABLE [dbo].[ReOpenLogs] DROP CONSTRAINT [FK_ReOpenLogs_ReOpenCategories]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[ReOpenCategories]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.ReOpenCategories Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.ReOpenCategories Table'
END
GO

--
-- Script To Delete dbo.RepairItems Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.RepairItems Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Repairs_RepairItems')
      ALTER TABLE [dbo].[Repairs] DROP CONSTRAINT [FK_Repairs_RepairItems]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[RepairItems]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.RepairItems Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.RepairItems Table'
END
GO

--
-- Script To Delete dbo.RepairCats Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.RepairCats Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_PMServices_RepairCats')
      ALTER TABLE [dbo].[PMServices] DROP CONSTRAINT [FK_PMServices_RepairCats]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_RepairItems_RepairCats')
      ALTER TABLE [dbo].[RepairItems] DROP CONSTRAINT [FK_RepairItems_RepairCats]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_WorkOrderReportedIssues_RepairCats')
      ALTER TABLE [dbo].[WorkOrderReportedIssues] DROP CONSTRAINT [FK_WorkOrderReportedIssues_RepairCats]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[RepairCats]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.RepairCats Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.RepairCats Table'
END
GO

--
-- Script To Delete dbo.ServiceChecks Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.ServiceChecks Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_WorkOrderInspectItems_ServiceChecks')
      ALTER TABLE [dbo].[WorkOrderInspectItems] DROP CONSTRAINT [FK_WorkOrderInspectItems_ServiceChecks]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_WorkOrderPMItems_ServiceChecks')
      ALTER TABLE [dbo].[WorkOrderPMItems] DROP CONSTRAINT [FK_WorkOrderPMItems_ServiceChecks]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_WorkOrderReportedIssues_ServiceChecks')
      ALTER TABLE [dbo].[WorkOrderReportedIssues] DROP CONSTRAINT [FK_WorkOrderReportedIssues_ServiceChecks]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[ServiceChecks]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.ServiceChecks Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.ServiceChecks Table'
END
GO

--
-- Script To Delete dbo.ServiceResults Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.ServiceResults Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_WorkOrderInspectItems_ServiceResults')
      ALTER TABLE [dbo].[WorkOrderInspectItems] DROP CONSTRAINT [FK_WorkOrderInspectItems_ServiceResults]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_WorkOrderPMItems_ServiceResults')
      ALTER TABLE [dbo].[WorkOrderPMItems] DROP CONSTRAINT [FK_WorkOrderPMItems_ServiceResults]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_WorkOrderReportedIssues_ServiceResults')
      ALTER TABLE [dbo].[WorkOrderReportedIssues] DROP CONSTRAINT [FK_WorkOrderReportedIssues_ServiceResults]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[ServiceResults]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.ServiceResults Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.ServiceResults Table'
END
GO

--
-- Script To Delete dbo.UnitMeasures Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.UnitMeasures Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_EquipTypes_UnitMeasures')
      ALTER TABLE [dbo].[EquipTypes] DROP CONSTRAINT [FK_EquipTypes_UnitMeasures]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_PMSchedDetails_UnitMeasures')
      ALTER TABLE [dbo].[PMSchedDetails] DROP CONSTRAINT [FK_PMSchedDetails_UnitMeasures]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[UnitMeasures]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.UnitMeasures Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.UnitMeasures Table'
END
GO

--
-- Script To Delete dbo.UserTypes Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.UserTypes Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_Logins_UserTypes_UserTypes')
      ALTER TABLE [dbo].[Logins_UserTypes] DROP CONSTRAINT [FK_Logins_UserTypes_UserTypes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[UserTypes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.UserTypes Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.UserTypes Table'
END
GO

--
-- Script To Delete dbo.WorkOrderOperatorStatus Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.WorkOrderOperatorStatus Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_WorkOrders_WorkOrderOperatorStatus')
      ALTER TABLE [dbo].[WorkOrders] DROP CONSTRAINT [FK_WorkOrders_WorkOrderOperatorStatus]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[WorkOrderOperatorStatus]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.WorkOrderOperatorStatus Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.WorkOrderOperatorStatus Table'
END
GO

--
-- Script To Delete dbo.WorkOrderStatus Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.WorkOrderStatus Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_WorkOrders_WorkOrderStatus')
      ALTER TABLE [dbo].[WorkOrders] DROP CONSTRAINT [FK_WorkOrders_WorkOrderStatus]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[WorkOrderStatus]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.WorkOrderStatus Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.WorkOrderStatus Table'
END
GO

--
-- Script To Delete dbo.WorkOrderTypes Table In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.WorkOrderTypes Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_WorkOrders_WorkOrderTypes')
      ALTER TABLE [dbo].[WorkOrders] DROP CONSTRAINT [FK_WorkOrders_WorkOrderTypes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[WorkOrderTypes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.WorkOrderTypes Table Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.WorkOrderTypes Table'
END
GO

--
-- Script To Delete dbo.sp_GetDateTimeOfForecastInspection Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_GetDateTimeOfForecastInspection Procedure'
GO

DROP PROCEDURE [dbo].[sp_GetDateTimeOfForecastInspection]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_GetDateTimeOfForecastInspection Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_GetDateTimeOfForecastInspection Procedure'
END
GO

--
-- Script To Delete dbo.f_GetFreeTime Function In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.f_GetFreeTime Function'
GO

DROP FUNCTION [dbo].[f_GetFreeTime]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.f_GetFreeTime Function Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.f_GetFreeTime Function'
END
GO

--
-- Script To Delete dbo.sp_SelectInspectionItemsListByCategory Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectInspectionItemsListByCategory Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectInspectionItemsListByCategory]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectInspectionItemsListByCategory Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectInspectionItemsListByCategory Procedure'
END
GO

--
-- Script To Delete dbo.f_GetPositionOptions Function In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.f_GetPositionOptions Function'
GO

DROP FUNCTION [dbo].[f_GetPositionOptions]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.f_GetPositionOptions Function Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.f_GetPositionOptions Function'
END
GO

--
-- Script To Delete dbo.sp_SelectPartsUsedForOrder Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectPartsUsedForOrder Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectPartsUsedForOrder]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectPartsUsedForOrder Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectPartsUsedForOrder Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectRepairsList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectRepairsList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectRepairsList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectRepairsList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectRepairsList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectWorkOrderInspectionItems Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectWorkOrderInspectionItems Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectWorkOrderInspectionItems]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectWorkOrderInspectionItems Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectWorkOrderInspectionItems Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectWorkOrderInspections Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectWorkOrderInspections Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectWorkOrderInspections]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectWorkOrderInspections Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectWorkOrderInspections Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectWorkOrderPMItems Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectWorkOrderPMItems Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectWorkOrderPMItems]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectWorkOrderPMItems Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectWorkOrderPMItems Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectWorkOrderReportedIssues Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectWorkOrderReportedIssues Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectWorkOrderReportedIssues]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectWorkOrderReportedIssues Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectWorkOrderReportedIssues Procedure'
END
GO

--
-- Script To Delete dbo.f_IsTechnician Function In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.f_IsTechnician Function'
GO

DROP FUNCTION [dbo].[f_IsTechnician]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.f_IsTechnician Function Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.f_IsTechnician Function'
END
GO

--
-- Script To Delete dbo.sp_SelectTempOperatorsAssignment Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectTempOperatorsAssignment Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectTempOperatorsAssignment]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectTempOperatorsAssignment Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectTempOperatorsAssignment Procedure'
END
GO

--
-- Script To Delete dbo.v_TempOperatorsAssignment View In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.v_TempOperatorsAssignment View'
GO

DROP VIEW [dbo].[v_TempOperatorsAssignment]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.v_TempOperatorsAssignment View Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.v_TempOperatorsAssignment View'
END
GO

--
-- Script To Delete dbo.sp_Authenticate Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_Authenticate Procedure'
GO

DROP PROCEDURE [dbo].[sp_Authenticate]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_Authenticate Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_Authenticate Procedure'
END
GO

--
-- Script To Delete dbo.sp_AuthOperator Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_AuthOperator Procedure'
GO

DROP PROCEDURE [dbo].[sp_AuthOperator]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_AuthOperator Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_AuthOperator Procedure'
END
GO

--
-- Script To Delete dbo.sp_ClearDatabase Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_ClearDatabase Procedure'
GO

DROP PROCEDURE [dbo].[sp_ClearDatabase]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_ClearDatabase Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_ClearDatabase Procedure'
END
GO

--
-- Script To Delete dbo.sp_ComponentDetail_CustomFields Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_ComponentDetail_CustomFields Procedure'
GO

DROP PROCEDURE [dbo].[sp_ComponentDetail_CustomFields]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_ComponentDetail_CustomFields Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_ComponentDetail_CustomFields Procedure'
END
GO

--
-- Script To Delete dbo.sp_CustFieldEquipments Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_CustFieldEquipments Procedure'
GO

DROP PROCEDURE [dbo].[sp_CustFieldEquipments]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_CustFieldEquipments Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_CustFieldEquipments Procedure'
END
GO

--
-- Script To Delete dbo.sp_DeleteComponentFromEquipment Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_DeleteComponentFromEquipment Procedure'
GO

DROP PROCEDURE [dbo].[sp_DeleteComponentFromEquipment]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_DeleteComponentFromEquipment Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_DeleteComponentFromEquipment Procedure'
END
GO

--
-- Script To Delete dbo.sp_DeleteFutureWorkOrder Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_DeleteFutureWorkOrder Procedure'
GO

DROP PROCEDURE [dbo].[sp_DeleteFutureWorkOrder]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_DeleteFutureWorkOrder Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_DeleteFutureWorkOrder Procedure'
END
GO

--
-- Script To Delete dbo.sp_DeleteWorkOrder Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_DeleteWorkOrder Procedure'
GO

DROP PROCEDURE [dbo].[sp_DeleteWorkOrder]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_DeleteWorkOrder Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_DeleteWorkOrder Procedure'
END
GO

--
-- Script To Delete dbo.sp_DepartmentDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_DepartmentDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_DepartmentDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_DepartmentDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_DepartmentDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_EquipmentDetail_Alt Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_EquipmentDetail_Alt Procedure'
GO

DROP PROCEDURE [dbo].[sp_EquipmentDetail_Alt]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_EquipmentDetail_Alt Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_EquipmentDetail_Alt Procedure'
END
GO

--
-- Script To Delete dbo.sp_EquipmentDetail_Aquis Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_EquipmentDetail_Aquis Procedure'
GO

DROP PROCEDURE [dbo].[sp_EquipmentDetail_Aquis]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_EquipmentDetail_Aquis Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_EquipmentDetail_Aquis Procedure'
END
GO

--
-- Script To Delete dbo.sp_EquipmentDetail_CustomFields Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_EquipmentDetail_CustomFields Procedure'
GO

DROP PROCEDURE [dbo].[sp_EquipmentDetail_CustomFields]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_EquipmentDetail_CustomFields Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_EquipmentDetail_CustomFields Procedure'
END
GO

--
-- Script To Delete dbo.sp_EquipmentDetail_Disp Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_EquipmentDetail_Disp Procedure'
GO

DROP PROCEDURE [dbo].[sp_EquipmentDetail_Disp]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_EquipmentDetail_Disp Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_EquipmentDetail_Disp Procedure'
END
GO

--
-- Script To Delete dbo.sp_EquipmentDetail_Main Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_EquipmentDetail_Main Procedure'
GO

DROP PROCEDURE [dbo].[sp_EquipmentDetail_Main]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_EquipmentDetail_Main Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_EquipmentDetail_Main Procedure'
END
GO

--
-- Script To Delete dbo.sp_ErrorDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_ErrorDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_ErrorDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_ErrorDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_ErrorDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_GetCompleteAbleOrder Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_GetCompleteAbleOrder Procedure'
GO

DROP PROCEDURE [dbo].[sp_GetCompleteAbleOrder]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_GetCompleteAbleOrder Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_GetCompleteAbleOrder Procedure'
END
GO

--
-- Script To Delete dbo.sp_GetDeleteAbleOrder Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_GetDeleteAbleOrder Procedure'
GO

DROP PROCEDURE [dbo].[sp_GetDeleteAbleOrder]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_GetDeleteAbleOrder Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_GetDeleteAbleOrder Procedure'
END
GO

--
-- Script To Delete dbo.sp_GetEquipId Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_GetEquipId Procedure'
GO

DROP PROCEDURE [dbo].[sp_GetEquipId]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_GetEquipId Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_GetEquipId Procedure'
END
GO

--
-- Script To Delete dbo.sp_GetEquipInfo_Alt Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_GetEquipInfo_Alt Procedure'
GO

DROP PROCEDURE [dbo].[sp_GetEquipInfo_Alt]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_GetEquipInfo_Alt Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_GetEquipInfo_Alt Procedure'
END
GO

--
-- Script To Delete dbo.sp_GetEquipInfo_Order Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_GetEquipInfo_Order Procedure'
GO

DROP PROCEDURE [dbo].[sp_GetEquipInfo_Order]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_GetEquipInfo_Order Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_GetEquipInfo_Order Procedure'
END
GO

--
-- Script To Delete dbo.sp_GetEquipSearch Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_GetEquipSearch Procedure'
GO

DROP PROCEDURE [dbo].[sp_GetEquipSearch]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_GetEquipSearch Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_GetEquipSearch Procedure'
END
GO

--
-- Script To Delete dbo.sp_GetInfoForCheckIn Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_GetInfoForCheckIn Procedure'
GO

DROP PROCEDURE [dbo].[sp_GetInfoForCheckIn]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_GetInfoForCheckIn Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_GetInfoForCheckIn Procedure'
END
GO

--
-- Script To Delete dbo.sp_GetInfoForCreateWOInspection Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_GetInfoForCreateWOInspection Procedure'
GO

DROP PROCEDURE [dbo].[sp_GetInfoForCreateWOInspection]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_GetInfoForCreateWOInspection Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_GetInfoForCreateWOInspection Procedure'
END
GO

--
-- Script To Delete dbo.sp_GetInfoForInspection Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_GetInfoForInspection Procedure'
GO

DROP PROCEDURE [dbo].[sp_GetInfoForInspection]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_GetInfoForInspection Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_GetInfoForInspection Procedure'
END
GO

--
-- Script To Delete dbo.sp_GetInfoForWorkOrder Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_GetInfoForWorkOrder Procedure'
GO

DROP PROCEDURE [dbo].[sp_GetInfoForWorkOrder]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_GetInfoForWorkOrder Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_GetInfoForWorkOrder Procedure'
END
GO

--
-- Script To Delete dbo.sp_GetPassword Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_GetPassword Procedure'
GO

DROP PROCEDURE [dbo].[sp_GetPassword]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_GetPassword Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_GetPassword Procedure'
END
GO

--
-- Script To Delete dbo.sp_GetPINCode Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_GetPINCode Procedure'
GO

DROP PROCEDURE [dbo].[sp_GetPINCode]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_GetPINCode Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_GetPINCode Procedure'
END
GO

--
-- Script To Delete dbo.sp_GetServiceName Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_GetServiceName Procedure'
GO

DROP PROCEDURE [dbo].[sp_GetServiceName]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_GetServiceName Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_GetServiceName Procedure'
END
GO

--
-- Script To Delete dbo.sp_GetSignedDocument Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_GetSignedDocument Procedure'
GO

DROP PROCEDURE [dbo].[sp_GetSignedDocument]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_GetSignedDocument Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_GetSignedDocument Procedure'
END
GO

--
-- Script To Delete dbo.sp_GetSpareEquip Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_GetSpareEquip Procedure'
GO

DROP PROCEDURE [dbo].[sp_GetSpareEquip]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_GetSpareEquip Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_GetSpareEquip Procedure'
END
GO

--
-- Script To Delete dbo.sp_GetUserInfoForKiosk Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_GetUserInfoForKiosk Procedure'
GO

DROP PROCEDURE [dbo].[sp_GetUserInfoForKiosk]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_GetUserInfoForKiosk Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_GetUserInfoForKiosk Procedure'
END
GO

--
-- Script To Delete dbo.sp_GetWorkOrderId Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_GetWorkOrderId Procedure'
GO

DROP PROCEDURE [dbo].[sp_GetWorkOrderId]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_GetWorkOrderId Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_GetWorkOrderId Procedure'
END
GO

--
-- Script To Delete dbo.sp_GroupDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_GroupDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_GroupDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_GroupDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_GroupDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_GroupsPermissionsDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_GroupsPermissionsDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_GroupsPermissionsDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_GroupsPermissionsDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_GroupsPermissionsDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_HolidayDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_HolidayDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_HolidayDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_HolidayDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_HolidayDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_InitDB Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_InitDB Procedure'
GO

DROP PROCEDURE [dbo].[sp_InitDB]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_InitDB Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_InitDB Procedure'
END
GO

--
-- Script To Delete dbo.sp_InitOrg Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_InitOrg Procedure'
GO

DROP PROCEDURE [dbo].[sp_InitOrg]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_InitOrg Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_InitOrg Procedure'
END
GO

--
-- Script To Delete dbo.sp_InspectCatsDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_InspectCatsDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_InspectCatsDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_InspectCatsDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_InspectCatsDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_InspectHistoryDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_InspectHistoryDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_InspectHistoryDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_InspectHistoryDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_InspectHistoryDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_InspectionDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_InspectionDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_InspectionDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_InspectionDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_InspectionDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_InspectionItemsPMSchedDetailsDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_InspectionItemsPMSchedDetailsDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_InspectionItemsPMSchedDetailsDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_InspectionItemsPMSchedDetailsDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_InspectionItemsPMSchedDetailsDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_InspectItemDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_InspectItemDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_InspectItemDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_InspectItemDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_InspectItemDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_InspectSchedDetailDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_InspectSchedDetailDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_InspectSchedDetailDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_InspectSchedDetailDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_InspectSchedDetailDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_InspectScheduleDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_InspectScheduleDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_InspectScheduleDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_InspectScheduleDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_InspectScheduleDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_LocationDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_LocationDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_LocationDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_LocationDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_LocationDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_LoginsDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_LoginsDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_LoginsDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_LoginsDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_LoginsDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_LoginsGroupsDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_LoginsGroupsDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_LoginsGroupsDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_LoginsGroupsDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_LoginsGroupsDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_LoginsInfo Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_LoginsInfo Procedure'
GO

DROP PROCEDURE [dbo].[sp_LoginsInfo]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_LoginsInfo Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_LoginsInfo Procedure'
END
GO

--
-- Script To Delete dbo.sp_NotesDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_NotesDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_NotesDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_NotesDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_NotesDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_OperatorInstructionsDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_OperatorInstructionsDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_OperatorInstructionsDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_OperatorInstructionsDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_OperatorInstructionsDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_OrgsDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_OrgsDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_OrgsDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_OrgsDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_OrgsDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_PagesPermissionDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_PagesPermissionDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_PagesPermissionDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_PagesPermissionDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_PagesPermissionDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_PartsUsedDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_PartsUsedDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_PartsUsedDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_PartsUsedDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_PartsUsedDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_PermissionDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_PermissionDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_PermissionDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_PermissionDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_PermissionDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_PMHistoryDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_PMHistoryDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_PMHistoryDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_PMHistoryDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_PMHistoryDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_UpdateRepair Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_UpdateRepair Procedure'
GO

DROP PROCEDURE [dbo].[sp_UpdateRepair]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_UpdateRepair Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_UpdateRepair Procedure'
END
GO

--
-- Script To Delete dbo.sp_RepairCommonDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_RepairCommonDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_RepairCommonDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_RepairCommonDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_RepairCommonDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_RepairExDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_RepairExDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_RepairExDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_RepairExDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_RepairExDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_RepairItemDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_RepairItemDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_RepairItemDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_RepairItemDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_RepairItemDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_RepairsDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_RepairsDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_RepairsDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_RepairsDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_RepairsDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_Report_GetInspectionItems Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_Report_GetInspectionItems Procedure'
GO

DROP PROCEDURE [dbo].[sp_Report_GetInspectionItems]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_Report_GetInspectionItems Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_Report_GetInspectionItems Procedure'
END
GO

--
-- Script To Delete dbo.sp_Report_GetInspections Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_Report_GetInspections Procedure'
GO

DROP PROCEDURE [dbo].[sp_Report_GetInspections]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_Report_GetInspections Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_Report_GetInspections Procedure'
END
GO

--
-- Script To Delete dbo.sp_Report_GetPMItems Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_Report_GetPMItems Procedure'
GO

DROP PROCEDURE [dbo].[sp_Report_GetPMItems]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_Report_GetPMItems Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_Report_GetPMItems Procedure'
END
GO

--
-- Script To Delete dbo.sp_Report_GetReportedIssues Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_Report_GetReportedIssues Procedure'
GO

DROP PROCEDURE [dbo].[sp_Report_GetReportedIssues]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_Report_GetReportedIssues Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_Report_GetReportedIssues Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectActivityWorkOrderList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectActivityWorkOrderList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectActivityWorkOrderList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectActivityWorkOrderList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectActivityWorkOrderList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectCategoryList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectCategoryList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectCategoryList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectCategoryList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectCategoryList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectComponentList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectComponentList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectComponentList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectComponentList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectComponentList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectComponentTypeList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectComponentTypeList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectComponentTypeList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectComponentTypeList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectComponentTypeList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectCustFieldDef Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectCustFieldDef Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectCustFieldDef]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectCustFieldDef Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectCustFieldDef Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectDepartmentsList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectDepartmentsList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectDepartmentsList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectDepartmentsList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectDepartmentsList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectDispMethodsList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectDispMethodsList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectDispMethodsList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectDispMethodsList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectDispMethodsList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectEquipAssignTo Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectEquipAssignTo Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectEquipAssignTo]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectEquipAssignTo Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectEquipAssignTo Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectEquipInspectList_Filter Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectEquipInspectList_Filter Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectEquipInspectList_Filter]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectEquipInspectList_Filter Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectEquipInspectList_Filter Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectEquipList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectEquipList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectEquipList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectEquipList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectEquipList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectEquipList_CustomFields Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectEquipList_CustomFields Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectEquipList_CustomFields]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectEquipList_CustomFields Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectEquipList_CustomFields Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectEquipList_Filter Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectEquipList_Filter Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectEquipList_Filter]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectEquipList_Filter Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectEquipList_Filter Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectEquipListByOperator Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectEquipListByOperator Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectEquipListByOperator]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectEquipListByOperator Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectEquipListByOperator Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectEquipListByOperator2 Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectEquipListByOperator2 Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectEquipListByOperator2]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectEquipListByOperator2 Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectEquipListByOperator2 Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectEquipListByOperatorActivate Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectEquipListByOperatorActivate Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectEquipListByOperatorActivate]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectEquipListByOperatorActivate Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectEquipListByOperatorActivate Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectEquipListByUser Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectEquipListByUser Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectEquipListByUser]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectEquipListByUser Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectEquipListByUser Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectEquipListForCheckOut Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectEquipListForCheckOut Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectEquipListForCheckOut]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectEquipListForCheckOut Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectEquipListForCheckOut Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectEquipListForSpare Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectEquipListForSpare Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectEquipListForSpare]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectEquipListForSpare Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectEquipListForSpare Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectEquipListForSpare2 Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectEquipListForSpare2 Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectEquipListForSpare2]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectEquipListForSpare2 Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectEquipListForSpare2 Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectEquipmentAssignment Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectEquipmentAssignment Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectEquipmentAssignment]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectEquipmentAssignment Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectEquipmentAssignment Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectEquipStatusList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectEquipStatusList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectEquipStatusList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectEquipStatusList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectEquipStatusList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectEquipTypeList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectEquipTypeList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectEquipTypeList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectEquipTypeList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectEquipTypeList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectErrorsList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectErrorsList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectErrorsList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectErrorsList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectErrorsList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectFutureWorkOrderInspections Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectFutureWorkOrderInspections Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectFutureWorkOrderInspections]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectFutureWorkOrderInspections Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectFutureWorkOrderInspections Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectFutureWorkOrderPMItems Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectFutureWorkOrderPMItems Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectFutureWorkOrderPMItems]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectFutureWorkOrderPMItems Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectFutureWorkOrderPMItems Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectGroupsList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectGroupsList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectGroupsList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectGroupsList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectGroupsList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectGroupsListByNotUser Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectGroupsListByNotUser Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectGroupsListByNotUser]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectGroupsListByNotUser Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectGroupsListByNotUser Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectGroupsListByUser Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectGroupsListByUser Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectGroupsListByUser]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectGroupsListByUser Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectGroupsListByUser Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectHolidaysList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectHolidaysList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectHolidaysList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectHolidaysList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectHolidaysList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectInspectCategoriesList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectInspectCategoriesList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectInspectCategoriesList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectInspectCategoriesList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectInspectCategoriesList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectInspectionItemsList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectInspectionItemsList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectInspectionItemsList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectInspectionItemsList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectInspectionItemsList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectInspectionsList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectInspectionsList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectInspectionsList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectInspectionsList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectInspectionsList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectInspectionsListForWorkOrder Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectInspectionsListForWorkOrder Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectInspectionsListForWorkOrder]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectInspectionsListForWorkOrder Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectInspectionsListForWorkOrder Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectInspectSchedDetailsList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectInspectSchedDetailsList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectInspectSchedDetailsList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectInspectSchedDetailsList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectInspectSchedDetailsList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectInspectSchedulesList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectInspectSchedulesList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectInspectSchedulesList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectInspectSchedulesList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectInspectSchedulesList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectInstructionByCheckIn Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectInstructionByCheckIn Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectInstructionByCheckIn]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectInstructionByCheckIn Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectInstructionByCheckIn Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectInstructionByCheckOut Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectInstructionByCheckOut Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectInstructionByCheckOut]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectInstructionByCheckOut Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectInstructionByCheckOut Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectInstructionByReOpen Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectInstructionByReOpen Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectInstructionByReOpen]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectInstructionByReOpen Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectInstructionByReOpen Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectLocationsList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectLocationsList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectLocationsList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectLocationsList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectLocationsList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectMakesList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectMakesList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectMakesList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectMakesList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectMakesList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectModelMakes Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectModelMakes Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectModelMakes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectModelMakes Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectModelMakes Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectModelMakesList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectModelMakesList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectModelMakesList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectModelMakesList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectModelMakesList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectModelsList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectModelsList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectModelsList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectModelsList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectModelsList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectNotesList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectNotesList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectNotesList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectNotesList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectNotesList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectOrgsList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectOrgsList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectOrgsList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectOrgsList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectOrgsList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectOrgsListFromUser Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectOrgsListFromUser Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectOrgsListFromUser]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectOrgsListFromUser Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectOrgsListFromUser Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectPagesList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectPagesList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectPagesList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectPagesList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectPagesList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectPagesListFromPermission Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectPagesListFromPermission Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectPagesListFromPermission]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectPagesListFromPermission Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectPagesListFromPermission Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectPartsUsed Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectPartsUsed Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectPartsUsed]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectPartsUsed Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectPartsUsed Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectPermissionsList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectPermissionsList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectPermissionsList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectPermissionsList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectPermissionsList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectPermissionsListFromGroup Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectPermissionsListFromGroup Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectPermissionsListFromGroup]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectPermissionsListFromGroup Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectPermissionsListFromGroup Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectPMSchedPMServicesList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectPMSchedPMServicesList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectPMSchedPMServicesList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectPMSchedPMServicesList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectPMSchedPMServicesList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectPMSchedulesList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectPMSchedulesList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectPMSchedulesList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectPMSchedulesList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectPMSchedulesList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectPMServicesByInspectionItem Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectPMServicesByInspectionItem Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectPMServicesByInspectionItem]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectPMServicesByInspectionItem Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectPMServicesByInspectionItem Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectPMServicesListForWorkOrder Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectPMServicesListForWorkOrder Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectPMServicesListForWorkOrder]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectPMServicesListForWorkOrder Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectPMServicesListForWorkOrder Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectReOpenCategoryList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectReOpenCategoryList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectReOpenCategoryList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectReOpenCategoryList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectReOpenCategoryList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectRepairItemsAndCats Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectRepairItemsAndCats Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectRepairItemsAndCats]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectRepairItemsAndCats Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectRepairItemsAndCats Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectRepairsListForUpdate Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectRepairsListForUpdate Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectRepairsListForUpdate]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectRepairsListForUpdate Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectRepairsListForUpdate Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectRepairsListShort Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectRepairsListShort Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectRepairsListShort]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectRepairsListShort Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectRepairsListShort Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectReportedIssueListsForEquipment Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectReportedIssueListsForEquipment Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectReportedIssueListsForEquipment]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectReportedIssueListsForEquipment Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectReportedIssueListsForEquipment Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectReportedIssueListsForOpeartorKiosk Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectReportedIssueListsForOpeartorKiosk Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectReportedIssueListsForOpeartorKiosk]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectReportedIssueListsForOpeartorKiosk Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectReportedIssueListsForOpeartorKiosk Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectReportedIssueListsForWorkOrder Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectReportedIssueListsForWorkOrder Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectReportedIssueListsForWorkOrder]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectReportedIssueListsForWorkOrder Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectReportedIssueListsForWorkOrder Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectReportedIssuesListForUpdate Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectReportedIssuesListForUpdate Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectReportedIssuesListForUpdate]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectReportedIssuesListForUpdate Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectReportedIssuesListForUpdate Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectSourceList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectSourceList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectSourceList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectSourceList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectSourceList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectSpareEquipListByType Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectSpareEquipListByType Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectSpareEquipListByType]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectSpareEquipListByType Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectSpareEquipListByType Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectUserList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectUserList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectUserList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectUserList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectUserList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectUserList_Filter Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectUserList_Filter Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectUserList_Filter]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectUserList_Filter Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectUserList_Filter Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectUserListByType Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectUserListByType Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectUserListByType]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectUserListByType Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectUserListByType Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectUsersListFromGroup Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectUsersListFromGroup Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectUsersListFromGroup]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectUsersListFromGroup Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectUsersListFromGroup Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectWorkOrderCompleted Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectWorkOrderCompleted Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectWorkOrderCompleted]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectWorkOrderCompleted Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectWorkOrderCompleted Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectWorkOrderIssuesItems Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectWorkOrderIssuesItems Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectWorkOrderIssuesItems]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectWorkOrderIssuesItems Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectWorkOrderIssuesItems Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectWorkOrderListForDate Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectWorkOrderListForDate Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectWorkOrderListForDate]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectWorkOrderListForDate Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectWorkOrderListForDate Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectWorkOrderListForEquip Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectWorkOrderListForEquip Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectWorkOrderListForEquip]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectWorkOrderListForEquip Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectWorkOrderListForEquip Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectWorkOrderListForTech Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectWorkOrderListForTech Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectWorkOrderListForTech]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectWorkOrderListForTech Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectWorkOrderListForTech Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectWorkOrderListForTime Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectWorkOrderListForTime Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectWorkOrderListForTime]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectWorkOrderListForTime Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectWorkOrderListForTime Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectWorkOrderListForToday Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectWorkOrderListForToday Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectWorkOrderListForToday]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectWorkOrderListForToday Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectWorkOrderListForToday Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectWorkOrderListFromEquip Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectWorkOrderListFromEquip Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectWorkOrderListFromEquip]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectWorkOrderListFromEquip Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectWorkOrderListFromEquip Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectWorkOrderTypesList Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectWorkOrderTypesList Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectWorkOrderTypesList]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectWorkOrderTypesList Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectWorkOrderTypesList Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectWorkOrderUnassigned Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectWorkOrderUnassigned Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectWorkOrderUnassigned]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectWorkOrderUnassigned Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectWorkOrderUnassigned Procedure'
END
GO

--
-- Script To Delete dbo.sp_SelectWorkOrderUnsigned Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SelectWorkOrderUnsigned Procedure'
GO

DROP PROCEDURE [dbo].[sp_SelectWorkOrderUnsigned]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SelectWorkOrderUnsigned Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SelectWorkOrderUnsigned Procedure'
END
GO

--
-- Script To Delete dbo.sp_SetAssociationsIssue Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SetAssociationsIssue Procedure'
GO

DROP PROCEDURE [dbo].[sp_SetAssociationsIssue]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SetAssociationsIssue Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SetAssociationsIssue Procedure'
END
GO

--
-- Script To Delete dbo.sp_SetAssociationsRepair Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SetAssociationsRepair Procedure'
GO

DROP PROCEDURE [dbo].[sp_SetAssociationsRepair]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SetAssociationsRepair Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SetAssociationsRepair Procedure'
END
GO

--
-- Script To Delete dbo.sp_SetInspectItemChecks Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SetInspectItemChecks Procedure'
GO

DROP PROCEDURE [dbo].[sp_SetInspectItemChecks]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SetInspectItemChecks Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SetInspectItemChecks Procedure'
END
GO

--
-- Script To Delete dbo.sp_SetInspectWorkOrder Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SetInspectWorkOrder Procedure'
GO

DROP PROCEDURE [dbo].[sp_SetInspectWorkOrder]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SetInspectWorkOrder Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SetInspectWorkOrder Procedure'
END
GO

--
-- Script To Delete dbo.sp_SetIssueChecks Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SetIssueChecks Procedure'
GO

DROP PROCEDURE [dbo].[sp_SetIssueChecks]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SetIssueChecks Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SetIssueChecks Procedure'
END
GO

--
-- Script To Delete dbo.sp_SetNewTechToWorkOrder Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SetNewTechToWorkOrder Procedure'
GO

DROP PROCEDURE [dbo].[sp_SetNewTechToWorkOrder]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SetNewTechToWorkOrder Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SetNewTechToWorkOrder Procedure'
END
GO

--
-- Script To Delete dbo.sp_SetPassword Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SetPassword Procedure'
GO

DROP PROCEDURE [dbo].[sp_SetPassword]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SetPassword Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SetPassword Procedure'
END
GO

--
-- Script To Delete dbo.sp_SetPINCode Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SetPINCode Procedure'
GO

DROP PROCEDURE [dbo].[sp_SetPINCode]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SetPINCode Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SetPINCode Procedure'
END
GO

--
-- Script To Delete dbo.sp_SetPMItemChecks Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SetPMItemChecks Procedure'
GO

DROP PROCEDURE [dbo].[sp_SetPMItemChecks]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SetPMItemChecks Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SetPMItemChecks Procedure'
END
GO

--
-- Script To Delete dbo.sp_SetRepairResult Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SetRepairResult Procedure'
GO

DROP PROCEDURE [dbo].[sp_SetRepairResult]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SetRepairResult Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SetRepairResult Procedure'
END
GO

--
-- Script To Delete dbo.sp_SetRoadsideWorkOrder Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SetRoadsideWorkOrder Procedure'
GO

DROP PROCEDURE [dbo].[sp_SetRoadsideWorkOrder]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SetRoadsideWorkOrder Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SetRoadsideWorkOrder Procedure'
END
GO

--
-- Script To Delete dbo.sp_SetWorkOrder Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SetWorkOrder Procedure'
GO

DROP PROCEDURE [dbo].[sp_SetWorkOrder]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SetWorkOrder Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SetWorkOrder Procedure'
END
GO

--
-- Script To Delete dbo.sp_SigningEquipmentCheckIn Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SigningEquipmentCheckIn Procedure'
GO

DROP PROCEDURE [dbo].[sp_SigningEquipmentCheckIn]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SigningEquipmentCheckIn Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SigningEquipmentCheckIn Procedure'
END
GO

--
-- Script To Delete dbo.sp_SigningEquipmentCheckOut Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SigningEquipmentCheckOut Procedure'
GO

DROP PROCEDURE [dbo].[sp_SigningEquipmentCheckOut]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SigningEquipmentCheckOut Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SigningEquipmentCheckOut Procedure'
END
GO

--
-- Script To Delete dbo.sp_SigningInspection Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SigningInspection Procedure'
GO

DROP PROCEDURE [dbo].[sp_SigningInspection]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SigningInspection Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SigningInspection Procedure'
END
GO

--
-- Script To Delete dbo.sp_SigningWorkOrderClose Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SigningWorkOrderClose Procedure'
GO

DROP PROCEDURE [dbo].[sp_SigningWorkOrderClose]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SigningWorkOrderClose Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SigningWorkOrderClose Procedure'
END
GO

--
-- Script To Delete dbo.sp_SigningWorkOrderOpen Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SigningWorkOrderOpen Procedure'
GO

DROP PROCEDURE [dbo].[sp_SigningWorkOrderOpen]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SigningWorkOrderOpen Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SigningWorkOrderOpen Procedure'
END
GO

--
-- Script To Delete dbo.sp_SigningWorkOrderReOpen Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_SigningWorkOrderReOpen Procedure'
GO

DROP PROCEDURE [dbo].[sp_SigningWorkOrderReOpen]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_SigningWorkOrderReOpen Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_SigningWorkOrderReOpen Procedure'
END
GO

--
-- Script To Delete dbo.sp_UpdateActiveWorkOrder Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_UpdateActiveWorkOrder Procedure'
GO

DROP PROCEDURE [dbo].[sp_UpdateActiveWorkOrder]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_UpdateActiveWorkOrder Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_UpdateActiveWorkOrder Procedure'
END
GO

--
-- Script To Delete dbo.sp_UpdateCheckInWorkOrder Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_UpdateCheckInWorkOrder Procedure'
GO

DROP PROCEDURE [dbo].[sp_UpdateCheckInWorkOrder]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_UpdateCheckInWorkOrder Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_UpdateCheckInWorkOrder Procedure'
END
GO

--
-- Script To Delete dbo.sp_UpdateCheckOutWorkOrder Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_UpdateCheckOutWorkOrder Procedure'
GO

DROP PROCEDURE [dbo].[sp_UpdateCheckOutWorkOrder]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_UpdateCheckOutWorkOrder Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_UpdateCheckOutWorkOrder Procedure'
END
GO

--
-- Script To Delete dbo.sp_UpdateEquipAssignedTempTo Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_UpdateEquipAssignedTempTo Procedure'
GO

DROP PROCEDURE [dbo].[sp_UpdateEquipAssignedTempTo]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_UpdateEquipAssignedTempTo Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_UpdateEquipAssignedTempTo Procedure'
END
GO

--
-- Script To Delete dbo.sp_UpdateEquipAssignedTo Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_UpdateEquipAssignedTo Procedure'
GO

DROP PROCEDURE [dbo].[sp_UpdateEquipAssignedTo]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_UpdateEquipAssignedTo Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_UpdateEquipAssignedTo Procedure'
END
GO

--
-- Script To Delete dbo.sp_UpdateEquipSpare Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_UpdateEquipSpare Procedure'
GO

DROP PROCEDURE [dbo].[sp_UpdateEquipSpare]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_UpdateEquipSpare Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_UpdateEquipSpare Procedure'
END
GO

--
-- Script To Delete dbo.sp_UpdateFutureInspections Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_UpdateFutureInspections Procedure'
GO

DROP PROCEDURE [dbo].[sp_UpdateFutureInspections]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_UpdateFutureInspections Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_UpdateFutureInspections Procedure'
END
GO

--
-- Script To Delete dbo.sp_UpdateInActiveUser Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_UpdateInActiveUser Procedure'
GO

DROP PROCEDURE [dbo].[sp_UpdateInActiveUser]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_UpdateInActiveUser Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_UpdateInActiveUser Procedure'
END
GO

--
-- Script To Delete dbo.sp_UpdateInActiveWorkOrder Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_UpdateInActiveWorkOrder Procedure'
GO

DROP PROCEDURE [dbo].[sp_UpdateInActiveWorkOrder]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_UpdateInActiveWorkOrder Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_UpdateInActiveWorkOrder Procedure'
END
GO

--
-- Script To Delete dbo.sp_UpdateInspectionItems Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_UpdateInspectionItems Procedure'
GO

DROP PROCEDURE [dbo].[sp_UpdateInspectionItems]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_UpdateInspectionItems Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_UpdateInspectionItems Procedure'
END
GO

--
-- Script To Delete dbo.sp_UpdateInspections Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_UpdateInspections Procedure'
GO

DROP PROCEDURE [dbo].[sp_UpdateInspections]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_UpdateInspections Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_UpdateInspections Procedure'
END
GO

--
-- Script To Delete dbo.sp_UpdateOpenWorkOrder Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_UpdateOpenWorkOrder Procedure'
GO

DROP PROCEDURE [dbo].[sp_UpdateOpenWorkOrder]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_UpdateOpenWorkOrder Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_UpdateOpenWorkOrder Procedure'
END
GO

--
-- Script To Delete dbo.sp_UpdatePMItems Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_UpdatePMItems Procedure'
GO

DROP PROCEDURE [dbo].[sp_UpdatePMItems]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_UpdatePMItems Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_UpdatePMItems Procedure'
END
GO

--
-- Script To Delete dbo.sp_UpdatePositionInspectItem Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_UpdatePositionInspectItem Procedure'
GO

DROP PROCEDURE [dbo].[sp_UpdatePositionInspectItem]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_UpdatePositionInspectItem Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_UpdatePositionInspectItem Procedure'
END
GO

--
-- Script To Delete dbo.sp_UpdateReOpenWorkOrder Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_UpdateReOpenWorkOrder Procedure'
GO

DROP PROCEDURE [dbo].[sp_UpdateReOpenWorkOrder]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_UpdateReOpenWorkOrder Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_UpdateReOpenWorkOrder Procedure'
END
GO

--
-- Script To Delete dbo.sp_UpdateStayingWorkOrder Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_UpdateStayingWorkOrder Procedure'
GO

DROP PROCEDURE [dbo].[sp_UpdateStayingWorkOrder]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_UpdateStayingWorkOrder Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_UpdateStayingWorkOrder Procedure'
END
GO

--
-- Script To Delete dbo.sp_WorkOrderDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_WorkOrderDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_WorkOrderDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_WorkOrderDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_WorkOrderDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_WorkOrderDetail_CustomFields Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_WorkOrderDetail_CustomFields Procedure'
GO

DROP PROCEDURE [dbo].[sp_WorkOrderDetail_CustomFields]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_WorkOrderDetail_CustomFields Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_WorkOrderDetail_CustomFields Procedure'
END
GO

--
-- Script To Delete dbo.sp_WorkOrderInspectionsDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_WorkOrderInspectionsDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_WorkOrderInspectionsDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_WorkOrderInspectionsDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_WorkOrderInspectionsDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_WorkOrderInspectItemsDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_WorkOrderInspectItemsDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_WorkOrderInspectItemsDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_WorkOrderInspectItemsDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_WorkOrderInspectItemsDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_WorkOrderPMItemsDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_WorkOrderPMItemsDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_WorkOrderPMItemsDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_WorkOrderPMItemsDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_WorkOrderPMItemsDetail Procedure'
END
GO

--
-- Script To Delete dbo.sp_WorkOrderReportedIssuesDetail Procedure In largo.BFS_Beta
-- Generated Tuesday, April 11, 2006, at 10:27 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.sp_WorkOrderReportedIssuesDetail Procedure'
GO

DROP PROCEDURE [dbo].[sp_WorkOrderReportedIssuesDetail]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.sp_WorkOrderReportedIssuesDetail Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.sp_WorkOrderReportedIssuesDetail Procedure'
END
GO