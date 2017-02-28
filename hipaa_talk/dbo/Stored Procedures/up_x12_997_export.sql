

CREATE Procedure [dbo].[up_x12_997_export] (@x12_transaction_id int = null, @segment_count int output)
As
declare @ak101_gs01_functional_id_code char(2)
declare @ak102_gs06_group_control_no varchar(9)
declare @ak103_gs08_version_id_code varchar(12)
declare @prev_ak101_gs01_functional_id_code char(2)
declare @prev_ak102_gs06_group_control_no varchar(9)
declare @prev_ak103_gs08_version_id_code varchar(12)
declare @ak201_st01_transaction_id_code char(3)
declare @ak202_st02_transaction_control_no varchar(9)
declare @prev_ak201_st01_transaction_id_code char(3)
declare @prev_ak202_st02_transaction_control_no varchar(9)
declare @ak301_segment_id_code char(3)
declare @ak302_segment_pos varchar(10)
declare @ak303_loop_id_code varchar(4)
declare @ak304_segment_syntax_error_code varchar(3)
declare @prev_ak301_segment_id_code char(3)
declare @prev_ak302_segment_pos varchar(10)
declare @prev_ak303_loop_id_code varchar(4)
declare @prev_ak304_segment_syntax_error_code varchar(3)
declare @ak401_element_pos varchar(2)
declare @ak402_data_element_ref_no varchar(4)
declare @ak403_element_syntax_error_code varchar(3)
declare @ak404_copy_of_bad_element varchar(99)
declare @prev_ak401_element_pos varchar(2)
declare @prev_ak402_data_element_ref_no varchar(4)
declare @prev_ak403_element_syntax_error_code varchar(3)
declare @prev_ak404_copy_of_bad_element varchar(99)
declare @ak501_tran_ack_code varchar(1)
declare @ak502_tran_syntax_error_code varchar(3)
declare @ak503_tran_syntax_error_code varchar(3)
declare @ak504_tran_syntax_error_code varchar(3)
declare @ak505_tran_syntax_error_code varchar(3)
declare @ak506_tran_syntax_error_code varchar(3)
declare @prev_ak501_tran_ack_code varchar(1)
declare @prev_ak502_tran_syntax_error_code varchar(3)
declare @prev_ak503_tran_syntax_error_code varchar(3)
declare @prev_ak504_tran_syntax_error_code varchar(3)
declare @prev_ak505_tran_syntax_error_code varchar(3)
declare @prev_ak506_tran_syntax_error_code varchar(3)
declare @ak901_funct_ack_code varchar(1)
declare @ak902_num_tran_sets varchar(6)
declare @ak903_num_rcvd_tran_sets varchar(6)
declare @ak904_num_accept_tran_sets varchar(6)
declare @ak905_func_syntax_error_code varchar(3)
declare @ak906_func_syntax_error_code varchar(3)
declare @ak907_func_syntax_error_code varchar(3)
declare @ak908_func_syntax_error_code varchar(3)
declare @ak909_func_syntax_error_code varchar(3)
declare @prev_ak901_funct_ack_code varchar(1)
declare @prev_ak902_num_tran_sets varchar(6)
declare @prev_ak903_num_rcvd_tran_sets varchar(6)
declare @prev_ak904_num_accept_tran_sets varchar(6)
declare @prev_ak905_func_syntax_error_code varchar(3)
declare @prev_ak906_func_syntax_error_code varchar(3)
declare @prev_ak907_func_syntax_error_code varchar(3)
declare @prev_ak908_func_syntax_error_code varchar(3)
declare @prev_ak909_func_syntax_error_code varchar(3)
declare @x12_interchange_uid uniqueidentifier
--declare @segment_count int
--declare @tran_set_count int
--declare @funct_grp_count int

set @segment_count = 0
--set @tran_set_count = 0
--set @funct_grp_count = 0

