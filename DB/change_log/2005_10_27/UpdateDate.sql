use BFS_Beta

update 	Orgs
set 	vchFullName = 'WALKER COUNTY DEPARTMENT OF EDUCATION'
where 	[Id] = 1

select upper(O.vchFullName) from Orgs O
