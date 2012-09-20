SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create procedure dbo.sp_SelectEquipmentAssignment
(
		@OrgId int,
		@EquipId int,
		@dtMinDate datetime,
		@dtMaxDate datetime,
		@vchEquipId varchar(50)=null output
)
as
	set nocount on

	select @vchEquipId = vchEquipId
	from Equipments
	where [Id] = @EquipId
	and OrgId = @OrgId

	select 	EAL.[Id] as [Id],
		EAL.dtUpdated as dtUpdated,
		case when EAL.IsTemp = 1 then 'Temp Operator' else 'Operator' end as ChangeType,
		case when isnull(Lo.[Id], 0) = 0 then 'Nobody' else Lo.vchLastName + ', ' + Lo.vchFirstName end as AssignedFrom,
		case when isnull(Ln.[Id], 0) = 0 then 'Nobody' else Ln.vchLastName + ', ' + Ln.vchFirstName end as AssignedTo,
		case when isnull(Lu.[Id], 0) = 0 then '' else Lu.vchLastName + ', ' + Lu.vchFirstName end as UserName,
		EAL.vchNote as vchNote
	from EquipAssignLogs EAL
	left outer join Logins Lo
	on Lo.[Id] = isnull(EAL.AssignedFrom, 0)
	left outer join Logins Ln
	on Ln.[Id] = isnull(EAL.AssignedTo, 0)
	left outer join Logins Lu
	on Lu.[Id] = isnull(EAL.AssignedBy, 0)
	where EquipId = @EquipId
	and EAL.OrgId = @OrgId
	and datediff(minute, @dtMinDate, dateadd(d, 1, dateadd(d, datediff(d, '', isnull(EAL.dtUpdated, getdate())), ''))) > 0 
	and datediff(minute, dateadd(d, datediff(d, '', isnull(EAL.dtUpdated, getdate())), ''), @dtMaxDate) > 0 
	order by EAL.dtUpdated desc

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

