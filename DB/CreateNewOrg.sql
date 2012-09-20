SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO




ALTER   procedure dbo.sp_InitOrg
as
	set nocount on

	declare @OrgId int
	declare @dtCreated datetime
	declare @RC int

	select @OrgId = 0, @dtCreated = getdate()
	
	-- Step 1. Organization Information
	begin transaction
	
		insert into [Orgs](
			[intBWAId], 
			[vchName], 
			[btActive], 
			[dtCreated], 
			[dtCurrentDate], 
			[vchLogo], 
			[btPrint], 
			[vchFullName], 
			[vchAddress1], 
			[vchAddress2], 
			[vchCity], 
			[vchProvince], 
			[vchPostalCode], 
			[vchPhone], 
			[vchPhone2], 
			[vchFax], 
			[vchAcctNumber], 
			[vchContactName], 
			[vchNotes], 
			[vchWeb], 
			[vchEmail]
			)
		values(	1,
			'Demo County', 
			1, 
			@dtCreated, 
			@dtCreated,
			'DemoInc_45px.gif', 
			0, 
			'Demo County Department Of Education', 
			'222 Street Ave', 
			'', 
			'Atlanta', 
			'GA', 
			'30303', 
			'555-555-1212', 
			'', 
			'', 
			'', 
			'Patrick Clements', 
			'', 
			'http://login.bigfleetsystem.com', 
			'' 
			)
		select @OrgId = scope_identity()
	
	if @@Error <> 0
	begin
		rollback transaction
		print 'Step 1. An error occurred loading the new organization'
		return (99)
	end
	else
	begin
		commit transaction
		print 'Step 1. A new organization has been added to database'
	end
	
	-- Step 2. Equipment Types
	begin transaction
	
		insert into [EquipTypes]([OrgId], [vchName], [InspectId], [UnitMeasureId])
		select @OrgId, 'Bus', null, 1
		union all
		select @OrgId, 'Van', null, 3
		union all 
		select @OrgId, 'Truck', null, 2
	
	if @@Error <> 0
	begin
		rollback transaction
		print 'Step 2. An error occurred loading the new types of equipments'
		return (99)
	end
	else
	begin
		commit transaction
		print 'Step 2. The new equipment types has been added to database'
	end

	-- Step 3. Equipment (Component) Makers Names being used in your company
	begin transaction

		insert into [EquipMakes]([OrgId], [vchMakeName])
		select @OrgId, 'All America'
		union all 
		select @OrgId, 'International'
		union all 
		select @OrgId, 'CAT'
		union all 
		select @OrgId, 'ALLISION'
		union all 
		select @OrgId, 'Ford'
		union all 
		select @OrgId, 'Chevrolet'
		union all 
		select @OrgId, 'CUM'
		union all 
		select @OrgId, 'DT'
		union all 
		select @OrgId, 'ALLAMER'
	
	if @@Error <> 0
	begin
		rollback transaction
		print 'Step 3. An error occurred loading the makers names'
		return (99)
	end
	else
	begin
		commit transaction
		print 'Step 3. The new makers names has been added to database'
	end

	-- Step 4. Models Names for different Types and Makers of Equipments
	begin transaction

		-- 1.
		insert into [EquipModelType]([OrgId], [MakeId], [btIsComponent], [intTypeId])
		select @OrgId, EM.[Id], 0, ET.[Id]
		from EquipMakes as EM, EquipTypes as ET
		where EM.OrgId = @OrgId and vchMakeName = 'All America'
		and ET.OrgId = @OrgId and ET.vchName = 'Bus'
	
		select @RC = scope_identity()
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, 'BUS')
	
		-- 2.
		insert into [EquipModelType]([OrgId], [MakeId], [btIsComponent], [intTypeId])
		select @OrgId, EM.[Id], 0, ET.[Id]
		from EquipMakes as EM, EquipTypes as ET
		where EM.OrgId = @OrgId and vchMakeName = 'International'
		and ET.OrgId = @OrgId and ET.vchName = 'Bus'
	
		select @RC = scope_identity()
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, 'BUS')
	
		-- 3.
		insert into [EquipModelType]([OrgId], [MakeId], [btIsComponent], [intTypeId])
		select @OrgId, EM.[Id], 0, ET.[Id]
		from EquipMakes as EM, EquipTypes as ET
		where EM.OrgId = @OrgId and vchMakeName = 'Ford'
		and ET.OrgId = @OrgId and ET.vchName = 'Bus'
	
		select @RC = scope_identity()
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, 'Ranger')
	
		-- 4.
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, 'Astro')
	
		-- 5.
		insert into [EquipModelType]([OrgId], [MakeId], [btIsComponent], [intTypeId])
		select @OrgId, EM.[Id], 0, ET.[Id]
		from EquipMakes as EM, EquipTypes as ET
		where EM.OrgId = @OrgId and vchMakeName = 'Ford'
		and ET.OrgId = @OrgId and ET.vchName = 'Van'
	
		select @RC = scope_identity()
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, 'Van')
	
		-- 6.
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, 'F350')
	
		-- 7.
		insert into [EquipModelType]([OrgId], [MakeId], [btIsComponent], [intTypeId])
		select @OrgId, EM.[Id], 0, ET.[Id]
		from EquipMakes as EM, EquipTypes as ET
		where EM.OrgId = @OrgId and vchMakeName = 'Chevrolet'
		and ET.OrgId = @OrgId and ET.vchName = 'Van'
	
		select @RC = scope_identity()
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, 'Van')
	
		-- 8.
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, 'Step Van')
	
		-- 9.
		insert into [EquipModelType]([OrgId], [MakeId], [btIsComponent], [intTypeId])
		select @OrgId, EM.[Id], 0, ET.[Id]
		from EquipMakes as EM, EquipTypes as ET
		where EM.OrgId = @OrgId and vchMakeName = 'Ford'
		and ET.OrgId = @OrgId and ET.vchName = 'Truck'
	
		select @RC = scope_identity()
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, 'Truck')
	
		-- 10.
		insert into [EquipModelType]([OrgId], [MakeId], [btIsComponent], [intTypeId])
		select @OrgId, EM.[Id], 0, ET.[Id]
		from EquipMakes as EM, EquipTypes as ET
		where EM.OrgId = @OrgId and vchMakeName = 'Chevrolet'
		and ET.OrgId = @OrgId and ET.vchName = 'Truck'
	
		select @RC = scope_identity()
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, 'Astro')
	
	if @@Error <> 0
	begin
		rollback transaction
		print 'Step 4. An error occurred loading the Models names'
		return (99)
	end
	else
	begin
		commit transaction
		print 'Step 4. The new Models names has been added to database'
	end

	-- Step 5. Equipment Departments, Locations, Disposal Methods
	begin transaction

		insert into [Departments]([OrgId], [vchName])
		values(@OrgId, 'Transportation')

		insert into [Locations]([OrgId], [vchName])
		values(@OrgId, 'Default')

		insert into [EquipDisposalMethods]([OrgId], [vchName], [btActive])
		select @OrgId, 'Sold', 1
		union all
		select @OrgId, 'Salvaged', 1
		union all
		select @OrgId, 'Auctioned', 1
	
	if @@Error <> 0
	begin
		rollback transaction
		print 'Step 5. An error occurred loading the Departments, Locations, Disposal Methods.'
		return (99)
	end
	else
	begin
		commit transaction
		print 'Step 5. New Departments (Locations, Disposal Methods) has been added to database'
	end

	-- Step 6. Additional Custom Fields of Equipments
	begin transaction

		insert into [CustFieldDef](
			[OrgId], 
			[DataTypeId], 
			[ComponentTypeId], 
			[NumberColumn], 
			[vchName], 
			[vchNameText], 
			[vchNameLookupTable], 
			[vchNameFieldLookup], 
			[btRequired], 
			[intFieldTypeId], 
			[vchDefault], 
			[vchHelp]
			)
		select	@OrgId,
			DT.[Id], 
			ET.[Id], 
			1, 
			'vchCondition', 
			'Condition', 
			null, 
			null, 
			0, 
			1, 
			'N''''', 
			'Bus Condition, e.g.: EXCELLENT, GOOD, FAIR, POOR.'
		from 	DataTypes as DT, EquipTypes as ET
		where 	DT.vchName = 'Equipment'
		and	ET.OrgId = @OrgId and ET.vchName = 'Bus'
		union all
		select	@OrgId,
			DT.[Id], 
			ET.[Id], 
			1, 
			'dmCost', 
			'Cost', 
			null, 
			null, 
			0, 
			3, 
			'0.0', 
			'Bus Cost'
		from 	DataTypes as DT, EquipTypes as ET
		where 	DT.vchName = 'Equipment'
		and	ET.OrgId = @OrgId and ET.vchName = 'Bus'
		union all
		select	@OrgId,
			DT.[Id], 
			ET.[Id], 
			2, 
			'vchColor', 
			'Color', 
			null, 
			null, 
			0, 
			1, 
			'N''''', 
			'Bus Color'
		from 	DataTypes as DT, EquipTypes as ET
		where 	DT.vchName = 'Equipment'
		and	ET.OrgId = @OrgId and ET.vchName = 'Bus'
		union all
		select	@OrgId,
			DT.[Id], 
			ET.[Id], 
			1, 
			'intPassengers', 
			'Passengers', 
			null, 
			null, 
			0, 
			2, 
			'0', 
			'Amount of passengers seats at the Bus'
		from 	DataTypes as DT, EquipTypes as ET
		where 	DT.vchName = 'Equipment'
		and	ET.OrgId = @OrgId and ET.vchName = 'Bus'
		union all
		select	@OrgId,
			DT.[Id], 
			ET.[Id], 
			1, 
			'vchColor', 
			'Color', 
			null, 
			null, 
			0, 
			1, 
			'N''''', 
			'Van Color'
		from 	DataTypes as DT, EquipTypes as ET
		where 	DT.vchName = 'Equipment'
		and	ET.OrgId = @OrgId and ET.vchName = 'Van'
		union all
		select	@OrgId,
			DT.[Id], 
			ET.[Id], 
			2, 
			'vchNote', 
			'Note', 
			null, 
			null, 
			0, 
			1, 
			'N''''', 
			''
		from 	DataTypes as DT, EquipTypes as ET
		where 	DT.vchName = 'Equipment'
		and	ET.OrgId = @OrgId and ET.vchName = 'Van'
		union all
		select	@OrgId,
			DT.[Id], 
			ET.[Id], 
			1, 
			'vchColor', 
			'Color', 
			null, 
			null, 
			0, 
			1, 
			'N''''', 
			'Truck Color'
		from 	DataTypes as DT, EquipTypes as ET
		where 	DT.vchName = 'Equipment'
		and	ET.OrgId = @OrgId and ET.vchName = 'Truck'
		union all
		select	@OrgId,
			DT.[Id], 
			ET.[Id], 
			2, 
			'vchNote', 
			'Note', 
			null, 
			null, 
			0, 
			1, 
			'N''''', 
			''
		from 	DataTypes as DT, EquipTypes as ET
		where 	DT.vchName = 'Equipment'
		and	ET.OrgId = @OrgId and ET.vchName = 'Truck'

	if @@Error <> 0
	begin
		rollback transaction
		print 'Step 6. An error occurred loading the Custom Fields for the Equipments.'
		return (99)
	end
	else
	begin
		commit transaction
		print 'Step 6. Custom Fields for the new equipment types have been added to database'
	end

	-- Step 7. Equipment Components, Defaults
	begin transaction

		insert into [EquipComponentTypes]([OrgId], [vchName])
		select @OrgId, 'Engine'
		union all
		select @Orgid, 'Transmission'
		union all
		select @Orgid, 'Chassis'

		insert into [EquipComponentDefault](
			[OrgId], 
			[ComponentTypeId], 
			[EquipmentTypeId]
			)
		select 	@OrgId,
			ECT.[Id],
			ET.[Id]
		from EquipTypes as ET, EquipComponentTypes as ECT
		where ET.OrgId = @OrgId and ET.vchName = 'Bus'
		and ECT.OrgId = @OrgId and ECT.vchName = 'Engine'
		union all
		select 	@OrgId,
			ECT.[Id],
			ET.[Id]
		from EquipTypes as ET, EquipComponentTypes as ECT
		where ET.OrgId = @OrgId and ET.vchName = 'Bus'
		and ECT.OrgId = @OrgId and ECT.vchName = 'Transmission'
		union all
		select 	@OrgId,
			ECT.[Id],
			ET.[Id]
		from EquipTypes as ET, EquipComponentTypes as ECT
		where ET.OrgId = @OrgId and ET.vchName = 'Bus'
		and ECT.OrgId = @OrgId and ECT.vchName = 'Chassis'
		union all
		select 	@OrgId,
			ECT.[Id],
			ET.[Id]
		from EquipTypes as ET, EquipComponentTypes as ECT
		where ET.OrgId = @OrgId and ET.vchName = 'Van'
		and ECT.OrgId = @OrgId and ECT.vchName = 'Engine'
		union all
		select 	@OrgId,
			ECT.[Id],
			ET.[Id]
		from EquipTypes as ET, EquipComponentTypes as ECT
		where ET.OrgId = @OrgId and ET.vchName = 'Van'
		and ECT.OrgId = @OrgId and ECT.vchName = 'Transmission'
		union all
		select 	@OrgId,
			ECT.[Id],
			ET.[Id]
		from EquipTypes as ET, EquipComponentTypes as ECT
		where ET.OrgId = @OrgId and ET.vchName = 'Truck'
		and ECT.OrgId = @OrgId and ECT.vchName = 'Transmission'

	if @@Error <> 0
	begin
		rollback transaction
		print 'Step 7. An error occurred loading the Equipment Components.'
		return (99)
	end
	else
	begin
		commit transaction
		print 'Step 7. Equipment Components have been added to database'
	end

	-- Step 8. Components Fields
	begin transaction

		insert into [CustFieldDef](
			[OrgId], 
			[DataTypeId], 
			[ComponentTypeId], 
			[NumberColumn], 
			[vchName], 
			[vchNameText], 
			[vchNameLookupTable], 
			[vchNameFieldLookup], 
			[btRequired], 
			[intFieldTypeId], 
			[vchDefault], 
			[vchHelp]
			)
		select	@OrgId,
			DT.[Id], 
			ET.[Id], 
			1, 
			'EngineModelId', 
			'Model', 
			'EquipModels', 
			'vchModelName', 
			0, 
			8, 
			'0', 
			''
		from 	DataTypes as DT, EquipComponentTypes as ET
		where 	DT.vchName = 'Component'
		and	ET.OrgId = @OrgId and ET.vchName = 'Engine'
		union all
		select	@OrgId,
			DT.[Id], 
			ET.[Id], 
			1, 
			'vchPart', 
			'Part #', 
			null, 
			null, 
			0, 
			1, 
			'N''''', 
			''
		from 	DataTypes as DT, EquipComponentTypes as ET
		where 	DT.vchName = 'Component'
		and	ET.OrgId = @OrgId and ET.vchName = 'Engine'
		union all
		select	@OrgId,
			DT.[Id], 
			ET.[Id], 
			2, 
			'vchSerial', 
			'Serial #', 
			null, 
			null, 
			0, 
			1, 
			'N''''', 
			'Serial number'
		from 	DataTypes as DT, EquipComponentTypes as ET
		where 	DT.vchName = 'Component'
		and	ET.OrgId = @OrgId and ET.vchName = 'Engine'
		union all
		select	@OrgId,
			DT.[Id], 
			ET.[Id], 
			1, 
			'TransModelId', 
			'Model', 
			'EquipModels', 
			'vchModelName', 
			0, 
			8, 
			'0', 
			''
		from 	DataTypes as DT, EquipComponentTypes as ET
		where 	DT.vchName = 'Component'
		and	ET.OrgId = @OrgId and ET.vchName = 'Transmission'
		union all
		select	@OrgId,
			DT.[Id], 
			ET.[Id], 
			1, 
			'vchPart', 
			'Part #', 
			null, 
			null, 
			0, 
			1, 
			'N''''', 
			''
		from 	DataTypes as DT, EquipComponentTypes as ET
		where 	DT.vchName = 'Component'
		and	ET.OrgId = @OrgId and ET.vchName = 'Transmission'
		union all
		select	@OrgId,
			DT.[Id], 
			ET.[Id], 
			2, 
			'vchSerial', 
			'Serial #', 
			null, 
			null, 
			0, 
			1, 
			'N''''', 
			'Serial number'
		from 	DataTypes as DT, EquipComponentTypes as ET
		where 	DT.vchName = 'Component'
		and	ET.OrgId = @OrgId and ET.vchName = 'Transmission'
		union all
		select	@OrgId,
			DT.[Id], 
			ET.[Id], 
			1, 
			'ChasisModelId', 
			'Model', 
			'EquipModels', 
			'vchModelName', 
			0, 
			8, 
			'0', 
			''
		from 	DataTypes as DT, EquipComponentTypes as ET
		where 	DT.vchName = 'Component'
		and	ET.OrgId = @OrgId and ET.vchName = 'Chassis'
		union all
		select	@OrgId,
			DT.[Id], 
			ET.[Id], 
			1, 
			'vchChassis', 
			'Chassis #', 
			null, 
			null, 
			0, 
			1, 
			'N''''', 
			''
		from 	DataTypes as DT, EquipComponentTypes as ET
		where 	DT.vchName = 'Component'
		and	ET.OrgId = @OrgId and ET.vchName = 'Chassis'

	if @@Error <> 0
	begin
		rollback transaction
		print 'Step 8. An error occurred loading the Equipment Components Fields.'
		return (99)
	end
	else
	begin
		commit transaction
		print 'Step 8. Equipment Components Fields have been added to database'
	end

	-- Step 9. Models Names for different Types and Makers of Components
	begin transaction

		-- 1.
		insert into [EquipModelType]([OrgId], [MakeId], [btIsComponent], [intTypeId])
		select @OrgId, EM.[Id], 1, ET.[Id]
		from EquipMakes as EM, EquipComponentTypes as ET
		where EM.OrgId = @OrgId and vchMakeName = 'All America'
		and ET.OrgId = @OrgId and ET.vchName = 'Engine'
	
		select @RC = scope_identity()
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, 'Engine')

		-- 2.
		insert into [EquipModelType]([OrgId], [MakeId], [btIsComponent], [intTypeId])
		select @OrgId, EM.[Id], 1, ET.[Id]
		from EquipMakes as EM, EquipComponentTypes as ET
		where EM.OrgId = @OrgId and vchMakeName = 'International'
		and ET.OrgId = @OrgId and ET.vchName = 'Engine'
	
		select @RC = scope_identity()
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, 'Engine')

		-- 3.
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, '360')

		-- 4.
		insert into [EquipModelType]([OrgId], [MakeId], [btIsComponent], [intTypeId])
		select @OrgId, EM.[Id], 1, ET.[Id]
		from EquipMakes as EM, EquipComponentTypes as ET
		where EM.OrgId = @OrgId and vchMakeName = 'CAT'
		and ET.OrgId = @OrgId and ET.vchName = 'Engine'
	
		select @RC = scope_identity()
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, '3208')

		-- 5.
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, 'C.7')

		-- 6.
		insert into [EquipModelType]([OrgId], [MakeId], [btIsComponent], [intTypeId])
		select @OrgId, EM.[Id], 1, ET.[Id]
		from EquipMakes as EM, EquipComponentTypes as ET
		where EM.OrgId = @OrgId and vchMakeName = 'Ford'
		and ET.OrgId = @OrgId and ET.vchName = 'Engine'
	
		select @RC = scope_identity()
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, 'Engine')

		-- 7.
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, 'Motor')

		-- 8.
		insert into [EquipModelType]([OrgId], [MakeId], [btIsComponent], [intTypeId])
		select @OrgId, EM.[Id], 1, ET.[Id]
		from EquipMakes as EM, EquipComponentTypes as ET
		where EM.OrgId = @OrgId and vchMakeName = 'CUM'
		and ET.OrgId = @OrgId and ET.vchName = 'Engine'
	
		select @RC = scope_identity()
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, '8.3')

		-- 9.
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, '5.9')

		-- 10.
		insert into [EquipModelType]([OrgId], [MakeId], [btIsComponent], [intTypeId])
		select @OrgId, EM.[Id], 1, ET.[Id]
		from EquipMakes as EM, EquipComponentTypes as ET
		where EM.OrgId = @OrgId and vchMakeName = 'DT'
		and ET.OrgId = @OrgId and ET.vchName = 'Engine'
	
		select @RC = scope_identity()
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, '466')

		-- 11.
		insert into [EquipModelType]([OrgId], [MakeId], [btIsComponent], [intTypeId])
		select @OrgId, EM.[Id], 1, ET.[Id]
		from EquipMakes as EM, EquipComponentTypes as ET
		where EM.OrgId = @OrgId and vchMakeName = 'All America'
		and ET.OrgId = @OrgId and ET.vchName = 'Transmission'
	
		select @RC = scope_identity()
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, 'Transmission')

		-- 12.
		insert into [EquipModelType]([OrgId], [MakeId], [btIsComponent], [intTypeId])
		select @OrgId, EM.[Id], 1, ET.[Id]
		from EquipMakes as EM, EquipComponentTypes as ET
		where EM.OrgId = @OrgId and vchMakeName = 'International'
		and ET.OrgId = @OrgId and ET.vchName = 'Transmission'
	
		select @RC = scope_identity()
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, 'Transmission')

		-- 13.
		insert into [EquipModelType]([OrgId], [MakeId], [btIsComponent], [intTypeId])
		select @OrgId, EM.[Id], 1, ET.[Id]
		from EquipMakes as EM, EquipComponentTypes as ET
		where EM.OrgId = @OrgId and vchMakeName = 'ALLISION'
		and ET.OrgId = @OrgId and ET.vchName = 'Transmission'
	
		select @RC = scope_identity()
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, '643')

		-- 14.
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, '545')

		-- 15.
		insert into [EquipModelType]([OrgId], [MakeId], [btIsComponent], [intTypeId])
		select @OrgId, EM.[Id], 1, ET.[Id]
		from EquipMakes as EM, EquipComponentTypes as ET
		where EM.OrgId = @OrgId and vchMakeName = 'Ford'
		and ET.OrgId = @OrgId and ET.vchName = 'Transmission'
	
		select @RC = scope_identity()
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, 'Transmission')

		-- 16.
		insert into [EquipModelType]([OrgId], [MakeId], [btIsComponent], [intTypeId])
		select @OrgId, EM.[Id], 1, ET.[Id]
		from EquipMakes as EM, EquipComponentTypes as ET
		where EM.OrgId = @OrgId and vchMakeName = 'ALLAMER'
		and ET.OrgId = @OrgId and ET.vchName = 'Transmission'
	
		select @RC = scope_identity()
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, '545COM')

		-- 17.
		insert into [EquipModelType]([OrgId], [MakeId], [btIsComponent], [intTypeId])
		select @OrgId, EM.[Id], 1, ET.[Id]
		from EquipMakes as EM, EquipComponentTypes as ET
		where EM.OrgId = @OrgId and vchMakeName = 'All America'
		and ET.OrgId = @OrgId and ET.vchName = 'Chassis'
	
		select @RC = scope_identity()
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, 'Chassis')

		-- 18.
		insert into [EquipModelType]([OrgId], [MakeId], [btIsComponent], [intTypeId])
		select @OrgId, EM.[Id], 1, ET.[Id]
		from EquipMakes as EM, EquipComponentTypes as ET
		where EM.OrgId = @OrgId and vchMakeName = 'International'
		and ET.OrgId = @OrgId and ET.vchName = 'Chassis'
	
		select @RC = scope_identity()
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, 'Chassis')

		-- 18.
		insert into [EquipModelType]([OrgId], [MakeId], [btIsComponent], [intTypeId])
		select @OrgId, EM.[Id], 1, ET.[Id]
		from EquipMakes as EM, EquipComponentTypes as ET
		where EM.OrgId = @OrgId and vchMakeName = 'Ford'
		and ET.OrgId = @OrgId and ET.vchName = 'Chassis'
	
		select @RC = scope_identity()
	
		insert into [EquipModels]([OrgId], [TypeId], [vchModelName])
		values(@OrgId, @RC, 'Chassis')


	if @@Error <> 0
	begin
		rollback transaction
		print 'Step 9. An error occurred loading the Models Names for Components.'
		return (99)
	end
	else
	begin
		commit transaction
		print 'Step 9.  Models Names for Components have been added to database'
	end

	-- Step 10. Repair Categories/Items
	begin transaction

		insert into [RepairCats]([OrgId], [vchName], [vchDesc])
		select @OrgId, 'Brakes', ''
		union all
		select @OrgId, 'Steering', ''
		union all
		select @OrgId, 'Engine', 'Engine,Battery,Radiator,Belts,Heater,Exhaust'
		union all
		select @OrgId, 'Lights/Instruments/Elec', 'Lights,Fuses,Bulbs,Horn,Alternator'
		union all
		select @OrgId, 'Transmisson', ''
		union all
		select @OrgId, 'Tires', ''
		union all
		select @OrgId, 'Body', 'Wipers,Doors,Glass,Seats,Stop Arms,Mirrors'
		union all 
		select @OrgId, 'Other', 'Bus Supplies'
	
		insert into [RepairItems]([OrgId], [CatId], [vchDesc])
		select @OrgId, RC.[Id], 'Drums'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Brakes'
		union all
		select @OrgId, RC.[Id], 'Valves'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Brakes'
		union all
		select @OrgId, RC.[Id], 'Brake Fluid'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Brakes'
		union all
		select @OrgId, RC.[Id], 'Power Steering'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Steering'
		union all
		select @OrgId, RC.[Id], 'Coolant Filter'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Starter'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Radiator'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Thermostat'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Heater'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Anti-Freeze'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Battery Cable'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Air Filter'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Alternator'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Fuel Filter'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Water Pump'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Fan Belts'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Oil'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Oil Filter'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Switches'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Lights/Instruments/Elec'
		union all
		select @OrgId, RC.[Id], 'Lights'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Lights/Instruments/Elec'
		union all
		select @OrgId, RC.[Id], 'Horn'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Lights/Instruments/Elec'
		union all
		select @OrgId, RC.[Id], 'Transmisson'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Transmisson'
		union all
		select @OrgId, RC.[Id], 'Tran Fluid'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Transmisson'
		union all
		select @OrgId, RC.[Id], 'Tires'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Tires'
		union all
		select @OrgId, RC.[Id], 'Body'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Body'
		union all
		select @OrgId, RC.[Id], 'Other'
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Other'

	if @@Error <> 0
	begin
		rollback transaction
		print 'Step 10. An error occurred loading the Repair Categories/Items.'
		return (99)
	end
	else
	begin
		commit transaction
		print 'Step 10. Repair Categories/Items have been added to database'
	end

	-- 11. Schedules of Preventive Maintenances
	begin transaction

		insert into [PMSchedules]([OrgId], [vchName])
		select @OrgId, 'Bus Normal PM List'
		union all
		select @OrgId, 'Bus Extended PM List'
		union all
		select @OrgId, 'Truck Normal PM List'
		union all
		select @OrgId, 'Fork Lift Normal PM List'
	
	if @@Error <> 0
	begin
		rollback transaction
		print 'Step 11. An error occurred loading the PM Schedules.'
		return (99)
	end
	else
	begin
		commit transaction
		print 'Step 11.  PM Schedules have been added to database'
	end

	-- 12. PM Items
	begin transaction

		insert into [PMServices]([OrgId], [RepairCatId], [vchDesc], [btRequiresRepair])
		select @OrgId, RC.[Id], 'Adjust Valve Clearance', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Brakes'
		union all
		select @OrgId, RC.[Id], 'Air Conditioner Compressor', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Air Filter', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Alignment', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Alternator', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Lights/Instruments/Elec'
		union all
		select @OrgId, RC.[Id], 'Brake Drum Shoe', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Brakes'
		union all
		select @OrgId, RC.[Id], 'Transmission Service', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Transmisson'
		union all
		select @OrgId, RC.[Id], 'Oil/Filter Service', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Brake Fluid', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Brakes'
		union all
		select @OrgId, RC.[Id], 'Brake Shoes', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Brakes'
		union all
		select @OrgId, RC.[Id], 'Cap, Rotor, & Wire', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Catalytic Converter', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Change Windshield Wipers', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Body'
		union all
		select @OrgId, RC.[Id], 'Clean Fuel Injectors/Carburetor', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Clutch Cylinder', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Control Arm Lower Ball Joint', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Lights/Instruments/Elec'
		union all
		select @OrgId, RC.[Id], 'Cooling System Flush', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Disc Brake Calipers', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Brakes'
		union all
		select @OrgId, RC.[Id], 'Drum Brake Cylinders', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Brakes'
		union all
		select @OrgId, RC.[Id], 'Drum Brake Shoes', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Brakes'
		union all
		select @OrgId, RC.[Id], 'Engine Belts', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Engine Tune Up', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Exhaust Pipes', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Fuel Filter', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Fuel Injectors', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Fuel Pump', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Heater Core', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'PCV Valve', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Power Steering Pump', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Steering'
		union all
		select @OrgId, RC.[Id], 'Radiator', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Radiator Hoses', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Engine'
		union all
		select @OrgId, RC.[Id], 'Recharge A/C', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Lights/Instruments/Elec'
		union all
		select @OrgId, RC.[Id], 'Replace Brakes', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Brakes'
		union all
		select @OrgId, RC.[Id], 'Replace Parking Light', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Lights/Instruments/Elec'
		union all
		select @OrgId, RC.[Id], 'Rotate Tires', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Tires'
		union all
		select @OrgId, RC.[Id], 'Shock Absorbers', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Transmisson'
		union all
		select @OrgId, RC.[Id], 'Spark Plugs', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Lights/Instruments/Elec'
		union all
		select @OrgId, RC.[Id], 'Springs', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Transmisson'
		union all
		select @OrgId, RC.[Id], 'Starter', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Lights/Instruments/Elec'
		union all
		select @OrgId, RC.[Id], 'Strutts', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Transmisson'
		union all
		select @OrgId, RC.[Id], 'Thermostat', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Lights/Instruments/Elec'
		union all
		select @OrgId, RC.[Id], 'Tie Rods', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Steering'
		union all
		select @OrgId, RC.[Id], 'Timing Belt', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Lights/Instruments/Elec'
		union all
		select @OrgId, RC.[Id], 'Timing Chain', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Lights/Instruments/Elec'
		union all
		select @OrgId, RC.[Id], 'Tires and Balance', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Tires'
		union all
		select @OrgId, RC.[Id], 'Transmission Filter', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Transmisson'
		union all
		select @OrgId, RC.[Id], 'Universal CV Joint', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Transmisson'
		union all
		select @OrgId, RC.[Id], 'Water Pump', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Body'
		union all
		select @OrgId, RC.[Id], 'Wheel Alignment', 0
		from RepairCats RC
		where RC.OrgId = @OrgId and RC.vchName = 'Transmisson'

		
		insert into [PMSchedDetails](
			[OrgId], 
			[PMSchedId], 
			[PMServiceId], 
			[UnitMeasureId], 
			[intDays], 
			[dmUnits]
			)
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 730, 50000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Normal PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Adjust Valve Clearance'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 90, 8000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Normal PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Oil/Filter Service'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 30, 25000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Normal PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Transmission Service'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 730, 50000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Adjust Valve Clearance'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 1460, 40000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Brake Drum Shoe'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 730, 30000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Brake Fluid'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 730, 30000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Brake Shoes'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], NULL, 90000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Disc Brake Calipers'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], NULL, 90000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Drum Brake Cylinders'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 1460, 40000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Drum Brake Shoes'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 180, 7500.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Replace Brakes'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], NULL, 100000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Power Steering Pump'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], NULL, 90000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Tie Rods'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], NULL, 100000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Air Conditioner Compressor'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 365, 10000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Air Filter'
		and	UM.vchName = 'miles'
		union all
	
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 730, 20000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Alignment'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 1460, 60000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Cap, Rotor, & Wire'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], NULL, 100000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Catalytic Converter'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 90, 3000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Clean Fuel Injectors/Carburetor'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], NULL, 100000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Clutch Cylinder'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 1095, 45000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Cooling System Flush'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 1460, 60000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Engine Belts'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 1460, 60000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Engine Tune Up'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], NULL, 80000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Exhaust Pipes'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 1095, 40000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Fuel Filter'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], NULL, 100000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Fuel Injectors'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], NULL, 90000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Fuel Pump'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], NULL, 90000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Heater Core'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 1460, 40000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'PCV Valve'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], NULL, 60000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Radiator'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], NULL, 60000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Radiator Hoses'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], NULL, 100000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Alternator'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], NULL, 90000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Control Arm Lower Ball Joint'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], NULL, 100000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Recharge A/C'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 356, 8000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Replace Parking Light'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 730, 30000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Spark Plugs'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], NULL, 100000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Starter'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], NULL, 60000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Thermostat'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 2190, 100000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Timing Belt'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 2190, 100000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Timing Chain'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], NULL, 100000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Shock Absorbers'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], NULL, 100000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Springs'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], NULL, 60000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Strutts'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 730, 30000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Transmission Filter'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], NULL, 90000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Universal CV Joint'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 540, 20000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Wheel Alignment'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 180, 7500.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Rotate Tires'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 1095, 40000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Tires and Balance'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 730, 30000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Change Windshield Wipers'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], NULL, 90000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Bus Extended PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Water Pump'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 730, 50000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Truck Normal PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Adjust Valve Clearance'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 90, 8000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Truck Normal PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Oil/Filter Service'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 30, 25000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Truck Normal PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Transmission Service'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 730, 50000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Fork Lift Normal PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Adjust Valve Clearance'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 90, 8000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Fork Lift Normal PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Oil/Filter Service'
		and	UM.vchName = 'miles'
		union all
		select 	@OrgId, PMS.[Id], S.[Id], UM.[Id], 30, 25000.00000000
		from 	PMSchedules as PMS, 
			PMServices as S, 
			UnitMeasures as UM
		where 	PMS.OrgId = @OrgId and PMS.vchName = 'Fork Lift Normal PM List'
		and	S.OrgId = @OrgId and S.vchDesc = 'Transmission Service'
		and	UM.vchName = 'miles'
		

	if @@Error <> 0
	begin
		rollback transaction
		print 'Step 12. An error occurred loading the PM Items.'
		return (99)
	end
	else
	begin
		commit transaction
		print 'Step 12.  PM Items have been added to database'
	end


	-- 14. Inspections, Inspection Items
	begin transaction

		insert into [Inspections]([OrgId], [vchName])
		select @OrgId, 'Bus - Monthly Service Inspection'

		select @RC = scope_identity()
	
		insert into [InspectCats]([OrgId], [InspectId], [vchName], [tintOrder])
		select @OrgId, @RC, 'Safety Devices', 1
		union all
		select @OrgId, @RC, 'Brakes', 2
		union all
		select @OrgId, @RC, 'Tires', 3
		union all
		select @OrgId, @RC, 'Front End', 4
		union all
		select @OrgId, @RC, 'Drive Train', 5
		union all
		select @OrgId, @RC, 'Body', 6

		insert into [InspectionItems]([OrgId], [InspectId], [InspectCatId], [vchDesc], [tintOrder], [btEnabled])
		select @OrgId, @RC, IC.[Id], 'Stop Arm and Crossing Gate', 1, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Safety Devices'
		union all
		select @OrgId, @RC, IC.[Id], 'Flasher Lights and Strobe Lights', 2, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Safety Devices'
		union all
		select @OrgId, @RC, IC.[Id], 'First Aid Kit and Fire Extinguisher', 3, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Safety Devices'
		union all
		select @OrgId, @RC, IC.[Id], 'Body Fluid Clean-up Kit', 4, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Safety Devices'
		union all
		select @OrgId, @RC, IC.[Id], 'Disabled Vehicle Warning Devices', 5, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Safety Devices'
		union all
		select @OrgId, @RC, IC.[Id], 'Turn Signals,Lights and Horn', 6, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Safety Devices'
		union all
		select @OrgId, @RC, IC.[Id], 'Dash Instruments, Gauges & Speedometer', 7, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Safety Devices'
		union all
		select @OrgId, @RC, IC.[Id], 'Service Brakes - Primary', 1, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Brakes'
		union all
		select @OrgId, @RC, IC.[Id], 'Service Brakes - Backup', 2, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Brakes'
		union all
		select @OrgId, @RC, IC.[Id], 'Parking Brake', 3, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Brakes'
		union all
		select @OrgId, @RC, IC.[Id], 'Pedal Pressure and Clearance', 4, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Brakes'
		union all
		select @OrgId, @RC, IC.[Id], 'Air or Hydraulic Hoses', 5, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Brakes'
		union all
		select @OrgId, @RC, IC.[Id], 'Air Pressure or Hydraulic Fluid', 6, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Brakes'
		union all
		select @OrgId, @RC, IC.[Id], 'Front Tires: Tread -- Cuts/Cracks', 1, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Tires'
		union all
		select @OrgId, @RC, IC.[Id], 'Read Tires: Tread -- Cuts/Cracks', 2, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Tires'
		union all
		select @OrgId, @RC, IC.[Id], 'Tires Properly Inflated', 3, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Tires'
		union all
		select @OrgId, @RC, IC.[Id], 'Spindles and Wheel Alignment', 1, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Front End'
		union all
		select @OrgId, @RC, IC.[Id], 'Tie Rods and Drag Links', 2, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Front End'
		union all
		select @OrgId, @RC, IC.[Id], 'Front Springs, Clamps and Shackles', 3, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Front End'
		union all
		select @OrgId, @RC, IC.[Id], 'Power Steering Tight and Fluid Level', 4, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Front End'
		union all
		select @OrgId, @RC, IC.[Id], 'Governor Properly Set and Working', 1, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Drive Train'
		union all
		select @OrgId, @RC, IC.[Id], 'Fuel Line and Tank(s)', 2, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Drive Train'
		union all
		select @OrgId, @RC, IC.[Id], 'Fuel and Water Pumps', 3, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Drive Train'
		union all
		select @OrgId, @RC, IC.[Id], 'Oil and Air Filters', 4, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Drive Train'
		union all
		select @OrgId, @RC, IC.[Id], 'Motor Supports: Front and Rear', 5, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Drive Train'
		union all
		select @OrgId, @RC, IC.[Id], 'Exhaust System', 6, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Drive Train'
		union all
		select @OrgId, @RC, IC.[Id], 'Fan Belt(s)', 7, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Drive Train'
		union all
		select @OrgId, @RC, IC.[Id], 'Alternator and Battery(ies)', 8, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Drive Train'
		union all
		select @OrgId, @RC, IC.[Id], 'Starter', 9, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Drive Train'
		union all
		select @OrgId, @RC, IC.[Id], 'Engine Oil Level', 10, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Drive Train'
		union all
		select @OrgId, @RC, IC.[Id], 'Transmission Fluid Level', 11, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Drive Train'
		union all
		select @OrgId, @RC, IC.[Id], 'Coolant Level and Hoses', 12, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Drive Train'
		union all
		select @OrgId, @RC, IC.[Id], 'Univ. Joints and D. S. Bearings', 13, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Drive Train'
		union all
		select @OrgId, @RC, IC.[Id], 'Rear Springs, Clamps and Shackles', 14, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Drive Train'
		union all
		select @OrgId, @RC, IC.[Id], 'Wheel: Lug Bolts Tight', 15, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Drive Train'
		union all
		select @OrgId, @RC, IC.[Id], 'Bus Properly Lubricated', 16, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Drive Train'
		union all
		select @OrgId, @RC, IC.[Id], 'Rear View and Cross-over Mirrors', 1, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Body'
		union all
		select @OrgId, @RC, IC.[Id], 'Fenders, Cowl and Bumpers', 2, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Body'
		union all
		select @OrgId, @RC, IC.[Id], 'Driver''s Seat and Seat Belt', 3, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Body'
		union all
		select @OrgId, @RC, IC.[Id], 'Entrance Door, Steps and Stepwell Light', 4, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Body'
		union all
		select @OrgId, @RC, IC.[Id], 'Emergency Door(s) and Buzzer(s)', 5, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Body'
		union all
		select @OrgId, @RC, IC.[Id], 'Glass: Doors, Windows and Windshield', 6, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Body'
		union all
		select @OrgId, @RC, IC.[Id], 'Seats: Anchor, Upholstery and Cushion Attached', 7, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Body'
		union all
		select @OrgId, @RC, IC.[Id], 'Windshield Wiper and Washer', 8, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Body'
		union all
		select @OrgId, @RC, IC.[Id], 'Cleanliness/ Interior of Body', 9, 1
		from InspectCats IC
		where IC.OrgId = @OrgId and InspectId = @RC and vchName = 'Body'

		insert into [InspectionItems_PMSchedDetails]([OrgId], [InspectItemId], [PMSchedDetailId])
		select @OrgId, II.[Id], PMD.[Id]
		from InspectionItems II, PMSchedDetails PMD
		where II.OrgId = @OrgId and II.InspectId = @RC and II.vchDesc = 'Engine Oil Level'
		and PMD.OrgId = @OrgId and PMD.PMServiceId in (
			select [Id]
			from PMServices
			where OrgId = @OrgId and vchDesc = 'Oil/Filter Service'
			)
		union all
		select @OrgId, II.[Id], PMD.[Id]
		from InspectionItems II, PMSchedDetails PMD
		where II.OrgId = @OrgId and II.InspectId = @RC and II.vchDesc = 'Transmission Fluid Level'
		and PMD.OrgId = @OrgId and PMD.PMServiceId in (
			select [Id]
			from PMServices
			where OrgId = @OrgId and vchDesc = 'Transmission Service'
			)

	if @@Error <> 0
	begin
		rollback transaction
		print 'Step 14. An error occurred loading the Inspection Items.'
		return (99)
	end
	else
	begin
		commit transaction
		print 'Step 14. Inspection and his items have been added to database'
	end

	-- 15. Inspection Schedules and his details
	begin transaction

		insert into [InspectSchedules]([OrgId], [vchName])
		select @OrgId, 'Schedule for Monthly Inspection of Buses'

		select @RC = scope_identity()

		insert into [InspectSchedDetails]([OrgId], [InspectSchedId], [InspectionId], [TargetDaysOut], [MinimumDaysOut], [MaximumDaysOut])
		select @OrgId, @RC, I.[Id], 30, 24, 36
		from Inspections as I
		where I.OrgId = @OrgId and I.vchName = 'Bus - Monthly Service Inspection'

	if @@Error <> 0
	begin
		rollback transaction
		print 'Step 15. An error occurred loading the Inspection Schedules.'
		return (99)
	end
	else
	begin
		commit transaction
		print 'Step 15. Inspection Schedules have been added to database'
	end

	-- 16. Users Information 
	begin transaction

		insert into [Groups]([OrgId], [vchDesc], [CanDelete])
		select @OrgId, 'Administrators', 0
		union all
		select @OrgId, 'Managers', 1
		union all
		select @OrgId, 'Users', 1
		union all
		select @OrgId, 'Everyone', 0
		union all
		select @OrgId, 'Super Admins', 1

		----
		insert into [Groups_Permissions]([OrgId], [GroupId], [PermissionId])
		select @OrgId, G.[Id], 1
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Administrators'
		union all
		select @OrgId, G.[Id], 2
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Administrators'
		union all
		select @OrgId, G.[Id], 3
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Administrators'
		union all
		select @OrgId, G.[Id], 4
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Administrators'
		union all
		select @OrgId, G.[Id], 7
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Administrators'
		union all
		select @OrgId, G.[Id], 9
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Administrators'
		union all
		select @OrgId, G.[Id], 10
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Administrators'
		union all
		select @OrgId, G.[Id], 11
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Administrators'
		union all
		select @OrgId, G.[Id], 12
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Administrators'
		union all
		select @OrgId, G.[Id], 13
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Administrators'
		union all
		select @OrgId, G.[Id], 14
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Administrators'
		union all
		select @OrgId, G.[Id], 15
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Administrators'
		union all
		select @OrgId, G.[Id], 1
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Managers'
		union all
		select @OrgId, G.[Id], 2
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Managers'
		union all
		select @OrgId, G.[Id], 3
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Managers'
		union all
		select @OrgId, G.[Id], 9
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Managers'
		union all
		select @OrgId, G.[Id], 10
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Managers'
		union all
		select @OrgId, G.[Id], 11
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Managers'
		union all
		select @OrgId, G.[Id], 12
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Managers'
		union all
		select @OrgId, G.[Id], 13
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Managers'
		union all
		select @OrgId, G.[Id], 14
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Managers'
		union all
		select @OrgId, G.[Id], 15
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Managers'
		union all
		select @OrgId, G.[Id], 1
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Users'
		union all
		select @OrgId, G.[Id], 2
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Users'
		union all
		select @OrgId, G.[Id], 3
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Users'
		union all
		select @OrgId, G.[Id], 9
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Users'
		union all
		select @OrgId, G.[Id], 10
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Users'
		union all
		select @OrgId, G.[Id], 11
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Users'
		union all
		select @OrgId, G.[Id], 12
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Users'
		union all
		select @OrgId, G.[Id], 13
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Users'
		union all
		select @OrgId, G.[Id], 14
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Users'
		union all
		select @OrgId, G.[Id], 15
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Users'
		union all
		select @OrgId, G.[Id], 1
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Everyone'
		union all
		select @OrgId, G.[Id], 2
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Everyone'
		union all
		select @OrgId, G.[Id], 16
		from [Groups] as G where OrgId = @OrgId and vchDesc = 'Super Admins'
		----

		-- 1.
		insert into [Logins]([vchFirstName], [vchLastName], [vchEmail], [vchPass], [btActive], [Initials], [PIN], [dtCreated], [CreatedLoginId], [dtUpdated], [UpdatedLoginId], [salt])
		select 'Admin', 'DemoAdmin', 'demoadmin@bigfleetsystem.com', '294D413D2790A85118F4DC2DD7F5C1788B1F4D92', 1, 'AD', '12345', @dtCreated, 3, @dtCreated, 3, 'XZ3kTMA='
	
		select @RC = scope_identity()
	
		insert into [Logins_Orgs]([UserId], [OrgId])
		values(@RC, @OrgId)

		insert into [Logins_UserTypes]([UserId], [UserTypeId])
		values(@RC, 1) -- add technician

		insert into [Logins_Groups]([OrgId], [UserId], [GroupId])
		select @OrgId, @RC, G.[Id]
		from Groups G
		where OrgId = @OrgId and vchDesc = 'Administrators'

		-- 2.
		select @RC = L.[Id]
		from Logins L 
		where vchFirstName = 'Tom' and vchLastName = 'Pryor'

		insert into [Logins_Orgs]([UserId], [OrgId])
		values(@RC, @OrgId)
	
		insert into [Logins_Groups]([OrgId], [UserId], [GroupId])
		select @OrgId, @RC, G.[Id]
		from Groups G
		where OrgId = @OrgId and vchDesc = 'Administrators'
		
		-- 3.
		select @RC = L.[Id]
		from Logins L 
		where vchFirstName = 'Patrick' and vchLastName = 'Clements'

		insert into [Logins_Orgs]([UserId], [OrgId])
		values(@RC, @OrgId)
	
		insert into [Logins_Groups]([OrgId], [UserId], [GroupId])
		select @OrgId, @RC, G.[Id]
		from Groups G
		where OrgId = @OrgId and vchDesc = 'Administrators'
		
		-- 4.
		select @RC = L.[Id]
		from Logins L 
		where vchFirstName = 'Jon' and vchLastName = 'Vickers'

		insert into [Logins_Orgs]([UserId], [OrgId])
		values(@RC, @OrgId)
	
		insert into [Logins_Groups]([OrgId], [UserId], [GroupId])
		select @OrgId, @RC, G.[Id]
		from Groups G
		where OrgId = @OrgId and vchDesc = 'Administrators'
		
		-- 5.
		select @RC = L.[Id]
		from Logins L 
		where vchFirstName = 'Alexey' and vchLastName = 'Gavrilov'

		insert into [Logins_Orgs]([UserId], [OrgId])
		values(@RC, @OrgId)
	
		insert into [Logins_Groups]([OrgId], [UserId], [GroupId])
		select @OrgId, @RC, G.[Id]
		from Groups G
		where OrgId = @OrgId and vchDesc = 'Administrators'

	
		insert into [Logins_Groups]([OrgId], [UserId], [GroupId])
		select @OrgId, @RC, G.[Id]
		from Groups G
		where OrgId = @OrgId and vchDesc = 'Super Admin'

		-- 6.
		insert into [Logins]([vchFirstName], [vchLastName], [vchEmail], [vchPass], [btActive], [Initials], [PIN], [dtCreated], [CreatedLoginId], [dtUpdated], [UpdatedLoginId], [salt])
		select 'Manager', 'DemoManager', 'demomanager@bigfleetsystem.com', '294D413D2790A85118F4DC2DD7F5C1788B1F4D92', 1, 'MD', '12345', @dtCreated, 3, @dtCreated, 3, 'XZ3kTMA='
	
		select @RC = scope_identity()
	
		insert into [Logins_Orgs]([UserId], [OrgId])
		values(@RC, @OrgId)

		insert into [Logins_UserTypes]([UserId], [UserTypeId])
		values(@RC, 1) -- add technician

		insert into [Logins_Groups]([OrgId], [UserId], [GroupId])
		select @OrgId, @RC, G.[Id]
		from Groups G
		where OrgId = @OrgId and vchDesc = 'Managers'

		-- 7.
		select @RC = L.[Id]
		from Logins L 
		where vchFirstName = 'Mike' and vchLastName = 'Ramey'

		insert into [Logins_Orgs]([UserId], [OrgId])
		values(@RC, @OrgId)
	
		insert into [Logins_Groups]([OrgId], [UserId], [GroupId])
		select @OrgId, @RC, G.[Id]
		from Groups G
		where OrgId = @OrgId and vchDesc = 'Managers'

		-- 8.
		select @RC = L.[Id]
		from Logins L 
		where vchFirstName = 'William' and vchLastName = 'Murphy'

		insert into [Logins_Orgs]([UserId], [OrgId])
		values(@RC, @OrgId)
	
		insert into [Logins_Groups]([OrgId], [UserId], [GroupId])
		select @OrgId, @RC, G.[Id]
		from Groups G
		where OrgId = @OrgId and vchDesc = 'Managers'

		-- 9.
		insert into [Logins]([vchFirstName], [vchLastName], [vchEmail], [vchPass], [btActive], [Initials], [PIN], [dtCreated], [CreatedLoginId], [dtUpdated], [UpdatedLoginId], [salt])
		select 'Operator', 'DemoOperator', 'demooperator@bigfleetsystem.com', '294D413D2790A85118F4DC2DD7F5C1788B1F4D92', 1, 'OD', '12345', @dtCreated, 3, @dtCreated, 3, 'XZ3kTMA='
	
		select @RC = scope_identity()
	
		insert into [Logins_Orgs]([UserId], [OrgId])
		values(@RC, @OrgId)

		insert into [Logins_UserTypes]([UserId], [UserTypeId])
		values(@RC, 2) -- add technician

		insert into [Logins_Groups]([OrgId], [UserId], [GroupId])
		select @OrgId, @RC, G.[Id]
		from Groups G
		where OrgId = @OrgId and vchDesc = 'Users'
		
	if @@Error <> 0
	begin
		rollback transaction
		print 'Step 16. An error occurred loading the Users.'
		return (99)
	end
	else
	begin
		commit transaction
		print 'Step 16. Users have been added to database'
	end

	-- 17. Operator’s Instructions
	begin transaction

		insert into [OperatorInstructions]([OrgId], [TypeId], [vchNote])
		select @OrgId, 3, 'Thank you for using Demo County''s new work order system.'
		union all
		select @OrgId, 3, 'Please remember to go through the Departure Check-Out process when your bus has been serviced.'
		union all
		select @OrgId, 4, 'While technicians serve your equipment at your disposal a special room where you can have a rest, watch TV/DVD etc.'
		union all
		select @OrgId, 5, 'You have requested a spare equipment. Please read the following instructions about spare equipment:<ul type="circle"><li>You will need to go to the front desk to get the keys</li><li>All spare equipment will need to be returned upon check-out</li><li>Refuel and top-off the equipment before returning</li><li>Sweep interior</li><li>Park it close to where you found it on the lot</li></ul>'
		union all
		select @OrgId, 1, 'Thank you for using Demo County''s new work order system.'
		union all
		select @OrgId, 8, 'Please return the spare equipments keys to the front desk clerk.'
		
	if @@Error <> 0
	begin
		rollback transaction
		print 'Step 17. An error occurred loading the Operator’s Instructions.'
		return (99)
	end
	else
	begin
		commit transaction
		print 'Step 17. Operator’s Instructions have been added to database'
	end
	

--rollback



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

