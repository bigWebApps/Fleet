SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


ALTER   procedure sp_SelectInspectionsListForWorkOrder
	(
		@OrderId int,
		@OrgId int
	)
as
	set nocount on

	declare @EquipId int

	select 	@EquipId = EquipId
	from 	WorkOrders 
	where 	[Id] = @OrderId
	and 	OrgId = @OrgId

	select 	I.[Id],
		isnull(WOI.[Id], 0) as ItemId,
		@OrderId as WorkOrderId,
		isnull(EIH.[Id], 0) as HistoryId,
		case when isnull(WOI.[Id], 0) = 0 then 'False' else 'True' end as IsChecked,
		case when isnull(WOI.btIsProcessed, 0) = 0 then 'True' else 'False' end  as IsCompeted,
		I.vchName,
		case when isnull(EIH.[Id], 0) = 0 then 'No Service History'
		else 	case when (I.intFrequencyDays - datediff(day, EIH.dtDate, getdate())) > 0 then 
				case when (I.intFrequencyDays - datediff(day, EIH.dtDate, getdate())) > 7 then 'Okay' 
				else 'Due Soon' end 
			else 'Due' end
		end as StatusName,
		case when isnull(EIH.[Id], 0) = 0 then ''
		else convert(varchar, dateadd(day, (I.intFrequencyDays - datediff(day, EIH.dtDate, getdate())), getdate()), 101)
		end as DateDue,
		case when isnull(I.intFrequencyDays, -1) <> -1 then 
			convert(varchar, intFrequencyDays) + ' days' 
		else '' end as TimeInterval,
		case when isnull(EIH.[Id], 0) = 0 then ''
		else convert(varchar, EIH.dtDate, 101)
		end as DateLastInspected,
		case when isnull(EIH.[Id], 0) <> 0 then 'False' else 'True' end as VisibleLink,
		case when isnull(EIH.[Id], 0) <> 0 then 'black' else 'red' end as Color
	from Inspections I
	left join EquipInspectHistory EIH
	on EIH.EquipId = @EquipId
	and I.OrgId = EIH.OrgId
	and I.[Id] = EIH.InspectionId
	and EIH.[Id] in ( 
		select EIH_D.[Id]
		from EquipInspectHistory EIH_D
		inner join (
			select max([Id]) m, InspectionId
			from EquipInspectHistory
			where EquipId = @EquipId
			and OrgId = @OrgId
			group by InspectionId
			) EIH_G
		on EIH_D.InspectionId = EIH_G.InspectionId
		and EIH_D.[Id] = EIH_G.m
		)
	left outer join WorkOrderInspections WOI
	on WOI.InspectId = I.[Id]
	and WOI.OrgId = I.OrgId
	and WOI.WorkOrderId = @OrderId
	where I.OrgId = @OrgId
	order by I.[Id] asc



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

