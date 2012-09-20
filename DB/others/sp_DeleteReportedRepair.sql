SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

alter PROCEDURE sp_DeleteReportedRepair
	(
		@OrgId int,
		@Id int -- ERR Id
	)
AS
	set nocount on
	declare @RepairItemId int

	if not exists(select 'true' from EquipReportedRepairs where [Id] = @Id and OrgId = @OrgId)
	begin
		return -1
	end
	else
	begin
		select @RepairItemId = RepairItemId
		from EquipReportedRepairs 
		where [Id] = @Id
		and OrgId = @OrgId

		if exists(select 'true' from EquipReportedRepairs where [Id] <> @Id and RepairItemId = @RepairItemId)
		begin
			return 1
		end
		else
		begin
			delete from EquipReportedRepairs
			where [Id] = @Id
			and OrgId = @OrgId
		
			delete from RepairItems
			where [Id] = @RepairItemId
			and OrgId = @OrgId
			return 0
		end
	end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

