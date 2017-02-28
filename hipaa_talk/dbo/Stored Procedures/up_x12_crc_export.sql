CREATE Procedure [dbo].[up_x12_crc_export] (	@x12_interchange_uid uniqueidentifier,
					@crc01_code_category char(2) = null,
					@crc02_limitation_code char(1) = null,
					@crc03_code char(2) = null,
					@crc04_code char(2) = null,
					@crc05_code char(2) = null,
					@crc06_code char(2) = null,
					@crc07_code char(2) = null
				         )
As

	INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col008)
		Values (		CAST(@x12_interchange_uid as varchar(36)),
				'CRC',
				@crc01_code_category,
				@crc02_limitation_code,
				@crc03_code,
				@crc04_code,
				@crc05_code,
				@crc06_code,
				@crc07_code
			)

