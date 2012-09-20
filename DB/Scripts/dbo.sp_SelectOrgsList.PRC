SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectOrgsList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectOrgsList]
GO

CREATE PROCEDURE sp_SelectOrgsList
AS
	SET NOCOUNT ON
	
	select 	[Id], 
		[intBWAId],
		[vchName]
	from Orgs
	where btActive = 1

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

