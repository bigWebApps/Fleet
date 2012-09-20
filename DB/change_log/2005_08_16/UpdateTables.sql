BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
GO
BEGIN TRANSACTION

ALTER TABLE [dbo].[WorkOrderInspectItems] 
	DROP CONSTRAINT [FK_WorkOrderInspectItems_WorkOrderInspections]

ALTER TABLE [dbo].[WorkOrderInspectItems] 
	DROP CONSTRAINT [PK_WorkOrderInspectItems]

ALTER TABLE [dbo].[WorkOrderInspections] 
	DROP CONSTRAINT [PK_WorkOrderInspections]

ALTER TABLE dbo.Equipments
	DROP CONSTRAINT FK_Equipments_PMSchedules

ALTER TABLE dbo.Equipments
	DROP CONSTRAINT FK_Equipments_Orgs

ALTER TABLE dbo.Equipments
	DROP CONSTRAINT FK_Equipments_Logins

ALTER TABLE dbo.Equipments
	DROP CONSTRAINT FK_Equipments_Logins_CreatedBy

ALTER TABLE dbo.Equipments
	DROP CONSTRAINT FK_Equipments_Logins_UpdatedBy

ALTER TABLE dbo.Equipments
	DROP CONSTRAINT FK_Equipments_Locations

ALTER TABLE dbo.Equipments
	DROP CONSTRAINT FK_Equipments_Inspections

ALTER TABLE dbo.Equipments
	DROP CONSTRAINT FK_Equipments_EquipTypes

ALTER TABLE dbo.Equipments
	DROP CONSTRAINT FK_Equipments_EquipModels

ALTER TABLE dbo.Equipments
	DROP CONSTRAINT FK_Equipments_EquipDisposalMethods

ALTER TABLE dbo.Equipments
	DROP CONSTRAINT FK_Equipments_EquipData

ALTER TABLE dbo.Equipments
	DROP CONSTRAINT FK_Equipments_Departments

ALTER TABLE dbo.Equipments
	DROP CONSTRAINT DF_Equipments_dmCurrentUnits
