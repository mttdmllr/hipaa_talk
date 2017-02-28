

CREATE Procedure [dbo].[up_x12_interchange_parse] (	@x12_parse_temp_uid uniqueidentifier = null,
						@element_separator char(1) = null,
						@segment_separator varchar(3) = null,
						@errcode int = null output,
						@x12_interchange_id int = null output,
						@TA1_x12_interchange_id int = null output
						)
As
	
declare @@DEBUG_ON bit
set @@DEBUG_ON = 1
declare @x12_functional_group_id int
declare @x12_interchange_status_id int
declare @x12_transaction_id int
-- These variables store the ID from the x12_parse_temp table of the location of that segment.
-- It's only a temporary value, so once the interchange/functional group/transaction has been parsed, it's of no use.
declare @x12_parse_temp_id_ISA int
declare @x12_parse_temp_id_GS int
declare @x12_parse_temp_id_ST int
declare @x12_parse_temp_id_SE int
declare @x12_parse_temp_id_GE int
declare @x12_parse_temp_id_IEA int
declare @isa01_auth_info_qual char(2)
declare @isa02_auth_info char(10)
declare @isa03_security_info_qual char(2)
declare @isa04_security_info char(10)
declare @isa05_sender_id_qual char(2)
declare @isa06_sender_id varchar(15)
declare @isa07_receiver_id_qual char(15)
declare @isa08_receiver_id varchar(15)
declare @isa09_interchange_date char(6)
declare @isa10_interchange_time char(4)
declare @isa11_control_standards_id char(1)
declare @isa12_control_version_no varchar(5)
declare @isa13_control_no varchar(10)
declare @isa14_ack_requested char(1)
declare @isa15_usage_indicator varchar(1)
declare @isa16_component_element_seperator char(1)
declare @gs01_functional_id_code char(2)
declare @gs02_app_sender_code varchar(15)
declare @gs03_app_receiver_code varchar(15)
declare @gs04_date char(8)
declare @gs05_time varchar(8)
declare @gs06_group_control_no varchar(10)
declare @gs07_resp_agency_code char(2)
declare @gs08_version_id_code varchar(12)
declare @st01_transaction_id_code char(3)
declare @st02_transaction_control_no varchar(10)
declare @iea01_num_functional_groups int
declare @ge01_num_transaction_sets int
declare @x12_parse_temp_id int
declare @Col001 varchar(80)
declare @Col002 varchar(80)
declare @Col003 varchar(80)
declare @Col004 varchar(80)
declare @Col005 varchar(80)
declare @Col006 varchar(80)
declare @Col007 varchar(80)
declare @Col008 varchar(80)
declare @Col009 varchar(80)
declare @Col010 varchar(80)
declare @Col011 varchar(80)
declare @Col012 varchar(80)
declare @Col013 varchar(80)
declare @Col014 varchar(80)
declare @Col015 varchar(80)
declare @Col016 varchar(80)
declare @Col017 varchar(80)
declare @filename varchar(512)
declare @errmsg varchar(250)
-- If no GUID for a group of X12 records was specified, don't parse any.
if (@x12_parse_temp_uid IS NULL)
begin
	PRINT 'A value must be specified for column [x12_parse_temp].[x12_parse_temp_uid].'
	return(0)
end
-- If no group of X12 records was found for the specified GUID, don't parse any.
if not exists (select TOP 1 x12_parse_temp_id from x12_parse_temp where x12_parse_temp_uid = @x12_parse_temp_uid)
begin
	set @errmsg = 'No temp records found in table [x12_parse_temp] for the transaction specified: x12_parse_temp_uid = [' + CAST(@x12_parse_temp_uid as varchar(50)) + '].'
	exec up_x12_interchange_message	@x12_interchange_uid = @x12_parse_temp_uid,
					@message_code = '000',
					@message_text = @errmsg
	return(0)
end
-- Get all the ISA/GS/ST TA1 SE/GE/IEA segments for this submission
DECLARE curX12Parse SCROLL CURSOR FOR
	select x12_parse_temp_id, Col001, Col002, Col003, Col004, Col005, Col006, Col007, Col008, Col009, Col010, Col011, Col012, Col013, Col014, Col015, Col016, Col017, filename
	from x12_parse_temp
	where	x12_parse_temp_uid = @x12_parse_temp_uid AND
		LTRIM(RTRIM(col001)) IN ('ISA', 'GS', 'ST', 'TA1', 'SE', 'GE', 'IEA')
	order by x12_parse_temp_id
