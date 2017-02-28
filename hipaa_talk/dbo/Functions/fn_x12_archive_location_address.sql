CREATE FUNCTION [dbo].[fn_x12_archive_location_address] (@x12_interchange_uid uniqueidentifier)
RETURNS varchar(128) AS  
/*********************
-- START DOC --
FUNCTION: fn_x12_archive_location_address
	Parameter:	[IN] @x12_interchange_uid uniqueidentifier
			[RETURN] @fn_x12_archive_location_address varchar(128)
	Type:		int
	
	Characteristic:	NOT DETERMINISTIC
	Description:	Returns the location_address for the destination and file name of the archival of the incoming transaction
	
	Example:	select dbo.fn_x12_archive_location_address('EB28062C-866B-474B-ABD5-6AACF3E442B9') -- Returns the full path name of the archive location for this transaction
-- END DOC --
*********************/
BEGIN
	declare @x12_transaction_schema_id int
	declare @transaction_id_code varchar(32)

	declare @dest_x12_organization_id int
	declare @src_x12_organization_id int
	declare @dest_x12_organization_ud varchar(32)
	declare @src_x12_organization_ud varchar(32)
	declare @isa06_sender_id char(15)
	declare @isa08_receiver_id char(15)
	declare @location_address varchar(128)
	declare @incoming_filename varchar(128)
	declare @outbound_filename varchar(256)
	declare @created_date datetime

	select	@dest_x12_organization_id = x12_interchange.dest_x12_organization_id,
		@src_x12_organization_id = x12_interchange.src_x12_organization_id,
		@isa06_sender_id = x12_interchange.isa06_sender_id,
		@isa08_receiver_id = x12_interchange.isa08_receiver_id,
		@x12_transaction_schema_id = x12_functional_group.x12_transaction_schema_id,
		@incoming_filename = dbo.fn_FileFromPath(x12_interchange.filename),
		@created_date = x12_interchange.created_date
	from x12_interchange
	left join x12_functional_group
		ON x12_interchange.x12_interchange_id = x12_functional_group.x12_interchange_id
	where x12_interchange_uid = @x12_interchange_uid

	-- Get the organization names for use in the outbound file naming function.
	select @dest_x12_organization_ud = x12_organization_ud from x12_organization where x12_organization_id = @dest_x12_organization_id
	select @src_x12_organization_ud = x12_organization_ud from x12_organization where x12_organization_id = @src_x12_organization_id
	select @transaction_id_code = transaction_id_code from x12_transaction_schema where x12_transaction_schema_id = @x12_transaction_schema_id
	
	-- get the archive location for delivery of outgoing documents of this type
	select	@location_address = location_address,
		@outbound_filename = outbound_filename
	from x12_organization_archive_location
	inner join x12_location
		on x12_organization_archive_location.x12_location_id = x12_location.x12_location_id
	where	src_x12_organization_id = @src_x12_organization_id AND
		dest_x12_organization_id = @dest_x12_organization_id AND
		x12_transaction_schema_id = @x12_transaction_schema_id
	
	-- if the archive location was NOT found, try again where the DESTINATION ORGANIZATION is NULL
	if (@location_address IS NULL)
	begin
		select	@location_address = location_address,
			@outbound_filename = outbound_filename
		from x12_organization_archive_location
		inner join x12_location
			on x12_organization_archive_location.x12_location_id = x12_location.x12_location_id
		where	src_x12_organization_id = @src_x12_organization_id AND
			dest_x12_organization_id IS NULL AND
			x12_transaction_schema_id = @x12_transaction_schema_id
	end
	
	-- if the archive location was NOT found, try again where the SOURCE ORGANIZATION is NULL
	if (@location_address IS NULL)
	begin
		select	@location_address = location_address,
			@outbound_filename = outbound_filename
		from x12_organization_archive_location
		inner join x12_location
			on x12_organization_archive_location.x12_location_id = x12_location.x12_location_id
		where	dest_x12_organization_id = @dest_x12_organization_id AND
			src_x12_organization_id IS NULL AND
			x12_transaction_schema_id = @x12_transaction_schema_id
	end
	
	-- if the archive location was NOT found, try again where BOTH the SOURCE and DESTINATION ORGANIZATIONS are NULL
	if (@location_address IS NULL)
	begin
		select	@location_address = location_address,
			@outbound_filename = outbound_filename
		from x12_organization_archive_location
		inner join x12_location
			on x12_organization_archive_location.x12_location_id = x12_location.x12_location_id
		where	dest_x12_organization_id IS NULL AND
			src_x12_organization_id IS NULL AND
			x12_transaction_schema_id = @x12_transaction_schema_id
	end

if (@outbound_filename IS NULL)
begin
	set @outbound_filename = IsNull(@incoming_filename, '') + '_' + LTRIM(RTRIM(CONVERT(varchar(64), @x12_interchange_uid)))
end
else
begin
	set @outbound_filename = REPLACE(@outbound_filename, '#filename#', IsNull(@incoming_filename, 'ERR-FILENAME'))
	set @outbound_filename = REPLACE(@outbound_filename, '#datetime#', REPLACE(REPLACE(REPLACE(convert(char(23), @created_date, 120), ':', ''), '-', ''), ' ', ''))
	set @outbound_filename = REPLACE(@outbound_filename, '#destorgname#', IsNull(@dest_x12_organization_ud, 'ERR-DEST-ORG'))
	set @outbound_filename = REPLACE(@outbound_filename, '#srcorgname#', IsNull(@src_x12_organization_ud, 'ERR-SRC-ORG'))
	set @outbound_filename = REPLACE(@outbound_filename, '#senderid#', IsNull(@isa06_sender_id, 'ERR-SENDER-ID'))
	set @outbound_filename = REPLACE(@outbound_filename, '#receiverid#', IsNull(@isa08_receiver_id, 'ERR-RECEIVER-ID'))
	set @outbound_filename = REPLACE(@outbound_filename, '#tranidcode#', IsNull(@transaction_id_code, ''))
end

RETURN IsNull(@location_address, '') + '\' + IsNull(@outbound_filename, '')

END












