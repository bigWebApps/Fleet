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

	declare @tmpNameValue nvarchar(50)
	declare @tmpDataId int

	begin tran
	
	create table #Parameters (
		vchName varchar(50),
		vchNameValue varchar(50),
		intDataId int,
		vchValue sql_variant
		)

	SELECT 	@vchType=et.vchName, 
		@vchDept=d.vchName, 
		@vchLocation=loc.vchName,
		@vchAssignedTo=l.vchLastName+', '+l.vchFirstName,
		@vchStatus=es.vchName,
		@vchPMSched=pm.vchName,
		@vchInspect=i.vchName,
		@intCurrentUnits=e.intCurrentUnits,
		@dtInService=e.dtInservice, 
		@dtAquired=e.dtAquired, 
		@vchPurOrgContact=e.vchPurOrgContact, 
		@smPurAmount=e.smPurAmount, 
		@intPurUnits=e.intPurUnits,
		@vchPurNotes=e.vchPurNotes,
		@dtOutOfService=e.dtOutOfService, 
		@dtDisposed=e.dtDisposed, 
		@vchDispOrgContact=e.vchDispOrgContact, 
		@smDispAmount=e.smDispAmount, 
		@intDispUnits=e.intDispUnits,
		@vchDispNotes=e.vchDispNotes, 
		@vchDispMethod=edm.vchName,
		@tmpDataId = e.DataId
	FROM Equipment e
	LEFT OUTER JOIN EquipTypes et ON et.OrgId=@OrgId AND et.Id=e.TypeId
	LEFT OUTER JOIN EquipDisposalMethods edm ON edm.OrgId=@OrgId AND edm.Id=e.intDispMethod
	LEFT OUTER JOIN Departments d ON d.OrgId=@OrgId AND d.Id=e.DeptId
	LEFT OUTER JOIN Locations loc ON loc.OrgId=@OrgId AND loc.Id=e.LocId
	LEFT OUTER JOIN Logins l ON l.OrgId=@OrgId AND l.id=e.AssignedTo
	LEFT OUTER JOIN EquipStatus es ON es.id=e.StatusId
	LEFT OUTER JOIN PMSchedules pm ON pm.OrgId=@OrgId AND pm.id=e.PMSchedId
	LEFT OUTER JOIN Inspections i ON i.OrgId=@OrgId AND i.Id=e.InspectId
	WHERE e.OrgId=@OrgId AND e.Id=@Id

-- getting a general information for Equip from EquipData 

	insert into #Parameters (vchName, vchNameValue, intDataId)
	select CFD.vchName, FT.vchName + CONVERT(NVARCHAR, CFD.NumberColumn), CFD.DataId
	from CustFieldDef CFD
	inner join FieldTypes FT
	on FT.[Id] = CFD.intFieldTypeId
	and CFD.DataId = @tmpDataId
	and CFD.OrgId = @OrgId

	select @tmpNameValue = vchNameValue 
	from #Parameters where vchName = N'vchEquipId'
				
	exec('update #Parameters set vchValue = ED.' + @tmpNameValue + ' from EquipData ED where ED.Id = intDataId and vchName = ''vchEquipId''')
					
	select @tmpNameValue = vchNameValue 
	from #Parameters where vchName = N'ModelId'
					
	exec('update #Parameters set vchValue = ED.' + @tmpNameValue + ' from EquipData ED where ED.Id = intDataId and vchName = ''ModelId''')
					
	select @tmpNameValue = vchNameValue 
	from #Parameters where vchName = N'intYear'
					
	exec('update #Parameters set vchValue = ED.' + @tmpNameValue + ' from EquipData ED where ED.Id = intDataId and vchName = ''intYear''')
					
	select @tmpNameValue = vchNameValue 
	from #Parameters where vchName = N'vchVINSerial'
					
	exec('update #Parameters set vchValue = ED.' + @tmpNameValue + ' from EquipData ED where ED.Id = intDataId and vchName = ''vchVINSerial''')
					
	select @tmpNameValue = vchNameValue 
	from #Parameters where vchName = N'vchFuelCode'
					
	exec('update #Parameters set vchValue = ED.' + @tmpNameValue + ' from EquipData ED where ED.Id = intDataId and vchName = ''vchFuelCode''')
					
	select  @vchMake = EMa.vchMakeName,
		@vchModel = EM.vchModelName 
	from EquipMakes EMa
	inner join EquipModelType EMT
	on EMa.[Id] = EMT.MakeId
	inner join EquipModels EM
	on EMT.[Id] = EM.TypeId
	inner join #Parameters P
	on EM.[Id] = CONVERT(INT, P.vchValue)
	and P.vchName = 'ModelId'
					
	select @vchEquipId = CONVERT(NVARCHAR, vchValue)
	from #Parameters 
	where vchName = 'vchEquipId'
					
	select @intYear = CONVERT(INT, vchValue)
	from #Parameters 
	where vchName = 'intYear'
					
	select @vchVinSerial = CONVERT(NVARCHAR, vchValue)
	from #Parameters 
	where vchName = 'vchVINSerial'
					
	select @vchFuelCode = CONVERT(NVARCHAR, vchValue)
	from #Parameters 
	where vchName = 'vchFuelCode'

-- getting a component's information for Equip from EquipData 

