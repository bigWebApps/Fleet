declare @PageId int

insert into [Pages]([vchPageName])
values('admin_holidays.aspx')

select @PageId = scope_identity()

insert into [Pages_Permissions]([PageId], [PermissionId])
values(@PageId, 7)

insert into [Pages]([vchPageName])
values('admin_inspections.aspx')

select @PageId = scope_identity()

insert into [Pages_Permissions]([PageId], [PermissionId])
values(@PageId, 7)

insert into [Pages]([vchPageName])
values('admin_inspections_items.aspx')

select @PageId = scope_identity()

insert into [Pages_Permissions]([PageId], [PermissionId])
values(@PageId, 7)

insert into [Pages]([vchPageName])
values('admin_inspection_item_edit.aspx')

select @PageId = scope_identity()

insert into [Pages_Permissions]([PageId], [PermissionId])
values(@PageId, 7)

insert into [Pages]([vchPageName])
values('admin_inspection_category_edit.aspx')

select @PageId = scope_identity()

insert into [Pages_Permissions]([PageId], [PermissionId])
values(@PageId, 7)

insert into [Pages]([vchPageName])
values('admin_inspectschedules.aspx')

select @PageId = scope_identity()

insert into [Pages_Permissions]([PageId], [PermissionId])
values(@PageId, 7)

insert into [Pages]([vchPageName])
values('admin_inspectschedule_detail.aspx')

select @PageId = scope_identity()

insert into [Pages_Permissions]([PageId], [PermissionId])
values(@PageId, 7)

insert into [Pages]([vchPageName])
values('admin_inspectschedule_detail_edit.aspx')

select @PageId = scope_identity()

insert into [Pages_Permissions]([PageId], [PermissionId])
values(@PageId, 7)
