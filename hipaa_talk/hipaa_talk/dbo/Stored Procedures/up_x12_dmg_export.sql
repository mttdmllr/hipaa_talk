CREATE Procedure [dbo].[up_x12_dmg_export] (	@x12_interchange_uid uniqueidentifier,
						@dmg01_date_time_format_qual varchar(3) = null,
						@dmg02_dob varchar(35) = null,
						@dmg03_gender char(1) = NULL,
						@dmg04_member_marital_status CHAR(1) = NULL,
						@dmg05_member_ethnicity CHAR(1) = NULL,
						@dmg06_member_citizenship CHAR(2) = NULL
				   )
As

	INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007)
		Values (	CAST(@x12_interchange_uid as varchar(36)),  'DMG',
				UPPER(LTRIM(RTRIM(@dmg01_date_time_format_qual))),
				UPPER(LTRIM(RTRIM(@dmg02_dob))),
				UPPER(LTRIM(RTRIM(@dmg03_gender))),
				UPPER(LTRIM(RTRIM(@dmg04_member_marital_status))),
				UPPER(LTRIM(RTRIM(@dmg05_member_ethnicity))),
				UPPER(LTRIM(RTRIM(@dmg06_member_citizenship)))
			)

