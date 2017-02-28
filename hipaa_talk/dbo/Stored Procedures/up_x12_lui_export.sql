

CREATE PROCEDURE [dbo].[up_x12_lui_export]
    (
      @x12_interchange_uid UNIQUEIDENTIFIER,
      @lui01_language_code_qual CHAR(2) = NULL,
      @lui02_language_code VARCHAR(80) = NULL,
      @lui03_language_desc VARCHAR(80) = NULL,
      @lui04_language_use_indicator VARCHAR(2) = NULL      								   
    )
AS 
    DECLARE @success INT
    SET @success = 0

    IF ( @lui01_language_code_qual IS NOT NULL       
       ) 
        BEGIN
            INSERT  INTO x12_parse_temp
                    (
                      x12_parse_temp_uid,
                      col001,
                      col002,
                      col003,
                      col004,
                      col005          
                    )
            VALUES  (
                      CAST(@x12_interchange_uid AS VARCHAR(36)),
                      'LUI',
                      UPPER(LTRIM(RTRIM(@lui01_language_code_qual))),
                      UPPER(LTRIM(RTRIM(@lui02_language_code))),
                      UPPER(LTRIM(RTRIM(@lui03_language_desc))),
                      UPPER(LTRIM(RTRIM(@lui04_language_use_indicator)))
                    )
            SET @success = 1
        END

    RETURN @success
