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


BEGIN TRANSACTION
ALTER TABLE [dbo].[EquipPMHistory] DROP CONSTRAINT [FK_EquipPMHistory_WorkOrders]
GO
ALTER TABLE [dbo].[EquipInspectHistory] DROP CONSTRAINT [FK_EquipInspectHistory_WorkOrders]
GO
COMMIT

BEGIN TRANSACTION

CREATE TABLE dbo.Holidays
	(
	OrgId int NOT NULL,
	[Id] int NOT NULL IDENTITY (1, 1),
	dtStartDate datetime NOT NULL,
	dtEndDate datetime NOT NULL,
	vchDesc varchar(50) NOT NULL,
	intPercentOff int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Holidays ADD CONSTRAINT
	DF_Holidays_vchDesc DEFAULT '' FOR vchDesc
GO
ALTER TABLE dbo.Holidays ADD CONSTRAINT
	DF_Holidays_intPercentOff DEFAULT 100 FOR intPercentOff
GO
ALTER TABLE dbo.Holidays ADD CONSTRAINT
	PK_Holidays PRIMARY KEY CLUSTERED 
	(
	[Id],
	OrgId
	) ON [PRIMARY]

GO
COMMIT

print '1 step'

BEGIN TRANSACTION
ALTER TABLE dbo.Inspections
	DROP CONSTRAINT DF_Inspections_intFrequencyDays
GO
ALTER TABLE dbo.Inspections
	DROP COLUMN intFrequencyDays
GO
COMMIT

print '2 step'

BEGIN TRANSACTION
CREATE TABLE dbo.InspectSchedules
	(
	OrgId int NOT NULL,
	[Id] int NOT NULL IDENTITY (1, 1),
	vchName varchar(50) NOT NULL
	) ON [PRIMARY]
GO

ALTER TABLE dbo.InspectSchedules ADD CONSTRAINT
	DF_InspectSchedules_vchName DEFAULT '' FOR vchName
GO
ALTER TABLE dbo.InspectSchedules ADD CONSTRAINT
	PK_InspectSchedules PRIMARY KEY CLUSTERED 
	(
	[Id],
	OrgId
	) ON [PRIMARY]

GO

insert into [dbo].[InspectSchedules]([OrgId], [vchName])
select 1, 'Schedule for Monthly Inspection of Buses'
COMMIT

print '3 step'

BEGIN TRANSACTION
CREATE TABLE dbo.InspectSchedDetails
	(
	OrgId int NOT NULL,
	[Id] int NOT NULL IDENTITY (1, 1),
	InspectSchedId int NOT NULL,
	InspectionId int NOT NULL,
	TargetDaysOut int NOT NULL,
	MinimumDaysOut int NOT NULL,
	MaximumDaysOut int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.InspectSchedDetails ADD CONSTRAINT
	DF_InspectSchedDetails_TargetDaysOut DEFAULT 1 FOR TargetDaysOut
GO
ALTER TABLE dbo.InspectSchedDetails ADD CONSTRAINT
	DF_InspectSchedDetails_MinimumDaysOut DEFAULT 1 FOR MinimumDaysOut
GO
ALTER TABLE dbo.InspectSchedDetails ADD CONSTRAINT
	DF_InspectSchedDetails_MaximumDaysOut DEFAULT 1 FOR MaximumDaysOut
GO
ALTER TABLE dbo.InspectSchedDetails ADD CONSTRAINT
	PK_InspectSchedDetails PRIMARY KEY CLUSTERED 
	(
	[Id],
	OrgId
	) ON [PRIMARY]

GO
ALTER TABLE dbo.InspectSchedDetails ADD CONSTRAINT
	FK_InspectSchedDetails_Inspections FOREIGN KEY
	(
	OrgId,
	InspectionId
	) REFERENCES dbo.Inspections
	(
	OrgId,
	[Id]
	)
GO
ALTER TABLE dbo.InspectSchedDetails ADD CONSTRAINT
	FK_InspectSchedDetails_InspectSchedules FOREIGN KEY
	(
	InspectSchedId,
	OrgId
	) REFERENCES dbo.InspectSchedules
	(
	[Id],
	OrgId
	)
GO

insert into [dbo].[InspectSchedDetails]([OrgId], InspectSchedId, [InspectionId], [TargetDaysOut], [MinimumDaysOut], [MaximumDaysOut])
select 1, 1, 1, 30, 24, 36
COMMIT

print '4 step'

BEGIN TRANSACTION
ALTER TABLE dbo.Equipments
	DROP CONSTRAINT FK_Equipments_Inspections
GO

EXECUTE sp_rename N'dbo.Equipments.InspectId', N'InspectScheduleId', 'COLUMN'
GO

ALTER TABLE dbo.Equipments ADD CONSTRAINT
	FK_Equipments_InspectSchedules FOREIGN KEY
	(
	InspectScheduleId,
	OrgId
	) REFERENCES dbo.InspectSchedules
	(
	[Id],
	OrgId
	)
GO
COMMIT

print '5 step'

BEGIN TRANSACTION
ALTER TABLE dbo.WorkOrderInspections
	DROP CONSTRAINT FK_WorkOrderInspections_Inspections
GO

EXECUTE sp_rename N'dbo.WorkOrderInspections.InspectId', N'InspectSchedDetailId', 'COLUMN'
GO

ALTER TABLE dbo.WorkOrderInspections ADD CONSTRAINT
	FK_WorkOrderInspections_InspectSchedDetails FOREIGN KEY
	(
	InspectSchedDetailId,
	OrgId
	) REFERENCES dbo.InspectSchedDetails
	(
	[Id],
	OrgId
	)
GO
COMMIT

print '6 step'

BEGIN TRANSACTION
ALTER TABLE dbo.EquipInspectHistory
	DROP CONSTRAINT FK_EquipInspectHistory_Inspections
GO

EXECUTE sp_rename N'dbo.EquipInspectHistory.InspectionId', N'InspectSchedDetailId', 'COLUMN'
GO

ALTER TABLE dbo.EquipInspectHistory ADD CONSTRAINT
	FK_EquipInspectHistory_InspectSchedules FOREIGN KEY
	(
	InspectSchedDetailId,
	OrgId
	) REFERENCES dbo.InspectSchedDetails
	(
	[Id],
	OrgId
	)
GO
COMMIT
print '7 step'
