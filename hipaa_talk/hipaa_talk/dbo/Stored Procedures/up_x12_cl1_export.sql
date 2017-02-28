CREATE Procedure [dbo].[up_x12_cl1_export] (	@x12_interchange_uid uniqueidentifier,
					@cl101_admit_type_code char(1) = null,
					@cl102_admit_source_code char(1) = null,
					@cl103_patient_status_code char(2) = null
				   )
As

	INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004)
		Values (	CAST(@x12_interchange_uid as varchar(36)),  'CL1',
				UPPER(LTRIM(RTRIM(@cl101_admit_type_code))),
				UPPER(LTRIM(RTRIM(@cl102_admit_source_code))),
				UPPER(LTRIM(RTRIM(@cl103_patient_status_code)))
			)

