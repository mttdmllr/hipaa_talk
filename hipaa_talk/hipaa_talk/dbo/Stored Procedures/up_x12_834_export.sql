CREATE PROCEDURE [dbo].[up_x12_834_export]
    (
      @x12_transaction_id INT = NULL,
      @segment_count INT OUTPUT
    )
AS /******************************************************************************
**		Name: up_x12_834_export
**
**		Desc: 
**	    Type: 
**		Return values: 
**
**		Called By:
**
**		Auth: rebecca.preston@phtech.com
**		Date: 6/16/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		--------		--------				-------------------------------------------
**     Here is a note
************************************************************************************/



--Declare
    DECLARE @Col001 VARCHAR(255)
    DECLARE @Col002 VARCHAR(255)
    DECLARE @Col003 VARCHAR(255)
    DECLARE @Col004 VARCHAR(255)
    DECLARE @Col005 VARCHAR(255)
    DECLARE @Col006 VARCHAR(255)
    DECLARE @Col007 VARCHAR(255)
    DECLARE @Col008 VARCHAR(255)
    DECLARE @Col009 VARCHAR(255)
    DECLARE @Col010 VARCHAR(255)
    DECLARE @Col011 VARCHAR(255)
    DECLARE @Col012 VARCHAR(255)
    DECLARE @Col013 VARCHAR(255)
    DECLARE @Col014 VARCHAR(255)
    DECLARE @Col015 VARCHAR(255)
    DECLARE @Col016 VARCHAR(255)
    DECLARE @Col017 VARCHAR(255)
    DECLARE @Col018 VARCHAR(255)
    DECLARE @Col019 VARCHAR(255)
    DECLARE @Col020 VARCHAR(255)
    DECLARE @Col021 VARCHAR(255)


    DECLARE @x12_834_benefit_enrollment_id INT 
    DECLARE @bgn01_trans_set_purpose_code CHAR(2)
    DECLARE @bgn02_trans_set_ident_code VARCHAR(30)
    DECLARE @bgn03_trans_set_creation_date CHAR(8)
    DECLARE @bgn04_trans_set_creation_time VARCHAR(8)
    DECLARE @bgn05_time_zone_code CHAR(2)
    DECLARE @bgn06_trans_set_ident_code VARCHAR(30)
    DECLARE @bgn07 VARCHAR(30)
    DECLARE @bgn08_action_code CHAR(2)
    DECLARE @ref01_reference_id_qual CHAR(3)
    DECLARE @ref02_master_policy_number VARCHAR(30)
    DECLARE @dtp01_date_time_qual CHAR(3)
    DECLARE @dtp02_date_time_period_fmt_qual CHAR(3)
    DECLARE @dtp03_date_time_period VARCHAR(35)
    DECLARE @L1000A_n101_entity_id_code CHAR(3)
    DECLARE @L1000A_n102_plan_sponsor_nm VARCHAR(60)
    DECLARE @L1000A_n103_sponsor_id_qual CHAR(2)
    DECLARE @L1000A_n104_sponsor_id VARCHAR(80)
    DECLARE @L1000B_n101_entity_id_code CHAR(3)
    DECLARE @L1000B_n102_insurer_nm VARCHAR(60)
    DECLARE @L1000B_n103_insurer_id_qual CHAR(2)
    DECLARE @L1000B_n104_insurer_id VARCHAR(80)
    DECLARE @L1000C_n101_entity_id_code CHAR(3)
    DECLARE @L1000C_n102_tpa_broker_nm VARCHAR(60)
    DECLARE @L1000C_n103_tpa_broker_id_qual CHAR(2)
    DECLARE @L1000C_n104_tpa_broker_id VARCHAR(80)
    DECLARE @L1100C_act01_tpa_broker_accnt_num VARCHAR(35)
    DECLARE @L1100C_act06_tpa_broker_accnt_num VARCHAR(35)
    DECLARE @L2000_ins01_insured_indicator CHAR(1)
    DECLARE @L2000_ins02_ind_relationship_code CHAR(2)
    DECLARE @L2000_ins03_maint_type_code CHAR(3)
    DECLARE @L2000_ins04_maint_reason_code CHAR(3)
    DECLARE @L2000_ins05_benefit_status_code CHAR(1)
    DECLARE @L2000_ins06_medicare_plan_code CHAR(1)
    DECLARE @L2000_ins07_cobra_code CHAR(2)
    DECLARE @L2000_ins08_employment_status_code CHAR(2)
    DECLARE @L2000_ins09_student_status_code CHAR(1)
    DECLARE @L2000_ins10_handicap_indicator CHAR(1)
    DECLARE @L2000_ins12_insured_death_date VARCHAR(35)
    DECLARE @L2000_ins13_birth_seq_num VARCHAR(9)
    DECLARE @L2000_ref02_subscriber_id VARCHAR(30)
    DECLARE @L2000_ref02_insured_grp_policy_num VARCHAR(30)
    DECLARE @L2000_ref01_subscriber_sup_qual_id VARCHAR(30)
    DECLARE @L2000_ref02_subscriber_sup_id VARCHAR(30)
    DECLARE @L2000_ref02_3H_subscriber_sup_id VARCHAR(30)
    DECLARE @L2000_ref02_DX_subscriber_sup_id VARCHAR(30)
    DECLARE @L2000_ref02_17_subscriber_sup_id VARCHAR(30)
    DECLARE @L2000_ref02_23_subscriber_sup_id VARCHAR(30)
    DECLARE @L2000_ref02_F6_subscriber_sup_id VARCHAR(30)
    DECLARE @L2000_ref02_prior_cvg_month_count VARCHAR(30)
    DECLARE @L2000_dtp01_member_level_qual CHAR(3)
    DECLARE @L2000_dtp03_356_status_info_eff_date VARCHAR(35)
    DECLARE @L2000_dtp03_357_status_info_eff_date VARCHAR(35)
    DECLARE @L2100A_nm101_entity_id_code CHAR(3)
    DECLARE @L2100A_nm102_entity_type_qual CHAR(1)
    DECLARE @L2100A_nm103_subscriber_last_nm VARCHAR(35)
    DECLARE @L2100A_nm104_subscriber_first_nm VARCHAR(25)
    DECLARE @L2100A_nm105_subscriber_middle_nm VARCHAR(25)
    DECLARE @L2100A_nm106_subscriber_name_prefix VARCHAR(10)
    DECLARE @L2100A_nm107_subscriber_name_suffix VARCHAR(10)
    DECLARE @L2100A_nm108_subscriber_id_code_qual CHAR(2)
    DECLARE @L2100A_nm109_subscriber_id VARCHAR(80)
    DECLARE @L2100A_per101_member_comm_func_code CHAR(2)
    DECLARE @L2100A_per103_member_comm_num_qual CHAR(2)
    DECLARE @L2100A_per104_member_comm VARCHAR(80)
    DECLARE @L2100A_n301_subscriber_address1 VARCHAR(55)
    DECLARE @L2100A_n302_subscriber_address2 VARCHAR(55)
    DECLARE @L2100A_n401_subscriber_city VARCHAR(30)
    DECLARE @L2100A_n402_subscriber_state CHAR(2)
    DECLARE @L2100A_n403_subscriber_zip VARCHAR(15)
    DECLARE @L2100A_n404_subscriber_country VARCHAR(3)
    DECLARE @L2100A_n406_subscriber_location_code VARCHAR(30)
    DECLARE @L2100A_dmg02_member_dob VARCHAR(35)
    DECLARE @L2100A_dmg03_member_gender CHAR(1)
    DECLARE @L2100A_dmg04_member_marital_status CHAR(1)
    DECLARE @L2100A_dmg05_member_ethnicity CHAR(1)
    DECLARE @L2100A_dmg06_member_citizenship CHAR(2)
    DECLARE @L2100A_amt02_B9_contract_amt MONEY
    DECLARE @L2100A_amt02_C1_contract_amt MONEY
    DECLARE @L2100A_amt02_D2_contract_amt MONEY
    DECLARE @L2100A_amt02_P3_contract_amt MONEY
    DECLARE @L2100A_hlh01_health_related_code CHAR(1)
    DECLARE @L2100A_hlh02_member_height VARCHAR(8)
    DECLARE @L2100A_hlh03_member_weight VARCHAR(10)
    DECLARE @L2100A_lui01_language_code_qual CHAR(2)
    DECLARE @L2100A_lui02_language_code VARCHAR(80)
    DECLARE @L2100A_lui03_language_desc VARCHAR(80)
    DECLARE @L2100A_lui04_language_use_indicator CHAR(2)
    DECLARE @L2100G_nm101_entity_id_code CHAR(3)
    DECLARE @L2100G_nm102_entity_type_qual CHAR(1)
    DECLARE @L2100G_nm103_resp_party_last_nm VARCHAR(35)
    DECLARE @L2100G_nm104_resp_party_first_nm VARCHAR(25)
    DECLARE @L2100G_nm105_resp_party_middle_nm VARCHAR(25)
    DECLARE @L2100G_nm106_resp_party_name_prefix VARCHAR(10)
    DECLARE @L2100G_nm107_resp_party_name_suffix VARCHAR(10)
    DECLARE @L2100G_nm108_resp_party_id_code_qual CHAR(2)
    DECLARE @L2100G_nm109_resp_party_id VARCHAR(80)
    DECLARE @L2100G_per101_member_comm_func_code CHAR(2)
    DECLARE @L2100G_per103_member_comm_num_qual CHAR(2)
    DECLARE @L2100G_per104_member_comm VARCHAR(80)
    DECLARE @L2100G_n301_resp_party_address1 VARCHAR(55)
    DECLARE @L2100G_n302_resp_party_address2 VARCHAR(55)
    DECLARE @L2100G_n401_resp_party_city VARCHAR(30)
    DECLARE @L2100G_n402_resp_party_state CHAR(2)
    DECLARE @L2100G_n403_resp_party_zip VARCHAR(15)
    DECLARE @L2100G_n404_resp_party_country VARCHAR(3)
    DECLARE @L2300_hd01_maint_type_code CHAR(3)
    DECLARE @L2300_hd03_ins_line_code CHAR(3)
    DECLARE @L2300_hd04_plan_cvg_desc VARCHAR(50)
    DECLARE @L2300_hd05_cvg_level_code VARCHAR(3)
    DECLARE @L2300_dtp03_303_cvg_period VARCHAR(35)
    DECLARE @L2300_dtp03_348_cvg_period VARCHAR(35)
    DECLARE @L2300_dtp03_349_cvg_period VARCHAR(35)
    DECLARE @L2300_dtp03_543_cvg_period VARCHAR(35)
    DECLARE @L2300_amt02_B9_contract_amt MONEY
    DECLARE @L2300_amt02_C1_contract_amt MONEY
    DECLARE @L2300_amt02_D2_contract_amt MONEY
    DECLARE @L2300_amt02_P3_contract_amt MONEY
    DECLARE @L2300_ref02_17_insured_grp_policy_num VARCHAR(30)
    DECLARE @L2300_ref02_1l_insured_grp_policy_num VARCHAR(30)
    DECLARE @L2300_ref02_ZZ_insured_grp_policy_num VARCHAR(30)
    DECLARE @L2320_1_cob01_payer_resp_seq_code CHAR(1)
    DECLARE @L2320_1_cob02_insured_grp_policy_num VARCHAR(30)
    DECLARE @L2320_1_cob03_cob_code CHAR(1)
    DECLARE @L2320_2_cob01_payer_resp_seq_code CHAR(1)
    DECLARE @L2320_2_cob02_insured_grp_policy_num VARCHAR(30)
    DECLARE @L2320_2_cob03_cob_code CHAR(1)
    DECLARE @L2320_3_cob01_payer_resp_seq_code CHAR(1)
    DECLARE @L2320_3_cob02_insured_grp_policy_num VARCHAR(30)
    DECLARE @L2320_3_cob03_cob_code CHAR(1)
    DECLARE @L2320_4_cob01_payer_resp_seq_code CHAR(1)
    DECLARE @L2320_4_cob02_insured_grp_policy_num VARCHAR(30)
    DECLARE @L2320_4_cob03_cob_code CHAR(1)
    DECLARE @L2320_5_cob01_payer_resp_seq_code CHAR(1)
    DECLARE @L2320_5_cob02_insured_grp_policy_num VARCHAR(30)
    DECLARE @L2320_5_cob03_cob_code CHAR(1)

