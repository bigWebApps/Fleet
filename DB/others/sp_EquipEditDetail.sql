SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



ALTER    PROCEDURE sp_EquipEditDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int,
		@TypeId int OUTPUT,
		@MakeId int OUTPUT,
		@ModelId int OUTPUT,
		@vchEquipId varchar(25) OUTPUT,
		@intYear int OUTPUT,
		@DeptId int=null OUTPUT,
		@LocId int=null OUTPUT,
		@vchAssignedTo varchar(100)=null OUTPUT,
		@vchVinSerial varchar(50)=null OUTPUT,
		@vchFuelCode varchar(25)=null OUTPUT
	)
AS
	declare @tmpNameValue nvarchar(50)
	declare @tmpDataId int

	create table #Parameters (
		vchName varchar(50),
		vchNameValue varchar(50),
		intDataId int,
		vchValue sql_variant
		)

	IF @Action='S' -- select record
		BEGIN
			IF NOT EXISTS(SELECT 'true' FROM Equipment WHERE OrgId=@OrgId AND Id=@Id)
				RETURN -1
			ELSE
				BEGIN
					SELECT 	@Id=e.Id,
						@TypeId=e.TypeId,
						@DeptId=e.DeptId,
						@LocId=e.LocId, 
						@vchAssignedTo=l.vchLastName+', '+l.vchFirstName,
						@tmpDataId = e.DataId
					FROM Equipment e
					LEFT OUTER JOIN Logins l 
					ON l.OrgId=@OrgId AND l.id=e.AssignedTo
					WHERE e.OrgId=@OrgId AND e.Id=@Id

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
					
					select @ModelId = CONVERT(INT, vchValue)
					from #Parameters 
					where vchName = 'ModelId'
					
					select @MakeId = EMT.[MakeId]
					from EquipModelType EMT
					inner join EquipModels EM
					on EMT.[Id] = EM.TypeId
					and EM.[Id] = @ModelId
					
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
				
					RETURN @Id
				END
		END
		
	IF @Action='U' -- update or add
		BEGIN
			IF @Id = 0
				BEGIN -- add record
					INSERT INTO [EquipData]	([OrgId], 
								[dtCreated], 
								[dtUpdated], 
								[intSize], 
								[nvarchar1], 
								[nvarchar2], 
								[nvarchar3], 
								[int1], 
								[lookup1]
								)
					VALUES			(@OrgId, 
								(getutcdate()), 
								(getutcdate()), 
								0, 
								@vchEquipId, 
								@vchVinSerial, 
								@vchFuelCode, 
								@intYear, 
								@ModelId
								)

					
					select @tmpDataId = Scope_Identity()
					
					INSERT INTO [CustFieldDef](
								[OrgId], 
								[DataId], 
								[NumberColumn], 
								[vchName], 
								[vchNameText], 
								[vchNameLookupTable], 
								[btRequired], 
								[intFieldTypeId], 
								[vchDefault]
								)
					VALUES(
								@OrgId, 
								@tmpDataId, 
								1, 
								N'vchEquipId', 
								N'Equipment Id', 
								null, 
								0, 
								1, 
								N'N''''')
					
					INSERT INTO [CustFieldDef](
								[OrgId], 
								[DataId], 
								[NumberColumn], 
								[vchName], 
								[vchNameText], 
								[vchNameLookupTable], 
								[btRequired], 
								[intFieldTypeId], 
								[vchDefault]
								)
					VALUES(
								@OrgId, 
								@tmpDataId, 
								2, 
								N'vchVINSerial', 
								N'VIN/Serial #', 
								null, 
								0, 
								1, 
								N'N''''')
					
					INSERT INTO [CustFieldDef](
								[OrgId], 
								[DataId], 
								[NumberColumn], 
								[vchName], 
								[vchNameText], 
								[vchNameLookupTable], 
								[btRequired], 
								[intFieldTypeId], 
								[vchDefault]
								)
					VALUES(
								@OrgId, 
								@tmpDataId, 
								3, 
								N'vchFuelCode', 
								N'Fuel Code', 
								null, 
								0, 
								1, 
								N'N''''')
					
					INSERT INTO [CustFieldDef](
								[OrgId], 
								[DataId], 
								[NumberColumn], 
								[vchName], 
								[vchNameText], 
								[vchNameLookupTable], 
								[btRequired], 
								[intFieldTypeId], 
								[vchDefault]
								)
					VALUES(
								@OrgId, 
								@tmpDataId, 
								1, 
								N'ModelId', 
								N'Model', 
								N'EquipModels', 
								0, 
								8, 
								N'1')
					
					INSERT INTO [CustFieldDef](
								[OrgId], 
								[DataId], 
								[NumberColumn], 
								[vchName], 
								[vchNameText], 
								[vchNameLookupTable], 
								[btRequired], 
								[intFieldTypeId], 
								[vchDefault]
								)
					VALUES(
								@OrgId, 
								@tmpDataId, 
								1, 
								N'intYear', 
								N'Year', 
								null, 
								0, 
								2, 
								N'1980'
								)
					
					
					INSERT INTO Equipment (	OrgId, 
								TypeId, 
								DeptId, 
								LocId,
								DataId
								)
					VALUES (		@OrgId,
								@TypeId,
								@DeptId,
								@LocId,
								@tmpDataId
								)
											
					select @Id= Scope_Identity()
				END
			ELSE 
				BEGIN -- update record
					insert into #Parameters (vchName, vchNameValue, intDataId)
					select CFD.vchName, FT.vchName + CONVERT(NVARCHAR, CFD.NumberColumn), CFD.DataId
					from CustFieldDef CFD
					left join FieldTypes FT
					on FT.[Id] = CFD.intFieldTypeId
					inner join Equipment E 
					on CFD.DataId = E.[DataId]
					and E.OrgId=@OrgId 
					and E.[Id]=@Id

					select 	@tmpNameValue = vchNameValue,
						@tmpDataId = intDataId
					from 	#Parameters 
					where 	vchName = N'vchEquipId'
					
					exec('update EquipData set ' + @tmpNameValue + '=N''' + @vchEquipId + ''' where OrgId=' + @OrgId + ' and Id=' + @tmpDataId)
					
					select 	@tmpNameValue = vchNameValue,
						@tmpDataId = intDataId
					from 	#Parameters 
					where 	vchName = N'ModelId'
					
					exec('update EquipData set ' + @tmpNameValue + '=' + @ModelId + ' where OrgId=' + @OrgId + ' and Id=' + @tmpDataId)
					
					select 	@tmpNameValue = vchNameValue,
						@tmpDataId = intDataId
					from 	#Parameters 
					where 	vchName = N'intYear'
					
					exec('update EquipData set ' + @tmpNameValue + '=' + @intYear + ' where OrgId=' + @OrgId + ' and Id=' + @tmpDataId)
					
					select 	@tmpNameValue = vchNameValue,
						@tmpDataId = intDataId
					from 	#Parameters 
					where 	vchName = N'vchVINSerial'
					
					exec('update EquipData set ' + @tmpNameValue + '=N''' + @vchVinSerial + ''' where OrgId=' + @OrgId + ' and Id=' + @tmpDataId)
					
					select 	@tmpNameValue = vchNameValue,
						@tmpDataId = intDataId
					from 	#Parameters 
					where 	vchName = N'vchFuelCode'
					
					exec('update EquipData set ' + @tmpNameValue + '=N''' + @vchFuelCode + ''' where OrgId=' + @OrgId + ' and Id=' + @tmpDataId)

					UPDATE 	Equipment 
					SET 	OrgId=@OrgId,
						TypeId=@TypeId,
						DeptId=@DeptId,
						LocId=@LocId
					WHERE 	OrgId=@OrgId 
					AND 	[Id]=@Id

				END
		
			RETURN @Id
		END
	drop table #Parameters


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

