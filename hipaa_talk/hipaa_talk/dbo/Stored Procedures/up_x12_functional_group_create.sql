CREATE Procedure [dbo].[up_x12_functional_group_create]
	(	@x12_functional_group_id int = null output,
		@x12_functional_group_uid uniqueidentifier = null,
		@x12_interchange_id int,
		@gs01_functional_id_code char (2),
		@gs02_app_sender_code varchar (15) = null,
		@gs03_app_receiver_code varchar (15) = null,
		@gs04_date char (8) = null,
		@gs05_time varchar (8) = null,
		@gs06_group_control_no varchar (9) = null,
		@gs07_resp_agency_code varchar (2) = null,
		@gs08_version_id_code varchar (12),
		@x12_parse_temp_id_start int = null,
		@x12_parse_temp_id_end int = null,
		@error bit = 0,
		@processed bit = 0,
		@active bit = 1
	)
As
/*********************
-- START DOC --
PROCEDURE: up_x12_functional_group_create 
	Parameter:	[IN/OUT] @x12_functional_group_id int = null output,
			[IN] @x12_functional_group_uid uniqueidentifier = null,
			[IN] @x12_interchange_id int,
			[IN] @gs01_functional_id_code char (2),
			[IN] @gs02_app_sender_code varchar (15) = null,
			[IN] @gs03_app_receiver_code varchar (15) = null,
			[IN] @gs04_date char (8) = null,
			[IN] @gs05_time varchar (8) = null,
			[IN] @gs06_group_control_no varchar (9) = null,
			[IN] @gs07_resp_agency_code char (2) = null,
			[IN] @gs08_version_id_code varchar (12),
			[IN] @x12_parse_temp_id_start int = null,
			[IN] @x12_parse_temp_id_end int = null,
			[IN] @error bit = 0,
			[IN] @processed bit = 0,
			[IN] @active bit = 1
	Type:		INSERT (single record)
	Description:	This stored procedure creates a single GS record in the x12_functional_group table to be used to sending or receiving X12 documents.  It returns the newly created
			x12_functional_group_id integer value in the @x12_functional_group_id variable.
	Usage:		declare @x12_functional_group_id int
			exec up_x12_functional_group_create	@x12_functional_group_id = @x12_functional_group_id output,
								@x12_interchange_id = @x12_interchange_id,
								@gs01_functional_id_code = 'HP',
								@gs08_version_id_code = '004010X091A1'
	
-- END DOC --
*********************/
	declare @x12_transaction_schema_id int
	declare @curhour char(2)
	declare @curminute char(2)
	
	set @curhour = SUBSTRING(convert(varchar, getdate(), 114), 1, 2)
	set @curminute = SUBSTRING(convert(varchar, getdate(), 114), 4, 2)
	-- Set the TRANSACTION SCHEMA type
	if (@gs01_functional_id_code = 'FA')
	begin
		select @x12_transaction_schema_id = x12_transaction_schema_id
			from x12_transaction_schema
			where x12_transaction_schema.transaction_id_code = '997'
	end
	else
	begin
		select @x12_transaction_schema_id = x12_transaction_schema_id
			from x12_transaction_schema
			where	x12_transaction_schema.functional_version_id_code = @gs08_version_id_code AND
				x12_transaction_schema.functional_group_id_code = @gs01_functional_id_code
	end
	-- if the sender and/or receiver code is NULL, use the values from the ISA segment
	if (@gs02_app_sender_code IS NULL) select @gs02_app_sender_code = isa06_sender_id FROM x12_interchange where x12_interchange_id = @x12_interchange_id
	if (@gs03_app_receiver_code IS NULL) select @gs03_app_receiver_code = isa08_receiver_id FROM x12_interchange where x12_interchange_id = @x12_interchange_id
	if (@gs04_date IS NULL OR LEN(LTRIM(RTRIM(@gs04_date))) < 8) set @gs04_date = convert(char(8), getdate(), 112)
	if (@gs05_time IS NULL OR LEN(LTRIM(RTRIM(@gs05_time))) < 4) set @gs05_time = @curhour + @curminute
	-- set the gs06_group_control_no value after the record is inserted
	if (@gs07_resp_agency_code IS NULL OR LEN(LTRIM(RTRIM(@gs07_resp_agency_code))) > 2) set @gs07_resp_agency_code = 'X'
	-- If no @x12_transaction_uid value was passed, create one:
	if (@x12_functional_group_uid IS NULL) set @x12_functional_group_uid = NEWID()
	
	-- Insert the new x12_functional_group record
	INSERT INTO x12_functional_group
			(	x12_functional_group_uid,
				x12_transaction_schema_id,
				x12_interchange_id,
				gs01_functional_id_code,
				gs02_app_sender_code,
				gs03_app_receiver_code,
				gs04_date,
				gs05_time,
				gs06_group_control_no,
				gs07_resp_agency_code,
				gs08_version_id_code,
				x12_parse_temp_id_start,
				x12_parse_temp_id_end,
				error,
				processed,
				active
			)
		VALUES
		(	@x12_functional_group_uid,
			@x12_transaction_schema_id,
			@x12_interchange_id,
			@gs01_functional_id_code,
			@gs02_app_sender_code,
			@gs03_app_receiver_code,
			@gs04_date,
			@gs05_time,
			@gs06_group_control_no,
			@gs07_resp_agency_code,
			@gs08_version_id_code,
			@x12_parse_temp_id_start,
			@x12_parse_temp_id_end,
			@error,
			@processed,
			@active
	
		)
	
	-- Get the x12_functional_group_id for the record just inserted
		select @x12_functional_group_id = SCOPE_IDENTITY()
	
		-- Update the gs06_group_control_no value using the x12_functional_group_id value for the new record
		if (@gs06_group_control_no IS NULL)
		begin
			update x12_functional_group SET
					gs06_group_control_no = ISNULL(@gs06_group_control_no, @x12_functional_group_id) 
				where x12_functional_group_id = @x12_functional_group_id
		end
return (0)
