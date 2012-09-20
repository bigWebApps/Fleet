SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create procedure dbo.sp_HolidayDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int output,
		@dtStartDate datetime=null output,
		@dtEndDate datetime=null output,
		@vchDesc varchar(50) output,
		@intPercentOff int=null output
	)
AS
	set nocount on
	
	if @Action = 'S'
	begin
		if not exists(select 'true' from Holidays where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			select 	@dtStartDate = dtStartDate,
				@dtEndDate = dtEndDate,
				@vchDesc = vchDesc,
				@intPercentOff = intPercentOff
			from Holidays
			where [Id] = @Id
			and OrgId = @OrgId

			return 0;
		end
	end
	if @Action = 'U'
	begin
		select 	@dtStartDate = dateadd(d, datediff(d, '', @dtStartDate), ''),
			@dtEndDate = dateadd(minute, -1, dateadd(d, datediff(d, '', dateadd(d, 1, @dtEndDate)), ''))

		if @Id = 0
		begin -- insert
			insert into Holidays([OrgId], dtStartDate, dtEndDate, vchDesc, intPercentOff)
			values	(@OrgId, @dtStartDate, @dtEndDate, @vchDesc, @intPercentOff)

			select @Id = scope_identity()

			return 0
		end
		else
		begin -- update
			if not exists(select 'true' from Holidays where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				update 	[Holidays]
				set 	dtStartDate = @dtStartDate,
					dtEndDate = @dtEndDate,
					vchDesc = @vchDesc,
					intPercentOff = @intPercentOff
				where 	[Id]=@Id
				and 	OrgId = @OrgId

				return 0
			end
		end
	end
	if @Action = 'D'
	begin
		if not exists(select 'true' from Holidays where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			delete from Holidays
			where [Id] = @Id
			and OrgId = @OrgId
		end
	end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

