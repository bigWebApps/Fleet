SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectReOpenCategoryList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectReOpenCategoryList]
GO


create procedure dbo.sp_SelectReOpenCategoryList
as
	set nocount on
	select [Id], vchReason, btTechnicianCause
	from ReOpenCategories


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

