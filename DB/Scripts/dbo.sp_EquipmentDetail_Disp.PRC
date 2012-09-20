SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_EquipmentDetail_Disp]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_EquipmentDetail_Disp]
GO

CREATE PROCEDURE sp_EquipmentDetail_Disp
	(
		@Action char(1),
		@OrgId int,
		@Id int,
		@dtOutService datetime=null OUTPUT,
		@dtDisposed datetime=null OUTPUT,
		@vchDispOrgContact varchar(50)=null OUTPUT,
		@dmDispUnits decimal(19,8)=null OUTPUT,
		@smDispAmount smallmoney=null OUTPUT,
		@vchDispNotes varchar(250)=null OUTPUT,
		@intDispMethod int=null OUTPUT,
		@vchDispMethod varchar(25)=null OUTPUT
	)
AS
	set nocount on
	if @Action = 'S'
	begin
		if not exists(select 'true' from Equipments where OrgId=@OrgId and [Id]=@Id)
		begin
			return -1
		end
		else
		begin
			select 	@dtOutService = E.dtOutService,
				@dtDisposed = E.dtDisposed,
				@vchDispOrgContact = ISNULL(E.vchDispOrgContact, ''),
				@dmDispUnits = E.dmDispUnits,
				@smDispAmount = E.smDispAmount,
				@vchDispNotes = ISNULL(E.vchDispNotes, ''),
				@intDispMethod = E.intDispMethod,
				@vchDispMethod = ISNULL(EDM.vchName, '')
			from Equipments E
			left outer join EquipDisposalMethods EDM
			on EDM.[OrgId] = @OrgId and EDM.[Id] = E.intDispMethod
			where E.OrgId = @OrgId 
			and E.[Id] = @Id
	
			return 0
		end
	end
	if @Action = 'U'
	begin
		if not exists(select 'true' from Equipments where OrgId=@OrgId and [Id]=@Id)
		begin
			return -1
		end
		else
		begin
			update 	[Equipments]
			set 	dtOutService = @dtOutService,
				dtDisposed = @dtDisposed,
				vchDispOrgContact = @vchDispOrgContact,
				dmDispUnits = @dmDispUnits,
				smDispAmount = @smDispAmount,
				vchDispNotes = @vchDispNotes,
				intDispMethod = @intDispMethod
			where 	[OrgId] = @OrgId 
			and 	[Id] = @Id
			return 0
		end
	end
	return 0

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

