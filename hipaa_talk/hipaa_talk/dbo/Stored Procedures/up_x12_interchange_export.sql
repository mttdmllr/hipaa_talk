CREATE PROCEDURE [dbo].[up_x12_interchange_export] (	@x12_interchange_id int = null,
						@x12_interchange_uid uniqueidentifier = null)

AS

-- if the x12_interchange_id value is null, get it using the x12_interchange_uid
if ( @x12_interchange_id IS NULL)
	select @x12_interchange_id = x12_interchange_id from x12_interchange where x12_interchange_uid = @x12_interchange_uid

-- if the x12_interchange_uid value is null, get it using the x12_interchange_id
if ( @x12_interchange_uid IS NULL)
	select @x12_interchange_uid = x12_interchange_uid from x12_interchange where x12_interchange_id = @x12_interchange_id

-- If BOTH the x12_interchange_id and x12_interchange_uid values are null, bail.
if ( @x12_interchange_uid IS NULL AND @x12_interchange_id IS NULL )
	return(0)

declare @cur_x12_functional_group_id int
declare @cur_x12_transaction_id int
declare @cur_x12_transaction_schema_ud varchar(32)
declare @cur_export_procedure_nm varchar(128)

declare @funct_grp_count int
declare @tran_set_count int
declare @segment_count int

set @funct_grp_count = 0
set @tran_set_count = 0
set @segment_count = 0

-- Set the defaults for this transaction.
exec up_x12_interchange_set_defaults @x12_interchange_id


-- CREATE HEADER SEGMENTS
-- Create the ISA segment
INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010, col011, col012, col013, col014, col015, col016, col017)
	SELECT	x12_interchange_uid,
			'ISA',
			IsNull(isa01_auth_info_qual, REPLICATE(' ', 2)),
			IsNull(isa02_auth_info, REPLICATE(' ', 10)),
			IsNull(isa03_security_info_qual, REPLICATE(' ', 2)),
			IsNull(isa04_security_info, REPLICATE(' ', 10)),
			IsNull(isa05_sender_id_qual, REPLICATE(' ', 2)),
			IsNull(isa06_sender_id, REPLICATE(' ', 15)),
			IsNull(isa07_receiver_id_qual, REPLICATE(' ', 2)),
			IsNull(isa08_receiver_id, REPLICATE(' ', 15)),
			IsNull(isa09_interchange_date, REPLICATE(' ', 6)),
			IsNull(isa10_interchange_time, REPLICATE(' ', 4)),
			IsNull(isa11_control_standards_id, 'U'),
			IsNull(isa12_control_version_no, REPLICATE(' ', 5)),
			IsNull(isa13_control_no, REPLICATE(' ', 9)),
			IsNull(isa14_ack_requested, '0'),
			IsNull(isa15_usage_indicator, 'P'),
			isa16_component_element_seperator
	FROM x12_interchange
	WHERE x12_interchange_id = @x12_interchange_id

DECLARE curGS SCROLL CURSOR FOR	SELECT DISTINCT	x12_functional_group.x12_functional_group_id,
									x12_transaction_schema.x12_transaction_schema_ud,
									x12_transaction_schema.export_procedure_nm
				FROM x12_functional_group
				INNER JOIN x12_transaction_schema
					ON x12_functional_group.x12_transaction_schema_id = x12_transaction_schema.x12_transaction_schema_id 
				WHERE x12_interchange_id = @x12_interchange_id

OPEN curGS


set @funct_grp_count = 0

-- GET ALL THE FUNCTIONAL GROUPS FOR THIS INTERCHANGE
FETCH NEXT FROM curGS INTO @cur_x12_functional_group_id, @cur_x12_transaction_schema_ud, @cur_export_procedure_nm
WHILE (@@fetch_status <> -1)
BEGIN
	-- Create GS segment
	INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col008, col009)
		SELECT	@x12_interchange_uid,
				'GS',
				LTrim(RTrim(gs01_functional_id_code)),
				LTrim(RTrim(gs02_app_sender_code)),
				LTrim(RTrim(gs03_app_receiver_code)),
				LTrim(RTrim(gs04_date)),
				LTrim(RTrim(gs05_time)),
				LTrim(RTrim(gs06_group_control_no)),
				LTrim(RTrim(gs07_resp_agency_code)),
				LTrim(RTrim(gs08_version_id_code))
		FROM x12_functional_group
		WHERE x12_functional_group_id = @cur_x12_functional_group_id

	set @funct_grp_count = @funct_grp_count + 1



	-- GET ALL THE TRANSACTIONS FOR THIS FUNCTIONAL GROUP
	DECLARE curST SCROLL CURSOR FOR	SELECT DISTINCT	x12_transaction_id
					FROM x12_transaction
					WHERE x12_functional_group_id = @cur_x12_functional_group_id
	
	OPEN curST
	
	
	set @tran_set_count = 0

	FETCH NEXT FROM curST INTO @cur_x12_transaction_id
	WHILE (@@fetch_status <> -1)
	BEGIN
		-- Create ST segment
		INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003)
			SELECT	x12_interchange_uid,
				'ST',
				LTrim(RTrim(st01_transaction_id_code)),
				LTrim(RTrim(st02_transaction_control_no))
			FROM vw_x12_transaction
			WHERE x12_transaction_id = @cur_x12_transaction_id
		set @tran_set_count = @tran_set_count + 1

		-- RUN THE SPECIFIED TRANSACTION EXPORTS HERE AS SPECIFIED BY THE TRANSACTION_SCHEMA TABLE.
		exec @cur_export_procedure_nm	@x12_transaction_id = @cur_x12_transaction_id,
							@segment_count = @segment_count output

		-- Insert SE segment
		INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003)
			SELECT	@x12_interchange_uid,
				'SE',
				@segment_count + 2, -- add 2 to include ST/SE segments
				st02_transaction_control_no
			FROM vw_x12_transaction
			WHERE x12_transaction_id = @cur_x12_transaction_id

		FETCH NEXT FROM curST INTO @cur_x12_transaction_id
	END
	
	
	CLOSE curST
	DEALLOCATE curST




	-- Insert GE segment
	INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003)
		SELECT	@x12_interchange_uid,
			'GE',
			@tran_set_count,
			gs06_group_control_no
		FROM x12_functional_group
		WHERE x12_functional_group_id = @cur_x12_functional_group_id


	FETCH NEXT FROM curGS INTO @cur_x12_functional_group_id, @cur_x12_transaction_schema_ud, @cur_export_procedure_nm
END


CLOSE curGS
DEALLOCATE curGS



-- Insert IEA segment
INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003)
	SELECT	x12_interchange_uid,
		'IEA',
		@funct_grp_count,
		isa13_control_no
	FROM x12_interchange
	WHERE x12_interchange_id = @x12_interchange_id

