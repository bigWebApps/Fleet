SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SetIssueChecks]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SetIssueChecks]
GO


CREATE  procedure sp_SetIssueChecks
	(
		@OrgId int,
		@OrderId int,
		@ItemId int,
		@ServiceCheckId int=null,
		@ServiceResultId int=null -- old result status
	)
AS
	set nocount on
	declare @IsDelete bit
	declare @RepairItemId int
	declare @i int
	declare @N int
	create table #tmp(
		[Id] int identity(1, 1), 
		RepairId int
		)
	if not exists(select 'true' from WorkOrderReportedIssues where [Id] = @ItemId and OrgId = @OrgId and WorkOrderId = @OrderId)
	begin
		return -1
	end
	else
	begin
		select 	@RepairItemId = isnull(RepairItemId, 0)
		from 	WorkOrderReportedIssues
		where 	[Id] = @ItemId 
		and 	OrgId = @OrgId
		and 	WorkOrderId = @OrderId
		if isnull(@ServiceResultId, 0) > 0 -- then delete the his repairs
		begin
			-- if the deleting repair has relate to an other PM items, Issues, and Inspection Items 
			-- then don't delete repair and only update this PM items
			select @IsDelete = 1
	
			if exists(select 'true' 
				from WorkOrderPMItems
				where OrgId = @OrgId
				and WorkOrderId = @OrderId
				and RepairItemId = @RepairItemId
				)
			begin
				select @IsDelete = 0
			end
	
			if exists(select 'true' 
				from WorkOrderReportedIssues
				where OrgId = @OrgId
				and WorkOrderId = @OrderId
				and RepairItemId = @RepairItemId
				and [Id] <> @ItemId
				)
			begin
				select @IsDelete = 0
			end
	
			if exists(select 'true' 
				from WorkOrderInspectItems
				where OrgId = @OrgId
				and WorkOrderId = @OrderId
				and RepairItemId = @RepairItemId
				)
			begin
				select @IsDelete = 0
			end
	
			if @IsDelete = 1
			begin -- processing all repairs for delete
	
				insert into #tmp(RepairId)
				select RepairId
				from RepairMult
				where ItemId = @RepairItemId
				and OrgId = @OrgId
	
				select @i = 1, @N = scope_identity()
	
				delete from RepairMult
				where ItemId = @RepairItemId
				and OrgId = @OrgId
				
				-- deleting all repairs, if repair has other issues (or other item) 
				-- then don't delete it
				while @i <= @N
				begin
					if not exists(select 'true' 
						from RepairMult 
						where OrgId = @OrgId 
						and RepairId in (
							select RepairId
							from #tmp
							where [Id] = @i
							)
						)
					begin
						delete from PartsUsed
						where OrgId = @OrgId
						and RepairId in (
							select RepairId
							from #tmp
							where [Id] = @i
							)
		
						delete from Repairs
						where OrgId = @OrgId
						and [Id] in (
							select RepairId
							from #tmp
							where [Id] = @i
							)
					end
					select @i = @i + 1
				end
			end
		end
		update WorkOrderReportedIssues
		set 	ServiceCheckId = @ServiceCheckId,
			ServiceResultId = null,
			RepairItemId = null
		where [Id] = @ItemId
		and OrgId = @OrgId
		and WorkOrderId = @OrderId
	end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

