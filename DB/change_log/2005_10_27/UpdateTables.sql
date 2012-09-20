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
ALTER TABLE dbo.Orgs ADD
	vchFullName varchar(255) NOT NULL CONSTRAINT DF_Orgs_vchFullName DEFAULT '',
	vchAddress1 varchar(50) NULL,
	vchAddress2 varchar(50) NULL,
	vchCity varchar(50) NULL,
	vchProvince varchar(50) NULL,
	vchPostalCode varchar(30) NULL,
	vchPhone varchar(20) NULL,
	vchPhone2 varchar(20) NULL,
	vchFax varchar(20) NULL,
	vchAcctNumber varchar(50) NULL,
	vchContactName varchar(50) NULL,
	vchNotes text NULL,
	vchWeb varchar(75) NULL,
	vchEmail varchar(75) NULL
GO
COMMIT

BEGIN TRANSACTION
ALTER TABLE dbo.OperatorInstructions
	DROP CONSTRAINT FK_OperatorInstructions_OperatorInstructionTypes
GO
ALTER TABLE dbo.OperatorInstructionTypes
	DROP CONSTRAINT PK_UserInstructionTypes
GO
ALTER TABLE dbo.OperatorInstructionTypes ADD CONSTRAINT
	PK_OperatorInstructionTypes PRIMARY KEY CLUSTERED 
	(
	Id
	) ON [PRIMARY]

GO
ALTER TABLE dbo.OperatorInstructionTypes
	DROP COLUMN OrgId
GO
COMMIT