--Prev Variables
    DECLARE @prev_x12_834_benefit_enrollment_id INT
    DECLARE @prev_x12_transaction_id INT
    DECLARE @prev_bgn01_trans_set_purpose_code CHAR(2)
    DECLARE @prev_bgn02_trans_set_ident_code VARCHAR(30)
    DECLARE @prev_bgn03_trans_set_creation_date CHAR(8)
    DECLARE @prev_bgn04_trans_set_creation_time VARCHAR(8)
    DECLARE @prev_bgn05_time_zone_code CHAR(2)
    DECLARE @prev_bgn06_trans_set_ident_code VARCHAR(30)
    DECLARE @prev_bgn08_action_code CHAR(2)
    DECLARE @prev_ref01_reference_id_qual CHAR(3)
    DECLARE @prev_ref02_master_policy_number VARCHAR(30)
    DECLARE @prev_dtp01_date_time_qual CHAR(3)
    DECLARE @prev_dtp02_date_time_period_fmt_qual CHAR(3)
    DECLARE @prev_dtp03_date_time_period VARCHAR(35)
    DECLARE @prev_L1000A_n101_entity_id_code CHAR(3)
    DECLARE @prev_L1000A_n102_plan_sponsor_nm VARCHAR(60)
    DECLARE @prev_L1000A_n103_sponsor_id_qual CHAR(2)
    DECLARE @prev_L1000A_n104_sponsor_id VARCHAR(80)
    DECLARE @prev_L1000B_n101_entity_id_code CHAR(3)
    DECLARE @prev_L1000B_n102_insurer_nm VARCHAR(60)
    DECLARE @prev_L1000B_n103_insurer_id_qual CHAR(2)
    DECLARE @prev_L1000B_n104_insurer_id VARCHAR(80)
    DECLARE @prev_L1000C_n101_entity_id_code CHAR(3)
    DECLARE @prev_L1000C_n102_tpa_broker_nm VARCHAR(60)
    DECLARE @prev_L1000C_n103_tpa_broker_id_qual CHAR(2)
    DECLARE @prev_L1000C_n104_tpa_broker_id VARCHAR(80)
    DECLARE @prev_L1100C_act01_tpa_broker_accnt_num VARCHAR(35)
    DECLARE @prev_L1100C_act06_tpa_broker_accnt_num VARCHAR(35)
    DECLARE @prev_L2000_ins01_insured_indicator CHAR(1)
    DECLARE @prev_L2000_ins02_ind_relationship_code CHAR(2)
    DECLARE @prev_L2000_ins03_maint_type_code CHAR(3)
    DECLARE @prev_L2000_ins04_maint_reason_code CHAR(3)
    DECLARE @prev_L2000_ins05_benefit_status_code CHAR(1)
    DECLARE @prev_L2000_ins06_medicare_plan_code CHAR(1)
    DECLARE @prev_L2000_ins07_cobra_code CHAR(2)
    DECLARE @prev_L2000_ins08_employment_status_code CHAR(2)
    DECLARE @prev_L2000_ins09_student_status_code CHAR(1)
    DECLARE @prev_L2000_ins10_handicap_indicator CHAR(1)
    DECLARE @prev_L2000_ins12_insured_death_date VARCHAR(35)
    DECLARE @prev_L2000_ins13_birth_seq_num VARCHAR(9)
    DECLARE @prev_L2000_ref02_subscriber_id VARCHAR(30)
    DECLARE @prev_L2000_ref02_insured_grp_policy_num VARCHAR(30)
    DECLARE @prev_L2000_ref01_subscriber_sup_qual_id VARCHAR(30)
    DECLARE @prev_L2000_ref02_subscriber_sup_id VARCHAR(30)
    DECLARE @prev_L2000_ref02_3H_subscriber_sup_id VARCHAR(30)
    DECLARE @prev_L2000_ref02_DX_subscriber_sup_id VARCHAR(30)
    DECLARE @prev_L2000_ref02_17_subscriber_sup_id VARCHAR(30)
    DECLARE @prev_L2000_ref02_23_subscriber_sup_id VARCHAR(30)
    DECLARE @prev_L2000_ref02_F6_subscriber_sup_id VARCHAR(30)
    DECLARE @prev_L2000_ref02_prior_cvg_month_count VARCHAR(30)
    DECLARE @prev_L2000_dtp01_member_level_qual CHAR(3)
    DECLARE @prev_L2000_dtp03_356_status_info_eff_date VARCHAR(35)
    DECLARE @prev_L2000_dtp03_357_status_info_eff_date VARCHAR(35)
    DECLARE @prev_L2100A_nm101_entity_id_code CHAR(3)
    DECLARE @prev_L2100A_nm102_entity_type_qual CHAR(1)
    DECLARE @prev_L2100A_nm103_subscriber_last_nm VARCHAR(35)
    DECLARE @prev_L2100A_nm104_subscriber_first_nm VARCHAR(25)
    DECLARE @prev_L2100A_nm105_subscriber_middle_nm VARCHAR(25)
    DECLARE @prev_L2100A_nm106_subscriber_name_prefix VARCHAR(10)
    DECLARE @prev_L2100A_nm107_subscriber_name_suffix VARCHAR(10)
    DECLARE @prev_L2100A_nm108_subscriber_id_code_qual CHAR(2)
    DECLARE @prev_L2100A_nm109_subscriber_id VARCHAR(80)
    DECLARE @prev_L2100A_per101_member_comm_func_code CHAR(2)
    DECLARE @prev_L2100A_per103_member_comm_num_qual CHAR(2)
    DECLARE @prev_L2100A_per104_member_comm VARCHAR(80)
    DECLARE @prev_L2100A_n301_subscriber_address1 VARCHAR(55)
    DECLARE @prev_L2100A_n302_subscriber_address2 VARCHAR(55)
    DECLARE @prev_L2100A_n401_subscriber_city VARCHAR(30)
    DECLARE @prev_L2100A_n402_subscriber_state CHAR(2)
    DECLARE @prev_L2100A_n403_subscriber_zip VARCHAR(15)
    DECLARE @prev_L2100A_n404_subscriber_country VARCHAR(3)
    DECLARE @prev_L2100A_n406_subscriber_location_code VARCHAR(30)
    DECLARE @prev_L2100A_dmg02_member_dob VARCHAR(35)
    DECLARE @prev_L2100A_dmg03_member_gender CHAR(1)
    DECLARE @prev_L2100A_dmg04_member_marital_status CHAR(1)
    DECLARE @prev_L2100A_dmg05_member_ethnicity CHAR(1)
    DECLARE @prev_L2100A_dmg06_member_citizenship CHAR(2)
    DECLARE @prev_L2100A_amt02_B9_contract_amt MONEY
    DECLARE @prev_L2100A_amt02_C1_contract_amt MONEY
    DECLARE @prev_L2100A_amt02_D2_contract_amt MONEY
    DECLARE @prev_L2100A_amt02_P3_contract_amt MONEY
    DECLARE @prev_L2100A_hlh01_health_related_code CHAR(1)
    DECLARE @prev_L2100A_hlh02_member_height VARCHAR(8)
    DECLARE @prev_L2100A_hlh03_member_weight VARCHAR(10)
    DECLARE @prev_L2100A_lui01_language_code_qual CHAR(2)
    DECLARE @prev_L2100A_lui02_language_code VARCHAR(80)
    DECLARE @prev_L2100A_lui03_language_desc VARCHAR(80)
    DECLARE @prev_L2100A_lui04_language_use_indicator CHAR(2)
    DECLARE @prev_L2100G_nm101_entity_id_code CHAR(3)
    DECLARE @prev_L2100G_nm102_entity_type_qual CHAR(1)
    DECLARE @prev_L2100G_nm103_resp_party_last_nm VARCHAR(35)
    DECLARE @prev_L2100G_nm104_resp_party_first_nm VARCHAR(25)
    DECLARE @prev_L2100G_nm105_resp_party_middle_nm VARCHAR(25)
    DECLARE @prev_L2100G_nm106_resp_party_name_prefix VARCHAR(10)
    DECLARE @prev_L2100G_nm107_resp_party_name_suffix VARCHAR(10)
    DECLARE @prev_L2100G_nm108_resp_party_id_code_qual CHAR(2)
    DECLARE @prev_L2100G_nm109_resp_party_id VARCHAR(80)
    DECLARE @prev_L2100G_per101_member_comm_func_code CHAR(2)
    DECLARE @prev_L2100G_per103_member_comm_num_qual CHAR(2)
    DECLARE @prev_L2100G_per104_member_comm VARCHAR(80)
    DECLARE @prev_L2100G_n301_resp_party_address1 VARCHAR(55)
    DECLARE @prev_L2100G_n302_resp_party_address2 VARCHAR(55)
    DECLARE @prev_L2100G_n401_resp_party_city VARCHAR(30)
    DECLARE @prev_L2100G_n402_resp_party_state CHAR(2)
    DECLARE @prev_L2100G_n403_resp_party_zip VARCHAR(15)
    DECLARE @prev_L2100G_n404_resp_party_country VARCHAR(3)
    DECLARE @prev_L2300_hd01_maint_type_code CHAR(3)
    DECLARE @prev_L2300_hd03_ins_line_code CHAR(3)
    DECLARE @prev_L2300_hd04_plan_cvg_desc VARCHAR(50)
    DECLARE @prev_L2300_hd05_cvg_level_code VARCHAR(3)
    DECLARE @prev_L2300_dtp03_303_cvg_period VARCHAR(35)
    DECLARE @prev_L2300_dtp03_348_cvg_period VARCHAR(35)
    DECLARE @prev_L2300_dtp03_349_cvg_period VARCHAR(35)
    DECLARE @prev_L2300_dtp03_543_cvg_period VARCHAR(35)
    DECLARE @prev_L2300_amt02_B9_contract_amt MONEY
    DECLARE @prev_L2300_amt02_C1_contract_amt MONEY
    DECLARE @prev_L2300_amt02_D2_contract_amt MONEY
    DECLARE @prev_L2300_amt02_P3_contract_amt MONEY
    DECLARE @prev_L2300_ref02_17_insured_grp_policy_num VARCHAR(30)
    DECLARE @prev_L2300_ref02_1l_insured_grp_policy_num VARCHAR(30)
    DECLARE @prev_L2300_ref02_ZZ_insured_grp_policy_num VARCHAR(30)
    DECLARE @prev_L2320_1_cob01_payer_resp_seq_code CHAR(1)
    DECLARE @prev_L2320_1_cob02_insured_grp_policy_num VARCHAR(30)
    DECLARE @prev_L2320_1_cob03_cob_code CHAR(1)
    DECLARE @prev_L2320_2_cob01_payer_resp_seq_code CHAR(1)
    DECLARE @prev_L2320_2_cob02_insured_grp_policy_num VARCHAR(30)
    DECLARE @prev_L2320_2_cob03_cob_code CHAR(1)
    DECLARE @prev_L2320_3_cob01_payer_resp_seq_code CHAR(1)
    DECLARE @prev_L2320_3_cob02_insured_grp_policy_num VARCHAR(30)
    DECLARE @prev_L2320_3_cob03_cob_code CHAR(1)
    DECLARE @prev_L2320_4_cob01_payer_resp_seq_code CHAR(1)
    DECLARE @prev_L2320_4_cob02_insured_grp_policy_num VARCHAR(30)
    DECLARE @prev_L2320_4_cob03_cob_code CHAR(1)
    DECLARE @prev_L2320_5_cob01_payer_resp_seq_code CHAR(1)
    DECLARE @prev_L2320_5_cob02_insured_grp_policy_num VARCHAR(30)
    DECLARE @prev_L2320_5_cob03_cob_code CHAR(1)


