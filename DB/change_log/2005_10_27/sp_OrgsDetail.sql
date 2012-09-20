SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

create procedure dbo.sp_OrgsDetail
(
	@Action char(1),
	@Id int output,
	@vchName varchar(50)=null output,
	@btActive bit=null output,
	@dtCreated datetime=null output,
	@dtUpdated datetime=null output,
	@vchLogo varchar(255)=null output,
	@btPrint bit=null output,
	@vchFullName varchar(255)=null output,
	@vchAddress1 varchar(50)=null output,
	@vchAddress2 varchar(50)=null output,
	@vchCity varchar(50)=null output,
	@vchProvince varchar(50)=null output,
	@vchPostalCode varchar(30)=null output,
	@vchPhone varchar(20)=null output,
	@vchPhone2 varchar(20)=null output,
	@vchFax varchar(20)=null output,
	@vchAcctNumber varchar(50)=null output,
	@vchContactName varchar(50)=null output,
	@vchNotes varchar(7000)=null output,
	@vchWeb varchar(75)=null output,
	@vchEmail varchar(75)=null output	
) as
	set nocount on
	
	if @Action = 'S'
	begin
		if not exists(select 'true' from Orgs where [Id] = @Id)
			return -1
		else
		begin
			select 	@vchName = [vchName],
				@btActive = [btActive], 
				@dtCreated = [dtCreated], 
				@dtUpdated = [dtCurrentDate], 
				@vchLogo = [vchLogo],
				@btPrint = [btPrint],
				@vchFullName = [vchFullName],
				@vchAddress1 = [vchAddress1], 
				@vchAddress2 = [vchAddress2], 
				@vchCity = [vchCity], 
				@vchProvince = [vchProvince], 
				@vchPostalCode = [vchPostalCode], 
				@vchPhone = [vchPhone], 
				@vchPhone2 = [vchPhone2], 
				@vchFax = [vchFax], 
				@vchAcctNumber = [vchAcctNumber], 
				@vchContactName = [vchContactName], 
				@vchNotes = [vchNotes], 
				@vchWeb = [vchWeb], 
				@vchEmail = [vchEmail] 
			from 	[Orgs]
			where 	[Id] = @Id

			return 0
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0 
		begin  -- insert a new organization
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
				@vchName,
				1, 
				@dtCreated,
				@dtCreated, 
				@vchLogo,
				@btPrint, 
				@vchFullName,
				@vchAddress1,
				@vchAddress2,
				@vchCity,
				@vchProvince,
				@vchPostalCode,
				@vchPhone,
				@vchPhone2,
				@vchFax,
				@vchAcctNumber,
				@vchContactName,
				convert(text, @vchNotes),
				@vchWeb,
				@vchEmail
				)

				select @Id = scope_identity()

				return 0
		end
		else
		begin  -- update organization
			if not exists(select 'true' from Orgs where [Id] = @Id)
				return -1
			else
			begin
				update 	[Orgs]
				set 	[vchName]=@vchName,
					[btActive]=@btActive,
					[dtCurrentDate]=@dtUpdated,
					[vchLogo]=@vchLogo,
					[btPrint]=@btPrint,
					[vchFullName]=@vchFullName,
					[vchAddress1]=@vchAddress1,
					[vchAddress2]=@vchAddress2,
					[vchCity]=@vchCity,
					[vchProvince]=@vchProvince,
					[vchPostalCode]=@vchPostalCode,
					[vchPhone]=@vchPhone,
					[vchPhone2]=@vchPhone2,
					[vchFax]=@vchFax,
					[vchAcctNumber]=@vchAcctNumber,
					[vchContactName]=@vchContactName,
					[vchNotes]=convert(text, @vchNotes),
					[vchWeb]=@vchWeb,
					[vchEmail]=@vchEmail
				where 	[Id]=@Id

				return 0
			end
		end
	end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

