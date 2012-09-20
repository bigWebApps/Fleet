SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ComponentDetail_CustomFields]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ComponentDetail_CustomFields]
GO

----------------------------------------------------------------------------
-- Author: Alexey Gavrilov
-- Date: 10/19/2004
-- Description: Procedure execute operations for the Custom Fields of 
-- the Equipment Component depending on a input variable is @Action.
-- if @Action = 'S' then procedure select the record of the custom fields 
-- for component and return 0
-- if @Action = 'U' and @Id = 0 then procedure insert the record in 
-- the table of the custom fields and insert record in table of Components 
-- and return the Component ID
-- if @Action = 'U' and @Id <> 0 then procedure update the custom fields 
-- and return 0
-- If the record of the components table not exists then return -1
---------------------------------------------------------------------------
CREATE procedure sp_ComponentDetail_CustomFields
	(
		@Action char(1),
		@OrgId int,
		@Id int=null,
		@EquipId int=null,
		@UserId int=null,
		@TypeId int=null,
		@btActive bit=null,
		@nvarchar1 nvarchar(255)=null, 
		@nvarchar2 nvarchar(255)=null, 
		@nvarchar3 nvarchar(255)=null, 
		@nvarchar4 nvarchar(255)=null, 
		@nvarchar5 nvarchar(255)=null, 
		@nvarchar6 nvarchar(255)=null, 
		@nvarchar7 nvarchar(255)=null, 
		@nvarchar8 nvarchar(255)=null, 
		@nvarchar9 nvarchar(255)=null, 
		@nvarchar10 nvarchar(255)=null, 
		@nvarchar11 nvarchar(255)=null, 
		@nvarchar12 nvarchar(255)=null, 
		@nvarchar13 nvarchar(255)=null, 
		@nvarchar14 nvarchar(255)=null, 
		@nvarchar15 nvarchar(255)=null, 
		@nvarchar16 nvarchar(255)=null, 
		@nvarchar17 nvarchar(255)=null, 
		@nvarchar18 nvarchar(255)=null, 
		@nvarchar19 nvarchar(255)=null, 
		@nvarchar20 nvarchar(255)=null, 
		@nvarchar21 nvarchar(255)=null, 
		@nvarchar22 nvarchar(255)=null, 
		@nvarchar23 nvarchar(255)=null, 
		@nvarchar24 nvarchar(255)=null, 
		@nvarchar25 nvarchar(255)=null, 
		@nvarchar26 nvarchar(255)=null, 
		@nvarchar27 nvarchar(255)=null, 
		@nvarchar28 nvarchar(255)=null, 
		@nvarchar29 nvarchar(255)=null, 
		@nvarchar30 nvarchar(255)=null, 
		@nvarchar31 nvarchar(255)=null, 
		@nvarchar32 nvarchar(255)=null, 
		@int1 int=null, 
		@int2 int=null,
		@int3 int=null,
		@int4 int=null,
		@int5 int=null,
		@int6 int=null,
		@int7 int=null,
		@int8 int=null,
		@lookup1 int=null,
		@lookup2 int=null,
		@lookup3 int=null,
		@lookup4 int=null,
		@lookup5 int=null,
		@lookup6 int=null,
		@lookup7 int=null,
		@lookup8 int=null,
		@float1 float=null,
		@float2 float=null,
		@float3 float=null,
		@float4 float=null,
		@float5 float=null,
		@float6 float=null,
		@float7 float=null,
		@float8 float=null,
		@datetime1 datetime=null,
		@datetime2 datetime=null,
		@datetime3 datetime=null,
		@datetime4 datetime=null,
		@datetime5 datetime=null,
		@datetime6 datetime=null,
		@datetime7 datetime=null,
		@datetime8 datetime=null,
		@bit1 bit=null,
		@bit2 bit=null,
		@bit3 bit=null,
		@bit4 bit=null,
		@bit5 bit=null,
		@bit6 bit=null,
		@bit7 bit=null,
		@bit8 bit=null
	)
