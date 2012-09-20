SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER  PROCEDURE sp_EquipEngineDetail
	(
		@Action char(1),
		@UId int,
		@OrgId int,
		@Id int,
		@MakeId int=null OUTPUT,
		@ModelId int=null OUTPUT,
		@vchPart varchar(25)=null OUTPUT,
		@vchSerial varchar(25)=null OUTPUT,
		@vchUpdatedBy varchar(100)=null OUTPUT,
		@dtUpdated datetime=null OUTPUT
	)
AS
	-- -1 = Record not found

	declare @tmpNameValue nvarchar(50)
	declare @tmpDataId int
	declare @tmpTypeId int

	create table #Parameters (
		vchName varchar(50),
		vchNameValue varchar(50),
		intDataId int,
		vchValue sql_variant
		)
	IF @Action='S'
		BEGIN
			IF NOT EXISTS(SELECT 'true' FROM Equipment WHERE OrgId=@OrgId AND Id=@Id)
				RETURN -1
			ELSE
				BEGIN
					if exists(select 'true' from EquipComponents EC inner join EquipComponentTypes ECT on EC.TypeId = ECT.[Id] and ECT.vchName = N'Engine' and EC.EquipId = @Id and EC.OrgId = @OrgId and ECT.OrgId = @OrgId)
					begin
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
						
						select @tmpNameValue = vchNameValue 
						from #Parameters where vchName = N'EnginedtUpdated'
										
						exec('update #Parameters set vchValue = ED.' + @tmpNameValue + ' from EquipData ED where ED.Id = intDataId and vchName = ''EnginedtUpdated''')
						
						select @tmpNameValue = vchNameValue 
						from #Parameters where vchName = N'EngineUpdatedBy'
										
						exec('update #Parameters set vchValue = ED.' + @tmpNameValue + ' from EquipData ED where ED.Id = intDataId and vchName = ''EngineUpdatedBy''')
											
						select @ModelId = CONVERT(INT, vchValue)
						from #Parameters 
						where vchName = 'EngineModelId'
						
						select @MakeId = EMT.[MakeId]
						from EquipModelType EMT
						inner join EquipModels EM
						on EMT.[Id] = EM.TypeId
						and EM.[Id] = @ModelId
						
						select @vchPart = CONVERT(VARCHAR, vchValue)
						from #Parameters 
						where vchName = 'EnginePart'
						
						select @vchSerial = CONVERT(VARCHAR, vchValue)
						from #Parameters 
						where vchName = 'EngineSerial'
						
						select @vchUpdatedBy = l.vchLastName+', '+l.vchFirstName
						from #Parameters P
						LEFT OUTER JOIN Logins l 
						ON l.OrgId=@OrgId AND l.[Id] = CONVERT(INT, P.vchValue)
						where vchName = 'EngineUpdatedBy'
						
						select @dtUpdated = CONVERT(DATETIME, vchValue)
						from #Parameters 
						where vchName = 'EnginedtUpdated'
					end
					
					select EM.[Id], EM.vchMakeName as vchName 
					from EquipModelType EMT
					inner join EquipComponentTypes ECT
					on EMT.btIsComponent = 1
					and EMT.intTypeId = ECT.[Id]
					and ECT.vchName = N'Engine'
					inner join EquipMakes EM
					on EM.[Id] = EMT.MakeId
					and EM.OrgId=@OrgId
					order by EM.vchMakeName asc
					
					select EM.[Id], EM.vchModelName as vchName, EMT.MakeId
					from EquipModels EM
					left join EquipModelType EMT
					on EM.TypeId = EMT.[Id]
					and EM.OrgId = @OrgId
					inner join EquipComponentTypes ECT
					on EMT.btIsComponent = 1
					and EMT.intTypeId = ECT.[Id]
					and ECT.vchName = N'Engine'
					order by vchModelName asc
					
					RETURN 0
				END
		END

	IF @Action='U'
		BEGIN
			if not exists(select 'true' from EquipComponents EC inner join EquipComponentTypes ECT on EC.TypeId = ECT.[Id] and ECT.vchName = N'Engine' and EC.EquipId = @Id and EC.OrgId = @OrgId and ECT.OrgId = @OrgId)
			begin -- insert

					INSERT INTO [EquipData]	([OrgId], 
								[dtCreated], 
								[dtUpdated], 
								[intSize], 
								[nvarchar1], 
								[nvarchar2], 
								[lookup1],
								[lookup2],
								[datetime1]
								)
					VALUES			(@OrgId, 
								(getutcdate()), 
								(getutcdate()), 
								0, 
								@vchPart, 
								@vchSerial,
								@ModelId,
								@UId,
								(getutcdate())
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
								N'EngineModelId', 
								N'Model', 
								N'EquipModel', 
								0, 
								8, 
								N'1'
								)

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
								N'EnginePart', 
								N'Part #', 
								null, 
								0, 
								1, 
								N'N'''''
								)

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
								N'EngineSerial', 
								N'Serial #', 
								null, 
								0, 
								1, 
								N'N'''''
								)

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
								N'EnginedtUpdated', 
								N'Last Update', 
								null, 
								0, 
								4, 
								N'(getutcdate())'
								)

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
								N'EngineUpdatedBy', 
								N'', 
								N'Logins', 
								0, 
								8, 
								N'1'
								)

					select @tmpTypeId = [Id] 
					from EquipComponentTypes 
					where OrgId = @OrgId 
					and vchName = N'Engine'

					INSERT INTO [EquipComponents](
								[OrgId], 
								[TypeId], 
								[EquipId], 
								[DataId], 
								[btActive]
								)
					VALUES(			
								@OrgId, 
								@tmpTypeId,
								@Id, 
								@tmpDataId, 
								1
								)
			end
			else
			begin -- update
	
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
				
				select 	@tmpNameValue = vchNameValue,
					@tmpDataId = intDataId
				from 	#Parameters 
				where 	vchName = N'EngineModelId'
				
				exec('update EquipData set ' + @tmpNameValue + '=' + @ModelId + ' where OrgId=' + @OrgId + ' and Id=' + @tmpDataId)
				
	
				select 	@tmpNameValue = vchNameValue,
					@tmpDataId = intDataId
				from 	#Parameters 
				where 	vchName = N'EnginePart'
				
				exec('update EquipData set ' + @tmpNameValue + '=N''' + @vchPart + ''' where OrgId=' + @OrgId + ' and Id=' + @tmpDataId)
	
				select 	@tmpNameValue = vchNameValue,
					@tmpDataId = intDataId
				from 	#Parameters 
				where 	vchName = N'EngineSerial'
				
				exec('update EquipData set ' + @tmpNameValue + '=N''' + @vchSerial + ''' where OrgId=' + @OrgId + ' and Id=' + @tmpDataId)
	
				select 	@tmpNameValue = vchNameValue,
					@tmpDataId = intDataId
				from 	#Parameters 
				where 	vchName = N'EnginedtUpdated'
				
				exec('update EquipData set ' + @tmpNameValue + '=(getutcdate()) where OrgId=' + @OrgId + ' and Id=' + @tmpDataId)
	
				select 	@tmpNameValue = vchNameValue,
					@tmpDataId = intDataId
				from 	#Parameters 
				where 	vchName = N'EngineUpdatedBy'
				
				exec('update EquipData set ' + @tmpNameValue + '=' + @UId + ' where OrgId=' + @OrgId + ' and Id=' + @tmpDataId)
			end
			RETURN 0
		END

	drop table #Parameters



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

