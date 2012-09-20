SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 9/2/2004 
-- Description: The procedure edit repair or add repair and set association 
-- between new repair and issue
---------------------------------------------------------------------------
ALTER  procedure sp_UpdateRepair
	(
		@OrgId int,
		@OrderId int,
		@vchType varchar(25),
		@ItemId int,
		@ServiceResultId int,
		@RepairId int=null output,
		@RepairDesc varchar(4000)=null output,
		@RepairItemId int=null output,
		@RepairCatId int=null output
	)
as
-- So, if RepairId is 0 then we create a new repair and associate him 
-- with inputted issue if not, we only edit the existed repair
	set nocount on
	declare @RC int
	if isnull(@RepairId, 0) = 0
	begin
		if @RepairItemId = 0
		begin
			select @RepairItemId = null
		end
		insert into Repairs(
			OrgId,
			RepairItemId,
			WorkOrderId,
			vchDesc
			)
		values( 
			@OrgId,
			@RepairItemId,
			@OrderId,
			isnull(@RepairDesc, '')
			)
		select @RepairId = scope_identity()
		
		if @vchType <> 'FREE'
		begin
			exec @RC = [dbo].sp_SetAssociationsRepair 1, @OrgId, @OrderId, @vchType, @ItemId, @RepairId, @ServiceResultId
		end
	end
	else
	begin
		exec @RC = [dbo].sp_RepairCommonDetail 'U', @OrgId, @OrderId, @RepairId, @RepairDesc OUTPUT, @RepairItemId OUTPUT , @RepairCatId OUTPUT 
	end
	return @RC

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

