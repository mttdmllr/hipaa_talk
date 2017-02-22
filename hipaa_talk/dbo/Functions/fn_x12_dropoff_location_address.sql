CREATE FUNCTION [dbo].[fn_x12_dropoff_location_address] (@x12_interchange_uid uniqueidentifier)
RETURNS varchar(128) AS  
/*********************
-- START DOC --
FUNCTION: fn_x12_dropoff_location_address
	Parameter:	[IN] @x12_interchange_uid uniqueidentifier
			[RETURN] @fn_x12_dropoff_location_address varchar(128)
	Type:		int
	
	Characteristic:	NOT DETERMINISTIC
	Description:	Returns the location_address for the destination of the outbound transaction
	
	Example:	select dbo.fn_x12_dropoff_location_address('EB28062C-866B-474B-ABD5-6AACF3E442B9') -- Returns the full path name of the dropoff location for this transaction
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
	declare @outbound_filename varchar(128)
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

	if (@x12_transaction_schema_id IS NULL)
	begin
		select @x12_transaction_schema_id = x12_transaction_schema_id
		from x12_transaction_schema
		where	x12_transaction_schema_ud = 'X12_4010_TA1'
			AND exists (select x12_ta1_interchange_ack_id
				FROM x12_ta1_interchange_ack
				INNER JOIN x12_interchange
					ON x12_interchange.x12_interchange_id = x12_ta1_interchange_ack.x12_interchange_id
				where x12_interchange.x12_interchange_uid = @x12_interchange_uid
				)
	end

	-- Get the organization names for use in the outbound file naming function.
	select @dest_x12_organization_ud = x12_organization_ud from x12_organization where x12_organization_id = @dest_x12_organization_id
	select @src_x12_organization_ud = x12_organization_ud from x12_organization where x12_organization_id = @src_x12_organization_id
	select @transaction_id_code = transaction_id_code from x12_transaction_schema where x12_transaction_schema_id = @x12_transaction_schema_id
	
	-- get the dropoff location for delivery of outgoing documents of this type
	select	TOP 1
		@location_address = location_address,
		@outbound_filename = outbound_filename
	from x12_organization_drop_location
	inner join x12_location
		on x12_organization_drop_location.x12_location_id = x12_location.x12_location_id
	where	src_x12_organization_id = @src_x12_organization_id AND
		dest_x12_organization_id = @dest_x12_organization_id AND
		(	x12_transaction_schema_id = @x12_transaction_schema_id OR
			x12_transaction_schema_id IS NULL
		)
	ORDER BY x12_transaction_schema_id desc
	
	-- if the dropoff location was NOT found, try again where the SOURCE is NULL
	if (@location_address IS NULL)
	begin
		select	TOP 1
			@location_address = location_address,
			@outbound_filename = outbound_filename
		from x12_organization_drop_location
		inner join x12_location
			on x12_organization_drop_location.x12_location_id = x12_location.x12_location_id
		where	dest_x12_organization_id = @dest_x12_organization_id AND
			src_x12_organization_id IS NULL AND
			(	x12_transaction_schema_id = @x12_transaction_schema_id OR
				x12_transaction_schema_id IS NULL
			)
		ORDER BY x12_transaction_schema_id desc
	end
	
	-- if the dropoff location was NOT found, try again where the DESTINATION is NULL
	if (@location_address IS NULL)
	begin
		select	TOP 1
			@location_address = location_address,
			@outbound_filename = outbound_filename
		from x12_organization_drop_location
		inner join x12_location
			on x12_organization_drop_location.x12_location_id = x12_location.x12_location_id
		where	src_x12_organization_id = @src_x12_organization_id AND
			dest_x12_organization_id IS NULL AND
			(	x12_transaction_schema_id = @x12_transaction_schema_id OR
				x12_transaction_schema_id IS NULL
			)
		ORDER BY x12_transaction_schema_id desc
	end
	
	-- if the dropoff location was NOT found, try again where BOTH the SOURCE and DESTINATION are NULL
	if (@location_address IS NULL)
	begin
		select	TOP 1
			@location_address = location_address,
			@outbound_filename = outbound_filename
		from x12_organization_drop_location
		inner join x12_location
			on x12_organization_drop_location.x12_location_id = x12_location.x12_location_id
		where	dest_x12_organization_id IS NULL AND
			src_x12_organization_id IS NULL AND
			(	x12_transaction_schema_id = @x12_transaction_schema_id OR
				x12_transaction_schema_id IS NULL
			)
		ORDER BY x12_transaction_schema_id desc
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









