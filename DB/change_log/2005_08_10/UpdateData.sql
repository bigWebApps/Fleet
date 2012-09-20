
declare @PageId int

insert into [Pages]([vchPageName])
values('wo_viewDates.aspx')

select @PageId = scope_identity()

insert into [Pages_Permissions]([PageId], [PermissionId])
values(@PageId, 10)

update Equipments
set DeptId = 1

delete from Departments where [Id] <> 1

insert into OperatorInstructions(OrgId, TypeId, vchNote)
values(1, 3, 'Please remember to go through the Departure Check-Out process when your bus has been serviced')