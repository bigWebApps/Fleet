SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelectModelMakes]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelectModelMakes]
GO

CREATE PROCEDURE sp_SelectModelMakes
	(
		@OrgId int,
		@ModelId int,
		@MakeId int OUTPUT,
		@ModelName nvarchar(50)=null OUTPUT,
		@MakeName nvarchar(50)=null OUTPUT,
		@ErrorCode int OUTPUT
	)
AS
	set nocount on
	
	select @MakeId = null, @ModelName = null, @MakeName = null, @ErrorCode=null
	if ISNULL(@MakeId, 0) = 0 and ISNULL(@ModelId, 0) <> 0
	begin -- select all info, make and model info
		select 	@MakeId = EMa.[Id],
			@ModelName = EMo.vchModelName,
			@MakeName = EMa.vchMakeName
		from 	EquipModels EMo
		inner join EquipModelType EMT
		on EMo.TypeId = EMT.[Id]
		inner join EquipMakes EMa
		on EMT.MakeId = EMa.[Id]
		and EMo.[Id] = @ModelId
		
	end
	if ISNULL(@MakeId, 0) <> 0 and ISNULL(@ModelId, 0) = 0
	begin -- select make info only
		select @MakeName = vchMakeName
		from EquipMakes
		where [Id] = @MakeId
		and OrgId = @OrgId
	end
	select @ErrorCode=@@ERROR
	return 0

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

