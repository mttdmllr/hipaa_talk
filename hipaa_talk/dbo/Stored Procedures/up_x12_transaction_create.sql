

CREATE Procedure [dbo].[up_x12_transaction_create]
	(	@x12_transaction_id int = null output,
		@x12_transaction_uid uniqueidentifier = null,
		@x12_functional_group_id int,
		@st01_transaction_id_code char (3),
		@st02_transaction_control_no varchar (9) = null,
		@x12_parse_temp_id_start int = null,
		@x12_parse_temp_id_end int = null,
		@error bit = 0,
		@processed bit = 0,
		@active bit = 1
	)
As

/*********************
-- START DOC --
PROCEDURE: up_x12_transaction_create 

	Parameter:	[IN/OUT] @x12_transaction_id int = null output,
			[IN] @x12_transaction_uid uniqueidentifier = null,
			[IN] @x12_functional_group_id int,
			[IN] @st01_transaction_id_code char (3),
			[IN] @st02_transaction_control_no varchar (9) = null,
			[IN] @x12_parse_temp_id_start int = null,
			[IN] @x12_parse_temp_id_end int = null,
			[IN] @error bit = 0,
			[IN] @processed bit = 0,
			[IN] @active bit = 1

	Type:		INSERT (single record)

	Description:	This stored procedure creates a single ST record in the x12_transaction table to be used to sending or receiving X12 documents.  It returns the newly created
			x12_transaction_id integer value in the @x12_transaction_id variable.

	Usage:		declare @x12_transaction_id int
			exec up_x12_transaction_create	@x12_transaction_id = @x12_transaction_id output,
							@x12_functional_group_id = @x12_functional_group_id,
							@st01_transaction_id_code = '835'
	
-- END DOC --

*********************/

	-- If no @x12_transaction_uid value was passed, create one:
	if (@x12_transaction_uid IS NULL) set @x12_transaction_uid = NEWID()
	
	-- Insert the new x12_transaction record
	INSERT INTO x12_transaction
			(	x12_transaction_uid,
				x12_functional_group_id,
				st01_transaction_id_code,
				st02_transaction_control_no,
				x12_parse_temp_id_start,
				x12_parse_temp_id_end,
				error,
				processed,
				active
			)
		VALUES
		(	@x12_transaction_uid,
			@x12_functional_group_id,
			@st01_transaction_id_code,
			@st02_transaction_control_no,
			@x12_parse_temp_id_start,
			@x12_parse_temp_id_end,
			@error,
			@processed,
			@active
		)

	-- Get the x12_transaction_id for the record just inserted
	select @x12_transaction_id = SCOPE_IDENTITY()

	-- Update the st02_transaction_control_no value using the x12_transaction_id value for the new record or if the control_no wasn't specified
	if ( @st02_transaction_control_no IS NULL )
	begin
		set @st02_transaction_control_no = @x12_transaction_id
	end

	if ( Len(LTrim(RTrim(@st02_transaction_control_no))) < 4 AND Len(LTrim(RTrim(@st02_transaction_control_no))) > 0 )
	begin
		set @st02_transaction_control_no = REPLICATE('0', 4-Len(LTrim(RTrim(@st02_transaction_control_no)))) + LTrim(RTrim(@st02_transaction_control_no))
	end

	if ( Len(LTrim(RTrim(@st02_transaction_control_no))) > 9  )
	begin
		set @st02_transaction_control_no = Right(LTrim(RTrim(@st02_transaction_control_no)), 9)
	end

	update x12_transaction SET
			st02_transaction_control_no = @st02_transaction_control_no
		where	x12_transaction_id = @x12_transaction_id AND
			( st02_transaction_control_no <> @st02_transaction_control_no OR st02_transaction_control_no IS NULL )

return (0)
