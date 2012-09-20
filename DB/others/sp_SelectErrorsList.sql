SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER PROCEDURE sp_SelectErrorsList
	(
		@dtStartDate datetime,
		@dtFinishDate datetime
	)
AS
	set nocount on

	select 	E.[Id] as [Id],
		E.UserId as UserId,
		isnull(L.vchLastName, 'Unknown') + ', ' + isnull(L.vchFirstName, 'Unknown') as UserName,
		E.UserOrgId as OrgId,
		O.vchName as OrgName,
		E.vchErrorName as vchErrorName,
		E.vchPageName as vchPageName,
		E.dtCreated as dtCreated,
		E.vchDesc as vchDesc
	from Errors E
	inner join Orgs O
	on O.[Id] = E.UserOrgId
	and  datediff(minute, @dtStartDate, E.dtCreated) > 0 
	and datediff(minute, E.dtCreated, @dtFinishDate) > 0 
	left outer join Logins L
	on L.[Id] = E.UserId
	order by E.[Id] desc






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

