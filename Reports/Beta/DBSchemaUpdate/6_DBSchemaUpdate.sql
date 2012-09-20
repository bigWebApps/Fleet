--
-- Script To Update dbo.OperatorInstructions Table In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Updating dbo.OperatorInstructions Table'
GO

SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, QUOTED_IDENTIFIER, CONCAT_NULL_YIELDS_NULL ON
GO

SET NUMERIC_ROUNDABORT OFF
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.OperatorInstructions Table Updated Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Update dbo.OperatorInstructions Table'
END
GO
--
-- Script To Update dbo.OperatorInstructionTypes Table In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Updating dbo.OperatorInstructionTypes Table'
GO

SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, QUOTED_IDENTIFIER, CONCAT_NULL_YIELDS_NULL ON
GO

SET NUMERIC_ROUNDABORT OFF
GO


IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF EXISTS (SELECT name FROM sysobjects WHERE name = N'DF_UserInstructionTypes_vchName')
      ALTER TABLE [dbo].[OperatorInstructionTypes] DROP CONSTRAINT [DF_UserInstructionTypes_vchName]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   CREATE TABLE [dbo].[tmp_OperatorInstructionTypes] (
   [OrgId] [int] NOT NULL,
   [Id] [int] IDENTITY (1, 1) NOT NULL,
   [vchName] [varchar] (50) NOT NULL DEFAULT ('')
)
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   SET IDENTITY_INSERT [dbo].[tmp_OperatorInstructionTypes] ON
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   INSERT INTO [dbo].[tmp_OperatorInstructionTypes] ([OrgId], [Id], [vchName])
   SELECT '', [Id], [vchName]
   FROM [dbo].[OperatorInstructionTypes]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   SET IDENTITY_INSERT [dbo].[tmp_OperatorInstructionTypes] OFF
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   DROP TABLE [dbo].[OperatorInstructionTypes]
GO

sp_rename N'[dbo].[tmp_OperatorInstructionTypes]', N'OperatorInstructionTypes'

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   ALTER TABLE [dbo].[OperatorInstructionTypes] ADD CONSTRAINT [PK_UserInstructionTypes] PRIMARY KEY CLUSTERED ([Id], [OrgId])
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.OperatorInstructionTypes Table Updated Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Update dbo.OperatorInstructionTypes Table'
END
GO

--
-- Script To Delete dbo.dt_addtosourcecontrol_u Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_addtosourcecontrol_u Procedure'
GO

DROP PROCEDURE [dbo].[dt_addtosourcecontrol_u]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_addtosourcecontrol_u Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_addtosourcecontrol_u Procedure'
END
GO

--
-- Script To Delete dbo.dt_addtosourcecontrol Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_addtosourcecontrol Procedure'
GO

DROP PROCEDURE [dbo].[dt_addtosourcecontrol]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_addtosourcecontrol Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_addtosourcecontrol Procedure'
END
GO

--
-- Script To Delete dbo.dt_adduserobject Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_adduserobject Procedure'
GO

DROP PROCEDURE [dbo].[dt_adduserobject]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_adduserobject Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_adduserobject Procedure'
END
GO

--
-- Script To Delete dbo.dt_adduserobject_vcs Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_adduserobject_vcs Procedure'
GO

