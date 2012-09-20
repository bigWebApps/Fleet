SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


ALTER PROCEDURE sp_EquipChasisDetail
	(
		@Action char(1),
		@UId int,
		@OrgId int,
		@Id int,
		@ChasisMakeId int=null OUTPUT,
		@vchChasisNumber varchar(25)=null OUTPUT,
		@vchChasisUpdatedBy varchar(100)=null OUTPUT,
		@dtChasisUpdated datetime=null OUTPUT
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
					if exists(select 'true' from EquipComponents EC inner join EquipComponentTypes ECT on EC.TypeId = ECT.[Id] and ECT.vchName = N'Chasis' and EC.EquipId = @Id and EC.OrgId = @OrgId and ECT.OrgId = @OrgId)
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
						and ECT.vchName = N'Chasis'
						
						select @tmpNameValue = vchNameValue 
						from #Parameters where vchName = N'ChasisMakeId'
						
						exec('update #Parameters set vchValue = ED.' + @tmpNameValue + ' from EquipData ED where ED.Id = intDataId and vchName = ''ChasisMakeId''')
						
						select @tmpNameValue = vchNameValue 
						from #Parameters where vchName = N'ChasisNumber'
						
						exec('update #Parameters set vchValue = ED.' + @tmpNameValue + ' from EquipData ED where ED.Id = intDataId and vchName = ''ChasisNumber''')
						
						select @tmpNameValue = vchNameValue 
						from #Parameters where vchName = N'ChasisdtUpdated'
						
						exec('update #Parameters set vchValue = ED.' + @tmpNameValue + ' from EquipData ED where ED.Id = intDataId and vchName = ''ChasisdtUpdated''')
						
						select @tmpNameValue = vchNameValue 
						from #Parameters where vchName = N'ChasisUpdatedBy'
						
						exec('update #Parameters set vchValue = l.vchLastName+'', ''+l.vchFirstName from EquipData ED LEFT OUTER JOIN Logins l ON l.Id=' +@tmpNameValue + ' WHERE ED.Id = intDataId and vchName = ''ChasisUpdatedBy''')
						
						select 	@ChasisMakeId = CONVERT(INT, vchValue)
						from #Parameters 
						where vchName = 'ChasisMakeId'
						
						select 	@vchChasisNumber = CONVERT(VARCHAR, vchValue)
						from #Parameters 
						where vchName = 'ChasisNumber'
						
						select 	@dtChasisUpdated = CONVERT(DATETIME, vchValue)
						from #Parameters 
						where vchName = 'ChasisdtUpdated'
						
						select 	@vchChasisUpdatedBy = CONVERT(VARCHAR, vchValue)
						from #Parameters 
						where vchName = 'ChasisUpdatedBy'
					end

					select EM.[Id], EM.vchMakeName as vchName
					from EquipModelType EMT
					inner join EquipComponentTypes ECT
					on EMT.btIsComponent = 1
					and EMT.intTypeId = ECT.[Id]
					and ECT.vchName = N'Chasis'
					inner join EquipMakes EM
					on EM.[Id] = EMT.MakeId
					and EM.OrgId=@OrgId
					order by EM.vchMakeName asc
					
					RETURN 0
				END
		END

	IF @Action='U'
		BEGIN
			if not exists(select 'true' from EquipComponents EC inner join EquipComponentTypes ECT on EC.TypeId = ECT.[Id] and ECT.vchName = N'Chasis' and EC.EquipId = @Id and EC.OrgId = @OrgId and ECT.OrgId = @OrgId)
			begin  -- insert
				
					INSERT INTO [EquipData]	([OrgId], 
								[dtCreated], 
								[dtUpdated], 
								[intSize], 
								[nvarchar1], 
								[lookup1],
								[lookup2],
								[datetime1]
								)
					VALUES			(@OrgId, 
								(getutcdate()), 
								(getutcdate()), 
								0, 
								@vchChasisNumber, 
								@ChasisMakeId,
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
								N'ChasisMakeId', 
								N'Chasis Make', 
								N'EquipMakes', 
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
								N'ChasisNumber', 
								N'Chasis #', 
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
								N'ChasisdtUpdated', 
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
								N'ChasisUpdatedBy', 
								N'', 
								N'Logins', 
								0, 
								8, 
								N'1'
								)

					select @tmpTypeId = [Id] 
					from EquipComponentTypes 
					where OrgId = @OrgId 
					and vchName = N'Chasis'

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
				and ECT.vchName = N'Chasis'
	
				select 	@tmpNameValue = vchNameValue,
					@tmpDataId = intDataId
				from 	#Parameters 
				where 	vchName = N'ChasisMakeId'
				
				exec('update EquipData set ' + @tmpNameValue + '=' + @ChasisMakeId + ' where OrgId=' + @OrgId + ' and Id=' + @tmpDataId)
				
				select 	@tmpNameValue = vchNameValue,
					@tmpDataId = intDataId
				from 	#Parameters 
				where 	vchName = N'ChasisNumber'
				
				exec('update EquipData set ' + @tmpNameValue + '=N''' + @vchChasisNumber + ''' where OrgId=' + @OrgId + ' and Id=' + @tmpDataId)
				
				
				select 	@tmpNameValue = vchNameValue,
					@tmpDataId = intDataId
				from 	#Parameters 
				where 	vchName = N'ChasisdtUpdated'
				
				exec('update EquipData set ' + @tmpNameValue + '=(getutcdate()) where OrgId=' + @OrgId + ' and Id=' + @tmpDataId)
				
				select 	@tmpNameValue = vchNameValue,
					@tmpDataId = intDataId
				from 	#Parameters 
				where 	vchName = N'ChasisUpdatedBy'
				
				exec('update EquipData set ' + @tmpNameValue + '=N''' + @UId + ''' where OrgId=' + @OrgId + ' and Id=' + @tmpDataId)
			end
			RETURN 0
		END

	drop table #Parameters



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

