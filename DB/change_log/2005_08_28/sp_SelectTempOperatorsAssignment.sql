SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

alter procedure dbo.sp_SelectTempOperatorsAssignment
(
		@OrgId int,
		@dtMinDate datetime,
		@dtMaxDate datetime
)
as
	set nocount on
	
	select 	E.[Id],
		E.vchEquipId,
		TOA.dtUpdated,
		TOA.vchNote,
		Lt.vchLastName + ', ' + Lt.vchFirstName as TempOperator,
		case when isnull(Lu.vchLastName, '') = '' then '' else Lu.vchLastName + ', ' + Lu.vchFirstName end as UserName
	from Equipments E 
	inner join v_TempOperatorsAssignment TOA
	on  E.OrgId = @OrgId
	and TOA.[Id] = E.[Id] 
	and (TOA.AssignedTo = E.TempOperatorId or isnull(TOA.AssignedTo, 0) = 0)
	and TOA.OrgId = E.OrgId
	left outer join Logins Lt
	on Lt.[Id] = E.TempOperatorId
	left outer join Logins Lu
	on Lu.[Id] = TOA.AssignedBy
	order by TOA.dtUpdated desc

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

