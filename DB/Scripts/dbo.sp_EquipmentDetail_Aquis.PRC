SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_EquipmentDetail_Aquis]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_EquipmentDetail_Aquis]
GO

CREATE PROCEDURE sp_EquipmentDetail_Aquis
	(
		@Action char(1),
		@OrgId int,
		@Id int,
		@dtInService datetime=null OUTPUT,
		@dtAquired datetime=null OUTPUT,
		@vchPurOrgContact varchar(50)=null OUTPUT,
		@smPurAmount smallmoney=null OUTPUT,
		@dmPurUnits decimal(19, 8)=null OUTPUT,
		@vchPurNotes varchar(250)=null OUTPUT
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
			select 	@dtInService = dtInService,
				@dtAquired = dtAquired,
				@vchPurOrgContact = ISNULL(vchPurOrgContact, ''),
				@smPurAmount = smPurAmount,
				@dmPurUnits = dmPurUnits,
				@vchPurNotes = ISNULL(vchPurNotes, '')
			from Equipments
			where OrgId = @OrgId 
			and [Id] = @Id
	
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
			set 	dtInService = @dtInService,
				dtAquired = @dtAquired,
				vchPurOrgContact = @vchPurOrgContact,
				smPurAmount = @smPurAmount,
				dmPurUnits = @dmPurUnits,
				vchPurNotes = @vchPurNotes
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

