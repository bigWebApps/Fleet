SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER   PROCEDURE sp_SelectPagesList
	(
	@OrgId int
	)
AS
	set nocount on

	declare @PageId int
	declare @N int
	declare @M int
	declare @i int
	declare @j int
	declare @vchGroupList varchar(512)

	create table #t_Pages(
		t_id int identity(1,1),
		t_PageId int,
		t_vchPageName varchar(150),
		t_vchGroupList varchar(512)
	)
	
	insert into #t_Pages(t_PageId, t_vchPageName)
	select [Id], vchPageName
	from Pages
	
	select @N = scope_identity()
	
	select @i = 0
	
	while @i <= @N
	begin
		select @i = @i + 1
	
		select @PageId = t_PageId 
		from #t_Pages tP
		where tP.t_id = @i
	
		create table #t_Groups(
			t_id int identity(1, 1),
			t_vchDesc varchar(50)
		)
	
		insert #t_Groups(t_vchDesc)
		select distinct G.vchDesc 
		from Groups G
		inner join Groups_Permissions GP
		on G.[Id] = GP.GroupId
		and G.OrgId = GP.OrgId
		and G.OrgId = @OrgId
		inner join Pages_Permissions PP
		on PP.PermissionId = GP.PermissionId
		and PP.PageId = @PageId
	
		select @M = scope_identity()
		select @j = 0
		select @vchGroupList = ''
	
		while @j<=@M 
		begin
			select @j = @j + 1
	
			select @vchGroupList = @vchGroupList + ';' + t_vchDesc 
			from #t_Groups
			where t_id = @j
		end
	
		update #t_Pages
		set t_vchGroupList = substring(@vchGroupList, 2, len(@vchGroupList))
		where t_id = @i
	
		drop table #t_Groups	
	end
	
	select 	t_PageId as [Id],
		t_vchPageName as vchPageName,
		t_vchGroupList as vchGroupList
	from #t_Pages
	
	drop table #t_Pages

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

