SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE dbo.sp_SelectEquipView
	(
		@OrgId int,
		@Id int,
		@vchEquipId varchar(25) OUTPUT,
		@intYear int OUTPUT,
		@vchType varchar(50) OUTPUT,
		@vchMake varchar(50) OUTPUT,
		@vchModel varchar(50) OUTPUT,
		@vchDept varchar(50)=null OUTPUT,
		@vchLocation varchar(50)=null OUTPUT,
		@vchAssignedTo varchar(100)=null OUTPUT,
		@vchVinSerial varchar(50)=null OUTPUT,
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
		@vchDispMethod varchar(25)=null OUTPUT,
		@vchTransMake varchar(25)=null OUTPUT,
		@vchTransModel varchar(25)=null OUTPUT,
		@vchTransPart varchar(25)=null OUTPUT,
		@vchTransSerial varchar(25)=null OUTPUT,
		@vchEngineMake varchar(25)=null OUTPUT,
		@vchEngineModel varchar(25)=null OUTPUT,
		@vchEnginePart varchar(25)=null OUTPUT,
		@vchEngineSerial varchar(25)=null OUTPUT,
		@vchChasisMake varchar(25)=null OUTPUT,
		@vchChasisNumber varchar(25)=null OUTPUT,
		@vchFuelCode varchar(25)=null OUTPUT
	)
AS
	SELECT @vchEquipId=e.vchEquipId, @intYear=e.intYear, @vchType=et.vchName, @vchMake=ema.vchMakeName,
		@vchModel=emo.vchModelName, @vchDept=d.vchName, @vchLocation=loc.vchName,@vchAssignedTo=l.vchLastName+', '+l.vchFirstName,
		@vchVinSerial=e.vchVinSerial,@vchStatus=es.vchName,@vchPMSched=pm.vchName,@vchInspect=i.vchName,@intCurrentUnits=e.intCurrentUnits,
		@dtInService=e.dtInservice, @dtAquired=e.dtAquired, @vchPurOrgContact=e.vchPurOrgContact, @smPurAmount=e.smPurAmount, @intPurUnits=e.intPurUnits,@vchPurNotes=e.vchPurNotes,
		@dtOutOfService=e.dtOutOfService, @dtDisposed=e.dtDisposed, @vchDispOrgContact=e.vchDispOrgContact, @smDispAmount=e.smDispAmount, @intDispUnits=e.intDispUnits,@vchDispNotes=e.vchDispNotes, @vchDispMethod=edm.vchName,
		@vchTransMake=etmak.vchName,@vchTransModel=etm.vchName,@vchTransPart=e.TransPart,@vchTransSerial=e.TransSerial,
		@vchEngineMake=eemak.vchName,@vchEngineModel=eem.vchName,@vchEnginePart=e.EnginePart,@vchEngineSerial=e.EngineSerial,
		@vchChasisMake=echm.vchName, @vchChasisNumber=e.ChasisNumber,
		@vchFuelCode=e.vchFuelCode
	FROM Equipment e
	LEFT OUTER JOIN EquipTypes et ON et.OrgId=@OrgId AND et.Id=e.TypeId
	LEFT OUTER JOIN EquipMakes ema ON ema.OrgId=@OrgId AND ema.Id=e.MakeId
	LEFT OUTER JOIN EquipModels emo ON emo.OrgId=@OrgId AND emo.Id=e.ModelId
	LEFT OUTER JOIN EquipDisposalMethods edm ON edm.OrgId=@OrgId AND edm.Id=e.intDispMethod
	LEFT OUTER JOIN Departments d ON d.OrgId=@OrgId AND d.Id=e.DeptId
	LEFT OUTER JOIN Locations loc ON loc.OrgId=@OrgId AND loc.Id=e.LocId
	LEFT OUTER JOIN Logins l ON l.OrgId=@OrgId AND l.id=e.AssignedTo
	LEFT OUTER JOIN EquipStatus es ON es.id=e.StatusId
	LEFT OUTER JOIN PMSchedules pm ON pm.OrgId=@OrgId AND pm.id=e.PMSchedId
	LEFT OUTER JOIN Inspections i ON i.OrgId=@OrgId AND i.Id=e.InspectId
	LEFT OUTER JOIN EquipTransModels etm ON etm.OrgId=@OrgId AND etm.id=e.TransModelId
	LEFT OUTER JOIN EquipTransMakes etmak ON etmak.OrgId=@OrgId AND etmak.id=etm.MakeId
	LEFT OUTER JOIN EquipEngineModels eem ON eem.OrgId=@OrgId AND eem.id=e.EngineModelId
	LEFT OUTER JOIN EquipEngineMakes eemak ON eemak.OrgId=@OrgId AND eemak.id=eem.MakeId
	LEFT OUTER JOIN EquipChasisMakes echm ON echm.OrgId=@OrgId AND echm.Id = e.ChasisMakeId
	WHERE e.OrgId=@OrgId AND e.Id=@Id
	RETURN 
	
		


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

