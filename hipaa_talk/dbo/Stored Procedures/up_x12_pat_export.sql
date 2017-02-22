CREATE Procedure [dbo].[up_x12_pat_export] (	@x12_interchange_uid uniqueidentifier,
					@pat01_ind_rel_code char(2) = null,
					@pat04_student_status_code char(1) = null,
					@pat05_date_time_format_qual char(3) = 'D8',
					@pat06_patient_death_date varchar(35) = null,
					@pat07_unit_measure_code char(2) = null,
					@pat08_patient_weight varchar(10) = null,
					@pat09_pregnancy_ind char(1) = null
				   )
As

-- If the patient death date was not provided, set the format qualifier to NULL
if ( Len(LTrim(RTrim(@pat06_patient_death_date))) = 0 OR @pat06_patient_death_date IS NULL)
begin
	set @pat05_date_time_format_qual = null
end

	INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col005, col006, col007, col008, col009, col010)
		Values (	CAST(@x12_interchange_uid as varchar(36)),  'PAT',
				UPPER(LTRIM(RTRIM(@pat01_ind_rel_code))),
				UPPER(LTRIM(RTRIM(@pat04_student_status_code))),
				UPPER(LTRIM(RTRIM(@pat05_date_time_format_qual))),
				UPPER(LTRIM(RTRIM(@pat06_patient_death_date))),
				UPPER(LTRIM(RTRIM(@pat07_unit_measure_code))),
				UPPER(LTRIM(RTRIM(@pat08_patient_weight))),
				UPPER(LTRIM(RTRIM(@pat09_pregnancy_ind)))
			)

