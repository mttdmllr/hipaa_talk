
CREATE Procedure [dbo].[up_x12_ta1_export] (@x12_interchange_id int = null)
As
declare @ta101_isa13_control_no char(9)
declare @ta102_interchange_date char(6)
declare @ta103_interchange_time char(4)
declare @ta104_interchange_ack_code char(1)
declare @ta105_interchange_note_code char(3)
declare @x12_interchange_uid uniqueidentifier
select @x12_interchange_uid = x12_interchange_uid from x12_interchange
	where x12_interchange_id = @x12_interchange_id
declare @errmsg varchar(250)
declare @errcode int
-- CREATE HEADER SEGMENTS
	-- Create ISA segment
	INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010, col011, col012, col013, col014, col015, col016, col017)
		SELECT	x12_interchange_uid,
			'ISA',
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
			isa16_component_element_seperator
		FROM x12_interchange
		WHERE x12_interchange_id = @x12_interchange_id
-- END: CREATE HEADER RECORDS
DECLARE curtX12Doc SCROLL CURSOR FOR
	select	ta101_isa13_control_no,
		ta102_interchange_date,
		ta103_interchange_time,
		ta104_interchange_ack_code,
		ta105_interchange_note_code
	from x12_ta1_interchange_ack
	where	x12_interchange_id = @x12_interchange_id
	order by x12_ta1_interchange_ack_id
OPEN curtX12Doc
FETCH NEXT FROM curtX12Doc INTO	@ta101_isa13_control_no,
				@ta102_interchange_date,
				@ta103_interchange_time,
				@ta104_interchange_ack_code,
				@ta105_interchange_note_code
WHILE (@@fetch_status <> -1)
BEGIN
	INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003, col004, col005, col006)
		VALUES (@x12_interchange_uid, 'TA1', @ta101_isa13_control_no, @ta102_interchange_date,
			@ta103_interchange_time, @ta104_interchange_ack_code, @ta105_interchange_note_code )
	FETCH NEXT FROM curtX12Doc INTO	@ta101_isa13_control_no,
					@ta102_interchange_date,
					@ta103_interchange_time,
					@ta104_interchange_ack_code,
					@ta105_interchange_note_code
END
CLOSE curtX12Doc
DEALLOCATE curtX12Doc
-- CREATE TRAILER SEGMENTS
	-- Insert IEA segment
	INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003)
		SELECT	x12_interchange_uid,
			'IEA',
			0,
			isa13_control_no
		FROM x12_interchange
		WHERE x12_interchange_id = @x12_interchange_id
-- END: CREATE TRAILER RECORDS
return (0)

