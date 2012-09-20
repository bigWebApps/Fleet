SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



ALTER  PROCEDURE sp_SelectEquipView_FixedFields
	(
		@OrgId int,
		@Id int,
		@vchType varchar(50) OUTPUT,
		@vchAssignedTo varchar(100)=null OUTPUT,
		@vchStatus varchar(50)=null OUTPUT,
		@vchPMSched varchar(25)=null OUTPUT,
		@vchInspect varchar(50)=null OUTPUT,
		@intCurrentUnits int=null OUTPUT,
		@dtInService smalldatetime=null OUTPUT,
		@dtAquired smalldatetime=null OUTPUT,
		@vchPurOrgContact varchar(50)=null OUTPUT,
		@smPurAmount smallmoney=null OUTPUT,
		@intPurUnits int=null OUTPUT,
		@vchPurNotes varchar(250)=null OUTPUT,
		@dtOutOfService smalldatetime=null OUTPUT,
		@dtDisposed smalldatetime=null OUTPUT,
		@vchDispOrgContact varchar(50)=null OUTPUT,
		@smDispAmount smallmoney=null OUTPUT,
		@intDispUnits int=null OUTPUT,
		@vchDispNotes varchar(250)=null OUTPUT,
		@vchDispMethod varchar(25)=null OUTPUT
	)
AS
	set nocount on

	SELECT 	@vchType=ISNULL(et.vchName, ''), 
		@vchAssignedTo=l.vchLastName+', '+l.vchFirstName,
		@vchStatus=ISNULL(es.vchName, ''),
		@vchPMSched=ISNULL(pm.vchName, ''),
		@vchInspect=ISNULL(i.vchName, ''),
		@intCurrentUnits= e.intCurrentUnits,
		@dtInService = e.dtInservice,
		@dtAquired = e.dtAquired,
		@vchPurOrgContact=ISNULL(e.vchPurOrgContact, ''), 
		@smPurAmount=e.smPurAmount,
		@intPurUnits = e.intPurUnits,
		@vchPurNotes=ISNULL(e.vchPurNotes, ''),
		@dtOutOfService= e.dtOutOfService,
		@dtDisposed = e.dtDisposed,
		@vchDispOrgContact = ISNULL(e.vchDispOrgContact, ''), 
		@smDispAmount = e.smDispAmount, 
		@intDispUnits = e.intDispUnits,
		@vchDispNotes= ISNULL(e.vchDispNotes, ''), 
		@vchDispMethod=edm.vchName
	FROM Equipment e
	LEFT OUTER JOIN EquipTypes et ON et.OrgId=@OrgId AND et.Id=e.TypeId
	LEFT OUTER JOIN EquipDisposalMethods edm ON edm.OrgId=@OrgId AND edm.Id=e.intDispMethod
	LEFT OUTER JOIN Logins l ON l.OrgId=@OrgId AND l.id=e.AssignedTo
	LEFT OUTER JOIN EquipStatus es ON es.id=e.StatusId
	LEFT OUTER JOIN PMSchedules pm ON pm.OrgId=@OrgId AND pm.id=e.PMSchedId
	LEFT OUTER JOIN Inspections i ON i.OrgId=@OrgId AND i.Id=e.InspectId
	WHERE e.OrgId=@OrgId AND e.Id=@Id

	RETURN 
	


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

