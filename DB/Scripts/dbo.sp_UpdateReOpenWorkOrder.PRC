SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_UpdateReOpenWorkOrder]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_UpdateReOpenWorkOrder]
GO


create procedure dbo.sp_UpdateReOpenWorkOrder
	(
		@OrgId int,
		@OrderId int,
		@intOperatorId int,
		@ReOpenCategoryId int,
		@dtCurrentDate datetime
	)
as
	set nocount on
	
	if not exists(select 'true' 
		from WorkOrders 
		where OrgId=@OrgId 
		and [Id] = @OrderId)
	begin
		return -1
	end
	else
	begin
		if exists(select 'true' 
			from WorkOrders 
			where OrgId = @OrgId 
			and [Id] = @OrderId 
			and StatusId = 2)
		begin
			insert into [ReOpenLogs](
				[OrgId], 
				[ReOpenCategoryId], 
				[OrderId], 
				[OperatorId], 
				[TechnicianId], 
				[daCreated]
			)
			select 
				@OrgId,
				@ReOpenCategoryId,
				@OrderId,
				@intOperatorId,
				intTechId,
				@dtCurrentDate
			from WorkOrders
			where [Id] = @OrderId
			and OrgId = @OrgId
		end
		return 0
	end




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

