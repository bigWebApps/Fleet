SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

alter procedure sp_GetSignedDocument
	(
		@OrgId int,
		@DocumentId int,
		@DocumentTypeId int,
		@vchUserName varchar(102)=null output,
		@chInitials char(3)=null output,
		@dtSignDate datetime=null output
	)
AS
	set nocount on
	
	if not exists(select 'true' from SignedDocuments where [DocumentId] = @DocumentId and [DocumentTypeId] = @DocumentTypeId and OrgId = @OrgId)
	begin
		return -1
	end
	else
	begin
		select 	@vchUserName = L.vchLastName + ', ' + L.vchFirstName,
			@chInitials = upper(L.Initials),
			@dtSignDate = SD.dtSignDate
		from 	SignedDocuments SD
		inner 	join Logins L
		on 	SD.[DocumentId] = @DocumentId 
		and 	SD.[DocumentTypeId] = @DocumentTypeId 
		and 	SD.OrgId = @OrgId
		and 	SD.UserId = L.[Id]

		return 0
	end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

