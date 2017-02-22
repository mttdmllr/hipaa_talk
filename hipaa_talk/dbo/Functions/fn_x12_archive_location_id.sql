CREATE FUNCTION [dbo].[fn_x12_archive_location_id] (@x12_interchange_uid uniqueidentifier)
RETURNS int AS  

/*********************
-- START DOC --
FUNCTION: fn_x12_archive_location_id

	Parameter:	[IN] @x12_interchange_uid uniqueidentifier
			[RETURN] @archive_x12_location_id int 

	Type:		int
	
	Characteristic:	NOT DETERMINISTIC

	Description:	Returns the x12_location_id for the destination of the archival of the incoming transaction
	
	Example:	select dbo.fn_x12_archive_location_id('EB28062C-866B-474B-ABD5-6AACF3E442B9') -- Returns an integer of the x12_location_id for this transaction
-- END DOC --
*********************/

BEGIN
	declare @dest_x12_organization_id int
	declare @src_x12_organization_id int
	declare @archive_x12_location_id int
	declare @x12_transaction_schema_id int
	
	select	@dest_x12_organization_id = dest_x12_organization_id,
		@src_x12_organization_id = src_x12_organization_id,
		@x12_transaction_schema_id = x12_transaction_schema_id
	from x12_interchange
	inner join x12_functional_group
		ON x12_interchange.x12_interchange_id = x12_functional_group.x12_interchange_id
	where x12_interchange_uid = @x12_interchange_uid
	
	-- get the archive location for delivery of outgoing documents of this type
	select @archive_x12_location_id = x12_location_id from x12_organization_archive_location
	where	src_x12_organization_id = @src_x12_organization_id AND
		dest_x12_organization_id = @dest_x12_organization_id AND
		x12_transaction_schema_id = @x12_transaction_schema_id
	
	-- if the archive location was NOT found, try again where the DESTINATION is NULL
	if (@archive_x12_location_id IS NULL)
	begin
		select @archive_x12_location_id = x12_location_id from x12_organization_archive_location
		where	src_x12_organization_id = @src_x12_organization_id AND
			dest_x12_organization_id IS NULL AND
			x12_transaction_schema_id = @x12_transaction_schema_id
	end
	
	-- if the archive location was NOT found, try again where the SOURCE is NULL
	if (@archive_x12_location_id IS NULL)
	begin
		select @archive_x12_location_id = x12_location_id from x12_organization_archive_location
		where	dest_x12_organization_id = @dest_x12_organization_id AND
			src_x12_organization_id IS NULL AND
			x12_transaction_schema_id = @x12_transaction_schema_id
	end
	
	-- if the archive location was NOT found, try again where BOTH the SOURCE and DESTINATION are NULL
	if (@archive_x12_location_id IS NULL)
	begin
		select @archive_x12_location_id = x12_location_id from x12_organization_archive_location
		where	dest_x12_organization_id IS NULL AND
			src_x12_organization_id IS NULL AND
			x12_transaction_schema_id = @x12_transaction_schema_id
	end


RETURN @archive_x12_location_id

END









