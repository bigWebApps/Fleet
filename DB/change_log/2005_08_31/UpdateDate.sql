
insert into dbo.[InspectionItems_PMSchedDetails]([OrgId], [InspectItemId], [PMSchedDetailId])
select 1, 43, 3
union all
select 1, 43, 23
union all
select 1, 43, 32
union all
select 1, 44, 2
union all
select 1, 44, 22
union all
select 1, 44, 31


insert into [dbo].[Holidays]([OrgId], [dtStartDate], [dtEndDate], [vchDesc], [intPercentOff])
select 1, '9/12/2005 12:00AM', ' 9/12/2005 11:59PM', 'Staff Meeting', 50
union all
select 1, '10/10/2005 12:00AM', ' 10/10/2005 11:59PM', 'Columbus Day', 100
union all
select 1, '11/24/2005 12:00AM', ' 11/24/2005 11:59PM', 'Thanksgiving Day', 100
union all
select 1, '12/14/2005 12:00AM', ' 1/2/2006 11:59PM', 'Christmas', 100

select * from dbo.Holidays

declare @PageId int

insert into [Pages]([vchPageName])
values('wo_showEquipsForInspect.aspx')

select @PageId = scope_identity()

insert into [Pages_Permissions]([PageId], [PermissionId])
values(@PageId, 10)

insert into [Pages]([vchPageName])
values('wo_addInspectForecast.aspx')

select @PageId = scope_identity()

insert into [Pages_Permissions]([PageId], [PermissionId])
values(@PageId, 10)