select @x12_interchange_uid = x12_interchange_uid
from vw_x12_transaction
	where x12_transaction_id = @x12_transaction_id

declare @errmsg varchar(250)
declare @errcode int
DECLARE curtX12Doc SCROLL CURSOR FOR
	select	ak101_gs01_functional_id_code,
		ak102_gs06_group_control_no,
		ak103_gs08_version_id_code,
		ak201_st01_transaction_id_code,
		ak202_st02_transaction_control_no,
		ak301_segment_id_code,
		ak302_segment_pos,
		ak303_loop_id_code,
		ak304_segment_syntax_error_code,
		ak401_element_pos,
		ak402_data_element_ref_no,
		ak403_element_syntax_error_code,
		ak404_copy_of_bad_element,
		ak501_tran_ack_code,
		ak502_tran_syntax_error_code,
		ak503_tran_syntax_error_code,
		ak504_tran_syntax_error_code,
		ak505_tran_syntax_error_code,
		ak506_tran_syntax_error_code,
		ak901_funct_ack_code,
		ak902_num_tran_sets,
		ak903_num_rcvd_tran_sets,
		ak904_num_accept_tran_sets,
		ak905_func_syntax_error_code,
		ak906_func_syntax_error_code,
		ak907_func_syntax_error_code,
		ak908_func_syntax_error_code
	from x12_997_functional_ack
	where	x12_transaction_id = @x12_transaction_id
	order by x12_997_functional_ack_id
OPEN curtX12Doc
FETCH NEXT FROM curtX12Doc INTO	@ak101_gs01_functional_id_code,
				@ak102_gs06_group_control_no,
				@ak103_gs08_version_id_code,
				@ak201_st01_transaction_id_code,
				@ak202_st02_transaction_control_no,
				@ak301_segment_id_code,
				@ak302_segment_pos,
				@ak303_loop_id_code,
				@ak304_segment_syntax_error_code,
				@ak401_element_pos,
				@ak402_data_element_ref_no,
				@ak403_element_syntax_error_code,
				@ak404_copy_of_bad_element,
				@ak501_tran_ack_code,
				@ak502_tran_syntax_error_code,
				@ak503_tran_syntax_error_code,
				@ak504_tran_syntax_error_code,
				@ak505_tran_syntax_error_code,
				@ak506_tran_syntax_error_code,
				@ak901_funct_ack_code,
				@ak902_num_tran_sets,
				@ak903_num_rcvd_tran_sets,
				@ak904_num_accept_tran_sets,
				@ak905_func_syntax_error_code,
				@ak906_func_syntax_error_code,
				@ak907_func_syntax_error_code,
				@ak908_func_syntax_error_code
WHILE (@@fetch_status <> -1)
BEGIN
-- Insert the AK1 segment
	if (	@ak101_gs01_functional_id_code <> @prev_ak101_gs01_functional_id_code OR
		@ak102_gs06_group_control_no <> @prev_ak102_gs06_group_control_no OR
		@ak103_gs08_version_id_code <> @prev_ak103_gs08_version_id_code OR
		@prev_ak101_gs01_functional_id_code IS NULL)
	begin
	-- if the AK1 information is different than the previous AK1 info, insert an AK9 (with previous record data) and a new AK1
		if ( @prev_ak101_gs01_functional_id_code IS NOT NULL )
		begin
			INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010)
				VALUES (@x12_interchange_uid, 'AK9',
					@prev_ak901_funct_ack_code,
					@prev_ak902_num_tran_sets,
					@prev_ak903_num_rcvd_tran_sets,
					@prev_ak904_num_accept_tran_sets,
					@prev_ak905_func_syntax_error_code,
					@prev_ak906_func_syntax_error_code,
					@prev_ak907_func_syntax_error_code,
					@prev_ak908_func_syntax_error_code,
					@prev_ak909_func_syntax_error_code)
			set @segment_count = @segment_count + 1
		end
		INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003, col004)
			VALUES (@x12_interchange_uid, 'AK1',
				@ak101_gs01_functional_id_code,
				@ak102_gs06_group_control_no,
				@ak103_gs08_version_id_code)
		set @segment_count = @segment_count + 1
	end