--BEGIN: Initialize transaction variables here.\
    DECLARE @x12_interchange_uid UNIQUEIDENTIFIER

    SET @segment_count = 0

    DECLARE @pre_segment_count INT
    SET @pre_segment_count = 0

-- Set the x12_interchange_uid value of the 834 transaction that's being exported.
    SELECT  @x12_interchange_uid = x12_interchange_uid
    FROM    vw_x12_transaction
    WHERE   x12_transaction_id = @x12_transaction_id
-- END: Initialize transaction variables.


-- Count up all the segments before inserting this transaction (exclude the transaction header segments).
-- We do this beforehand because otherwise we wouldn't be able to count them accurately,
-- the x12_parse_temp table doesn't track records by transaction.
    SELECT  @pre_segment_count = COUNT(x12_parse_temp_id)
    FROM    x12_parse_temp
    WHERE   col001 NOT IN ( 'ISA', 'GS', 'ST', 'IEA', 'GE', 'SE' )
            AND x12_parse_temp_uid = @x12_interchange_uid


    DECLARE @errmsg VARCHAR(250)
    DECLARE @errcode INT
 --delcare the cursor

    DECLARE curtx12doc SCROLL CURSOR
        FOR SELECT  x12_834_benefit_enrollment_id,
                    x12_transaction_id,
                    bgn01_trans_set_purpose_code,
                    bgn02_trans_set_ident_code,
                    bgn03_trans_set_creation_date,
                    bgn04_trans_set_creation_time,
                    bgn05_time_zone_code,
                    bgn06_trans_set_ident_code,
                    bgn08_action_code,
                    ref01_reference_id_qual,
                    ref02_master_policy_number,
                    dtp01_date_time_qual,
                    dtp02_date_time_period_fmt_qual,
                    dtp03_date_time_period,
                    L1000A_n101_entity_id_code,
                    L1000A_n102_plan_sponsor_nm,
                    L1000A_n103_sponsor_id_qual,
                    L1000A_n104_sponsor_id,
                    L1000B_n101_entity_id_code,
                    L1000B_n102_insurer_nm,
                    L1000B_n103_insurer_id_qual,
                    L1000B_n104_insurer_id,
                    L1000C_n101_entity_id_code,
                    L1000C_n102_tpa_broker_nm,
                    L1000C_n103_tpa_broker_id_qual,
                    L1000C_n104_tpa_broker_id,
                    L1100C_act01_tpa_broker_accnt_num,
                    L1100C_act06_tpa_broker_accnt_num,
                    L2000_ins01_insured_indicator,
                    L2000_ins02_ind_relationship_code,
                    L2000_ins03_maint_type_code,
                    L2000_ins04_maint_reason_code,
                    L2000_ins05_benefit_status_code,
                    L2000_ins06_medicare_plan_code,
                    L2000_ins07_cobra_code,
                    L2000_ins08_employment_status_code,
                    L2000_ins09_student_status_code,
                    L2000_ins10_handicap_indicator,
                    L2000_ins12_insured_death_date,
                    L2000_ins13_birth_seq_num,
                    L2000_ref02_subscriber_id,
                    L2000_ref02_insured_grp_policy_num,
                    L2000_ref01_subscriber_sup_qual_id,
                    L2000_ref02_subscriber_sup_id,
                    L2000_ref02_3H_subscriber_sup_id,
                    L2000_ref02_DX_subscriber_sup_id,
                    L2000_ref02_17_subscriber_sup_id,
                    L2000_ref02_23_subscriber_sup_id,
                    L2000_ref02_F6_subscriber_sup_id,
                    L2000_ref02_prior_cvg_month_count,
                    L2000_dtp01_member_level_qual,
                    L2000_dtp03_356_status_info_eff_date,
                    L2000_dtp03_357_status_info_eff_date,
                    L2100A_nm101_entity_id_code,
                    L2100A_nm102_entity_type_qual,
                    L2100A_nm103_subscriber_last_nm,
                    L2100A_nm104_subscriber_first_nm,
                    L2100A_nm105_subscriber_middle_nm,
                    L2100A_nm106_subscriber_name_prefix,
                    L2100A_nm107_subscriber_name_suffix,
                    L2100A_nm108_subscriber_id_code_qual,
                    L2100A_nm109_subscriber_id,
                    L2100A_per101_member_comm_func_code,
                    L2100A_per103_member_comm_num_qual,
                    L2100A_per104_member_comm,
                    L2100A_n301_subscriber_address1,
                    L2100A_n302_subscriber_address2,
                    L2100A_n401_subscriber_city,
                    L2100A_n402_subscriber_state,
                    L2100A_n403_subscriber_zip,
                    L2100A_n404_subscriber_country,
                    L2100A_n406_subscriber_location_code,
                    L2100A_dmg02_member_dob,
                    L2100A_dmg03_member_gender,
                    L2100A_dmg04_member_marital_status,
                    L2100A_dmg05_member_ethnicity,
                    L2100A_dmg06_member_citizenship,
                    L2100A_amt02_B9_contract_amt,
                    L2100A_amt02_C1_contract_amt,
                    L2100A_amt02_D2_contract_amt,
                    L2100A_amt02_P3_contract_amt,
                    L2100A_hlh01_health_related_code,
                    L2100A_hlh02_member_height,
                    L2100A_hlh03_member_weight,
                    L2100A_lui01_language_code_qual,
                    L2100A_lui02_language_code,
                    L2100A_lui03_language_desc,
                    L2100A_lui04_language_use_indicator,
                    L2100G_nm101_entity_id_code,
                    L2100G_nm102_entity_type_qual,
                    L2100G_nm103_resp_party_last_nm,
                    L2100G_nm104_resp_party_first_nm,
                    L2100G_nm105_resp_party_middle_nm,
                    L2100G_nm106_resp_party_name_prefix,
                    L2100G_nm107_resp_party_name_suffix,
                    L2100G_nm108_resp_party_id_code_qual,
                    L2100G_nm109_resp_party_id,
                    L2100G_per101_member_comm_func_code,
                    L2100G_per103_member_comm_num_qual,
                    L2100G_per104_member_comm,
                    L2100G_n301_resp_party_address1,
                    L2100G_n302_resp_party_address2,
                    L2100G_n401_resp_party_city,
                    L2100G_n402_resp_party_state,
                    L2100G_n403_resp_party_zip,
                    L2100G_n404_resp_party_country,
                    L2300_hd01_maint_type_code,
                    L2300_hd03_ins_line_code,
                    L2300_hd04_plan_cvg_desc,
                    L2300_hd05_cvg_level_code,
                    L2300_dtp03_303_cvg_period,
                    L2300_dtp03_348_cvg_period,
                    L2300_dtp03_349_cvg_period,
                    L2300_dtp03_543_cvg_period,
                    L2300_amt02_B9_contract_amt,
                    L2300_amt02_C1_contract_amt,
                    L2300_amt02_D2_contract_amt,
                    L2300_amt02_P3_contract_amt,
                    L2300_ref02_17_insured_grp_policy_num,
                    L2300_ref02_1l_insured_grp_policy_num,
                    L2300_ref02_ZZ_insured_grp_policy_num,
                    L2320_1_cob01_payer_resp_seq_code,
                    L2320_1_cob02_insured_grp_policy_num,
                    L2320_1_cob03_cob_code,
                    L2320_2_cob01_payer_resp_seq_code,
                    L2320_2_cob02_insured_grp_policy_num,
                    L2320_2_cob03_cob_code,
                    L2320_3_cob01_payer_resp_seq_code,
                    L2320_3_cob02_insured_grp_policy_num,
                    L2320_3_cob03_cob_code,
                    L2320_4_cob01_payer_resp_seq_code,
                    L2320_4_cob02_insured_grp_policy_num,
                    L2320_4_cob03_cob_code,
                    L2320_5_cob01_payer_resp_seq_code,
                    L2320_5_cob02_insured_grp_policy_num,
                    L2320_5_cob03_cob_code
            FROM    x12_834_benefit_enrollment
            WHERE   x12_transaction_id = @x12_transaction_id
            ORDER BY x12_834_benefit_enrollment_id
    OPEN curtX12Doc
    FETCH NEXT FROM curtX12Doc INTO @x12_834_benefit_enrollment_id,
        @x12_transaction_id, @bgn01_trans_set_purpose_code,
        @bgn02_trans_set_ident_code, @bgn03_trans_set_creation_date,
        @bgn04_trans_set_creation_time, @bgn05_time_zone_code,
        @bgn06_trans_set_ident_code, @bgn08_action_code,
        @ref01_reference_id_qual, @ref02_master_policy_number,
        @dtp01_date_time_qual, @dtp02_date_time_period_fmt_qual,
        @dtp03_date_time_period, @L1000A_n101_entity_id_code,
        @L1000A_n102_plan_sponsor_nm, @L1000A_n103_sponsor_id_qual,
        @L1000A_n104_sponsor_id, @L1000B_n101_entity_id_code,
        @L1000B_n102_insurer_nm, @L1000B_n103_insurer_id_qual,
        @L1000B_n104_insurer_id, @L1000C_n101_entity_id_code,
        @L1000C_n102_tpa_broker_nm, @L1000C_n103_tpa_broker_id_qual,
        @L1000C_n104_tpa_broker_id, @L1100C_act01_tpa_broker_accnt_num,
        @L1100C_act06_tpa_broker_accnt_num, @L2000_ins01_insured_indicator,
        @L2000_ins02_ind_relationship_code, @L2000_ins03_maint_type_code,
        @L2000_ins04_maint_reason_code, @L2000_ins05_benefit_status_code,
        @L2000_ins06_medicare_plan_code, @L2000_ins07_cobra_code,
        @L2000_ins08_employment_status_code, @L2000_ins09_student_status_code,
        @L2000_ins10_handicap_indicator, @L2000_ins12_insured_death_date,
        @L2000_ins13_birth_seq_num, @L2000_ref02_subscriber_id,
        @L2000_ref02_insured_grp_policy_num,
        @L2000_ref01_subscriber_sup_qual_id, @L2000_ref02_subscriber_sup_id,
        @L2000_ref02_3H_subscriber_sup_id, @L2000_ref02_DX_subscriber_sup_id,
        @L2000_ref02_17_subscriber_sup_id, @L2000_ref02_23_subscriber_sup_id,
        @L2000_ref02_F6_subscriber_sup_id, @L2000_ref02_prior_cvg_month_count,
        @L2000_dtp01_member_level_qual, @L2000_dtp03_356_status_info_eff_date,
        @L2000_dtp03_357_status_info_eff_date, @L2100A_nm101_entity_id_code,
        @L2100A_nm102_entity_type_qual, @L2100A_nm103_subscriber_last_nm,
        @L2100A_nm104_subscriber_first_nm, @L2100A_nm105_subscriber_middle_nm,
        @L2100A_nm106_subscriber_name_prefix,
        @L2100A_nm107_subscriber_name_suffix,
        @L2100A_nm108_subscriber_id_code_qual, @L2100A_nm109_subscriber_id,
        @L2100A_per101_member_comm_func_code,
        @L2100A_per103_member_comm_num_qual, @L2100A_per104_member_comm,
        @L2100A_n301_subscriber_address1, @L2100A_n302_subscriber_address2,
        @L2100A_n401_subscriber_city, @L2100A_n402_subscriber_state,
        @L2100A_n403_subscriber_zip, @L2100A_n404_subscriber_country,
        @L2100A_n406_subscriber_location_code, @L2100A_dmg02_member_dob,
        @L2100A_dmg03_member_gender, @L2100A_dmg04_member_marital_status,
        @L2100A_dmg05_member_ethnicity, @L2100A_dmg06_member_citizenship,
        @L2100A_amt02_B9_contract_amt, @L2100A_amt02_C1_contract_amt,
        @L2100A_amt02_D2_contract_amt, @L2100A_amt02_P3_contract_amt,
        @L2100A_hlh01_health_related_code, @L2100A_hlh02_member_height,
        @L2100A_hlh03_member_weight, @L2100A_lui01_language_code_qual,
        @L2100A_lui02_language_code, @L2100A_lui03_language_desc,
        @L2100A_lui04_language_use_indicator, @L2100G_nm101_entity_id_code,
        @L2100G_nm102_entity_type_qual, @L2100G_nm103_resp_party_last_nm,
        @L2100G_nm104_resp_party_first_nm, @L2100G_nm105_resp_party_middle_nm,
        @L2100G_nm106_resp_party_name_prefix,
        @L2100G_nm107_resp_party_name_suffix,
        @L2100G_nm108_resp_party_id_code_qual, @L2100G_nm109_resp_party_id,
        @L2100G_per101_member_comm_func_code,
        @L2100G_per103_member_comm_num_qual, @L2100G_per104_member_comm,
        @L2100G_n301_resp_party_address1, @L2100G_n302_resp_party_address2,
        @L2100G_n401_resp_party_city, @L2100G_n402_resp_party_state,
        @L2100G_n403_resp_party_zip, @L2100G_n404_resp_party_country,
        @L2300_hd01_maint_type_code, @L2300_hd03_ins_line_code,
        @L2300_hd04_plan_cvg_desc, @L2300_hd05_cvg_level_code,
        @L2300_dtp03_303_cvg_period, @L2300_dtp03_348_cvg_period,
        @L2300_dtp03_349_cvg_period, @L2300_dtp03_543_cvg_period,
        @L2300_amt02_B9_contract_amt, @L2300_amt02_C1_contract_amt,
        @L2300_amt02_D2_contract_amt, @L2300_amt02_P3_contract_amt,
        @L2300_ref02_17_insured_grp_policy_num,
        @L2300_ref02_1l_insured_grp_policy_num,
        @L2300_ref02_ZZ_insured_grp_policy_num,
        @L2320_1_cob01_payer_resp_seq_code,
        @L2320_1_cob02_insured_grp_policy_num, @L2320_1_cob03_cob_code,
        @L2320_2_cob01_payer_resp_seq_code,
        @L2320_2_cob02_insured_grp_policy_num, @L2320_2_cob03_cob_code,
        @L2320_3_cob01_payer_resp_seq_code,
        @L2320_3_cob02_insured_grp_policy_num, @L2320_3_cob03_cob_code,
        @L2320_4_cob01_payer_resp_seq_code,
        @L2320_4_cob02_insured_grp_policy_num, @L2320_4_cob03_cob_code,
        @L2320_5_cob01_payer_resp_seq_code,
        @L2320_5_cob02_insured_grp_policy_num, @L2320_5_cob03_cob_code


    WHILE ( @@fetch_status <> -1 )
        BEGIN
			--Insert the BGN Segment if new or does not exists yet
            IF ( @segment_count = 0 ) 
                BEGIN   
                    set @bgn07 = null                                       
							--Insert the BGN Segment
                    SET @bgn02_trans_set_ident_code = ISNULL(@bgn02_trans_set_ident_code,
                                                             @x12_transaction_id)
                    SET @bgn04_trans_set_creation_time = ISNULL(@bgn04_trans_set_creation_time, ( replace(convert(varchar(6), getdate(), 108), ':', '') ))

                    EXEC up_x12_bgn_export @x12_interchange_uid = @x12_interchange_uid,
                        @bgn01_trans_set_purpose_code = @bgn01_trans_set_purpose_code,
                        @bgn02_trans_set_ident_code = @bgn02_trans_set_ident_code,
                        @bgn03_trans_set_creation_date = @bgn03_trans_set_creation_date,
                        @bgn04_trans_set_creation_time = @bgn04_trans_set_creation_time,
                        @bgn05_time_zone_code = @bgn05_time_zone_code,
                        @bgn06_trans_set_ident_code = @bgn06_trans_set_ident_code,
                        @bgn07 = @bgn07,
                        @bgn08_action_code = @bgn08_action_code                
                END
        
			-- Insert the REF segment if new or does not exists
            IF ( @segment_count = 0 ) 
                BEGIN
                    SET @ref02_master_policy_number = ISNULL(@ref02_master_policy_number,
                                                             @x12_transaction_id)
							--Insert REF Segment
                    EXEC up_x12_ref_export @x12_interchange_uid = @x12_interchange_uid,
                        @ref01_id_qual = '38',
                        @ref02_reference_number = @ref02_master_policy_number
                END         
			
			--Insert the DTP Segment if new or does not exists yet
			/**** THERE CAN BE MULTIPLE DTP Entries need to review to make sure this is captured if sent****/
            IF ( @segment_count = 0 ) 
                BEGIN
                    IF @dtp01_date_time_qual IS NOT NULL 
                        BEGIN
                            SET @dtp03_date_time_period = ISNULL(@dtp03_date_time_period, CONVERT(VARCHAR(8), GETDATE(), 112))
						--Insert DTP Segment
                            EXEC up_x12_dtp_export @x12_interchange_uid = @x12_interchange_uid,
                                @dtp01_date_time_qual = @dtp01_date_time_qual,
                                @dtp02_date_time_format_qual = 'D8',
                                @dtp03_begin_date = @dtp03_date_time_period
                        END
                END             

			/*****BEGIN 1000A SPONSOR NAME LOOP******/
			-- N1
            IF ( @segment_count = 0 ) 
                BEGIN
                    SET @L1000A_n101_entity_id_code = ISNULL(@L1000A_n101_entity_id_code,
                                                             'P5')
                    SET @L1000A_n102_plan_sponsor_nm = ISNULL(@L1000A_n102_plan_sponsor_nm, 'PH Tech')
                    SET @L1000A_n103_sponsor_id_qual = ISNULL(@L1000A_n103_sponsor_id_qual, 'FI')	 
                    SET @L1000A_n104_sponsor_id = ISNULL(@L1000A_n104_sponsor_id,
                                                         '931211733')
				--insert the requried segments for the loop
				--Insert N1 Sponsor Name
                    EXEC up_x12_n1_export @x12_interchange_uid = @x12_interchange_uid,
                        @n101_id_code = @L1000A_n101_entity_id_code,
                        @n102_name = @L1000A_n102_plan_sponsor_nm,
                        @n103_id_qual = @L1000A_n103_sponsor_id_qual,
                        @n104_id = @L1000A_n104_sponsor_id
                END
              
			/*****END 1000A SPONSOR NAME LOOP******/

			/*****BEGIN 1000B PAYER LOOP******/
            IF ( @segment_count = 0 ) 
                BEGIN  
                    SET @L1000B_n101_entity_id_code = ISNULL(@L1000B_n101_entity_id_code,
                                                             'IN')
                    SET @L1000B_n102_insurer_nm = ISNULL(@L1000B_n102_insurer_nm,
                                                         'TBD')
                    SET @L1000B_n103_insurer_id_qual = ISNULL(@L1000B_n103_insurer_id_qual, 'FI')
                    SET @L1000B_n104_insurer_id = ISNULL(@L1000B_n104_insurer_id,
                                                         '999999') 
				                 					
				--insert the requried segments for the loop
				--Insert N1 Payer
                    EXEC up_x12_n1_export @x12_interchange_uid = @x12_interchange_uid,
                        @n101_id_code = @L1000B_n101_entity_id_code,
                        @n102_name = @L1000B_n102_insurer_nm,
                        @n103_id_qual = @L1000B_n103_insurer_id_qual,
                        @n104_id = @L1000B_n104_insurer_id
                END
              
			/*****END 1000B Payer LOOP******/

			/*****BEGIN 1000C TPA/BROKER LOOP******/
            IF ( ISNULL(@L1000C_n101_entity_id_code, '') <> ISNULL(@prev_L1000C_n101_entity_id_code, '')
                 OR ISNULL(@L1000C_n102_tpa_broker_nm, '') <> ISNULL(@prev_L1000C_n102_tpa_broker_nm, '')
                 OR ISNULL(@L1000C_n103_tpa_broker_id_qual, '') <> ISNULL(@prev_L1000C_n103_tpa_broker_id_qual, '')
                 OR ISNULL(@L1000C_n104_tpa_broker_id, '') <> ISNULL(@prev_L1000C_n104_tpa_broker_id, '')
                 OR ISNULL(@L1100C_act01_tpa_broker_accnt_num, '') <> ISNULL(@prev_L1100C_act01_tpa_broker_accnt_num, '')
                 OR ISNULL(@L1100C_act06_tpa_broker_accnt_num, '') <> ISNULL(@prev_L1100C_act06_tpa_broker_accnt_num, '')
                 OR @L1000C_n101_entity_id_code IS NULL
               ) 
                BEGIN
                    IF @L1000C_n101_entity_id_code IS NOT NULL 
                        BEGIN
					--insert the requried segments for the loop
						--Insert N1 Payer
                            EXEC up_x12_n1_export @x12_interchange_uid = @x12_interchange_uid,
                                @n101_id_code = @L1000C_n101_entity_id_code,
                                @n102_name = @L1000C_n102_tpa_broker_nm,
                                @n103_id_qual = @L1000C_n103_tpa_broker_id_qual,
                                @n104_id = @L1000C_n104_tpa_broker_id

                            IF @L1100C_act01_tpa_broker_accnt_num IS NOT NULL 
                                BEGIN
						--Insert ACT  
                                    EXEC up_x12_act_export @x12_interchange_uid = @x12_interchange_uid,
                                        @act01_tpa_broker_accnt_num = @L1100C_act01_tpa_broker_accnt_num,
                                        @act06_tpa_broker_accnt_num = @L1100C_act06_tpa_broker_accnt_num	
                                END
                        END
                END
			/*****END 1000C TPA/BROKER LOOP******/

			/*****BEGIN 2000 MEMBER LEVEL DETAIL LOOP******/
			
			--INS Segment

            IF @L2000_ins01_insured_indicator IS NOT NULL 
                BEGIN
                    EXEC up_x12_ins_export @x12_interchange_uid = @x12_interchange_uid,
                        @ins01_insured_indicator = @L2000_ins01_insured_indicator,
                        @ins02_ind_relationship_code = @L2000_ins02_ind_relationship_code,
                        @ins03_maint_type_code = @L2000_ins03_maint_type_code,
                        @ins04_maint_reason_code = @L2000_ins04_maint_reason_code,
                        @ins05_benefit_status_code = @L2000_ins05_benefit_status_code,
                        @ins06_medicare_plan_code = @L2000_ins06_medicare_plan_code,
                        @ins07_cobra_code = @L2000_ins07_cobra_code,
                        @ins08_employment_status_code = @L2000_ins08_employment_status_code,
                        @ins09_student_status_code = @L2000_ins09_student_status_code,
                        @ins10_handicap_indicator = @L2000_ins10_handicap_indicator,
                        @ins12_insured_death_date = @L2000_ins12_insured_death_date,
                        @ins13_birth_seq_num = @L2000_ins13_birth_seq_num
                END  

			--REF Segment Subscriber Number
            IF ( ISNULL(@L2000_ref02_subscriber_id, '') <> ISNULL(@prev_L2000_ref02_subscriber_id, '')
                 OR @L2000_ref02_subscriber_id IS NULL
               ) 
                BEGIN
                    IF @L2000_ref02_subscriber_id IS NOT NULL 
                        BEGIN	
					--Insert REF Segment
                            EXEC up_x12_ref_export @x12_interchange_uid = @x12_interchange_uid,
                                @ref01_id_qual = '0F',
                                @ref02_reference_number = @L2000_ref02_subscriber_id
                        END
                END

			--REF Segment Member Policy Number          
                
            IF @L2000_ref02_insured_grp_policy_num IS NOT NULL 
                BEGIN	
					--Insert REF Segment
                    EXEC up_x12_ref_export @x12_interchange_uid = @x12_interchange_uid,
                        @ref01_id_qual = '1L',
                        @ref02_reference_number = @L2000_ref02_insured_grp_policy_num
                END
                
			--REF Segment Member Identification Number          
            IF @L2000_ref01_subscriber_sup_qual_id IS NOT NULL 
                BEGIN	
					--Insert REF Segment
                    EXEC up_x12_ref_export @x12_interchange_uid = @x12_interchange_uid,
                        @ref01_id_qual = @L2000_ref01_subscriber_sup_qual_id,
                        @ref02_reference_number = @L2000_ref02_subscriber_sup_id
                END
                			
			--REF Segment Member Identification Number 17             
            IF @L2000_ref02_17_subscriber_sup_id IS NOT NULL 
                BEGIN	
					--Insert REF Segment
                    EXEC up_x12_ref_export @x12_interchange_uid = @x12_interchange_uid,
                        @ref01_id_qual = '17',
                        @ref02_reference_number = @L2000_ref02_17_subscriber_sup_id
                END
             
			--REF Segment Member Identification Number 23
           
            IF @L2000_ref02_23_subscriber_sup_id IS NOT NULL 
                BEGIN	
					--Insert REF Segment
                    EXEC up_x12_ref_export @x12_interchange_uid = @x12_interchange_uid,
                        @ref01_id_qual = '23',
                        @ref02_reference_number = @L2000_ref02_23_subscriber_sup_id
                END
             
			--REF Segment Member Identification Number 3H
            IF @L2000_ref02_3H_subscriber_sup_id IS NOT NULL 
                BEGIN	
					--Insert REF Segment
                    EXEC up_x12_ref_export @x12_interchange_uid = @x12_interchange_uid,
                        @ref01_id_qual = '3H',
                        @ref02_reference_number = @L2000_ref02_3H_subscriber_sup_id
                END            

				--REF Segment Member Identification Number DX
            IF @L2000_ref02_DX_subscriber_sup_id IS NOT NULL 
                BEGIN	
					--Insert REF Segment
                    EXEC up_x12_ref_export @x12_interchange_uid = @x12_interchange_uid,
                        @ref01_id_qual = 'DX',
                        @ref02_reference_number = @L2000_ref02_DX_subscriber_sup_id
                END
            
				--REF Segment Member Identification Number F6
            IF @L2000_ref02_F6_subscriber_sup_id IS NOT NULL 
                BEGIN	
					--Insert REF Segment
                    EXEC up_x12_ref_export @x12_interchange_uid = @x12_interchange_uid,
                        @ref01_id_qual = 'F6',
                        @ref02_reference_number = @L2000_ref02_F6_subscriber_sup_id
                END
            

				--REF Segment Prior Coverage
            IF @L2000_ref02_prior_cvg_month_count IS NOT NULL 
                BEGIN	
					--Insert REF Segment
                    EXEC up_x12_ref_export @x12_interchange_uid = @x12_interchange_uid,
                        @ref01_id_qual = 'QQ',
                        @ref02_reference_number = @L2000_ref02_prior_cvg_month_count
                END
            
				--DTP Member Level Dates          
            IF @L2000_dtp03_356_status_info_eff_date IS NOT NULL 
                BEGIN
					--Insert DTP Segment
                    EXEC up_x12_dtp_export @x12_interchange_uid = @x12_interchange_uid,
                        @dtp01_date_time_qual = '356',
                        @dtp02_date_time_format_qual = 'D8',
                        @dtp03_begin_date = @L2000_dtp03_356_status_info_eff_date
                END

               
				--DTP Member Level Dates			
            IF @L2000_dtp03_357_status_info_eff_date IS NOT NULL 
                BEGIN
						--Insert DTP Segment
                    EXEC up_x12_dtp_export @x12_interchange_uid = @x12_interchange_uid,
                        @dtp01_date_time_qual = '357',
                        @dtp02_date_time_format_qual = 'D8',
                        @dtp03_begin_date = @L2000_dtp03_357_status_info_eff_date
                END

						



						/*****BEGIN 2100A Member Name LOOP******/	
						
							--NM1 Member Name
            IF ( ISNULL(@L2100A_nm101_entity_id_code, '') <> ISNULL(@prev_L2100A_nm101_entity_id_code, '')
                 OR ISNULL(@L2100A_nm102_entity_type_qual, '') <> ISNULL(@prev_L2100A_nm102_entity_type_qual, '')
                 OR ISNULL(@L2100A_nm103_subscriber_last_nm, '') <> ISNULL(@prev_L2100A_nm103_subscriber_last_nm, '')
                 OR ISNULL(@L2100A_nm104_subscriber_first_nm, '') <> ISNULL(@prev_L2100A_nm104_subscriber_first_nm, '')
                 OR ISNULL(@L2100A_nm105_subscriber_middle_nm, '') <> ISNULL(@prev_L2100A_nm105_subscriber_middle_nm, '')
                 OR ISNULL(@L2100A_nm106_subscriber_name_prefix, '') <> ISNULL(@prev_L2100A_nm106_subscriber_name_prefix, '')
                 OR ISNULL(@L2100A_nm107_subscriber_name_suffix, '') <> ISNULL(@prev_L2100A_nm107_subscriber_name_suffix, '')
                 OR ISNULL(@L2100A_nm108_subscriber_id_code_qual, '') <> ISNULL(@prev_L2100A_nm108_subscriber_id_code_qual, '')
                 OR ISNULL(@L2100A_nm109_subscriber_id, '') <> ISNULL(@prev_L2100A_nm109_subscriber_id, '')
                 OR @L2100A_nm103_subscriber_last_nm IS NULL
               ) 
                BEGIN
                    IF @L2100A_nm103_subscriber_last_nm IS NOT NULL 
                        BEGIN
                            SET @L2100A_nm101_entity_id_code = ISNULL(@L2100A_nm101_entity_id_code, 'IL')
						--Insert NM1 Segment
                            EXEC up_x12_nm1_export @x12_interchange_uid = @x12_interchange_uid,
                                @nm101_entity_id_code = @L2100A_nm101_entity_id_code,
                                @nm102_entity_type_qual = '1',
                                @nm103_last_name = @L2100A_nm103_subscriber_last_nm,
                                @nm104_first_name = @L2100A_nm104_subscriber_first_nm,
                                @nm105_middle_name = @L2100A_nm105_subscriber_middle_nm,
                                @nm106_name_prefix = @L2100A_nm106_subscriber_name_prefix,
                                @nm107_name_suffix = @L2100A_nm107_subscriber_name_suffix,
                                @nm108_id_code_qual = @L2100A_nm108_subscriber_id_code_qual,
                                @nm109_id_code = @L2100A_nm109_subscriber_id
                        END
                END


							--PER Member Communciations Numbers
            IF ( ISNULL(@L2100A_per101_member_comm_func_code, '') <> ISNULL(@prev_L2100A_per101_member_comm_func_code, '')
                 OR ISNULL(@L2100A_per103_member_comm_num_qual, '') <> ISNULL(@prev_L2100A_per103_member_comm_num_qual, '')
                 OR ISNULL(@L2100A_per104_member_comm, '') <> ISNULL(@prev_L2100A_per104_member_comm, '')
                 OR @L2100A_per101_member_comm_func_code IS NULL
               ) 
                BEGIN
                    IF @L2100A_per104_member_comm IS NOT NULL 
                        BEGIN
												--insert PER segment
                            EXEC up_x12_per_export @x12_interchange_uid = @x12_interchange_uid,
                                @perf01_contact_function_code = 'IP',
                                @perf03_contact_number_qual = @L2100A_per103_member_comm_num_qual,
                                @perf04_contact_number = @L2100A_per104_member_comm
                        END
                END
																		

							--N3 Member Residence Street Address
            IF @L2100A_n301_subscriber_address1 IS NOT NULL 
                BEGIN
																				--insert N3 Segment
                    EXEC up_x12_n3_export @x12_interchange_uid = @x12_interchange_uid,
                        @n301_address1 = @L2100A_n301_subscriber_address1,
                        @n302_address2 = @L2100A_n302_subscriber_address2
                END							

			--N4 Member Residence City State Zip						
            IF @L2100A_n401_subscriber_city IS NOT NULL 
                BEGIN
					--insert N4 Segment
                    EXEC up_x12_n4_export @x12_interchange_uid = @x12_interchange_uid,
                        @n401_city = @L2100A_n401_subscriber_city,
                        @n402_state = @L2100A_n402_subscriber_state,
                        @n403_zip = @L2100A_n403_subscriber_zip,
                        @n404_country = @L2100A_n404_subscriber_country,
                        @n405_location_qual = 'CY',
                        @n406_location_id_code = @L2100A_n406_subscriber_location_code
                END					


							--DMG Member Demographics
     
              
            IF @L2100A_dmg02_member_dob IS NOT NULL 
                BEGIN
															--insert dmg segment
                    EXEC up_x12_dmg_export @x12_interchange_uid = @x12_interchange_uid,
                        @dmg01_date_time_format_qual = 'D8',
                        @dmg02_dob = @L2100A_dmg02_member_dob,
                        @dmg03_gender = @L2100A_dmg03_member_gender,
                        @dmg04_member_marital_status = @L2100A_dmg04_member_marital_status,
                        @dmg05_member_ethnicity = @L2100A_dmg05_member_ethnicity,
                        @dmg06_member_citizenship = @L2100A_dmg06_member_citizenship
                END
               

							--ICM MEmber Income
							--Not captured Therefore not doing

							--AMT Member Policy Amounts
							--B9
            IF @L2100A_amt02_B9_contract_amt IS NOT NULL 
                BEGIN
										--insert AMT  B9 segment
                    EXEC up_x12_amt_export @x12_interchange_uid = @x12_interchange_uid,
                        @amt01_amount_qual_code = 'B9',
                        @amt02_amount = @L2100A_amt02_B9_contract_amt
                END

							--C1
            IF @L2100A_amt02_C1_contract_amt IS NOT NULL 
                BEGIN
											--insert AMT  C1 segment
                    EXEC up_x12_amt_export @x12_interchange_uid = @x12_interchange_uid,
                        @amt01_amount_qual_code = 'C1',
                        @amt02_amount = @L2100A_amt02_C1_contract_amt
                END

							--D2
            IF @L2100A_amt02_D2_contract_amt IS NOT NULL 
                BEGIN
										--insert AMT  D2 segment
                    EXEC up_x12_amt_export @x12_interchange_uid = @x12_interchange_uid,
                        @amt01_amount_qual_code = 'D2',
                        @amt02_amount = @L2100A_amt02_D2_contract_amt
                END

							--P3
            IF @L2100A_amt02_P3_contract_amt IS NOT NULL 
                BEGIN
											--insert AMT  P3 segment
                    EXEC up_x12_amt_export @x12_interchange_uid = @x12_interchange_uid,
                        @amt01_amount_qual_code = 'P3',
                        @amt02_amount = @L2100A_amt02_P3_contract_amt
                END

							--HLH Member Helath Information							
            IF ( ISNULL(@L2100A_hlh01_health_related_code, '') <> ISNULL(@prev_L2100A_hlh01_health_related_code, '')
                 OR ISNULL(@L2100A_hlh02_member_height, '') <> ISNULL(@prev_L2100A_hlh02_member_height, '')
                 OR ISNULL(@L2100A_hlh03_member_weight, '') <> ISNULL(@prev_L2100A_hlh03_member_weight, '')
                 OR @L2100A_hlh01_health_related_code IS NULL
               ) 
                BEGIN
                    IF @L2100A_hlh01_health_related_code IS NOT NULL 
                        BEGIN
							
											--insert HLH Segment											
                            EXEC up_x12_hlh_export @x12_interchange_uid = @x12_interchange_uid,
                                @hlh01_health_related_code = @L2100A_hlh01_health_related_code,
                                @hlh02_member_height = @L2100A_hlh02_member_height,
                                @hlh03_member_weight = @L2100A_hlh03_member_weight
                        END
                END
												

							--LUI Member Language							
            IF @L2100A_lui01_language_code_qual IS NOT NULL 
                BEGIN
											--insert LUI Segment
											--*** THIS HAS NOT BEEN CREATED YET*** NEED TO CHECK PARAMETER FEED
                    EXEC up_x12_lui_export @x12_interchange_uid = @x12_interchange_uid,
                        @lui01_language_code_qual = @L2100A_lui01_language_code_qual,
                        @lui02_language_code = @L2100A_lui02_language_code,
                        @lui03_language_desc = @L2100A_lui03_language_desc,
                        @lui04_language_use_indicator = @L2100A_lui04_language_use_indicator
                END
							
						/*****END 2100A Member Name LOOP******/	

						/*****BEGIN 2100BIncorrect Member Name LOOP******/	
								--DO NOT CAPTURE
						/*****END 2100BIncorrect Member Name LOOP******/
	
						/*****BEGIN 2100C Member Mailing Address LOOP******/	
								--DO NOT CAPTURE
						/*****END 2100C Member Mailing Address LOOP******/	
						
						/*****BEGIN 2100D Member Employer LOOP******/	
								--DO NOT CAPTURE
						/*****END 2100D  Member Employer LOOP******/	

						/*****BEGIN 2100E Member School LOOP******/	
								--DO NOT CAPTURE
						/*****END 2100E Member School LOOP******/	

						/*****BEGIN 2100F Custoidal ParentLOOP******/	
								--DO NOT CAPTURE
						/*****END 2100F Custoidal Parent LOOP******/	

						/*****BEGIN 2100G Responsible Person LOOP******/	
							--NM1REsponsible Party Name
            IF ( ISNULL(@L2100G_nm101_entity_id_code, '') <> ISNULL(@prev_L2100G_nm101_entity_id_code, '')
                 OR ISNULL(@L2100G_nm102_entity_type_qual, '') <> ISNULL(@prev_L2100G_nm102_entity_type_qual, '')
                 OR ISNULL(@L2100G_nm103_resp_party_last_nm, '') <> ISNULL(@prev_L2100G_nm103_resp_party_last_nm, '')
                 OR ISNULL(@L2100G_nm104_resp_party_first_nm, '') <> ISNULL(@prev_L2100G_nm104_resp_party_first_nm, '')
                 OR ISNULL(@L2100G_nm105_resp_party_middle_nm, '') <> ISNULL(@prev_L2100G_nm105_resp_party_middle_nm, '')
                 OR ISNULL(@L2100G_nm106_resp_party_name_prefix, '') <> ISNULL(@prev_L2100G_nm106_resp_party_name_prefix, '')
                 OR ISNULL(@L2100G_nm107_resp_party_name_suffix, '') <> ISNULL(@prev_L2100G_nm107_resp_party_name_suffix, '')
                 OR ISNULL(@L2100G_nm108_resp_party_id_code_qual, '') <> ISNULL(@prev_L2100G_nm108_resp_party_id_code_qual, '')
                 OR ISNULL(@L2100G_nm109_resp_party_id, '') <> ISNULL(@prev_L2100G_nm109_resp_party_id, '')
                 OR @L2100G_nm101_entity_id_code IS NULL
               ) 
                BEGIN
                    IF @L2100G_nm103_resp_party_last_nm IS NOT NULL 
                        BEGIN
                            SET @L2100G_nm101_entity_id_code = ISNULL(@L2100G_nm101_entity_id_code, 'QD')
							--Insert NM1 Segment
                            EXEC up_x12_nm1_export @x12_interchange_uid = @x12_interchange_uid,
                                @nm101_entity_id_code = @L2100G_nm101_entity_id_code,
                                @nm102_entity_type_qual = @L2100G_nm102_entity_type_qual,
                                @nm103_last_name = @L2100G_nm103_resp_party_last_nm,
                                @nm104_first_name = @L2100G_nm104_resp_party_first_nm,
                                @nm105_middle_name = @L2100G_nm105_resp_party_middle_nm,
                                @nm106_name_prefix = @L2100G_nm106_resp_party_name_prefix,
                                @nm107_name_suffix = @L2100G_nm107_resp_party_name_suffix,
                                @nm108_id_code_qual = @L2100G_nm108_resp_party_id_code_qual,
                                @nm109_id_code = @L2100G_nm109_resp_party_id
                        
                        

			--PER Responsible Party communication
                            IF ( ISNULL(@L2100G_per101_member_comm_func_code,
                                        '') <> ISNULL(@prev_L2100G_per101_member_comm_func_code,
                                                      '')
                                 OR ISNULL(@L2100G_per103_member_comm_num_qual,
                                           '') <> ISNULL(@prev_L2100G_per103_member_comm_num_qual,
                                                         '')
                                 OR ISNULL(@L2100G_per104_member_comm, '') <> ISNULL(@prev_L2100G_per104_member_comm, '')
                                 OR @L2100G_per101_member_comm_func_code IS NULL
                               ) 
                                BEGIN
                                    IF @L2100G_per104_member_comm IS NOT NULL 
                                        BEGIN
							--insert PER segment
                                            EXEC up_x12_per_export @x12_interchange_uid = @x12_interchange_uid,
                                                @perf01_contact_function_code = @L2100G_per101_member_comm_func_code,
                                                @perf03_contact_number_qual = @L2100G_per103_member_comm_num_qual,
                                                @perf04_contact_number = @L2100G_per104_member_comm
                                        END
                                END
					
			--N3 Responsible Party Street Address
                            IF ( ISNULL(@L2100G_n301_resp_party_address1, '') <> ISNULL(@prev_L2100G_n301_resp_party_address1, '')
                                 OR ISNULL(@L2100G_n302_resp_party_address2,
                                           '') <> ISNULL(@prev_L2100G_n302_resp_party_address2,
                                                         '')
                                 OR @L2100G_n301_resp_party_address1 IS NULL
                               ) 
                                BEGIN
                                    IF @L2100G_n301_resp_party_address1 IS NOT NULL 
                                        BEGIN
												-- insert N3 segment
                                            EXEC up_x12_n3_export @x12_interchange_uid = @x12_interchange_uid,
                                                @n301_address1 = @L2100G_n301_resp_party_address1,
                                                @n302_address2 = @L2100G_n302_resp_party_address2
                                        END
                                END

					--N4 Responsible Party City State         
                            IF @L2100G_n401_resp_party_city IS NOT NULL 
                                BEGIN
											--Inser N4
                                    EXEC up_x12_n4_export @x12_interchange_uid = @x12_interchange_uid,
                                        @n401_city = @L2100G_n401_resp_party_city,
                                        @n402_state = @L2100G_n402_resp_party_state,
                                        @n403_zip = @L2100G_n403_resp_party_zip,
                                        @n404_country = @L2100G_n404_resp_party_country
                                END
                        END
                END
						/*****END 2100G Responsible Person LOOP******/	


							/*****BEGIN 2200 Disability Information LOOP******/	
										--Not Captured--
							/*****END 2200 Disability Information LOOP******/	


						/*****BEGIN 2300 HEALTH COVERAGE LOOP******/	
					--HD Health Coverage           
            IF @L2300_hd01_maint_type_code IS NOT NULL 
                BEGIN
									--insert HD segment*******THIS DOESN"T EXISTS NEED TO CHECK PARAMETER FEED
                    EXEC up_x12_hd_export @x12_interchange_uid = @x12_interchange_uid,
                        @hd01_maint_type_code = @L2300_hd01_maint_type_code,
                        @hd03_ins_line_code = @L2300_hd03_ins_line_code,
                        @hd04_plan_cvg_desc = @L2300_hd04_plan_cvg_desc,
                        @hd05_cvg_level_code = @L2300_hd05_cvg_level_code								
                END             
					--DTP Segments
					--DTP Health Coverage Dates 303
           
            IF @L2300_dtp03_303_cvg_period IS NOT NULL 
                BEGIN
									--insert DTP 303 segment
                    EXEC up_x12_dtp_export @x12_interchange_uid = @x12_interchange_uid,
                        @dtp01_date_time_qual = '303',
                        @dtp02_date_time_format_qual = 'D8',
                        @dtp03_begin_date = @L2300_dtp03_303_cvg_period

                END
           

					--DTP Health Coverage Dates 348
          
            IF @L2300_dtp03_348_cvg_period IS NOT NULL 
                BEGIN
									--insert DTP 348 segment
                    EXEC up_x12_dtp_export @x12_interchange_uid = @x12_interchange_uid,
                        @dtp01_date_time_qual = '348',
                        @dtp02_date_time_format_qual = 'D8',
                        @dtp03_begin_date = @L2300_dtp03_348_cvg_period
                END
            

					--DTP Health Coverage Dates 349
          
            IF @L2300_dtp03_349_cvg_period IS NOT NULL 
                BEGIN
									--insert DTP 349 segment
                    EXEC up_x12_dtp_export @x12_interchange_uid = @x12_interchange_uid,
                        @dtp01_date_time_qual = '349',
                        @dtp02_date_time_format_qual = 'D8',
                        @dtp03_begin_date = @L2300_dtp03_349_cvg_period
                END
             


					--DTP Health Coverage Dates 543
           
            IF @L2300_dtp03_543_cvg_period IS NOT NULL 
                BEGIN
									--insert DTP 543 segment
                    EXEC up_x12_dtp_export @x12_interchange_uid = @x12_interchange_uid,
                        @dtp01_date_time_qual = '543',
                        @dtp02_date_time_format_qual = 'D8',
                        @dtp03_begin_date = @L2300_dtp03_543_cvg_period
                END
             

					--AMT	Health Coverage Policy				
					--B9
            IF @L2300_amt02_B9_contract_amt IS NOT NULL 
                BEGIN
													--insert AMT  B9 segment
                    EXEC up_x12_amt_export @x12_interchange_uid = @x12_interchange_uid,
                        @amt01_amount_qual_code = 'B9',
                        @amt02_amount = @L2300_amt02_B9_contract_amt
                END
              

					--C1           
            IF @L2300_amt02_C1_contract_amt IS NOT NULL 
                BEGIN
										--insert AMT  C1 segment
                    EXEC up_x12_amt_export @x12_interchange_uid = @x12_interchange_uid,
                        @amt01_amount_qual_code = 'C1',
                        @amt02_amount = @L2300_amt02_C1_contract_amt
                END
         

					--D2           
            IF @L2300_amt02_D2_contract_amt IS NOT NULL 
                BEGIN
										--insert AMT  D2 segment
                    EXEC up_x12_amt_export @x12_interchange_uid = @x12_interchange_uid,
                        @amt01_amount_qual_code = 'D2',
                        @amt02_amount = @L2300_amt02_D2_contract_amt
                END
         

					--P3           
            IF @L2300_amt02_P3_contract_amt IS NOT NULL 
                BEGIN
										--insert AMT  P3 segment
                    EXEC up_x12_amt_export @x12_interchange_uid = @x12_interchange_uid,
                        @amt01_amount_qual_code = 'P3',
                        @amt02_amount = @L2300_amt02_P3_contract_amt
                END
         

					--REF	Health Coverage Policy	Number	
					--REF 17          
            IF @L2300_ref02_17_insured_grp_policy_num IS NOT NULL 
                BEGIN
									--insert Ref 17
                    EXEC up_x12_ref_export @x12_interchange_uid = @x12_interchange_uid,
                        @ref01_id_qual = '17',
                        @ref02_reference_number = @L2300_ref02_17_insured_grp_policy_num

                END
          
					--REF 11
            IF @L2300_ref02_1l_insured_grp_policy_num IS NOT NULL 
                BEGIN
									--insert Ref 11
                    EXEC up_x12_ref_export @x12_interchange_uid = @x12_interchange_uid,
                        @ref01_id_qual = '11',
                        @ref02_reference_number = @L2300_ref02_1l_insured_grp_policy_num

                END
           

					--REF ZZ        
            IF @L2300_ref02_ZZ_insured_grp_policy_num IS NOT NULL 
                BEGIN
									--insert Ref ZZ
                    EXEC up_x12_ref_export @x12_interchange_uid = @x12_interchange_uid,
                        @ref01_id_qual = 'ZZ',
                        @ref02_reference_number = @L2300_ref02_ZZ_insured_grp_policy_num

                END
   

					--IDC Not Captured

					/*****BEGIN 2310 Provider Information LOOP******/	
								--not captured--
					/*****END 2310 Provider Information LOOP******/	

					/*****BEGIN 2320 Coordination of Benefits LOOP******/	
					--COB SEGMENT
					--COB 1
        
            IF @L2320_1_cob02_insured_grp_policy_num IS NOT NULL 
                BEGIN
							--insert cob segment
                    EXEC up_x12_cob_export @x12_interchange_uid = @x12_interchange_uid,
                        @cob01_payer_resp_seq_code = @L2320_1_cob01_payer_resp_seq_code,
                        @cob02_insured_grp_policy_num = @L2320_1_cob02_insured_grp_policy_num,
                        @cob03_cob_code = @L2320_1_cob03_cob_code
              
				--COB 2
	  
                    IF @L2320_2_cob02_insured_grp_policy_num IS NOT NULL 
                        BEGIN
							--insert cob segment
                            EXEC up_x12_cob_export @x12_interchange_uid = @x12_interchange_uid,
                                @cob01_payer_resp_seq_code = @L2320_2_cob01_payer_resp_seq_code,
                                @cob02_insured_grp_policy_num = @L2320_2_cob02_insured_grp_policy_num,
                                @cob03_cob_code = @L2320_2_cob03_cob_code
                        END
             
				--COB 3
                    IF @L2320_3_cob02_insured_grp_policy_num IS NOT NULL 
                        BEGIN
							--insert cob segment
                            EXEC up_x12_cob_export @x12_interchange_uid = @x12_interchange_uid,
                                @cob01_payer_resp_seq_code = @L2320_3_cob01_payer_resp_seq_code,
                                @cob02_insured_grp_policy_num = @L2320_3_cob02_insured_grp_policy_num,
                                @cob03_cob_code = @L2320_3_cob03_cob_code
                        END
               
				--COB 4          
                    IF @L2320_4_cob02_insured_grp_policy_num IS NOT NULL 
                        BEGIN
							--insert cob segment
                            EXEC up_x12_cob_export @x12_interchange_uid = @x12_interchange_uid,
                                @cob01_payer_resp_seq_code = @L2320_4_cob01_payer_resp_seq_code,
                                @cob02_insured_grp_policy_num = @L2320_4_cob02_insured_grp_policy_num,
                                @cob03_cob_code = @L2320_4_cob03_cob_code
                        END
                END

				--COB 5           
            IF @L2320_5_cob02_insured_grp_policy_num IS NOT NULL 
                BEGIN
							--insert cob segment
                    EXEC up_x12_cob_export @x12_interchange_uid = @x12_interchange_uid,
                        @cob01_payer_resp_seq_code = @L2320_5_cob01_payer_resp_seq_code,
                        @cob02_insured_grp_policy_num = @L2320_5_cob02_insured_grp_policy_num,
                        @cob03_cob_code = @L2320_5_cob03_cob_code
                END
				
							/*****END 2320 Coordination of Benefits LOOP******/	
								

	/*****END 2300 HEALTH COVERAGE LOOP******/	

