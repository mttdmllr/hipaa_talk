

CREATE PROCEDURE [dbo].[up_x12_transaction_copy]
    (
	@cur_x12_transaction_id AS int,
	-- If values are specified for the following variables, they are used, otherwise the original transaction values are used.
	@x12_interchange_status_id int = null,
	@src_x12_organization_id int = null,
	@dest_x12_organization_id int = null,
	@isa01_auth_info_qual char(2) = null,
	@isa02_auth_info char(10) = null,
	@isa03_security_info_qual char(2) = null,
	@isa04_security_info char(10) = null,
	@isa05_sender_id_qual char(2) = null,
	@isa06_sender_id char(15) = null,
	@isa07_receiver_id_qual char(2) = null,
	@isa08_receiver_id char(15) = null,
	@isa09_interchange_date char(6) = null,
	@isa10_interchange_time char(4) = null,
	@isa11_control_standards_id char(1) = null,
	@isa12_control_version_no char(5) = null,
	@isa13_control_no char(9) = null,
	@isa14_ack_requested char(1) = null,
	@isa15_usage_indicator char(1) = null,
	@isa16_component_element_seperator char(1) = null,
	@element_separator char(1) = null,
	@segment_separator varchar(3) = null,
	@filename varchar(512) = null,
	@incoming bit = 0,
	@outgoing bit = 1,
	@gs01_functional_id_code char(2) = null,
	@gs02_app_sender_code varchar(15) = null,
	@gs03_app_receiver_code varchar(15) = null,
	@gs04_date char(8) = null,
	@gs05_time varchar(8) = null,
	@gs06_group_control_no varchar(9) = null,
	@gs07_resp_agency_code varchar(2) = null,
	@gs08_version_id_code varchar(12) = null,
	@st01_transaction_id_code char(3) = null,
	@st02_transaction_control_no varchar(9) = null,
	-- end: modifiable variables
	@x12_interchange_id AS int OUTPUT,
	@x12_functional_group_id AS int OUTPUT,
	@x12_transaction_id AS int OUTPUT
    )