-- Insert the AK2 segment
	if (	@ak201_st01_transaction_id_code <> @prev_ak201_st01_transaction_id_code OR
		@ak202_st02_transaction_control_no <> @prev_ak202_st02_transaction_control_no OR
		@prev_ak201_st01_transaction_id_code IS NULL )
	begin
	-- if the AK2 information is different than the previous AK2 info, insert an AK5 (with previous record data) and a new AK2
		if ( @prev_ak501_tran_ack_code IS NOT NULL )
		begin
			INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007)
				VALUES (@x12_interchange_uid, 'AK5',
					@ak501_tran_ack_code,
					@ak502_tran_syntax_error_code,
					@ak503_tran_syntax_error_code,
					@ak504_tran_syntax_error_code,
					@ak505_tran_syntax_error_code,
					@ak506_tran_syntax_error_code)
			set @segment_count = @segment_count + 1
		end
		INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003)
			VALUES (@x12_interchange_uid, 'AK2',
				@ak201_st01_transaction_id_code,
				@ak202_st02_transaction_control_no)
		set @segment_count = @segment_count + 1
	end
-- Insert the AK3 segment
	if ( @ak301_segment_id_code IS NOT NULL)
	begin
		INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003, col004, col005)
			VALUES (@x12_interchange_uid, 'AK3',
				@ak301_segment_id_code,
				@ak302_segment_pos,
				@ak303_loop_id_code,
				@ak304_segment_syntax_error_code)
		set @segment_count = @segment_count + 1
	end
-- Insert the AK4 segment
	if ( @ak401_element_pos IS NOT NULL)
	begin
		INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003, col004, col005)
			VALUES (@x12_interchange_uid, 'AK4',
				@ak401_element_pos,
				@ak402_data_element_ref_no,
				@ak403_element_syntax_error_code,
				@ak404_copy_of_bad_element)
		set @segment_count = @segment_count + 1
	end
-- set the "PREVIOUS VALUE" variables
	set @prev_ak101_gs01_functional_id_code = @ak101_gs01_functional_id_code
	set @prev_ak102_gs06_group_control_no = @ak102_gs06_group_control_no
	set @prev_ak103_gs08_version_id_code = @ak103_gs08_version_id_code
	set @prev_ak201_st01_transaction_id_code = @ak201_st01_transaction_id_code
	set @prev_ak202_st02_transaction_control_no = @ak202_st02_transaction_control_no
	set @prev_ak301_segment_id_code = @ak301_segment_id_code
	set @prev_ak302_segment_pos = @ak302_segment_pos
	set @prev_ak303_loop_id_code = @ak303_loop_id_code
	set @prev_ak304_segment_syntax_error_code = @ak304_segment_syntax_error_code
	set @prev_ak401_element_pos = @ak401_element_pos
	set @prev_ak402_data_element_ref_no = @ak402_data_element_ref_no
	set @prev_ak403_element_syntax_error_code = @ak403_element_syntax_error_code
	set @prev_ak404_copy_of_bad_element = @ak404_copy_of_bad_element
	set @prev_ak501_tran_ack_code = @ak501_tran_ack_code
	set @prev_ak502_tran_syntax_error_code = @ak502_tran_syntax_error_code
	set @prev_ak503_tran_syntax_error_code = @ak503_tran_syntax_error_code
	set @prev_ak504_tran_syntax_error_code = @ak504_tran_syntax_error_code
	set @prev_ak505_tran_syntax_error_code = @ak505_tran_syntax_error_code
	set @prev_ak506_tran_syntax_error_code = @ak506_tran_syntax_error_code
	set @prev_ak901_funct_ack_code = @ak901_funct_ack_code
	set @prev_ak902_num_tran_sets = @ak902_num_tran_sets
	set @prev_ak903_num_rcvd_tran_sets = @ak903_num_rcvd_tran_sets
	set @prev_ak904_num_accept_tran_sets = @ak904_num_accept_tran_sets
	set @prev_ak905_func_syntax_error_code = @ak905_func_syntax_error_code
	set @prev_ak906_func_syntax_error_code = @ak906_func_syntax_error_code
	set @prev_ak907_func_syntax_error_code = @ak907_func_syntax_error_code
	set @prev_ak908_func_syntax_error_code = @ak908_func_syntax_error_code
	FETCH NEXT FROM curtX12Doc INTO	@ak101_gs01_functional_id_code,
					@ak102_gs06_group_control_no,
					@ak103_gs08_version_id_code,
					@ak201_st01_transaction_id_code,
					@ak202_st02_transaction_control_no,
					@ak301_segment_id_code,
					@ak302_segment_pos,
					@ak303_loop_id_code,
					@ak304_segment_syntax_error_code,
					@ak401_element_pos,
					@ak402_data_element_ref_no,
					@ak403_element_syntax_error_code,
					@ak404_copy_of_bad_element,
					@ak501_tran_ack_code,
					@ak502_tran_syntax_error_code,
					@ak503_tran_syntax_error_code,
					@ak504_tran_syntax_error_code,
					@ak505_tran_syntax_error_code,
					@ak506_tran_syntax_error_code,
					@ak901_funct_ack_code,
					@ak902_num_tran_sets,
					@ak903_num_rcvd_tran_sets,
					@ak904_num_accept_tran_sets,
					@ak905_func_syntax_error_code,
					@ak906_func_syntax_error_code,
					@ak907_func_syntax_error_code,
					@ak908_func_syntax_error_code
