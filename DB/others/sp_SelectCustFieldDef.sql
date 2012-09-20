SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER PROCEDURE sp_SelectCustFieldDef
	(
		@OrgId int,
		@DataTypeId int,
		@ComponentTypeID int
	)
AS
	SET NOCOUNT ON

	if not exists(select 'true' from [CustFieldDef]	where DataTypeId = @DataTypeId and ComponentTypeId = @ComponentTypeID and OrgId = @OrgId)
	begin
		return -1
	end
	else
	begin
		select 	[Id], 
			[NumberColumn], 
			[vchName], 
			[vchNameText], 
			[vchNameLookupTable], 
			[vchNameFieldLookup], 
			[btRequired], 
			[intFieldTypeId], 
			[vchDefault],
			[vchHelp]
		from 	[CustFieldDef]
		where DataTypeId = @DataTypeId
		and ComponentTypeId = @ComponentTypeID
		and OrgId = @OrgId

		return 0
	end




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

