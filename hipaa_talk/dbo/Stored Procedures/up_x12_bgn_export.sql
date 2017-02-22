

CREATE PROCEDURE [dbo].[up_x12_bgn_export]
    (
      @x12_interchange_uid UNIQUEIDENTIFIER,
      @bgn01_trans_set_purpose_code CHAR(2) = NULL,
      @bgn02_trans_set_ident_code VARCHAR(30) = NULL,
      @bgn03_trans_set_creation_date CHAR(8) = NULL,
      @bgn04_trans_set_creation_time VARCHAR(8) = NULL,
      @bgn05_time_zone_code CHAR(2) = NULL,
      @bgn06_trans_set_ident_code VARCHAR(30) = NULL,
	  @bgn07 varchar(30) = null,
      @bgn08_action_code CHAR(2) = NULL
				
				   
    )
AS 
    DECLARE @success INT
    SET @success = 0

    IF ( @bgn01_trans_set_purpose_code IS NOT NULL
         AND @bgn02_trans_set_ident_code IS NOT NULL
         AND @bgn03_trans_set_creation_date IS NOT NULL
         AND @bgn04_trans_set_creation_time IS NOT NULL
       ) 
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
                      'BGN',
                      UPPER(LTRIM(RTRIM(@bgn01_trans_set_purpose_code))),
                      UPPER(LTRIM(RTRIM(@bgn02_trans_set_ident_code))),
                      UPPER(LTRIM(RTRIM(@bgn03_trans_set_creation_date))),
                      UPPER(LTRIM(RTRIM(@bgn04_trans_set_creation_time))),
                      UPPER(LTRIM(RTRIM(@bgn05_time_zone_code))),
                      UPPER(LTRIM(RTRIM(@bgn06_trans_set_ident_code))),
					  UPPER(LTRIM(RTRIM(@bgn07))),
                      UPPER(LTRIM(RTRIM(@bgn08_action_code)))
                    )
            SET @success = 1
        END

    RETURN @success
