begin tran

update EquipAssignLogs
set IsTemp = 1
where vchNote like 'checking out the spare equipment'
or vchNote like 'checking in the spare equipment'

begin tran

update 	Equipments
set 	TempOperatorId = EquipOperatorId,
	EquipOperatorId = null
where 	bitSpare = 1

--select * from Equipments where bitSpare = 1
-- select * from EquipAssignLogs

declare @PageId int
declare @PermissionId int

insert into [Pages]([vchPageName])
values('e_selectTempOperator.aspx')

select @PageId = scope_identity()

insert into [Pages_Permissions]([PageId], [PermissionId])
values(@PageId, 3)

insert into [Pages]([vchPageName])
values('e_viewTempOperatorReport.aspx')

select @PageId = scope_identity()

insert into [dbo].[Permissions]([vchName], [chCode])
values('Can view Equipment Reports', 'CER')

select @PermissionId = scope_identity()

insert into [Pages_Permissions]([PageId], [PermissionId])
values(@PageId, @PermissionId)

insert into [dbo].[Groups_Permissions]([OrgId], [GroupId], [PermissionId])
select 1, 1, @PermissionId
union all
select 1, 2, @PermissionId
union all
select 1, 3, @PermissionId

insert into [Pages]([vchPageName])
values('e_viewEquipAssignmentReport.aspx')

select @PageId = scope_identity()

insert into [Pages_Permissions]([PageId], [PermissionId])
values(@PageId, @PermissionId)

insert into [Pages]([vchPageName])
values('wo_deleteWorkOrder.aspx')

select @PageId = scope_identity()

insert into [Pages_Permissions]([PageId], [PermissionId])
values(@PageId, 12)

update [Permissions]
set vchName = 'Can close/delete Work Order'
where [Id] = 12 

commit
--rollback