GO
CREATE TABLE dbo.Tmp_Equipments
	(
	OrgId int NOT NULL,
	Id int NOT NULL IDENTITY (1, 1),
	TypeId int NOT NULL,
	ModelId int NULL,
	intYear int NULL,
	EquipOperatorId int NULL,
	TempOperatorId int NULL,
	DeptId int NULL,
	LocId int NULL,
	DataId int NOT NULL,
	bitSpare bit NOT NULL,
	vchFuelCode varchar(20) COLLATE Latin1_General_CI_AS NULL,
	PMScheduleId int NULL,
	InspectId int NULL,
	dmCurrentUnits decimal(19, 8) NULL,
	vchEquipId varchar(50) COLLATE Latin1_General_CI_AS NULL,
	vchVinSerial varchar(50) COLLATE Latin1_General_CI_AS NULL,
	vchPlateNumber varchar(50) COLLATE Latin1_General_CI_AS NULL,
	dtInservice datetime NULL,
	dtAquired datetime NULL,
	dtOutService datetime NULL,
	dtDisposed datetime NULL,
	vchPurOrgContact varchar(50) NULL,
	dmPurUnits decimal(19, 8) NULL,
	smPurAmount smallmoney NULL,
	vchPurNotes varchar(250) NULL,
	vchDispOrgContact varchar(50) NULL,
	dmDispUnits decimal(19, 8) NULL,
	smDispAmount smallmoney NULL,
	vchDispNotes varchar(250) NULL,
	intDispMethod int NULL,
	intCreatedBy int NULL,
	dtCreated datetime NULL,
	intUpdatedBy int NULL,
	dtUpdated datetime NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_Equipments ADD CONSTRAINT
	DF_Equipments_dmCurrentUnits DEFAULT (0) FOR dmCurrentUnits
GO
SET IDENTITY_INSERT dbo.Tmp_Equipments ON
GO
IF EXISTS(SELECT * FROM dbo.Equipments)
	 EXEC('INSERT INTO dbo.Tmp_Equipments (OrgId, Id, TypeId, ModelId, intYear, EquipOperatorId, DeptId, LocId, DataId, bitSpare, vchFuelCode, PMScheduleId, InspectId, dmCurrentUnits, vchEquipId, vchVinSerial, vchPlateNumber, dtInservice, dtAquired, dtOutService, dtDisposed, vchPurOrgContact, dmPurUnits, smPurAmount, vchPurNotes, vchDispOrgContact, dmDispUnits, smDispAmount, vchDispNotes, intDispMethod, intCreatedBy, dtCreated, intUpdatedBy, dtUpdated)
		SELECT OrgId, Id, TypeId, ModelId, intYear, AssignedTo, DeptId, LocId, DataId, bitSpare, vchFuelCode, PMScheduleId, InspectId, dmCurrentUnits, vchEquipId, vchVinSerial, vchPlateNumber, dtInservice, dtAquired, dtOutService, dtDisposed, vchPurOrgContact, dmPurUnits, smPurAmount, vchPurNotes, vchDispOrgContact, dmDispUnits, smDispAmount, vchDispNotes, intDispMethod, intCreatedBy, dtCreated, intUpdatedBy, dtUpdated FROM dbo.Equipments TABLOCKX')
GO
SET IDENTITY_INSERT dbo.Tmp_Equipments OFF
GO
ALTER TABLE dbo.EquipUnitLogs
	DROP CONSTRAINT FK_EquipUnitLogs_Equipments

ALTER TABLE dbo.WorkOrders
	DROP CONSTRAINT FK_WorkOrders_Equipments

ALTER TABLE dbo.EquipInspectHistory
	DROP CONSTRAINT FK_EquipInspectHistory_Equipments

ALTER TABLE dbo.EquipPMHistory
	DROP CONSTRAINT FK_EquipPMHistory_Equipments

ALTER TABLE dbo.WorkOrderReportedIssues
	DROP CONSTRAINT FK_WorkOrderReportedIssues_Equipments
GO
DROP TABLE dbo.Equipments
GO
EXECUTE sp_rename N'dbo.Tmp_Equipments', N'Equipments', 'OBJECT'
GO
ALTER TABLE [dbo].[WorkOrderInspectItems] ADD CONSTRAINT [PK_WorkOrderInspectItems] PRIMARY KEY  CLUSTERED 
	(
		[OrgId],
		[WorkOrderInspectId],
		[Id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO
ALTER TABLE [dbo].[WorkOrderInspections] ADD CONSTRAINT 
	[PK_WorkOrderInspections] PRIMARY KEY  CLUSTERED 
	(
		[OrgId],
		[Id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO
ALTER TABLE [dbo].[WorkOrderInspectItems] ADD CONSTRAINT 
	[FK_WorkOrderInspectItems_WorkOrderInspections] FOREIGN KEY 
	(
		[OrgId],
		[WorkOrderInspectId]
	) REFERENCES [WorkOrderInspections] (
		[OrgId],
		[Id]
	)
GO
ALTER TABLE dbo.Equipments ADD CONSTRAINT
	PK_Equipments PRIMARY KEY CLUSTERED 
	(
	Id,
	OrgId
	) ON [PRIMARY]
GO
ALTER TABLE dbo.Equipments WITH NOCHECK ADD CONSTRAINT
	FK_Equipments_Departments FOREIGN KEY
	(
	OrgId,
	DeptId
	) REFERENCES dbo.Departments
	(
	OrgId,
	Id
	)
GO
ALTER TABLE dbo.Equipments WITH NOCHECK ADD CONSTRAINT
	FK_Equipments_EquipData FOREIGN KEY
	(
	OrgId,
	DataId
	) REFERENCES dbo.EquipData
	(
	OrgId,
	Id
	)
GO
ALTER TABLE dbo.Equipments WITH NOCHECK ADD CONSTRAINT
	FK_Equipments_EquipDisposalMethods FOREIGN KEY
	(
	OrgId,
	intDispMethod
	) REFERENCES dbo.EquipDisposalMethods
	(
	OrgId,
	Id
	)
GO
ALTER TABLE dbo.Equipments WITH NOCHECK ADD CONSTRAINT
	FK_Equipments_EquipModels FOREIGN KEY
	(
	OrgId,
	ModelId
	) REFERENCES dbo.EquipModels
	(
	OrgId,
	Id
	)
GO
ALTER TABLE dbo.Equipments WITH NOCHECK ADD CONSTRAINT
	FK_Equipments_EquipTypes FOREIGN KEY
	(
	OrgId,
	TypeId
	) REFERENCES dbo.EquipTypes
	(
	OrgId,
	Id
	)
GO
ALTER TABLE dbo.Equipments WITH NOCHECK ADD CONSTRAINT
	FK_Equipments_Inspections FOREIGN KEY
	(
	OrgId,
	InspectId
	) REFERENCES dbo.Inspections
	(
	OrgId,
	Id
	)
GO
ALTER TABLE dbo.Equipments WITH NOCHECK ADD CONSTRAINT
	FK_Equipments_Locations FOREIGN KEY
	(
	OrgId,
	LocId
	) REFERENCES dbo.Locations
	(
	OrgId,
	Id
	)
GO
ALTER TABLE dbo.Equipments WITH NOCHECK ADD CONSTRAINT
	FK_Equipments_Logins_Equip FOREIGN KEY
	(
	EquipOperatorId
	) REFERENCES dbo.Logins
	(
	Id
	)
GO
ALTER TABLE dbo.Equipments WITH NOCHECK ADD CONSTRAINT
	FK_Equipments_Logins_CreatedBy FOREIGN KEY
	(
	intCreatedBy
	) REFERENCES dbo.Logins
	(
	Id
	)
GO
ALTER TABLE dbo.Equipments WITH NOCHECK ADD CONSTRAINT
	FK_Equipments_Logins_UpdatedBy FOREIGN KEY
	(
	intUpdatedBy
	) REFERENCES dbo.Logins
	(
	Id
	)
GO
ALTER TABLE dbo.Equipments WITH NOCHECK ADD CONSTRAINT
	FK_Equipments_Orgs FOREIGN KEY
	(
	OrgId
	) REFERENCES dbo.Orgs
	(
	Id
	)
GO
ALTER TABLE dbo.Equipments WITH NOCHECK ADD CONSTRAINT
	FK_Equipments_PMSchedules FOREIGN KEY
	(
	OrgId,
	PMScheduleId
	) REFERENCES dbo.PMSchedules
	(
	OrgId,
	Id
	)
GO
ALTER TABLE dbo.Equipments ADD CONSTRAINT
	FK_Equipments_Logins_Temp FOREIGN KEY
	(
	TempOperatorId
	) REFERENCES dbo.Logins
	(
	Id
	)
GO
ALTER TABLE dbo.WorkOrderReportedIssues WITH NOCHECK ADD CONSTRAINT
	FK_WorkOrderReportedIssues_Equipments FOREIGN KEY
	(
	EquipId,
	OrgId
	) REFERENCES dbo.Equipments
	(
	Id,
	OrgId
	)
GO
ALTER TABLE dbo.EquipPMHistory WITH NOCHECK ADD CONSTRAINT
	FK_EquipPMHistory_Equipments FOREIGN KEY
	(
	EquipId,
	OrgId
	) REFERENCES dbo.Equipments
	(
	Id,
	OrgId
	)
GO
ALTER TABLE dbo.EquipInspectHistory WITH NOCHECK ADD CONSTRAINT
	FK_EquipInspectHistory_Equipments FOREIGN KEY
	(
	EquipId,
	OrgId
	) REFERENCES dbo.Equipments
	(
	Id,
	OrgId
	)
GO
ALTER TABLE dbo.WorkOrders WITH NOCHECK ADD CONSTRAINT
	FK_WorkOrders_Equipments FOREIGN KEY
	(
	EquipId,
	OrgId
	) REFERENCES dbo.Equipments
	(
	Id,
	OrgId
	)
GO
ALTER TABLE dbo.EquipUnitLogs WITH NOCHECK ADD CONSTRAINT
	FK_EquipUnitLogs_Equipments FOREIGN KEY
	(
	EquipId,
	OrgId
	) REFERENCES dbo.Equipments
	(
	Id,
	OrgId
	)
GO
COMMIT