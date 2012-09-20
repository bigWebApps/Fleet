SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_InspectCatsDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_InspectCatsDetail]
GO



CREATE  procedure dbo.sp_InspectCatsDetail
	(
		@Action char(1),
		@OrgId int,
		@InspectId int,
		@Id int output,
		@vchName varchar(50)=null output,
		@vchInspectionName varchar(50)=null output,
		@intPosition int=null output,
		@intMaxPosition int=null output
	)
AS
	set nocount on

	declare @intOldPosition tinyint

	select 	@intMaxPosition = isnull(max(tintOrder), 0)
	from 	InspectCats
	where 	InspectId = @InspectId 
	and 	OrgId = @OrgId

	if @Action = 'S'
	begin
		if @Id = 0 
		begin 
			select @intMaxPosition = @intMaxPosition + 1
			select 	@vchName = '',
				@intPosition = @intMaxPosition,
				@vchInspectionName = isnull(I.vchName, '')
			from Inspections I
			where I.OrgId = @OrgId
			and I.[Id] = @InspectId
		end
		else
		begin
			if not exists(select 'true' from InspectCats where [Id] = @Id and InspectId = @InspectId and OrgId = @OrgId)
			begin
				return -1;
			end
			else
			begin 
				select 	@vchName = isnull(IC.vchName, ''),
					@intPosition = isnull(IC.tintOrder, @intMaxPosition),
					@vchInspectionName = isnull(I.vchName, '')
				from Inspections I
				inner join InspectCats IC
				on I.OrgId = @OrgId
				and I.[Id] = @InspectId
				and IC.[Id] = @Id 
				and IC.InspectId = I.[Id]
				and IC.OrgId = I.OrgId
	
				return 0
			end
		end
	end
	if @Action = 'D'
	begin
		if not exists(select 'true' from InspectCats where [Id] = @Id and InspectId = @InspectId and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			if exists(select 'true' 
				from InspectionItems
				where InspectCatId = @Id
				and InspectId = @InspectId
				and OrgId = @OrgId
				)
			begin
				return 1
			end

			select @intOldPosition = tintOrder
			from InspectCats
			where [Id] = @Id 
			and InspectId = @InspectId 
			and OrgId = @OrgId

			delete from InspectCats
			where [Id] = @Id 
			and InspectId = @InspectId 
			and OrgId = @OrgId

			update InspectCats
			set tintOrder = tintOrder - 1
			where tintOrder >= isnull(@intOldPosition, 0)
			and InspectId = @InspectId 
			and OrgId = @OrgId
			
			return 0
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
			update 	InspectCats
			set 	tintOrder = tintOrder + 1
			where 	InspectId = @InspectId 
			and 	OrgId = @OrgId
			and 	tintOrder >= convert(tinyint, @intPosition)

			insert into [InspectCats]([OrgId], [InspectId], [vchName], [tintOrder])
			values(@OrgId, @InspectId, @vchName, convert(tinyint, @intPosition))

			select @Id = scope_identity()

			return 0
		end
		else
		begin -- update
			if not exists(select 'true' from InspectCats where [Id] = @Id and InspectId = @InspectId and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				select 	@intOldPosition = tintOrder
				from 	InspectCats
				where 	[Id] = @Id 
				and 	InspectId = @InspectId 
				and 	OrgId = @OrgId

				if @intOldPosition <> @intPosition
				begin 
					update 	InspectCats
					set 	tintOrder = 0
					where 	[Id] = @Id 
					and 	InspectId = @InspectId 
					and 	OrgId = @OrgId
	
					update 	InspectCats
					set 	tintOrder = tintOrder - 1
					where 	InspectId = @InspectId 
					and 	OrgId = @OrgId
					and 	tintOrder > @intOldPosition
	
					update 	InspectCats
					set 	tintOrder = tintOrder + 1
					where 	InspectId = @InspectId 
					and 	OrgId = @OrgId
					and 	tintOrder >= convert(tinyint, @intPosition)
				end

				update 	InspectCats
				set 	vchName = isnull(@vchName, ''),
					tintOrder = convert(tinyint, @intPosition)
				where 	[Id] = @Id 
				and 	InspectId = @InspectId 
				and 	OrgId = @OrgId

				return 0
			end
		end
	end
	return 0








GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

