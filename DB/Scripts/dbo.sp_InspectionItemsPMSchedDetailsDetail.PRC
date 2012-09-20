SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_InspectionItemsPMSchedDetailsDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_InspectionItemsPMSchedDetailsDetail]
GO


create procedure dbo.sp_InspectionItemsPMSchedDetailsDetail
	(
		@Action char(1),
		@OrgId int,
		@Id int output,
		@InspectItemId int=null output,
		@PMSchedDetailId int=null output
	)
as
	set nocount on

	if @Action = 'I'
	begin
		insert into [InspectionItems_PMSchedDetails]([OrgId], [InspectItemId], [PMSchedDetailId])
		values(@OrgId, @InspectItemId, @PMSchedDetailId)

		select @Id = scope_identity()

		return 0
	end

	if @Action = 'D'
	begin
		if not exists(select 'true' from InspectionItems_PMSchedDetails where [Id] = @Id and OrgId = @OrgId)
		begin
			return -1
		end
		else
		begin
			delete from [InspectionItems_PMSchedDetails]
			where [Id] = @Id and OrgId = @OrgId

			return 0
		end
	end



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

