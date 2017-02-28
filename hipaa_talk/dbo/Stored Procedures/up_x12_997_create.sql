

CREATE Procedure [dbo].[up_x12_997_create] (@src_x12_functional_group_id int, @x12_transaction_id int = null output, @x12_interchange_id int = null output)
As
-- Variables used to generate the ISA/GS/ST segment from the original segment

declare @isa01_auth_info_qual char (2)
declare @isa02_auth_info char (10)
declare @isa03_security_info_qual char (2)
declare @isa04_security_info char (10)
declare @isa05_sender_id_qual char (2)
declare @isa06_sender_id char (15)
declare @isa07_receiver_id_qual char (2)
declare @isa08_receiver_id char (15)
declare @isa09_interchange_date char (6)
declare @isa10_interchange_time char (4)
declare @isa11_control_standards_id char (1)
declare @isa12_control_version_no char (5)
declare @isa13_control_no char (9)
declare @isa14_ack_requested char (1)
declare @isa15_usage_indicator char (1)
declare @gs01_functional_id_code char(2)
declare @gs02_app_sender_code varchar(15)
declare @gs03_app_receiver_code varchar(15)
declare @gs06_group_control_no varchar(9)
declare @gs08_version_id_code varchar (12)
declare @st01_transaction_id_code char (3)
declare @st02_transaction_control_no varchar (9)
-- Variables used to store the outgoin 997 values
-- AK1 segment
declare @ak101_gs01_functional_id_code char(2)
declare @ak102_gs06_group_control_no varchar(9)
declare @ak103_gs08_version_id_code varchar(12)
-- AK2 segment
declare @ak201_st01_transaction_id_code char(3)
declare @ak202_st02_transaction_control_no varchar(9)
-- AK3 segment
declare @ak301_segment_id_code char(3)
declare @ak302_segment_pos varchar(10)
declare @ak303_loop_id_code varchar(4)
declare @ak304_segment_syntax_error_code varchar(3)
-- AK4 segment
declare @ak401_element_pos varchar(2)
declare @ak402_data_element_ref_no varchar(4)
declare @ak403_element_syntax_error_code varchar(3)
declare @ak404_copy_of_bad_element varchar(99)
-- AK5 segment
declare @ak501_tran_ack_code varchar(1)
declare @ak502_tran_syntax_error_code varchar(3)
declare @ak503_tran_syntax_error_code varchar(3)
declare @ak504_tran_syntax_error_code varchar(3)
declare @ak505_tran_syntax_error_code varchar(3)
declare @ak506_tran_syntax_error_code varchar(3)
-- AK9 segment
declare @ak901_funct_ack_code varchar(1)
declare @ak902_num_tran_sets varchar(6)
declare @ak903_num_rcvd_tran_sets varchar(6)
declare @ak904_num_accept_tran_sets varchar(6)
declare @ak905_func_syntax_error_code varchar(3)
declare @ak906_func_syntax_error_code varchar(3)
declare @ak907_func_syntax_error_code varchar(3)
declare @ak908_func_syntax_error_code varchar(3)
declare @ak909_func_syntax_error_code varchar(3)
declare @src_x12_transaction_id int
-- declare @x12_interchange_id int
declare @x12_functional_group_id int
--set @isa09_interchange_date = RIGHT(CONVERT(varchar(4), DATEPART(yy, GetDate())), 2) + CAST(DATEPART(mm, GetDate()) as char(2)) + CAST(DATEPART(dd, GetDate()) as char(2))
--set @isa10_interchange_time = CAST(DATEPART(hh, GetDate()) as char(2)) + CAST(DATEPART(mi, GetDate()) as char(2))
if (@src_x12_functional_group_id IS NOT NULL)
begin
-- BEGIN: Generate the ISA/GS information from the original transaction
	select	DISTINCT
		@isa01_auth_info_qual = '00',
		@isa02_auth_info = SPACE(10),
		@isa03_security_info_qual = '00',
		@isa04_security_info = SPACE(10),
		@isa05_sender_id_qual = isa07_receiver_id_qual,
		@isa06_sender_id = isa08_receiver_id,
		@isa07_receiver_id_qual = isa05_sender_id_qual,
		@isa08_receiver_id = isa06_sender_id,
		@isa11_control_standards_id = 'U',
		@isa12_control_version_no = '00401',
		@isa14_ack_requested = '0',
		@isa15_usage_indicator = isa15_usage_indicator, -- if production was sent, then we send production
		@gs02_app_sender_code = gs03_app_receiver_code,
		@gs03_app_receiver_code = gs02_app_sender_code,
		@gs08_version_id_code = gs08_version_id_code,
		@ak101_gs01_functional_id_code = gs01_functional_id_code,
		@ak102_gs06_group_control_no = gs06_group_control_no,
		@ak103_gs08_version_id_code = gs08_version_id_code
	from vw_x12_transaction
	where x12_functional_group_id = @src_x12_functional_group_id
