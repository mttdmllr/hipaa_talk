

CREATE Procedure [dbo].[up_x12_n4_export] (
					@x12_interchange_uid uniqueidentifier,
					@n401_city varchar(30) = null,
					@n402_state char(2) = null,
					@n403_zip varchar(15) = null,
					@n404_country char(3) = null,
					@n405_location_qual char(2) = null,
					@n406_location_id_code varchar(30) = null
				   )
As

	if (@n401_city IS NOT NULL)
	begin
		INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007)
			Values (	CAST(@x12_interchange_uid as varchar(36)),  'N4',
					UPPER(LTRIM(RTRIM(@n401_city))),
					UPPER(LTRIM(RTRIM(@n402_state))),
					REPLACE(UPPER(LTRIM(RTRIM(@n403_zip))), '-', ''),
					UPPER(LTRIM(RTRIM(@n404_country))),
					UPPER(LTRIM(RTRIM(@n405_location_qual))),
					UPPER(LTRIM(RTRIM(@n406_location_id_code)))
				) 
	end
