

CREATE PROCEDURE [dbo].[up_x12_act_export]
    (
      @x12_interchange_uid UNIQUEIDENTIFIER,
      @act01_tpa_broker_accnt_num VARCHAR(35) = NULL,
      @act06_tpa_broker_accnt_num VARCHAR(35) = NULL    								   
    )
AS 
  
            INSERT  INTO x12_parse_temp
                    (
                      x12_parse_temp_uid,
                      col001,
                      col002,
                      col003         
                    )
            VALUES  (
                      CAST(@x12_interchange_uid AS VARCHAR(36)),
                      'ACT',
                      UPPER(LTRIM(RTRIM(@act01_tpa_broker_accnt_num))),
                      UPPER(LTRIM(RTRIM(@act06_tpa_broker_accnt_num)))
                    )
       


