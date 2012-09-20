SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_InspectionDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_InspectionDetail]
GO


create procedure dbo.sp_InspectionDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int,
		@vchName varchar(50)=null output
	)
AS
	set nocount on

	if @Action = 'S'
	begin
		if not exists(select 'true' from Inspections where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			select @vchName = vchName
			from Inspections
			where [Id] = @Id
			and OrgId = @OrgId
		end
	end
	if @Action = 'D'
	begin
		if not exists(select 'true' from Inspections where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			if exists(select 'true' 
				from InspectSchedDetails
				where InspectionId = @Id
				and OrgId = @OrgId
				)
			begin
				return 1
			end
			if exists(select top 1 'true' 
				from WorkOrderInspectItems
				where OrgId = @OrgId
				and ItemId in (
					select [Id]
					from InspectionItems 
					where InspectId = @Id
					and OrgId = @OrgId
					)
				)
			begin
				return 2
			end
			
			delete from InspectionItems_PMSchedDetails
			where OrgId = @OrgId 
			and InspectItemId in (
				select [Id]
				from InspectionItems 
				where InspectId = @Id
				and OrgId = @OrgId		
				)

			delete from InspectionItems
			where InspectId = @Id
			and OrgId = @OrgId
				
			delete from Inspections
			where [Id] = @Id
			and OrgId = @OrgId
			
			return 0
		end
	end
	if @Action = 'U'
	begin
		if @Id = 0
		begin -- insert
			insert into Inspections([OrgId], [vchName])
			values(@OrgId, isnull(@vchName, ''))

			return 0
		end
		else
		begin -- update
			if not exists(select 'true' from Inspections where [Id] = @Id and OrgId = @OrgId)
			begin
				return -1
			end
			else
			begin
				update 	Inspections
				set 	vchName = isnull(@vchName, '')
				where 	[Id] = @Id
				and OrgId = @OrgId

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

