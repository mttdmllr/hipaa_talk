

CREATE Procedure [dbo].[up_x12_hl_export] (
					@x12_interchange_uid uniqueidentifier,
					@hl01_id_num varchar(12) = null,
					@hl02_parent_id_num varchar(12) = null,
					@hl03_level_code char(2) = null,
					@hl04_child_code char(1) = null
				   )
As

	if (@hl01_id_num IS NOT NULL AND @hl03_level_code IS NOT NULL AND @hl04_child_code IS NOT NULL)
	begin
		INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004, col005)
			Values (	CAST(@x12_interchange_uid as varchar(36)),  'HL',
					UPPER(LTRIM(RTRIM(@hl01_id_num))),
					UPPER(LTRIM(RTRIM(@hl02_parent_id_num))),
					UPPER(LTRIM(RTRIM(@hl03_level_code))),
					UPPER(LTRIM(RTRIM(@hl04_child_code)))
				) 
	end