OPEN curX12Parse
FETCH NEXT FROM curX12Parse INTO @x12_parse_temp_id, @Col001, @Col002, @Col003, @Col004, @Col005, @Col006, @Col007, @Col008, @Col009, @Col010, @Col011, @Col012, @Col013, @Col014, @Col015, @Col016, @Col017, @filename
WHILE (@@fetch_status <> -1)
BEGIN
	-- Get ISA/interchange information
	if ( RTrim(@col001) = 'ISA')
	begin
		set @x12_parse_temp_id_ISA = @x12_parse_temp_id
		set @isa01_auth_info_qual = RTrim(LTrim(@Col002))
		set @isa02_auth_info = RTrim(LTrim(@Col003))
		set @isa03_security_info_qual = RTrim(LTrim(@Col004))
		set @isa04_security_info = RTrim(LTrim(@Col005))
		set @isa05_sender_id_qual = RTrim(LTrim(@Col006))
		set @isa06_sender_id = RTrim(LTrim(@Col007))
		set @isa07_receiver_id_qual = RTrim(LTrim(@Col008))
		set @isa08_receiver_id = RTrim(LTrim(@Col009))
		set @isa09_interchange_date = RTrim(LTrim(@Col010))
		set @isa10_interchange_time = RTrim(LTrim(@Col011))
		set @isa11_control_standards_id = RTrim(LTrim(@Col012))
		set @isa12_control_version_no = RTrim(LTrim(@Col013))
		set @isa13_control_no = RTrim(LTrim(@Col014))
		set @isa14_ack_requested = RTrim(LTrim(@Col015))
		set @isa15_usage_indicator = RTrim(LTrim(@Col016))
		set @isa16_component_element_seperator = RTrim(LTrim(@Col017))
		select @x12_interchange_status_id = x12_interchange_status_id FROM x12_interchange_status where x12_interchange_status_ud = 'PARSED'
		-- Create an INTERCHANGE record
		exec up_x12_interchange_create	@x12_interchange_id  = @x12_interchange_id output,
						@x12_interchange_uid = @x12_parse_temp_uid,
						@x12_interchange_status_id = @x12_interchange_status_id,
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
						@x12_parse_temp_id_start = @x12_parse_temp_id_ISA,
						@filename = @filename,
						@incoming = 1,		-- send the "incoming" bit flag
						@outgoing = 0,		-- DO NOT send the outgoing flag
						@error = 0,		-- error = 0
						@processed = 0,	-- processed = 0
						@active = 1		-- active = 1
		if (@@DEBUG_ON = 1) PRINT 'CREATED INTERCHANGE x12_interchange_id = ' + STR(@x12_interchange_id)
	end
	-- Get GS/functional group information
	if ( LTrim(RTrim(@Col001)) = 'GS' )
	begin
		-- ALERT: SOMETHING FUNKY IS CAUSING THE IF STATEMENT ABOVE TO BE IGNORED, DOING IT TWICE WORKS.  WTF?
		if ( RTrim(@Col001) = 'GS' )
		begin
			set @x12_parse_temp_id_GS = @x12_parse_temp_id
	
			set @gs01_functional_id_code = RTrim(LTrim(@Col002))
			set @gs02_app_sender_code = RTrim(LTrim(@Col003))
			set @gs03_app_receiver_code = RTrim(LTrim(@Col004))
			set @gs04_date = RTrim(LTrim(@Col005))
			set @gs05_time = RTrim(LTrim(@Col006))
			set @gs06_group_control_no = RTrim(LTrim(@Col007))
			set @gs07_resp_agency_code = RTrim(LTrim(@Col008))
			set @gs08_version_id_code = RTrim(LTrim(@Col009))
	
			-- Create a FUNCTIONAL GROUP record
			exec up_x12_functional_group_create	@x12_functional_group_id output,
								null,			-- don't send UID, let the system generate it
								@x12_interchange_id,
								@gs01_functional_id_code,
								@gs02_app_sender_code,
								@gs03_app_receiver_code,
								@gs04_date,
								@gs05_time,
								@gs06_group_control_no,
								@gs07_resp_agency_code,
								@gs08_version_id_code,
								@x12_parse_temp_id_GS,
								null,			-- GE ID value not known yet
								0,			-- error bit
								0,			-- processed bit
								1			-- active bit
	
			if (@@DEBUG_ON = 1) PRINT 'CREATED FUNCTIONAL GROUP x12_functional_group_id = ' + STR(@x12_functional_group_id)
	
			set @iea01_num_functional_groups = @iea01_num_functional_groups + 1
		end
	end
	-- Get ST/transaction information
	if ( RTrim(@col001) = 'ST')
	begin
		set @x12_parse_temp_id_ST = @x12_parse_temp_id
		set @st01_transaction_id_code = RTrim(LTrim(@Col002))
		set @st02_transaction_control_no = RTrim(LTrim(@Col003))
		-- Check to see if this transaction has already been processed.
		if exists (select DISTINCT x12_transaction_id
			FROM x12_transaction
			INNER JOIN x12_functional_group
				ON x12_transaction.x12_functional_group_id = x12_functional_group.x12_functional_group_id
			INNER JOIN x12_interchange
				ON x12_functional_group.x12_interchange_id = x12_interchange.x12_interchange_id
				WHERE	x12_interchange.isa06_sender_id = @isa06_sender_id AND
					x12_interchange.isa08_receiver_id = @isa08_receiver_id AND
					x12_interchange.isa13_control_no = @isa13_control_no AND
					x12_interchange.isa15_usage_indicator = @isa15_usage_indicator AND
					x12_functional_group.gs06_group_control_no = @gs06_group_control_no AND
					x12_transaction.st01_transaction_id_code = @st01_transaction_id_code AND
					x12_transaction.st02_transaction_control_no = @st02_transaction_control_no AND
					x12_transaction.processed = 1)
		begin
			-- TRANSACTION HAS ALREADY BEEN PROCESSED, INSERT AN ERROR MESSAGE, AND PROCESS ANYWAY
			SET @errmsg = 'Transaction Control Number [' + @st02_transaction_control_no + '] has already been processed.'
			SET @errcode = '999'
			-- Insert a message that says we've already imported this transaction set and then continue on our merry way.
			exec up_x12_interchange_message	@x12_interchange_uid = @x12_parse_temp_uid,
							@isa13_control_no = @isa13_control_no,
							@gs06_group_control_no = @gs06_group_control_no,
							@st02_transaction_control_no = @st02_transaction_control_no,
							@message_code = @errcode,
							@message_text = @errmsg
		end

		-- TRANSACTION HAS NOT BEEN PROCESSED
		-- Create the TRANSACTION record
		exec up_x12_transaction_create	@x12_transaction_id output,
						null,	-- don't pass a UID, let the system generate it
						@x12_functional_group_id,
						@st01_transaction_id_code,
						@st02_transaction_control_no,
						@x12_parse_temp_id_ST,
						0,	-- error bit
						0,	-- processed bit
						1	-- active bit
		if (@@DEBUG_ON = 1) PRINT 'CREATED TRANSACTION x12_transaction_id = ' + STR(@x12_transaction_id)

		-- Increment the total number of transaction sets in this functional group
		set @ge01_num_transaction_sets = @ge01_num_transaction_sets  + 1
	end
	-- Set SE/transaction TRAILER information
	if ( RTrim(@col001) = 'SE')
	begin
		set @x12_parse_temp_id_SE = @x12_parse_temp_id
		UPDATE x12_transaction SET x12_parse_temp_id_end = @x12_parse_temp_id_SE
			where x12_transaction_id = @x12_transaction_id
	end
	-- Set GE/functional group TRAILER information
	if ( RTrim(@col001) = 'GE')
	begin
		set @x12_parse_temp_id_GE = @x12_parse_temp_id
		UPDATE x12_functional_group SET	ge01_num_transaction_sets = @ge01_num_transaction_sets,
						x12_parse_temp_id_end = @x12_parse_temp_id_GE
			where x12_functional_group_id = @x12_functional_group_id
	end
	-- Set IEA/interchange TRAILER information
	if ( RTrim(@col001) = 'IEA')
	begin
		set @x12_parse_temp_id_IEA = @x12_parse_temp_id
		UPDATE x12_interchange SET	iea01_num_functional_groups = @iea01_num_functional_groups,
						x12_parse_temp_id_end = @x12_parse_temp_id_IEA
			where x12_interchange_id = @x12_interchange_id
	end
	FETCH NEXT FROM curX12Parse INTO @x12_parse_temp_id, @Col001, @Col002, @Col003, @Col004, @Col005, @Col006, @Col007, @Col008, @Col009, @Col010, @Col011, @Col012, @Col013, @Col014, @Col015, @Col016, @Col017, @filename
END
CLOSE curX12Parse
DEALLOCATE curX12Parse
-- TA1: create records associated with this data group
exec up_x12_ta1_parse @x12_interchange_uid = @x12_parse_temp_uid
-- Parse the functional groups for this INTERCHANGE
exec up_x12_functional_group_parse @x12_interchange_id
-- Set the "processed" bit to TRUE
update x12_interchange SET processed = 1 where x12_interchange_id = @x12_interchange_id

/*  This might possibly be a place to update the interchange to the appropriate status based on the organization and schema.
exec up_x12_interchange_set_status	@x12_interchange_id = @x12_interchange_id
					@x12_interchange_status_ud = 'IMPORT-READY'
*/

if ( @isa14_ack_requested = '1' )
begin
	-- Interchange was accepted, create TA1 ack
	exec up_x12_ta1_create	@x12_interchange_id, 		-- source x12_interchange_id
				@TA1_x12_interchange_id output, -- newly generated x12_interchange_id for TA1
				'A',				-- Accept/Reject code
				'000'				-- Note code
	exec up_x12_ta1_export @TA1_x12_interchange_id
end
return (0)
