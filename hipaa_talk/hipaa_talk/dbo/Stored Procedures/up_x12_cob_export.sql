
CREATE Procedure [dbo].[up_x12_cob_export] (	@x12_interchange_uid uniqueidentifier,
						@cob01_payer_resp_seq_code varchar(1) = null,
						@cob02_insured_grp_policy_num varchar(30) = null,
						@cob03_cob_code char(1) = null
				   )
As

	INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004)
		Values (	CAST(@x12_interchange_uid as varchar(36)),  'COB',
				UPPER(LTRIM(RTRIM(@cob01_payer_resp_seq_code))),
				UPPER(LTRIM(RTRIM(@cob02_insured_grp_policy_num))),
				UPPER(LTRIM(RTRIM(@cob03_cob_code)))
			)
