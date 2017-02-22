

CREATE PROCEDURE [dbo].[up_x12_hlh_export]
    (
      @x12_interchange_uid UNIQUEIDENTIFIER,
      @hlh01_health_related_code CHAR(1) = NULL,
      @hlh02_member_height VARCHAR(8) = NULL,
      @hlh03_member_weight VARCHAR(10) = NULL    								   
    )
AS 
  
            INSERT  INTO x12_parse_temp
                    (
                      x12_parse_temp_uid,
                      col001,
                      col002,
                      col003,
                      col004         
                    )
            VALUES  (
                      CAST(@x12_interchange_uid AS VARCHAR(36)),
                      'HLH',
                      UPPER(LTRIM(RTRIM(@hlh01_health_related_code))),
                      UPPER(LTRIM(RTRIM(@hlh02_member_height))),
                      UPPER(LTRIM(RTRIM(@hlh03_member_weight)))
                    )
       


