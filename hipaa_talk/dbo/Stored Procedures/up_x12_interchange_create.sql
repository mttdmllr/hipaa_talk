



CREATE Procedure [dbo].[up_x12_interchange_create]
		(	@x12_interchange_id int = null output,
			@x12_interchange_uid uniqueidentifier = null,
			@x12_interchange_status_id int,
			@src_x12_organization_id int = null,
			@dest_x12_organization_id int = null,
			@isa01_auth_info_qual char (2) = null,
			@isa02_auth_info char (10) = null,
			@isa03_security_info_qual char (2) = null,
			@isa04_security_info char (10) = null,
			@isa05_sender_id_qual char (2) = null,
			@isa06_sender_id char (15) = null,
			@isa07_receiver_id_qual char (2) = null,
			@isa08_receiver_id char (15) = null,
			@isa09_interchange_date char (6) = null,
			@isa10_interchange_time char (4) = null,
			@isa11_control_standards_id char (1) = null,
			@isa12_control_version_no char (5) = null,
			@isa13_control_no char (9) = null,
			@isa14_ack_requested char (1) = null,
			@isa15_usage_indicator char (1) = null,
			@isa16_component_element_seperator char(1) = null,
			@element_separator char(1) = null,
			@segment_separator varchar(3) = null,
			@x12_parse_temp_id_start int = null,
			@x12_parse_temp_id_end int = null,
			@filename varchar (512) = null,
			@incoming bit = 0,
			@outgoing bit = 0,
			@error bit = 0,
			@processed bit = 0,
			@active bit = 1
		)
