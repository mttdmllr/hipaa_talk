CREATE Procedure [dbo].[up_x12_trn_export] (
					@x12_interchange_uid uniqueidentifier,
					@trn01_trace_type_code char(2) = null,
					@trn02_reference_id varchar(50) = null,
					@trn03_orig_company_id char(10) = null,
					@trn04_reference_id varchar(50) = null
				   )
As

	if (@trn01_trace_type_code IS NOT NULL )
	begin
		INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004, col005)
			Values (	CAST(@x12_interchange_uid as varchar(36)),  'TRN',
					UPPER(LTRIM(RTRIM(@trn01_trace_type_code))),
					UPPER(LTRIM(RTRIM(@trn02_reference_id))),
					UPPER(LTRIM(RTRIM(@trn03_orig_company_id))),
					UPPER(LTRIM(RTRIM(@trn04_reference_id)))
				) 
	end

