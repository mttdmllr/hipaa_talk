

CREATE PROCEDURE [dbo].[up_x12_hd_export]
    (
      @x12_interchange_uid UNIQUEIDENTIFIER,
      @hd01_maint_type_code CHAR(3) = NULL,
	  @hd02					CHAR(3) = NULL,
      @hd03_ins_line_code CHAR(3) = NULL,
      @hd04_plan_cvg_desc VARCHAR(50) = NULL,
      @hd05_cvg_level_code VARCHAR(3) = NULL      								   
    )
AS 
    DECLARE @success INT
    SET @success = 0

    IF ( @hd01_maint_type_code IS NOT NULL       
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
					  col006
		          
                    )
            VALUES  (
                      CAST(@x12_interchange_uid AS VARCHAR(36)),
                      'HD',
                      UPPER(LTRIM(RTRIM(@hd01_maint_type_code))),
					  UPPER(LTRIM(RTRIM(@hd02				))),
                      UPPER(LTRIM(RTRIM(@hd03_ins_line_code))),
                      UPPER(LTRIM(RTRIM(@hd04_plan_cvg_desc))),
                      UPPER(LTRIM(RTRIM(@hd05_cvg_level_code)))
                    )
            SET @success = 1
        END

    RETURN @success