As
/*********************
-- START DOC --
PROCEDURE: up_x12_interchange_create 
	Parameter:	[IN/OUT] @x12_interchange_id int = null output,
			[IN] @x12_interchange_uid uniqueidentifier,
			[IN[ @x12_interchange_status_id int,
			[IN] @isa01_auth_info_qual char (2),
			[IN] @isa02_auth_info char (10),
			[IN] @isa03_security_info_qual char (2),
			[IN] @isa04_security_info char (10),
			[IN] @isa05_sender_id_qual char (2),
			[IN] @isa06_sender_id char (15),
			[IN] @isa07_receiver_id_qual char (2),
			[IN] @isa08_receiver_id char (15),
			[IN] @isa09_interchange_date char (6),
			[IN] @isa10_interchange_time char (4),
			[IN] @isa11_control_standards_id char (1),
			[IN] @isa12_control_version_no char (5),
			[IN] @isa13_control_no char (9),
			[IN] @isa14_ack_requested char (1),
			[IN] @isa15_usage_indicator char (1),
			[IN] @isa16_component_element_seperator char(1),
			[IN] @x12_parse_temp_id_start int = null,
			[IN] @x12_parse_temp_id_end int = null,
			[IN] @filename varchar (512) = null,
			[IN] @incoming bit = 0,
			[IN] @outgoing bit = 0,
			[IN] @error bit = 0,
			[IN] @processed bit = 0,
			[IN] @active bit = 1
	Type:		INSERT (single record)
	Description:	This stored procedure creates a single ISA record in the x12_interchange table to be used to sending or receiving X12 documents.  It returns the newly created
			x12_interchange_id integer value in the @x12_interchange_id variable.
	Usage:		declare @x12_interchange_id int
			exec up_x12_interchange_create		@x12_interchange_id = @x12_interchange_id output,
								@isa06_sender_id = 'tp000089',
								@isa08_receiver_id = 'ORDHSOMAP',
								@outgoing = 1
	
-- END DOC --
*********************/
	declare @x12_transaction_schema_id int
	declare @curhour char(2)
	declare @curminute char(2)
	set @curhour = SUBSTRING(convert(varchar, getdate(), 114), 1, 2)
	set @curminute = SUBSTRING(convert(varchar, getdate(), 114), 4, 2)

	-- If the interchange status was not passed in, go get one based on whether this is incoming or outgoing
	if (@x12_interchange_status_id IS NULL AND @incoming = 1)
		select @x12_interchange_status_id = x12_interchange_status_id FROM x12_interchange_status WHERE x12_interchange_status_ud = 'PARSED'
	if (@x12_interchange_status_id IS NULL AND @outgoing = 1)
		select @x12_interchange_status_id = x12_interchange_status_id FROM x12_interchange_status WHERE x12_interchange_status_ud = 'EXPORT-READY'

	if (@dest_x12_organization_id IS NULL)
	BEGIN
		-- Set the DESTINATION organization based on the isa07_receiver_id_qual/isa08_receiver_id value
		SELECT @dest_x12_organization_id = dbo.fn_x12_identifier_value_org_id(@isa08_receiver_id, @isa07_receiver_id_qual)
	END
	
	if (@src_x12_organization_id IS NULL)
	BEGIN
		-- Set the SOURCE organization based on the isa05_sender_id_qual/isa06_sender_id value
		SELECT @src_x12_organization_id = dbo.fn_x12_identifier_value_org_id(@isa06_sender_id, @isa05_sender_id_qual)
	END

	-- This is generally used for outgoing interchanges where the isa08 and isa06 fields aren't specified.
	-- Use the mutually defined identifier for the destination and source organizations.
	if (@isa08_receiver_id IS NULL AND @dest_x12_organization_id IS NOT NULL)
		set @isa08_receiver_id = dbo.fn_x12_organization_identifier_value(@dest_x12_organization_id, 'ZZ')
	if (@isa06_sender_id IS NULL AND @src_x12_organization_id IS NOT NULL)
		set @isa06_sender_id = dbo.fn_x12_organization_identifier_value(@src_x12_organization_id, 'ZZ')
	
	-- SET UP THE DEFAULTS
	if (@isa01_auth_info_qual IS NULL OR (@isa01_auth_info_qual <> '00' AND @isa01_auth_info_qual <> '03') ) set @isa01_auth_info_qual = '00'
	if (@isa02_auth_info IS NULL) set @isa02_auth_info = REPLICATE(' ', 10)
	if (@isa03_security_info_qual IS NULL OR (@isa03_security_info_qual <> '00' AND @isa03_security_info_qual <> '03') ) set @isa03_security_info_qual = '00'
	if (@isa04_security_info IS NULL) set @isa04_security_info = REPLICATE(' ', 10)
	if (@isa05_sender_id_qual IS NULL OR LEN(LTRIM(RTRIM(@isa05_sender_id_qual))) <> 2 ) set @isa05_sender_id_qual = 'ZZ'
	if (@isa06_sender_id IS NULL) set @isa06_sender_id = REPLICATE(' ', 15)
	-- if the @isa06_sender_id value is less than 15 characters long, append the appropriate number of spaces to it.
	if (LEN(LTRIM(RTRIM(@isa06_sender_id))) < 15 ) set @isa06_sender_id = LTRIM(RTRIM(@isa06_sender_id)) + REPLICATE(' ', 15-LEN(LTRIM(RTRIM(@isa06_sender_id))))
	if (@isa07_receiver_id_qual IS NULL OR LEN(LTRIM(RTRIM(@isa07_receiver_id_qual))) <> 2 ) set @isa07_receiver_id_qual = 'ZZ'
	if (@isa08_receiver_id IS NULL) set @isa08_receiver_id = REPLICATE(' ', 15)
	-- if the @isa08_receiver_id value is less than 15 characters long, append the appropriate number of spaces to it.
	if (LEN(LTRIM(RTRIM(@isa08_receiver_id))) < 15 ) set @isa08_receiver_id = LTRIM(RTRIM(@isa08_receiver_id)) + REPLICATE(' ', 15-LEN(LTRIM(RTRIM(@isa08_receiver_id))))
	if (@isa09_interchange_date IS NULL OR LEN(LTRIM(RTRIM(@isa09_interchange_date))) < 6) set @isa09_interchange_date = convert(char(6), getdate(), 12)
	if (@isa10_interchange_time IS NULL OR LEN(LTRIM(RTRIM(@isa10_interchange_time))) < 4) set @isa10_interchange_time = @curhour + @curminute
	if (@isa11_control_standards_id IS NULL) set @isa11_control_standards_id = 'U'
	if (@isa12_control_version_no IS NULL) set @isa12_control_version_no = '00401'
	-- set the isa13_control_no value after insert
	if (@isa14_ack_requested IS NULL) set @isa14_ack_requested = '0'
	if (@isa15_usage_indicator IS NULL) set @isa15_usage_indicator = 'P'
	if (@isa16_component_element_seperator IS NULL OR @isa16_component_element_seperator = ' ') set @isa16_component_element_seperator = ':'

	if (@element_separator IS NULL) set @element_separator = '*'
	if (@segment_separator IS NULL) set @segment_separator = '~'

	-- If no @x12_interchange_uid value was passed, create one:
	if (@x12_interchange_uid IS NULL) set @x12_interchange_uid = NEWID()
	-- Insert the new x12_interchange record
	INSERT INTO x12_interchange
			(	x12_interchange_uid,
				x12_interchange_status_id,
				src_x12_organization_id,
				dest_x12_organization_id,
				isa01_auth_info_qual,
				isa02_auth_info,
				isa03_security_info_qual,
				isa04_security_info,
				isa05_sender_id_qual,
				isa06_sender_id,
				isa07_receiver_id_qual,
				isa08_receiver_id,
				isa09_interchange_date,
				isa10_interchange_time,
				isa11_control_standards_id,
				isa12_control_version_no,
				isa13_control_no,
				isa14_ack_requested,
				isa15_usage_indicator,
				isa16_component_element_seperator,
				element_separator,
				segment_separator,
				x12_parse_temp_id_start,
				x12_parse_temp_id_end,
				filename,
				incoming,
				outgoing,
				error,
				processed,
				active
			)
		VALUES
		(	@x12_interchange_uid,
			@x12_interchange_status_id,
			@src_x12_organization_id,
			@dest_x12_organization_id,
			@isa01_auth_info_qual,
			@isa02_auth_info,
			@isa03_security_info_qual,
			@isa04_security_info,
			@isa05_sender_id_qual,
			@isa06_sender_id,
			@isa07_receiver_id_qual,
			@isa08_receiver_id,
			@isa09_interchange_date,
			@isa10_interchange_time,
			@isa11_control_standards_id,
			@isa12_control_version_no,
			@isa13_control_no,
			@isa14_ack_requested,
			@isa15_usage_indicator,
			@isa16_component_element_seperator,
			@element_separator,
			@segment_separator,
			@x12_parse_temp_id_start,
			@x12_parse_temp_id_end,
			@filename,
			@incoming,
			@outgoing,
			@error,
			@processed,
			@active
	
		)
	
	-- Get the x12_interchange_id for the record just inserted
		select @x12_interchange_id = SCOPE_IDENTITY()
	
		-- Update the isa13_control_no value using the x12_interchange_id value for the new record
		if ( @isa13_control_no IS NULL )
		begin
			update x12_interchange SET
					isa13_control_no = ISNULL(@isa13_control_no, REPLICATE('0', 9-LEN(@x12_interchange_id)) + LTRIM(RTRIM(STR(@x12_interchange_id))))
				where x12_interchange_id = @x12_interchange_id
		end
return (0)


