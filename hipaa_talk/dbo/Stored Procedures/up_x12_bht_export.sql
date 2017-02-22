


CREATE Procedure [dbo].[up_x12_bht_export] (
					@x12_interchange_uid uniqueidentifier,
					@bht01_hierarchical_structure_code char(4) = null,
					@bht02_tran_purpose_code char(2) = null,
					@bht03_app_tran_id varchar(30) = null,
					@bht04_tran_set_create_date varchar(8) = null,
					@bht05_tran_set_create_time varchar(8) = null,
					@bht06_tran_type_code char(2) = null
				   )
As

declare @success int
set @success = 0

	if (@bht04_tran_set_create_date IS NULL)
	begin
		set @bht04_tran_set_create_date = convert(char(8), getdate(), 112)
	end
	if (@bht05_tran_set_create_time IS NULL)
	begin
		set @bht05_tran_set_create_time = SUBSTRING(convert(varchar, getdate(), 114), 1, 2) + SUBSTRING(convert(varchar, getdate(), 114), 4, 2) + SUBSTRING(convert(varchar, getdate(), 114), 7, 2)
	end

	if (@bht01_hierarchical_structure_code IS NOT NULL)
	begin
		INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007)
			Values (	CAST(@x12_interchange_uid as varchar(36)),  'BHT',
					UPPER(LTRIM(RTRIM(@bht01_hierarchical_structure_code))),
					UPPER(LTRIM(RTRIM(@bht02_tran_purpose_code))),
					UPPER(LTRIM(RTRIM(@bht03_app_tran_id))),
					UPPER(LTRIM(RTRIM(@bht04_tran_set_create_date))),
					UPPER(LTRIM(RTRIM(@bht05_tran_set_create_time))),
					UPPER(LTRIM(RTRIM(@bht06_tran_type_code)))
				) 
		set @success = 1
	end
return @success