/*****END 2000 MEMBER LEVEL DETAIL LOOP******/	
	
            SET @prev_x12_834_benefit_enrollment_id = @x12_834_benefit_enrollment_id
            SET @prev_x12_transaction_id = @x12_transaction_id
            SET @prev_bgn01_trans_set_purpose_code = @bgn01_trans_set_purpose_code
            SET @prev_bgn02_trans_set_ident_code = @bgn02_trans_set_ident_code
            SET @prev_bgn03_trans_set_creation_date = @bgn03_trans_set_creation_date
            SET @prev_bgn04_trans_set_creation_time = @bgn04_trans_set_creation_time
            SET @prev_bgn05_time_zone_code = @bgn05_time_zone_code
            SET @prev_bgn06_trans_set_ident_code = @bgn06_trans_set_ident_code
            SET @prev_bgn08_action_code = @bgn08_action_code
            SET @prev_ref01_reference_id_qual = @ref01_reference_id_qual
            SET @prev_ref02_master_policy_number = @ref02_master_policy_number
            SET @prev_dtp01_date_time_qual = @dtp01_date_time_qual
            SET @prev_dtp02_date_time_period_fmt_qual = @dtp02_date_time_period_fmt_qual
            SET @prev_dtp03_date_time_period = @dtp03_date_time_period
            SET @prev_L1000A_n101_entity_id_code = @L1000A_n101_entity_id_code
            SET @prev_L1000A_n102_plan_sponsor_nm = @L1000A_n102_plan_sponsor_nm
            SET @prev_L1000A_n103_sponsor_id_qual = @L1000A_n103_sponsor_id_qual
            SET @prev_L1000A_n104_sponsor_id = @L1000A_n104_sponsor_id
            SET @prev_L1000B_n101_entity_id_code = @L1000B_n101_entity_id_code
            SET @prev_L1000B_n102_insurer_nm = @L1000B_n102_insurer_nm
            SET @prev_L1000B_n103_insurer_id_qual = @L1000B_n103_insurer_id_qual
            SET @prev_L1000B_n104_insurer_id = @L1000B_n104_insurer_id
            SET @prev_L1000C_n101_entity_id_code = @L1000C_n101_entity_id_code
            SET @prev_L1000C_n102_tpa_broker_nm = @L1000C_n102_tpa_broker_nm
            SET @prev_L1000C_n103_tpa_broker_id_qual = @L1000C_n103_tpa_broker_id_qual
            SET @prev_L1000C_n104_tpa_broker_id = @L1000C_n104_tpa_broker_id
            SET @prev_L1100C_act01_tpa_broker_accnt_num = @L1100C_act01_tpa_broker_accnt_num
            SET @prev_L1100C_act06_tpa_broker_accnt_num = @L1100C_act06_tpa_broker_accnt_num
            SET @prev_L2000_ins01_insured_indicator = @L2000_ins01_insured_indicator
            SET @prev_L2000_ins02_ind_relationship_code = @L2000_ins02_ind_relationship_code
            SET @prev_L2000_ins03_maint_type_code = @L2000_ins03_maint_type_code
            SET @prev_L2000_ins04_maint_reason_code = @L2000_ins04_maint_reason_code
            SET @prev_L2000_ins05_benefit_status_code = @L2000_ins05_benefit_status_code
            SET @prev_L2000_ins06_medicare_plan_code = @L2000_ins06_medicare_plan_code
            SET @prev_L2000_ins07_cobra_code = @L2000_ins07_cobra_code
            SET @prev_L2000_ins08_employment_status_code = @L2000_ins08_employment_status_code
            SET @prev_L2000_ins09_student_status_code = @L2000_ins09_student_status_code
            SET @prev_L2000_ins10_handicap_indicator = @L2000_ins10_handicap_indicator
            SET @prev_L2000_ins12_insured_death_date = @L2000_ins12_insured_death_date
            SET @prev_L2000_ins13_birth_seq_num = @L2000_ins13_birth_seq_num
            SET @prev_L2000_ref02_subscriber_id = @L2000_ref02_subscriber_id
            SET @prev_L2000_ref02_insured_grp_policy_num = @L2000_ref02_insured_grp_policy_num
            SET @prev_L2000_ref01_subscriber_sup_qual_id = @L2000_ref01_subscriber_sup_qual_id
            SET @prev_L2000_ref02_subscriber_sup_id = @L2000_ref02_subscriber_sup_id
            SET @prev_L2000_ref02_3H_subscriber_sup_id = @L2000_ref02_3H_subscriber_sup_id
            SET @prev_L2000_ref02_DX_subscriber_sup_id = @L2000_ref02_DX_subscriber_sup_id
            SET @prev_L2000_ref02_17_subscriber_sup_id = @L2000_ref02_17_subscriber_sup_id
            SET @prev_L2000_ref02_23_subscriber_sup_id = @L2000_ref02_23_subscriber_sup_id
            SET @prev_L2000_ref02_F6_subscriber_sup_id = @L2000_ref02_F6_subscriber_sup_id
            SET @prev_L2000_ref02_prior_cvg_month_count = @L2000_ref02_prior_cvg_month_count
            SET @prev_L2000_dtp01_member_level_qual = @L2000_dtp01_member_level_qual
            SET @prev_L2000_dtp03_356_status_info_eff_date = @L2000_dtp03_356_status_info_eff_date
            SET @prev_L2000_dtp03_357_status_info_eff_date = @L2000_dtp03_357_status_info_eff_date
            SET @prev_L2100A_nm101_entity_id_code = @L2100A_nm101_entity_id_code
            SET @prev_L2100A_nm102_entity_type_qual = @L2100A_nm102_entity_type_qual
            SET @prev_L2100A_nm103_subscriber_last_nm = @L2100A_nm103_subscriber_last_nm
            SET @prev_L2100A_nm104_subscriber_first_nm = @L2100A_nm104_subscriber_first_nm
            SET @prev_L2100A_nm105_subscriber_middle_nm = @L2100A_nm105_subscriber_middle_nm
            SET @prev_L2100A_nm106_subscriber_name_prefix = @L2100A_nm106_subscriber_name_prefix
            SET @prev_L2100A_nm107_subscriber_name_suffix = @L2100A_nm107_subscriber_name_suffix
            SET @prev_L2100A_nm108_subscriber_id_code_qual = @L2100A_nm108_subscriber_id_code_qual
            SET @prev_L2100A_nm109_subscriber_id = @L2100A_nm109_subscriber_id
            SET @prev_L2100A_per101_member_comm_func_code = @L2100A_per101_member_comm_func_code
            SET @prev_L2100A_per103_member_comm_num_qual = @L2100A_per103_member_comm_num_qual
            SET @prev_L2100A_per104_member_comm = @L2100A_per104_member_comm
            SET @prev_L2100A_n301_subscriber_address1 = @L2100A_n301_subscriber_address1
            SET @prev_L2100A_n302_subscriber_address2 = @L2100A_n302_subscriber_address2
            SET @prev_L2100A_n401_subscriber_city = @L2100A_n401_subscriber_city
            SET @prev_L2100A_n402_subscriber_state = @L2100A_n402_subscriber_state
            SET @prev_L2100A_n403_subscriber_zip = @L2100A_n403_subscriber_zip
            SET @prev_L2100A_n404_subscriber_country = @L2100A_n404_subscriber_country
            SET @prev_L2100A_n406_subscriber_location_code = @L2100A_n406_subscriber_location_code
            SET @prev_L2100A_dmg02_member_dob = @L2100A_dmg02_member_dob
            SET @prev_L2100A_dmg03_member_gender = @L2100A_dmg03_member_gender
            SET @prev_L2100A_dmg04_member_marital_status = @L2100A_dmg04_member_marital_status
            SET @prev_L2100A_dmg05_member_ethnicity = @L2100A_dmg05_member_ethnicity
            SET @prev_L2100A_dmg06_member_citizenship = @L2100A_dmg06_member_citizenship
            SET @prev_L2100A_amt02_B9_contract_amt = @L2100A_amt02_B9_contract_amt
            SET @prev_L2100A_amt02_C1_contract_amt = @L2100A_amt02_C1_contract_amt
            SET @prev_L2100A_amt02_D2_contract_amt = @L2100A_amt02_D2_contract_amt
            SET @prev_L2100A_amt02_P3_contract_amt = @L2100A_amt02_P3_contract_amt
            SET @prev_L2100A_hlh01_health_related_code = @L2100A_hlh01_health_related_code
            SET @prev_L2100A_hlh02_member_height = @L2100A_hlh02_member_height
            SET @prev_L2100A_hlh03_member_weight = @L2100A_hlh03_member_weight
            SET @prev_L2100A_lui01_language_code_qual = @L2100A_lui01_language_code_qual
            SET @prev_L2100A_lui02_language_code = @L2100A_lui02_language_code
            SET @prev_L2100A_lui03_language_desc = @L2100A_lui03_language_desc
            SET @prev_L2100A_lui04_language_use_indicator = @L2100A_lui04_language_use_indicator
            SET @prev_L2100G_nm101_entity_id_code = @L2100G_nm101_entity_id_code
            SET @prev_L2100G_nm102_entity_type_qual = @L2100G_nm102_entity_type_qual
            SET @prev_L2100G_nm103_resp_party_last_nm = @L2100G_nm103_resp_party_last_nm
            SET @prev_L2100G_nm104_resp_party_first_nm = @L2100G_nm104_resp_party_first_nm
            SET @prev_L2100G_nm105_resp_party_middle_nm = @L2100G_nm105_resp_party_middle_nm
            SET @prev_L2100G_nm106_resp_party_name_prefix = @L2100G_nm106_resp_party_name_prefix
            SET @prev_L2100G_nm107_resp_party_name_suffix = @L2100G_nm107_resp_party_name_suffix
            SET @prev_L2100G_nm108_resp_party_id_code_qual = @L2100G_nm108_resp_party_id_code_qual
            SET @prev_L2100G_nm109_resp_party_id = @L2100G_nm109_resp_party_id
            SET @prev_L2100G_per101_member_comm_func_code = @L2100G_per101_member_comm_func_code
            SET @prev_L2100G_per103_member_comm_num_qual = @L2100G_per103_member_comm_num_qual
            SET @prev_L2100G_per104_member_comm = @L2100G_per104_member_comm
            SET @prev_L2100G_n301_resp_party_address1 = @L2100G_n301_resp_party_address1
            SET @prev_L2100G_n302_resp_party_address2 = @L2100G_n302_resp_party_address2
            SET @prev_L2100G_n401_resp_party_city = @L2100G_n401_resp_party_city
            SET @prev_L2100G_n402_resp_party_state = @L2100G_n402_resp_party_state
            SET @prev_L2100G_n403_resp_party_zip = @L2100G_n403_resp_party_zip
            SET @prev_L2100G_n404_resp_party_country = @L2100G_n404_resp_party_country
            SET @prev_L2300_hd01_maint_type_code = @L2300_hd01_maint_type_code
            SET @prev_L2300_hd03_ins_line_code = @L2300_hd03_ins_line_code
            SET @prev_L2300_hd04_plan_cvg_desc = @L2300_hd04_plan_cvg_desc
            SET @prev_L2300_hd05_cvg_level_code = @L2300_hd05_cvg_level_code
            SET @prev_L2300_dtp03_303_cvg_period = @L2300_dtp03_303_cvg_period
            SET @prev_L2300_dtp03_348_cvg_period = @L2300_dtp03_348_cvg_period
            SET @prev_L2300_dtp03_349_cvg_period = @L2300_dtp03_349_cvg_period
            SET @prev_L2300_dtp03_543_cvg_period = @L2300_dtp03_543_cvg_period
            SET @prev_L2300_amt02_B9_contract_amt = @L2300_amt02_B9_contract_amt
            SET @prev_L2300_amt02_C1_contract_amt = @L2300_amt02_C1_contract_amt
            SET @prev_L2300_amt02_D2_contract_amt = @L2300_amt02_D2_contract_amt
            SET @prev_L2300_amt02_P3_contract_amt = @L2300_amt02_P3_contract_amt
            SET @prev_L2300_ref02_17_insured_grp_policy_num = @L2300_ref02_17_insured_grp_policy_num
            SET @prev_L2300_ref02_1l_insured_grp_policy_num = @L2300_ref02_1l_insured_grp_policy_num
            SET @prev_L2300_ref02_ZZ_insured_grp_policy_num = @L2300_ref02_ZZ_insured_grp_policy_num
            SET @prev_L2320_1_cob01_payer_resp_seq_code = @L2320_1_cob01_payer_resp_seq_code
            SET @prev_L2320_1_cob02_insured_grp_policy_num = @L2320_1_cob02_insured_grp_policy_num
            SET @prev_L2320_1_cob03_cob_code = @L2320_1_cob03_cob_code
            SET @prev_L2320_2_cob01_payer_resp_seq_code = @L2320_2_cob01_payer_resp_seq_code
            SET @prev_L2320_2_cob02_insured_grp_policy_num = @L2320_2_cob02_insured_grp_policy_num
            SET @prev_L2320_2_cob03_cob_code = @L2320_2_cob03_cob_code
            SET @prev_L2320_3_cob01_payer_resp_seq_code = @L2320_3_cob01_payer_resp_seq_code
            SET @prev_L2320_3_cob02_insured_grp_policy_num = @L2320_3_cob02_insured_grp_policy_num
            SET @prev_L2320_3_cob03_cob_code = @L2320_3_cob03_cob_code
            SET @prev_L2320_4_cob01_payer_resp_seq_code = @L2320_4_cob01_payer_resp_seq_code
            SET @prev_L2320_4_cob02_insured_grp_policy_num = @L2320_4_cob02_insured_grp_policy_num
            SET @prev_L2320_4_cob03_cob_code = @L2320_4_cob03_cob_code
            SET @prev_L2320_5_cob01_payer_resp_seq_code = @L2320_5_cob01_payer_resp_seq_code
            SET @prev_L2320_5_cob02_insured_grp_policy_num = @L2320_5_cob02_insured_grp_policy_num
            SET @prev_L2320_5_cob03_cob_code = @L2320_5_cob03_cob_code
            SET @segment_count = ( @segment_count + 1 )


            FETCH NEXT FROM curtX12Doc INTO @x12_834_benefit_enrollment_id,
                @x12_transaction_id, @bgn01_trans_set_purpose_code,
                @bgn02_trans_set_ident_code, @bgn03_trans_set_creation_date,
                @bgn04_trans_set_creation_time, @bgn05_time_zone_code,
                @bgn06_trans_set_ident_code, @bgn08_action_code,
                @ref01_reference_id_qual, @ref02_master_policy_number,
                @dtp01_date_time_qual, @dtp02_date_time_period_fmt_qual,
                @dtp03_date_time_period, @L1000A_n101_entity_id_code,
                @L1000A_n102_plan_sponsor_nm, @L1000A_n103_sponsor_id_qual,
                @L1000A_n104_sponsor_id, @L1000B_n101_entity_id_code,
                @L1000B_n102_insurer_nm, @L1000B_n103_insurer_id_qual,
                @L1000B_n104_insurer_id, @L1000C_n101_entity_id_code,
                @L1000C_n102_tpa_broker_nm, @L1000C_n103_tpa_broker_id_qual,
                @L1000C_n104_tpa_broker_id, @L1100C_act01_tpa_broker_accnt_num,
                @L1100C_act06_tpa_broker_accnt_num,
                @L2000_ins01_insured_indicator,
                @L2000_ins02_ind_relationship_code,
                @L2000_ins03_maint_type_code, @L2000_ins04_maint_reason_code,
                @L2000_ins05_benefit_status_code,
                @L2000_ins06_medicare_plan_code, @L2000_ins07_cobra_code,
                @L2000_ins08_employment_status_code,
                @L2000_ins09_student_status_code,
                @L2000_ins10_handicap_indicator,
                @L2000_ins12_insured_death_date, @L2000_ins13_birth_seq_num,
                @L2000_ref02_subscriber_id,
                @L2000_ref02_insured_grp_policy_num,
                @L2000_ref01_subscriber_sup_qual_id,
                @L2000_ref02_subscriber_sup_id,
                @L2000_ref02_3H_subscriber_sup_id,
                @L2000_ref02_DX_subscriber_sup_id,
                @L2000_ref02_17_subscriber_sup_id,
                @L2000_ref02_23_subscriber_sup_id,
                @L2000_ref02_F6_subscriber_sup_id,
                @L2000_ref02_prior_cvg_month_count,
                @L2000_dtp01_member_level_qual,
                @L2000_dtp03_356_status_info_eff_date,
                @L2000_dtp03_357_status_info_eff_date,
                @L2100A_nm101_entity_id_code, @L2100A_nm102_entity_type_qual,
                @L2100A_nm103_subscriber_last_nm,
                @L2100A_nm104_subscriber_first_nm,
                @L2100A_nm105_subscriber_middle_nm,
                @L2100A_nm106_subscriber_name_prefix,
                @L2100A_nm107_subscriber_name_suffix,
                @L2100A_nm108_subscriber_id_code_qual,
                @L2100A_nm109_subscriber_id,
                @L2100A_per101_member_comm_func_code,
                @L2100A_per103_member_comm_num_qual,
                @L2100A_per104_member_comm, @L2100A_n301_subscriber_address1,
                @L2100A_n302_subscriber_address2, @L2100A_n401_subscriber_city,
                @L2100A_n402_subscriber_state, @L2100A_n403_subscriber_zip,
                @L2100A_n404_subscriber_country,
                @L2100A_n406_subscriber_location_code,
                @L2100A_dmg02_member_dob, @L2100A_dmg03_member_gender,
                @L2100A_dmg04_member_marital_status,
                @L2100A_dmg05_member_ethnicity,
                @L2100A_dmg06_member_citizenship,
                @L2100A_amt02_B9_contract_amt, @L2100A_amt02_C1_contract_amt,
                @L2100A_amt02_D2_contract_amt, @L2100A_amt02_P3_contract_amt,
                @L2100A_hlh01_health_related_code, @L2100A_hlh02_member_height,
                @L2100A_hlh03_member_weight, @L2100A_lui01_language_code_qual,
                @L2100A_lui02_language_code, @L2100A_lui03_language_desc,
                @L2100A_lui04_language_use_indicator,
                @L2100G_nm101_entity_id_code, @L2100G_nm102_entity_type_qual,
                @L2100G_nm103_resp_party_last_nm,
                @L2100G_nm104_resp_party_first_nm,
                @L2100G_nm105_resp_party_middle_nm,
                @L2100G_nm106_resp_party_name_prefix,
                @L2100G_nm107_resp_party_name_suffix,
                @L2100G_nm108_resp_party_id_code_qual,
                @L2100G_nm109_resp_party_id,
                @L2100G_per101_member_comm_func_code,
                @L2100G_per103_member_comm_num_qual,
                @L2100G_per104_member_comm, @L2100G_n301_resp_party_address1,
                @L2100G_n302_resp_party_address2, @L2100G_n401_resp_party_city,
                @L2100G_n402_resp_party_state, @L2100G_n403_resp_party_zip,
                @L2100G_n404_resp_party_country, @L2300_hd01_maint_type_code,
                @L2300_hd03_ins_line_code, @L2300_hd04_plan_cvg_desc,
                @L2300_hd05_cvg_level_code, @L2300_dtp03_303_cvg_period,
                @L2300_dtp03_348_cvg_period, @L2300_dtp03_349_cvg_period,
                @L2300_dtp03_543_cvg_period, @L2300_amt02_B9_contract_amt,
                @L2300_amt02_C1_contract_amt, @L2300_amt02_D2_contract_amt,
                @L2300_amt02_P3_contract_amt,
                @L2300_ref02_17_insured_grp_policy_num,
                @L2300_ref02_1l_insured_grp_policy_num,
                @L2300_ref02_ZZ_insured_grp_policy_num,
                @L2320_1_cob01_payer_resp_seq_code,
                @L2320_1_cob02_insured_grp_policy_num, @L2320_1_cob03_cob_code,
                @L2320_2_cob01_payer_resp_seq_code,
                @L2320_2_cob02_insured_grp_policy_num, @L2320_2_cob03_cob_code,
                @L2320_3_cob01_payer_resp_seq_code,
                @L2320_3_cob02_insured_grp_policy_num, @L2320_3_cob03_cob_code,
                @L2320_4_cob01_payer_resp_seq_code,
                @L2320_4_cob02_insured_grp_policy_num, @L2320_4_cob03_cob_code,
                @L2320_5_cob01_payer_resp_seq_code,
                @L2320_5_cob02_insured_grp_policy_num, @L2320_5_cob03_cob_code
				
        END

    CLOSE curtX12Doc
    DEALLOCATE curtX12Doc

	-- Count up all the segments we just inserted, exclude the transaction header segments, and subtract what was there before.
    SELECT  @segment_count = COUNT(x12_parse_temp_id) - @pre_segment_count
    FROM    x12_parse_temp
    WHERE   col001 NOT IN ( 'ISA', 'GS', 'ST', 'IEA', 'GE', 'SE' )
            AND x12_parse_temp_uid = @x12_interchange_uid

    RETURN ( 0 )
