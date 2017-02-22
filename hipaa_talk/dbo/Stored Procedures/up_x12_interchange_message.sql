CREATE PROCEDURE [dbo].[up_x12_interchange_message] (	@x12_interchange_id int = null,
							@x12_interchange_uid uniqueidentifier = null,
							@isa13_control_no varchar(9) = null,
							@gs06_group_control_no varchar(9) = null,
							@st02_transaction_control_no varchar(9) = null,
							@loop_id varchar(10) = null,
							@segment_id char(5) = null,
							@segment_pos_in_tran int = null,
							@element_pos_in_segment int = null,
							@element_no int = null,
							@element_value varchar(128) = null,
							@message_code char(10) = null,
							@message_text nvarchar(500)  = null,
							@x12_transaction_schema_ud varchar(32) = null,
							@x12_individual_record_id int = null)
AS
declare @SQLString nvarchar(4000) 
declare @table_nm varchar(64)
if ( @x12_interchange_uid IS NULL AND @x12_interchange_id IS NOT NULL )
	select @x12_interchange_uid = x12_interchange_uid FROM x12_interchange where x12_interchange_id = @x12_interchange_id
if ( @isa13_control_no IS NULL AND @x12_interchange_uid IS NOT NULL )
	select @isa13_control_no  = isa13_control_no FROM x12_interchange where x12_interchange_uid = @x12_interchange_uid
if ( @gs06_group_control_no IS NULL AND @x12_interchange_uid IS NOT NULL )
	select @gs06_group_control_no = MAX(gs06_group_control_no) FROM vw_x12_transaction
		where x12_interchange_uid = @x12_interchange_uid
if ( @st02_transaction_control_no IS NULL AND @x12_interchange_uid IS NOT NULL )
	select @st02_transaction_control_no = MAX(st02_transaction_control_no) FROM vw_x12_transaction
		where x12_interchange_uid = @x12_interchange_uid
INSERT INTO x12_interchange_message (	x12_interchange_uid,
						isa13_control_no,
						gs06_group_control_no,
						st02_transaction_control_no,
						loop_id,
						segment_id,
						segment_pos_in_tran,
						element_pos_in_segment,
						element_no,
						element_value,
						message_code,
						message_text	)
			VALUES	(	@x12_interchange_uid,
						@isa13_control_no,
						@gs06_group_control_no,
						@st02_transaction_control_no,
						@loop_id,
						@segment_id,
						@segment_pos_in_tran,
						@element_pos_in_segment,
						@element_no,
						@element_value,
						@message_code,
						@message_text	)
-- If the primary key of the flat X12 table was passed in along with the schema, update the error bit for that record to 1.
if ( @x12_individual_record_id IS NOT NULL AND @x12_transaction_schema_ud IS NOT NULL )
begin
	-- get the table name for the specified schema
	select @table_nm = LTrim(Rtrim(table_nm)) FROM x12_transaction_schema WHERE x12_transaction_schema_ud = @x12_transaction_schema_ud
	-- if the table name was found...
	if (@table_nm IS NOT NULL AND Len(LTrim(RTrim(@table_nm))) > 0 )
	begin
		-- create the update string using the table name that was retrieved.
		set @SQLString = 'update ' + @table_nm + ' set error = 1 where ' + @table_nm + '_id = ' + STR(@x12_individual_record_id)
		exec sp_executesql @SQLString
		update x12_interchange set error = 1 where error = 0 and x12_interchange_uid = @x12_interchange_uid
	end
end
