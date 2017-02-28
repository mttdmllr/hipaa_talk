CREATE Procedure [dbo].[up_x12_n3_export] (
					@x12_interchange_uid uniqueidentifier,
					@n301_address1 varchar(55) = null,
					@n302_address2 varchar(55) = null
				   )
As

	if (@n301_address1 IS NOT NULL)
	begin
		INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003)
			Values (	CAST(@x12_interchange_uid as varchar(36)),  'N3',
					UPPER(LTRIM(RTRIM(@n301_address1))),
					UPPER(LTRIM(RTRIM(@n302_address2)))
				) 
	end

