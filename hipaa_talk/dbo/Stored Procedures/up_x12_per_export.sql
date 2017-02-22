


CREATE PROCEDURE [dbo].[up_x12_per_export]
    (
      @x12_interchange_uid UNIQUEIDENTIFIER,
      @perf01_contact_function_code CHAR(2) = NULL,
      @perf02_contact_name VARCHAR(60) = NULL,
      @perf03_contact_number_qual CHAR(2) = NULL,
      @perf04_contact_number VARCHAR(80) = NULL,
      @perf05_contact_number_qual CHAR(2) = NULL,
      @perf06_contact_number VARCHAR(80) = NULL,
      @perf07_contact_number_qual CHAR(2) = NULL,
      @perf08_contact_number VARCHAR(80) = NULL
				   
    )
AS 
	--Added the logic for when the function code is "IP" the per02 is not required 
    IF (( @perf01_contact_function_code = 'IP' AND
		 @perf02_contact_name IS NULL AND
         @perf03_contact_number_qual IS NOT NULL)
       OR ( @perf01_contact_function_code <> 'IP' AND
			@perf01_contact_function_code IS NOT NULL AND
            @perf02_contact_name IS NOT NULL AND
            @perf03_contact_number_qual IS NOT NULL
           )) 
        BEGIN
            INSERT  INTO x12_parse_temp
                    (
                      x12_parse_temp_uid,
                      col001,
                      col002,
                      col003,
                      col004,
                      col005,
                      col006,
                      col007,
                      col008,
                      col009
                    )
            VALUES  (
                      CAST(@x12_interchange_uid AS VARCHAR(36)),
                      'PER',
                      UPPER(LTRIM(RTRIM(@perf01_contact_function_code))),
                      UPPER(LTRIM(RTRIM(@perf02_contact_name))),
                      UPPER(LTRIM(RTRIM(@perf03_contact_number_qual))),
                      UPPER(LTRIM(RTRIM(@perf04_contact_number))),
                      UPPER(LTRIM(RTRIM(@perf05_contact_number_qual))),
                      UPPER(LTRIM(RTRIM(@perf06_contact_number))),
                      UPPER(LTRIM(RTRIM(@perf07_contact_number_qual))),
                      UPPER(LTRIM(RTRIM(@perf08_contact_number)))
                    ) 
        END

   