END
CLOSE curtX12Doc
DEALLOCATE curtX12Doc
-- CREATE TRAILER SEGMENTS
	-- Insert the FINAL AK5 segment
	INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007)
		VALUES (@x12_interchange_uid, 'AK5',
			@ak501_tran_ack_code,
			@ak502_tran_syntax_error_code,
			@ak503_tran_syntax_error_code,
			@ak504_tran_syntax_error_code,
			@ak505_tran_syntax_error_code,
			@ak506_tran_syntax_error_code)
	set @segment_count = @segment_count + 1
	
	-- Insert the FINAL AK9 segment
	INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010)
		VALUES (@x12_interchange_uid, 'AK9',
			@ak901_funct_ack_code,
			@ak902_num_tran_sets,
			@ak903_num_rcvd_tran_sets,
			@ak904_num_accept_tran_sets,
			@ak905_func_syntax_error_code,
			@ak906_func_syntax_error_code,
			@ak907_func_syntax_error_code,
			@ak908_func_syntax_error_code,
			@ak909_func_syntax_error_code)
	set @segment_count = @segment_count + 1

/*
	-- Insert SE segment
	INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003)
		SELECT	DISTINCT x12_interchange_uid,
				'SE',
				@segment_count + 1, -- add 1 to include SE segments
				st02_transaction_control_no
		FROM vw_x12_transaction
		WHERE x12_transaction_id = @x12_transaction_id
	-- Insert GE segment
	INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003)
		SELECT	DISTINCT x12_interchange_uid,
				'GE',
				@tran_set_count,
				gs06_group_control_no
		FROM vw_x12_transaction
		WHERE x12_transaction_id = @x12_transaction_id
	-- Insert IEA segment
	INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003)
		SELECT	DISTINCT x12_interchange_uid,
				'IEA',
				@funct_grp_count,
				isa13_control_no
		FROM vw_x12_transaction
		WHERE x12_transaction_id = @x12_transaction_id
*/
-- END: CREATE TRAILER RECORDS
-- set the transaction to processed

update x12_transaction set processed = 1 where x12_transaction_id = @x12_transaction_id
return (0)


