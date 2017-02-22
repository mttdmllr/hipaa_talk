CREATE Procedure [dbo].[up_x12_sbr_export]	(
					@x12_interchange_uid uniqueidentifier,
					@sbr01_payer_resp_seq_code char(1) = null,
					@sbr02_ind_relationship_code char(2) = null,
					@sbr03_insured_grp_policy_num varchar(30) = null,
					@sbr04_insured_grp_nm varchar(60) = null,
					@sbr05_insurance_type_code char(3) = null,
					@sbr06_cob_code char(1) = null,
					@sbr09_claim_filing_ind_code char(2) = null
				   	)
As

	INSERT INTO x12_parse_temp
		(	x12_parse_temp_uid,
			col001,
			col002,
			col003,
			col004,
			col005,
			col006,
			col007,
			col010
		)
	Values	(	CAST(@x12_interchange_uid as varchar(36)), 
			'SBR',
			UPPER(LTrim(RTrim(@sbr01_payer_resp_seq_code))), 
			UPPER(LTrim(RTrim(@sbr02_ind_relationship_code))),
			UPPER(LTrim(RTrim(@sbr03_insured_grp_policy_num))),
			UPPER(LTrim(RTrim(@sbr04_insured_grp_nm))),
			UPPER(LTrim(RTrim(@sbr05_insurance_type_code))),
			UPPER(LTrim(RTrim(@sbr06_cob_code))),
			UPPER(LTrim(RTrim(@sbr09_claim_filing_ind_code)))
		)


