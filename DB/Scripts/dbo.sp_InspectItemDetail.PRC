SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_InspectItemDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_InspectItemDetail]
GO




CREATE   procedure dbo.sp_InspectItemDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int output,
		@InspectId int,
		@InspectCatId int=null output,
		@vchDesc varchar(100)=null output,
		@vchInspectionName varchar(50)=null output,
		@btEnabled bit=null output
	)
as
	set nocount on

	declare @Position int
	declare @OldInspectCatId int

	if @Action = 'S'
	begin
		if @Id = 0
		begin
			select 	@InspectCatId = 0,
				@vchDesc = '',
				@vchInspectionName = isnull(I.vchName, ''),
				@btEnabled = 0
			from Inspections I
			where I.[Id] = @InspectId
			and I.OrgId = @OrgId
		end
		else
		begin
			if not exists(select 'true' from InspectionItems where [Id] = @Id and InspectId = @InspectId and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin 
				select 	@InspectCatId = II.InspectCatId,
					@vchDesc = isnull(II.vchDesc, ''),
					@vchInspectionName = isnull(I.vchName, ''),
					@btEnabled = II.btEnabled
				from InspectionItems II
				inner join Inspections I
				on II.[Id] = @Id
				and II.InspectId = @InspectId
				and II.OrgId = @OrgId
				and II.InspectId = I.[Id]
				and II.OrgId = I.OrgId
			end
			return 0
		end
	end
	if @Action = 'D'
	begin
		if not exists(select 'true' from InspectionItems where [Id] = @Id and InspectId = @InspectId and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			if exists(select top 1 'true' 
				from WorkOrderInspectItems
				where OrgId = @OrgId
				and ItemId = @Id
				)
			begin
				return -2
			end
			else
			begin
				select 	@Position = tintOrder,
					@OldInspectCatId = InspectCatId
				from InspectionItems
				where [Id] = @Id 
				and InspectId = @InspectId 
				and OrgId = @OrgId

				update InspectionItems
				set tintOrder = tintOrder - 1
				where tintOrder >= isnull(@Position, 0)
				and InspectId = @InspectId 
				and OrgId = @OrgId
				and InspectCatId = @OldInspectCatId

				delete from InspectionItems_PMSchedDetails
				where InspectItemId = @Id
				and OrgId = @OrgId
	
				delete from InspectionItems
				where [Id] = @Id 
				and InspectId = @InspectId 
				and OrgId = @OrgId

				return 0
			end
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
			select @Position = max(tintOrder)
			from InspectionItems
			where InspectId = @InspectId 
			and OrgId = @OrgId
			and InspectCatId = @InspectCatId

			insert into [InspectionItems]([OrgId], [InspectId], [InspectCatId], [vchDesc], [tintOrder], [btEnabled])
			values(@OrgId, @InspectId, @InspectCatId, @vchDesc, (isnull(@Position, 0) + 1), @btEnabled)

			select @Id = scope_identity()

			return 0
		end
		else
		begin -- update
			if not exists(select 'true' from InspectionItems where [Id] = @Id and InspectId = @InspectId and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin

				select 	@Position = tintOrder,
					@OldInspectCatId = InspectCatId
				from InspectionItems
				where [Id] = @Id 
				and InspectId = @InspectId 
				and OrgId = @OrgId
				
				if @OldInspectCatId <> @InspectCatId
				begin 
					update InspectionItems
					set tintOrder = tintOrder - 1
					where tintOrder >= isnull(@Position, 0)
					and InspectId = @InspectId 
					and OrgId = @OrgId
					and InspectCatId = @OldInspectCatId

					select @Position = max(tintOrder)
					from InspectionItems
					where InspectId = @InspectId 
					and OrgId = @OrgId
					and InspectCatId  = @InspectCatId

					update 	[InspectionItems]
					set 	[InspectCatId] = @InspectCatId,
						[vchDesc] = @vchDesc,
						[tintOrder] = (isnull(@Position, 0) + 1),
						[btEnabled] = @btEnabled
					where [Id] = @Id 
					and InspectId = @InspectId 
					and OrgId = @OrgId
				end
				else
				begin
					update 	[InspectionItems]
					set 	[vchDesc] = @vchDesc,
						[btEnabled] = @btEnabled
					where [Id] = @Id 
					and InspectId = @InspectId 
					and OrgId = @OrgId
				end

				return 0
			end
		end
	end







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