-- END: Generate the ISA/GS information
	-- Create the 997 interchange record
	exec up_x12_interchange_create		@x12_interchange_id = @x12_interchange_id output,
						@x12_interchange_uid = null,				-- don't send x12_interchange_uid, let the system generate it
						@x12_interchange_status_id = null,
						@isa01_auth_info_qual = @isa01_auth_info_qual,
						@isa02_auth_info = @isa02_auth_info,
						@isa03_security_info_qual = @isa03_security_info_qual,
						@isa04_security_info = @isa04_security_info,
						@isa05_sender_id_qual = @isa05_sender_id_qual,
						@isa06_sender_id = @isa06_sender_id,
						@isa07_receiver_id_qual = @isa07_receiver_id_qual,
						@isa08_receiver_id = @isa08_receiver_id,
						@isa11_control_standards_id = @isa11_control_standards_id,
						@isa12_control_version_no = @isa12_control_version_no,
						@isa13_control_no = null, 				-- don't send the ISA control number, it's created automatically
						@isa14_ack_requested = @isa14_ack_requested,
						@isa15_usage_indicator = @isa15_usage_indicator,
						@x12_parse_temp_id_start = NULL,	-- ISA ID value not necessary
						@x12_parse_temp_id_end = NULL,	-- IEA ID value not necessary
						@filename = NULL,			-- filename not known
						@incoming = 0,				-- DO NOT send the "incoming" bit flag
						@outgoing = 1,				-- send the outgoing flag
						@error = 0,				-- error = 0
						@processed = 0,			-- processed = 0
						@active = 1				-- active = 1
	-- Create the 997 functional group record
	exec up_x12_functional_group_create	@x12_functional_group_id = @x12_functional_group_id output,
						@x12_functional_group_uid = null,				-- don't send x12_functional_group_uid, let the system generate it
						@x12_interchange_id = @x12_interchange_id,
						@gs01_functional_id_code = 'FA',				-- gs01_functional_id_code
						@gs02_app_sender_code = @gs02_app_sender_code,
						@gs03_app_receiver_code = @gs03_app_receiver_code,
						@gs06_group_control_no = null,					-- don't send the GS control number, it's created automatically
						@gs07_resp_agency_code = 'X',
						@gs08_version_id_code = @gs08_version_id_code		-- The gs08 value for a 997 is the same as the originating version_id_code
	-- Create the 997 transaction record
	exec up_x12_transaction_create		@x12_transaction_id = @x12_transaction_id output,
						@x12_transaction_uid = null,		-- don't send x12_transaction_uid, let the system generate it
						@x12_functional_group_id = @x12_functional_group_id,
						@st01_transaction_id_code = '997',
						@st02_transaction_control_no = NULL,
						@error = 0,		-- error bit
						@processed = 0,	-- processed bit
						@active = 1		-- active bit

	update x12_interchange set filename = dbo.fn_x12_dropoff_location_address(x12_interchange_uid) where x12_interchange_id = @x12_interchange_id
	/*	
		AK3 Field 4 - reports errors in a data segment
		1 Unrecognized segment ID
		2 Unexpected segment
		3 Mandatory segment missing
		4 Loop Occurs Over Maximum Times
		5 Segment Exceeds Maximum Use
		6 Segment Not in Defined Transaction
		7 Segment Not in Proper Sequence
		8 Segment Has Data Element Errors
		AK4 Field 3 - `1'- data element error code
		1 Mandatory data element missing
		2 Conditional required data element missing.
		3 Too many data elements.
		4 Data element too short.
		5 Data element too long.
		6 Invalid character in data element.
		7 Invalid code value.
		8 Invalid Date
		9 Invalid Time
		10 Exclusion Condition Violated
		AK5 Field 1 -`R'- indicates Rejection or Acceptance of transaction
		A Accepted
		E Accepted But Errors Were Noted
		M Rejected, Message Authentication Code (MAC)
		R Rejected
		W Rejected, Assurance Failed Validity Tests
		X Rejected, Content After Decryption Could Not Be Analyzed
		AK5 Field 2 -`5' - syntax error code
		1 Transaction Set Not Supported
		2 Transaction Set Trailer Missing
		3 Transaction Set Control Number in Header and Trailer Do Not Match
		4 Number of Included Segments Does Not Match Actual Count
		5 One or More Segments in Error
		6 Missing or Invalid Transaction Set Identifier
		7 Missing or Invalid Transaction Set Control Number
		8 Authentication Key Name Unknown
		9 Encryption Key Name Unknown
		10 Requested Service (Authentication or Encrypted) Not Available
		11 Unknown Security Recipient
		12 Incorrect Message Length (Encryption Only)
		13 Message Authentication Code Failed
		15 Unknown Security Originator
		16 Syntax Error in Decrypted Text
		17 Security Not Supported
		23 Transaction Set Control Number Not Unique within the Functional Group
		24 S3E Security End Segment Missing for S3S Security Start Segment
		25 S3S Security Start Segment Missing for S3E Security End Segment
		26 S4E Security End Segment Missing for S4S Security Start Segment
		27 S4S Security Start
		AK9 Field 1 - `R' - indicates Acceptance or Rejection of functional group
		A Accepted ADVISED
		E Accepted, But Errors Were Noted.
		M Rejected, Message Authentication Code (MAC) Failed
		P Partially Accepted, At Least One Transaction Set Was Rejected
		R Rejected
		W Rejected, Assurance Failed Validity Tests
		X Rejected, Content After Decryption Could Not Be Analyzed
	*/
