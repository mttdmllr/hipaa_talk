CREATE Procedure [dbo].[up_x12_nm1_parse] (	@x12_transaction_schema_ud varchar(35),
					@loop_id_code varchar(6) = null, 
					@nm1_string nvarchar(350) = null,
					@segment_id_code varchar(5) = null,
					@nm101 varchar(5) = null,
					@nm102 varchar(5) = null,
					@nm103 varchar(50) = null,
					@nm104 varchar(50) = null,
					@nm105 varchar(50) = null,
					@nm106 varchar(15) = null,
					@nm107 varchar(15) = null,
					@nm108 varchar(5) = null,
					@nm109 varchar(100) = null,
					@nm101_entity_id_code varchar(3) output,
					@nm102_entity_type_qual char(1) output,
					@nm103_last_name varchar(35) output,
					@nm104_first_name varchar(25) = null output,
					@nm105_middle_name varchar(25) = null output,
					@nm106_name_prefix varchar(10) = null output,
					@nm107_name_suffix varchar(10) = null output,
					@nm108_id_code_qual varchar(2) = null output,
					@nm109_id_code varchar(80) = null output )
As

declare	@errmsg nvarchar(500),
	@delim varchar(5)

set @delim = '*'

if (	(@nm1_string IS NOT NULL AND dbo.fn_ListGetAt(@nm1_string, 1, @delim) <> 'NM1') OR
	(@segment_id_code IS NOT NULL AND @segment_id_code <> 'NM1')
   )
begin
	-- If the string is NOT NULL, but the first element in the string isn't "NM1" or if the segment_id_code passed in isn't "NM1" then break out.
	if (@segment_id_code IS NOT NULL AND @nm1_string IS NULL)
	begin
		set @nm1_string =	IsNull(@segment_id_code, '') + @delim +
					IsNull(@nm101, '') + @delim +
					IsNull(@nm102, '') + @delim +
					IsNull(@nm103, '') + @delim +
					IsNull(@nm104, '') + @delim +
					IsNull(@nm105, '') + @delim +
					IsNull(@nm106, '') + @delim +
					IsNull(@nm107, '') + @delim +
					IsNull(@nm108, '') + @delim +
					IsNull(@nm109, '')
	end

	-- Get out of here if the segment isn't valid.
	set @errmsg = 'THE STRING: [' + @nm1_string + '] IS NOT A VALID NM1 SEGMENT'
	RAISERROR(@errmsg, 16, 1)
	return(0)
end

-- Only parse the NM1 string if it was passed in, otherwise use the values for nm101-9 that have been passed.
if ( @nm1_string IS NOT NULL )
begin
	set @nm101 = dbo.fn_ListGetAt(@nm1_string, 2, @delim)
	set @nm102 = dbo.fn_ListGetAt(@nm1_string, 3, @delim)
	set @nm103 = dbo.fn_ListGetAt(@nm1_string, 4, @delim)
	set @nm104 = dbo.fn_ListGetAt(@nm1_string, 5, @delim)
	set @nm105 = dbo.fn_ListGetAt(@nm1_string, 6, @delim)
	set @nm106 = dbo.fn_ListGetAt(@nm1_string, 7, @delim)
	set @nm107 = dbo.fn_ListGetAt(@nm1_string, 8, @delim)
	set @nm108 = dbo.fn_ListGetAt(@nm1_string, 9, @delim)
	set @nm109 = dbo.fn_ListGetAt(@nm1_string, 10, @delim)
end

-- BEGIN: Error checking for each field

	-- NM101 Error Checking
	if (Len(@nm101) > 3)
	begin
		PRINT 'NM101 exceeds maximum length.'
	end
	if (Len(@nm101) < 2 OR @nm101 IS NULL)
	begin
		PRINT 'NM101 is shorter than the minimum length.'
	end
	
	-- NM102 Error Checking
	if (Len(@nm102) > 1)
	begin
		PRINT 'NM102 exceeds maximum length.'
	end
	if (Len(@nm102) = 0 OR @nm102 IS NULL)
	begin
		PRINT 'NM102 is shorter than the minimum length.'
	end
	if ( ISNUMERIC(@nm102) = 0 )
	begin
		PRINT 'NM102 expects a numeric code.'
	end
	
	-- NM103 Error Checking
	if (Len(@nm103) > 35)
	begin
		PRINT 'NM103 exceeds maximum length.'
	end
	if (@nm103 IS NULL)
	begin
		PRINT 'NM103 is a required field.'
	end
	
	-- NM104 Error Checking
	if (Len(@nm104) > 25)
	begin
		PRINT 'NM104 exceeds maximum length.'
	end
	
	-- NM105 Error Checking
	if (Len(@nm105) > 25)
	begin
		PRINT 'NM105 exceeds maximum length.'
	end
	
	-- NM106 Error Checking
	if (Len(@nm106) > 10)
	begin
		PRINT 'NM106 exceeds maximum length.'
	end
	
	-- NM107 Error Checking
	if (Len(@nm107) > 10)
	begin
		PRINT 'NM107 exceeds maximum length.'
	end
	
	-- NM108 Error Checking
	if (Len(@nm108) > 2)
	begin
		PRINT 'NM108 exceeds maximum length.'
	end
	
	-- NM109 Error Checking
	if (Len(@nm109) > 80)
	begin
		PRINT 'NM109 exceeds maximum length.'
	end
	if ((Len(@nm109) < 2) AND @nm109 IS NOT NULL)
	begin
		PRINT 'NM109 is shorter than the minimum length.'
	end

set @nm101_entity_id_code = @nm101
set @nm102_entity_type_qual = @nm102
set @nm103_last_name = @nm103
set @nm104_first_name = @nm104
set @nm105_middle_name = @nm105
set @nm106_name_prefix = @nm106
set @nm107_name_suffix = @nm107
set @nm108_id_code_qual = @nm108
set @nm109_id_code = @nm109

