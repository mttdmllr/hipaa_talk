

CREATE Procedure [dbo].[up_x12_997_parse] (@x12_transaction_id int = null, @se01_num_transaction_segments int = null output)
As
declare @Col001 varchar(255)
declare @Col002 varchar(255)
declare @Col003 varchar(255)
declare @Col004 varchar(255)
declare @Col005 varchar(255)
declare @Col006 varchar(255)
declare @Col007 varchar(255)
declare @Col008 varchar(255)
declare @Col009 varchar(255)
declare @Col010 varchar(255)
declare @Col011 varchar(255)
declare @Col012 varchar(255)
declare @Col013 varchar(255)
declare @Col014 varchar(255)
declare @Col015 varchar(255)
declare @Col016 varchar(255)
declare @Col017 varchar(255)
declare @Col018 varchar(255)
declare @Col019 varchar(255)
declare @Col020 varchar(255)
declare @Col021 varchar(255)


declare @src_x12_functional_group_id int
declare @ak101_gs01_functional_id_code char(2)
declare @ak102_gs06_group_control_no varchar(9)
declare @ak103_gs08_version_id_code varchar(12)
declare @ak201_st01_transaction_id_code char(3)
declare @ak202_st02_transaction_control_no varchar(9)
declare @ak301_segment_id_code char(3)
declare @ak302_segment_pos varchar(10)
declare @ak303_loop_id_code varchar(4)
declare @ak304_segment_syntax_error_code varchar(3)
declare @ak401_element_pos varchar(2)
declare @ak402_data_element_ref_no varchar(4)
declare @ak403_element_syntax_error_code varchar(3)
declare @ak404_copy_of_bad_element varchar(99)
declare @ak501_tran_ack_code varchar(1)
declare @ak502_tran_syntax_error_code varchar(3)
declare @ak503_tran_syntax_error_code varchar(3)
declare @ak504_tran_syntax_error_code varchar(3)
declare @ak505_tran_syntax_error_code varchar(3)
declare @ak506_tran_syntax_error_code varchar(3)
declare @ak901_funct_ack_code varchar(1)
declare @ak902_num_tran_sets varchar(6)
declare @ak903_num_rcvd_tran_sets varchar(6)
declare @ak904_num_accept_tran_sets varchar(6)
declare @ak905_func_syntax_error_code varchar(3)
declare @ak906_func_syntax_error_code varchar(3)
declare @ak907_func_syntax_error_code varchar(3)
declare @ak908_func_syntax_error_code varchar(3)
declare @ak909_func_syntax_error_code varchar(3)
declare @errmsg varchar(250)
declare @errcode int
declare @x12_parse_temp_id_start int
declare @x12_parse_temp_id_end int
declare @isa16_component_element_seperator char(1)
declare @x12_interchange_uid uniqueidentifier

set @se01_num_transaction_segments = 0

select	@isa16_component_element_seperator = isa16_component_element_seperator,
	@x12_interchange_uid = x12_interchange_uid
from vw_x12_transaction
where x12_transaction_id = @x12_transaction_id

if (@isa16_component_element_seperator IS NULL OR @isa16_component_element_seperator = ' ')
begin
	set @isa16_component_element_seperator = ':'
end

select	@x12_parse_temp_id_start = x12_parse_temp_id_start,
	@x12_parse_temp_id_end = x12_parse_temp_id_end
from x12_transaction where x12_transaction_id = @x12_transaction_id
DECLARE curtX12Doc SCROLL CURSOR FOR
	select Col001, Col002, Col003, Col004, Col005, Col006, Col007, Col008, Col009, Col010, Col011, Col012, Col013, Col014, Col015, Col016, Col017
	from x12_parse_temp
	where	x12_parse_temp_id BETWEEN @x12_parse_temp_id_start AND @x12_parse_temp_id_end
				AND x12_parse_temp_uid = @x12_interchange_uid
	order by x12_parse_temp_id
