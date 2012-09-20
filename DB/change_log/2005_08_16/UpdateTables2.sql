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
CREATE TABLE dbo.Tmp_EquipAssignLogs
	(
	OrgId int NOT NULL,
	EquipId int NOT NULL,
	Id int NOT NULL IDENTITY (1, 1),
	IsTemp bit NOT NULL,
	AssignedFrom int NULL,
	AssignedTo int NULL,
	AssignedBy int NOT NULL,
	vchNote varchar(250) NULL,
	dtUpdated smalldatetime NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_EquipAssignLogs ADD CONSTRAINT
	DF_EquipAssignLogs_IsTemp DEFAULT 0 FOR IsTemp
GO
SET IDENTITY_INSERT dbo.Tmp_EquipAssignLogs ON
GO
IF EXISTS(SELECT * FROM dbo.EquipAssignLogs)
	 EXEC('INSERT INTO dbo.Tmp_EquipAssignLogs (OrgId, EquipId, Id, AssignedFrom, AssignedTo, AssignedBy, vchNote, dtUpdated)
		SELECT OrgId, EquipId, Id, AssignedFrom, AssignedTo, AssignedBy, vchNote, dtUpdated FROM dbo.EquipAssignLogs TABLOCKX')
GO
SET IDENTITY_INSERT dbo.Tmp_EquipAssignLogs OFF
GO
DROP TABLE dbo.EquipAssignLogs
GO
EXECUTE sp_rename N'dbo.Tmp_EquipAssignLogs', N'EquipAssignLogs', 'OBJECT'
GO
ALTER TABLE dbo.EquipAssignLogs ADD CONSTRAINT
	PK_EquipAssignLogs PRIMARY KEY CLUSTERED 
	(
	OrgId,
	EquipId,
	Id
	) ON [PRIMARY]

GO
COMMIT
