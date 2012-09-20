declare @PageId int

insert into [Pages]([vchPageName])
values('wo_viewEquipWorkOrderReport.aspx')

select @PageId = scope_identity()

insert into [Pages_Permissions]([PageId], [PermissionId])
values(@PageId, 15)


