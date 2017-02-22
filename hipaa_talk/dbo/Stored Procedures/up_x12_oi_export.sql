CREATE Procedure [dbo].[up_x12_oi_export] (	@x12_interchange_uid uniqueidentifier,
					@oi03_benefit_assign_ind char(1) = null,
					@oi04_patient_signature_code char(1) = null,
					@oi06_release_of_info_code char(1) = null
				   )
As

	INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col004, col005, col007)
		Values (	CAST(@x12_interchange_uid as varchar(36)),  'OI',
				UPPER(LTRIM(RTRIM(@oi03_benefit_assign_ind))),
				UPPER(LTRIM(RTRIM(@oi04_patient_signature_code))),
				UPPER(LTRIM(RTRIM(@oi06_release_of_info_code)))
			)