-- getting Engine info for the Equip

	delete from #Parameters
	insert into #Parameters (vchName, vchNameValue, intDataId)
	select CFD.vchName, FT.vchName + CONVERT(NVARCHAR, CFD.NumberColumn), CFD.DataId
	from CustFieldDef CFD
	inner join FieldTypes FT
	on FT.[Id] = CFD.intFieldTypeId
	inner join EquipComponents EC
	on CFD.[DataId] = EC.DataId
	inner join EquipComponentTypes ECT
	on EC.TypeId = ECT.[Id]
	and EC.EquipId = @Id
	and EC.OrgId = @OrgId
	and ECT.vchName = N'Engine'
					
	select @tmpNameValue = vchNameValue 
	from #Parameters where vchName = N'EngineModelId'
									
	exec('update #Parameters set vchValue = ED.' + @tmpNameValue + ' from EquipData ED where ED.Id = intDataId and vchName = ''EngineModelId''')
					
	select @tmpNameValue = vchNameValue 
	from #Parameters where vchName = N'EnginePart'
									
	exec('update #Parameters set vchValue = ED.' + @tmpNameValue + ' from EquipData ED where ED.Id = intDataId and vchName = ''EnginePart''')
					
	select @tmpNameValue = vchNameValue 
	from #Parameters where vchName = N'EngineSerial'
									
	exec('update #Parameters set vchValue = ED.' + @tmpNameValue + ' from EquipData ED where ED.Id = intDataId and vchName = ''EngineSerial''')

	select  @vchEngineMake = EMa.vchMakeName,
		@vchEngineModel = EM.vchModelName 
	from EquipMakes EMa
	inner join EquipModelType EMT
	on EMa.[Id] = EMT.MakeId
	inner join EquipModels EM
	on EMT.[Id] = EM.TypeId
	inner join #Parameters P
	on EM.[Id] = CONVERT(INT, P.vchValue)
	and P.vchName = 'EngineModelId'
					
	select @vchEnginePart = CONVERT(VARCHAR, vchValue)
	from #Parameters 
	where vchName = 'EnginePart'
					
	select @vchEngineSerial = CONVERT(VARCHAR, vchValue)
	from #Parameters 
	where vchName = 'EngineSerial'

-- getting Transmission info for the Equip

	delete from #Parameters
	insert into #Parameters (vchName, vchNameValue, intDataId)
	select CFD.vchName, FT.vchName + CONVERT(NVARCHAR, CFD.NumberColumn), CFD.DataId
	from CustFieldDef CFD
	inner join FieldTypes FT
	on FT.[Id] = CFD.intFieldTypeId
	inner join EquipComponents EC
	on CFD.[DataId] = EC.DataId
	inner join EquipComponentTypes ECT
	on EC.TypeId = ECT.[Id]
	and EC.EquipId = @Id
	and EC.OrgId = @OrgId
	and ECT.vchName = N'Transmission'
					
	select @tmpNameValue = vchNameValue 
	from #Parameters where vchName = N'TransModelId'
									
	exec('update #Parameters set vchValue = ED.' + @tmpNameValue + ' from EquipData ED where ED.Id = intDataId and vchName = ''TransModelId''')
					
	select @tmpNameValue = vchNameValue 
	from #Parameters where vchName = N'TransPart'
									
	exec('update #Parameters set vchValue = ED.' + @tmpNameValue + ' from EquipData ED where ED.Id = intDataId and vchName = ''TransPart''')
					
	select @tmpNameValue = vchNameValue 
	from #Parameters where vchName = N'TransSerial'
									
	exec('update #Parameters set vchValue = ED.' + @tmpNameValue + ' from EquipData ED where ED.Id = intDataId and vchName = ''TransSerial''')

	select  @vchTransMake = EMa.vchMakeName,
		@vchTransModel = EM.vchModelName 
	from EquipMakes EMa
	inner join EquipModelType EMT
	on EMa.[Id] = EMT.MakeId
	inner join EquipModels EM
	on EMT.[Id] = EM.TypeId
	inner join #Parameters P
	on EM.[Id] = CONVERT(INT, P.vchValue)
	and P.vchName = 'TransModelId'
										
	select @vchTransPart = CONVERT(VARCHAR, vchValue)
	from #Parameters 
	where vchName = 'TransPart'
					
	select @vchTransSerial = CONVERT(VARCHAR, vchValue)
	from #Parameters 
	where vchName = 'TransSerial'


-- getting Chasis info for the Equip

	delete from #Parameters
	insert into #Parameters (vchName, vchNameValue, intDataId)
	select CFD.vchName, FT.vchName + CONVERT(NVARCHAR, CFD.NumberColumn), CFD.DataId
	from CustFieldDef CFD
	inner join FieldTypes FT
	on FT.[Id] = CFD.intFieldTypeId
	inner join EquipComponents EC
	on CFD.[DataId] = EC.DataId
	inner join EquipComponentTypes ECT
	on EC.TypeId = ECT.[Id]
	and EC.EquipId = @Id
	and EC.OrgId = @OrgId
	and ECT.vchName = N'Chasis'
					
	select @tmpNameValue = vchNameValue 
	from #Parameters where vchName = N'ChasisMakeId'
					
	exec('update #Parameters set vchValue = ED.' + @tmpNameValue + ' from EquipData ED where ED.Id = intDataId and vchName = ''ChasisMakeId''')
					
	select @tmpNameValue = vchNameValue 
	from #Parameters where vchName = N'ChasisNumber'
					
	exec('update #Parameters set vchValue = ED.' + @tmpNameValue + ' from EquipData ED where ED.Id = intDataId and vchName = ''ChasisNumber''')
	
	select @vchChasisMake = EM.vchMakeName
	from #Parameters P
	inner join EquipMakes EM
	on EM.[Id] = CONVERT(INT, P.vchValue)
	and P.vchName = 'ChasisMakeId'
					
	select @vchChasisNumber = CONVERT(VARCHAR, vchValue)
	from #Parameters 
	where vchName = 'ChasisNumber'
					
	drop table #Parameters
	commit

	RETURN 
	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

