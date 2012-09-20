--
-- Script To Delete dbo.dt_addtosourcecontrol Procedure In largo.BFS_Beta
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Script To Delete dbo.dt_addtosourcecontrol_u Procedure In largo.BFS_Beta
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Script To Delete dbo.dt_adduserobject Procedure In largo.BFS_Beta
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Script To Delete dbo.dt_checkinobject Procedure In largo.BFS_Beta
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Script To Delete dbo.dt_checkinobject_u Procedure In largo.BFS_Beta
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Script To Delete dbo.dt_checkoutobject Procedure In largo.BFS_Beta
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Script To Delete dbo.dt_checkoutobject_u Procedure In largo.BFS_Beta
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Script To Delete dbo.dt_isundersourcecontrol Procedure In largo.BFS_Beta
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Script To Delete dbo.dt_validateloginparams Procedure In largo.BFS_Beta
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Script To Delete dbo.dt_whocheckedout Procedure In largo.BFS_Beta
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Script To Delete dbo.dt_isundersourcecontrol_u Procedure In largo.BFS_Beta
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Script To Delete dbo.dt_validateloginparams_u Procedure In largo.BFS_Beta
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Script To Delete dbo.dt_whocheckedout_u Procedure In largo.BFS_Beta
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Script To Delete dbo.dt_displayoaerror_u Procedure In largo.BFS_Beta
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Script To Delete dbo.dt_removefromsourcecontrol Procedure In largo.BFS_Beta
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Script To Delete dbo.dt_getpropertiesbyid_vcs Procedure In largo.BFS_Beta
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Script To Delete dbo.dt_getpropertiesbyid_vcs_u Procedure In largo.BFS_Beta
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Script To Delete dbo.dt_setpropertybyid Procedure In largo.BFS_Beta
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Generated Thursday, April 27, 2006, at 04:25 AM
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
-- Generated Thursday, April 27, 2006, at 04:25 AM
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