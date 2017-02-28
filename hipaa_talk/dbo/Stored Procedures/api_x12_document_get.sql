
CREATE PROCEDURE [dbo].[api_x12_document_get]
    (
		@x12_interchange_uid uniqueidentifier = null,
		@x12_document_id int = null
    )
AS 
    SET NOCOUNT ON		    -- we do not need to track the number of rows returned (saves time).
    SET XACT_ABORT OFF		-- we want subsequent procedures to be called in the event of an error.

	declare @ptrval binary(16)
	declare @contentLen int
	
	if not exists (select x12_document_id from x12_document
					where x12_document_uid = @x12_interchange_uid)
	begin
		exec up_x12_document_export	@x12_interchange_uid = @x12_interchange_uid,
									@x12_document_id = @x12_document_id
	end

	select	@ptrval = TEXTPTR(filedata),
			@contentLen = DATALENGTH(filedata)
	from x12_document
	where	x12_document_uid = @x12_interchange_uid OR
			x12_document_id = @x12_document_id

	if (@contentLen > 0 AND TEXTVALID('x12_document.filedata', @ptrVal) = 1 )
	begin
		READTEXT x12_document.filedata @ptrVal 0 @contentLen
		return
	end
	else
	begin
		select 'ERROR GENERATING X12 DOCUMENT' as filedata
	end

