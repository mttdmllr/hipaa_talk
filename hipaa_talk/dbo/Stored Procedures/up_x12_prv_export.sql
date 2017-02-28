

CREATE Procedure [dbo].[up_x12_prv_export] (
					@x12_interchange_uid uniqueidentifier,
					@prv01_provider_code varchar(3) = null,
					@prv02_provider_id_qual varchar(3) = null,
					@prv03_provider_id varchar(30) = null
				   )
As

	if (@prv01_provider_code IS NOT NULL AND @prv02_provider_id_qual IS NOT NULL AND @prv03_provider_id IS NOT NULL)
	begin
		INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004)
			Values (	CAST(@x12_interchange_uid as varchar(36)),  'PRV',
					UPPER(LTRIM(RTRIM(@prv01_provider_code))),
					UPPER(LTRIM(RTRIM(@prv02_provider_id_qual))),
					UPPER(LTRIM(RTRIM(@prv03_provider_id)))
				) 
	end