AS 
-- If the values are supplied for x12_interchange_id and x12_functional_group_id, then new interchange and functional_group records are not created.
BEGIN

	-- If no @cur_x12_transaction_id value is specified, exit.
	if (@cur_x12_transaction_id IS NULL)
	begin
		PRINT 'NOTHING TO COPY!'
		return
	end

	-- Get the new status for the interchange that we're creating if one was not specified.
	-- Assume the new transaction is to be exported.
	if (@x12_interchange_status_id IS NULL) 
	begin
		select  @x12_interchange_status_id = x12_interchange_status_id
		from    x12_interchange_status
		where   x12_interchange_status_ud = 'EXPORT-READY'
	end

	-- Get the current ISA/GS/ST values to be used for the new control segments
	select	@src_x12_organization_id = IsNull(@src_x12_organization_id, src_x12_organization_id),
		@dest_x12_organization_id = IsNull(@dest_x12_organization_id, dest_x12_organization_id),
		@isa01_auth_info_qual = IsNull(@isa01_auth_info_qual, isa01_auth_info_qual),
		@isa02_auth_info = IsNull(@isa02_auth_info, isa02_auth_info),
		@isa03_security_info_qual = IsNull(@isa03_security_info_qual, isa03_security_info_qual),
		@isa04_security_info = IsNull(@isa04_security_info, isa04_security_info),
		@isa05_sender_id_qual = IsNull(@isa05_sender_id_qual, isa05_sender_id_qual),
		@isa06_sender_id = IsNull(@isa06_sender_id, isa06_sender_id),
		@isa07_receiver_id_qual = IsNull(@isa07_receiver_id_qual, isa07_receiver_id_qual),
		@isa08_receiver_id = IsNull(@isa08_receiver_id, isa08_receiver_id),
		@isa09_interchange_date = IsNull(@isa09_interchange_date, isa09_interchange_date),
		@isa10_interchange_time = IsNull(@isa10_interchange_time, isa10_interchange_time),
		@isa11_control_standards_id = IsNull(@isa11_control_standards_id, isa11_control_standards_id),
		@isa12_control_version_no = IsNull(@isa12_control_version_no, isa12_control_version_no),
		@isa13_control_no = IsNull(@isa13_control_no, isa13_control_no),
		@isa14_ack_requested = IsNull(@isa14_ack_requested, isa14_ack_requested),
		@isa15_usage_indicator = IsNull(@isa15_usage_indicator, isa15_usage_indicator),
		@isa16_component_element_seperator = IsNull(@isa16_component_element_seperator, isa16_component_element_seperator),
		@element_separator = IsNull(@element_separator, element_separator),
		@segment_separator = IsNull(@segment_separator, segment_separator),
		@filename = IsNull(@filename, filename),
		@gs01_functional_id_code = IsNull(@gs01_functional_id_code, gs01_functional_id_code),
		@gs02_app_sender_code = IsNull(@gs02_app_sender_code, gs02_app_sender_code),
		@gs03_app_receiver_code = IsNull(@gs03_app_receiver_code, gs03_app_receiver_code),
		@gs04_date = IsNull(@gs04_date, gs04_date),
		@gs05_time = IsNull(@gs05_time, gs05_time),
		@gs06_group_control_no = IsNull(@gs06_group_control_no, gs06_group_control_no),
		@gs07_resp_agency_code = IsNull(@gs07_resp_agency_code, gs07_resp_agency_code),
		@gs08_version_id_code = IsNull(@gs08_version_id_code, gs08_version_id_code),
		@st01_transaction_id_code = IsNull(@st01_transaction_id_code, st01_transaction_id_code),
		@st02_transaction_control_no = IsNull(@st02_transaction_control_no, st02_transaction_control_no),
		@incoming = IsNull(@incoming, incoming),
		@outgoing = IsNull(@outgoing, outgoing)
	from    vw_x12_transaction
	where   x12_transaction_id = @cur_x12_transaction_id

	-- Create the interchange control segment record.
	if ( @x12_interchange_id IS NULL)
	begin
		exec up_x12_interchange_create	@x12_interchange_id = @x12_interchange_id output,
						@x12_interchange_status_id = @x12_interchange_status_id,
						@src_x12_organization_id = @src_x12_organization_id,
						@dest_x12_organization_id = @dest_x12_organization_id,
						@isa01_auth_info_qual = @isa01_auth_info_qual,
						@isa02_auth_info = @isa02_auth_info,
						@isa03_security_info_qual = @isa03_security_info_qual,
						@isa04_security_info = @isa04_security_info,
						@isa05_sender_id_qual = @isa05_sender_id_qual,
						@isa06_sender_id = @isa06_sender_id,
						@isa07_receiver_id_qual = @isa07_receiver_id_qual,
						@isa08_receiver_id = @isa08_receiver_id,
						@isa09_interchange_date = @isa09_interchange_date,
						@isa10_interchange_time = @isa10_interchange_time,
						@isa11_control_standards_id = @isa11_control_standards_id,
						@isa12_control_version_no = @isa12_control_version_no,
						@isa13_control_no = @isa13_control_no,
						@isa14_ack_requested = @isa14_ack_requested,
						@isa15_usage_indicator = @isa15_usage_indicator,
						@isa16_component_element_seperator = @isa16_component_element_seperator,
						@element_separator = @element_separator,
						@segment_separator = @segment_separator,
						@filename = @filename, @incoming = @incoming,
						@outgoing = @outgoing, @error = 0, @processed = 0, @active = 1
	end


	if ( @x12_functional_group_id IS NULL)
	begin
		-- Create the functional group control segment record.
		exec up_x12_functional_group_create	@x12_functional_group_id = @x12_functional_group_id output,
							@x12_interchange_id = @x12_interchange_id,
							@gs01_functional_id_code = @gs01_functional_id_code,
							@gs02_app_sender_code = @gs02_app_sender_code,
							@gs03_app_receiver_code = @gs03_app_receiver_code,
							@gs04_date = @gs04_date, @gs05_time = @gs05_time,
							@gs06_group_control_no = @gs06_group_control_no,
							@gs07_resp_agency_code = @gs07_resp_agency_code,
							@gs08_version_id_code = @gs08_version_id_code, @error = 0,
							@processed = 0, @active = 1
	end

	-- Create the transaction control segment record.
	exec up_x12_transaction_create	@x12_transaction_id = @x12_transaction_id output,
					@x12_functional_group_id = @x12_functional_group_id,
					@st01_transaction_id_code = @st01_transaction_id_code,
					@st02_transaction_control_no = @st02_transaction_control_no,
					@error = 0, @processed = 0, @active = 1
END
