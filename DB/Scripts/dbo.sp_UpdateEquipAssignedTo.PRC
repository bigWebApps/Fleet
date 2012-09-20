SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_UpdateEquipAssignedTo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_UpdateEquipAssignedTo]
GO


CREATE procedure dbo.sp_UpdateEquipAssignedTo
	(
		@OrgId int,
		@UId int, /*UserId*/
		@EquipId int,
		@EquipOperatorId int,
		@vchNote varchar(250)
	)
as
	set nocount on

	declare @EquipOperatorIdFrom int
	
	if @EquipOperatorId = 0 
		select @EquipOperatorId = null
	
	select @EquipOperatorIdFrom = EquipOperatorId 
	from Equipments 
	where OrgId = @OrgId 
	and [Id] = @EquipId
	
	insert into EquipAssignLogs (
			OrgId, 
			EquipId, 
			IsTemp,
			AssignedFrom, 
			AssignedTo, 
			AssignedBy, 
			vchNote, 
			dtUpdated
			) 
	values (	
			@OrgId, 
			@EquipId, 
			0,
			@EquipOperatorIdFrom, 
			@EquipOperatorId, 
			@UId, 
			@vchNote, 
			getdate()
		)

	update Equipments
	set EquipOperatorId = @EquipOperatorId
	where OrgId=@OrgId 
	and [Id]=@EquipId

	-- if this equipment has the unclosed work orders then 
	-- system to reassign iperator for these orders 

	update WorkOrders 
	set intOperatorId = @EquipOperatorId
	where EquipId = @EquipId
	and OrgId = @OrgId
	and isnull(OperatorStatusId, 0) <> 2

	return 



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

