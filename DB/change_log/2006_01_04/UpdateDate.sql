declare @PageId int

insert into [Pages]([vchPageName])
values('ok_mainMenu2.aspx')

select @PageId = scope_identity()

insert into [Pages_Permissions]([PageId], [PermissionId])
values(@PageId, 14)
