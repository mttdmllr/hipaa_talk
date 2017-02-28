
create Procedure [dbo].[up_x12_ins_export] (	@x12_interchange_uid uniqueidentifier,
						@ins01_insured_indicator char(1) = null,
						@ins02_ind_relationship_code CHAR(2) = NULL,
						@ins03_maint_type_code CHAR(3) = NULL,
						@ins04_maint_reason_code CHAR(3) = NULL,
						@ins05_benefit_status_code CHAR(1) = NULL,
						@ins06_medicare_plan_code CHAR(1) = NULL,
						@ins07_cobra_code CHAR(2) = NULL,
						@ins08_employment_status_code CHAR(2) = NULL,
						@ins09_student_status_code CHAR(1) = NULL,
						@ins10_handicap_indicator CHAR(1) = NULL,
						@ins12_insured_death_date VARCHAR(35) = NULL,
						@ins13_birth_seq_num CHAR(9) = NULL
				                            )
As

	INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010, col011, col012, col013)
		Values (	CAST(@x12_interchange_uid as varchar(36)),  'INS',
				UPPER(LTRIM(RTRIM(@ins01_insured_indicator))),
				UPPER(LTRIM(RTRIM(@ins02_ind_relationship_code))),
				UPPER(LTRIM(RTRIM(@ins03_maint_type_code))),
				UPPER(LTRIM(RTRIM(@ins04_maint_reason_code))),
				UPPER(LTRIM(RTRIM(@ins05_benefit_status_code))),
				UPPER(LTRIM(RTRIM(@ins06_medicare_plan_code))),
				UPPER(LTRIM(RTRIM(@ins07_cobra_code))),
				UPPER(LTRIM(RTRIM(@ins08_employment_status_code))),
				UPPER(LTRIM(RTRIM(@ins09_student_status_code))),
				UPPER(LTRIM(RTRIM(@ins10_handicap_indicator))),
				UPPER(LTRIM(RTRIM(@ins12_insured_death_date))),
				UPPER(LTRIM(RTRIM(@ins13_birth_seq_num)))
			)
