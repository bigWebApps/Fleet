SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER PROCEDURE sp_CustFieldEquipments
	(
		@Action char(1),
		@OrgId int,
		@Id int=null OUTPUT,
		@DataTypeId int OUTPUT,
		@ComponentTypeID int OUTPUT,
		@NumberColumn int OUTPUT,
		@vchName nvarchar(50)=null OUTPUT,
		@vchNameText nvarchar(100)=null OUTPUT,
		@vchNameLookupTable nvarchar(50)=null OUTPUT,
		@vchNameFieldLookup nvarchar(50) OUTPUT,
		@btRequired bit=null OUTPUT,
		@FieldTypeId int OUTPUT,
		@vchDefault nvarchar(50)=null OUTPUT, 
		@vchHelp nvarchar(1024)=null OUTPUT,
		@ErrorCode int OUTPUT
	)
AS
	SET NOCOUNT ON

	if @Action='S' -- select record
	begin
		if not exists(
			select 'true' 
			from CustFieldDef
			where intFieldTypeId = @FieldTypeId
			and DataTypeId = @DataTypeId
			and ComponentTypeID = @ComponentTypeID
			and NumberColumn = @NumberColumn
			and OrgId = @OrgId
			)
		begin
			return -1
		end
		else
		begin
			select top 1
				@Id = ISNULL([Id], 0),
				@vchName = ISNULL(vchName, N''),
				@vchNameText = ISNULL(vchNameText, N''),
				@vchNameLookupTable = ISNULL(vchNameLookupTable, N''),
				@vchNameFieldLookup = ISNULL(vchNameFieldLookup, N''),
				@btRequired = ISNULL(btRequired, 0),
				@vchDefault = ISNULL(vchDefault, N''),
				@vchHelp = ISNULL(vchHelp, N'')
			from CustFieldDef
			where intFieldTypeId = @FieldTypeId
			and DataTypeId = @DataTypeId
			and ComponentTypeID = @ComponentTypeID
			and NumberColumn = @NumberColumn
			and OrgId = @OrgId
	
			return 1
		end
	end

	if @Action='U' -- update or add
	begin
		if @Id = 0 -- insert
		begin
			insert into [CustFieldDef](
					[OrgId], 
					[DataTypeId], 
					[ComponentTypeId], 
					[NumberColumn], 
					[vchName], 
					[vchNameText], 
					[vchNameLookupTable], 
					[btRequired], 
					[intFieldTypeId], 
					[vchDefault],
					[vchHelp]
					)
			values(
					@OrgId, 
					@DataTypeId,
					@ComponentTypeId,
					@NumberColumn,
					@vchName,
					@vchNameText,
					@vchNameLookupTable,
					@btRequired,
					@FieldTypeId,
					@vchDefault,
					@vchHelp
					)	
			select @Id = scope_identity()
		end
		else -- update
		begin
			update  [CustFieldDef]
			set 	[DataTypeId] = @DataTypeId,
				[ComponentTypeId] = @ComponentTypeId,
				[NumberColumn] = @NumberColumn,
				[vchName] = @vchName,
				[vchNameText] = @vchNameText,
				[vchNameLookupTable] = @vchNameLookupTable,
				[vchNameFieldLookup] = @vchNameFieldLookup,
				[btRequired] = @btRequired,
				[intFieldTypeId] = @FieldTypeId,
				[vchDefault] = @vchDefault,
				[vchHelp] = @vchHelp
			where 	CustFieldDef.[Id] = @Id
			and 	CustFieldDef.OrgId = @OrgId
		end
		return @Id 
	end

	select @ErrorCode=@@ERROR

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

