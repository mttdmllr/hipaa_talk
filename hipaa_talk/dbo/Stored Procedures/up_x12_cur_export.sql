CREATE Procedure [dbo].[up_x12_cur_export] (	@x12_interchange_uid uniqueidentifier,
					@cur01_entity_id_code char(3) = null,
					@cur02_currency_code char(3) = null,
					@cur03_exchange_rate varchar(10) = null
				   )
As

if ( @cur01_entity_id_code IS NOT NULL AND @cur02_currency_code IS NOT NULL )
begin
	INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004)
		Values (	CAST(@x12_interchange_uid as varchar(36)),  'CUR',
				UPPER(LTRIM(RTRIM(@cur01_entity_id_code))),
				UPPER(LTRIM(RTRIM(@cur02_currency_code))),
				UPPER(LTRIM(RTRIM(@cur03_exchange_rate)))
			)
end