--	@ak201_st01_transaction_id_code = st01_transaction_id_code,
--	@ak202_st02_transaction_control_no = st02_transaction_control_no

set @ak902_num_tran_sets = 0
set @ak903_num_rcvd_tran_sets = 0
set @ak904_num_accept_tran_sets = 0
set @ak904_num_accept_tran_sets = 0

DECLARE curX12Create997 SCROLL CURSOR FOR
	select x12_transaction_id, st01_transaction_id_code, st02_transaction_control_no
	from x12_transaction
	where	x12_transaction.x12_functional_group_id = @src_x12_functional_group_id
	order by x12_transaction_id
OPEN curX12Create997
FETCH NEXT FROM curX12Create997 INTO @src_x12_transaction_id, @st01_transaction_id_code, @st02_transaction_control_no
WHILE (@@fetch_status <> -1)
BEGIN
	-- Set the AK201 value, this is the transaction ID code being acknowledged
	set @ak201_st01_transaction_id_code = @st01_transaction_id_code
	-- Set the AK202 value, this is the control number of the transaction being acknowledged
	set @ak202_st02_transaction_control_no = @st02_transaction_control_no
	set @ak902_num_tran_sets = @ak902_num_tran_sets + 1
	set @ak903_num_rcvd_tran_sets = @ak903_num_rcvd_tran_sets + 1

	if not exists (	select x12_interchange_message.x12_interchange_message_id
			from x12_interchange_message
			inner join vw_x12_transaction
				on x12_interchange_message.x12_interchange_uid = vw_x12_transaction.x12_interchange_uid
			where	vw_x12_transaction.x12_transaction_id = @src_x12_transaction_id AND
				x12_interchange_message.message_code IS NOT NULL )
	begin
		set @ak501_tran_ack_code = 'A'		-- this transaction was accepted
		set @ak901_funct_ack_code = 'A'		-- this functional group was accepted
		set @ak904_num_accept_tran_sets = @ak904_num_accept_tran_sets + 1
	end
	else
	begin
		set @ak501_tran_ack_code = 'E'		-- this transaction was accepted with errors noted
		set @ak901_funct_ack_code = 'E'	-- this functional group was accepted with errors noted
		set @ak904_num_accept_tran_sets = @ak904_num_accept_tran_sets + 1
	end

	INSERT INTO x12_997_functional_ack (	x12_transaction_id,
						src_x12_functional_group_id,
						-- AK1 segment
						ak101_gs01_functional_id_code,
						ak102_gs06_group_control_no,
--						ak103_gs08_version_id_code,
						-- AK2 segment
						ak201_st01_transaction_id_code,
						ak202_st02_transaction_control_no,
						-- AK3 segment
						ak301_segment_id_code,
						ak302_segment_pos,
						ak303_loop_id_code,
						ak304_segment_syntax_error_code,
						-- AK4 segment
						ak401_element_pos,
						ak402_data_element_ref_no,
						ak403_element_syntax_error_code,
						ak404_copy_of_bad_element,
						-- AK5 segment
						ak501_tran_ack_code,
						ak502_tran_syntax_error_code,
						ak503_tran_syntax_error_code,
						ak504_tran_syntax_error_code,
						ak505_tran_syntax_error_code,
						ak506_tran_syntax_error_code,
						-- AK9 segment
						ak901_funct_ack_code,
						ak902_num_tran_sets,
						ak903_num_rcvd_tran_sets,
						ak904_num_accept_tran_sets,
						ak905_func_syntax_error_code,
						ak906_func_syntax_error_code,
						ak907_func_syntax_error_code,
						ak908_func_syntax_error_code,
						ak909_func_syntax_error_code
					)
		VALUES	(	@x12_transaction_id,
					@src_x12_functional_group_id,
					-- AK1 segment
					@ak101_gs01_functional_id_code,
					@ak102_gs06_group_control_no,
--					@ak103_gs08_version_id_code,
					-- AK2 segment
					@ak201_st01_transaction_id_code,
					@ak202_st02_transaction_control_no,
					-- AK3 segment
					@ak301_segment_id_code,
					@ak302_segment_pos,
					@ak303_loop_id_code,
					@ak304_segment_syntax_error_code,
					-- AK4 segment
					@ak401_element_pos,
					@ak402_data_element_ref_no,
					@ak403_element_syntax_error_code,
					@ak404_copy_of_bad_element,
					-- AK5 segment
					@ak501_tran_ack_code,
					@ak502_tran_syntax_error_code,
					@ak503_tran_syntax_error_code,
					@ak504_tran_syntax_error_code,
					@ak505_tran_syntax_error_code,
					@ak506_tran_syntax_error_code,
					-- AK9 segment
					@ak901_funct_ack_code,
					@ak902_num_tran_sets,
					@ak903_num_rcvd_tran_sets,
					@ak904_num_accept_tran_sets,
					@ak905_func_syntax_error_code,
					@ak906_func_syntax_error_code,
					@ak907_func_syntax_error_code,
					@ak908_func_syntax_error_code,
					@ak909_func_syntax_error_code
				)
	FETCH NEXT FROM curX12Create997 INTO @src_x12_transaction_id, @st01_transaction_id_code, @st02_transaction_control_no
END
CLOSE curX12Create997
DEALLOCATE curX12Create997
end

update x12_997_functional_ack set 	ak901_funct_ack_code = @ak901_funct_ack_code,
									ak902_num_tran_sets = @ak902_num_tran_sets,
									ak903_num_rcvd_tran_sets = @ak903_num_rcvd_tran_sets,
									ak904_num_accept_tran_sets = @ak904_num_accept_tran_sets,
									ak905_func_syntax_error_code = @ak905_func_syntax_error_code,
									ak906_func_syntax_error_code = @ak906_func_syntax_error_code,
									ak907_func_syntax_error_code = @ak907_func_syntax_error_code,
									ak908_func_syntax_error_code = @ak908_func_syntax_error_code,
									ak909_func_syntax_error_code = @ak909_func_syntax_error_code
	where	x12_transaction_id = @x12_transaction_id AND
			src_x12_functional_group_id = @src_x12_functional_group_id


