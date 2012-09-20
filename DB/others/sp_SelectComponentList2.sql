SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




ALTER    PROCEDURE sp_SelectComponentList2
	(
		@OrgId int,
		@EquipId int
	)
AS
	set nocount on

	select 	EquipComponents.[Id] as ComponentId, 
		EquipComponents.[DataId], 
		EquipComponents.[TypeId] as TypeId,
		EquipComponentTypes.vchName as ComponentName,
		case when EquipComponents.btActive = 1 then 'Active' else 'Inactive (under repair)' end as Active,
		isnull(EquipData.[nvarchar1], N'') as nvarchar1,
		isnull(EquipData.[nvarchar2], N'') as nvarchar2,
		isnull(EquipData.[nvarchar3], N'') as nvarchar3,
		isnull(EquipData.[nvarchar4], N'') as nvarchar4,
		isnull(EquipData.[nvarchar5], N'') as nvarchar5,
		isnull(EquipData.[nvarchar6], N'') as nvarchar6,
		isnull(EquipData.[nvarchar7], N'') as nvarchar7,
		isnull(EquipData.[nvarchar8], N'') as nvarchar8,
		isnull(EquipData.[nvarchar9], N'') as nvarchar9,
		isnull(EquipData.[nvarchar10], N'') as nvarchar10,
		isnull(EquipData.[nvarchar11], N'') as nvarchar11,
		isnull(EquipData.[nvarchar12], N'') as nvarchar12,
		isnull(EquipData.[nvarchar13], N'') as nvarchar13,
		isnull(EquipData.[nvarchar14], N'') as nvarchar14,
		isnull(EquipData.[nvarchar15], N'') as nvarchar15,
		isnull(EquipData.[nvarchar16], N'') as nvarchar16,
		isnull(EquipData.[nvarchar17], N'') as nvarchar17,
		isnull(EquipData.[nvarchar18], N'') as nvarchar18,
		isnull(EquipData.[nvarchar19], N'') as nvarchar19,
		isnull(EquipData.[nvarchar20], N'') as nvarchar20,
		isnull(EquipData.[nvarchar21], N'') as nvarchar21,
		isnull(EquipData.[nvarchar22], N'') as nvarchar22,
		isnull(EquipData.[nvarchar23], N'') as nvarchar23,
		isnull(EquipData.[nvarchar24], N'') as nvarchar24,
		isnull(EquipData.[nvarchar25], N'') as nvarchar25,
		isnull(EquipData.[nvarchar26], N'') as nvarchar26,
		isnull(EquipData.[nvarchar27], N'') as nvarchar27,
		isnull(EquipData.[nvarchar28], N'') as nvarchar28,
		isnull(EquipData.[nvarchar29], N'') as nvarchar29,
		isnull(EquipData.[nvarchar30], N'') as nvarchar30,
		isnull(EquipData.[nvarchar31], N'') as nvarchar31,
		isnull(EquipData.[nvarchar32], N'') as nvarchar32,
		isnull(EquipData.[int1], 0) as 
		isnull(EquipData.[int2], 0) as 
		isnull(EquipData.[int3], N'') as 
		isnull(EquipData.[int4], N'') as 
		isnull(EquipData.[int5], N'') as 
		isnull(EquipData.[int6], N'') as 
		isnull(EquipData.[int7], N'') as 
		isnull(EquipData.[int8], N'') as 
		isnull(EquipData.[lookup1], 
		isnull(EquipData.[lookup2], 
		isnull(EquipData.[lookup3], 
		isnull(EquipData.[lookup4], 
		isnull(EquipData.[lookup5], 
		isnull(EquipData.[lookup6], 
		isnull(EquipData.[lookup7], 
		isnull(EquipData.[lookup8], 
		isnull(EquipData.[float1], 
		isnull(EquipData.[float2], 
		isnull(EquipData.[float3], 
		isnull(EquipData.[float4], 
		isnull(EquipData.[float5], 
		isnull(EquipData.[float6], 
		isnull(EquipData.[float7], 
		isnull(EquipData.[float8], 
		convert(nvarchar, EquipData.[datetime1], 101) as [datetime1], 
		convert(nvarchar, EquipData.[datetime2], 101) as [datetime2],
		convert(nvarchar, EquipData.[datetime3], 101) as [datetime3],
		convert(nvarchar, EquipData.[datetime4], 101) as [datetime4],
		convert(nvarchar, EquipData.[datetime5], 101) as [datetime5],
		convert(nvarchar, EquipData.[datetime6], 101) as [datetime6],
		convert(nvarchar, EquipData.[datetime7], 101) as [datetime7],
		convert(nvarchar, EquipData.[datetime8], 101) as [datetime8],
		isnull(EquipData.[bit1], 
		isnull(EquipData.[bit2], 
		isnull(EquipData.[bit3], 
		isnull(EquipData.[bit4], 
		isnull(EquipData.[bit5], 
		isnull(EquipData.[bit6], 
		isnull(EquipData.[bit7], 
		isnull(EquipData.[bit8] 
	from EquipComponents
	inner join EquipData
	on EquipData.[Id] = EquipComponents.DataId
	and EquipData.OrgId = EquipComponents.OrgId 
	inner join EquipComponentTypes
	on EquipComponents.TypeId = EquipComponentTypes.[Id]
	and EquipComponents.[EquipId] = @EquipId
	and EquipComponents.OrgId = @OrgId
	order by EquipComponents.[Id]
	
	return 



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

