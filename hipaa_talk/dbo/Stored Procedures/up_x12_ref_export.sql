

CREATE Procedure [dbo].[up_x12_ref_export] (
					@x12_interchange_uid uniqueidentifier,
					@ref01_id_qual char(3) = null,
					@ref02_reference_number varchar(30) = null
				   )
As

	if (Len(LTrim(RTrim(IsNull(@ref02_reference_number, '')))) > 0 AND @ref01_id_qual IS NOT NULL)
	begin
		INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003)
			Values (	CAST(@x12_interchange_uid as varchar(36)),  'REF',
					UPPER(LTRIM(RTRIM(@ref01_id_qual))),
					UPPER(LTRIM(RTRIM(@ref02_reference_number)))
				) 
	end