AS
	set nocount on
	declare @DataId int
	if @Action='S'
	begin -- select 
		if not exists(select 'true' from EquipComponents where [Id] = @Id and [OrgId] = @OrgId)
		begin
			return -1
		end
		else
		begin
			select 	EquipComponents.[Id] as ComponentId, 
				EquipComponents.EquipId,
				EquipComponents.DataId, 
				EquipComponents.TypeId as TypeId,
				EquipComponents.btActive,
				EquipComponentTypes.vchName as ComponentName,
				EquipData.intUpdatedBy,
				case when isnull(Logins.vchFirstName, '') = '' then 'Unassigned' else Logins.vchLastName + ', ' + Logins.vchFirstName end as UserName,
				EquipData.dtUpdated,
				EquipData.[nvarchar1], 
				EquipData.[nvarchar2], 
				EquipData.[nvarchar3], 
				EquipData.[nvarchar4], 
				EquipData.[nvarchar5], 
				EquipData.[nvarchar6], 
				EquipData.[nvarchar7], 
				EquipData.[nvarchar8], 
				EquipData.[nvarchar9], 
				EquipData.[nvarchar10], 
				EquipData.[nvarchar11], 
				EquipData.[nvarchar12], 
				EquipData.[nvarchar13], 
				EquipData.[nvarchar14], 
				EquipData.[nvarchar15], 
				EquipData.[nvarchar16], 
				EquipData.[nvarchar17], 
				EquipData.[nvarchar18], 
				EquipData.[nvarchar19], 
				EquipData.[nvarchar20], 
				EquipData.[nvarchar21], 
				EquipData.[nvarchar22], 
				EquipData.[nvarchar23], 
				EquipData.[nvarchar24], 
				EquipData.[nvarchar25], 
				EquipData.[nvarchar26], 
				EquipData.[nvarchar27], 
				EquipData.[nvarchar28], 
				EquipData.[nvarchar29], 
				EquipData.[nvarchar30], 
				EquipData.[nvarchar31], 
				EquipData.[nvarchar32], 
				EquipData.[int1], 
				EquipData.[int2], 
				EquipData.[int3], 
				EquipData.[int4], 
				EquipData.[int5], 
				EquipData.[int6], 
				EquipData.[int7], 
				EquipData.[int8], 
				EquipData.[lookup1], 
				EquipData.[lookup2], 
				EquipData.[lookup3], 
				EquipData.[lookup4], 
				EquipData.[lookup5], 
				EquipData.[lookup6], 
				EquipData.[lookup7], 
				EquipData.[lookup8], 
				EquipData.[float1], 
				EquipData.[float2], 
				EquipData.[float3], 
				EquipData.[float4], 
				EquipData.[float5], 
				EquipData.[float6], 
				EquipData.[float7], 
				EquipData.[float8], 
				EquipData.[datetime1], 
				EquipData.[datetime2], 
				EquipData.[datetime3], 
				EquipData.[datetime4], 
				EquipData.[datetime5], 
				EquipData.[datetime6], 
				EquipData.[datetime7],
				EquipData.[datetime8],
				EquipData.[bit1],
				EquipData.[bit2],
				EquipData.[bit3],
				EquipData.[bit4],
				EquipData.[bit5],
				EquipData.[bit6], 
				EquipData.[bit7], 
				EquipData.[bit8] 
			from EquipComponents
			inner join EquipData
			on EquipData.[Id] = EquipComponents.DataId
			and EquipData.OrgId = EquipComponents.OrgId 
			and EquipComponents.[Id] = @Id
			and EquipComponents.[OrgId] = @OrgId
			inner join EquipComponentTypes 
			on EquipComponentTypes.[Id] = EquipComponents.TypeId
			and EquipComponentTypes.OrgId = EquipComponents.OrgId
			left join Logins
			on EquipData.intUpdatedBy = Logins.[Id]
			
	
			return 0
		end
	end
	if @Action='U'
	begin -- 
		if @Id = 0
		begin -- insert
			-- insert EquipData and Component
			insert into [EquipData](
				[OrgId], 
				[intCreatedBy], 
				[dtCreated], 
				[intUpdatedBy], 
				[dtUpdated], 
				[vchOrdering], 
				[ftItemOrder], 
				[intSize], 
				[nvarchar1], 
				[nvarchar2], 
				[nvarchar3], 
				[nvarchar4], 
				[nvarchar5], 
				[nvarchar6], 
				[nvarchar7], 
				[nvarchar8], 
				[nvarchar9], 
				[nvarchar10], 
				[nvarchar11], 
				[nvarchar12], 
				[nvarchar13], 
				[nvarchar14], 
				[nvarchar15], 
				[nvarchar16], 
				[nvarchar17], 
				[nvarchar18], 
				[nvarchar19], 
				[nvarchar20], 
				[nvarchar21], 
				[nvarchar22], 
				[nvarchar23], 
				[nvarchar24], 
				[nvarchar25], 
				[nvarchar26], 
				[nvarchar27], 
				[nvarchar28], 
				[nvarchar29], 
				[nvarchar30], 
				[nvarchar31], 
				[nvarchar32], 
				[int1], 
				[int2], 
				[int3], 
				[int4], 
				[int5], 
				[int6], 
				[int7], 
				[int8], 
				[lookup1], 
				[lookup2], 
				[lookup3], 
				[lookup4], 
				[lookup5], 
				[lookup6], 
				[lookup7], 
				[lookup8], 
				[float1], 
				[float2], 
				[float3], 
				[float4], 
				[float5], 
				[float6], 
				[float7], 
				[float8], 
				[datetime1], 
				[datetime2], 
				[datetime3], 
				[datetime4], 
				[datetime5], 
				[datetime6], 
				[datetime7], 
				[datetime8], 
				[bit1], 
				[bit2], 
				[bit3], 
				[bit4], 
				[bit5], 
				[bit6], 
				[bit7], 
				[bit8]
				)
			values(
				@OrgId,
				@UserId,
				getutcdate(),
				@UserId,
				getutcdate(),
				null, 
				null, 
				0,
				@nvarchar1,
				@nvarchar2,
				@nvarchar3,
				@nvarchar4,
				@nvarchar5,
				@nvarchar6,
				@nvarchar7,
				@nvarchar8,
				@nvarchar9,
				@nvarchar10,
				@nvarchar11,
				@nvarchar12,
				@nvarchar13,
				@nvarchar14,
				@nvarchar15,
				@nvarchar16,
				@nvarchar17,
				@nvarchar18,
				@nvarchar19,
				@nvarchar20,
				@nvarchar21,
				@nvarchar22,
				@nvarchar23,
				@nvarchar24,
				@nvarchar25,
				@nvarchar26,
				@nvarchar27,
				@nvarchar28,
				@nvarchar29,
				@nvarchar30,
				@nvarchar31,
				@nvarchar32,
				@int1,
				@int2,
				@int3,
				@int4,
				@int5,
				@int6,
				@int7,
				@int8,
				@lookup1,
				@lookup2,
				@lookup3,
				@lookup4,
				@lookup5,
				@lookup6,
				@lookup7,
				@lookup8,
				@float1,
				@float2,
				@float3,
				@float4,
				@float5,
				@float6,
				@float7,
				@float8,
				@datetime1,
				@datetime2,
				@datetime3,
				@datetime4,
				@datetime5,
				@datetime6,
				@datetime7,
				@datetime8,
				@bit1,
				@bit2,
				@bit3,
				@bit4,
				@bit5,
				@bit6,
				@bit7,
				@bit8
				)
			select @DataId = scope_identity()
			
			-- unactivation the another components with same type
			if ISNULL(@btActive, 0) = 1
			begin
				update EquipComponents
				set btActive = 0
				where EquipId = @EquipId
				and TypeId = @TypeId
				and OrgId = @OrgId
				and btActive = 1
			end
			insert into [EquipComponents](
				[OrgId], 
				[TypeId], 
				[EquipId], 
				[DataId], 
				[btActive]
				)
			values(
				@OrgId,
				@TypeId,
				@EquipId,
				@DataId,
				@btActive
				)
			return scope_identity()
		end
		else
		begin -- update EquipData
			if not exists(select 'true' from EquipComponents where [Id] = @Id and [OrgId] = @OrgId)
			begin
				return -1
			end
			else
			begin
				-- unactivation the another components with same type
				if isnull(@btActive, 0) = 1
				begin
					update EquipComponents
					set btActive = 0
					where EquipId = @EquipId
					and TypeId = @TypeId
					and OrgId = @OrgId
					and btActive = 1
				end
				update 	EquipComponents
				set	btActive=@btActive
				where 	[Id] = @Id
				and 	[OrgId] = @OrgId
				update 	[EquipData]
				set 	[OrgId]=@OrgId,
					[intUpdatedBy]=@UserId,
					[dtUpdated]=getutcdate(),
					[nvarchar1]=@nvarchar1,
					[nvarchar2]=@nvarchar2,
					[nvarchar3]=@nvarchar3,
					[nvarchar4]=@nvarchar4,
					[nvarchar5]=@nvarchar5,
					[nvarchar6]=@nvarchar6,
					[nvarchar7]=@nvarchar7,
					[nvarchar8]=@nvarchar8,
					[nvarchar9]=@nvarchar9,
					[nvarchar10]=@nvarchar10,
					[nvarchar11]=@nvarchar11,
					[nvarchar12]=@nvarchar12,
					[nvarchar13]=@nvarchar13,
					[nvarchar14]=@nvarchar14,
					[nvarchar15]=@nvarchar15,
					[nvarchar16]=@nvarchar16,
					[nvarchar17]=@nvarchar17,
					[nvarchar18]=@nvarchar18,
					[nvarchar19]=@nvarchar19,
					[nvarchar20]=@nvarchar20,
					[nvarchar21]=@nvarchar21,
					[nvarchar22]=@nvarchar22,
					[nvarchar23]=@nvarchar23,
					[nvarchar24]=@nvarchar24,
					[nvarchar25]=@nvarchar25,
					[nvarchar26]=@nvarchar26,
					[nvarchar27]=@nvarchar27,
					[nvarchar28]=@nvarchar28,
					[nvarchar29]=@nvarchar29,
					[nvarchar30]=@nvarchar30,
					[nvarchar31]=@nvarchar31,
					[nvarchar32]=@nvarchar32,
					[int1]=@int1,
					[int2]=@int2,
					[int3]=@int3,
					[int4]=@int4,
					[int5]=@int5,
					[int6]=@int6,
					[int7]=@int7,
					[int8]=@int8,
					[lookup1]=@lookup1,
					[lookup2]=@lookup2,
					[lookup3]=@lookup3,
					[lookup4]=@lookup4,
					[lookup5]=@lookup5,
					[lookup6]=@lookup6,
					[lookup7]=@lookup7,
					[lookup8]=@lookup8,
					[float1]=@float1,
					[float2]=@float2,
					[float3]=@float3,
					[float4]=@float4,
					[float5]=@float5,
					[float6]=@float6,
					[float7]=@float7,
					[float8]=@float8,
					[datetime1]=@datetime1,
					[datetime2]=@datetime2,
					[datetime3]=@datetime3,
					[datetime4]=@datetime4,
					[datetime5]=@datetime5,
					[datetime6]=@datetime6,
					[datetime7]=@datetime7,
					[datetime8]=@datetime8,
					[bit1]=@bit1,
					[bit2]=@bit2,
					[bit3]=@bit3,
					[bit4]=@bit4,
					[bit5]=@bit5,
					[bit6]=@bit6,
					[bit7]=@bit7,
					[bit8]=@bit8
				from 	EquipComponents
				where	EquipComponents.[Id] = @Id
				and 	EquipComponents.[OrgId] = @OrgId
				and 	EquipData.[Id] = EquipComponents.[DataId]
				return 0
			end
		end
	end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

