SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER  PROCEDURE sp_SelectEquipList
	(
		@OrgId int,
		@ErrorCode int OUTPUT 
	)
AS
	SET NOCOUNT ON

	select 	E.[Id], 
		E.DataId, 
		ET.vchName as TypeName, 
		D.vchName as DepartmentName, 
		L.vchName as LocationName, 
		ED.[nvarchar1], 
		ED.[nvarchar2], 
		ED.[nvarchar3], 
		ED.[nvarchar4], 
		ED.[nvarchar5], 
		ED.[nvarchar6], 
		ED.[nvarchar7], 
		ED.[nvarchar8], 
		ED.[nvarchar9], 
		ED.[nvarchar10], 
		ED.[nvarchar11], 
		ED.[nvarchar12], 
		ED.[nvarchar13], 
		ED.[nvarchar14], 
		ED.[nvarchar15], 
		ED.[nvarchar16], 
		ED.[nvarchar17], 
		ED.[nvarchar18], 
		ED.[nvarchar19], 
		ED.[nvarchar20], 
		ED.[nvarchar21], 
		ED.[nvarchar22], 
		ED.[nvarchar23], 
		ED.[nvarchar24], 
		ED.[nvarchar25], 
		ED.[nvarchar26], 
		ED.[nvarchar27], 
		ED.[nvarchar28], 
		ED.[nvarchar29], 
		ED.[nvarchar30], 
		ED.[nvarchar31], 
		ED.[nvarchar32], 
		ED.[int1], 
		ED.[int2], 
		ED.[int3], 
		ED.[int4], 
		ED.[int5], 
		ED.[int6], 
		ED.[int7], 
		ED.[int8], 
		ED.[lookup1], 
		ED.[lookup2], 
		ED.[lookup3], 
		ED.[lookup4], 
		ED.[lookup5], 
		ED.[lookup6], 
		ED.[lookup7], 
		ED.[lookup8], 
		ED.[float1], 
		ED.[float2], 
		ED.[float3], 
		ED.[float4], 
		ED.[float5], 
		ED.[float6], 
		ED.[float7], 
		ED.[float8], 
		ED.[datetime1], 
		ED.[datetime2], 
		ED.[datetime3], 
		ED.[datetime4], 
		ED.[datetime5], 
		ED.[datetime6], 
		ED.[datetime7], 
		ED.[datetime8], 
		ED.[bit1], 
		ED.[bit2], 
		ED.[bit3], 
		ED.[bit4], 
		ED.[bit5], 
		ED.[bit6], 
		ED.[bit7], 
		ED.[bit8] 
	from EquipData ED
	inner join Equipment E
	on ED.[Id] = E.DataId
	and ED.OrgId = E.OrgId 
	left join EquipTypes ET
	on ET.[Id] = E.TypeId
	and ET.OrgId = E.OrgId
	left join Departments D
	on D.[Id] = E.DeptId
	and D.OrgId = E.OrgId 
	left join Locations L
	on L.[Id] = E.LocId
	and L.OrgId = E.OrgId 
	where ED.OrgId = @OrgId
	
	select @ErrorCode=@@ERROR

	RETURN 

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

