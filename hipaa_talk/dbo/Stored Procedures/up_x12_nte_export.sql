CREATE Procedure [dbo].[up_x12_nte_export] (	@x12_interchange_uid uniqueidentifier,
					@note_reference_code char(3) = null,
					@note_text varchar(80) = null
				         )
As

	if (@note_text IS NOT NULL)
	begin
		INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003 )
			Values (	CAST(@x12_interchange_uid as varchar(36)),  'NTE',
				UPPER(LTrim(RTrim(@note_reference_code))),
				UPPER(LTrim(RTrim(@note_text)))
				) 
	end