OPEN curtX12Doc
FETCH NEXT FROM curtX12Doc INTO @Col001, @Col002, @Col003, @Col004, @Col005, @Col006, @Col007, @Col008, @Col009, @Col010, @Col011, @Col012, @Col013, @Col014, @Col015, @Col016, @Col017
WHILE (@@fetch_status <> -1)
BEGIN
	set @se01_num_transaction_segments = @se01_num_transaction_segments + 1
	if ( RTrim(@col001) = 'AK1')
	begin
		set @ak101_gs01_functional_id_code = LTRIM(RTRIM(@col002))
		set @ak102_gs06_group_control_no = LTRIM(RTRIM(@col003))
		set @ak103_gs08_version_id_code = LTRIM(RTRIM(@col004))
	end
	if ( RTrim(@col001) = 'AK2')
	begin
		set @ak201_st01_transaction_id_code = LTRIM(RTRIM(@col002))
		set @ak202_st02_transaction_control_no = LTRIM(RTRIM(@col003))
		select @src_x12_functional_group_id = x12_functional_group_id
			from vw_x12_transaction
			WHERE src_x12_organization_id = ( select dest_x12_organization_id from vw_x12_transaction
								where x12_transaction_id = @x12_transaction_id ) AND
				dest_x12_organization_id = ( select src_x12_organization_id from vw_x12_transaction
								where x12_transaction_id = @x12_transaction_id ) AND
				gs06_group_control_no = @ak102_gs06_group_control_no AND
				st02_transaction_control_no = @ak202_st02_transaction_control_no
	end
	if ( RTrim(@col001) = 'AK3')
	begin
		set @ak301_segment_id_code = LTRIM(RTRIM(@col002))
		set @ak302_segment_pos = LTRIM(RTRIM(@col003))
		set @ak303_loop_id_code = LTRIM(RTRIM(@col004))
		set @ak304_segment_syntax_error_code = LTRIM(RTRIM(@col005))
	end
	if ( RTrim(@col001) = 'AK4')
	begin
		set @ak401_element_pos = LTRIM(RTRIM(@col002))
		set @ak402_data_element_ref_no = LTRIM(RTRIM(@col003))
		set @ak403_element_syntax_error_code = LTRIM(RTRIM(@col004))
		set @ak404_copy_of_bad_element = LTRIM(RTRIM(@col005))
		insert into x12_997_functional_ack
			(
			x12_transaction_id,
			src_x12_functional_group_id,
			ak101_gs01_functional_id_code, ak102_gs06_group_control_no, ak103_gs08_version_id_code, 
			ak201_st01_transaction_id_code, ak202_st02_transaction_control_no, 
			ak301_segment_id_code, ak302_segment_pos, ak303_loop_id_code, ak304_segment_syntax_error_code, 
			ak401_element_pos, ak402_data_element_ref_no, ak403_element_syntax_error_code, ak404_copy_of_bad_element
			)
		
		VALUES (
			@x12_transaction_id,
			@src_x12_functional_group_id,
			@ak101_gs01_functional_id_code, @ak102_gs06_group_control_no, @ak103_gs08_version_id_code, 
			@ak201_st01_transaction_id_code, @ak202_st02_transaction_control_no, 
			@ak301_segment_id_code, @ak302_segment_pos, @ak303_loop_id_code, @ak304_segment_syntax_error_code, 
			@ak401_element_pos, @ak402_data_element_ref_no, @ak403_element_syntax_error_code, @ak404_copy_of_bad_element
			)
	end
	if ( RTrim(@col001) = 'AK5')
	begin
		set @ak501_tran_ack_code = LTRIM(RTRIM(@col002))
		set @ak502_tran_syntax_error_code = LTRIM(RTRIM(@col003))
		set @ak503_tran_syntax_error_code = LTRIM(RTRIM(@col004))
		set @ak504_tran_syntax_error_code = LTRIM(RTRIM(@col005))
		set @ak505_tran_syntax_error_code = LTRIM(RTRIM(@col006))
		set @ak506_tran_syntax_error_code = LTRIM(RTRIM(@col007))
		insert into x12_997_functional_ack
			(
			x12_transaction_id,
			src_x12_functional_group_id,
			ak101_gs01_functional_id_code, ak102_gs06_group_control_no, ak103_gs08_version_id_code, 
			ak201_st01_transaction_id_code, ak202_st02_transaction_control_no, 
			ak301_segment_id_code, ak302_segment_pos, ak303_loop_id_code, ak304_segment_syntax_error_code, 
			ak401_element_pos, ak402_data_element_ref_no, ak403_element_syntax_error_code, ak404_copy_of_bad_element, 
			ak501_tran_ack_code, ak502_tran_syntax_error_code, ak503_tran_syntax_error_code, ak504_tran_syntax_error_code, ak505_tran_syntax_error_code, ak506_tran_syntax_error_code
			)
		
		VALUES (
			@x12_transaction_id,
			@src_x12_functional_group_id,
			@ak101_gs01_functional_id_code, @ak102_gs06_group_control_no, @ak103_gs08_version_id_code, 
			@ak201_st01_transaction_id_code, @ak202_st02_transaction_control_no, 
			@ak301_segment_id_code, @ak302_segment_pos, @ak303_loop_id_code, @ak304_segment_syntax_error_code, 
			@ak401_element_pos, @ak402_data_element_ref_no, @ak403_element_syntax_error_code, @ak404_copy_of_bad_element, 
			@ak501_tran_ack_code, @ak502_tran_syntax_error_code, @ak503_tran_syntax_error_code, @ak504_tran_syntax_error_code, @ak505_tran_syntax_error_code, @ak506_tran_syntax_error_code
			)
		-- if we're in the AK5 segment, update all the previous AK records with the following values
		update x12_997_functional_ack set ak501_tran_ack_code = @ak501_tran_ack_code,
						ak502_tran_syntax_error_code = @ak502_tran_syntax_error_code,
						ak503_tran_syntax_error_code = @ak503_tran_syntax_error_code,
						ak504_tran_syntax_error_code = @ak504_tran_syntax_error_code,
						ak505_tran_syntax_error_code = @ak505_tran_syntax_error_code,
						ak506_tran_syntax_error_code = @ak506_tran_syntax_error_code
		where	x12_transaction_id = @x12_transaction_id AND
			ak501_tran_ack_code IS NULL
	end
	if ( RTrim(@col001) = 'AK9')
	begin
		set @ak901_funct_ack_code = LTRIM(RTRIM(@col002))
		set @ak902_num_tran_sets = LTRIM(RTRIM(@col003))
		set @ak903_num_rcvd_tran_sets = LTRIM(RTRIM(@col004))
		set @ak904_num_accept_tran_sets = LTRIM(RTRIM(@col005))
		set @ak905_func_syntax_error_code = LTRIM(RTRIM(@col006))
		set @ak906_func_syntax_error_code = LTRIM(RTRIM(@col007))
		set @ak907_func_syntax_error_code = LTRIM(RTRIM(@col008))
		set @ak908_func_syntax_error_code = LTRIM(RTRIM(@col009))
		set @ak909_func_syntax_error_code = LTRIM(RTRIM(@col010))
		-- if we're in the AK9 segment, update all the previous AK records with the following values
		update x12_997_functional_ack set
						ak901_funct_ack_code = @ak901_funct_ack_code,
						ak902_num_tran_sets = @ak902_num_tran_sets,
						ak903_num_rcvd_tran_sets = @ak903_num_rcvd_tran_sets,
						ak904_num_accept_tran_sets = @ak904_num_accept_tran_sets,
						ak905_func_syntax_error_code = @ak905_func_syntax_error_code,
						ak906_func_syntax_error_code = @ak906_func_syntax_error_code,
						ak907_func_syntax_error_code = @ak907_func_syntax_error_code,
						ak908_func_syntax_error_code = @ak908_func_syntax_error_code,
						ak909_func_syntax_error_code = @ak909_func_syntax_error_code
		where	x12_transaction_id = @x12_transaction_id AND
			ak901_funct_ack_code IS NULL
	end
	FETCH NEXT FROM curtX12Doc INTO @Col001, @Col002, @Col003, @Col004, @Col005, @Col006, @Col007, @Col008, @Col009, @Col010, @Col011, @Col012, @Col013, @Col014, @Col015, @Col016, @Col017
END
CLOSE curtX12Doc
DEALLOCATE curtX12Doc
return (0)