DROP PROCEDURE [dbo].[dt_adduserobject_vcs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_adduserobject_vcs Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_adduserobject_vcs Procedure'
END
GO

--
-- Script To Delete dbo.dt_checkinobject_u Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_checkinobject_u Procedure'
GO

DROP PROCEDURE [dbo].[dt_checkinobject_u]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_checkinobject_u Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_checkinobject_u Procedure'
END
GO

--
-- Script To Delete dbo.dt_checkinobject Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_checkinobject Procedure'
GO

DROP PROCEDURE [dbo].[dt_checkinobject]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_checkinobject Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_checkinobject Procedure'
END
GO

--
-- Script To Delete dbo.dt_checkoutobject_u Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_checkoutobject_u Procedure'
GO

DROP PROCEDURE [dbo].[dt_checkoutobject_u]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_checkoutobject_u Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_checkoutobject_u Procedure'
END
GO

--
-- Script To Delete dbo.dt_checkoutobject Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_checkoutobject Procedure'
GO

DROP PROCEDURE [dbo].[dt_checkoutobject]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_checkoutobject Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_checkoutobject Procedure'
END
GO

--
-- Script To Delete dbo.dt_displayoaerror_u Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_displayoaerror_u Procedure'
GO

DROP PROCEDURE [dbo].[dt_displayoaerror_u]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_displayoaerror_u Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_displayoaerror_u Procedure'
END
GO

--
-- Script To Delete dbo.dt_isundersourcecontrol_u Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_isundersourcecontrol_u Procedure'
GO

DROP PROCEDURE [dbo].[dt_isundersourcecontrol_u]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_isundersourcecontrol_u Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_isundersourcecontrol_u Procedure'
END
GO

--
-- Script To Delete dbo.dt_isundersourcecontrol Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_isundersourcecontrol Procedure'
GO

DROP PROCEDURE [dbo].[dt_isundersourcecontrol]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_isundersourcecontrol Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_isundersourcecontrol Procedure'
END
GO

--
-- Script To Delete dbo.dt_validateloginparams_u Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_validateloginparams_u Procedure'
GO

DROP PROCEDURE [dbo].[dt_validateloginparams_u]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_validateloginparams_u Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_validateloginparams_u Procedure'
END
GO

--
-- Script To Delete dbo.dt_validateloginparams Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_validateloginparams Procedure'
GO

DROP PROCEDURE [dbo].[dt_validateloginparams]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_validateloginparams Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_validateloginparams Procedure'
END
GO

--
-- Script To Delete dbo.dt_whocheckedout_u Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_whocheckedout_u Procedure'
GO

DROP PROCEDURE [dbo].[dt_whocheckedout_u]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_whocheckedout_u Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_whocheckedout_u Procedure'
END
GO

--
-- Script To Delete dbo.dt_whocheckedout Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_whocheckedout Procedure'
GO

DROP PROCEDURE [dbo].[dt_whocheckedout]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_whocheckedout Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_whocheckedout Procedure'
END
GO

--
-- Script To Delete dbo.dt_displayoaerror Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_displayoaerror Procedure'
GO

DROP PROCEDURE [dbo].[dt_displayoaerror]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_displayoaerror Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_displayoaerror Procedure'
END
GO

--
-- Script To Delete dbo.dt_removefromsourcecontrol Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_removefromsourcecontrol Procedure'
GO

DROP PROCEDURE [dbo].[dt_removefromsourcecontrol]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_removefromsourcecontrol Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_removefromsourcecontrol Procedure'
END
GO

--
-- Script To Delete dbo.dt_droppropertiesbyid Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_droppropertiesbyid Procedure'
GO

DROP PROCEDURE [dbo].[dt_droppropertiesbyid]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_droppropertiesbyid Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_droppropertiesbyid Procedure'
END
GO

--
-- Script To Delete dbo.dt_dropuserobjectbyid Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_dropuserobjectbyid Procedure'
GO

DROP PROCEDURE [dbo].[dt_dropuserobjectbyid]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_dropuserobjectbyid Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_dropuserobjectbyid Procedure'
END
GO

--
-- Script To Delete dbo.dt_setpropertybyid_u Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_setpropertybyid_u Procedure'
GO

DROP PROCEDURE [dbo].[dt_setpropertybyid_u]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_setpropertybyid_u Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_setpropertybyid_u Procedure'
END
GO

--
-- Script To Delete dbo.dt_generateansiname Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_generateansiname Procedure'
GO

DROP PROCEDURE [dbo].[dt_generateansiname]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_generateansiname Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_generateansiname Procedure'
END
GO

--
-- Script To Delete dbo.dt_getobjwithprop Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_getobjwithprop Procedure'
GO

DROP PROCEDURE [dbo].[dt_getobjwithprop]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_getobjwithprop Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_getobjwithprop Procedure'
END
GO

--
-- Script To Delete dbo.dt_getobjwithprop_u Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_getobjwithprop_u Procedure'
GO

DROP PROCEDURE [dbo].[dt_getobjwithprop_u]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_getobjwithprop_u Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_getobjwithprop_u Procedure'
END
GO

--
-- Script To Delete dbo.dt_getpropertiesbyid Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_getpropertiesbyid Procedure'
GO

DROP PROCEDURE [dbo].[dt_getpropertiesbyid]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_getpropertiesbyid Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_getpropertiesbyid Procedure'
END
GO

--
-- Script To Delete dbo.dt_getpropertiesbyid_u Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_getpropertiesbyid_u Procedure'
GO

DROP PROCEDURE [dbo].[dt_getpropertiesbyid_u]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_getpropertiesbyid_u Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_getpropertiesbyid_u Procedure'
END
GO

--
-- Script To Delete dbo.dt_getpropertiesbyid_vcs_u Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_getpropertiesbyid_vcs_u Procedure'
GO

DROP PROCEDURE [dbo].[dt_getpropertiesbyid_vcs_u]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_getpropertiesbyid_vcs_u Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_getpropertiesbyid_vcs_u Procedure'
END
GO

--
-- Script To Delete dbo.dt_getpropertiesbyid_vcs Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_getpropertiesbyid_vcs Procedure'
GO

DROP PROCEDURE [dbo].[dt_getpropertiesbyid_vcs]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_getpropertiesbyid_vcs Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_getpropertiesbyid_vcs Procedure'
END
GO

--
-- Script To Delete dbo.dt_setpropertybyid Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_setpropertybyid Procedure'
GO

DROP PROCEDURE [dbo].[dt_setpropertybyid]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_setpropertybyid Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_setpropertybyid Procedure'
END
GO

--
-- Script To Delete dbo.dt_vcsenabled Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_vcsenabled Procedure'
GO

DROP PROCEDURE [dbo].[dt_vcsenabled]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_vcsenabled Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_vcsenabled Procedure'
END
GO

--
-- Script To Delete dbo.dt_verstamp006 Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_verstamp006 Procedure'
GO

DROP PROCEDURE [dbo].[dt_verstamp006]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_verstamp006 Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_verstamp006 Procedure'
END
GO

--
-- Script To Delete dbo.dt_verstamp007 Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Deleting dbo.dt_verstamp007 Procedure'
GO

DROP PROCEDURE [dbo].[dt_verstamp007]
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.dt_verstamp007 Procedure Deleted Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Delete dbo.dt_verstamp007 Procedure'
END
GO

--
-- Script To Delete dbo.sp_GetInfoForCheckIn Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Script To Delete dbo.sp_SelectInspectionItemsListByCategory Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Script To Delete dbo.sp_SelectInspectionsList Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Script To Delete dbo.sp_SelectPartsUsedForOrder Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Script To Delete dbo.sp_SelectPermissionsList Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Script To Delete dbo.sp_SelectRepairsList Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Script To Delete dbo.sp_SelectRepairsListForUpdate Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Script To Delete dbo.sp_SelectTempOperatorsAssignment Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Script To Delete dbo.sp_SelectUserList Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Script To Delete dbo.sp_SelectWorkOrderInspectionItems Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Script To Delete dbo.sp_SelectWorkOrderIssuesItems Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Script To Delete dbo.sp_SelectWorkOrderPMItems Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Script To Delete dbo.sp_SelectWorkOrderTypesList Procedure In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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
-- Generated Friday, April 14, 2006, at 04:03 AM
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

--
-- Script To Update dbo.OperatorInstructions Table In largo.BFS_Beta
-- Generated Friday, April 14, 2006, at 04:03 AM
--
-- Please backup largo.BFS_Beta before executing this script
--


BEGIN TRANSACTION
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

PRINT 'Updating dbo.OperatorInstructions Table'
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
   IF NOT EXISTS (SELECT name FROM sysobjects WHERE name = N'FK_OperatorInstructions_OperatorInstructionTypes')
      ALTER TABLE [dbo].[OperatorInstructions] ADD CONSTRAINT [FK_OperatorInstructions_OperatorInstructionTypes] FOREIGN KEY ([TypeId], [OrgId]) REFERENCES [dbo].[OperatorInstructionTypes] ([Id], [OrgId])
GO

IF @@ERROR <> 0
   IF @@TRANCOUNT = 1 ROLLBACK TRANSACTION
GO

IF @@TRANCOUNT = 1
BEGIN
   PRINT 'dbo.OperatorInstructions Table Updated Successfully'
   COMMIT TRANSACTION
END ELSE
BEGIN
   PRINT 'Failed To Update dbo.OperatorInstructions Table'
END
GO
