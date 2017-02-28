--LIN**N4*01234567891~

CREATE Procedure [dbo].[up_x12_lin_export] (	@x12_interchange_uid uniqueidentifier,
					@2410_LIN02_ProductOrServiceIDQualifier varchar(2),
					@2410_LIN03_NationalDrugCode varchar(48)
				   )
As

	IF LEN(LTRIM(RTRIM(@2410_LIN03_NationalDrugCode))) > 0
	BEGIN
		INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004)
			Values	(	@x12_interchange_uid,
					'LIN',
					NULL,
					UPPER(LTrim(RTrim(@2410_LIN02_ProductOrServiceIDQualifier))),
					UPPER(LTrim(RTrim(@2410_LIN03_NationalDrugCode)))
				)
	END

