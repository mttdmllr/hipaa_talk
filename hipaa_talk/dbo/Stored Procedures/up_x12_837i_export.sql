CREATE Procedure [dbo].[up_x12_837i_export] (@x12_transaction_id int = null, @segment_count int output)
As
declare @Col001 varchar(255)
declare @Col002 varchar(255)
declare @Col003 varchar(255)
declare @Col004 varchar(255)
declare @Col005 varchar(255)
declare @Col006 varchar(255)
declare @Col007 varchar(255)
declare @Col008 varchar(255)
declare @Col009 varchar(255)
declare @Col010 varchar(255)
declare @Col011 varchar(255)
declare @Col012 varchar(255)
declare @Col013 varchar(255)
declare @Col014 varchar(255)
declare @Col015 varchar(255)
declare @Col016 varchar(255)
declare @Col017 varchar(255)
declare @Col018 varchar(255)
declare @Col019 varchar(255)
declare @Col020 varchar(255)
declare @Col021 varchar(255)


--BEGIN: DECLARE 837i Variables
declare @bht01_hierarchical_structure_code char(4) 
declare @bht02_trans_set_purpose_code char(2) 
declare @bht03_orig_app_tran_id varchar(30) 
declare @bht04_trans_set_creation_date varchar(8) 
declare @bht05_trans_set_creation_time varchar(8) 
declare @bht06_claim_encounter_id char(2) 
	
declare @ref01_receiver_ref_id_qual char(3) 
declare @ref02_transmission_type_code varchar(30) 
	
declare @L1000A_nm102_entity_type_qual char(1) 
declare @L1000A_nm103_submitter_last_nm varchar(35) 
declare @L1000A_nm104_submitter_first_nm varchar(25) 
declare @L1000A_nm105_submitter_middle_nm varchar(25) 
declare @L1000A_nm108_submitter_id_qual char(2) 
declare @L1000A_nm109_submitter_id varchar(80) 
	
declare @L1000A_per01_contact_function_code char(2) 
declare @L1000A_per02_contact_nm varchar(60) 
declare @L1000A_per03_comm_num_qual char(2) 
declare @L1000A_per04_comm_number varchar(80) 
	
declare @L1000B_nm102_entity_type_qual char(1) 
declare @L1000B_nm103_receiver_last_nm varchar(35) 
declare @L1000B_nm108_receiver_id_qual char(2) 
declare @L1000B_nm109_receiver_id varchar(80) 
	
declare @L2000A_hl01_hierarchical_id_num varchar(12) 
declare @L2000A_hl03_hierarchical_level_code char(2) 
declare @L2000A_hl04_hierarchical_child_code char(1) 
	
declare @L2000A_prv01_provider_code char(3) 
declare @L2000A_prv02_ref_id_qual char(3) 
declare @L2000A_prv03_taxonomy_code varchar(30) 
	
declare @L2000A_cur02_currency_code char(3) 
	
declare @L2010AA_nm102_entity_type_qual char(1) 
declare @L2010AA_nm103_billing_prov_last_nm varchar(35) 
declare @L2010AA_nm104_billing_prov_first_nm varchar(25) 
declare @L2010AA_nm105_billing_prov_middle_nm varchar(25) 
declare @L2010AA_nm107_billing_prov_suffix varchar(10) 
declare @L2010AA_nm108_id_code_qual char(2) 
declare @L2010AA_nm109_billing_prov_id varchar(80) 
	
declare @L2010AA_n301_billing_prov_address1 varchar(55) 
declare @L2010AA_n302_billing_prov_address2 varchar(55) 
	
declare @L2010AA_n401_billing_prov_city varchar(30) 
declare @L2010AA_n402_billing_prov_state char(2) 
declare @L2010AA_n403_billing_prov_zip varchar(15) 
declare @L2010AA_n404_billing_prov_country char(3) 
	
declare @L2010AA_ref02_1B_billing_prov_id varchar(30) 
declare @L2010AA_ref02_1C_billing_prov_id varchar(30) 
declare @L2010AA_ref02_1D_billing_prov_id varchar(30) 
declare @L2010AA_ref02_1G_billing_prov_id varchar(30) 
declare @L2010AA_ref02_EI_billing_prov_id varchar(30) 
declare @L2010AA_ref02_SY_billing_prov_id varchar(30) 
declare @L2010AA_ref02_FH_billing_prov_id varchar(30) 
declare @L2010AA_ref02_06_card_billing_id varchar(30) 
declare @L2010AA_ref02_8U_card_billing_id varchar(30) 
declare @L2010AA_ref02_EM_card_billing_id varchar(30) 
declare @L2010AA_ref02_IJ_card_billing_id varchar(30) 
declare @L2010AA_ref02_LU_card_billing_id varchar(30) 
declare @L2010AA_ref02_ST_card_billing_id varchar(30) 

declare @L2010AA_per01_billing_prov_comm_func_code char(2) 
declare @L2010AA_per02_billing_prov_contact_nm varchar(60) 
declare @L2010AA_per03_billing_prov_comm_num_qual char(2) 
declare @L2010AA_per04_billing_prov_comm varchar(80) 
	
declare @L2010AB_nm102_entity_type_qual char(1) 
declare @L2010AB_nm103_payto_prov_last_nm varchar(35) 
declare @L2010AB_nm104_payto_prov_first_nm varchar(25)
declare @L2010AB_nm105_payto_prov_middle_nm varchar(25)
declare @L2010AB_nm107_payto_prov_suffix varchar(10)
declare @L2010AB_nm108_id_code_qual char(2) 
declare @L2010AB_nm109_payto_prov_id varchar(80) 
	
declare @L2010AB_n301_payto_prov_address1 varchar(55) 
declare @L2010AB_n302_payto_prov_address2 varchar(55) 
	
declare @L2010AB_n401_payto_prov_city varchar(30) 
declare @L2010AB_n402_payto_prov_state char(2) 
declare @L2010AB_n403_payto_prov_zip varchar(15) 
declare @L2010AB_n404_payto_prov_country char(3) 
	
declare @L2010AB_ref02_1C_payto_prov_id varchar(30) 
declare @L2010AB_ref02_1D_payto_prov_id varchar(30) 
declare @L2010AB_ref02_1G_payto_prov_id varchar(30) 
declare @L2010AB_ref02_EI_payto_prov_id varchar(30) 
declare @L2010AB_ref02_SY_payto_prov_id varchar(30) 
declare @L2010AB_ref02_FH_payto_prov_id varchar(30) 
	
declare @L2000B_hl01_hierarchical_id_num varchar(12) 
declare @L2000B_hl02_hierarchical_parent_id_num varchar(12) 
declare @L2000B_hl03_hierarchical_level_code char(2) 
declare @L2000B_hl04_hierarchical_child_code char(1) 
	
declare @L2000B_sbr01_payer_resp_seq_code char(1) 
declare @L2000B_sbr02_ind_relationship_code char(2) 
declare @L2000B_sbr03_insured_grp_policy_num varchar(30) 
declare @L2000B_sbr04_insured_grp_nm varchar(60) 
declare @L2000B_sbr09_claim_id_code char(2) 
	
	
declare @L2000B_pat06_insured_ind_death_date varchar(35) 
declare @L2000B_pat08_patient_weight varchar(10) 
declare @L2000B_pat09_pregnancy_indicator char(1) 
	
declare @L2010BA_nm102_entity_type_qual char(1) 
declare @L2010BA_nm103_subscriber_last_nm varchar(35) 
declare @L2010BA_nm104_subscriber_first_nm varchar(25) 
declare @L2010BA_nm105_subscriber_middle_nm varchar(25) 
declare @L2010BA_nm107_subscriber_suffix varchar(10) 
declare @L2010BA_nm108_id_code_qual char(2) 
declare @L2010BA_nm109_subscriber_id varchar(80) 
	
declare @L2010BA_n301_subscriber_address1 varchar(55) 
declare @L2010BA_n302_subscriber_address2 varchar(55) 
		
declare @L2010BA_n401_subscriber_city varchar(30) 
declare @L2010BA_n402_subscriber_state char(2) 
declare @L2010BA_n403_subscriber_zip varchar(15) 
declare @L2010BA_n404_subscriber_country char(3) 
	
declare @L2010BA_dmg02_subscriber_dob varchar(35) 
declare @L2010BA_dmg03_subscriber_gender char(1) 
	
declare @L2010BA_ref02_1W_subscriber_sup_id varchar(30) 
declare @L2010BA_ref02_23_subscriber_sup_id varchar(30) 
declare @L2010BA_ref02_IG_subscriber_sup_id varchar(30) 
declare @L2010BA_ref02_SY_subscriber_sup_id varchar(30) 
declare @L2010BA_ref02_Y4_prop_casualty_claim_num varchar(30) 

declare @L2010BB_nm102_entity_type_qual char(1) 
declare @L2010BB_nm103_card_holder_last_nm varchar(35) 
declare @L2010BB_nm104_card_holder_first_nm varchar(25) 
declare @L2010BB_nm105_card_holder_middle_nm varchar(25) 
declare @L2010BB_nm107_card_holder_suffix varchar(10) 
declare @L2010BB_nm108_card_id_qual char(2) 
declare @L2010BB_nm109_card_num varchar(80) 
	
declare @L2010BB_ref02_AB_payer_id varchar(30) 
declare @L2010BB_ref02_BB_payer_id varchar(30) 
				
declare @L2010BC_nm102_entity_type_qual char(1) 
declare @L2010BC_nm103_payer_nm varchar(35) 
declare @L2010BC_nm108_payer_id_qual char(2) 
declare @L2010BC_nm109_payer_id varchar(80) 


declare @L2010BC_n301_payer_address1 varchar(55) 
declare @L2010BC_n302_payer_address2 varchar(55) 
declare @L2010BC_n401_payer_city varchar(30) 
declare @L2010BC_n402_payer_state char(2) 
declare @L2010BC_n403_payer_zip varchar(15) 
declare @L2010BC_n404_payer_country char(3) 

declare @L2010BC_ref02_2U_payer_id varchar(30) 
declare @L2010BC_ref02_FY_payer_id varchar(30) 
declare @L2010BC_ref02_NF_payer_id varchar(30) 
declare @L2010BC_ref02_TJ_payer_id varchar(30) 

	
declare @L2010BD_nm102_entity_type_qual char(1) 
declare @L2010BD_nm103_resp_party_last_nm varchar(35) 
declare @L2010BD_nm104_resp_party_first_nm varchar(25) 
declare @L2010BD_nm105_resp_party_middle_nm varchar(25) 
declare @L2010BD_nm107_resp_party_suffix varchar(10) 

declare @L2010BD_n301_resp_party_address1 varchar(55) 
declare @L2010BD_n302_resp_party_address2 varchar(55) 

declare @L2010BD_n401_resp_party_city varchar(30) 
declare @L2010BD_n402_resp_party_state char(2) 
declare @L2010BD_n403_resp_party_zip varchar(15) 
declare @L2010BD_n404_resp_party_country char(3) 


	
declare @L2000C_hl01_hierarchical_id_num varchar(12) 
declare @L2000C_hl02_hierarchical_parent_id_num varchar(12) 
declare @L2000C_hl03_hierarchical_level_code char(2) 
declare @L2000C_hl04_hierarchical_child_code char(1) 
	
declare @L2000C_pat01_ind_relationship_code char(2) 
		
declare @L2010CA_nm102_entity_type_qual char(1) 
declare @L2010CA_nm103_patient_last_nm varchar(35) 
declare @L2010CA_nm104_patient_first_nm varchar(25) 
declare @L2010CA_nm105_patient_middle_nm varchar(25) 
declare @L2010CA_nm107_patient_suffix varchar(10) 
declare @L2010CA_nm108_id_code_qual char(2) 
declare @L2010CA_nm109_patient_id varchar(80) 
	
declare @L2010CA_n301_patient_address1 varchar(55) 
declare @L2010CA_n302_patient_address2 varchar(55) 
	
declare @L2010CA_n401_patient_city varchar(30) 
declare @L2010CA_n402_patient_state char(2) 
declare @L2010CA_n403_patient_zip varchar(15) 
declare @L2010CA_n404_patient_country char(3) 
	
declare @L2010CA_dmg02_patient_dob varchar(35) 
declare @L2010CA_dmg03_patient_gender char(1) 
	
declare @L2010CA_ref02_1W_patient_sup_id varchar(30) 
declare @L2010CA_ref02_23_patient_sup_id varchar(30) 
declare @L2010CA_ref02_IG_patient_sup_id varchar(30) 
declare @L2010CA_ref02_SY_patient_sup_id varchar(30) 
declare @L2010CA_ref02_Y4_prop_casualty_claim_num varchar(30) 

declare @L2300_clm01_pt_acct_num varchar(38) 
declare @L2300_clm02_total_claim_chg_amt money 
declare @L2300_clm05_facility_type_code char(2) 
declare @L2300_clm05_facility_code_qual char(2)
declare @L2300_clm05_claim_freq_code char(1) 
declare @L2300_clm06_provider_signature_ind char(1) 
declare @L2300_clm07_medicare_assign_code char(1) 
declare @L2300_clm08_benefit_assign_ind char(1) 
declare @L2300_clm09_release_of_info_code char(1) 
declare @L2300_clm18_explan_benefits_ind char(1) 
declare @L2300_clm20_delay_reason_code char(2) 
	
declare @L2300_dtp03_096_discharge_hour varchar(35) 
declare @L2300_dtp03_434_begin_statement_date varchar(35) 
declare @L2300_dtp03_434_end_statement_date varchar(35) 
declare @L2300_dtp03_435_admission_date varchar(35) 

declare @L2300_cl101_admit_type_code char(1)
declare @L2300_cl102_admit_source_code char(1)
declare @L2300_cl103_patient_status_code char(2)

declare @L2300_pwk01_attachment_type_code char(2) 
declare @L2300_pwk02_attachment_trans_code char(2) 
declare @L2300_pwk06_attachment_control_num varchar(80) 
	
declare @L2300_amt02_patient_paid_amt money 
declare @L2300_amt02_patient_resp_amt money
declare @L2300_amt02_total_purchased_amt money 
	
declare @L2300_ref02_9C_adj_repriced_claim_num varchar(30) 
declare @L2300_ref02_9A_repriced_claim_num varchar(30) 
declare @L2300_ref02_D9_claim_id_clearing_house varchar(30) 
declare @L2300_ref02_DD_domcument_id varchar(30) 
declare @L2300_ref02_F8_original_ref_num varchar(30) 
declare @L2300_ref02_9F_referral_num varchar(30) 
declare @L2300_ref02_G1_prior_auth_num varchar(30) 
declare @L2300_ref02_EA_medical_record_num varchar(30) 
	
declare @L2300_k301_fixed_format_info varchar(80) 
	
declare @L2300_nte01_note_ref_code char(3) 
declare @L2300_nte02_claim_note_text varchar(80) 

declare @L2300_hi01_BK_diag_admit_ecode varchar(30)
declare @L2300_hi02_BJ_diag_admit_ecode varchar(30)
declare @L2300_hi02_ZZ_diag_admit_ecode varchar(30)
declare @L2300_hi03_BN_diag_admit_ecode varchar(30)

declare @L2300_hi01_DR_diag_drg varchar(30)

declare @L2300_hi01_BF_diag_code varchar(30)
declare @L2300_hi02_BF_diag_code varchar(30)
declare @L2300_hi03_BF_diag_code varchar(30)
declare @L2300_hi04_BF_diag_code varchar(30)
declare @L2300_hi05_BF_diag_code varchar(30)
declare @L2300_hi06_BF_diag_code varchar(30)
declare @L2300_hi07_BF_diag_code varchar(30)
declare @L2300_hi08_BF_diag_code varchar(30)
declare @L2300_hi09_BF_diag_code varchar(30)
declare @L2300_hi10_BF_diag_code varchar(30)
declare @L2300_hi11_BF_diag_code varchar(30)
declare @L2300_hi12_BF_diag_code varchar(30)

declare @L2300_hi01_BR_princ_proc_info varchar(30)
declare @L2300_hi01_BR_princ_proc_info_date varchar(35)

declare @L2300_hi01_BQ_other_proc_info varchar(30)
declare @L2300_hi01_BQ_other_proc_info_date varchar(35)
declare @L2300_hi02_BQ_other_proc_info varchar(30)
declare @L2300_hi02_BQ_other_proc_info_date varchar(35)
declare @L2300_hi03_BQ_other_proc_info varchar(30)
declare @L2300_hi03_BQ_other_proc_info_date varchar(35)
declare @L2300_hi04_BQ_other_proc_info varchar(30)
declare @L2300_hi04_BQ_other_proc_info_date varchar(35)
declare @L2300_hi05_BQ_other_proc_info varchar(30)
declare @L2300_hi05_BQ_other_proc_info_date varchar(35)
declare @L2300_hi06_BQ_other_proc_info varchar(30)
declare @L2300_hi06_BQ_other_proc_info_date varchar(35)
declare @L2300_hi07_BQ_other_proc_info varchar(30)
declare @L2300_hi07_BQ_other_proc_info_date varchar(35)
declare @L2300_hi08_BQ_other_proc_info varchar(30)
declare @L2300_hi08_BQ_other_proc_info_date varchar(35)
declare @L2300_hi09_BQ_other_proc_info varchar(30)
declare @L2300_hi09_BQ_other_proc_info_date varchar(35)
declare @L2300_hi10_BQ_other_proc_info varchar(30)
declare @L2300_hi10_BQ_other_proc_info_date varchar(35)
declare @L2300_hi11_BQ_other_proc_info varchar(30)
declare @L2300_hi11_BQ_other_proc_info_date varchar(35)
declare @L2300_hi12_BQ_other_proc_info varchar(30)
declare @L2300_hi12_BQ_other_proc_info_date varchar(35)

declare @L2300_hi01_BI_occur_span varchar(30)
declare @L2300_hi01_BI_occur_span_date varchar(35)
declare @L2300_hi02_BI_occur_span varchar(30)
declare @L2300_hi02_BI_occur_span_date varchar(35)
declare @L2300_hi03_BI_occur_span varchar(30)
declare @L2300_hi03_BI_occur_span_date varchar(35)
declare @L2300_hi04_BI_occur_span varchar(30)
declare @L2300_hi04_BI_occur_span_date varchar(35)
declare @L2300_hi05_BI_occur_span varchar(30)
declare @L2300_hi05_BI_occur_span_date varchar(35)
declare @L2300_hi06_BI_occur_span varchar(30)
declare @L2300_hi06_BI_occur_span_date varchar(35)
declare @L2300_hi07_BI_occur_span varchar(30)
declare @L2300_hi07_BI_occur_span_date varchar(35)
declare @L2300_hi08_BI_occur_span varchar(30)
declare @L2300_hi08_BI_occur_span_date varchar(35)
declare @L2300_hi09_BI_occur_span varchar(30)
declare @L2300_hi09_BI_occur_span_date varchar(35)
declare @L2300_hi10_BI_occur_span varchar(30)
declare @L2300_hi10_BI_occur_span_date varchar(35)
declare @L2300_hi11_BI_occur_span varchar(30)
declare @L2300_hi11_BI_occur_span_date varchar(35)
declare @L2300_hi12_BI_occur_span varchar(30)
declare @L2300_hi12_BI_occur_span_date varchar(35)

declare @L2300_hi01_BH_occur_info varchar(30)
declare @L2300_hi01_BH_occur_info_date varchar(35)
declare @L2300_hi02_BH_occur_info varchar(30)
declare @L2300_hi02_BH_occur_info_date varchar(35)
declare @L2300_hi03_BH_occur_info varchar(30)
declare @L2300_hi03_BH_occur_info_date varchar(35)
declare @L2300_hi04_BH_occur_info varchar(30)
declare @L2300_hi04_BH_occur_info_date varchar(35)
declare @L2300_hi05_BH_occur_info varchar(30)
declare @L2300_hi05_BH_occur_info_date varchar(35)
declare @L2300_hi06_BH_occur_info varchar(30)
declare @L2300_hi06_BH_occur_info_date varchar(35)
declare @L2300_hi07_BH_occur_info varchar(30)
declare @L2300_hi07_BH_occur_info_date varchar(35)
declare @L2300_hi08_BH_occur_info varchar(30)
declare @L2300_hi08_BH_occur_info_date varchar(35)
declare @L2300_hi09_BH_occur_info varchar(30)
declare @L2300_hi09_BH_occur_info_date varchar(35)
declare @L2300_hi10_BH_occur_info varchar(30)
declare @L2300_hi10_BH_occur_info_date varchar(35)
declare @L2300_hi11_BH_occur_info varchar(30)
declare @L2300_hi11_BH_occur_info_date varchar(35)
declare @L2300_hi12_BH_occur_info varchar(30)
declare @L2300_hi12_BH_occur_info_date varchar(35)

declare @L2300_hi01_BE_value_info varchar(30)
declare @L2300_hi01_BE_value_info_amt money
declare @L2300_hi02_BE_value_info varchar(30)
declare @L2300_hi02_BE_value_info_amt money
declare @L2300_hi03_BE_value_info varchar(30)
declare @L2300_hi03_BE_value_info_amt money
declare @L2300_hi04_BE_value_info varchar(30)
declare @L2300_hi04_BE_value_info_amt money
declare @L2300_hi05_BE_value_info varchar(30)
declare @L2300_hi05_BE_value_info_amt money
declare @L2300_hi06_BE_value_info varchar(30)
declare @L2300_hi06_BE_value_info_amt money
declare @L2300_hi07_BE_value_info varchar(30)
declare @L2300_hi07_BE_value_info_amt money
declare @L2300_hi08_BE_value_info varchar(30)
declare @L2300_hi08_BE_value_info_amt money
declare @L2300_hi09_BE_value_info varchar(30)
declare @L2300_hi09_BE_value_info_amt money
declare @L2300_hi10_BE_value_info varchar(30)
declare @L2300_hi10_BE_value_info_amt money
declare @L2300_hi11_BE_value_info varchar(30)
declare @L2300_hi11_BE_value_info_amt money
declare @L2300_hi12_BE_value_info varchar(30)
declare @L2300_hi12_BE_value_info_amt money

declare @L2300_hi01_BG_cond_info varchar(30)
declare @L2300_hi02_BG_cond_info varchar(30)
declare @L2300_hi03_BG_cond_info varchar(30)
declare @L2300_hi04_BG_cond_info varchar(30)
declare @L2300_hi05_BG_cond_info varchar(30)
declare @L2300_hi06_BG_cond_info varchar(30)
declare @L2300_hi07_BG_cond_info varchar(30)
declare @L2300_hi08_BG_cond_info varchar(30)
declare @L2300_hi09_BG_cond_info varchar(30)
declare @L2300_hi10_BG_cond_info varchar(30)
declare @L2300_hi11_BG_cond_info varchar(30)
declare @L2300_hi12_BG_cond_info varchar(30)

declare @L2300_hi01_TC_treat_code_info varchar(30)
declare @L2300_hi02_TC_treat_code_info varchar(30)
declare @L2300_hi03_TC_treat_code_info varchar(30)
declare @L2300_hi04_TC_treat_code_info varchar(30)
declare @L2300_hi05_TC_treat_code_info varchar(30)
declare @L2300_hi06_TC_treat_code_info varchar(30)
declare @L2300_hi07_TC_treat_code_info varchar(30)
declare @L2300_hi08_TC_treat_code_info varchar(30)
declare @L2300_hi09_TC_treat_code_info varchar(30)
declare @L2300_hi10_TC_treat_code_info varchar(30)
declare @L2300_hi11_TC_treat_code_info varchar(30)
declare @L2300_hi12_TC_treat_code_info varchar(30)
	
declare @L2300_qty02_CA_claim_qty varchar(30) 
declare @L2300_qty02_CD_claim_qty varchar(30) 
declare @L2300_qty02_LA_claim_qty varchar(30) 
declare @L2300_qty02_NA_claim_qty varchar(30) 
	

declare @L2310A_nm101_entity_id_code char(3) 
declare @L2310A_nm102_entity_type_qual char(1) 
declare @L2310A_nm103_attending_prov_last_nm varchar(35) 
declare @L2310A_nm104_attending_prov_first_nm varchar(25) 
declare @L2310A_nm105_attending_prov_middle_nm varchar(25) 
declare @L2310A_nm107_attending_prov_suffix varchar(10) 
declare @L2310A_nm108_id_code_qual char(2) 
declare @L2310A_nm109_attending_prov_id varchar(80) 
	
declare @L2310A_prv01_provider_code char(3) 
declare @L2310A_prv02_ref_id_qual char(3) 
declare @L2310A_prv03_taxonomy_code varchar(30) 
	
declare @L2310A_ref02_1C_attending_prov_id varchar(30) 
declare @L2310A_ref02_1D_attending_prov_id varchar(30) 
declare @L2310A_ref02_1G_attending_prov_id varchar(30) 
declare @L2310A_ref02_EI_attending_prov_id varchar(30) 
declare @L2310A_ref02_SY_attending_prov_id varchar(30) 
declare @L2310A_ref02_FH_attending_prov_id varchar(30) 
	
declare @L2310B_nm102_entity_type_qual char(1) 
declare @L2310B_nm103_operating_prov_last_nm varchar(35) 
declare @L2310B_nm104_operating_prov_first_nm varchar(25) 
declare @L2310B_nm105_operating_prov_middle_nm varchar(25) 
declare @L2310B_nm107_operating_prov_suffix varchar(10) 
declare @L2310B_nm108_id_code_qual char(2) 
declare @L2310B_nm109_operating_prov_id varchar(80) 
		
declare @L2310B_ref02_1C_operating_prov_id varchar(30) 
declare @L2310B_ref02_1D_operating_prov_id varchar(30) 
declare @L2310B_ref02_1G_operating_prov_id varchar(30) 
declare @L2310B_ref02_EI_operating_prov_id varchar(30) 
declare @L2310B_ref02_SY_operating_prov_id varchar(30) 
declare @L2310B_ref02_FH_operating_prov_id varchar(30) 

---check on this other provider may be wrong in the HIPAA guide
declare @L2310C_nm102_entity_type_qual char(1) 
declare @L2310C_nm103_other_prov_last_nm varchar(35) 
declare @L2310C_nm104_other_prov_first_nm varchar(25) 
declare @L2310C_nm105_other_prov_middle_nm varchar(25) 
declare @L2310C_nm107_other_prov_suffix varchar(10) 
declare @L2310C_nm108_id_code_qual char(2) 
declare @L2310C_nm109_other_prov_id varchar(80) 
		
declare @L2310C_ref02_1C_other_prov_id varchar(30) 
declare @L2310C_ref02_1D_other_prov_id varchar(30) 
declare @L2310C_ref02_1G_other_prov_id varchar(30) 
declare @L2310C_ref02_EI_other_prov_id varchar(30) 
declare @L2310C_ref02_SY_other_prov_id varchar(30) 
declare @L2310C_ref02_FH_other_prov_id varchar(30) 
	
declare @L2310E_nm101_entity_id_code char(3) 
declare @L2310E_nm102_entity_type_qual char(1) 
declare @L2310E_nm103_service_facility_last_nm varchar(35) 
declare @L2310E_nm108_id_code_qual char(2) 
declare @L2310E_nm109_service_facility_id varchar(80) 
	
declare @L2310E_n301_service_facility_address1 varchar(55) 
declare @L2310E_n302_service_facility_address2 varchar(55) 
	
declare @L2310E_n401_service_facility_city varchar(30) 
declare @L2310E_n402_service_facility_state char(2) 
declare @L2310E_n403_service_facility_zip varchar(15) 
declare @L2310E_n404_service_facility_country char(3) 
	
declare @L2310E_ref02_1C_service_facility_id varchar(30) 
declare @L2310E_ref02_1D_service_facility_id varchar(30) 
declare @L2310E_ref02_1G_service_facility_id varchar(30) 
declare @L2310E_ref02_G2_service_facility_id varchar(30) 

declare @L2320_1_sbr01_payer_resp_seq_code char(1)
declare @L2320_1_sbr02_ind_relationship_code char(2)
declare @L2320_1_sbr03_insured_grp_policy_num varchar(30)
declare @L2320_1_sbr04_insured_grp_nm varchar(60)
declare @L2320_1_sbr09_claim_file_ind_code char(3)
declare @L2320_1_cas01_adjustment_group_code char(2)
declare @L2320_1_cas02_adjustment_reason_code varchar(5)
declare @L2320_1_cas03_adjustment_amt money
declare @L2320_1_cas04_adjustment_qty varchar(15)
declare @L2320_1_cas05_adjustment_reason_code varchar(5)
declare @L2320_1_cas06_adjustment_amt money
declare @L2320_1_cas07_adjustment_qty varchar(15)
declare @L2320_1_cas08_adjustment_reason_code varchar(5)
declare @L2320_1_cas09_adjustment_amt money
declare @L2320_1_cas10_adjustment_qty varchar(15)
declare @L2320_1_amt02_C4_payer_prior_pmt_amt money
declare @L2320_1_amt02_B6_cob_allowed_amt money
declare @L2320_1_amt02_T3_cob_submitted_amt money
declare @L2320_1_amt02_ZZ_drg_outlier_amt money
declare @L2320_1_amt02_N1_cob_medicare_paid_amt money
declare @L2320_1_amt02_KF_medicare_paid_100_amt money
declare @L2320_1_amt02_PG_medicare_paid_80_amt money
declare @L2320_1_amt02_AA_cob_medicare_a_trust_pd_amt money
declare @L2320_1_amt02_B1_cob_medicare_b_trust_pd_amt money
declare @L2320_1_amt02_A8_cob_non_cvd_amt money
declare @L2320_1_amt02_YT_cob_denied_amt money
declare @L2320_1_dmg02_other_subscriber_dob varchar(35)
declare @L2320_1_dmg03_other_subscriber_gender char(1)
declare @L2320_1_oi03_other_ins_benefit_assign_ind char(10)
declare @L2320_1_oi06_other_ins_release_of_info_code char(10)
declare @L2330A_1_nm101_entity_id_code char(3)
declare @L2330A_1_nm102_entity_type_qual varchar(35)
declare @L2330A_1_nm103_other_subscriber_last_name varchar(35)
declare @L2330A_1_nm104_other_subscriber_first_name varchar(25)
declare @L2330A_1_nm105_other_subscriber_middle_name varchar(25)
declare @L2330A_1_nm107_other_subscriber_name_suffix varchar(10)
declare @L2330A_1_nm108_other_subscriber_id_code_qual char(2)
declare @L2330A_1_nm109_other_subscriber_id varchar(80)
declare @L2330B_1_nm101_entity_id_code char(3)
declare @L2330B_1_nm102_entity_type_qual char(1)
declare @L2330B_1_nm103_other_payer_nm varchar(35)
declare @L2330B_1_nm108_id_code_qual char(2)
declare @L2330B_1_nm109_other_payer_id varchar(80)
declare @L2330B_1_dtp03_573_date_claim_paid varchar(35)
declare @L2330B_1_ref02_2U_other_payer_secondary_id varchar(30)
declare @L2330B_1_ref02_F8_other_payer_secondary_id varchar(30)
declare @L2330B_1_ref02_FY_other_payer_secondary_id varchar(30)
declare @L2330B_1_ref02_NF_other_payer_secondary_id varchar(30)
declare @L2330B_1_ref02_TJ_other_payer_secondary_id varchar(30)
declare @L2330B_1_ref02_9F_other_payer_auth_num varchar(30)
declare @L2330B_1_ref02_G1_other_payer_auth_num varchar(30)

declare @L2320_2_sbr01_payer_resp_seq_code char(1)
declare @L2320_2_sbr02_ind_relationship_code char(2)
declare @L2320_2_sbr03_insured_grp_policy_num varchar(30)
declare @L2320_2_sbr04_insured_grp_nm varchar(60)
declare @L2320_2_sbr09_claim_file_ind_code char(3)
declare @L2320_2_cas01_adjustment_group_code char(2)
declare @L2320_2_cas02_adjustment_reason_code varchar(5)
declare @L2320_2_cas03_adjustment_amt money
declare @L2320_2_cas04_adjustment_qty varchar(15)
declare @L2320_2_cas05_adjustment_reason_code varchar(5)
declare @L2320_2_cas06_adjustment_amt money
declare @L2320_2_cas07_adjustment_qty varchar(15)
declare @L2320_2_cas08_adjustment_reason_code varchar(5)
declare @L2320_2_cas09_adjustment_amt money
declare @L2320_2_cas10_adjustment_qty varchar(15)
declare @L2320_2_amt02_C4_payer_prior_pmt_amt money
declare @L2320_2_amt02_B6_cob_allowed_amt money
declare @L2320_2_amt02_T3_cob_submitted_amt money
declare @L2320_2_amt02_ZZ_drg_outlier_amt money
declare @L2320_2_amt02_N1_cob_medicare_paid_amt money
declare @L2320_2_amt02_KF_medicare_paid_100_amt money
declare @L2320_2_amt02_PG_medicare_paid_80_amt money
declare @L2320_2_amt02_AA_cob_medicare_a_trust_pd_amt money
declare @L2320_2_amt02_B1_cob_medicare_b_trust_pd_amt money
declare @L2320_2_amt02_A8_cob_non_cvd_amt money
declare @L2320_2_amt02_YT_cob_denied_amt money
declare @L2320_2_dmg02_other_subscriber_dob varchar(35)
declare @L2320_2_dmg03_other_subscriber_gender char(1)
declare @L2320_2_oi03_other_ins_benefit_assign_ind char(10)
declare @L2320_2_oi06_other_ins_release_of_info_code char(10)
declare @L2330A_2_nm101_entity_id_code char(3)
declare @L2330A_2_nm102_entity_type_qual varchar(35)
declare @L2330A_2_nm103_other_subscriber_last_name varchar(35)
declare @L2330A_2_nm104_other_subscriber_first_name varchar(25)
declare @L2330A_2_nm105_other_subscriber_middle_name varchar(25)
declare @L2330A_2_nm107_other_subscriber_name_suffix varchar(10)
declare @L2330A_2_nm108_other_subscriber_id_code_qual char(2)
declare @L2330A_2_nm109_other_subscriber_id varchar(80)
declare @L2330B_2_nm101_entity_id_code char(3)
declare @L2330B_2_nm102_entity_type_qual char(1)
declare @L2330B_2_nm103_other_payer_nm varchar(35)
declare @L2330B_2_nm108_id_code_qual char(2)
declare @L2330B_2_nm109_other_payer_id varchar(80)
declare @L2330B_2_dtp03_573_date_claim_paid varchar(35)
declare @L2330B_2_ref02_2U_other_payer_secondary_id varchar(30)
declare @L2330B_2_ref02_F8_other_payer_secondary_id varchar(30)
declare @L2330B_2_ref02_FY_other_payer_secondary_id varchar(30)
declare @L2330B_2_ref02_NF_other_payer_secondary_id varchar(30)
declare @L2330B_2_ref02_TJ_other_payer_secondary_id varchar(30)
declare @L2330B_2_ref02_9F_other_payer_auth_num varchar(30)
declare @L2330B_2_ref02_G1_other_payer_auth_num varchar(30)

declare @L2320_3_sbr01_payer_resp_seq_code char(1)
declare @L2320_3_sbr02_ind_relationship_code char(2)
declare @L2320_3_sbr03_insured_grp_policy_num varchar(30)
declare @L2320_3_sbr04_insured_grp_nm varchar(60)
declare @L2320_3_sbr09_claim_file_ind_code char(3)
declare @L2320_3_cas01_adjustment_group_code char(2)
declare @L2320_3_cas02_adjustment_reason_code varchar(5)
declare @L2320_3_cas03_adjustment_amt money
declare @L2320_3_cas04_adjustment_qty varchar(15)
declare @L2320_3_cas05_adjustment_reason_code varchar(5)
declare @L2320_3_cas06_adjustment_amt money
declare @L2320_3_cas07_adjustment_qty varchar(15)
declare @L2320_3_cas08_adjustment_reason_code varchar(5)
declare @L2320_3_cas09_adjustment_amt money
declare @L2320_3_cas10_adjustment_qty varchar(15)
declare @L2320_3_amt02_C4_payer_prior_pmt_amt money
declare @L2320_3_amt02_B6_cob_allowed_amt money
declare @L2320_3_amt02_T3_cob_submitted_amt money
declare @L2320_3_amt02_ZZ_drg_outlier_amt money
declare @L2320_3_amt02_N1_cob_medicare_paid_amt money
declare @L2320_3_amt02_KF_medicare_paid_100_amt money
declare @L2320_3_amt02_PG_medicare_paid_80_amt money
declare @L2320_3_amt02_AA_cob_medicare_a_trust_pd_amt money
declare @L2320_3_amt02_B1_cob_medicare_b_trust_pd_amt money
declare @L2320_3_amt02_A8_cob_non_cvd_amt money
declare @L2320_3_amt02_YT_cob_denied_amt money
declare @L2320_3_dmg02_other_subscriber_dob varchar(35)
declare @L2320_3_dmg03_other_subscriber_gender char(1)
declare @L2320_3_oi03_other_ins_benefit_assign_ind char(10)
declare @L2320_3_oi06_other_ins_release_of_info_code char(10)
declare @L2330A_3_nm101_entity_id_code char(3)
declare @L2330A_3_nm102_entity_type_qual varchar(35)
declare @L2330A_3_nm103_other_subscriber_last_name varchar(35)
declare @L2330A_3_nm104_other_subscriber_first_name varchar(25)
declare @L2330A_3_nm105_other_subscriber_middle_name varchar(25)
declare @L2330A_3_nm107_other_subscriber_name_suffix varchar(10)
declare @L2330A_3_nm108_other_subscriber_id_code_qual char(2)
declare @L2330A_3_nm109_other_subscriber_id varchar(80)
declare @L2330B_3_nm101_entity_id_code char(3)
declare @L2330B_3_nm102_entity_type_qual char(1)
declare @L2330B_3_nm103_other_payer_nm varchar(35)
declare @L2330B_3_nm108_id_code_qual char(2)
declare @L2330B_3_nm109_other_payer_id varchar(80)
declare @L2330B_3_dtp03_573_date_claim_paid varchar(35)
declare @L2330B_3_ref02_2U_other_payer_secondary_id varchar(30)
declare @L2330B_3_ref02_F8_other_payer_secondary_id varchar(30)
declare @L2330B_3_ref02_FY_other_payer_secondary_id varchar(30)
declare @L2330B_3_ref02_NF_other_payer_secondary_id varchar(30)
declare @L2330B_3_ref02_TJ_other_payer_secondary_id varchar(30)
declare @L2330B_3_ref02_9F_other_payer_auth_num varchar(30)
declare @L2330B_3_ref02_G1_other_payer_auth_num varchar(30)

declare @L2400_lx01_assigned_num varchar(6) 
declare @L2400_sv201_rev_code varchar(48) 
declare @L2400_sv202_proc_code_qual char(2) 
declare @L2400_sv202_proc_code varchar(48) 
declare @L2400_sv202_proc_mod1 char(2) 
declare @L2400_sv202_proc_mod2 char(2) 
declare @L2400_sv202_proc_mod3 char(2) 
declare @L2400_sv202_proc_mod4 char(2) 
declare @L2400_sv203_line_charge money
declare @L2400_sv204_measurement_code char(2) 
declare @L2400_sv205_service_unit_count varchar(15) 
declare @L2400_sv206_service_line_rate varchar(10) 
declare @L2400_sv207_denied_amt money 
	
declare @L2400_dtp02_472_from_service_date varchar(35) 
declare @L2400_dtp02_472_to_service_date varchar(35) 

declare @L2400_dtp02_866_format_qual char(3) 
declare @L2400_dtp02_866_assess_date varchar(35) 

DECLARE @L2410_1_lin03_N4_ndc VARCHAR(48)
		
declare @L2420A_nm102_entity_type_qual char(1) 
declare @L2420A_nm103_attending_physician_last_nm varchar(35) 
declare @L2420A_nm104_attending_physician_first_nm varchar(25) 
declare @L2420A_nm105_attending_physician_middle_nm varchar(25) 
declare @L2420A_nm107_attending_physician_suffix varchar(10) 
declare @L2420A_nm108_id_code_qual char(2) 
declare @L2420A_nm109_attending_physician_id varchar(80) 

declare @L2420A_ref02_1C_attending_prov_id varchar(30) 
declare @L2420A_ref02_1D_attending_prov_id varchar(30) 
declare @L2420A_ref02_1G_attending_prov_id varchar(30) 
declare @L2420A_ref02_EI_attending_prov_id varchar(30) 
declare @L2420A_ref02_SY_attending_prov_id varchar(30) 
declare @L2420A_ref02_FH_attending_prov_id varchar(30) 

declare @L2420B_nm102_entity_type_qual char(1) 
declare @L2420B_nm103_operating_prov_last_nm varchar(35) 
declare @L2420B_nm104_operating_prov_first_nm varchar(25) 
declare @L2420B_nm105_operating_prov_middle_nm varchar(25) 
declare @L2420B_nm107_operating_prov_suffix varchar(10) 
declare @L2420B_nm108_id_code_qual char(2) 
declare @L2420B_nm109_operating_prov_id varchar(80) 

declare @L2420B_ref02_1C_operating_prov_id varchar(30) 
declare @L2420B_ref02_1D_operating_prov_id varchar(30) 
declare @L2420B_ref02_1G_operating_prov_id varchar(30) 
declare @L2420B_ref02_EI_operating_prov_id varchar(30) 
declare @L2420B_ref02_SY_operating_prov_id varchar(30) 
declare @L2420B_ref02_FH_operating_prov_id varchar(30) 

declare @L2420C_nm102_entity_type_qual char(1) 
declare @L2420C_nm103_other_prov_last_nm varchar(35) 
declare @L2420C_nm104_other_prov_first_nm varchar(25) 
declare @L2420C_nm105_other_prov_middle_nm varchar(25) 
declare @L2420C_nm107_other_prov_suffix varchar(10) 
declare @L2420C_nm108_id_code_qual char(2) 
declare @L2420C_nm109_other_prov_id varchar(80) 	

declare @L2420C_ref02_1C_other_prov_id varchar(30) 
declare @L2420C_ref02_1D_other_prov_id varchar(30) 
declare @L2420C_ref02_1G_other_prov_id varchar(30) 
declare @L2420C_ref02_G2_other_prov_id varchar(30) 
declare @L2420C_ref02_EI_other_prov_id varchar(30) 
declare @L2420C_ref02_SY_other_prov_id varchar(30) 
declare @L2420C_ref02_FH_other_prov_id varchar(30) 
			
declare @L2430_svd01_payer_id varchar(80) 
declare @L2430_svd02_service_line_paid money
declare @L2430_svd03_proc_code_qual char(2) 
declare @L2430_svd03_proc_code varchar(48) 
declare @L2430_svd03_proc_mod1 char(2) 
declare @L2430_svd03_proc_mod2 char(2) 
declare @L2430_svd03_proc_mod3 char(2) 
declare @L2430_svd03_proc_mod4 char(2) 
declare @L2430_svd03_proc_code_desc VARCHAR(80)
declare @L2430_svd04_rev_code varchar(48) 
declare @L2430_svd05_adj_qty varchar(15) 
declare @L2430_svd06_bundled_line_num varchar(6) 

declare @L2430_cas01_adjustment_group_code char(2) 
declare @L2430_cas02_adjustment_reason_code varchar(5) 
declare @L2430_cas03_adjustment_amt money 
declare @L2430_cas04_adjustment_qty varchar(15) 
declare @L2430_cas05_adjustment_reason_code varchar(5) 
declare @L2430_cas06_adjustment_amt money 
declare @L2430_cas07_adjustment_qty varchar(15) 
declare @L2430_cas08_adjustment_reason_code varchar(5) 
declare @L2430_cas09_adjustment_amt money 
declare @L2430_cas10_adjustment_qty varchar(15) 

declare @L2430_1_cas01_adjustment_group_code char(3)
declare @L2430_1_cas02_adjustment_reason_code varchar(15)
declare @L2430_1_cas03_adjustment_amt money
declare @L2430_1_cas04_adjustment_qty varchar(15)
declare @L2430_1_cas05_adjustment_reason_code varchar(15)
declare @L2430_1_cas06_adjustment_amt money
declare @L2430_1_cas07_adjustment_qty varchar(15)
declare @L2430_1_cas08_adjustment_reason_code varchar(15)
declare @L2430_1_cas09_adjustment_amt money
declare @L2430_1_cas10_adjustment_qty varchar(15)
declare @L2430_1_cas11_adjustment_reason_code varchar(15)
declare @L2430_1_cas12_adjustment_amt money
declare @L2430_1_cas13_adjustment_qty varchar(15)
declare @L2430_1_cas14_adjustment_reason_code varchar(15)
declare @L2430_1_cas15_adjustment_amt money
declare @L2430_1_cas16_adjustment_qty varchar(15)
declare @L2430_1_cas17_adjustment_reason_code varchar(15)
declare @L2430_1_cas18_adjustment_amt money
declare @L2430_1_cas19_adjustment_qty varchar(15)
declare @L2430_2_cas01_adjustment_group_code char(3)
declare @L2430_2_cas02_adjustment_reason_code varchar(15)
declare @L2430_2_cas03_adjustment_amt money
declare @L2430_2_cas04_adjustment_qty varchar(15)
declare @L2430_2_cas05_adjustment_reason_code varchar(15)
declare @L2430_2_cas06_adjustment_amt money
declare @L2430_2_cas07_adjustment_qty varchar(15)
declare @L2430_2_cas08_adjustment_reason_code varchar(15)
declare @L2430_2_cas09_adjustment_amt money
declare @L2430_2_cas10_adjustment_qty varchar(15)
declare @L2430_2_cas11_adjustment_reason_code varchar(15)
declare @L2430_2_cas12_adjustment_amt money
declare @L2430_2_cas13_adjustment_qty varchar(15)
declare @L2430_2_cas14_adjustment_reason_code varchar(15)
declare @L2430_2_cas15_adjustment_amt money
declare @L2430_2_cas16_adjustment_qty varchar(15)
declare @L2430_2_cas17_adjustment_reason_code varchar(15)
declare @L2430_2_cas18_adjustment_amt money
declare @L2430_2_cas19_adjustment_qty varchar(15)
declare @L2430_3_cas01_adjustment_group_code char(3)
declare @L2430_3_cas02_adjustment_reason_code varchar(15)
declare @L2430_3_cas03_adjustment_amt money
declare @L2430_3_cas04_adjustment_qty varchar(15)
declare @L2430_3_cas05_adjustment_reason_code varchar(15)
declare @L2430_3_cas06_adjustment_amt money
declare @L2430_3_cas07_adjustment_qty varchar(15)
declare @L2430_3_cas08_adjustment_reason_code varchar(15)
declare @L2430_3_cas09_adjustment_amt money
declare @L2430_3_cas10_adjustment_qty varchar(15)
declare @L2430_3_cas11_adjustment_reason_code varchar(15)
declare @L2430_3_cas12_adjustment_amt money
declare @L2430_3_cas13_adjustment_qty varchar(15)
declare @L2430_3_cas14_adjustment_reason_code varchar(15)
declare @L2430_3_cas15_adjustment_amt money
declare @L2430_3_cas16_adjustment_qty varchar(15)
declare @L2430_3_cas17_adjustment_reason_code varchar(15)
declare @L2430_3_cas18_adjustment_amt money
declare @L2430_3_cas19_adjustment_qty varchar(15)
declare @L2430_4_cas01_adjustment_group_code char(3)
declare @L2430_4_cas02_adjustment_reason_code varchar(15)
declare @L2430_4_cas03_adjustment_amt money
declare @L2430_4_cas04_adjustment_qty varchar(15)
declare @L2430_4_cas05_adjustment_reason_code varchar(15)
declare @L2430_4_cas06_adjustment_amt money
declare @L2430_4_cas07_adjustment_qty varchar(15)
declare @L2430_4_cas08_adjustment_reason_code varchar(15)
declare @L2430_4_cas09_adjustment_amt money
declare @L2430_4_cas10_adjustment_qty varchar(15)
declare @L2430_4_cas11_adjustment_reason_code varchar(15)
declare @L2430_4_cas12_adjustment_amt money
declare @L2430_4_cas13_adjustment_qty varchar(15)
declare @L2430_4_cas14_adjustment_reason_code varchar(15)
declare @L2430_4_cas15_adjustment_amt money
declare @L2430_4_cas16_adjustment_qty varchar(15)
declare @L2430_4_cas17_adjustment_reason_code varchar(15)
declare @L2430_4_cas18_adjustment_amt money
declare @L2430_4_cas19_adjustment_qty varchar(15)
declare @L2430_5_cas01_adjustment_group_code char(3)
declare @L2430_5_cas02_adjustment_reason_code varchar(15)
declare @L2430_5_cas03_adjustment_amt money
declare @L2430_5_cas04_adjustment_qty varchar(15)
declare @L2430_5_cas05_adjustment_reason_code varchar(15)
declare @L2430_5_cas06_adjustment_amt money
declare @L2430_5_cas07_adjustment_qty varchar(15)
declare @L2430_5_cas08_adjustment_reason_code varchar(15)
declare @L2430_5_cas09_adjustment_amt money
declare @L2430_5_cas10_adjustment_qty varchar(15)
declare @L2430_5_cas11_adjustment_reason_code varchar(15)
declare @L2430_5_cas12_adjustment_amt money
declare @L2430_5_cas13_adjustment_qty varchar(15)
declare @L2430_5_cas14_adjustment_reason_code varchar(15)
declare @L2430_5_cas15_adjustment_amt money
declare @L2430_5_cas16_adjustment_qty varchar(15)
declare @L2430_5_cas17_adjustment_reason_code varchar(15)
declare @L2430_5_cas18_adjustment_amt money
declare @L2430_5_cas19_adjustment_qty varchar(15)

declare @L2430_dtp03_573_service_adjudication_date varchar(35)
-- END: DECLARE 837i Variables

-- BEGIN: DECLARE PREV_ 837i Variables
declare @prev_bht01_hierarchical_structure_code char(4) 
declare @prev_bht02_trans_set_purpose_code char(2) 
declare @prev_bht03_orig_app_tran_id varchar(30) 
declare @prev_bht04_trans_set_creation_date varchar(8) 
declare @prev_bht05_trans_set_creation_time varchar(8) 
declare @prev_bht06_claim_encounter_id char(2) 
	
declare @prev_ref01_receiver_ref_id_qual char(3) 
declare @prev_ref02_transmission_type_code varchar(30) 
	
declare @prev_L1000A_nm103_submitter_last_nm varchar(35) 
declare @prev_L1000B_nm103_receiver_last_nm varchar(35) 


declare @prev_L1000B_nm108_receiver_id_qual char(2) 
declare @prev_L1000B_nm109_receiver_id varchar(80) 
	
declare @prev_L2000A_hl01_hierarchical_id_num varchar(12) 
declare @prev_L2000A_hl03_hierarchical_level_code char(2) 
declare @prev_L2000A_hl04_hierarchical_child_code char(1) 

declare @prev_L2010AA_nm103_billing_prov_last_nm varchar(35)
declare @prev_L2010AA_nm104_billing_prov_first_nm varchar(25)
declare @prev_L2010AA_nm105_billing_prov_middle_nm varchar(25)
declare @prev_L2010AA_nm107_billing_prov_suffix varchar(10)
declare @prev_L2010AA_nm108_id_code_qual char(2)
declare @prev_L2010AA_nm109_billing_prov_id varchar(80)
declare @prev_L2010AA_n301_billing_prov_address1 varchar(55)
declare @prev_L2010AA_n302_billing_prov_address2 varchar(55)
declare @prev_L2010AA_n401_billing_prov_city varchar(30)
declare @prev_L2010AA_n402_billing_prov_state char(2)
declare @prev_L2010AA_n403_billing_prov_zip varchar(15)
declare @prev_L2010AA_n404_billing_prov_country char(3)
declare @prev_L2010AA_ref02_1C_billing_prov_id varchar(30)
declare @prev_L2010AA_ref02_1D_billing_prov_id varchar(30)
declare @prev_L2010AA_ref02_1G_billing_prov_id varchar(30)
declare @prev_L2010AA_ref02_EI_billing_prov_id varchar(30)
declare @prev_L2010AA_ref02_SY_billing_prov_id varchar(30)
declare @prev_L2010AA_ref02_FH_billing_prov_id varchar(30)
	
declare @prev_L2000B_hl01_hierarchical_id_num varchar(12) 
declare @prev_L2000B_hl02_hierarchical_parent_id_num varchar(12) 
declare @prev_L2000B_hl03_hierarchical_level_code char(2) 
declare @prev_L2000B_hl04_hierarchical_child_code char(1) 
	
declare @prev_L2000B_sbr01_payer_resp_seq_code char(1)
declare @prev_L2000B_sbr02_ind_relationship_code char(2)
declare @prev_L2000B_sbr03_insured_grp_policy_num varchar(30)
declare @prev_L2000B_sbr04_insured_grp_nm varchar(60)
declare @prev_L2000B_sbr09_claim_id_code char(2)
declare @prev_L2010BA_nm102_entity_type_qual char(1)
declare @prev_L2010BA_nm103_subscriber_last_nm varchar(35)
declare @prev_L2010BA_nm104_subscriber_first_nm varchar(25)
declare @prev_L2010BA_nm105_subscriber_middle_nm varchar(25)
declare @prev_L2010BA_nm107_subscriber_suffix varchar(10)
declare @prev_L2010BA_nm108_id_code_qual char(2)
declare @prev_L2010BA_nm109_subscriber_id varchar(80)
declare @prev_L2010BA_n301_subscriber_address1 varchar(55)
declare @prev_L2010BA_n302_subscriber_address2 varchar(55)
declare @prev_L2010BA_n401_subscriber_city varchar(30)
declare @prev_L2010BA_n402_subscriber_state char(2)
declare @prev_L2010BA_n403_subscriber_zip varchar(15)

declare @prev_L2000C_hl01_hierarchical_id_num varchar(12) 
declare @prev_L2000C_hl02_hierarchical_parent_id_num varchar(12) 
declare @prev_L2000C_hl03_hierarchical_level_code char(2) 
declare @prev_L2000C_hl04_hierarchical_child_code char(1) 

declare @prev_L2010CA_nm102_entity_type_qual char(1) 
declare @prev_L2010CA_nm103_patient_last_nm varchar(35) 
declare @prev_L2010CA_nm104_patient_first_nm varchar(25) 
declare @prev_L2010CA_nm105_patient_middle_nm varchar(25) 
declare @prev_L2010CA_nm107_patient_suffix varchar(10) 
declare @prev_L2010CA_nm108_id_code_qual char(2) 
declare @prev_L2010CA_nm109_patient_id varchar(80) 

declare @prev_L2300_clm01_pt_acct_num varchar(38) 
declare @prev_L2300_clm02_total_claim_chg_amt money 
declare @prev_L2300_ref02_F8_original_ref_num varchar(30) 

declare @prev_L2330B_1_ref02_F8_other_payer_secondary_id varchar(30)
declare @prev_L2330B_2_ref02_F8_other_payer_secondary_id varchar(30)
declare @prev_L2330B_3_ref02_F8_other_payer_secondary_id varchar(30)

declare @prev_L2400_lx01_assigned_num varchar(6) 

DECLARE @prev_L2410_1_lin03_N4_ndc VARCHAR(48)

-- END: DECLARE PREV_ 837i Variables

declare @x12_interchange_uid uniqueidentifier
declare @patdeathdate as varchar(3)

declare @global_hl01_hierarchical_id_num int

--BEGIN: Initialize transaction variables here.
set @global_hl01_hierarchical_id_num = 0
set @prev_L2000A_hl01_hierarchical_id_num = 0
set @prev_L2000B_hl01_hierarchical_id_num = 0
set @prev_L2000C_hl01_hierarchical_id_num = 0
set @segment_count = 0

declare @pre_segment_count int
set @pre_segment_count = 0
--set @trn01_trace_type_code = '1' 
--set @L2000_LX01_assigned_number = 0

-- Set the x12_interchange_uid value of the 837i transaction that's being exported.
select @x12_interchange_uid = x12_interchange_uid
from vw_x12_transaction
where x12_transaction_id = @x12_transaction_id
-- END: Initialize transaction variables.

-- Count up all the segments before inserting this transaction (exclude the transaction header segments).
-- We do this beforehand because otherwise we wouldn't be able to count them accurately,
-- the x12_parse_temp table doesn't records track by transaction.
select @pre_segment_count = count(x12_parse_temp_id)
from x12_parse_temp
where	col001 NOT IN ('ISA', 'GS', 'ST', 'IEA', 'GE', 'SE') AND
	x12_parse_temp_uid = @x12_interchange_uid

declare @errmsg varchar(250)
declare @errcode int
 --delcare the cursor

DECLARE curtx12doc SCROLL CURSOR FOR
	SELECT	x12_transaction_id,
		bht01_hierarchical_structure_code,
		bht02_trans_set_purpose_code,
		bht03_orig_app_tran_id,
		bht04_trans_set_creation_date,
		bht05_trans_set_creation_time,
		bht06_claim_encounter_id,
		ref01_receiver_ref_id_qual,
		ref02_transmission_type_code,
		L1000A_nm102_entity_type_qual,
		L1000A_nm103_submitter_last_nm,
		L1000A_nm104_submitter_first_nm,
		L1000A_nm105_submitter_middle_nm,
		L1000A_nm108_submitter_id_qual,
		L1000A_nm109_submitter_id,
		L1000A_per01_contact_function_code,
		L1000A_per02_contact_nm,
		L1000A_per03_comm_num_qual,
		L1000A_per04_comm_number,
		L1000B_nm102_entity_type_qual,
		L1000B_nm103_receiver_last_nm,
		L1000B_nm108_receiver_id_qual,
		L1000B_nm109_receiver_id,
		L2000A_hl01_hierarchical_id_num, 
		L2000A_hl03_hierarchical_level_code,
		L2000A_hl04_hierarchical_child_code,
		L2000A_prv01_provider_code,
		L2000A_prv02_ref_id_qual,
		L2000A_prv03_taxonomy_code,
		L2000A_cur02_currency_code,
		L2010AA_nm102_entity_type_qual,
		L2010AA_nm103_billing_prov_last_nm,
		L2010AA_nm104_billing_prov_first_nm,
		L2010AA_nm105_billing_prov_middle_nm,
		L2010AA_nm107_billing_prov_suffix,
		L2010AA_nm108_id_code_qual,
		L2010AA_nm109_billing_prov_id,
		L2010AA_n301_billing_prov_address1,
		L2010AA_n302_billing_prov_address2,
		L2010AA_n401_billing_prov_city,
		L2010AA_n402_billing_prov_state,
		L2010AA_n403_billing_prov_zip,
		L2010AA_n404_billing_prov_country,
		L2010AA_ref02_1B_billing_prov_id,
		L2010AA_ref02_1C_billing_prov_id,
		L2010AA_ref02_1D_billing_prov_id,
		L2010AA_ref02_1G_billing_prov_id,
		L2010AA_ref02_EI_billing_prov_id,
		L2010AA_ref02_SY_billing_prov_id,
		L2010AA_ref02_FH_billing_prov_id,
		L2010AA_ref02_06_card_billing_id,
		L2010AA_ref02_8U_card_billing_id,
		L2010AA_ref02_EM_card_billing_id,
		L2010AA_ref02_IJ_card_billing_id,
		L2010AA_ref02_LU_card_billing_id,
		L2010AA_ref02_ST_card_billing_id,
		L2010AA_per01_billing_prov_comm_func_code,
		L2010AA_per02_billing_prov_contact_nm,
		L2010AA_per03_billing_prov_comm_num_qual,
		L2010AA_per04_billing_prov_comm,
		L2010AB_nm102_entity_type_qual,
		L2010AB_nm103_payto_prov_last_nm,
		L2010AB_nm104_payto_prov_first_nm,
		L2010AB_nm105_payto_prov_middle_nm,
		L2010AB_nm107_payto_prov_suffix,
		L2010AB_nm108_id_code_qual,
		L2010AB_nm109_payto_prov_id,
		L2010AB_n301_payto_prov_address1,
		L2010AB_n302_payto_prov_address2,
		L2010AB_n401_payto_prov_city,
		L2010AB_n402_payto_prov_state,
		L2010AB_n403_payto_prov_zip,
		L2010AB_n404_payto_prov_country,
		L2010AB_ref02_1C_payto_prov_id,
		L2010AB_ref02_1D_payto_prov_id,
		L2010AB_ref02_1G_payto_prov_id,
		L2010AB_ref02_EI_payto_prov_id,
		L2010AB_ref02_SY_payto_prov_id,
		L2010AB_ref02_FH_payto_prov_id,
		L2000B_hl01_hierarchical_id_num, 
		L2000B_hl02_hierarchical_parent_id_num, 
		L2000B_hl03_hierarchical_level_code,
		L2000B_hl04_hierarchical_child_code,
		L2000B_sbr01_payer_resp_seq_code,
		L2000B_sbr02_ind_relationship_code,
		L2000B_sbr03_insured_grp_policy_num,
		L2000B_sbr04_insured_grp_nm,
		L2000B_sbr09_claim_id_code,
		L2000B_pat06_insured_ind_death_date,
		L2000B_pat08_patient_weight,
		L2000B_pat09_pregnancy_indicator,
		L2010BA_nm102_entity_type_qual,
		L2010BA_nm103_subscriber_last_nm,
		L2010BA_nm104_subscriber_first_nm,
		L2010BA_nm105_subscriber_middle_nm,
		L2010BA_nm107_subscriber_suffix,
		L2010BA_nm108_id_code_qual,
		L2010BA_nm109_subscriber_id,
		L2010BA_n301_subscriber_address1,
		L2010BA_n302_subscriber_address2,
		L2010BA_n401_subscriber_city,
		L2010BA_n402_subscriber_state,
		L2010BA_n403_subscriber_zip,
		L2010BA_n404_subscriber_country,
		L2010BA_dmg02_subscriber_dob,
		L2010BA_dmg03_subscriber_gender,
		L2010BA_ref02_1W_subscriber_sup_id,
		L2010BA_ref02_23_subscriber_sup_id,
		L2010BA_ref02_IG_subscriber_sup_id,
		L2010BA_ref02_SY_subscriber_sup_id,
		L2010BA_ref02_Y4_prop_casualty_claim_num,
		L2010BB_nm102_entity_type_qual,
		L2010BB_nm103_card_holder_last_nm,
		L2010BB_nm104_card_holder_first_nm,
		L2010BB_nm105_card_holder_middle_nm,
		L2010BB_nm107_card_holder_suffix,
		L2010BB_nm108_card_id_qual,
		L2010BB_nm109_card_num,
		L2010BB_ref02_AB_payer_id,
		L2010BB_ref02_BB_payer_id,
		L2010BC_nm102_entity_type_qual,
		L2010BC_nm103_payer_nm,
		L2010BC_nm108_payer_id_qual,
		L2010BC_nm109_payer_id,
		L2010BC_n301_payer_address1,
		L2010BC_n302_payer_address2,
		L2010BC_n401_payer_city,
		L2010BC_n402_payer_state,
		L2010BC_n403_payer_zip,
		L2010BC_n404_payer_country,
		L2010BC_ref02_2U_payer_id,
		L2010BC_ref02_FY_payer_id,
		L2010BC_ref02_NF_payer_id,
		L2010BC_ref02_TJ_payer_id,
		L2010BD_nm102_entity_type_qual,
		L2010BD_nm103_resp_party_last_nm,
		L2010BD_nm104_resp_party_first_nm,
		L2010BD_nm105_resp_party_middle_nm,
		L2010BD_nm107_resp_party_suffix,
		L2010BD_n301_resp_party_address1,
		L2010BD_n302_resp_party_address2,
		L2010BD_n401_resp_party_city,
		L2010BD_n402_resp_party_state,
		L2010BD_n403_resp_party_zip,
		L2010BD_n404_resp_party_country,
		L2000C_hl01_hierarchical_id_num, 
		L2000C_hl02_hierarchical_parent_id_num, 
		L2000C_hl03_hierarchical_level_code,
		L2000C_hl04_hierarchical_child_code,
		L2000C_pat01_ind_relationship_code,
		L2010CA_nm102_entity_type_qual,
		L2010CA_nm103_patient_last_nm,
		L2010CA_nm104_patient_first_nm,
		L2010CA_nm105_patient_middle_nm,
		L2010CA_nm107_patient_suffix,
		L2010CA_nm108_id_code_qual,
		L2010CA_nm109_patient_id,
		L2010CA_n301_patient_address1,
		L2010CA_n302_patient_address2,
		L2010CA_n401_patient_city,
		L2010CA_n402_patient_state,
		L2010CA_n403_patient_zip,
		L2010CA_n404_patient_country,
		L2010CA_dmg02_patient_dob,
		L2010CA_dmg03_patient_gender,
		L2010CA_ref02_1W_patient_sup_id,
		L2010CA_ref02_23_patient_sup_id,
		L2010CA_ref02_IG_patient_sup_id,
		L2010CA_ref02_SY_patient_sup_id,
		L2010CA_ref02_Y4_prop_casualty_claim_num,
		L2300_clm01_pt_acct_num,
		L2300_clm02_total_claim_chg_amt, 
		L2300_clm05_facility_type_code,
		L2300_clm05_facility_code_qual,
		L2300_clm05_claim_freq_code,
		L2300_clm06_provider_signature_ind,
		L2300_clm07_medicare_assign_code,
		L2300_clm08_benefit_assign_ind,
		L2300_clm09_release_of_info_code,
		L2300_clm18_explan_benefits_ind,
		L2300_clm20_delay_reason_code,
		L2300_dtp03_096_discharge_hour,
		L2300_dtp03_434_begin_statement_date,
		L2300_dtp03_434_end_statement_date,
		L2300_dtp03_435_admission_date,
		L2300_cl101_admit_type_code,
		L2300_cl102_admit_source_code,
		L2300_cl103_patient_status_code,
		L2300_pwk01_attachment_type_code,
		L2300_pwk02_attachment_trans_code,
		L2300_pwk06_attachment_control_num,
		L2300_amt02_patient_paid_amt, 
		L2300_amt02_patient_resp_amt,
		L2300_amt02_total_purchased_amt, 
		L2300_ref02_9C_adj_repriced_claim_num,
		L2300_ref02_9A_repriced_claim_num,
		L2300_ref02_D9_claim_id_clearing_house,
		L2300_ref02_DD_domcument_id,
		L2300_ref02_F8_original_ref_num,
		L2300_ref02_9F_referral_num,
		L2300_ref02_G1_prior_auth_num,
		L2300_ref02_EA_medical_record_num,
		L2300_k301_fixed_format_info,
		L2300_nte01_note_ref_code,
		L2300_nte02_claim_note_text,
		L2300_hi01_BK_diag_admit_ecode,
		L2300_hi02_BJ_diag_admit_ecode,
		L2300_hi02_ZZ_diag_admit_ecode,
		L2300_hi03_BN_diag_admit_ecode,
		L2300_hi01_DR_diag_drg,
		L2300_hi01_BF_diag_code,
		L2300_hi02_BF_diag_code,
		L2300_hi03_BF_diag_code,
		L2300_hi04_BF_diag_code,
		L2300_hi05_BF_diag_code,
		L2300_hi06_BF_diag_code,
		L2300_hi07_BF_diag_code,
		L2300_hi08_BF_diag_code,
		L2300_hi09_BF_diag_code,
		L2300_hi10_BF_diag_code,
		L2300_hi11_BF_diag_code,
		L2300_hi12_BF_diag_code,
		L2300_hi01_BR_princ_proc_info,
		L2300_hi01_BR_princ_proc_info_date,
		L2300_hi01_BQ_other_proc_info,
		L2300_hi01_BQ_other_proc_info_date,
		L2300_hi02_BQ_other_proc_info,
		L2300_hi02_BQ_other_proc_info_date,
		L2300_hi03_BQ_other_proc_info,
		L2300_hi03_BQ_other_proc_info_date,
		L2300_hi04_BQ_other_proc_info,
		L2300_hi04_BQ_other_proc_info_date,
		L2300_hi05_BQ_other_proc_info,
		L2300_hi05_BQ_other_proc_info_date,
		L2300_hi06_BQ_other_proc_info,
		L2300_hi06_BQ_other_proc_info_date,
		L2300_hi07_BQ_other_proc_info,
		L2300_hi07_BQ_other_proc_info_date,
		L2300_hi08_BQ_other_proc_info,
		L2300_hi08_BQ_other_proc_info_date,
		L2300_hi09_BQ_other_proc_info,
		L2300_hi09_BQ_other_proc_info_date,
		L2300_hi10_BQ_other_proc_info,
		L2300_hi10_BQ_other_proc_info_date,
		L2300_hi11_BQ_other_proc_info,
		L2300_hi11_BQ_other_proc_info_date,
		L2300_hi12_BQ_other_proc_info,
		L2300_hi12_BQ_other_proc_info_date,
		L2300_hi01_BI_occur_span,
		L2300_hi01_BI_occur_span_date,
		L2300_hi02_BI_occur_span,
		L2300_hi02_BI_occur_span_date,
		L2300_hi03_BI_occur_span,
		L2300_hi03_BI_occur_span_date,
		L2300_hi04_BI_occur_span,
		L2300_hi04_BI_occur_span_date,
		L2300_hi05_BI_occur_span,
		L2300_hi05_BI_occur_span_date,
		L2300_hi06_BI_occur_span,
		L2300_hi06_BI_occur_span_date,
		L2300_hi07_BI_occur_span,
		L2300_hi07_BI_occur_span_date,
		L2300_hi08_BI_occur_span,
		L2300_hi08_BI_occur_span_date,
		L2300_hi09_BI_occur_span,
		L2300_hi09_BI_occur_span_date,
		L2300_hi10_BI_occur_span,
		L2300_hi10_BI_occur_span_date,
		L2300_hi11_BI_occur_span,
		L2300_hi11_BI_occur_span_date,
		L2300_hi12_BI_occur_span,
		L2300_hi12_BI_occur_span_date,
		L2300_hi01_BH_occur_info,
		L2300_hi01_BH_occur_info_date,
		L2300_hi02_BH_occur_info,
		L2300_hi02_BH_occur_info_date,
		L2300_hi03_BH_occur_info,
		L2300_hi03_BH_occur_info_date,
		L2300_hi04_BH_occur_info,
		L2300_hi04_BH_occur_info_date,
		L2300_hi05_BH_occur_info,
		L2300_hi05_BH_occur_info_date,
		L2300_hi06_BH_occur_info,
		L2300_hi06_BH_occur_info_date,
		L2300_hi07_BH_occur_info,
		L2300_hi07_BH_occur_info_date,
		L2300_hi08_BH_occur_info,
		L2300_hi08_BH_occur_info_date,
		L2300_hi09_BH_occur_info,
		L2300_hi09_BH_occur_info_date,
		L2300_hi10_BH_occur_info,
		L2300_hi10_BH_occur_info_date,
		L2300_hi11_BH_occur_info,
		L2300_hi11_BH_occur_info_date,
		L2300_hi12_BH_occur_info,
		L2300_hi12_BH_occur_info_date,
		L2300_hi01_BE_value_info,
		L2300_hi01_BE_value_info_amt,
		L2300_hi02_BE_value_info,
		L2300_hi02_BE_value_info_amt,
		L2300_hi03_BE_value_info,
		L2300_hi03_BE_value_info_amt,
		L2300_hi04_BE_value_info,
		L2300_hi04_BE_value_info_amt,
		L2300_hi05_BE_value_info,
		L2300_hi05_BE_value_info_amt,
		L2300_hi06_BE_value_info,
		L2300_hi06_BE_value_info_amt,
		L2300_hi07_BE_value_info,
		L2300_hi07_BE_value_info_amt,
		L2300_hi08_BE_value_info,
		L2300_hi08_BE_value_info_amt,
		L2300_hi09_BE_value_info,
		L2300_hi09_BE_value_info_amt,
		L2300_hi10_BE_value_info,
		L2300_hi10_BE_value_info_amt,
		L2300_hi11_BE_value_info,
		L2300_hi11_BE_value_info_amt,
		L2300_hi12_BE_value_info,
		L2300_hi12_BE_value_info_amt,
		L2300_hi01_BG_cond_info,
		L2300_hi02_BG_cond_info,
		L2300_hi03_BG_cond_info,
		L2300_hi04_BG_cond_info,
		L2300_hi05_BG_cond_info,
		L2300_hi06_BG_cond_info,
		L2300_hi07_BG_cond_info,
		L2300_hi08_BG_cond_info,
		L2300_hi09_BG_cond_info,
		L2300_hi10_BG_cond_info,
		L2300_hi11_BG_cond_info,
		L2300_hi12_BG_cond_info,
		L2300_hi01_TC_treat_code_info,
		L2300_hi02_TC_treat_code_info,
		L2300_hi03_TC_treat_code_info,
		L2300_hi04_TC_treat_code_info,
		L2300_hi05_TC_treat_code_info,
		L2300_hi06_TC_treat_code_info,
		L2300_hi07_TC_treat_code_info,
		L2300_hi08_TC_treat_code_info,
		L2300_hi09_TC_treat_code_info,
		L2300_hi10_TC_treat_code_info,
		L2300_hi11_TC_treat_code_info,
		L2300_hi12_TC_treat_code_info,
		L2300_qty02_CA_claim_qty,
		L2300_qty02_CD_claim_qty,
		L2300_qty02_LA_claim_qty,
		L2300_qty02_NA_claim_qty,
		L2310A_nm101_entity_id_code,
		L2310A_nm102_entity_type_qual,
		L2310A_nm103_attending_prov_last_nm,
		L2310A_nm104_attending_prov_first_nm,
		L2310A_nm105_attending_prov_middle_nm,
		L2310A_nm107_attending_prov_suffix,
		L2310A_nm108_id_code_qual,
		L2310A_nm109_attending_prov_id,
		L2310A_prv01_provider_code,
		L2310A_prv02_ref_id_qual,
		L2310A_prv03_taxonomy_code,
		L2310A_ref02_1C_attending_prov_id,
		L2310A_ref02_1D_attending_prov_id,
		L2310A_ref02_1G_attending_prov_id,
		L2310A_ref02_EI_attending_prov_id,
		L2310A_ref02_SY_attending_prov_id,
		L2310A_ref02_FH_attending_prov_id,
		L2310B_nm102_entity_type_qual,
		L2310B_nm103_operating_prov_last_nm,
		L2310B_nm104_operating_prov_first_nm,
		L2310B_nm105_operating_prov_middle_nm,
		L2310B_nm107_operating_prov_suffix,
		L2310B_nm108_id_code_qual,
		L2310B_nm109_operating_prov_id,
		L2310B_ref02_1C_operating_prov_id,
		L2310B_ref02_1D_operating_prov_id,
		L2310B_ref02_1G_operating_prov_id,
		L2310B_ref02_EI_operating_prov_id,
		L2310B_ref02_SY_operating_prov_id,
		L2310B_ref02_FH_operating_prov_id,
		L2310C_nm102_entity_type_qual,
		L2310C_nm103_other_prov_last_nm,
		L2310C_nm104_other_prov_first_nm,
		L2310C_nm105_other_prov_middle_nm,
		L2310C_nm107_other_prov_suffix,
		L2310C_nm108_id_code_qual,
		L2310C_nm109_other_prov_id,
		L2310C_ref02_1C_other_prov_id,
		L2310C_ref02_1D_other_prov_id,
		L2310C_ref02_1G_other_prov_id,
		L2310C_ref02_EI_other_prov_id,
		L2310C_ref02_SY_other_prov_id,
		L2310C_ref02_FH_other_prov_id,
		L2310E_nm101_entity_id_code,
		L2310E_nm102_entity_type_qual,
		L2310E_nm103_service_facility_last_nm,
		L2310E_nm108_id_code_qual,
		L2310E_nm109_service_facility_id,
		L2310E_n301_service_facility_address1,
		L2310E_n302_service_facility_address2,
		L2310E_n401_service_facility_city,
		L2310E_n402_service_facility_state,
		L2310E_n403_service_facility_zip,
		L2310E_n404_service_facility_country,
		L2310E_ref02_1C_service_facility_id,
		L2310E_ref02_1D_service_facility_id,
		L2310E_ref02_1G_service_facility_id,
		L2310E_ref02_G2_service_facility_id,
		L2320_1_sbr01_payer_resp_seq_code,
		L2320_1_sbr02_ind_relationship_code,
		L2320_1_sbr03_insured_grp_policy_num,
		L2320_1_sbr04_insured_grp_nm,
		L2320_1_sbr09_claim_file_ind_code,
		L2320_1_cas01_adjustment_group_code,
		L2320_1_cas02_adjustment_reason_code,
		L2320_1_cas03_adjustment_amt,
		L2320_1_cas04_adjustment_qty,
		L2320_1_cas05_adjustment_reason_code,
		L2320_1_cas06_adjustment_amt,
		L2320_1_cas07_adjustment_qty,
		L2320_1_cas08_adjustment_reason_code,
		L2320_1_cas09_adjustment_amt,
		L2320_1_cas10_adjustment_qty,
		L2320_1_amt02_C4_payer_prior_pmt_amt,
		L2320_1_amt02_B6_cob_allowed_amt,
		L2320_1_amt02_T3_cob_submitted_amt,
		L2320_1_amt02_ZZ_drg_outlier_amt,
		L2320_1_amt02_N1_cob_medicare_paid_amt,
		L2320_1_amt02_KF_medicare_paid_100_amt,
		L2320_1_amt02_PG_medicare_paid_80_amt,
		L2320_1_amt02_AA_cob_medicare_a_trust_pd_amt,
		L2320_1_amt02_B1_cob_medicare_b_trust_pd_amt,
		L2320_1_amt02_A8_cob_non_cvd_amt,
		L2320_1_amt02_YT_cob_denied_amt,
		L2320_1_dmg02_other_subscriber_dob,
		L2320_1_dmg03_other_subscriber_gender,
		L2320_1_oi03_other_ins_benefit_assign_ind,
		L2320_1_oi06_other_ins_release_of_info_code,
		L2330A_1_nm101_entity_id_code,
		L2330A_1_nm102_entity_type_qual,
		L2330A_1_nm103_other_subscriber_last_name,
		L2330A_1_nm104_other_subscriber_first_name,
		L2330A_1_nm105_other_subscriber_middle_name,
		L2330A_1_nm107_other_subscriber_name_suffix,
		L2330A_1_nm108_other_subscriber_id_code_qual,
		L2330A_1_nm109_other_subscriber_id,
		L2330B_1_nm101_entity_id_code,
		L2330B_1_nm102_entity_type_qual,
		L2330B_1_nm103_other_payer_nm,
		L2330B_1_nm108_id_code_qual,
		L2330B_1_nm109_other_payer_id,
		L2330B_1_dtp03_573_date_claim_paid,
		L2330B_1_ref02_2U_other_payer_secondary_id,
		L2330B_1_ref02_F8_other_payer_secondary_id,
		L2330B_1_ref02_FY_other_payer_secondary_id,
		L2330B_1_ref02_NF_other_payer_secondary_id,
		L2330B_1_ref02_TJ_other_payer_secondary_id,
		L2330B_1_ref02_9F_other_payer_auth_num,
		L2330B_1_ref02_G1_other_payer_auth_num,
		L2320_2_sbr01_payer_resp_seq_code,
		L2320_2_sbr02_ind_relationship_code,
		L2320_2_sbr03_insured_grp_policy_num,
		L2320_2_sbr04_insured_grp_nm,
		L2320_2_sbr09_claim_file_ind_code,
		L2320_2_cas01_adjustment_group_code,
		L2320_2_cas02_adjustment_reason_code,
		L2320_2_cas03_adjustment_amt,
		L2320_2_cas04_adjustment_qty,
		L2320_2_cas05_adjustment_reason_code,
		L2320_2_cas06_adjustment_amt,
		L2320_2_cas07_adjustment_qty,
		L2320_2_cas08_adjustment_reason_code,
		L2320_2_cas09_adjustment_amt,
		L2320_2_cas10_adjustment_qty,
		L2320_2_amt02_C4_payer_prior_pmt_amt,
		L2320_2_amt02_B6_cob_allowed_amt,
		L2320_2_amt02_T3_cob_submitted_amt,
		L2320_2_amt02_ZZ_drg_outlier_amt,
		L2320_2_amt02_N1_cob_medicare_paid_amt,
		L2320_2_amt02_KF_medicare_paid_100_amt,
		L2320_2_amt02_PG_medicare_paid_80_amt,
		L2320_2_amt02_AA_cob_medicare_a_trust_pd_amt,
		L2320_2_amt02_B1_cob_medicare_b_trust_pd_amt,
		L2320_2_amt02_A8_cob_non_cvd_amt,
		L2320_2_amt02_YT_cob_denied_amt,
		L2320_2_dmg02_other_subscriber_dob,
		L2320_2_dmg03_other_subscriber_gender,
		L2320_2_oi03_other_ins_benefit_assign_ind,
		L2320_2_oi06_other_ins_release_of_info_code,
		L2330A_2_nm101_entity_id_code,
		L2330A_2_nm102_entity_type_qual,
		L2330A_2_nm103_other_subscriber_last_name,
		L2330A_2_nm104_other_subscriber_first_name,
		L2330A_2_nm105_other_subscriber_middle_name,
		L2330A_2_nm107_other_subscriber_name_suffix,
		L2330A_2_nm108_other_subscriber_id_code_qual,
		L2330A_2_nm109_other_subscriber_id,
		L2330B_2_nm101_entity_id_code,
		L2330B_2_nm102_entity_type_qual,
		L2330B_2_nm103_other_payer_nm,
		L2330B_2_nm108_id_code_qual,
		L2330B_2_nm109_other_payer_id,
		L2330B_2_dtp03_573_date_claim_paid,
		L2330B_2_ref02_2U_other_payer_secondary_id,
		L2330B_2_ref02_F8_other_payer_secondary_id,
		L2330B_2_ref02_FY_other_payer_secondary_id,
		L2330B_2_ref02_NF_other_payer_secondary_id,
		L2330B_2_ref02_TJ_other_payer_secondary_id,
		L2330B_2_ref02_9F_other_payer_auth_num,
		L2330B_2_ref02_G1_other_payer_auth_num,
		L2320_3_sbr01_payer_resp_seq_code,
		L2320_3_sbr02_ind_relationship_code,
		L2320_3_sbr03_insured_grp_policy_num,
		L2320_3_sbr04_insured_grp_nm,
		L2320_3_sbr09_claim_file_ind_code,
		L2320_3_cas01_adjustment_group_code,
		L2320_3_cas02_adjustment_reason_code,
		L2320_3_cas03_adjustment_amt,
		L2320_3_cas04_adjustment_qty,
		L2320_3_cas05_adjustment_reason_code,
		L2320_3_cas06_adjustment_amt,
		L2320_3_cas07_adjustment_qty,
		L2320_3_cas08_adjustment_reason_code,
		L2320_3_cas09_adjustment_amt,
		L2320_3_cas10_adjustment_qty,
		L2320_3_amt02_C4_payer_prior_pmt_amt,
		L2320_3_amt02_B6_cob_allowed_amt,
		L2320_3_amt02_T3_cob_submitted_amt,
		L2320_3_amt02_ZZ_drg_outlier_amt,
		L2320_3_amt02_N1_cob_medicare_paid_amt,
		L2320_3_amt02_KF_medicare_paid_100_amt,
		L2320_3_amt02_PG_medicare_paid_80_amt,
		L2320_3_amt02_AA_cob_medicare_a_trust_pd_amt,
		L2320_3_amt02_B1_cob_medicare_b_trust_pd_amt,
		L2320_3_amt02_A8_cob_non_cvd_amt,
		L2320_3_amt02_YT_cob_denied_amt,
		L2320_3_dmg02_other_subscriber_dob,
		L2320_3_dmg03_other_subscriber_gender,
		L2320_3_oi03_other_ins_benefit_assign_ind,
		L2320_3_oi06_other_ins_release_of_info_code,
		L2330A_3_nm101_entity_id_code,
		L2330A_3_nm102_entity_type_qual,
		L2330A_3_nm103_other_subscriber_last_name,
		L2330A_3_nm104_other_subscriber_first_name,
		L2330A_3_nm105_other_subscriber_middle_name,
		L2330A_3_nm107_other_subscriber_name_suffix,
		L2330A_3_nm108_other_subscriber_id_code_qual,
		L2330A_3_nm109_other_subscriber_id,
		L2330B_3_nm101_entity_id_code,
		L2330B_3_nm102_entity_type_qual,
		L2330B_3_nm103_other_payer_nm,
		L2330B_3_nm108_id_code_qual,
		L2330B_3_nm109_other_payer_id,
		L2330B_3_dtp03_573_date_claim_paid,
		L2330B_3_ref02_2U_other_payer_secondary_id,
		L2330B_3_ref02_F8_other_payer_secondary_id,
		L2330B_3_ref02_FY_other_payer_secondary_id,
		L2330B_3_ref02_NF_other_payer_secondary_id,
		L2330B_3_ref02_TJ_other_payer_secondary_id,
		L2330B_3_ref02_9F_other_payer_auth_num,
		L2330B_3_ref02_G1_other_payer_auth_num,
		L2400_lx01_assigned_num, 
		L2400_sv201_rev_code, 
		L2400_sv202_proc_code_qual,
		L2400_sv202_proc_code, 
		L2400_sv202_proc_mod1,
		L2400_sv202_proc_mod2,
		L2400_sv202_proc_mod3,
		L2400_sv202_proc_mod4,
		L2400_sv203_line_charge,
		L2400_sv204_measurement_code,
		L2400_sv205_service_unit_count,
		L2400_sv206_service_line_rate,
		L2400_sv207_denied_amt, 
		L2400_dtp02_472_from_service_date,
		L2400_dtp02_472_to_service_date,
		L2400_dtp02_866_format_qual,
		L2400_dtp02_866_assess_date,
		L2410_1_lin03_N4_ndc,
		L2420A_nm102_entity_type_qual,
		L2420A_nm103_attending_physician_last_nm,
		L2420A_nm104_attending_physician_first_nm,
		L2420A_nm105_attending_physician_middle_nm,
		L2420A_nm107_attending_physician_suffix,
		L2420A_nm108_id_code_qual,
		L2420A_nm109_attending_physician_id,
		L2420A_ref02_1C_attending_prov_id,
		L2420A_ref02_1D_attending_prov_id,
		L2420A_ref02_1G_attending_prov_id,
		L2420A_ref02_EI_attending_prov_id,
		L2420A_ref02_SY_attending_prov_id,
		L2420A_ref02_FH_attending_prov_id,
		L2420B_nm102_entity_type_qual,
		L2420B_nm103_operating_prov_last_nm,
		L2420B_nm104_operating_prov_first_nm,
		L2420B_nm105_operating_prov_middle_nm,
		L2420B_nm107_operating_prov_suffix,
		L2420B_nm108_id_code_qual,
		L2420B_nm109_operating_prov_id,
		L2420B_ref02_1C_operating_prov_id,
		L2420B_ref02_1D_operating_prov_id,
		L2420B_ref02_1G_operating_prov_id,
		L2420B_ref02_EI_operating_prov_id,
		L2420B_ref02_SY_operating_prov_id,
		L2420B_ref02_FH_operating_prov_id,
		L2420C_nm102_entity_type_qual,
		L2420C_nm103_other_prov_last_nm,
		L2420C_nm104_other_prov_first_nm,
		L2420C_nm105_other_prov_middle_nm,
		L2420C_nm107_other_prov_suffix,
		L2420C_nm108_id_code_qual,
		L2420C_nm109_other_prov_id,	
		L2420C_ref02_1C_other_prov_id,
		L2420C_ref02_1D_other_prov_id,
		L2420C_ref02_1G_other_prov_id,
		L2420C_ref02_G2_other_prov_id,
		L2430_svd01_payer_id,
		L2430_svd02_service_line_paid,
		L2430_svd03_proc_code_qual,
		L2430_svd03_proc_code, 
		L2430_svd03_proc_mod1,
		L2430_svd03_proc_mod2,
		L2430_svd03_proc_mod3,
		L2430_svd03_proc_mod4,
		L2430_svd04_rev_code, 
		L2430_svd05_adj_qty,
		L2430_svd06_bundled_line_num, 
		L2430_cas01_adjustment_group_code,
		L2430_cas02_adjustment_reason_code, 
		L2430_cas03_adjustment_amt, 
		L2430_cas04_adjustment_qty,
		L2430_cas05_adjustment_reason_code, 
		L2430_cas06_adjustment_amt, 
		L2430_cas07_adjustment_qty,
		L2430_cas08_adjustment_reason_code, 
		L2430_cas09_adjustment_amt, 
		L2430_cas10_adjustment_qty,
		L2430_1_cas01_adjustment_group_code,
		L2430_1_cas02_adjustment_reason_code,
		L2430_1_cas03_adjustment_amt,
		L2430_1_cas04_adjustment_qty,
		L2430_1_cas05_adjustment_reason_code,
		L2430_1_cas06_adjustment_amt,
		L2430_1_cas07_adjustment_qty,
		L2430_1_cas08_adjustment_reason_code,
		L2430_1_cas09_adjustment_amt,
		L2430_1_cas10_adjustment_qty,
		L2430_1_cas11_adjustment_reason_code,
		L2430_1_cas12_adjustment_amt,
		L2430_1_cas13_adjustment_qty,
		L2430_1_cas14_adjustment_reason_code,
		L2430_1_cas15_adjustment_amt,
		L2430_1_cas16_adjustment_qty,
		L2430_1_cas17_adjustment_reason_code,
		L2430_1_cas18_adjustment_amt,
		L2430_1_cas19_adjustment_qty,
		L2430_2_cas01_adjustment_group_code,
		L2430_2_cas02_adjustment_reason_code,
		L2430_2_cas03_adjustment_amt,
		L2430_2_cas04_adjustment_qty,
		L2430_2_cas05_adjustment_reason_code,
		L2430_2_cas06_adjustment_amt,
		L2430_2_cas07_adjustment_qty,
		L2430_2_cas08_adjustment_reason_code,
		L2430_2_cas09_adjustment_amt,
		L2430_2_cas10_adjustment_qty,
		L2430_2_cas11_adjustment_reason_code,
		L2430_2_cas12_adjustment_amt,
		L2430_2_cas13_adjustment_qty,
		L2430_2_cas14_adjustment_reason_code,
		L2430_2_cas15_adjustment_amt,
		L2430_2_cas16_adjustment_qty,
		L2430_2_cas17_adjustment_reason_code,
		L2430_2_cas18_adjustment_amt,
		L2430_2_cas19_adjustment_qty,
		L2430_3_cas01_adjustment_group_code,
		L2430_3_cas02_adjustment_reason_code,
		L2430_3_cas03_adjustment_amt,
		L2430_3_cas04_adjustment_qty,
		L2430_3_cas05_adjustment_reason_code,
		L2430_3_cas06_adjustment_amt,
		L2430_3_cas07_adjustment_qty,
		L2430_3_cas08_adjustment_reason_code,
		L2430_3_cas09_adjustment_amt,
		L2430_3_cas10_adjustment_qty,
		L2430_3_cas11_adjustment_reason_code,
		L2430_3_cas12_adjustment_amt,
		L2430_3_cas13_adjustment_qty,
		L2430_3_cas14_adjustment_reason_code,
		L2430_3_cas15_adjustment_amt,
		L2430_3_cas16_adjustment_qty,
		L2430_3_cas17_adjustment_reason_code,
		L2430_3_cas18_adjustment_amt,
		L2430_3_cas19_adjustment_qty,
		L2430_4_cas01_adjustment_group_code,
		L2430_4_cas02_adjustment_reason_code,
		L2430_4_cas03_adjustment_amt,
		L2430_4_cas04_adjustment_qty,
		L2430_4_cas05_adjustment_reason_code,
		L2430_4_cas06_adjustment_amt,
		L2430_4_cas07_adjustment_qty,
		L2430_4_cas08_adjustment_reason_code,
		L2430_4_cas09_adjustment_amt,
		L2430_4_cas10_adjustment_qty,
		L2430_4_cas11_adjustment_reason_code,
		L2430_4_cas12_adjustment_amt,
		L2430_4_cas13_adjustment_qty,
		L2430_4_cas14_adjustment_reason_code,
		L2430_4_cas15_adjustment_amt,
		L2430_4_cas16_adjustment_qty,
		L2430_4_cas17_adjustment_reason_code,
		L2430_4_cas18_adjustment_amt,
		L2430_4_cas19_adjustment_qty,
		L2430_5_cas01_adjustment_group_code,
		L2430_5_cas02_adjustment_reason_code,
		L2430_5_cas03_adjustment_amt,
		L2430_5_cas04_adjustment_qty,
		L2430_5_cas05_adjustment_reason_code,
		L2430_5_cas06_adjustment_amt,
		L2430_5_cas07_adjustment_qty,
		L2430_5_cas08_adjustment_reason_code,
		L2430_5_cas09_adjustment_amt,
		L2430_5_cas10_adjustment_qty,
		L2430_5_cas11_adjustment_reason_code,
		L2430_5_cas12_adjustment_amt,
		L2430_5_cas13_adjustment_qty,
		L2430_5_cas14_adjustment_reason_code,
		L2430_5_cas15_adjustment_amt,
		L2430_5_cas16_adjustment_qty,
		L2430_5_cas17_adjustment_reason_code,
		L2430_5_cas18_adjustment_amt,
		L2430_5_cas19_adjustment_qty,
		L2430_dtp03_573_service_adjudication_date
	from x12_837_claim_institutional
	where	x12_transaction_id = @x12_transaction_id
	order by x12_837_claim_institutional_id
OPEN curtX12Doc
-- fetch all the columns into the variables
FETCH NEXT FROM curtX12Doc INTO	@x12_transaction_id,
				@bht01_hierarchical_structure_code,
				@bht02_trans_set_purpose_code,
				@bht03_orig_app_tran_id,
				@bht04_trans_set_creation_date,
				@bht05_trans_set_creation_time,
				@bht06_claim_encounter_id,
				@ref01_receiver_ref_id_qual,
				@ref02_transmission_type_code,
				@L1000A_nm102_entity_type_qual,
				@L1000A_nm103_submitter_last_nm,
				@L1000A_nm104_submitter_first_nm,
				@L1000A_nm105_submitter_middle_nm,
				@L1000A_nm108_submitter_id_qual,
				@L1000A_nm109_submitter_id,
				@L1000A_per01_contact_function_code,
				@L1000A_per02_contact_nm,
				@L1000A_per03_comm_num_qual,
				@L1000A_per04_comm_number,
				@L1000B_nm102_entity_type_qual,
				@L1000B_nm103_receiver_last_nm,
				@L1000B_nm108_receiver_id_qual,
				@L1000B_nm109_receiver_id,
				@L2000A_hl01_hierarchical_id_num, 
				@L2000A_hl03_hierarchical_level_code,
				@L2000A_hl04_hierarchical_child_code,
				@L2000A_prv01_provider_code,
				@L2000A_prv02_ref_id_qual,
				@L2000A_prv03_taxonomy_code,
				@L2000A_cur02_currency_code,
				@L2010AA_nm102_entity_type_qual,
				@L2010AA_nm103_billing_prov_last_nm,
				@L2010AA_nm104_billing_prov_first_nm,
				@L2010AA_nm105_billing_prov_middle_nm,
				@L2010AA_nm107_billing_prov_suffix,
				@L2010AA_nm108_id_code_qual,
				@L2010AA_nm109_billing_prov_id,
				@L2010AA_n301_billing_prov_address1,
				@L2010AA_n302_billing_prov_address2,
				@L2010AA_n401_billing_prov_city,
				@L2010AA_n402_billing_prov_state,
				@L2010AA_n403_billing_prov_zip,
				@L2010AA_n404_billing_prov_country,
				@L2010AA_ref02_1B_billing_prov_id,
				@L2010AA_ref02_1C_billing_prov_id,
				@L2010AA_ref02_1D_billing_prov_id,
				@L2010AA_ref02_1G_billing_prov_id,
				@L2010AA_ref02_EI_billing_prov_id,
				@L2010AA_ref02_SY_billing_prov_id,
				@L2010AA_ref02_FH_billing_prov_id,
				@L2010AA_ref02_06_card_billing_id,
				@L2010AA_ref02_8U_card_billing_id,
				@L2010AA_ref02_EM_card_billing_id,
				@L2010AA_ref02_IJ_card_billing_id,
				@L2010AA_ref02_LU_card_billing_id,
				@L2010AA_ref02_ST_card_billing_id,
				@L2010AA_per01_billing_prov_comm_func_code,
				@L2010AA_per02_billing_prov_contact_nm,
				@L2010AA_per03_billing_prov_comm_num_qual,
				@L2010AA_per04_billing_prov_comm,
				@L2010AB_nm102_entity_type_qual,
				@L2010AB_nm103_payto_prov_last_nm,
				@L2010AB_nm104_payto_prov_first_nm,
				@L2010AB_nm105_payto_prov_middle_nm,
				@L2010AB_nm107_payto_prov_suffix,
				@L2010AB_nm108_id_code_qual,
				@L2010AB_nm109_payto_prov_id,
				@L2010AB_n301_payto_prov_address1,
				@L2010AB_n302_payto_prov_address2,
				@L2010AB_n401_payto_prov_city,
				@L2010AB_n402_payto_prov_state,
				@L2010AB_n403_payto_prov_zip,
				@L2010AB_n404_payto_prov_country,
				@L2010AB_ref02_1C_payto_prov_id,
				@L2010AB_ref02_1D_payto_prov_id,
				@L2010AB_ref02_1G_payto_prov_id,
				@L2010AB_ref02_EI_payto_prov_id,
				@L2010AB_ref02_SY_payto_prov_id,
				@L2010AB_ref02_FH_payto_prov_id,
				@L2000B_hl01_hierarchical_id_num, 
				@L2000B_hl02_hierarchical_parent_id_num, 
				@L2000B_hl03_hierarchical_level_code,
				@L2000B_hl04_hierarchical_child_code,
				@L2000B_sbr01_payer_resp_seq_code,
				@L2000B_sbr02_ind_relationship_code,
				@L2000B_sbr03_insured_grp_policy_num,
				@L2000B_sbr04_insured_grp_nm,
				@L2000B_sbr09_claim_id_code,
				@L2000B_pat06_insured_ind_death_date,
				@L2000B_pat08_patient_weight,
				@L2000B_pat09_pregnancy_indicator,
				@L2010BA_nm102_entity_type_qual,
				@L2010BA_nm103_subscriber_last_nm,
				@L2010BA_nm104_subscriber_first_nm,
				@L2010BA_nm105_subscriber_middle_nm,
				@L2010BA_nm107_subscriber_suffix,
				@L2010BA_nm108_id_code_qual,
				@L2010BA_nm109_subscriber_id,
				@L2010BA_n301_subscriber_address1,
				@L2010BA_n302_subscriber_address2,
				@L2010BA_n401_subscriber_city,
				@L2010BA_n402_subscriber_state,
				@L2010BA_n403_subscriber_zip,
				@L2010BA_n404_subscriber_country,
				@L2010BA_dmg02_subscriber_dob,
				@L2010BA_dmg03_subscriber_gender,
				@L2010BA_ref02_1W_subscriber_sup_id,
				@L2010BA_ref02_23_subscriber_sup_id,
				@L2010BA_ref02_IG_subscriber_sup_id,
				@L2010BA_ref02_SY_subscriber_sup_id,
				@L2010BA_ref02_Y4_prop_casualty_claim_num,
				@L2010BB_nm102_entity_type_qual,
				@L2010BB_nm103_card_holder_last_nm,
				@L2010BB_nm104_card_holder_first_nm,
				@L2010BB_nm105_card_holder_middle_nm,
				@L2010BB_nm107_card_holder_suffix,
				@L2010BB_nm108_card_id_qual,
				@L2010BB_nm109_card_num,
				@L2010BB_ref02_AB_payer_id,
				@L2010BB_ref02_BB_payer_id,
				@L2010BC_nm102_entity_type_qual,
				@L2010BC_nm103_payer_nm,
				@L2010BC_nm108_payer_id_qual,
				@L2010BC_nm109_payer_id,
				@L2010BC_n301_payer_address1,
				@L2010BC_n302_payer_address2,
				@L2010BC_n401_payer_city,
				@L2010BC_n402_payer_state,
				@L2010BC_n403_payer_zip,
				@L2010BC_n404_payer_country,
				@L2010BC_ref02_2U_payer_id,
				@L2010BC_ref02_FY_payer_id,
				@L2010BC_ref02_NF_payer_id,
				@L2010BC_ref02_TJ_payer_id,
				@L2010BD_nm102_entity_type_qual,
				@L2010BD_nm103_resp_party_last_nm,
				@L2010BD_nm104_resp_party_first_nm,
				@L2010BD_nm105_resp_party_middle_nm,
				@L2010BD_nm107_resp_party_suffix,
				@L2010BD_n301_resp_party_address1,
				@L2010BD_n302_resp_party_address2,
				@L2010BD_n401_resp_party_city,
				@L2010BD_n402_resp_party_state,
				@L2010BD_n403_resp_party_zip,
				@L2010BD_n404_resp_party_country,
				@L2000C_hl01_hierarchical_id_num, 
				@L2000C_hl02_hierarchical_parent_id_num, 
				@L2000C_hl03_hierarchical_level_code,
				@L2000C_hl04_hierarchical_child_code,
				@L2000C_pat01_ind_relationship_code,
				@L2010CA_nm102_entity_type_qual,
				@L2010CA_nm103_patient_last_nm,
				@L2010CA_nm104_patient_first_nm,
				@L2010CA_nm105_patient_middle_nm,
				@L2010CA_nm107_patient_suffix,
				@L2010CA_nm108_id_code_qual,
				@L2010CA_nm109_patient_id,
				@L2010CA_n301_patient_address1,
				@L2010CA_n302_patient_address2,
				@L2010CA_n401_patient_city,
				@L2010CA_n402_patient_state,
				@L2010CA_n403_patient_zip,
				@L2010CA_n404_patient_country,
				@L2010CA_dmg02_patient_dob,
				@L2010CA_dmg03_patient_gender,
				@L2010CA_ref02_1W_patient_sup_id,
				@L2010CA_ref02_23_patient_sup_id,
				@L2010CA_ref02_IG_patient_sup_id,
				@L2010CA_ref02_SY_patient_sup_id,
				@L2010CA_ref02_Y4_prop_casualty_claim_num,
				@L2300_clm01_pt_acct_num,
				@L2300_clm02_total_claim_chg_amt, 
				@L2300_clm05_facility_type_code,
				@L2300_clm05_facility_code_qual,
				@L2300_clm05_claim_freq_code,
				@L2300_clm06_provider_signature_ind,
				@L2300_clm07_medicare_assign_code,
				@L2300_clm08_benefit_assign_ind,
				@L2300_clm09_release_of_info_code,
				@L2300_clm18_explan_benefits_ind,
				@L2300_clm20_delay_reason_code,
				@L2300_dtp03_096_discharge_hour,
				@L2300_dtp03_434_begin_statement_date,
				@L2300_dtp03_434_end_statement_date,
				@L2300_dtp03_435_admission_date,
				@L2300_cl101_admit_type_code,
				@L2300_cl102_admit_source_code,
				@L2300_cl103_patient_status_code,
				@L2300_pwk01_attachment_type_code,
				@L2300_pwk02_attachment_trans_code,
				@L2300_pwk06_attachment_control_num,
				@L2300_amt02_patient_paid_amt, 
				@L2300_amt02_patient_resp_amt,
				@L2300_amt02_total_purchased_amt, 
				@L2300_ref02_9C_adj_repriced_claim_num,
				@L2300_ref02_9A_repriced_claim_num,
				@L2300_ref02_D9_claim_id_clearing_house,
				@L2300_ref02_DD_domcument_id,
				@L2300_ref02_F8_original_ref_num,
				@L2300_ref02_9F_referral_num,
				@L2300_ref02_G1_prior_auth_num,
				@L2300_ref02_EA_medical_record_num,
				@L2300_k301_fixed_format_info,
				@L2300_nte01_note_ref_code,
				@L2300_nte02_claim_note_text,
				@L2300_hi01_BK_diag_admit_ecode,
				@L2300_hi02_BJ_diag_admit_ecode,
				@L2300_hi02_ZZ_diag_admit_ecode,
				@L2300_hi03_BN_diag_admit_ecode,
				@L2300_hi01_DR_diag_drg,
				@L2300_hi01_BF_diag_code,
				@L2300_hi02_BF_diag_code,
				@L2300_hi03_BF_diag_code,
				@L2300_hi04_BF_diag_code,
				@L2300_hi05_BF_diag_code,
				@L2300_hi06_BF_diag_code,
				@L2300_hi07_BF_diag_code,
				@L2300_hi08_BF_diag_code,
				@L2300_hi09_BF_diag_code,
				@L2300_hi10_BF_diag_code,
				@L2300_hi11_BF_diag_code,
				@L2300_hi12_BF_diag_code,
				@L2300_hi01_BR_princ_proc_info,
				@L2300_hi01_BR_princ_proc_info_date,
				@L2300_hi01_BQ_other_proc_info,
				@L2300_hi01_BQ_other_proc_info_date,
				@L2300_hi02_BQ_other_proc_info,
				@L2300_hi02_BQ_other_proc_info_date,
				@L2300_hi03_BQ_other_proc_info,
				@L2300_hi03_BQ_other_proc_info_date,
				@L2300_hi04_BQ_other_proc_info,
				@L2300_hi04_BQ_other_proc_info_date,
				@L2300_hi05_BQ_other_proc_info,
				@L2300_hi05_BQ_other_proc_info_date,
				@L2300_hi06_BQ_other_proc_info,
				@L2300_hi06_BQ_other_proc_info_date,
				@L2300_hi07_BQ_other_proc_info,
				@L2300_hi07_BQ_other_proc_info_date,
				@L2300_hi08_BQ_other_proc_info,
				@L2300_hi08_BQ_other_proc_info_date,
				@L2300_hi09_BQ_other_proc_info,
				@L2300_hi09_BQ_other_proc_info_date,
				@L2300_hi10_BQ_other_proc_info,
				@L2300_hi10_BQ_other_proc_info_date,
				@L2300_hi11_BQ_other_proc_info,
				@L2300_hi11_BQ_other_proc_info_date,
				@L2300_hi12_BQ_other_proc_info,
				@L2300_hi12_BQ_other_proc_info_date,
				@L2300_hi01_BI_occur_span,
				@L2300_hi01_BI_occur_span_date,
				@L2300_hi02_BI_occur_span,
				@L2300_hi02_BI_occur_span_date,
				@L2300_hi03_BI_occur_span,
				@L2300_hi03_BI_occur_span_date,
				@L2300_hi04_BI_occur_span,
				@L2300_hi04_BI_occur_span_date,
				@L2300_hi05_BI_occur_span,
				@L2300_hi05_BI_occur_span_date,
				@L2300_hi06_BI_occur_span,
				@L2300_hi06_BI_occur_span_date,
				@L2300_hi07_BI_occur_span,
				@L2300_hi07_BI_occur_span_date,
				@L2300_hi08_BI_occur_span,
				@L2300_hi08_BI_occur_span_date,
				@L2300_hi09_BI_occur_span,
				@L2300_hi09_BI_occur_span_date,
				@L2300_hi10_BI_occur_span,
				@L2300_hi10_BI_occur_span_date,
				@L2300_hi11_BI_occur_span,
				@L2300_hi11_BI_occur_span_date,
				@L2300_hi12_BI_occur_span,
				@L2300_hi12_BI_occur_span_date,
				@L2300_hi01_BH_occur_info,
				@L2300_hi01_BH_occur_info_date,
				@L2300_hi02_BH_occur_info,
				@L2300_hi02_BH_occur_info_date,
				@L2300_hi03_BH_occur_info,
				@L2300_hi03_BH_occur_info_date,
				@L2300_hi04_BH_occur_info,
				@L2300_hi04_BH_occur_info_date,
				@L2300_hi05_BH_occur_info,
				@L2300_hi05_BH_occur_info_date,
				@L2300_hi06_BH_occur_info,
				@L2300_hi06_BH_occur_info_date,
				@L2300_hi07_BH_occur_info,
				@L2300_hi07_BH_occur_info_date,
				@L2300_hi08_BH_occur_info,
				@L2300_hi08_BH_occur_info_date,
				@L2300_hi09_BH_occur_info,
				@L2300_hi09_BH_occur_info_date,
				@L2300_hi10_BH_occur_info,
				@L2300_hi10_BH_occur_info_date,
				@L2300_hi11_BH_occur_info,
				@L2300_hi11_BH_occur_info_date,
				@L2300_hi12_BH_occur_info,
				@L2300_hi12_BH_occur_info_date,
				@L2300_hi01_BE_value_info,
				@L2300_hi01_BE_value_info_amt,
				@L2300_hi02_BE_value_info,
				@L2300_hi02_BE_value_info_amt,
				@L2300_hi03_BE_value_info,
				@L2300_hi03_BE_value_info_amt,
				@L2300_hi04_BE_value_info,
				@L2300_hi04_BE_value_info_amt,
				@L2300_hi05_BE_value_info,
				@L2300_hi05_BE_value_info_amt,
				@L2300_hi06_BE_value_info,
				@L2300_hi06_BE_value_info_amt,
				@L2300_hi07_BE_value_info,
				@L2300_hi07_BE_value_info_amt,
				@L2300_hi08_BE_value_info,
				@L2300_hi08_BE_value_info_amt,
				@L2300_hi09_BE_value_info,
				@L2300_hi09_BE_value_info_amt,
				@L2300_hi10_BE_value_info,
				@L2300_hi10_BE_value_info_amt,
				@L2300_hi11_BE_value_info,
				@L2300_hi11_BE_value_info_amt,
				@L2300_hi12_BE_value_info,
				@L2300_hi12_BE_value_info_amt,
				@L2300_hi01_BG_cond_info,
				@L2300_hi02_BG_cond_info,
				@L2300_hi03_BG_cond_info,
				@L2300_hi04_BG_cond_info,
				@L2300_hi05_BG_cond_info,
				@L2300_hi06_BG_cond_info,
				@L2300_hi07_BG_cond_info,
				@L2300_hi08_BG_cond_info,
				@L2300_hi09_BG_cond_info,
				@L2300_hi10_BG_cond_info,
				@L2300_hi11_BG_cond_info,
				@L2300_hi12_BG_cond_info,
				@L2300_hi01_TC_treat_code_info,
				@L2300_hi02_TC_treat_code_info,
				@L2300_hi03_TC_treat_code_info,
				@L2300_hi04_TC_treat_code_info,
				@L2300_hi05_TC_treat_code_info,
				@L2300_hi06_TC_treat_code_info,
				@L2300_hi07_TC_treat_code_info,
				@L2300_hi08_TC_treat_code_info,
				@L2300_hi09_TC_treat_code_info,
				@L2300_hi10_TC_treat_code_info,
				@L2300_hi11_TC_treat_code_info,
				@L2300_hi12_TC_treat_code_info,
				@L2300_qty02_CA_claim_qty,
				@L2300_qty02_CD_claim_qty,
				@L2300_qty02_LA_claim_qty,
				@L2300_qty02_NA_claim_qty,
				@L2310A_nm101_entity_id_code,
				@L2310A_nm102_entity_type_qual,
				@L2310A_nm103_attending_prov_last_nm,
				@L2310A_nm104_attending_prov_first_nm,
				@L2310A_nm105_attending_prov_middle_nm,
				@L2310A_nm107_attending_prov_suffix,
				@L2310A_nm108_id_code_qual,
				@L2310A_nm109_attending_prov_id,
				@L2310A_prv01_provider_code,
				@L2310A_prv02_ref_id_qual,
				@L2310A_prv03_taxonomy_code,
				@L2310A_ref02_1C_attending_prov_id,
				@L2310A_ref02_1D_attending_prov_id,
				@L2310A_ref02_1G_attending_prov_id,
				@L2310A_ref02_EI_attending_prov_id,
				@L2310A_ref02_SY_attending_prov_id,
				@L2310A_ref02_FH_attending_prov_id,
				@L2310B_nm102_entity_type_qual,
				@L2310B_nm103_operating_prov_last_nm,
				@L2310B_nm104_operating_prov_first_nm,
				@L2310B_nm105_operating_prov_middle_nm,
				@L2310B_nm107_operating_prov_suffix,
				@L2310B_nm108_id_code_qual,
				@L2310B_nm109_operating_prov_id,
				@L2310B_ref02_1C_operating_prov_id,
				@L2310B_ref02_1D_operating_prov_id,
				@L2310B_ref02_1G_operating_prov_id,
				@L2310B_ref02_EI_operating_prov_id,
				@L2310B_ref02_SY_operating_prov_id,
				@L2310B_ref02_FH_operating_prov_id,
				@L2310C_nm102_entity_type_qual,
				@L2310C_nm103_other_prov_last_nm,
				@L2310C_nm104_other_prov_first_nm,
				@L2310C_nm105_other_prov_middle_nm,
				@L2310C_nm107_other_prov_suffix,
				@L2310C_nm108_id_code_qual,
				@L2310C_nm109_other_prov_id,
				@L2310C_ref02_1C_other_prov_id,
				@L2310C_ref02_1D_other_prov_id,
				@L2310C_ref02_1G_other_prov_id,
				@L2310C_ref02_EI_other_prov_id,
				@L2310C_ref02_SY_other_prov_id,
				@L2310C_ref02_FH_other_prov_id,
				@L2310E_nm101_entity_id_code,
				@L2310E_nm102_entity_type_qual,
				@L2310E_nm103_service_facility_last_nm,
				@L2310E_nm108_id_code_qual,
				@L2310E_nm109_service_facility_id,
				@L2310E_n301_service_facility_address1,
				@L2310E_n302_service_facility_address2,
				@L2310E_n401_service_facility_city,
				@L2310E_n402_service_facility_state,
				@L2310E_n403_service_facility_zip,
				@L2310E_n404_service_facility_country,
				@L2310E_ref02_1C_service_facility_id,
				@L2310E_ref02_1D_service_facility_id,
				@L2310E_ref02_1G_service_facility_id,
				@L2310E_ref02_G2_service_facility_id,
				@L2320_1_sbr01_payer_resp_seq_code,
				@L2320_1_sbr02_ind_relationship_code,
				@L2320_1_sbr03_insured_grp_policy_num,
				@L2320_1_sbr04_insured_grp_nm,
				@L2320_1_sbr09_claim_file_ind_code,
				@L2320_1_cas01_adjustment_group_code,
				@L2320_1_cas02_adjustment_reason_code,
				@L2320_1_cas03_adjustment_amt,
				@L2320_1_cas04_adjustment_qty,
				@L2320_1_cas05_adjustment_reason_code,
				@L2320_1_cas06_adjustment_amt,
				@L2320_1_cas07_adjustment_qty,
				@L2320_1_cas08_adjustment_reason_code,
				@L2320_1_cas09_adjustment_amt,
				@L2320_1_cas10_adjustment_qty,
				@L2320_1_amt02_C4_payer_prior_pmt_amt,
				@L2320_1_amt02_B6_cob_allowed_amt,
				@L2320_1_amt02_T3_cob_submitted_amt,
				@L2320_1_amt02_ZZ_drg_outlier_amt,
				@L2320_1_amt02_N1_cob_medicare_paid_amt,
				@L2320_1_amt02_KF_medicare_paid_100_amt,
				@L2320_1_amt02_PG_medicare_paid_80_amt,
				@L2320_1_amt02_AA_cob_medicare_a_trust_pd_amt,
				@L2320_1_amt02_B1_cob_medicare_b_trust_pd_amt,
				@L2320_1_amt02_A8_cob_non_cvd_amt,
				@L2320_1_amt02_YT_cob_denied_amt,
				@L2320_1_dmg02_other_subscriber_dob,
				@L2320_1_dmg03_other_subscriber_gender,
				@L2320_1_oi03_other_ins_benefit_assign_ind,
				@L2320_1_oi06_other_ins_release_of_info_code,
				@L2330A_1_nm101_entity_id_code,
				@L2330A_1_nm102_entity_type_qual,
				@L2330A_1_nm103_other_subscriber_last_name,
				@L2330A_1_nm104_other_subscriber_first_name,
				@L2330A_1_nm105_other_subscriber_middle_name,
				@L2330A_1_nm107_other_subscriber_name_suffix,
				@L2330A_1_nm108_other_subscriber_id_code_qual,
				@L2330A_1_nm109_other_subscriber_id,
				@L2330B_1_nm101_entity_id_code,
				@L2330B_1_nm102_entity_type_qual,
				@L2330B_1_nm103_other_payer_nm,
				@L2330B_1_nm108_id_code_qual,
				@L2330B_1_nm109_other_payer_id,
				@L2330B_1_dtp03_573_date_claim_paid,
				@L2330B_1_ref02_2U_other_payer_secondary_id,
				@L2330B_1_ref02_F8_other_payer_secondary_id,
				@L2330B_1_ref02_FY_other_payer_secondary_id,
				@L2330B_1_ref02_NF_other_payer_secondary_id,
				@L2330B_1_ref02_TJ_other_payer_secondary_id,
				@L2330B_1_ref02_9F_other_payer_auth_num,
				@L2330B_1_ref02_G1_other_payer_auth_num,
				@L2320_2_sbr01_payer_resp_seq_code,
				@L2320_2_sbr02_ind_relationship_code,
				@L2320_2_sbr03_insured_grp_policy_num,
				@L2320_2_sbr04_insured_grp_nm,
				@L2320_2_sbr09_claim_file_ind_code,
				@L2320_2_cas01_adjustment_group_code,
				@L2320_2_cas02_adjustment_reason_code,
				@L2320_2_cas03_adjustment_amt,
				@L2320_2_cas04_adjustment_qty,
				@L2320_2_cas05_adjustment_reason_code,
				@L2320_2_cas06_adjustment_amt,
				@L2320_2_cas07_adjustment_qty,
				@L2320_2_cas08_adjustment_reason_code,
				@L2320_2_cas09_adjustment_amt,
				@L2320_2_cas10_adjustment_qty,
				@L2320_2_amt02_C4_payer_prior_pmt_amt,
				@L2320_2_amt02_B6_cob_allowed_amt,
				@L2320_2_amt02_T3_cob_submitted_amt,
				@L2320_2_amt02_ZZ_drg_outlier_amt,
				@L2320_2_amt02_N1_cob_medicare_paid_amt,
				@L2320_2_amt02_KF_medicare_paid_100_amt,
				@L2320_2_amt02_PG_medicare_paid_80_amt,
				@L2320_2_amt02_AA_cob_medicare_a_trust_pd_amt,
				@L2320_2_amt02_B1_cob_medicare_b_trust_pd_amt,
				@L2320_2_amt02_A8_cob_non_cvd_amt,
				@L2320_2_amt02_YT_cob_denied_amt,
				@L2320_2_dmg02_other_subscriber_dob,
				@L2320_2_dmg03_other_subscriber_gender,
				@L2320_2_oi03_other_ins_benefit_assign_ind,
				@L2320_2_oi06_other_ins_release_of_info_code,
				@L2330A_2_nm101_entity_id_code,
				@L2330A_2_nm102_entity_type_qual,
				@L2330A_2_nm103_other_subscriber_last_name,
				@L2330A_2_nm104_other_subscriber_first_name,
				@L2330A_2_nm105_other_subscriber_middle_name,
				@L2330A_2_nm107_other_subscriber_name_suffix,
				@L2330A_2_nm108_other_subscriber_id_code_qual,
				@L2330A_2_nm109_other_subscriber_id,
				@L2330B_2_nm101_entity_id_code,
				@L2330B_2_nm102_entity_type_qual,
				@L2330B_2_nm103_other_payer_nm,
				@L2330B_2_nm108_id_code_qual,
				@L2330B_2_nm109_other_payer_id,
				@L2330B_2_dtp03_573_date_claim_paid,
				@L2330B_2_ref02_2U_other_payer_secondary_id,
				@L2330B_2_ref02_F8_other_payer_secondary_id,
				@L2330B_2_ref02_FY_other_payer_secondary_id,
				@L2330B_2_ref02_NF_other_payer_secondary_id,
				@L2330B_2_ref02_TJ_other_payer_secondary_id,
				@L2330B_2_ref02_9F_other_payer_auth_num,
				@L2330B_2_ref02_G1_other_payer_auth_num,
				@L2320_3_sbr01_payer_resp_seq_code,
				@L2320_3_sbr02_ind_relationship_code,
				@L2320_3_sbr03_insured_grp_policy_num,
				@L2320_3_sbr04_insured_grp_nm,
				@L2320_3_sbr09_claim_file_ind_code,
				@L2320_3_cas01_adjustment_group_code,
				@L2320_3_cas02_adjustment_reason_code,
				@L2320_3_cas03_adjustment_amt,
				@L2320_3_cas04_adjustment_qty,
				@L2320_3_cas05_adjustment_reason_code,
				@L2320_3_cas06_adjustment_amt,
				@L2320_3_cas07_adjustment_qty,
				@L2320_3_cas08_adjustment_reason_code,
				@L2320_3_cas09_adjustment_amt,
				@L2320_3_cas10_adjustment_qty,
				@L2320_3_amt02_C4_payer_prior_pmt_amt,
				@L2320_3_amt02_B6_cob_allowed_amt,
				@L2320_3_amt02_T3_cob_submitted_amt,
				@L2320_3_amt02_ZZ_drg_outlier_amt,
				@L2320_3_amt02_N1_cob_medicare_paid_amt,
				@L2320_3_amt02_KF_medicare_paid_100_amt,
				@L2320_3_amt02_PG_medicare_paid_80_amt,
				@L2320_3_amt02_AA_cob_medicare_a_trust_pd_amt,
				@L2320_3_amt02_B1_cob_medicare_b_trust_pd_amt,
				@L2320_3_amt02_A8_cob_non_cvd_amt,
				@L2320_3_amt02_YT_cob_denied_amt,
				@L2320_3_dmg02_other_subscriber_dob,
				@L2320_3_dmg03_other_subscriber_gender,
				@L2320_3_oi03_other_ins_benefit_assign_ind,
				@L2320_3_oi06_other_ins_release_of_info_code,
				@L2330A_3_nm101_entity_id_code,
				@L2330A_3_nm102_entity_type_qual,
				@L2330A_3_nm103_other_subscriber_last_name,
				@L2330A_3_nm104_other_subscriber_first_name,
				@L2330A_3_nm105_other_subscriber_middle_name,
				@L2330A_3_nm107_other_subscriber_name_suffix,
				@L2330A_3_nm108_other_subscriber_id_code_qual,
				@L2330A_3_nm109_other_subscriber_id,
				@L2330B_3_nm101_entity_id_code,
				@L2330B_3_nm102_entity_type_qual,
				@L2330B_3_nm103_other_payer_nm,
				@L2330B_3_nm108_id_code_qual,
				@L2330B_3_nm109_other_payer_id,
				@L2330B_3_dtp03_573_date_claim_paid,
				@L2330B_3_ref02_2U_other_payer_secondary_id,
				@L2330B_3_ref02_F8_other_payer_secondary_id,
				@L2330B_3_ref02_FY_other_payer_secondary_id,
				@L2330B_3_ref02_NF_other_payer_secondary_id,
				@L2330B_3_ref02_TJ_other_payer_secondary_id,
				@L2330B_3_ref02_9F_other_payer_auth_num,
				@L2330B_3_ref02_G1_other_payer_auth_num,
				@L2400_lx01_assigned_num, 
				@L2400_sv201_rev_code, 
				@L2400_sv202_proc_code_qual,
				@L2400_sv202_proc_code, 
				@L2400_sv202_proc_mod1,
				@L2400_sv202_proc_mod2,
				@L2400_sv202_proc_mod3,
				@L2400_sv202_proc_mod4,
				@L2400_sv203_line_charge,
				@L2400_sv204_measurement_code,
				@L2400_sv205_service_unit_count,
				@L2400_sv206_service_line_rate,
				@L2400_sv207_denied_amt, 
				@L2400_dtp02_472_from_service_date,
				@L2400_dtp02_472_to_service_date,
				@L2400_dtp02_866_format_qual,
				@L2400_dtp02_866_assess_date,
				@L2410_1_lin03_N4_ndc,
				@L2420A_nm102_entity_type_qual,
				@L2420A_nm103_attending_physician_last_nm,
				@L2420A_nm104_attending_physician_first_nm,
				@L2420A_nm105_attending_physician_middle_nm,
				@L2420A_nm107_attending_physician_suffix,
				@L2420A_nm108_id_code_qual,
				@L2420A_nm109_attending_physician_id,
				@L2420A_ref02_1C_attending_prov_id,
				@L2420A_ref02_1D_attending_prov_id,
				@L2420A_ref02_1G_attending_prov_id,
				@L2420A_ref02_EI_attending_prov_id,
				@L2420A_ref02_SY_attending_prov_id,
				@L2420A_ref02_FH_attending_prov_id,
				@L2420B_nm102_entity_type_qual,
				@L2420B_nm103_operating_prov_last_nm,
				@L2420B_nm104_operating_prov_first_nm,
				@L2420B_nm105_operating_prov_middle_nm,
				@L2420B_nm107_operating_prov_suffix,
				@L2420B_nm108_id_code_qual,
				@L2420B_nm109_operating_prov_id,
				@L2420B_ref02_1C_operating_prov_id,
				@L2420B_ref02_1D_operating_prov_id,
				@L2420B_ref02_1G_operating_prov_id,
				@L2420B_ref02_EI_operating_prov_id,
				@L2420B_ref02_SY_operating_prov_id,
				@L2420B_ref02_FH_operating_prov_id,
				@L2420C_nm102_entity_type_qual,
				@L2420C_nm103_other_prov_last_nm,
				@L2420C_nm104_other_prov_first_nm,
				@L2420C_nm105_other_prov_middle_nm,
				@L2420C_nm107_other_prov_suffix,
				@L2420C_nm108_id_code_qual,
				@L2420C_nm109_other_prov_id,	
				@L2420C_ref02_1C_other_prov_id,
				@L2420C_ref02_1D_other_prov_id,
				@L2420C_ref02_1G_other_prov_id,
				@L2420C_ref02_G2_other_prov_id,
				@L2430_svd01_payer_id,
				@L2430_svd02_service_line_paid,
				@L2430_svd03_proc_code_qual,
				@L2430_svd03_proc_code, 
				@L2430_svd03_proc_mod1,
				@L2430_svd03_proc_mod2,
				@L2430_svd03_proc_mod3,
				@L2430_svd03_proc_mod4,
				@L2430_svd04_rev_code, 
				@L2430_svd05_adj_qty,
				@L2430_svd06_bundled_line_num, 
				@L2430_cas01_adjustment_group_code,
				@L2430_cas02_adjustment_reason_code, 
				@L2430_cas03_adjustment_amt, 
				@L2430_cas04_adjustment_qty,
				@L2430_cas05_adjustment_reason_code, 
				@L2430_cas06_adjustment_amt, 
				@L2430_cas07_adjustment_qty,
				@L2430_cas08_adjustment_reason_code, 
				@L2430_cas09_adjustment_amt, 
				@L2430_cas10_adjustment_qty,
				@L2430_1_cas01_adjustment_group_code,
				@L2430_1_cas02_adjustment_reason_code,
				@L2430_1_cas03_adjustment_amt,
				@L2430_1_cas04_adjustment_qty,
				@L2430_1_cas05_adjustment_reason_code,
				@L2430_1_cas06_adjustment_amt,
				@L2430_1_cas07_adjustment_qty,
				@L2430_1_cas08_adjustment_reason_code,
				@L2430_1_cas09_adjustment_amt,
				@L2430_1_cas10_adjustment_qty,
				@L2430_1_cas11_adjustment_reason_code,
				@L2430_1_cas12_adjustment_amt,
				@L2430_1_cas13_adjustment_qty,
				@L2430_1_cas14_adjustment_reason_code,
				@L2430_1_cas15_adjustment_amt,
				@L2430_1_cas16_adjustment_qty,
				@L2430_1_cas17_adjustment_reason_code,
				@L2430_1_cas18_adjustment_amt,
				@L2430_1_cas19_adjustment_qty,
				@L2430_2_cas01_adjustment_group_code,
				@L2430_2_cas02_adjustment_reason_code,
				@L2430_2_cas03_adjustment_amt,
				@L2430_2_cas04_adjustment_qty,
				@L2430_2_cas05_adjustment_reason_code,
				@L2430_2_cas06_adjustment_amt,
				@L2430_2_cas07_adjustment_qty,
				@L2430_2_cas08_adjustment_reason_code,
				@L2430_2_cas09_adjustment_amt,
				@L2430_2_cas10_adjustment_qty,
				@L2430_2_cas11_adjustment_reason_code,
				@L2430_2_cas12_adjustment_amt,
				@L2430_2_cas13_adjustment_qty,
				@L2430_2_cas14_adjustment_reason_code,
				@L2430_2_cas15_adjustment_amt,
				@L2430_2_cas16_adjustment_qty,
				@L2430_2_cas17_adjustment_reason_code,
				@L2430_2_cas18_adjustment_amt,
				@L2430_2_cas19_adjustment_qty,
				@L2430_3_cas01_adjustment_group_code,
				@L2430_3_cas02_adjustment_reason_code,
				@L2430_3_cas03_adjustment_amt,
				@L2430_3_cas04_adjustment_qty,
				@L2430_3_cas05_adjustment_reason_code,
				@L2430_3_cas06_adjustment_amt,
				@L2430_3_cas07_adjustment_qty,
				@L2430_3_cas08_adjustment_reason_code,
				@L2430_3_cas09_adjustment_amt,
				@L2430_3_cas10_adjustment_qty,
				@L2430_3_cas11_adjustment_reason_code,
				@L2430_3_cas12_adjustment_amt,
				@L2430_3_cas13_adjustment_qty,
				@L2430_3_cas14_adjustment_reason_code,
				@L2430_3_cas15_adjustment_amt,
				@L2430_3_cas16_adjustment_qty,
				@L2430_3_cas17_adjustment_reason_code,
				@L2430_3_cas18_adjustment_amt,
				@L2430_3_cas19_adjustment_qty,
				@L2430_4_cas01_adjustment_group_code,
				@L2430_4_cas02_adjustment_reason_code,
				@L2430_4_cas03_adjustment_amt,
				@L2430_4_cas04_adjustment_qty,
				@L2430_4_cas05_adjustment_reason_code,
				@L2430_4_cas06_adjustment_amt,
				@L2430_4_cas07_adjustment_qty,
				@L2430_4_cas08_adjustment_reason_code,
				@L2430_4_cas09_adjustment_amt,
				@L2430_4_cas10_adjustment_qty,
				@L2430_4_cas11_adjustment_reason_code,
				@L2430_4_cas12_adjustment_amt,
				@L2430_4_cas13_adjustment_qty,
				@L2430_4_cas14_adjustment_reason_code,
				@L2430_4_cas15_adjustment_amt,
				@L2430_4_cas16_adjustment_qty,
				@L2430_4_cas17_adjustment_reason_code,
				@L2430_4_cas18_adjustment_amt,
				@L2430_4_cas19_adjustment_qty,
				@L2430_5_cas01_adjustment_group_code,
				@L2430_5_cas02_adjustment_reason_code,
				@L2430_5_cas03_adjustment_amt,
				@L2430_5_cas04_adjustment_qty,
				@L2430_5_cas05_adjustment_reason_code,
				@L2430_5_cas06_adjustment_amt,
				@L2430_5_cas07_adjustment_qty,
				@L2430_5_cas08_adjustment_reason_code,
				@L2430_5_cas09_adjustment_amt,
				@L2430_5_cas10_adjustment_qty,
				@L2430_5_cas11_adjustment_reason_code,
				@L2430_5_cas12_adjustment_amt,
				@L2430_5_cas13_adjustment_qty,
				@L2430_5_cas14_adjustment_reason_code,
				@L2430_5_cas15_adjustment_amt,
				@L2430_5_cas16_adjustment_qty,
				@L2430_5_cas17_adjustment_reason_code,
				@L2430_5_cas18_adjustment_amt,
				@L2430_5_cas19_adjustment_qty,
				@L2430_dtp03_573_service_adjudication_date
	
WHILE (@@fetch_status <> -1)
BEGIN

	-- Insert the BHT segment
	if (	ISNULL(@bht01_hierarchical_structure_code,'') <> ISNULL(@prev_bht01_hierarchical_structure_code,'') OR
		ISNULL(@bht02_trans_set_purpose_code,'') <> ISNULL(@prev_bht02_trans_set_purpose_code,'') OR
		ISNULL(@bht03_orig_app_tran_id,'') <> ISNULL(@prev_bht03_orig_app_tran_id,'') OR
		ISNULL(@bht04_trans_set_creation_date,'') <> ISNULL(@prev_bht04_trans_set_creation_date,'') OR
		ISNULL(@bht05_trans_set_creation_time,'') <> ISNULL(@prev_bht05_trans_set_creation_time,'') OR
		ISNULL(@bht06_claim_encounter_id,'') <> ISNULL(@prev_bht06_claim_encounter_id,'') OR
		@prev_bht01_hierarchical_structure_code IS NULL)
	Begin
		if 	(@bht01_hierarchical_structure_code IS NOT NULL)
		begin
			exec up_x12_bht_export	@x12_interchange_uid = @x12_interchange_uid,
						@bht01_hierarchical_structure_code = @bht01_hierarchical_structure_code,
						@bht02_tran_purpose_code = @bht02_trans_set_purpose_code,
						@bht03_app_tran_id = @bht03_orig_app_tran_id,
						@bht04_tran_set_create_date = @bht04_trans_set_creation_date,
						@bht05_tran_set_create_time = @bht05_trans_set_creation_time,
						@bht06_tran_type_code = @bht06_claim_encounter_id
		end
	end

	-- Insert the REF segment
	if (	ISNULL(@ref01_receiver_ref_id_qual,'') <> ISNULL(@prev_ref01_receiver_ref_id_qual,'') OR
		ISNULL(@ref02_transmission_type_code,'') <> ISNULL(@prev_ref02_transmission_type_code,'') OR
		@prev_ref01_receiver_ref_id_qual IS NULL)
	Begin
		if (@ref01_receiver_ref_id_qual is NOT NULL)
		Begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = @ref01_receiver_ref_id_qual,
						@ref02_reference_number = @ref02_transmission_type_code

			 
		end
			
	end

	-- BEGIN 1000A LOOP
	if (	@L1000A_nm108_submitter_id_qual IS NOT NULL AND
		IsNull(@L1000A_nm103_submitter_last_nm, '') <> IsNull(@prev_L1000A_nm103_submitter_last_nm, '')
	   )
	begin
		-- If the 1000A loop is used, the NM1 segment is always required.
		exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
					@nm101_entity_id_code = '41',
					@nm103_last_name = @L1000A_nm103_submitter_last_nm,
					@nm104_first_name = @L1000A_nm104_submitter_first_nm,
					@nm105_middle_name = @L1000A_nm105_submitter_middle_nm,
					@nm108_id_code_qual = @L1000A_nm108_submitter_id_qual,
					@nm109_id_code = @L1000A_nm109_submitter_id

		 

		-- If the 1000A loop is used, the PER segment is always required.
		exec up_x12_per_export	@x12_interchange_uid = @x12_interchange_uid,
					@perf01_contact_function_code = @L1000A_per01_contact_function_code,
					@perf02_contact_name = @L1000A_per02_contact_nm,
					@perf03_contact_number_qual = @L1000A_per03_comm_num_qual,
					@perf04_contact_number = @L1000A_per04_comm_number

		 
	end
	-- END 1000A LOOP
			
	-- BEGIN 1000B LOOP
	if (	@L1000B_nm102_entity_type_qual IS NOT NULL AND
		IsNull(@L1000B_nm103_receiver_last_nm, '') <> IsNull(@prev_L1000B_nm103_receiver_last_nm, '')
	   )
	begin
		exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
					@nm101_entity_id_code = '40',
					@nm103_last_name = @L1000B_nm103_receiver_last_nm,
					@nm108_id_code_qual = @L1000B_nm108_receiver_id_qual,
					@nm109_id_code = @L1000B_nm109_receiver_id

		 
	end
	-- END 1000B LOOP




	-- if the HL segment values were populated, use them.
	-- if the HL segment values were not populated, they need to be created here.
	if (@L2000A_hl01_hierarchical_id_num IS NULL)
	begin
		-- if any of the below are different than the previous value, this is a new provider

		if (
			BINARY_CHECKSUM(	@prev_L2010AA_nm103_billing_prov_last_nm,
						@prev_L2010AA_nm104_billing_prov_first_nm,
						@prev_L2010AA_nm105_billing_prov_middle_nm,
						@prev_L2010AA_nm107_billing_prov_suffix,
						@prev_L2010AA_nm108_id_code_qual,
						@prev_L2010AA_nm109_billing_prov_id,
						@prev_L2010AA_n301_billing_prov_address1,
						@prev_L2010AA_n302_billing_prov_address2,
						@prev_L2010AA_n401_billing_prov_city,
						@prev_L2010AA_n402_billing_prov_state,
						@prev_L2010AA_n403_billing_prov_zip,
						@prev_L2010AA_n404_billing_prov_country,
						@prev_L2010AA_ref02_1C_billing_prov_id,
						@prev_L2010AA_ref02_1D_billing_prov_id,
						@prev_L2010AA_ref02_1G_billing_prov_id,
						@prev_L2010AA_ref02_EI_billing_prov_id,
						@prev_L2010AA_ref02_SY_billing_prov_id,
						@prev_L2010AA_ref02_FH_billing_prov_id
					) <>
			BINARY_CHECKSUM(	@L2010AA_nm103_billing_prov_last_nm,
						@L2010AA_nm104_billing_prov_first_nm,
						@L2010AA_nm105_billing_prov_middle_nm,
						@L2010AA_nm107_billing_prov_suffix,
						@L2010AA_nm108_id_code_qual,
						@L2010AA_nm109_billing_prov_id,
						@L2010AA_n301_billing_prov_address1,
						@L2010AA_n302_billing_prov_address2,
						@L2010AA_n401_billing_prov_city,
						@L2010AA_n402_billing_prov_state,
						@L2010AA_n403_billing_prov_zip,
						@L2010AA_n404_billing_prov_country,
						@L2010AA_ref02_1C_billing_prov_id,
						@L2010AA_ref02_1D_billing_prov_id,
						@L2010AA_ref02_1G_billing_prov_id,
						@L2010AA_ref02_EI_billing_prov_id,
						@L2010AA_ref02_SY_billing_prov_id,
						@L2010AA_ref02_FH_billing_prov_id

					)
		)
		begin
			set @global_hl01_hierarchical_id_num = @global_hl01_hierarchical_id_num + 1
			set @L2000A_hl01_hierarchical_id_num = STR(@global_hl01_hierarchical_id_num)
		end
		else
		begin
			set @L2000A_hl01_hierarchical_id_num = @prev_L2000A_hl01_hierarchical_id_num
		end
	end


	-- BEGIN 2000A LOOP
	if (	ISNULL(@L2000A_hl01_hierarchical_id_num,'') <> ISNULL(@prev_L2000A_hl01_hierarchical_id_num,'') OR
		@prev_L2000A_hl01_hierarchical_id_num IS NULL)
	begin
		if (@L2000A_hl01_hierarchical_id_num IS NULL)
		begin
			set @global_hl01_hierarchical_id_num = @global_hl01_hierarchical_id_num + 1
			set @L2000A_hl01_hierarchical_id_num = STR(@global_hl01_hierarchical_id_num)
		end

--		set @prev_L2000A_hl01_hierarchical_id_num = @L2000A_hl01_hierarchical_id_num

		exec up_x12_hl_export	@x12_interchange_uid = @x12_interchange_uid,
					@hl01_id_num = @L2000A_hl01_hierarchical_id_num,
					@hl03_level_code = '20',
					@hl04_child_code = '1'

		 
			
	
		if 	(@L2000A_prv01_provider_code IS NOT NULL)
		begin
			exec up_x12_prv_export	@x12_interchange_uid = @x12_interchange_uid,
						@prv01_provider_code = @L2000A_prv01_provider_code,
						@prv02_provider_id_qual = @L2000A_prv02_ref_id_qual,
						@prv03_provider_id = @L2000A_prv03_taxonomy_code
				
			 
		end
	
		if 	(@L2000A_cur02_currency_code IS NOT NULL)
		begin
			exec up_x12_cur_export	@x12_interchange_uid = @x12_interchange_uid,
						@cur01_entity_id_code = '85',
						@cur02_currency_code = @L2000A_cur02_currency_code
		end
	

		-- The 2010AA Loop is always required within the 2000A Loop; the NM1 segment is always required.
		exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
					@nm101_entity_id_code = '85',
					@nm103_last_name = @L2010AA_nm103_billing_prov_last_nm,
					@nm104_first_name = @L2010AA_nm104_billing_prov_first_nm,
					@nm105_middle_name = @L2010AA_nm105_billing_prov_middle_nm,
					@nm107_name_suffix = @L2010AA_nm107_billing_prov_suffix,
					@nm108_id_code_qual = @L2010AA_nm108_id_code_qual,
					@nm109_id_code = @L2010AA_nm109_billing_prov_id
			
		 
	
	-- Insert of the N3 Segment
		exec up_x12_n3_export	@x12_interchange_uid = @x12_interchange_uid,
					@n301_address1 = @L2010AA_n301_billing_prov_address1,
					@n302_address2 = @L2010AA_n302_billing_prov_address2

		 
	-- Insert of the N4 Segment
		exec up_x12_n4_export	@x12_interchange_uid = @x12_interchange_uid,
					@n401_city = @L2010AA_n401_billing_prov_city,
					@n402_state = @L2010AA_n402_billing_prov_state,
					@n403_zip = @L2010AA_n403_billing_prov_zip

		 
				
	
	-- BEGIN: 2010 REF SEGMENTS
	
	-- 2010AA Loop REF 1C segment
		if 	(@L2010AA_ref02_1C_billing_prov_id IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = '1C',
						@ref02_reference_number = @L2010AA_ref02_1C_billing_prov_id
				
			 
		end
	-- 2010AA Loop REF 1D Segment
		if 	(@L2010AA_ref02_1D_billing_prov_id  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = '1D',
						@ref02_reference_number = @L2010AA_ref02_1D_billing_prov_id
	
			 
		end
	-- 2010AA Loop REF 1G Segment
		if 	(@L2010AA_ref02_1G_billing_prov_id  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = '1G',
						@ref02_reference_number = @L2010AA_ref02_1G_billing_prov_id
	
			 
		end
	-- 2010AA Loop REF EI Segment
		if 	(@L2010AA_ref02_EI_billing_prov_id  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'EI',
						@ref02_reference_number = @L2010AA_ref02_EI_billing_prov_id
	
			 
		end
	-- 2010AA Loop REF SY
		if 	(@L2010AA_ref02_SY_billing_prov_id  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'SY',
						@ref02_reference_number = @L2010AA_ref02_SY_billing_prov_id
	
			 
		end
	-- 2010AA Loop REF FH
		if 	(@L2010AA_ref02_FH_billing_prov_id  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'FH',
						@ref02_reference_number = @L2010AA_ref02_FH_billing_prov_id
				
			 
		end
	-- 2010AA Loop REF 06
		if 	(@L2010AA_ref02_06_card_billing_id  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = '06',
						@ref02_reference_number = @L2010AA_ref02_06_card_billing_id
	
			 
		end
	-- 2010AA Loop REF 8U
		if 	(@L2010AA_ref02_8U_card_billing_id  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = '8U',
						@ref02_reference_number = @L2010AA_ref02_8U_card_billing_id
					
			 
		end
	-- 2010AA Loop REF EM
		if 	(@L2010AA_ref02_EM_card_billing_id  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'EM',
						@ref02_reference_number = @L2010AA_ref02_EM_card_billing_id
				
			 
		end
	
	-- 2010AA Loop REF IJ
		if 	(@L2010AA_ref02_IJ_card_billing_id  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'IJ',
						@ref02_reference_number = @L2010AA_ref02_IJ_card_billing_id
				
			 
		end
	-- 2010AA Loop REF LU
		if 	(@L2010AA_ref02_LU_card_billing_id  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'LU',
						@ref02_reference_number = @L2010AA_ref02_LU_card_billing_id
				
			 
		end
	-- 2010AA Loop REF ST
		if 	(@L2010AA_ref02_ST_card_billing_id  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'ST',
						@ref02_reference_number = @L2010AA_ref02_ST_card_billing_id
				
			 
		end
	
	--End of 2010AA REF LOOP
		if 	(@L2010AA_per01_billing_prov_comm_func_code IS NOT NULL)
		begin
			exec up_x12_per_export	@x12_interchange_uid = @x12_interchange_uid,
						@perf01_contact_function_code = @L2010AA_per01_billing_prov_comm_func_code,
						@perf02_contact_name = @L2010AA_per02_billing_prov_contact_nm,
						@perf03_contact_number_qual = @L2010AA_per03_billing_prov_comm_num_qual,
						@perf04_contact_number = @L2010AA_per04_billing_prov_comm

			 
		end
		-- END OF 2010AA LOOP
	
	-- Pay to provider loop NM1 2010AB
		if (	@L2010AB_nm108_id_code_qual IS NOT NULL OR
			@L2010AB_nm109_payto_prov_id IS NOT NULL OR 
			@L2010AB_nm103_payto_prov_last_nm IS NOT NULL)
		begin
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = '87',
						@nm103_last_name = @L2010AB_nm103_payto_prov_last_nm,
						@nm104_first_name = @L2010AB_nm104_payto_prov_first_nm,
						@nm105_middle_name = @L2010AB_nm105_payto_prov_middle_nm,
						@nm107_name_suffix = @L2010AB_nm107_payto_prov_suffix,
						@nm108_id_code_qual = @L2010AB_nm108_id_code_qual,
						@nm109_id_code = @L2010AB_nm109_payto_prov_id

			 

		-- Insert of the N3 Segment for loop 2010AB
			exec up_x12_n3_export	@x12_interchange_uid = @x12_interchange_uid,
						@n301_address1 = @L2010AB_n301_payto_prov_address1,
						@n302_address2 = @L2010AB_n302_payto_prov_address2

			 
					
		
		-- Insert of the N4 Segment for loop 2010AB
			exec up_x12_n4_export	@x12_interchange_uid = @x12_interchange_uid,
						@n401_city = @L2010AB_n401_payto_prov_city,
						@n402_state = @L2010AB_n402_payto_prov_state,
						@n403_zip = @L2010AB_n403_payto_prov_zip

			 
		
		-- BEGIN: 2010AB REF SEGMENTS
		
		-- 2010AB Loop REF 1C segment
			if 	(@L2010AB_ref02_1C_payto_prov_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1C',
							@ref02_reference_number = @L2010AB_ref02_1C_payto_prov_id
					
				 
			end
		-- 2010AB Loop REF 1D Segment
			if 	(@L2010AB_ref02_1D_payto_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1D',
							@ref02_reference_number = @L2010AB_ref02_1D_payto_prov_id
					
				 
			end
		-- 2010AB Loop REF 1G Segment
			if 	(@L2010AB_ref02_1G_payto_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1G',
							@ref02_reference_number = @L2010AB_ref02_1G_payto_prov_id
					
				 
			end
		-- 2010AB Loop REF EI Segment
			if 	(@L2010AB_ref02_EI_payto_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'EI',
							@ref02_reference_number = @L2010AB_ref02_EI_payto_prov_id
					
				 
			end
		-- 2010AB Loop REF SY
			if 	(@L2010AB_ref02_SY_payto_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'SY',
							@ref02_reference_number = @L2010AB_ref02_SY_payto_prov_id
					
				 
			end
		-- 2010AB Loop REF FH
			if 	(@L2010AB_ref02_FH_payto_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'FH',
							@ref02_reference_number = @L2010AB_ref02_FH_payto_prov_id
					
				 
			end
		end
		-- End of 2010AB LOOP
	end
	-- END OF 2000A LOOP GROUPING
		

	-- if the HL segment values were populated, use them.
	-- if the HL segment values were not populated, they need to be created here.
	if (@L2000B_hl01_hierarchical_id_num IS NULL)
	begin
		-- if any of the below are different than the previous value, this is a new provider

		if (
			BINARY_CHECKSUM(	@prev_L2000A_hl01_hierarchical_id_num,
						@prev_L2000B_sbr01_payer_resp_seq_code,
						@prev_L2000B_sbr02_ind_relationship_code,
						@prev_L2000B_sbr03_insured_grp_policy_num,
						@prev_L2000B_sbr04_insured_grp_nm,
						@prev_L2000B_sbr09_claim_id_code,
						@prev_L2010BA_nm103_subscriber_last_nm,
						@prev_L2010BA_nm104_subscriber_first_nm,
						@prev_L2010BA_nm105_subscriber_middle_nm,
						@prev_L2010BA_nm107_subscriber_suffix,
						@prev_L2010BA_nm108_id_code_qual,
						@prev_L2010BA_nm109_subscriber_id,
						@prev_L2010BA_n301_subscriber_address1,
						@prev_L2010BA_n302_subscriber_address2,
						@prev_L2010BA_n401_subscriber_city,
						@prev_L2010BA_n402_subscriber_state,
						@prev_L2010BA_n403_subscriber_zip) <>
			BINARY_CHECKSUM(	@L2000A_hl01_hierarchical_id_num,
						@L2000B_sbr01_payer_resp_seq_code,
						@L2000B_sbr02_ind_relationship_code,
						@L2000B_sbr03_insured_grp_policy_num,
						@L2000B_sbr04_insured_grp_nm,
						@L2000B_sbr09_claim_id_code,
						@L2010BA_nm103_subscriber_last_nm,
						@L2010BA_nm104_subscriber_first_nm,
						@L2010BA_nm105_subscriber_middle_nm,
						@L2010BA_nm107_subscriber_suffix,
						@L2010BA_nm108_id_code_qual,
						@L2010BA_nm109_subscriber_id,
						@L2010BA_n301_subscriber_address1,
						@L2010BA_n302_subscriber_address2,
						@L2010BA_n401_subscriber_city,
						@L2010BA_n402_subscriber_state,
						@L2010BA_n403_subscriber_zip )
		)
		begin
			set @global_hl01_hierarchical_id_num = @global_hl01_hierarchical_id_num + 1
			set @L2000B_hl01_hierarchical_id_num = STR(@global_hl01_hierarchical_id_num)

			if (@L2000B_hl02_hierarchical_parent_id_num IS NULL)
			begin
				set @L2000B_hl02_hierarchical_parent_id_num = @L2000A_hl01_hierarchical_id_num
			end
		end
		else
		begin
			set @L2000B_hl01_hierarchical_id_num = @prev_L2000B_hl01_hierarchical_id_num
			set @L2000B_hl02_hierarchical_parent_id_num = @prev_L2000B_hl02_hierarchical_parent_id_num
		end
	end

--BEGIN 2000B LOOP GROUPING
	if (	ISNULL(@L2000B_hl01_hierarchical_id_num,'') <> ISNULL(@prev_L2000B_hl01_hierarchical_id_num,'') OR
		ISNULL(@L2000B_hl02_hierarchical_parent_id_num,'') <> ISNULL(@prev_L2000B_hl02_hierarchical_parent_id_num,'') OR
		@prev_L2000B_hl01_hierarchical_id_num IS NULL)
	begin
		if (@L2000B_hl01_hierarchical_id_num IS NULL)
		begin
			set @global_hl01_hierarchical_id_num = @global_hl01_hierarchical_id_num + 1
			set @L2000B_hl01_hierarchical_id_num = STR(@global_hl01_hierarchical_id_num)
		end

		if (@L2000B_hl02_hierarchical_parent_id_num IS NULL)
		begin
			set @L2000B_hl02_hierarchical_parent_id_num = @L2000A_hl01_hierarchical_id_num
		end

		if (@L2000B_hl04_hierarchical_child_code IS NULL)
		begin
			set @L2000B_hl04_hierarchical_child_code = '0'
		end

		set @prev_L2000B_hl01_hierarchical_id_num = @L2000B_hl01_hierarchical_id_num

		if 	(@L2000B_hl01_hierarchical_id_num IS NOT NULL)
		begin
			exec up_x12_hl_export	@x12_interchange_uid = @x12_interchange_uid,
						@hl01_id_num = @L2000B_hl01_hierarchical_id_num,
						@hl02_parent_id_num = @L2000B_hl02_hierarchical_parent_id_num,
						@hl03_level_code = '22',
						@hl04_child_code = @L2000B_hl04_hierarchical_child_code
		end

		if 	(@L2000B_hl01_hierarchical_id_num IS NOT NULL)
		begin
			exec up_x12_sbr_export	@x12_interchange_uid = @x12_interchange_uid,
						@sbr01_payer_resp_seq_code = @L2000B_sbr01_payer_resp_seq_code,
						@sbr02_ind_relationship_code = @L2000B_sbr02_ind_relationship_code,
						@sbr03_insured_grp_policy_num = @L2000B_sbr03_insured_grp_policy_num,
						@sbr04_insured_grp_nm = @L2000B_sbr04_insured_grp_nm,
						@sbr09_claim_filing_ind_code = @L2000B_sbr09_claim_id_code
		end

		/*
		These segments are misc information. This checks to see if any of the fields have data.
		If data is found then we insert it. There are some requirements for example
		L2000B_pat06_insured_ind_death_date must be precluded by a D8 when present.
		If @L2000B_pat08_patient_weight or @L2000B_pat09_pregnancy_indicator is present the other is required. 
		*/
		if (	@L2000B_pat06_insured_ind_death_date IS NOT NULL OR
			@L2000B_pat08_patient_weight IS NOT NULL OR
			@L2000B_pat09_pregnancy_indicator IS NOT NULL )
		begin
			Set @patdeathdate = ''
			if  (@L2000B_pat06_insured_ind_death_date IS NOT NULL)
			begin
				set @patdeathdate = 'D8'
			end
			
			exec up_x12_pat_export	@x12_interchange_uid = @x12_interchange_uid,
						@pat06_patient_death_date = @L2000B_pat06_insured_ind_death_date,
						@pat08_patient_weight = @L2000B_pat08_patient_weight,
						@pat09_pregnancy_ind = @L2000B_pat09_pregnancy_indicator
		end
	
		-- BEGIN: 2010BA-NM1 segment, this segment is always required.
		exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
					@nm101_entity_id_code = 'IL',
					@nm103_last_name = @L2010BA_nm103_subscriber_last_nm,
					@nm104_first_name = @L2010BA_nm104_subscriber_first_nm,
					@nm105_middle_name = @L2010BA_nm105_subscriber_middle_nm,
					@nm107_name_suffix = @L2010BA_nm107_subscriber_suffix,
					@nm108_id_code_qual = @L2010BA_nm108_id_code_qual,
					@nm109_id_code = @L2010BA_nm109_subscriber_id
		-- END: 2010BA-NM1


		-- if the subscriber city is not null, or the subscriber is the same as the patient, output the address info
		if (	@L2010BA_n301_subscriber_address1 IS NOT NULL OR
			IsNull(@L2000B_sbr02_ind_relationship_code, '') = '18')
		begin
			exec up_x12_n3_export	@x12_interchange_uid = @x12_interchange_uid,
						@n301_address1 = @L2010BA_n301_subscriber_address1,
						@n302_address2 = @L2010BA_n302_subscriber_address2

			 
		end
				
	
	-- Insert of the N4 Segment for loop 2010BA
	-- If the subscriber city is not null, or the subscriber is the same as the patient, output the city info.
		if (	@L2010BA_n401_subscriber_city IS NOT NULL OR
			IsNull(@L2000B_sbr02_ind_relationship_code, '') = '18')
		begin
			exec up_x12_n4_export	@x12_interchange_uid = @x12_interchange_uid,
						@n401_city = @L2010BA_n401_subscriber_city,
						@n402_state = @L2010BA_n402_subscriber_state,
						@n403_zip = @L2010BA_n403_subscriber_zip

			 
		end

				
		if (	@L2010BA_dmg02_subscriber_dob IS NOT NULL OR
			@L2010BA_dmg03_subscriber_gender IS NOT NULL OR
			IsNull(@L2000B_sbr02_ind_relationship_code, '') = '18')
		Begin
			exec up_x12_dmg_export	@x12_interchange_uid = @x12_interchange_uid,
						@dmg01_date_time_format_qual = 'D8',
						@dmg02_dob = @L2010BA_dmg02_subscriber_dob,
						@dmg03_gender = @L2010BA_dmg03_subscriber_gender
		end
	
	
	-- BEGIN: 2010BA REF SEGMENTS
	
	-- 2010BA Loop REF 1W segment
		if 	(@L2010BA_ref02_1W_subscriber_sup_id IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = '1W',
						@ref02_reference_number = @L2010BA_ref02_1W_subscriber_sup_id
				
			 
		end
	-- 2010BA Loop REF 23 Segment
		if 	(@L2010BA_ref02_23_subscriber_sup_id  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = '23',
						@ref02_reference_number = @L2010BA_ref02_23_subscriber_sup_id
				
			 
		end
	-- 2010BA Loop REF 1G Segment
		if 	(@L2010BA_ref02_IG_subscriber_sup_id  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = '1G',
						@ref02_reference_number = @L2010BA_ref02_IG_subscriber_sup_id
				
			 
		end
	-- 2010BA Loop REF SY Segment
		if 	(@L2010BA_ref02_SY_subscriber_sup_id  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'SY',
						@ref02_reference_number = @L2010BA_ref02_SY_subscriber_sup_id
				
			 
		end
	-- 2010BA Loop REF Y4
		if 	(@L2010BA_ref02_Y4_prop_casualty_claim_num  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'Y4',
						@ref02_reference_number = @L2010BA_ref02_Y4_prop_casualty_claim_num
				
			 
		end
	--End of 2010BA REF LOOP

	
	
	-- BEGIN: 2010BB REF SEGMENTS
		if (	@L2010BB_nm108_card_id_qual IS NOT NULL OR
			@L2010BB_nm109_card_num IS NOT NULL)
		begin
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = 'AO',
						@nm103_last_name = @L2010BB_nm103_card_holder_last_nm,
						@nm104_first_name = @L2010BB_nm104_card_holder_first_nm,
						@nm105_middle_name = @L2010BB_nm105_card_holder_middle_nm,
						@nm107_name_suffix = @L2010BB_nm107_card_holder_suffix,
						@nm108_id_code_qual = @L2010BB_nm108_card_id_qual,
						@nm109_id_code = @L2010BB_nm109_card_num

		-- 2010BB Loop REF AB Segment
			if 	(@L2010BB_ref02_AB_payer_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'AB',
							@ref02_reference_number = @L2010BB_ref02_AB_payer_id
					
				 
			end
		-- 2010BB Loop REF BB Segment
			if 	(@L2010BB_ref02_BB_payer_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'BB',
							@ref02_reference_number = @L2010BB_ref02_BB_payer_id
					
				 
			end
		end
	

	-- BEGIN: 2010BC LOOP
		if (	@L2010BC_nm103_payer_nm IS NOT NULL OR
			@L2010BC_nm108_payer_id_qual IS NOT NULL OR
			@L2010BC_nm109_payer_id IS NOT NULL )
		begin
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = 'PR',
						@nm103_last_name = @L2010BC_nm103_payer_nm,
						@nm108_id_code_qual = @L2010BC_nm108_payer_id_qual,
						@nm109_id_code = @L2010BC_nm109_payer_id

			 
						
		-- Insert of the N3 Segment for loop 2010BC
			if 	(@L2010BC_n301_payer_address1 IS NOT NULL)
			begin
				exec up_x12_n3_export	@x12_interchange_uid = @x12_interchange_uid,
							@n301_address1 = @L2010BC_n301_payer_address1,
							@n302_address2 = @L2010BC_n302_payer_address2
	
				 
			end
				
	
		-- Insert of the N4 Segment for loop 2010BC
			if 	(@L2010BC_n401_payer_city IS NOT NULL)
			begin
				exec up_x12_n4_export	@x12_interchange_uid = @x12_interchange_uid,
							@n401_city = @L2010BC_n401_payer_city,
							@n402_state = @L2010BC_n402_payer_state,
							@n403_zip = @L2010BC_n403_payer_zip
	
				 
			end

		-- 2010BC Loop REF 2U segment
			if 	(@L2010BC_ref02_2U_payer_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '2U',
							@ref02_reference_number = @L2010BC_ref02_2U_payer_id
			end
		-- 2010BC Loop REF FY Segment
			if 	(@L2010BC_ref02_FY_payer_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'FY',
							@ref02_reference_number = @L2010BC_ref02_FY_payer_id
			end
		-- 2010BC Loop REF NF Segment
			if 	(@L2010BC_ref02_NF_payer_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'NF',
							@ref02_reference_number = @L2010BC_ref02_NF_payer_id
			end
		-- 2010BC Loop REF NF Segment
			if 	(@L2010BC_ref02_TJ_payer_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'TJ',
							@ref02_reference_number = @L2010BC_ref02_TJ_payer_id
			end
		End	
	-- END: 2010BC LOOP

	-- BEGIN: 2010BD LOOP
		if ( @L2010BD_nm103_resp_party_last_nm IS NOT NULL )
		begin
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = 'QD',
						@nm103_last_name = @L2010BD_nm103_resp_party_last_nm,
						@nm104_first_name = @L2010BD_nm104_resp_party_first_nm,
						@nm105_middle_name = @L2010BD_nm105_resp_party_middle_nm,
						@nm107_name_suffix = @L2010BD_nm107_resp_party_suffix
				
			 

			-- The N3 segment is always required in this loop
			exec up_x12_n3_export	@x12_interchange_uid = @x12_interchange_uid,
						@n301_address1 = @L2010BD_n301_resp_party_address1,
						@n302_address2 = @L2010BD_n302_resp_party_address2

			 

			-- The N4 segment is always required in this loop
			exec up_x12_n4_export	@x12_interchange_uid = @x12_interchange_uid,
						@n401_city = @L2010BD_n401_resp_party_city,
						@n402_state = @L2010BD_n402_resp_party_state,
						@n403_zip = @L2010BD_n403_resp_party_zip
		end
	-- END: 2010BD LOOP
	end
-- END OF 2000B LOOP GROUPING



	-- if the HL segment values were populated, use them.
	-- if the HL segment values were not populated, they need to be created here.
	if ( IsNull(LTrim(RTrim(@L2000C_hl01_hierarchical_id_num)), '') = '' )
	begin
		-- if any of the below are different than the previous value, this is a new provider

		if (
			BINARY_CHECKSUM(	@prev_L2000A_hl01_hierarchical_id_num,
						@prev_L2000B_hl01_hierarchical_id_num,
						@prev_L2000B_sbr01_payer_resp_seq_code,
						@prev_L2000B_sbr02_ind_relationship_code,
						@prev_L2000B_sbr03_insured_grp_policy_num,
						@prev_L2000B_sbr04_insured_grp_nm,
						@prev_L2000B_sbr09_claim_id_code,
						@prev_L2010BA_nm103_subscriber_last_nm,
						@prev_L2010BA_nm104_subscriber_first_nm,
						@prev_L2010BA_nm105_subscriber_middle_nm,
						@prev_L2010BA_nm107_subscriber_suffix,
						@prev_L2010BA_nm108_id_code_qual,
						@prev_L2010BA_nm109_subscriber_id,
						@prev_L2010BA_n301_subscriber_address1,
						@prev_L2010BA_n302_subscriber_address2,
						@prev_L2010BA_n401_subscriber_city,
						@prev_L2010BA_n402_subscriber_state,
						@prev_L2010BA_n403_subscriber_zip,
						@prev_L2010CA_nm103_patient_last_nm,
						@prev_L2010CA_nm104_patient_first_nm,
						@prev_L2010CA_nm105_patient_middle_nm,
						@prev_L2010CA_nm107_patient_suffix,
						@prev_L2010CA_nm108_id_code_qual,
						@prev_L2010CA_nm109_patient_id ) <>
			BINARY_CHECKSUM(	@L2000A_hl01_hierarchical_id_num,
						@L2000B_hl01_hierarchical_id_num,
						@L2000B_sbr01_payer_resp_seq_code,
						@L2000B_sbr02_ind_relationship_code,
						@L2000B_sbr03_insured_grp_policy_num,
						@L2000B_sbr04_insured_grp_nm,
						@L2000B_sbr09_claim_id_code,
						@L2010BA_nm103_subscriber_last_nm,
						@L2010BA_nm104_subscriber_first_nm,
						@L2010BA_nm105_subscriber_middle_nm,
						@L2010BA_nm107_subscriber_suffix,
						@L2010BA_nm108_id_code_qual,
						@L2010BA_nm109_subscriber_id,
						@L2010BA_n301_subscriber_address1,
						@L2010BA_n302_subscriber_address2,
						@L2010BA_n401_subscriber_city,
						@L2010BA_n402_subscriber_state,
						@L2010BA_n403_subscriber_zip,
						@L2010CA_nm103_patient_last_nm,
						@L2010CA_nm104_patient_first_nm,
						@L2010CA_nm105_patient_middle_nm,
						@L2010CA_nm107_patient_suffix,
						@L2010CA_nm108_id_code_qual,
						@L2010CA_nm109_patient_id )
			AND IsNull(@L2000B_sbr02_ind_relationship_code, '') <> '18'
		)
		begin
			set @global_hl01_hierarchical_id_num = @global_hl01_hierarchical_id_num + 1
			set @L2000C_hl01_hierarchical_id_num = STR(@global_hl01_hierarchical_id_num)

			if (IsNull(LTrim(RTrim(@L2000C_hl02_hierarchical_parent_id_num)), '') = '')
			begin
				set @L2000C_hl02_hierarchical_parent_id_num = @L2000B_hl01_hierarchical_id_num
			end
		end
		else
		begin
			set @L2000C_hl01_hierarchical_id_num = @prev_L2000C_hl01_hierarchical_id_num
			set @L2000C_hl02_hierarchical_parent_id_num = @prev_L2000C_hl02_hierarchical_parent_id_num
		end
	end

-- BEGIN OF 2000C LOOP GROUPING
	if (	
		(	ISNULL(@L2000C_hl01_hierarchical_id_num,'') <> ISNULL(@prev_L2000C_hl01_hierarchical_id_num,'') OR
			ISNULL(@L2000C_hl02_hierarchical_parent_id_num,'') <> ISNULL(@prev_L2000C_hl02_hierarchical_parent_id_num,'')
		) AND
		IsNull(@L2000B_sbr02_ind_relationship_code, '') <> '18'
	   )
	begin
		if (IsNull(LTrim(RTrim(@L2000C_hl01_hierarchical_id_num)), '') = '')
		begin
			set @global_hl01_hierarchical_id_num = @global_hl01_hierarchical_id_num + 1
			set @L2000C_hl01_hierarchical_id_num = STR(@global_hl01_hierarchical_id_num)
		end

		if (IsNull(LTrim(RTrim(@L2000C_hl02_hierarchical_parent_id_num)), '') = '')
		begin
			set @L2000C_hl02_hierarchical_parent_id_num = @L2000B_hl01_hierarchical_id_num
		end

		if (IsNull(LTrim(RTrim(@L2000C_hl04_hierarchical_child_code)), '') = '')
		begin
			set @L2000C_hl04_hierarchical_child_code = '0'
		end

		set @prev_L2000C_hl01_hierarchical_id_num = @L2000C_hl01_hierarchical_id_num

		if ( IsNull(LTrim(RTrim(@L2000C_hl01_hierarchical_id_num)), '') <> '' )
		begin
			exec up_x12_hl_export	@x12_interchange_uid = @x12_interchange_uid,
						@hl01_id_num = @L2000C_hl01_hierarchical_id_num,
						@hl02_parent_id_num = @L2000C_hl02_hierarchical_parent_id_num,
						@hl03_level_code = '23',
						@hl04_child_code = '0'
		end
/*
		if (@L2000C_hl01_hierarchical_id_num IS NULL)
		begin
			set @global_hl01_hierarchical_id_num = @global_hl01_hierarchical_id_num + 1
			set @L2000C_hl01_hierarchical_id_num = STR(@global_hl01_hierarchical_id_num)
		end

		if (@L2000C_hl02_hierarchical_parent_id_num IS NULL)
		begin
			set @L2000C_hl02_hierarchical_parent_id_num = @L2000B_hl01_hierarchical_id_num
		end

		set @prev_L2000C_hl01_hierarchical_id_num = @L2000C_hl01_hierarchical_id_num

		if 	(@prev_L2000C_hl01_hierarchical_id_num IS NOT NULL)
		begin
			exec up_x12_hl_export	@x12_interchange_uid = @x12_interchange_uid,
						@hl01_id_num = @L2000C_hl01_hierarchical_id_num,
						@hl02_parent_id_num = @L2000C_hl02_hierarchical_parent_id_num,
						@hl03_level_code = '23',
						@hl04_child_code = '0'
			 
		end
*/

		-- BEGIN: 2010CA-PAT segment, this segment is always required in the 2010CA loop.
		exec up_x12_pat_export	@x12_interchange_uid = @x12_interchange_uid,
					@pat01_ind_rel_code = @L2000C_pat01_ind_relationship_code
		-- END: 2010CA-PAT

		-- BEGIN: 2010CA-NM1 segment, this segment is always required in the 2010CA loop.
		exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
					@nm101_entity_id_code = 'QC',
					@nm103_last_name = @L2010CA_nm103_patient_last_nm,
					@nm104_first_name = @L2010CA_nm104_patient_first_nm,
					@nm105_middle_name = @L2010CA_nm105_patient_middle_nm,
					@nm107_name_suffix = @L2010CA_nm107_patient_suffix,
					@nm108_id_code_qual = @L2010CA_nm108_id_code_qual,
					@nm109_id_code = @L2010CA_nm109_patient_id
		-- END: 2010CA-NM1

		-- BEGIN: 2010CA-N3 segment, this segment is always required in the 2010CA loop.
		exec up_x12_n3_export	@x12_interchange_uid = @x12_interchange_uid,
					@n301_address1 = @L2010CA_n301_patient_address1,
					@n302_address2 = @L2010CA_n302_patient_address2

		 
		-- END: 2010CA-N3

		-- BEGIN: 2010CA-N4 segment, this segment is always required in the 2010CA loop.
		exec up_x12_n4_export	@x12_interchange_uid = @x12_interchange_uid,
					@n401_city = @L2010CA_n401_patient_city,
					@n402_state = @L2010CA_n402_patient_state,
					@n403_zip = @L2010CA_n403_patient_zip

		 
		-- END: 2010CA-N4

		-- BEGIN: 2010CA-DMG segment, this segment is always required in the 2010CA loop.
		exec up_x12_dmg_export	@x12_interchange_uid = @x12_interchange_uid,
					@dmg01_date_time_format_qual = 'D8',
					@dmg02_dob = @L2010CA_dmg02_patient_dob,
					@dmg03_gender = @L2010CA_dmg03_patient_gender
		 
		-- END: 2010CA-DMG

		-- BEGIN: 2010CA REF SEGMENTS
			-- 2010CA Loop REF 1W segment
		if 	(@L2010CA_ref02_1W_patient_sup_id IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = '1W',
						@ref02_reference_number = @L2010CA_ref02_1W_patient_sup_id
				
			 
		end
		-- 2010CA Loop REF 23 Segment
		if 	(@L2010CA_ref02_23_patient_sup_id  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = '23',
						@ref02_reference_number = @L2010CA_ref02_23_patient_sup_id
				
			 
		end
		-- 2010CA Loop REF IG Segment
		if 	(@L2010CA_ref02_IG_patient_sup_id  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = '1G',
						@ref02_reference_number = @L2010CA_ref02_IG_patient_sup_id
				
			 
		end
	
		-- 2010CA Loop REF SY
		if 	(@L2010CA_ref02_SY_patient_sup_id  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'SY',
						@ref02_reference_number = @L2010CA_ref02_SY_patient_sup_id
				
			 
		end
		-- 2010CA Loop REF Y4
		if 	(@L2010CA_ref02_Y4_prop_casualty_claim_num  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'Y4',
						@ref02_reference_number = @L2010CA_ref02_Y4_prop_casualty_claim_num
				
			 
		end
	end
-- END OF 2000C LOOP GROUPING

-- BEGIN OF 2300 LOOP GROUPING
	-- If this is a different subscriber, a different patient, a different patient account number, or the charges are different, start a new 2300 LOOP.
	if	(	IsNull(@L2000B_hl01_hierarchical_id_num, '') <> IsNull(@prev_L2000B_hl01_hierarchical_id_num, '') OR
			IsNull(@L2000C_hl01_hierarchical_id_num, '') <> IsNull(@prev_L2000C_hl01_hierarchical_id_num, '') OR
			@L2300_clm01_pt_acct_num <> IsNull(@prev_L2300_clm01_pt_acct_num, '') OR
			@L2300_clm01_pt_acct_num IS NULL OR
			@L2300_clm02_total_claim_chg_amt <> @prev_L2300_clm02_total_claim_chg_amt OR
			@L2330B_1_ref02_F8_other_payer_secondary_id <> @prev_L2330B_1_ref02_F8_other_payer_secondary_id OR
			@L2330B_2_ref02_F8_other_payer_secondary_id <> @prev_L2330B_2_ref02_F8_other_payer_secondary_id OR
			@L2330B_3_ref02_F8_other_payer_secondary_id <> @prev_L2330B_3_ref02_F8_other_payer_secondary_id OR
			@L2300_ref02_F8_original_ref_num <> @prev_L2300_ref02_F8_original_ref_num
		)
	BEGIN
	
		-- Reset the previous LX value to NULL because we're definitely going to start a new procedure line.
		set @prev_L2400_lx01_assigned_num = null

		exec up_x12_clm_export	@x12_interchange_uid = @x12_interchange_uid,
					@clm01_pt_acct_num = @L2300_clm01_pt_acct_num,
					@clm02_total_claim_chg_amt = @L2300_clm02_total_claim_chg_amt,
					@clm05_facility_type_code = @L2300_clm05_facility_type_code,
					@clm05_claim_freq_code_qual = @L2300_clm05_facility_code_qual,
					@clm05_claim_freq_code = @L2300_clm05_claim_freq_code,
					@clm06_provider_signature_ind = @L2300_clm06_provider_signature_ind,
					@clm07_medicare_assign_code = @L2300_clm07_medicare_assign_code,
					@clm08_benefit_assign_ind = @L2300_clm08_benefit_assign_ind,
					@clm09_release_of_info_code = @L2300_clm09_release_of_info_code,
					@clm18_eob_indicator = @L2300_clm18_explan_benefits_ind,
					@clm20_delay_reason_code = @L2300_clm20_delay_reason_code

	-- Begin DTP 2300 Loops
		if 	(@L2300_dtp03_096_discharge_hour  IS NOT NULL)
		begin
			exec up_x12_dtp_export	@x12_interchange_uid = @x12_interchange_uid,
						@dtp01_date_time_qual = '096',
						@dtp02_date_time_format_qual = 'TM',
						@dtp03_begin_date = @L2300_dtp03_096_discharge_hour
	
			 
		end
		if 	(@L2300_dtp03_434_begin_statement_date  IS NOT NULL)
		begin
			exec up_x12_dtp_export	@x12_interchange_uid = @x12_interchange_uid,
						@dtp01_date_time_qual = '434',
						@dtp02_date_time_format_qual = 'RD8',
						@dtp03_begin_date = @L2300_dtp03_434_begin_statement_date,
						@dtp03_end_date = @L2300_dtp03_434_end_statement_date
	
			 
		end
		if 	(@L2300_dtp03_435_admission_date  IS NOT NULL)
		begin
			exec up_x12_dtp_export	@x12_interchange_uid = @x12_interchange_uid,
						@dtp01_date_time_qual = '435',
						@dtp02_date_time_format_qual = 'DT',
						@dtp03_begin_date = @L2300_dtp03_435_admission_date
	
			 
		end
	-- End DTP 2300 Loops

		-- Loop 2300-CL1 Segment
		if (	@L2300_cl101_admit_type_code IS NOT NULL OR
			@L2300_cl102_admit_source_code IS NOT NULL OR
			@L2300_cl103_patient_status_code IS NOT NULL )
		begin
			exec up_x12_cl1_export	@x12_interchange_uid = @x12_interchange_uid,
						@cl101_admit_type_code = @L2300_cl101_admit_type_code,
						@cl102_admit_source_code = @L2300_cl102_admit_source_code,
						@cl103_patient_status_code = @L2300_cl103_patient_status_code
		end	


		if (	@L2300_pwk01_attachment_type_code  IS NOT NULL OR
			@L2300_pwk02_attachment_trans_code IS NOT NULL OR
			@L2300_pwk06_attachment_control_num IS NOT NULL)
		begin
			exec up_x12_pwk_export	@x12_interchange_uid = @x12_interchange_uid,
						@pwk01_attach_rpt_type_code = @L2300_pwk01_attachment_type_code,
						@pwk02_attach_trans_code = @L2300_pwk02_attachment_trans_code,
						@pwk06_attach_control_no = @L2300_pwk06_attachment_control_num
		end
	
		if ( @L2300_amt02_patient_paid_amt IS NOT NULL )
		begin
			exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
						@amt01_amount_qual_code = 'F5',
						@amt02_amount = @L2300_amt02_patient_paid_amt

		end
		if ( @L2300_amt02_patient_resp_amt IS NOT NULL )
		begin
			exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
						@amt01_amount_qual_code = 'F3',
						@amt02_amount = @L2300_amt02_patient_resp_amt

		end
		if ( @L2300_amt02_total_purchased_amt IS NOT NULL )
		begin
			exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
						@amt01_amount_qual_code = 'NE',
						@amt02_amount = @L2300_amt02_total_purchased_amt
		end
	
	-- BEGIN: 2300 REF SEGMENTS
	-- 2300 Loop REF 9C
		if 	(@L2300_ref02_9C_adj_repriced_claim_num  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = '9C',
						@ref02_reference_number = @L2300_ref02_9C_adj_repriced_claim_num
		end
	-- 2300 Loop REF 9A
		if 	(@L2300_ref02_9A_repriced_claim_num  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = '9A',
						@ref02_reference_number = @L2300_ref02_9A_repriced_claim_num
		end
	-- 2300 Loop REF D9 segment
		if 	(@L2300_ref02_D9_claim_id_clearing_house IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'D9',
						@ref02_reference_number = @L2300_ref02_D9_claim_id_clearing_house
		end
	-- 2300 Loop REF DD Segment
		if 	(@L2300_ref02_DD_domcument_id  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'DD',
						@ref02_reference_number = @L2300_ref02_DD_domcument_id
		end
	-- 2300 Loop REF F8 Segment
		if 	(@L2300_ref02_F8_original_ref_num  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'F8',
						@ref02_reference_number = @L2300_ref02_F8_original_ref_num
		end
	-- 2300 Loop REF G1 Segment
		if 	(@L2300_ref02_G1_prior_auth_num  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'G1',
						@ref02_reference_number = @L2300_ref02_G1_prior_auth_num
		end
	-- 2300 Loop REF EA
		if 	(@L2300_ref02_EA_medical_record_num  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'EA',
						@ref02_reference_number = @L2300_ref02_EA_medical_record_num
		end
	--End of 2300 REF LOOP
	
	-- K3 fixed format info 
		if 	(@L2300_k301_fixed_format_info  IS NOT NULL)
		begin
			exec up_x12_k3_export	@x12_interchange_uid = @x12_interchange_uid,
						@fixed_format_info = @L2300_k301_fixed_format_info
		end
	
	
	--Claim Note
		if (	@L2300_nte01_note_ref_code IS NOT NULL OR
			@L2300_nte02_claim_note_text  IS NOT NULL)
		begin
			exec up_x12_nte_export	@x12_interchange_uid = @x12_interchange_uid,
						@note_reference_code = @L2300_nte01_note_ref_code,
						@note_text = @L2300_nte02_claim_note_text
		end

	--diag code
	-- BEGIN: 2300 HI SEGMENTS
	
	-- 2300 Loop HI segments
		-- Principal, Admitting, E-Code
		if (@L2300_hi02_ZZ_diag_admit_ecode IS NOT NULL)
		begin
			-- "ZZ used to indicate the Patient Reason For Visit."
			exec up_x12_hi_export	@x12_interchange_uid = @x12_interchange_uid,
						@hi01_code_list_qual_code = 'BK',
						@hi01_code = @L2300_hi01_BK_diag_admit_ecode,
						@hi02_code_list_qual_code = 'ZZ',
						@hi02_code = @L2300_hi02_ZZ_diag_admit_ecode,
						@hi03_code_list_qual_code = 'BN',
						@hi03_code = @L2300_hi03_BN_diag_admit_ecode
		end
		else
		begin
			-- 'BJ' = Admitting Diagnosis
			exec up_x12_hi_export	@x12_interchange_uid = @x12_interchange_uid,
						@hi01_code_list_qual_code = 'BK',
						@hi01_code = @L2300_hi01_BK_diag_admit_ecode,
						@hi02_code_list_qual_code = 'BJ',
						@hi02_code = @L2300_hi02_BJ_diag_admit_ecode,
						@hi03_code_list_qual_code = 'BN',
						@hi03_code = @L2300_hi03_BN_diag_admit_ecode
		end

		-- DRG information
		exec up_x12_hi_export	@x12_interchange_uid = @x12_interchange_uid,
					@hi01_code_list_qual_code = 'DR',
					@hi01_code = @L2300_hi01_DR_diag_drg
		-- Other Diagnosis Information
		exec up_x12_hi_export	@x12_interchange_uid = @x12_interchange_uid,
					@hi01_code_list_qual_code = 'BF',
					@hi01_code = @L2300_hi01_BF_diag_code,
					@hi02_code_list_qual_code = 'BF',
					@hi02_code = @L2300_hi02_BF_diag_code,
					@hi03_code_list_qual_code = 'BF',
					@hi03_code = @L2300_hi03_BF_diag_code,
					@hi04_code_list_qual_code = 'BF',
					@hi04_code = @L2300_hi04_BF_diag_code,
					@hi05_code_list_qual_code = 'BF',
					@hi05_code = @L2300_hi05_BF_diag_code,
					@hi06_code_list_qual_code = 'BF',
					@hi06_code = @L2300_hi06_BF_diag_code,
					@hi07_code_list_qual_code = 'BF',
					@hi07_code = @L2300_hi07_BF_diag_code,
					@hi08_code_list_qual_code = 'BF',
					@hi08_code = @L2300_hi08_BF_diag_code
		-- Principal Diagnosis Information
		exec up_x12_hi_export	@x12_interchange_uid = @x12_interchange_uid,
					@hi01_code_list_qual_code = 'BR',
					@hi01_code = @L2300_hi01_BR_princ_proc_info,
					@hi01_code_date_qual = 'D8',
					@hi01_code_date = @L2300_hi01_BR_princ_proc_info_date
		-- Other Diagnosis Information
		exec up_x12_hi_export	@x12_interchange_uid = @x12_interchange_uid,
					@hi01_code_list_qual_code = 'BQ',
					@hi01_code = @L2300_hi01_BQ_other_proc_info,
					@hi01_code_date = @L2300_hi01_BQ_other_proc_info_date,
					@hi02_code_list_qual_code = 'BQ',
					@hi02_code = @L2300_hi02_BQ_other_proc_info,
					@hi02_code_date = @L2300_hi02_BQ_other_proc_info_date,
					@hi03_code_list_qual_code = 'BQ',
					@hi03_code = @L2300_hi03_BQ_other_proc_info,
					@hi03_code_date = @L2300_hi02_BQ_other_proc_info_date,
					@hi04_code_list_qual_code = 'BQ',
					@hi04_code = @L2300_hi04_BQ_other_proc_info,
					@hi04_code_date = @L2300_hi04_BQ_other_proc_info_date,
					@hi05_code_list_qual_code = 'BQ',
					@hi05_code = @L2300_hi05_BQ_other_proc_info,
					@hi05_code_date = @L2300_hi05_BQ_other_proc_info_date,
					@hi06_code_list_qual_code = 'BQ',
					@hi06_code = @L2300_hi06_BQ_other_proc_info,
					@hi06_code_date = @L2300_hi06_BQ_other_proc_info_date,
					@hi07_code_list_qual_code = 'BQ',
					@hi07_code = @L2300_hi07_BQ_other_proc_info,
					@hi07_code_date = @L2300_hi07_BQ_other_proc_info_date,
					@hi08_code_list_qual_code = 'BQ',
					@hi08_code = @L2300_hi08_BQ_other_proc_info,
					@hi08_code_date = @L2300_hi08_BQ_other_proc_info_date,
					@hi09_code_list_qual_code = 'BQ',
					@hi09_code = @L2300_hi09_BQ_other_proc_info,
					@hi09_code_date = @L2300_hi09_BQ_other_proc_info_date,
					@hi10_code_list_qual_code = 'BQ',
					@hi10_code = @L2300_hi10_BQ_other_proc_info,
					@hi10_code_date = @L2300_hi10_BQ_other_proc_info_date,
					@hi11_code_list_qual_code = 'BQ',
					@hi11_code = @L2300_hi11_BQ_other_proc_info,
					@hi11_code_date = @L2300_hi11_BQ_other_proc_info_date,
					@hi12_code_list_qual_code = 'BQ',
					@hi12_code = @L2300_hi12_BQ_other_proc_info,
					@hi12_code_date = @L2300_hi12_BQ_other_proc_info_date
		-- Occurance Span Information
		exec up_x12_hi_export	@x12_interchange_uid = @x12_interchange_uid,
					@hi01_code_list_qual_code = 'BI',
					@hi01_code = @L2300_hi01_BI_occur_span,
					@hi01_code_date = @L2300_hi01_BI_occur_span_date,
					@hi02_code_list_qual_code = 'BI',
					@hi02_code = @L2300_hi02_BI_occur_span,
					@hi02_code_date = @L2300_hi02_BI_occur_span_date,
					@hi03_code_list_qual_code = 'BI',
					@hi03_code = @L2300_hi03_BI_occur_span,
					@hi03_code_date = @L2300_hi03_BI_occur_span_date,
					@hi04_code_list_qual_code = 'BI',					
					@hi04_code = @L2300_hi04_BI_occur_span,
					@hi04_code_date = @L2300_hi04_BI_occur_span_date,
					@hi05_code_list_qual_code = 'BI',
					@hi05_code = @L2300_hi05_BI_occur_span,
					@hi05_code_date = @L2300_hi05_BI_occur_span_date,
					@hi06_code_list_qual_code = 'BI',
					@hi06_code = @L2300_hi06_BI_occur_span,
					@hi06_code_date = @L2300_hi06_BI_occur_span_date,
					@hi07_code_list_qual_code = 'BI',
					@hi07_code = @L2300_hi07_BI_occur_span,
					@hi07_code_date = @L2300_hi07_BI_occur_span_date,
					@hi08_code_list_qual_code = 'BI',
					@hi08_code = @L2300_hi08_BI_occur_span,
					@hi08_code_date = @L2300_hi08_BI_occur_span_date,
					@hi09_code_list_qual_code = 'BI',
					@hi09_code = @L2300_hi09_BI_occur_span,
					@hi09_code_date = @L2300_hi09_BI_occur_span_date,
					@hi10_code_list_qual_code = 'BI',
					@hi10_code = @L2300_hi10_BI_occur_span,
					@hi10_code_date = @L2300_hi10_BI_occur_span_date,
					@hi11_code_list_qual_code = 'BI',
					@hi11_code = @L2300_hi11_BI_occur_span,
					@hi11_code_date = @L2300_hi11_BI_occur_span_date,
					@hi12_code_list_qual_code = 'BI',
					@hi12_code = @L2300_hi12_BI_occur_span,
					@hi12_code_date = @L2300_hi12_BI_occur_span_date
		-- Occurance Information
		exec up_x12_hi_export	@x12_interchange_uid = @x12_interchange_uid,
					@hi01_code_list_qual_code = 'BH',
					@hi01_code = @L2300_hi01_BH_occur_info,
					@hi01_code_date = @L2300_hi01_BH_occur_info_date,
					@hi02_code_list_qual_code = 'BH',
					@hi02_code = @L2300_hi02_BH_occur_info,
					@hi02_code_date = @L2300_hi02_BH_occur_info_date,
					@hi03_code_list_qual_code = 'BH',
					@hi03_code = @L2300_hi03_BH_occur_info,
					@hi03_code_date = @L2300_hi03_BH_occur_info_date,
					@hi04_code_list_qual_code = 'BH',
					@hi04_code = @L2300_hi04_BH_occur_info,
					@hi04_code_date = @L2300_hi04_BH_occur_info_date,
					@hi05_code_list_qual_code = 'BH',
					@hi05_code = @L2300_hi05_BH_occur_info,
					@hi05_code_date = @L2300_hi05_BH_occur_info_date,
					@hi06_code_list_qual_code = 'BH',
					@hi06_code = @L2300_hi06_BH_occur_info,
					@hi06_code_date = @L2300_hi06_BH_occur_info_date,
					@hi07_code_list_qual_code = 'BH',					
					@hi07_code = @L2300_hi07_BH_occur_info,
					@hi07_code_date = @L2300_hi07_BH_occur_info_date,
					@hi08_code_list_qual_code = 'BH',
					@hi08_code = @L2300_hi08_BH_occur_info,
					@hi08_code_date = @L2300_hi08_BH_occur_info_date,
					@hi09_code_list_qual_code = 'BH',
					@hi09_code = @L2300_hi09_BH_occur_info,
					@hi09_code_date = @L2300_hi09_BH_occur_info_date,
					@hi10_code_list_qual_code = 'BH',
					@hi10_code = @L2300_hi10_BH_occur_info,
					@hi10_code_date = @L2300_hi10_BH_occur_info_date,
					@hi11_code_list_qual_code = 'BH',
					@hi11_code = @L2300_hi11_BH_occur_info,
					@hi11_code_date = @L2300_hi11_BH_occur_info_date,
					@hi12_code_list_qual_code = 'BH',
					@hi12_code = @L2300_hi12_BH_occur_info,
					@hi12_code_date = @L2300_hi12_BH_occur_info_date
		-- Value Information
		exec up_x12_hi_export	@x12_interchange_uid = @x12_interchange_uid,
					@hi01_code_list_qual_code = 'BE',
					@hi01_code = @L2300_hi01_BE_value_info,
					@hi01_code_amount = @L2300_hi01_BE_value_info_amt,
					@hi02_code_list_qual_code = 'BE',
					@hi02_code = @L2300_hi02_BE_value_info,
					@hi02_code_amount = @L2300_hi02_BE_value_info_amt,
					@hi03_code_list_qual_code = 'BE',
					@hi03_code = @L2300_hi03_BE_value_info,
					@hi03_code_amount = @L2300_hi03_BE_value_info_amt,
					@hi04_code_list_qual_code = 'BE',
					@hi04_code = @L2300_hi04_BE_value_info,
					@hi04_code_amount = @L2300_hi04_BE_value_info_amt,
					@hi05_code_list_qual_code = 'BE',
					@hi05_code = @L2300_hi05_BE_value_info,
					@hi05_code_amount = @L2300_hi05_BE_value_info_amt,
					@hi06_code_list_qual_code = 'BE',
					@hi06_code = @L2300_hi06_BE_value_info,
					@hi06_code_amount = @L2300_hi06_BE_value_info_amt,
					@hi07_code_list_qual_code = 'BE',
					@hi07_code = @L2300_hi07_BE_value_info,
					@hi07_code_amount = @L2300_hi07_BE_value_info_amt,
					@hi08_code_list_qual_code = 'BE',
					@hi08_code = @L2300_hi08_BE_value_info,
					@hi08_code_amount = @L2300_hi08_BE_value_info_amt,
					@hi09_code_list_qual_code = 'BE',
					@hi09_code = @L2300_hi09_BE_value_info,
					@hi09_code_amount = @L2300_hi09_BE_value_info_amt,
					@hi10_code_list_qual_code = 'BE',
					@hi10_code = @L2300_hi10_BE_value_info,
					@hi10_code_amount = @L2300_hi10_BE_value_info_amt,
					@hi11_code_list_qual_code = 'BE',
					@hi11_code = @L2300_hi11_BE_value_info,
					@hi11_code_amount = @L2300_hi11_BE_value_info_amt,
					@hi12_code_list_qual_code = 'BE',
					@hi12_code = @L2300_hi12_BE_value_info,
					@hi12_code_amount = @L2300_hi12_BE_value_info_amt
		-- Condition Information
		exec up_x12_hi_export	@x12_interchange_uid = @x12_interchange_uid,
					@hi01_code_list_qual_code = 'BG',
					@hi01_code = @L2300_hi01_BG_cond_info,
					@hi02_code_list_qual_code = 'BG',
					@hi02_code = @L2300_hi02_BG_cond_info,
					@hi03_code_list_qual_code = 'BG',
					@hi03_code = @L2300_hi03_BG_cond_info,
					@hi04_code_list_qual_code = 'BG',
					@hi04_code = @L2300_hi04_BG_cond_info,
					@hi05_code_list_qual_code = 'BG',
					@hi05_code = @L2300_hi05_BG_cond_info,
					@hi06_code_list_qual_code = 'BG',
					@hi06_code = @L2300_hi06_BG_cond_info,
					@hi07_code_list_qual_code = 'BG',
					@hi07_code = @L2300_hi07_BG_cond_info,
					@hi08_code_list_qual_code = 'BG',
					@hi08_code = @L2300_hi08_BG_cond_info,
					@hi09_code_list_qual_code = 'BG',
					@hi09_code = @L2300_hi09_BG_cond_info,
					@hi10_code_list_qual_code = 'BG',
					@hi10_code = @L2300_hi10_BG_cond_info,
					@hi11_code_list_qual_code = 'BG',
					@hi11_code = @L2300_hi11_BG_cond_info,
					@hi12_code_list_qual_code = 'BG',
					@hi12_code = @L2300_hi12_BG_cond_info
		-- Treatment Code Information
		exec up_x12_hi_export	@x12_interchange_uid = @x12_interchange_uid,
					@hi01_code_list_qual_code = 'TC',
					@hi01_code = @L2300_hi01_TC_treat_code_info,
					@hi02_code_list_qual_code = 'TC',
					@hi02_code = @L2300_hi02_TC_treat_code_info,
					@hi03_code_list_qual_code = 'TC',
					@hi03_code = @L2300_hi03_TC_treat_code_info,
					@hi04_code_list_qual_code = 'TC',
					@hi04_code = @L2300_hi04_TC_treat_code_info,
					@hi05_code_list_qual_code = 'TC',
					@hi05_code = @L2300_hi05_TC_treat_code_info,
					@hi06_code_list_qual_code = 'TC',
					@hi06_code = @L2300_hi06_TC_treat_code_info,
					@hi07_code_list_qual_code = 'TC',
					@hi07_code = @L2300_hi07_TC_treat_code_info,
					@hi08_code_list_qual_code = 'TC',
					@hi08_code = @L2300_hi08_TC_treat_code_info,
					@hi09_code_list_qual_code = 'TC',
					@hi09_code = @L2300_hi09_TC_treat_code_info,
					@hi10_code_list_qual_code = 'TC',
					@hi10_code = @L2300_hi10_TC_treat_code_info,
					@hi11_code_list_qual_code = 'TC',
					@hi11_code = @L2300_hi11_TC_treat_code_info,
					@hi12_code_list_qual_code = 'TC',
					@hi12_code = @L2300_hi12_TC_treat_code_info
	--End of 2300 HI SEGMENTS

		exec up_x12_qty_export	@x12_interchange_uid = @x12_interchange_uid,
					@qty01_quantity_qual_code = 'CA',
					@qty02_quantity = @L2300_qty02_CA_claim_qty,
					@qty03_quantity_unit = 'DA'

		exec up_x12_qty_export	@x12_interchange_uid = @x12_interchange_uid,
					@qty01_quantity_qual_code = 'CD',
					@qty02_quantity = @L2300_qty02_CD_claim_qty,
					@qty03_quantity_unit = 'DA'

		exec up_x12_qty_export	@x12_interchange_uid = @x12_interchange_uid,
					@qty01_quantity_qual_code = 'LA',
					@qty02_quantity = @L2300_qty02_LA_claim_qty,
					@qty03_quantity_unit = 'DA'

		exec up_x12_qty_export	@x12_interchange_uid = @x12_interchange_uid,
					@qty01_quantity_qual_code = 'NA',
					@qty02_quantity = @L2300_qty02_NA_claim_qty,
					@qty03_quantity_unit = 'DA'


	--Start 2310A Loop
		if (	@L2310A_nm103_attending_prov_last_nm IS NOT NULL OR
			@L2310A_nm108_id_code_qual IS NOT NULL OR
			@L2310A_nm109_attending_prov_id IS NOT NULL )
		begin
			if (@L2310A_nm101_entity_id_code IS NULL)
			begin
				set @L2310A_nm101_entity_id_code = '71'
			end

			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = @L2310A_nm101_entity_id_code,
						@nm103_last_name = @L2310A_nm103_attending_prov_last_nm,
						@nm104_first_name = @L2310A_nm104_attending_prov_first_nm,
						@nm105_middle_name = @L2310A_nm105_attending_prov_middle_nm,
						@nm107_name_suffix = @L2310A_nm107_attending_prov_suffix,
						@nm108_id_code_qual = @L2310A_nm108_id_code_qual,
						@nm109_id_code = @L2310A_nm109_attending_prov_id

			 

			if 	(@L2310A_prv01_provider_code IS NOT NULL)
			begin
				exec up_x12_prv_export	@x12_interchange_uid = @x12_interchange_uid,
							@prv01_provider_code = @L2310A_prv01_provider_code,
							@prv02_provider_id_qual = @L2310A_prv02_ref_id_qual,
							@prv03_provider_id = @L2310A_prv03_taxonomy_code

				 
			end

		-- BEGIN: 2310A REF SEGMENTS
			-- 2310A Loop REF 1C segment
			if 	(@L2310A_ref02_1C_attending_prov_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1C',
							@ref02_reference_number = @L2310A_ref02_1C_attending_prov_id
			end
			-- 2310A Loop REF 1D Segment
			if 	(@L2310A_ref02_1D_attending_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1D',
							@ref02_reference_number = @L2310A_ref02_1D_attending_prov_id
			end
			-- 2310A Loop REF 1G Segment
			if 	(@L2310A_ref02_1G_attending_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1G',
							@ref02_reference_number = @L2310A_ref02_1G_attending_prov_id
			end
			-- 2310A Loop REF EI
			if 	(@L2310A_ref02_EI_attending_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'EI',
							@ref02_reference_number = @L2310A_ref02_EI_attending_prov_id
			end
			-- 2310A Loop REF SY
			if 	(@L2310A_ref02_SY_attending_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'SY',
							@ref02_reference_number = @L2310A_ref02_SY_attending_prov_id
			end
			-- 2310A Loop REF FH
			if 	(@L2310A_ref02_FH_attending_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'FH',
							@ref02_reference_number = @L2310A_ref02_FH_attending_prov_id
			end
		--End of 2310A REF SEGMENTS
		end
	-- END of 2310A Loop
	
	-- BEGIN OF 2310B LOOP
		if (	@L2310B_nm103_operating_prov_last_nm IS NOT NULL OR
			@L2310B_nm108_id_code_qual IS NOT NULL OR
			@L2310B_nm109_operating_prov_id IS NOT NULL )
		begin
			-- If the 2310B loop is used, then the NM1 segment is always required.
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = '72',
						@nm103_last_name = @L2310B_nm103_operating_prov_last_nm,
						@nm104_first_name = @L2310B_nm104_operating_prov_first_nm,
						@nm105_middle_name = @L2310B_nm105_operating_prov_middle_nm,
						@nm107_name_suffix = @L2310B_nm107_operating_prov_suffix,
						@nm108_id_code_qual = @L2310B_nm108_id_code_qual,
						@nm109_id_code = @L2310B_nm109_operating_prov_id

		-- BEGIN: 2310B REF SEGMENTS
			-- 2310B Loop REF 1C segment
			if 	(@L2310B_ref02_1C_operating_prov_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1C',
							@ref02_reference_number = @L2310B_ref02_1C_operating_prov_id
			end
			-- 2310B Loop REF 1D Segment
			if 	(@L2310B_ref02_1D_operating_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1D',
							@ref02_reference_number = @L2310B_ref02_1D_operating_prov_id
			end
			-- 2310B Loop REF 1G Segment
			if 	(@L2310B_ref02_1G_operating_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1G',
							@ref02_reference_number = @L2310B_ref02_1G_operating_prov_id
			end
			-- 2310B Loop REF EI
			if 	(@L2310B_ref02_EI_operating_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'EI',
							@ref02_reference_number = @L2310B_ref02_EI_operating_prov_id
			end
			-- 2310B Loop REF SY
			if 	(@L2310B_ref02_SY_operating_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'SY',
							@ref02_reference_number = @L2310B_ref02_SY_operating_prov_id
			end
			-- 2310B Loop REF FH
			if 	(@L2310B_ref02_FH_operating_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'FH',
							@ref02_reference_number = @L2310B_ref02_FH_operating_prov_id
			end
		-- END: 2310B REF SEGMENTS
		End
	-- END OF 2310B LOOP
	




	-- BEGIN OF 2310C LOOP
		if (	@L2310C_nm103_other_prov_last_nm IS NOT NULL OR
			@L2310C_nm108_id_code_qual IS NOT NULL OR
			@L2310C_nm109_other_prov_id IS NOT NULL )
		begin
			-- If the 2310C loop is used, then the NM1 segment is always required.
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = '73',
						@nm103_last_name = @L2310C_nm103_other_prov_last_nm,
						@nm104_first_name = @L2310C_nm104_other_prov_first_nm,
						@nm105_middle_name = @L2310C_nm105_other_prov_middle_nm,
						@nm107_name_suffix = @L2310C_nm107_other_prov_suffix,
						@nm108_id_code_qual = @L2310C_nm108_id_code_qual,
						@nm109_id_code = @L2310C_nm109_other_prov_id

		-- BEGIN: 2310C REF SEGMENTS
			-- 2310C Loop REF 1C segment
			if 	(@L2310C_ref02_1C_other_prov_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1C',
							@ref02_reference_number = @L2310C_ref02_1C_other_prov_id
			end
			-- 2310C Loop REF 1D Segment
			if 	(@L2310C_ref02_1D_other_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1D',
							@ref02_reference_number = @L2310C_ref02_1D_other_prov_id
			end
			-- 2310C Loop REF 1G Segment
			if 	(@L2310C_ref02_1G_other_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1G',
							@ref02_reference_number = @L2310C_ref02_1G_other_prov_id
			end
			-- 2310C Loop REF EI
			if 	(@L2310C_ref02_EI_other_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'EI',
							@ref02_reference_number = @L2310C_ref02_EI_other_prov_id
			end
			-- 2310C Loop REF SY
			if 	(@L2310C_ref02_SY_other_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'SY',
							@ref02_reference_number = @L2310C_ref02_SY_other_prov_id
			end
			-- 2310C Loop REF FH
			if 	(@L2310C_ref02_FH_other_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'FH',
							@ref02_reference_number = @L2310C_ref02_FH_other_prov_id
			end
		-- END: 2310C REF SEGMENTS
		End
	-- END OF 2310C LOOP



	-- BEGIN OF 2310E LOOP
		if (	@L2310E_nm103_service_facility_last_nm IS NOT NULL OR
			@L2310E_nm108_id_code_qual IS NOT NULL OR
			@L2310E_nm109_service_facility_id IS NOT NULL )
		begin

			-- If the 2310E loop is used, then the NM1 segment is always required.
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = @L2310E_nm101_entity_id_code,
						@nm103_last_name = @L2310E_nm103_service_facility_last_nm,
						@nm108_id_code_qual = @L2310E_nm108_id_code_qual,
						@nm109_id_code = @L2310E_nm109_service_facility_id
	
			 
	
			-- If the 2310E loop is used, then the N3 segment is always required.
			exec up_x12_n3_export	@x12_interchange_uid = @x12_interchange_uid,
						@n301_address1 = @L2310E_n301_service_facility_address1,
						@n302_address2 = @L2310E_n302_service_facility_address2

			 
	
			-- If the 2310E loop is used, then the N4 segment is always required.
			exec up_x12_n4_export	@x12_interchange_uid = @x12_interchange_uid,
						@n401_city = @L2310E_n401_service_facility_city,
						@n402_state = @L2310E_n402_service_facility_state,
						@n403_zip = @L2310E_n403_service_facility_zip
	
		-- BEGIN: 2310E REF SEGMENTS
			-- 2310E Loop REF 1C segment
			if 	(@L2310E_ref02_1C_service_facility_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1C',
							@ref02_reference_number = @L2310E_ref02_1C_service_facility_id
			end
			-- 2310E Loop REF 1D Segment
			if 	(@L2310E_ref02_1D_service_facility_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1D',
							@ref02_reference_number = @L2310E_ref02_1D_service_facility_id
			end
			-- 2310E Loop REF 1G Segment
			if 	(@L2310E_ref02_1G_service_facility_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1G',
							@ref02_reference_number = @L2310E_ref02_1G_service_facility_id
			end
			-- 2310E Loop REF G2 Segment
			if 	(@L2310E_ref02_G2_service_facility_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'G2',
							@ref02_reference_number = @L2310E_ref02_G2_service_facility_id
			end
		-- END: 2310E REF SEGMENTS
		End
	-- END OF 2310E LOOP


	-- BEGIN OF FIRST 2320 LOOP
		-- Insert of the SBR Segment
		if 	(@L2320_1_sbr01_payer_resp_seq_code IS NOT NULL)
		begin
			exec up_x12_sbr_export	@x12_interchange_uid = @x12_interchange_uid,
						@sbr01_payer_resp_seq_code = @L2320_1_sbr01_payer_resp_seq_code,
						@sbr02_ind_relationship_code = @L2320_1_sbr02_ind_relationship_code,
						@sbr03_insured_grp_policy_num = @L2320_1_sbr03_insured_grp_policy_num,
						@sbr04_insured_grp_nm = @L2320_1_sbr04_insured_grp_nm,
						@sbr09_claim_filing_ind_code = @L2320_1_sbr09_claim_file_ind_code

		-- Export a CAS segment for EVERY line where the charges don't equal the payment amount
			if (@L2320_1_cas01_adjustment_group_code IS NOT NULL)
			begin
				exec up_x12_cas_export	@x12_interchange_uid = @x12_interchange_uid,
							@cas01_adjustment_group_code	= @L2320_1_cas01_adjustment_group_code,
							@cas02_adjustment_reason_code	= @L2320_1_cas02_adjustment_reason_code,
							@cas03_adjustment_amt			= @L2320_1_cas03_adjustment_amt,
							@cas04_adjustment_qty			= @L2320_1_cas04_adjustment_qty,
							@cas05_adjustment_reason_code	= @L2320_1_cas05_adjustment_reason_code,
							@cas06_adjustment_amt			= @L2320_1_cas06_adjustment_amt,
							@cas07_adjustment_qty			= @L2320_1_cas07_adjustment_qty,
							@cas08_adjustment_reason_code	= @L2320_1_cas08_adjustment_reason_code,
							@cas09_adjustment_amt			= @L2320_1_cas09_adjustment_amt,
							@cas10_adjustment_qty			= @L2320_1_cas10_adjustment_qty
		
				 
			END
			
			if (@L2320_2_sbr01_payer_resp_seq_code IS NULL AND @L2320_2_cas01_adjustment_group_code IS NOT NULL)
			begin
				exec up_x12_cas_export	@x12_interchange_uid = @x12_interchange_uid,
							@cas01_adjustment_group_code	= @L2320_2_cas01_adjustment_group_code,
							@cas02_adjustment_reason_code	= @L2320_2_cas02_adjustment_reason_code,
							@cas03_adjustment_amt			= @L2320_2_cas03_adjustment_amt,
							@cas04_adjustment_qty			= @L2320_2_cas04_adjustment_qty,
							@cas05_adjustment_reason_code	= @L2320_2_cas05_adjustment_reason_code,
							@cas06_adjustment_amt			= @L2320_2_cas06_adjustment_amt,
							@cas07_adjustment_qty			= @L2320_2_cas07_adjustment_qty,
							@cas08_adjustment_reason_code	= @L2320_2_cas08_adjustment_reason_code,
							@cas09_adjustment_amt			= @L2320_2_cas09_adjustment_amt,
							@cas10_adjustment_qty			= @L2320_2_cas10_adjustment_qty
		
				 
			END
			
			if (@L2320_3_sbr01_payer_resp_seq_code IS NULL AND @L2320_3_cas01_adjustment_group_code IS NOT NULL)
			begin
				exec up_x12_cas_export	@x12_interchange_uid = @x12_interchange_uid,
							@cas01_adjustment_group_code	= @L2320_3_cas01_adjustment_group_code,
							@cas02_adjustment_reason_code	= @L2320_3_cas02_adjustment_reason_code,
							@cas03_adjustment_amt			= @L2320_3_cas03_adjustment_amt,
							@cas04_adjustment_qty			= @L2320_3_cas04_adjustment_qty,
							@cas05_adjustment_reason_code	= @L2320_3_cas05_adjustment_reason_code,
							@cas06_adjustment_amt			= @L2320_3_cas06_adjustment_amt,
							@cas07_adjustment_qty			= @L2320_3_cas07_adjustment_qty,
							@cas08_adjustment_reason_code	= @L2320_3_cas08_adjustment_reason_code,
							@cas09_adjustment_amt			= @L2320_3_cas09_adjustment_amt,
							@cas10_adjustment_qty			= @L2320_3_cas10_adjustment_qty
				 
			end
	
		-- BEGIN 2320 AMT SEGMENTS
			if ( @L2320_1_amt02_C4_payer_prior_pmt_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'C4',
							@amt02_amount = @L2320_1_amt02_C4_payer_prior_pmt_amt
			end

			if ( @L2320_1_amt02_B6_cob_allowed_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'B6',
							@amt02_amount = @L2320_1_amt02_B6_cob_allowed_amt
			end
			if ( @L2320_1_amt02_T3_cob_submitted_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'T3',
							@amt02_amount = @L2320_1_amt02_T3_cob_submitted_amt
			end
			if ( @L2320_1_amt02_ZZ_drg_outlier_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'ZZ',
							@amt02_amount = @L2320_1_amt02_ZZ_drg_outlier_amt
			end
			if ( @L2320_1_amt02_N1_cob_medicare_paid_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'N1',
							@amt02_amount = @L2320_1_amt02_N1_cob_medicare_paid_amt
			end
			if ( @L2320_1_amt02_KF_medicare_paid_100_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'KF',
							@amt02_amount = @L2320_1_amt02_KF_medicare_paid_100_amt
			end
			if ( @L2320_1_amt02_PG_medicare_paid_80_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'PG',
							@amt02_amount = @L2320_1_amt02_PG_medicare_paid_80_amt
			end
			if ( @L2320_1_amt02_AA_cob_medicare_a_trust_pd_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'AA',
							@amt02_amount = @L2320_1_amt02_AA_cob_medicare_a_trust_pd_amt
			end
			if ( @L2320_1_amt02_B1_cob_medicare_b_trust_pd_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'B1',
							@amt02_amount = @L2320_1_amt02_B1_cob_medicare_b_trust_pd_amt
			end
			if ( @L2320_1_amt02_A8_cob_non_cvd_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'A8',
							@amt02_amount = @L2320_1_amt02_A8_cob_non_cvd_amt
			end
			if ( @L2320_1_amt02_YT_cob_denied_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'YT',
							@amt02_amount = @L2320_1_amt02_YT_cob_denied_amt
			end

		-- END 2320 AMT SEGMENTS

			-- If the 2320 Loop is used, then the 2320-DMG segment is required
			exec up_x12_dmg_export	@x12_interchange_uid = @x12_interchange_uid,
						@dmg01_date_time_format_qual = 'D8',
						@dmg02_dob = @L2320_1_dmg02_other_subscriber_dob,
						@dmg03_gender = @L2320_1_dmg03_other_subscriber_gender

			-- If the 2320 Loop is used, then the 2320-OI segment is required
			exec up_x12_oi_export	@x12_interchange_uid = @x12_interchange_uid,
						@oi03_benefit_assign_ind = @L2320_1_oi03_other_ins_benefit_assign_ind,
						@oi06_release_of_info_code = @L2320_1_oi06_other_ins_release_of_info_code
	
-- TO-DO: Add the MIA segment for Medicare Inpatient Adjudication Information
-- TO-DO: Add the MOA segment for Medicare Outpatient Adjudication Information

			-- If the 2320 Loop is used, then the 2330A Loop and 2330A-NM1 segment is required
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = 'IL',
						@nm102_entity_type_qual = @L2330A_1_nm102_entity_type_qual,
						@nm103_last_name = @L2330A_1_nm103_other_subscriber_last_name,
						@nm104_first_name = @L2330A_1_nm104_other_subscriber_first_name,
						@nm105_middle_name = @L2330A_1_nm105_other_subscriber_middle_name,
						@nm107_name_suffix = @L2330A_1_nm107_other_subscriber_name_suffix,
						@nm108_id_code_qual = @L2330A_1_nm108_other_subscriber_id_code_qual,
						@nm109_id_code = @L2330A_1_nm109_other_subscriber_id

			 

			set @L2330B_1_nm103_other_payer_nm = IsNull(@L2330B_1_nm103_other_payer_nm, 'UNSPECIFIED')
			set @L2330B_1_nm109_other_payer_id = IsNull(@L2330B_1_nm109_other_payer_id, '999999999')
			-- If the 2320 Loop is used, then the 2330A Loop and 2330A-NM1 segment is required
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = 'PR',
						@nm103_last_name = @L2330B_1_nm103_other_payer_nm,
						@nm108_id_code_qual = @L2330B_1_nm108_id_code_qual,
						@nm109_id_code = @L2330B_1_nm109_other_payer_id
		
			if 	(@L2330B_1_dtp03_573_date_claim_paid IS NOT NULL)
			begin
				exec up_x12_dtp_export	@x12_interchange_uid = @x12_interchange_uid,
							@dtp01_date_time_qual = '573',
							@dtp02_date_time_format_qual = 'D8',
							@dtp03_begin_date = @L2330B_1_dtp03_573_date_claim_paid
			end
		
		-- BEGIN: 2330B REF SEGMENTS
			
			-- 2330B Loop REF 2U segment
			if 	(@L2330B_1_ref02_2U_other_payer_secondary_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '2U',
							@ref02_reference_number = @L2330B_1_ref02_2U_other_payer_secondary_id
			end
			-- 2330B Loop REF F8 Segment
			if 	(@L2330B_1_ref02_F8_other_payer_secondary_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'F8',
							@ref02_reference_number = @L2330B_1_ref02_F8_other_payer_secondary_id
			end
			-- 2330B Loop REF FY Segment
			if 	(@L2330B_1_ref02_FY_other_payer_secondary_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'FY',
							@ref02_reference_number = @L2330B_1_ref02_FY_other_payer_secondary_id
			end
			-- 2330B Loop REF G2 Segment
			if 	(@L2330B_1_ref02_NF_other_payer_secondary_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'NF',
							@ref02_reference_number = @L2330B_1_ref02_NF_other_payer_secondary_id
			end
			-- 2330B Loop REF TJ
			if 	(@L2330B_1_ref02_TJ_other_payer_secondary_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'TJ',
							@ref02_reference_number = @L2330B_1_ref02_TJ_other_payer_secondary_id
			end
			-- 2330B Loop REF 9F
			if 	(@L2330B_1_ref02_9F_other_payer_auth_num IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '9F',
							@ref02_reference_number = @L2330B_1_ref02_9F_other_payer_auth_num
			end
			-- 2330B Loop REF G1
			if 	(@L2330B_1_ref02_G1_other_payer_auth_num IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'G1',
							@ref02_reference_number = @L2330B_1_ref02_G1_other_payer_auth_num
			end
			--End of 2330B LOOP
		end
		-- END OF FIRST 2320 LOOP GROUPING


	-- BEGIN OF SECOND 2320 LOOP
		-- Insert of the SBR Segment
		if 	(@L2320_2_sbr01_payer_resp_seq_code IS NOT NULL)
		begin
			exec up_x12_sbr_export	@x12_interchange_uid = @x12_interchange_uid,
						@sbr01_payer_resp_seq_code = @L2320_2_sbr01_payer_resp_seq_code,
						@sbr02_ind_relationship_code = @L2320_2_sbr02_ind_relationship_code,
						@sbr03_insured_grp_policy_num = @L2320_2_sbr03_insured_grp_policy_num,
						@sbr04_insured_grp_nm = @L2320_2_sbr04_insured_grp_nm,
						@sbr09_claim_filing_ind_code = @L2320_2_sbr09_claim_file_ind_code

		-- Export a CAS segment for EVERY line where the charges don't equal the payment amount
			if (@L2320_2_cas01_adjustment_group_code IS NOT NULL)
			begin
				exec up_x12_cas_export	@x12_interchange_uid = @x12_interchange_uid,
							@L2320_2_cas01_adjustment_group_code = @L2320_2_cas01_adjustment_group_code,
							@L2320_2_cas02_adjustment_reason_code = @L2320_2_cas02_adjustment_reason_code,
							@L2320_2_cas03_adjustment_amt = @L2320_2_cas03_adjustment_amt,
							@L2320_2_cas04_adjustment_qty = @L2320_2_cas04_adjustment_qty,
							@L2320_2_cas05_adjustment_reason_code = @L2320_2_cas05_adjustment_reason_code,
							@L2320_2_cas06_adjustment_amt = @L2320_2_cas06_adjustment_amt,
							@L2320_2_cas07_adjustment_qty = @L2320_2_cas07_adjustment_qty,
							@L2320_2_cas08_adjustment_reason_code = @L2320_2_cas08_adjustment_reason_code,
							@L2320_2_cas09_adjustment_amt = @L2320_2_cas09_adjustment_amt,
							@L2320_2_cas10_adjustment_qty = @L2320_2_cas10_adjustment_qty
		
				 
			end
	
		-- BEGIN 2320 AMT SEGMENTS
			if ( @L2320_2_amt02_C4_payer_prior_pmt_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'C4',
							@amt02_amount = @L2320_2_amt02_C4_payer_prior_pmt_amt
			end

			if ( @L2320_2_amt02_B6_cob_allowed_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'B6',
							@amt02_amount = @L2320_2_amt02_B6_cob_allowed_amt
			end
			if ( @L2320_2_amt02_T3_cob_submitted_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'T3',
							@amt02_amount = @L2320_2_amt02_T3_cob_submitted_amt
			end
			if ( @L2320_2_amt02_ZZ_drg_outlier_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'ZZ',
							@amt02_amount = @L2320_2_amt02_ZZ_drg_outlier_amt
			end
			if ( @L2320_2_amt02_N1_cob_medicare_paid_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'N1',
							@amt02_amount = @L2320_2_amt02_N1_cob_medicare_paid_amt
			end
			if ( @L2320_2_amt02_KF_medicare_paid_100_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'KF',
							@amt02_amount = @L2320_2_amt02_KF_medicare_paid_100_amt
			end
			if ( @L2320_2_amt02_PG_medicare_paid_80_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'PG',
							@amt02_amount = @L2320_2_amt02_PG_medicare_paid_80_amt
			end
			if ( @L2320_2_amt02_AA_cob_medicare_a_trust_pd_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'AA',
							@amt02_amount = @L2320_2_amt02_AA_cob_medicare_a_trust_pd_amt
			end
			if ( @L2320_2_amt02_B1_cob_medicare_b_trust_pd_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'B1',
							@amt02_amount = @L2320_2_amt02_B1_cob_medicare_b_trust_pd_amt
			end
			if ( @L2320_2_amt02_A8_cob_non_cvd_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'A8',
							@amt02_amount = @L2320_2_amt02_A8_cob_non_cvd_amt
			end
			if ( @L2320_2_amt02_YT_cob_denied_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'YT',
							@amt02_amount = @L2320_2_amt02_YT_cob_denied_amt
			end

		-- END 2320 AMT SEGMENTS

			-- If the 2320 Loop is used, then the 2320-DMG segment is required
			exec up_x12_dmg_export	@x12_interchange_uid = @x12_interchange_uid,
						@dmg01_date_time_format_qual = 'D8',
						@dmg02_dob = @L2320_2_dmg02_other_subscriber_dob,
						@dmg03_gender = @L2320_2_dmg03_other_subscriber_gender

			-- If the 2320 Loop is used, then the 2320-OI segment is required
			exec up_x12_oi_export	@x12_interchange_uid = @x12_interchange_uid,
						@oi03_benefit_assign_ind = @L2320_2_oi03_other_ins_benefit_assign_ind,
						@oi06_release_of_info_code = @L2320_2_oi06_other_ins_release_of_info_code
	
-- TO-DO: Add the MIA segment for Medicare Inpatient Adjudication Information
-- TO-DO: Add the MOA segment for Medicare Outpatient Adjudication Information

			-- If the 2320 Loop is used, then the 2330A Loop and 2330A-NM1 segment is required
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = 'IL',
						@nm102_entity_type_qual = @L2330A_2_nm102_entity_type_qual,
						@nm103_last_name = @L2330A_2_nm103_other_subscriber_last_name,
						@nm104_first_name = @L2330A_2_nm104_other_subscriber_first_name,
						@nm105_middle_name = @L2330A_2_nm105_other_subscriber_middle_name,
						@nm107_name_suffix = @L2330A_2_nm107_other_subscriber_name_suffix,
						@nm108_id_code_qual = @L2330A_2_nm108_other_subscriber_id_code_qual,
						@nm109_id_code = @L2330A_2_nm109_other_subscriber_id

			 

			set @L2330B_2_nm103_other_payer_nm = IsNull(@L2330B_2_nm103_other_payer_nm, 'UNSPECIFIED')
			set @L2330B_2_nm109_other_payer_id = IsNull(@L2330B_2_nm109_other_payer_id, '999999999')
			-- If the 2320 Loop is used, then the 2330A Loop and 2330A-NM1 segment is required
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = 'PR',
						@nm103_last_name = @L2330B_2_nm103_other_payer_nm,
						@nm108_id_code_qual = @L2330B_2_nm108_id_code_qual,
						@nm109_id_code = @L2330B_2_nm109_other_payer_id
		
			if 	(@L2330B_2_dtp03_573_date_claim_paid IS NOT NULL)
			begin
				exec up_x12_dtp_export	@x12_interchange_uid = @x12_interchange_uid,
							@dtp01_date_time_qual = '573',
							@dtp02_date_time_format_qual = 'D8',
							@dtp03_begin_date = @L2330B_2_dtp03_573_date_claim_paid
			end
		
		-- BEGIN: 2330B REF SEGMENTS
			
			-- 2330B Loop REF 2U segment
			if 	(@L2330B_2_ref02_2U_other_payer_secondary_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '2U',
							@ref02_reference_number = @L2330B_2_ref02_2U_other_payer_secondary_id
			end
			-- 2330B Loop REF F8 Segment
			if 	(@L2330B_2_ref02_F8_other_payer_secondary_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'F8',
							@ref02_reference_number = @L2330B_2_ref02_F8_other_payer_secondary_id
			end
			-- 2330B Loop REF FY Segment
			if 	(@L2330B_2_ref02_FY_other_payer_secondary_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'FY',
							@ref02_reference_number = @L2330B_2_ref02_FY_other_payer_secondary_id
			end
			-- 2330B Loop REF G2 Segment
			if 	(@L2330B_2_ref02_NF_other_payer_secondary_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'NF',
							@ref02_reference_number = @L2330B_2_ref02_NF_other_payer_secondary_id
			end
			-- 2330B Loop REF TJ
			if 	(@L2330B_2_ref02_TJ_other_payer_secondary_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'TJ',
							@ref02_reference_number = @L2330B_2_ref02_TJ_other_payer_secondary_id
			end
			-- 2330B Loop REF 9F
			if 	(@L2330B_2_ref02_9F_other_payer_auth_num IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '9F',
							@ref02_reference_number = @L2330B_2_ref02_9F_other_payer_auth_num
			end
			-- 2330B Loop REF G1
			if 	(@L2330B_2_ref02_G1_other_payer_auth_num IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'G1',
							@ref02_reference_number = @L2330B_2_ref02_G1_other_payer_auth_num
			end
			--End of 2330B LOOP
		end
		-- END OF SECOND 2320 LOOP GROUPING

	-- BEGIN OF THIRD 2320 LOOP
		-- Insert of the SBR Segment
		if 	(@L2320_3_sbr01_payer_resp_seq_code IS NOT NULL)
		begin
			exec up_x12_sbr_export	@x12_interchange_uid = @x12_interchange_uid,
						@sbr01_payer_resp_seq_code = @L2320_3_sbr01_payer_resp_seq_code,
						@sbr02_ind_relationship_code = @L2320_3_sbr02_ind_relationship_code,
						@sbr03_insured_grp_policy_num = @L2320_3_sbr03_insured_grp_policy_num,
						@sbr04_insured_grp_nm = @L2320_3_sbr04_insured_grp_nm,
						@sbr09_claim_filing_ind_code = @L2320_3_sbr09_claim_file_ind_code

		-- Export a CAS segment for EVERY line where the charges don't equal the payment amount
			if (@L2320_3_cas01_adjustment_group_code IS NOT NULL)
			begin
				exec up_x12_cas_export	@x12_interchange_uid = @x12_interchange_uid,
							@L2320_3_cas01_adjustment_group_code = @L2320_3_cas01_adjustment_group_code,
							@L2320_3_cas02_adjustment_reason_code = @L2320_3_cas02_adjustment_reason_code,
							@L2320_3_cas03_adjustment_amt = @L2320_3_cas03_adjustment_amt,
							@L2320_3_cas04_adjustment_qty = @L2320_3_cas04_adjustment_qty,
							@L2320_3_cas05_adjustment_reason_code = @L2320_3_cas05_adjustment_reason_code,
							@L2320_3_cas06_adjustment_amt = @L2320_3_cas06_adjustment_amt,
							@L2320_3_cas07_adjustment_qty = @L2320_3_cas07_adjustment_qty,
							@L2320_3_cas08_adjustment_reason_code = @L2320_3_cas08_adjustment_reason_code,
							@L2320_3_cas09_adjustment_amt = @L2320_3_cas09_adjustment_amt,
							@L2320_3_cas10_adjustment_qty = @L2320_3_cas10_adjustment_qty
		
				 
			end
	
		-- BEGIN 2320 AMT SEGMENTS
			if ( @L2320_3_amt02_C4_payer_prior_pmt_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'C4',
							@amt02_amount = @L2320_3_amt02_C4_payer_prior_pmt_amt
			end

			if ( @L2320_3_amt02_B6_cob_allowed_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'B6',
							@amt02_amount = @L2320_3_amt02_B6_cob_allowed_amt
			end
			if ( @L2320_3_amt02_T3_cob_submitted_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'T3',
							@amt02_amount = @L2320_3_amt02_T3_cob_submitted_amt
			end
			if ( @L2320_3_amt02_ZZ_drg_outlier_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'ZZ',
							@amt02_amount = @L2320_3_amt02_ZZ_drg_outlier_amt
			end
			if ( @L2320_3_amt02_N1_cob_medicare_paid_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'N1',
							@amt02_amount = @L2320_3_amt02_N1_cob_medicare_paid_amt
			end
			if ( @L2320_3_amt02_KF_medicare_paid_100_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'KF',
							@amt02_amount = @L2320_3_amt02_KF_medicare_paid_100_amt
			end
			if ( @L2320_3_amt02_PG_medicare_paid_80_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'PG',
							@amt02_amount = @L2320_3_amt02_PG_medicare_paid_80_amt
			end
			if ( @L2320_3_amt02_AA_cob_medicare_a_trust_pd_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'AA',
							@amt02_amount = @L2320_3_amt02_AA_cob_medicare_a_trust_pd_amt
			end
			if ( @L2320_3_amt02_B1_cob_medicare_b_trust_pd_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'B1',
							@amt02_amount = @L2320_3_amt02_B1_cob_medicare_b_trust_pd_amt
			end
			if ( @L2320_3_amt02_A8_cob_non_cvd_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'A8',
							@amt02_amount = @L2320_3_amt02_A8_cob_non_cvd_amt
			end
			if ( @L2320_3_amt02_YT_cob_denied_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'YT',
							@amt02_amount = @L2320_3_amt02_YT_cob_denied_amt
			end

		-- END 2320 AMT SEGMENTS

			-- If the 2320 Loop is used, then the 2320-DMG segment is required
			exec up_x12_dmg_export	@x12_interchange_uid = @x12_interchange_uid,
						@dmg01_date_time_format_qual = 'D8',
						@dmg02_dob = @L2320_3_dmg02_other_subscriber_dob,
						@dmg03_gender = @L2320_3_dmg03_other_subscriber_gender

			-- If the 2320 Loop is used, then the 2320-OI segment is required
			exec up_x12_oi_export	@x12_interchange_uid = @x12_interchange_uid,
						@oi03_benefit_assign_ind = @L2320_3_oi03_other_ins_benefit_assign_ind,
						@oi06_release_of_info_code = @L2320_3_oi06_other_ins_release_of_info_code
	
-- TO-DO: Add the MIA segment for Medicare Inpatient Adjudication Information
-- TO-DO: Add the MOA segment for Medicare Outpatient Adjudication Information

			-- If the 2320 Loop is used, then the 2330A Loop and 2330A-NM1 segment is required
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = 'IL',
						@nm102_entity_type_qual = @L2330A_3_nm102_entity_type_qual,
						@nm103_last_name = @L2330A_3_nm103_other_subscriber_last_name,
						@nm104_first_name = @L2330A_3_nm104_other_subscriber_first_name,
						@nm105_middle_name = @L2330A_3_nm105_other_subscriber_middle_name,
						@nm107_name_suffix = @L2330A_3_nm107_other_subscriber_name_suffix,
						@nm108_id_code_qual = @L2330A_3_nm108_other_subscriber_id_code_qual,
						@nm109_id_code = @L2330A_3_nm109_other_subscriber_id

			 

			set @L2330B_3_nm103_other_payer_nm = IsNull(@L2330B_3_nm103_other_payer_nm, 'UNSPECIFIED')
			set @L2330B_3_nm109_other_payer_id = IsNull(@L2330B_3_nm109_other_payer_id, '999999999')
			-- If the 2320 Loop is used, then the 2330A Loop and 2330A-NM1 segment is required
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = 'PR',
						@nm103_last_name = @L2330B_3_nm103_other_payer_nm,
						@nm108_id_code_qual = @L2330B_3_nm108_id_code_qual,
						@nm109_id_code = @L2330B_3_nm109_other_payer_id
		
			if 	(@L2330B_3_dtp03_573_date_claim_paid IS NOT NULL)
			begin
				exec up_x12_dtp_export	@x12_interchange_uid = @x12_interchange_uid,
							@dtp01_date_time_qual = '573',
							@dtp02_date_time_format_qual = 'D8',
							@dtp03_begin_date = @L2330B_3_dtp03_573_date_claim_paid
			end
		
		-- BEGIN: 2330B REF SEGMENTS
			
			-- 2330B Loop REF 2U segment
			if 	(@L2330B_3_ref02_2U_other_payer_secondary_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '2U',
							@ref02_reference_number = @L2330B_3_ref02_2U_other_payer_secondary_id
			end
			-- 2330B Loop REF F8 Segment
			if 	(@L2330B_3_ref02_F8_other_payer_secondary_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'F8',
							@ref02_reference_number = @L2330B_3_ref02_F8_other_payer_secondary_id
			end
			-- 2330B Loop REF FY Segment
			if 	(@L2330B_3_ref02_FY_other_payer_secondary_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'FY',
							@ref02_reference_number = @L2330B_3_ref02_FY_other_payer_secondary_id
			end
			-- 2330B Loop REF G2 Segment
			if 	(@L2330B_3_ref02_NF_other_payer_secondary_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'NF',
							@ref02_reference_number = @L2330B_3_ref02_NF_other_payer_secondary_id
			end
			-- 2330B Loop REF TJ
			if 	(@L2330B_3_ref02_TJ_other_payer_secondary_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'TJ',
							@ref02_reference_number = @L2330B_3_ref02_TJ_other_payer_secondary_id
			end
			-- 2330B Loop REF 9F
			if 	(@L2330B_3_ref02_9F_other_payer_auth_num IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '9F',
							@ref02_reference_number = @L2330B_3_ref02_9F_other_payer_auth_num
			end
			-- 2330B Loop REF G1
			if 	(@L2330B_3_ref02_G1_other_payer_auth_num IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'G1',
							@ref02_reference_number = @L2330B_3_ref02_G1_other_payer_auth_num
			end
			--End of 2330B LOOP
		end
		-- END OF THIRD 2320 LOOP GROUPING
	end
-- END OF 2300 LOOP GROUPING

--begin 2400 loop
	/*	If the current L2400_lx01_assigned_num value is different than the previous,
		we're starting a new procedure line.  Although it is assumed that each record
		in the 837i table is a procedure line, we use the LX segment as our assurance.

		If @L2400_lx01_assigned_num is null, put in a 1 (but really a valid procedure line should never
		have a NULL value in the LX segment).
	*/
	if ( @L2400_lx01_assigned_num <> IsNull(@prev_L2400_lx01_assigned_num, '') )
	begin
		set @L2400_lx01_assigned_num = IsNull(@L2400_lx01_assigned_num, '1')

		exec up_x12_lx_export	@x12_interchange_uid = @x12_interchange_uid,
					@lx01_assigned_num = @L2400_lx01_assigned_num

		-- Export the 2400-SV1 segment
		exec up_x12_sv2_export	@x12_interchange_uid = @x12_interchange_uid,
					@sv201_rev_code = @L2400_sv201_rev_code,
					@sv202_proc_code_qual = @L2400_sv202_proc_code_qual,
					@sv202_proc_code = @L2400_sv202_proc_code,
					@sv202_proc_mod1 = @L2400_sv202_proc_mod1,
					@sv202_proc_mod2 = @L2400_sv202_proc_mod2,
					@sv202_proc_mod3 = @L2400_sv202_proc_mod3,
					@sv202_proc_mod4 = @L2400_sv202_proc_mod4,
					@sv203_line_charge = @L2400_sv203_line_charge,
					@sv204_measurement_code = @L2400_sv204_measurement_code,
					@sv205_service_unit_count = @L2400_sv205_service_unit_count,
					@sv206_service_line_rate = @L2400_sv206_service_line_rate,
					@sv207_denied_amt = @L2400_sv207_denied_amt


		if 	(@L2400_dtp02_472_from_service_date  IS NOT NULL)
		begin
			exec up_x12_dtp_export	@x12_interchange_uid = @x12_interchange_uid,
						@dtp01_date_time_qual = '472',
						@dtp03_begin_date = @L2400_dtp02_472_from_service_date,
						@dtp03_end_date = @L2400_dtp02_472_to_service_date
		end
				
		-- BEGIN 2410 LOOP
		IF (@L2410_1_lin03_N4_ndc IS NOT NULL)
		BEGIN
			EXEC dbo.up_x12_lin_export @x12_interchange_uid = @x12_interchange_uid, -- uniqueidentifier
			    @2410_LIN02_ProductOrServiceIDQualifier = 'N4', -- varchar(2)
			    @2410_LIN03_NationalDrugCode = @L2410_1_lin03_N4_ndc -- varchar(48)
		END
	
	-- BEGIN OF 2420A LOOP
		-- If any of the 2420A attending provider information exists, export the loop.
		if (	@L2420A_nm103_attending_physician_last_nm IS NOT NULL OR
			@L2420A_nm108_id_code_qual IS NOT NULL OR
			@L2420A_nm109_attending_physician_id IS NOT NULL)
		begin
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = '71',
						@nm103_last_name = @L2420A_nm103_attending_physician_last_nm,
						@nm104_first_name = @L2420A_nm104_attending_physician_first_nm,
						@nm105_middle_name = @L2420A_nm105_attending_physician_middle_nm,
						@nm107_name_suffix = @L2420A_nm107_attending_physician_suffix,
						@nm108_id_code_qual = @L2420A_nm108_id_code_qual,
						@nm109_id_code = @L2420A_nm109_attending_physician_id

			-- BEGIN: 2420A REF SEGMENTS
			-- 2420A Loop REF 1C segment
			if 	(@L2420A_ref02_1C_attending_prov_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1C',
							@ref02_reference_number = @L2420A_ref02_1C_attending_prov_id
			end
			-- 2420A Loop REF 1D Segment
			if 	(@L2420A_ref02_1D_attending_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1D',
							@ref02_reference_number = @L2420A_ref02_1D_attending_prov_id
			end
			-- 2420A Loop REF 1G Segment
			if 	(@L2420A_ref02_1G_attending_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1G',
							@ref02_reference_number = @L2420A_ref02_1G_attending_prov_id
			end
			-- 2420A Loop REF EI Segment
			if 	(@L2420A_ref02_EI_attending_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'EI',
							@ref02_reference_number = @L2420A_ref02_EI_attending_prov_id
			end
			-- 2420A Loop REF SY
			if 	(@L2420A_ref02_SY_attending_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'SY',
							@ref02_reference_number = @L2420A_ref02_SY_attending_prov_id
			end
			-- 2420A Loop REF FH
			if 	(@L2420A_ref02_FH_attending_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'FH',
							@ref02_reference_number = @L2420A_ref02_FH_attending_prov_id
			end
			--End of 2420A REF SEGMENTS
		End	
	-- END OF 2420A LOOP

	
	-- BEGIN OF 2420B LOOP
		if (	@L2420B_nm103_operating_prov_last_nm IS NOT NULL OR
			@L2420B_nm108_id_code_qual IS NOT NULL OR
			@L2420B_nm109_operating_prov_id IS NOT NULL )
		begin
			-- If the 2420B loop is used, then the NM1 segment is always required.
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = '72',
						@nm103_last_name = @L2420B_nm103_operating_prov_last_nm,
						@nm104_first_name = @L2420B_nm104_operating_prov_first_nm,
						@nm105_middle_name = @L2420B_nm105_operating_prov_middle_nm,
						@nm107_name_suffix = @L2420B_nm107_operating_prov_suffix,
						@nm108_id_code_qual = @L2420B_nm108_id_code_qual,
						@nm109_id_code = @L2420B_nm109_operating_prov_id

		-- BEGIN: 2420B REF SEGMENTS
			-- 2420B Loop REF 1C segment
			if 	(@L2420B_ref02_1C_operating_prov_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1C',
							@ref02_reference_number = @L2420B_ref02_1C_operating_prov_id
			end
			-- 2420B Loop REF 1D Segment
			if 	(@L2420B_ref02_1D_operating_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1D',
							@ref02_reference_number = @L2420B_ref02_1D_operating_prov_id
			end
			-- 2420B Loop REF 1G Segment
			if 	(@L2420B_ref02_1G_operating_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1G',
							@ref02_reference_number = @L2420B_ref02_1G_operating_prov_id
			end
			-- 2420B Loop REF EI
			if 	(@L2420B_ref02_EI_operating_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'EI',
							@ref02_reference_number = @L2420B_ref02_EI_operating_prov_id
			end
			-- 2420B Loop REF SY
			if 	(@L2420B_ref02_SY_operating_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'SY',
							@ref02_reference_number = @L2420B_ref02_SY_operating_prov_id
			end
			-- 2420B Loop REF FH
			if 	(@L2420B_ref02_FH_operating_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'FH',
							@ref02_reference_number = @L2420B_ref02_FH_operating_prov_id
			end
		-- END: 2420B REF SEGMENTS
		End
	-- END OF 2420B LOOP
	




	-- BEGIN OF 2420C LOOP
		if (	@L2420C_nm103_other_prov_last_nm IS NOT NULL OR
			@L2420C_nm108_id_code_qual IS NOT NULL OR
			@L2420C_nm109_other_prov_id IS NOT NULL )
		begin
			-- If the 2420C loop is used, then the NM1 segment is always required.
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = '73',
						@nm103_last_name = @L2420C_nm103_other_prov_last_nm,
						@nm104_first_name = @L2420C_nm104_other_prov_first_nm,
						@nm105_middle_name = @L2420C_nm105_other_prov_middle_nm,
						@nm107_name_suffix = @L2420C_nm107_other_prov_suffix,
						@nm108_id_code_qual = @L2420C_nm108_id_code_qual,
						@nm109_id_code = @L2420C_nm109_other_prov_id

		-- BEGIN: 2420C REF SEGMENTS
			-- 2420C Loop REF 1C segment
			if 	(@L2420C_ref02_1C_other_prov_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1C',
							@ref02_reference_number = @L2420C_ref02_1C_other_prov_id
			end
			-- 2420C Loop REF 1D Segment
			if 	(@L2420C_ref02_1D_other_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1D',
							@ref02_reference_number = @L2420C_ref02_1D_other_prov_id
			end
			-- 2420C Loop REF 1G Segment
			if 	(@L2420C_ref02_1G_other_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1G',
							@ref02_reference_number = @L2420C_ref02_1G_other_prov_id
			end
			-- 2420C Loop REF EI
			if 	(@L2420C_ref02_EI_other_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'EI',
							@ref02_reference_number = @L2420C_ref02_EI_other_prov_id
			end
			-- 2420C Loop REF G2
			if 	(@L2420C_ref02_G2_other_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'G2',
							@ref02_reference_number = @L2420C_ref02_G2_other_prov_id
			end
			-- 2420C Loop REF SY
			if 	(@L2420C_ref02_SY_other_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'SY',
							@ref02_reference_number = @L2420C_ref02_SY_other_prov_id
			end
			-- 2420C Loop REF FH
			if 	(@L2420C_ref02_FH_other_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'FH',
							@ref02_reference_number = @L2420C_ref02_FH_other_prov_id
			end
		-- END: 2420C REF SEGMENTS
		End
	-- END OF 2420C LOOP

	
	-- Export a CAS segment for EVERY line where the charges don't equal the payment amount
		if (@L2430_svd01_payer_id IS NOT NULL)
		begin
			-- Export the SVD Segment
			exec up_x12_svd_export	@x12_interchange_uid = @x12_interchange_uid,
						@svd01_other_payer_id = @L2430_svd01_payer_id,
						@svd02_service_line_paid = @L2430_svd02_service_line_paid,
						@svd03_proc_code_qual = @L2430_svd03_proc_code_qual,
						@svd103_proc_code = @L2430_svd03_proc_code,
						@svd103_proc_mod1 = @L2430_svd03_proc_mod1,
						@svd103_proc_mod2 = @L2430_svd03_proc_mod2,
						@svd103_proc_mod3 = @L2430_svd03_proc_mod3,
						@svd103_proc_mod4 = @L2430_svd03_proc_mod4,
						@svd103_proc_code_desc = @L2430_svd03_proc_code_desc,
						@svd104_rev_code = @L2430_svd04_rev_code,
						@svd105_paid_service_count = @L2430_svd05_adj_qty,
						@svd106_bundled_line_num = @L2430_svd06_bundled_line_num

			if (@L2430_cas01_adjustment_group_code IS NOT NULL)
			begin
				exec up_x12_cas_export	@x12_interchange_uid = @x12_interchange_uid,
							@cas01_adjustment_group_code = @L2430_cas01_adjustment_group_code,
							@cas02_adjustment_reason_code = @L2430_cas02_adjustment_reason_code,
							@cas03_adjustment_amt = @L2430_cas03_adjustment_amt,
							@cas04_adjustment_qty = @L2430_cas04_adjustment_qty,
							@cas05_adjustment_reason_code = @L2430_cas05_adjustment_reason_code,
							@cas06_adjustment_amt = @L2430_cas06_adjustment_amt,
							@cas07_adjustment_qty = @L2430_cas07_adjustment_qty,
							@cas08_adjustment_reason_code = @L2430_cas08_adjustment_reason_code,
							@cas09_adjustment_amt = @L2430_cas09_adjustment_amt,
							@cas10_adjustment_qty = @L2430_cas10_adjustment_qty
			end

			if (@L2430_1_cas01_adjustment_group_code IS NOT NULL)
			begin
				exec up_x12_cas_export	@x12_interchange_uid = @x12_interchange_uid,
							@cas01_adjustment_group_code = @L2430_1_cas01_adjustment_group_code,
							@cas02_adjustment_reason_code = @L2430_1_cas02_adjustment_reason_code,
							@cas03_adjustment_amt = @L2430_1_cas03_adjustment_amt,
							@cas04_adjustment_qty = @L2430_1_cas04_adjustment_qty,
							@cas05_adjustment_reason_code = @L2430_1_cas05_adjustment_reason_code,
							@cas06_adjustment_amt = @L2430_1_cas06_adjustment_amt,
							@cas07_adjustment_qty = @L2430_1_cas07_adjustment_qty,
							@cas08_adjustment_reason_code = @L2430_1_cas08_adjustment_reason_code,
							@cas09_adjustment_amt = @L2430_1_cas09_adjustment_amt,
							@cas10_adjustment_qty = @L2430_1_cas10_adjustment_qty,
							@cas11_adjustment_reason_code = @L2430_1_cas11_adjustment_reason_code,
							@cas12_adjustment_amt = @L2430_1_cas12_adjustment_amt,
							@cas13_adjustment_qty = @L2430_1_cas13_adjustment_qty,
							@cas14_adjustment_reason_code = @L2430_1_cas14_adjustment_reason_code,
							@cas15_adjustment_amt = @L2430_1_cas15_adjustment_amt,
							@cas16_adjustment_qty = @L2430_1_cas16_adjustment_qty,
							@cas17_adjustment_reason_code = @L2430_1_cas17_adjustment_reason_code,
							@cas18_adjustment_amt = @L2430_1_cas18_adjustment_amt,
							@cas19_adjustment_qty = @L2430_1_cas19_adjustment_qty
			end
		
			if (@L2430_2_cas01_adjustment_group_code IS NOT NULL)
			begin
				exec up_x12_cas_export	@x12_interchange_uid = @x12_interchange_uid,
							@cas01_adjustment_group_code = @L2430_2_cas01_adjustment_group_code,
							@cas02_adjustment_reason_code = @L2430_2_cas02_adjustment_reason_code,
							@cas03_adjustment_amt = @L2430_2_cas03_adjustment_amt,
							@cas04_adjustment_qty = @L2430_2_cas04_adjustment_qty,
							@cas05_adjustment_reason_code = @L2430_2_cas05_adjustment_reason_code,
							@cas06_adjustment_amt = @L2430_2_cas06_adjustment_amt,
							@cas07_adjustment_qty = @L2430_2_cas07_adjustment_qty,
							@cas08_adjustment_reason_code = @L2430_2_cas08_adjustment_reason_code,
							@cas09_adjustment_amt = @L2430_2_cas09_adjustment_amt,
							@cas10_adjustment_qty = @L2430_2_cas10_adjustment_qty,
							@cas11_adjustment_reason_code = @L2430_2_cas11_adjustment_reason_code,
							@cas12_adjustment_amt = @L2430_2_cas12_adjustment_amt,
							@cas13_adjustment_qty = @L2430_2_cas13_adjustment_qty,
							@cas14_adjustment_reason_code = @L2430_2_cas14_adjustment_reason_code,
							@cas15_adjustment_amt = @L2430_2_cas15_adjustment_amt,
							@cas16_adjustment_qty = @L2430_2_cas16_adjustment_qty,
							@cas17_adjustment_reason_code = @L2430_2_cas17_adjustment_reason_code,
							@cas18_adjustment_amt = @L2430_2_cas18_adjustment_amt,
							@cas19_adjustment_qty = @L2430_2_cas19_adjustment_qty
			end
		
			if (@L2430_3_cas01_adjustment_group_code IS NOT NULL)
			begin
				exec up_x12_cas_export	@x12_interchange_uid = @x12_interchange_uid,
							@cas01_adjustment_group_code = @L2430_3_cas01_adjustment_group_code,
							@cas02_adjustment_reason_code = @L2430_3_cas02_adjustment_reason_code,
							@cas03_adjustment_amt = @L2430_3_cas03_adjustment_amt,
							@cas04_adjustment_qty = @L2430_3_cas04_adjustment_qty,
							@cas05_adjustment_reason_code = @L2430_3_cas05_adjustment_reason_code,
							@cas06_adjustment_amt = @L2430_3_cas06_adjustment_amt,
							@cas07_adjustment_qty = @L2430_3_cas07_adjustment_qty,
							@cas08_adjustment_reason_code = @L2430_3_cas08_adjustment_reason_code,
							@cas09_adjustment_amt = @L2430_3_cas09_adjustment_amt,
							@cas10_adjustment_qty = @L2430_3_cas10_adjustment_qty,
							@cas11_adjustment_reason_code = @L2430_3_cas11_adjustment_reason_code,
							@cas12_adjustment_amt = @L2430_3_cas12_adjustment_amt,
							@cas13_adjustment_qty = @L2430_3_cas13_adjustment_qty,
							@cas14_adjustment_reason_code = @L2430_3_cas14_adjustment_reason_code,
							@cas15_adjustment_amt = @L2430_3_cas15_adjustment_amt,
							@cas16_adjustment_qty = @L2430_3_cas16_adjustment_qty,
							@cas17_adjustment_reason_code = @L2430_3_cas17_adjustment_reason_code,
							@cas18_adjustment_amt = @L2430_3_cas18_adjustment_amt,
							@cas19_adjustment_qty = @L2430_3_cas19_adjustment_qty
			end
		
			if (@L2430_4_cas01_adjustment_group_code IS NOT NULL)
			begin
				exec up_x12_cas_export	@x12_interchange_uid = @x12_interchange_uid,
							@cas01_adjustment_group_code = @L2430_4_cas01_adjustment_group_code,
							@cas02_adjustment_reason_code = @L2430_4_cas02_adjustment_reason_code,
							@cas03_adjustment_amt = @L2430_4_cas03_adjustment_amt,
							@cas04_adjustment_qty = @L2430_4_cas04_adjustment_qty,
							@cas05_adjustment_reason_code = @L2430_4_cas05_adjustment_reason_code,
							@cas06_adjustment_amt = @L2430_4_cas06_adjustment_amt,
							@cas07_adjustment_qty = @L2430_4_cas07_adjustment_qty,
							@cas08_adjustment_reason_code = @L2430_4_cas08_adjustment_reason_code,
							@cas09_adjustment_amt = @L2430_4_cas09_adjustment_amt,
							@cas10_adjustment_qty = @L2430_4_cas10_adjustment_qty,
							@cas11_adjustment_reason_code = @L2430_4_cas11_adjustment_reason_code,
							@cas12_adjustment_amt = @L2430_4_cas12_adjustment_amt,
							@cas13_adjustment_qty = @L2430_4_cas13_adjustment_qty,
							@cas14_adjustment_reason_code = @L2430_4_cas14_adjustment_reason_code,
							@cas15_adjustment_amt = @L2430_4_cas15_adjustment_amt,
							@cas16_adjustment_qty = @L2430_4_cas16_adjustment_qty,
							@cas17_adjustment_reason_code = @L2430_4_cas17_adjustment_reason_code,
							@cas18_adjustment_amt = @L2430_4_cas18_adjustment_amt,
							@cas19_adjustment_qty = @L2430_4_cas19_adjustment_qty				 
			end
	
			if (@L2430_5_cas01_adjustment_group_code IS NOT NULL)
			begin
				exec up_x12_cas_export	@x12_interchange_uid = @x12_interchange_uid,
							@cas01_adjustment_group_code = @L2430_5_cas01_adjustment_group_code,
							@cas02_adjustment_reason_code = @L2430_5_cas02_adjustment_reason_code,
							@cas03_adjustment_amt = @L2430_5_cas03_adjustment_amt,
							@cas04_adjustment_qty = @L2430_5_cas04_adjustment_qty,
							@cas05_adjustment_reason_code = @L2430_5_cas05_adjustment_reason_code,
							@cas06_adjustment_amt = @L2430_5_cas06_adjustment_amt,
							@cas07_adjustment_qty = @L2430_5_cas07_adjustment_qty,
							@cas08_adjustment_reason_code = @L2430_5_cas08_adjustment_reason_code,
							@cas09_adjustment_amt = @L2430_5_cas09_adjustment_amt,
							@cas10_adjustment_qty = @L2430_5_cas10_adjustment_qty,
							@cas11_adjustment_reason_code = @L2430_5_cas11_adjustment_reason_code,
							@cas12_adjustment_amt = @L2430_5_cas12_adjustment_amt,
							@cas13_adjustment_qty = @L2430_5_cas13_adjustment_qty,
							@cas14_adjustment_reason_code = @L2430_5_cas14_adjustment_reason_code,
							@cas15_adjustment_amt = @L2430_5_cas15_adjustment_amt,
							@cas16_adjustment_qty = @L2430_5_cas16_adjustment_qty,
							@cas17_adjustment_reason_code = @L2430_5_cas17_adjustment_reason_code,
							@cas18_adjustment_amt = @L2430_5_cas18_adjustment_amt,
							@cas19_adjustment_qty = @L2430_5_cas19_adjustment_qty				 
			end
	
			exec up_x12_dtp_export	@x12_interchange_uid = @x12_interchange_uid,
						@dtp01_date_time_qual = '573',
						@dtp02_date_time_format_qual = 'D8',
						@dtp03_begin_date = @L2430_dtp03_573_service_adjudication_date 
	
			 
		end
		-- END OF 2430 LOOP
	end
	-- END OF 2400 LOOP GROUPING, LX SERVICE LINE CHECK

	-- BEGIN: SET PREV VARS
	set @prev_bht01_hierarchical_structure_code = @bht01_hierarchical_structure_code
	set @prev_bht02_trans_set_purpose_code = @bht02_trans_set_purpose_code
	set @prev_bht03_orig_app_tran_id = @bht03_orig_app_tran_id
	set @prev_bht04_trans_set_creation_date = @bht04_trans_set_creation_date
	set @prev_bht05_trans_set_creation_time = @bht05_trans_set_creation_time
	set @prev_bht06_claim_encounter_id = @bht06_claim_encounter_id
	
	set @prev_ref01_receiver_ref_id_qual = @ref01_receiver_ref_id_qual
	set @prev_ref02_transmission_type_code = @ref02_transmission_type_code
	
	set @prev_L1000A_nm103_submitter_last_nm = @L1000A_nm103_submitter_last_nm
	set @prev_L1000B_nm103_receiver_last_nm = @L1000B_nm103_receiver_last_nm
	
	set @prev_L1000B_nm108_receiver_id_qual = @L1000B_nm108_receiver_id_qual
	set @prev_L1000B_nm109_receiver_id = @L1000B_nm109_receiver_id
	
	set @prev_L2000A_hl01_hierarchical_id_num = @L2000A_hl01_hierarchical_id_num
	set @prev_L2000A_hl03_hierarchical_level_code = @L2000A_hl03_hierarchical_level_code
	set @prev_L2000A_hl04_hierarchical_child_code = @L2000A_hl04_hierarchical_child_code 
	
	set @prev_L2010AA_nm103_billing_prov_last_nm = @L2010AA_nm103_billing_prov_last_nm
	set @prev_L2010AA_nm104_billing_prov_first_nm = @L2010AA_nm104_billing_prov_first_nm
	set @prev_L2010AA_nm105_billing_prov_middle_nm = @L2010AA_nm105_billing_prov_middle_nm
	set @prev_L2010AA_nm107_billing_prov_suffix = @L2010AA_nm107_billing_prov_suffix
	set @prev_L2010AA_nm108_id_code_qual = @L2010AA_nm108_id_code_qual
	set @prev_L2010AA_nm109_billing_prov_id = @L2010AA_nm109_billing_prov_id
	set @prev_L2010AA_n301_billing_prov_address1 = @L2010AA_n301_billing_prov_address1
	set @prev_L2010AA_n302_billing_prov_address2 = @L2010AA_n302_billing_prov_address2
	set @prev_L2010AA_n401_billing_prov_city = @L2010AA_n401_billing_prov_city
	set @prev_L2010AA_n402_billing_prov_state = @L2010AA_n402_billing_prov_state
	set @prev_L2010AA_n403_billing_prov_zip = @L2010AA_n403_billing_prov_zip
	set @prev_L2010AA_n404_billing_prov_country = @L2010AA_n404_billing_prov_country
	set @prev_L2010AA_ref02_1C_billing_prov_id = @L2010AA_ref02_1C_billing_prov_id
	set @prev_L2010AA_ref02_1D_billing_prov_id = @L2010AA_ref02_1D_billing_prov_id
	set @prev_L2010AA_ref02_1G_billing_prov_id = @L2010AA_ref02_1G_billing_prov_id
	set @prev_L2010AA_ref02_EI_billing_prov_id = @L2010AA_ref02_EI_billing_prov_id
	set @prev_L2010AA_ref02_SY_billing_prov_id = @L2010AA_ref02_SY_billing_prov_id
	set @prev_L2010AA_ref02_FH_billing_prov_id = @L2010AA_ref02_FH_billing_prov_id

	set @prev_L2000B_hl01_hierarchical_id_num = @L2000B_hl01_hierarchical_id_num 
	set @prev_L2000B_hl02_hierarchical_parent_id_num = @L2000B_hl02_hierarchical_parent_id_num 
	set @prev_L2000B_hl03_hierarchical_level_code = @L2000B_hl03_hierarchical_level_code 
	set @prev_L2000B_hl04_hierarchical_child_code = @L2000B_hl04_hierarchical_child_code 
	
	set @prev_L2000B_sbr01_payer_resp_seq_code = @L2000B_sbr01_payer_resp_seq_code
	set @prev_L2000B_sbr02_ind_relationship_code = @L2000B_sbr02_ind_relationship_code
	set @prev_L2000B_sbr03_insured_grp_policy_num = @L2000B_sbr03_insured_grp_policy_num
	set @prev_L2000B_sbr04_insured_grp_nm = @L2000B_sbr04_insured_grp_nm
	set @prev_L2000B_sbr09_claim_id_code = @L2000B_sbr09_claim_id_code
	set @prev_L2010BA_nm102_entity_type_qual = @L2010BA_nm102_entity_type_qual
	set @prev_L2010BA_nm103_subscriber_last_nm = @L2010BA_nm103_subscriber_last_nm
	set @prev_L2010BA_nm104_subscriber_first_nm = @L2010BA_nm104_subscriber_first_nm
	set @prev_L2010BA_nm105_subscriber_middle_nm = @L2010BA_nm105_subscriber_middle_nm
	set @prev_L2010BA_nm107_subscriber_suffix = @L2010BA_nm107_subscriber_suffix
	set @prev_L2010BA_nm108_id_code_qual = @L2010BA_nm108_id_code_qual
	set @prev_L2010BA_nm109_subscriber_id = @L2010BA_nm109_subscriber_id
	set @prev_L2010BA_n301_subscriber_address1 = @L2010BA_n301_subscriber_address1
	set @prev_L2010BA_n302_subscriber_address2 = @L2010BA_n302_subscriber_address2
	set @prev_L2010BA_n401_subscriber_city = @L2010BA_n401_subscriber_city
	set @prev_L2010BA_n402_subscriber_state = @L2010BA_n402_subscriber_state
	set @prev_L2010BA_n403_subscriber_zip = @L2010BA_n403_subscriber_zip

	set @prev_L2000C_hl01_hierarchical_id_num = @L2000C_hl01_hierarchical_id_num 
	set @prev_L2000C_hl02_hierarchical_parent_id_num = @L2000C_hl02_hierarchical_parent_id_num 
	set @prev_L2000C_hl03_hierarchical_level_code = @L2000C_hl03_hierarchical_level_code 
	set @prev_L2000C_hl04_hierarchical_child_code = @L2000C_hl04_hierarchical_child_code 

	set @prev_L2010CA_nm103_patient_last_nm = @L2010CA_nm103_patient_last_nm
	set @prev_L2010CA_nm104_patient_first_nm = @L2010CA_nm104_patient_first_nm
	set @prev_L2010CA_nm105_patient_middle_nm = @L2010CA_nm105_patient_middle_nm
	set @prev_L2010CA_nm107_patient_suffix = @L2010CA_nm107_patient_suffix
	set @prev_L2010CA_nm108_id_code_qual = @L2010CA_nm108_id_code_qual
	set @prev_L2010CA_nm109_patient_id = @L2010CA_nm109_patient_id

	set @prev_L2300_clm01_pt_acct_num = @L2300_clm01_pt_acct_num 
	set @prev_L2300_clm02_total_claim_chg_amt = @L2300_clm02_total_claim_chg_amt 
	set @prev_L2300_ref02_F8_original_ref_num = @L2300_ref02_F8_original_ref_num

	set @prev_L2330B_1_ref02_F8_other_payer_secondary_id = @L2330B_1_ref02_F8_other_payer_secondary_id
	set @prev_L2330B_2_ref02_F8_other_payer_secondary_id = @L2330B_2_ref02_F8_other_payer_secondary_id
	set @prev_L2330B_3_ref02_F8_other_payer_secondary_id = @L2330B_3_ref02_F8_other_payer_secondary_id

	set @prev_L2400_lx01_assigned_num = @L2400_lx01_assigned_num
	
	SET @prev_L2410_1_lin03_N4_ndc = @L2410_1_lin03_N4_ndc
	-- END: SET PREV VARS

		
	FETCH NEXT FROM curtX12Doc INTO	@x12_transaction_id,
					@bht01_hierarchical_structure_code,
					@bht02_trans_set_purpose_code,
					@bht03_orig_app_tran_id,
					@bht04_trans_set_creation_date,
					@bht05_trans_set_creation_time,
					@bht06_claim_encounter_id,
					@ref01_receiver_ref_id_qual,
					@ref02_transmission_type_code,
					@L1000A_nm102_entity_type_qual,
					@L1000A_nm103_submitter_last_nm,
					@L1000A_nm104_submitter_first_nm,
					@L1000A_nm105_submitter_middle_nm,
					@L1000A_nm108_submitter_id_qual,
					@L1000A_nm109_submitter_id,
					@L1000A_per01_contact_function_code,
					@L1000A_per02_contact_nm,
					@L1000A_per03_comm_num_qual,
					@L1000A_per04_comm_number,
					@L1000B_nm102_entity_type_qual,
					@L1000B_nm103_receiver_last_nm,
					@L1000B_nm108_receiver_id_qual,
					@L1000B_nm109_receiver_id,
					@L2000A_hl01_hierarchical_id_num, 
					@L2000A_hl03_hierarchical_level_code,
					@L2000A_hl04_hierarchical_child_code,
					@L2000A_prv01_provider_code,
					@L2000A_prv02_ref_id_qual,
					@L2000A_prv03_taxonomy_code,
					@L2000A_cur02_currency_code,
					@L2010AA_nm102_entity_type_qual,
					@L2010AA_nm103_billing_prov_last_nm,
					@L2010AA_nm104_billing_prov_first_nm,
					@L2010AA_nm105_billing_prov_middle_nm,
					@L2010AA_nm107_billing_prov_suffix,
					@L2010AA_nm108_id_code_qual,
					@L2010AA_nm109_billing_prov_id,
					@L2010AA_n301_billing_prov_address1,
					@L2010AA_n302_billing_prov_address2,
					@L2010AA_n401_billing_prov_city,
					@L2010AA_n402_billing_prov_state,
					@L2010AA_n403_billing_prov_zip,
					@L2010AA_n404_billing_prov_country,
					@L2010AA_ref02_1B_billing_prov_id,
					@L2010AA_ref02_1C_billing_prov_id,
					@L2010AA_ref02_1D_billing_prov_id,
					@L2010AA_ref02_1G_billing_prov_id,
					@L2010AA_ref02_EI_billing_prov_id,
					@L2010AA_ref02_SY_billing_prov_id,
					@L2010AA_ref02_FH_billing_prov_id,
					@L2010AA_ref02_06_card_billing_id,
					@L2010AA_ref02_8U_card_billing_id,
					@L2010AA_ref02_EM_card_billing_id,
					@L2010AA_ref02_IJ_card_billing_id,
					@L2010AA_ref02_LU_card_billing_id,
					@L2010AA_ref02_ST_card_billing_id,
					@L2010AA_per01_billing_prov_comm_func_code,
					@L2010AA_per02_billing_prov_contact_nm,
					@L2010AA_per03_billing_prov_comm_num_qual,
					@L2010AA_per04_billing_prov_comm,
					@L2010AB_nm102_entity_type_qual,
					@L2010AB_nm103_payto_prov_last_nm,
					@L2010AB_nm104_payto_prov_first_nm,
					@L2010AB_nm105_payto_prov_middle_nm,
					@L2010AB_nm107_payto_prov_suffix,
					@L2010AB_nm108_id_code_qual,
					@L2010AB_nm109_payto_prov_id,
					@L2010AB_n301_payto_prov_address1,
					@L2010AB_n302_payto_prov_address2,
					@L2010AB_n401_payto_prov_city,
					@L2010AB_n402_payto_prov_state,
					@L2010AB_n403_payto_prov_zip,
					@L2010AB_n404_payto_prov_country,
					@L2010AB_ref02_1C_payto_prov_id,
					@L2010AB_ref02_1D_payto_prov_id,
					@L2010AB_ref02_1G_payto_prov_id,
					@L2010AB_ref02_EI_payto_prov_id,
					@L2010AB_ref02_SY_payto_prov_id,
					@L2010AB_ref02_FH_payto_prov_id,
					@L2000B_hl01_hierarchical_id_num, 
					@L2000B_hl02_hierarchical_parent_id_num, 
					@L2000B_hl03_hierarchical_level_code,
					@L2000B_hl04_hierarchical_child_code,
					@L2000B_sbr01_payer_resp_seq_code,
					@L2000B_sbr02_ind_relationship_code,
					@L2000B_sbr03_insured_grp_policy_num,
					@L2000B_sbr04_insured_grp_nm,
					@L2000B_sbr09_claim_id_code,
					@L2000B_pat06_insured_ind_death_date,
					@L2000B_pat08_patient_weight,
					@L2000B_pat09_pregnancy_indicator,
					@L2010BA_nm102_entity_type_qual,
					@L2010BA_nm103_subscriber_last_nm,
					@L2010BA_nm104_subscriber_first_nm,
					@L2010BA_nm105_subscriber_middle_nm,
					@L2010BA_nm107_subscriber_suffix,
					@L2010BA_nm108_id_code_qual,
					@L2010BA_nm109_subscriber_id,
					@L2010BA_n301_subscriber_address1,
					@L2010BA_n302_subscriber_address2,
					@L2010BA_n401_subscriber_city,
					@L2010BA_n402_subscriber_state,
					@L2010BA_n403_subscriber_zip,
					@L2010BA_n404_subscriber_country,
					@L2010BA_dmg02_subscriber_dob,
					@L2010BA_dmg03_subscriber_gender,
					@L2010BA_ref02_1W_subscriber_sup_id,
					@L2010BA_ref02_23_subscriber_sup_id,
					@L2010BA_ref02_IG_subscriber_sup_id,
					@L2010BA_ref02_SY_subscriber_sup_id,
					@L2010BA_ref02_Y4_prop_casualty_claim_num,
					@L2010BB_nm102_entity_type_qual,
					@L2010BB_nm103_card_holder_last_nm,
					@L2010BB_nm104_card_holder_first_nm,
					@L2010BB_nm105_card_holder_middle_nm,
					@L2010BB_nm107_card_holder_suffix,
					@L2010BB_nm108_card_id_qual,
					@L2010BB_nm109_card_num,
					@L2010BB_ref02_AB_payer_id,
					@L2010BB_ref02_BB_payer_id,
					@L2010BC_nm102_entity_type_qual,
					@L2010BC_nm103_payer_nm,
					@L2010BC_nm108_payer_id_qual,
					@L2010BC_nm109_payer_id,
					@L2010BC_n301_payer_address1,
					@L2010BC_n302_payer_address2,
					@L2010BC_n401_payer_city,
					@L2010BC_n402_payer_state,
					@L2010BC_n403_payer_zip,
					@L2010BC_n404_payer_country,
					@L2010BC_ref02_2U_payer_id,
					@L2010BC_ref02_FY_payer_id,
					@L2010BC_ref02_NF_payer_id,
					@L2010BC_ref02_TJ_payer_id,
					@L2010BD_nm102_entity_type_qual,
					@L2010BD_nm103_resp_party_last_nm,
					@L2010BD_nm104_resp_party_first_nm,
					@L2010BD_nm105_resp_party_middle_nm,
					@L2010BD_nm107_resp_party_suffix,
					@L2010BD_n301_resp_party_address1,
					@L2010BD_n302_resp_party_address2,
					@L2010BD_n401_resp_party_city,
					@L2010BD_n402_resp_party_state,
					@L2010BD_n403_resp_party_zip,
					@L2010BD_n404_resp_party_country,
					@L2000C_hl01_hierarchical_id_num, 
					@L2000C_hl02_hierarchical_parent_id_num, 
					@L2000C_hl03_hierarchical_level_code,
					@L2000C_hl04_hierarchical_child_code,
					@L2000C_pat01_ind_relationship_code,
					@L2010CA_nm102_entity_type_qual,
					@L2010CA_nm103_patient_last_nm,
					@L2010CA_nm104_patient_first_nm,
					@L2010CA_nm105_patient_middle_nm,
					@L2010CA_nm107_patient_suffix,
					@L2010CA_nm108_id_code_qual,
					@L2010CA_nm109_patient_id,
					@L2010CA_n301_patient_address1,
					@L2010CA_n302_patient_address2,
					@L2010CA_n401_patient_city,
					@L2010CA_n402_patient_state,
					@L2010CA_n403_patient_zip,
					@L2010CA_n404_patient_country,
					@L2010CA_dmg02_patient_dob,
					@L2010CA_dmg03_patient_gender,
					@L2010CA_ref02_1W_patient_sup_id,
					@L2010CA_ref02_23_patient_sup_id,
					@L2010CA_ref02_IG_patient_sup_id,
					@L2010CA_ref02_SY_patient_sup_id,
					@L2010CA_ref02_Y4_prop_casualty_claim_num,
					@L2300_clm01_pt_acct_num,
					@L2300_clm02_total_claim_chg_amt, 
					@L2300_clm05_facility_type_code,
					@L2300_clm05_facility_code_qual,
					@L2300_clm05_claim_freq_code,
					@L2300_clm06_provider_signature_ind,
					@L2300_clm07_medicare_assign_code,
					@L2300_clm08_benefit_assign_ind,
					@L2300_clm09_release_of_info_code,
					@L2300_clm18_explan_benefits_ind,
					@L2300_clm20_delay_reason_code,
					@L2300_dtp03_096_discharge_hour,
					@L2300_dtp03_434_begin_statement_date,
					@L2300_dtp03_434_end_statement_date,
					@L2300_dtp03_435_admission_date,
					@L2300_cl101_admit_type_code,
					@L2300_cl102_admit_source_code,
					@L2300_cl103_patient_status_code,
					@L2300_pwk01_attachment_type_code,
					@L2300_pwk02_attachment_trans_code,
					@L2300_pwk06_attachment_control_num,
					@L2300_amt02_patient_paid_amt,
					@L2300_amt02_patient_resp_amt,
					@L2300_amt02_total_purchased_amt, 
					@L2300_ref02_9C_adj_repriced_claim_num,
					@L2300_ref02_9A_repriced_claim_num,
					@L2300_ref02_D9_claim_id_clearing_house,
					@L2300_ref02_DD_domcument_id,
					@L2300_ref02_F8_original_ref_num,
					@L2300_ref02_9F_referral_num,
					@L2300_ref02_G1_prior_auth_num,
					@L2300_ref02_EA_medical_record_num,
					@L2300_k301_fixed_format_info,
					@L2300_nte01_note_ref_code,
					@L2300_nte02_claim_note_text,
					@L2300_hi01_BK_diag_admit_ecode,
					@L2300_hi02_BJ_diag_admit_ecode,
					@L2300_hi02_ZZ_diag_admit_ecode,
					@L2300_hi03_BN_diag_admit_ecode,
					@L2300_hi01_DR_diag_drg,
					@L2300_hi01_BF_diag_code,
					@L2300_hi02_BF_diag_code,
					@L2300_hi03_BF_diag_code,
					@L2300_hi04_BF_diag_code,
					@L2300_hi05_BF_diag_code,
					@L2300_hi06_BF_diag_code,
					@L2300_hi07_BF_diag_code,
					@L2300_hi08_BF_diag_code,
					@L2300_hi09_BF_diag_code,
					@L2300_hi10_BF_diag_code,
					@L2300_hi11_BF_diag_code,
					@L2300_hi12_BF_diag_code,
					@L2300_hi01_BR_princ_proc_info,
					@L2300_hi01_BR_princ_proc_info_date,
					@L2300_hi01_BQ_other_proc_info,
					@L2300_hi01_BQ_other_proc_info_date,
					@L2300_hi02_BQ_other_proc_info,
					@L2300_hi02_BQ_other_proc_info_date,
					@L2300_hi03_BQ_other_proc_info,
					@L2300_hi03_BQ_other_proc_info_date,
					@L2300_hi04_BQ_other_proc_info,
					@L2300_hi04_BQ_other_proc_info_date,
					@L2300_hi05_BQ_other_proc_info,
					@L2300_hi05_BQ_other_proc_info_date,
					@L2300_hi06_BQ_other_proc_info,
					@L2300_hi06_BQ_other_proc_info_date,
					@L2300_hi07_BQ_other_proc_info,
					@L2300_hi07_BQ_other_proc_info_date,
					@L2300_hi08_BQ_other_proc_info,
					@L2300_hi08_BQ_other_proc_info_date,
					@L2300_hi09_BQ_other_proc_info,
					@L2300_hi09_BQ_other_proc_info_date,
					@L2300_hi10_BQ_other_proc_info,
					@L2300_hi10_BQ_other_proc_info_date,
					@L2300_hi11_BQ_other_proc_info,
					@L2300_hi11_BQ_other_proc_info_date,
					@L2300_hi12_BQ_other_proc_info,
					@L2300_hi12_BQ_other_proc_info_date,
					@L2300_hi01_BI_occur_span,
					@L2300_hi01_BI_occur_span_date,
					@L2300_hi02_BI_occur_span,
					@L2300_hi02_BI_occur_span_date,
					@L2300_hi03_BI_occur_span,
					@L2300_hi03_BI_occur_span_date,
					@L2300_hi04_BI_occur_span,
					@L2300_hi04_BI_occur_span_date,
					@L2300_hi05_BI_occur_span,
					@L2300_hi05_BI_occur_span_date,
					@L2300_hi06_BI_occur_span,
					@L2300_hi06_BI_occur_span_date,
					@L2300_hi07_BI_occur_span,
					@L2300_hi07_BI_occur_span_date,
					@L2300_hi08_BI_occur_span,
					@L2300_hi08_BI_occur_span_date,
					@L2300_hi09_BI_occur_span,
					@L2300_hi09_BI_occur_span_date,
					@L2300_hi10_BI_occur_span,
					@L2300_hi10_BI_occur_span_date,
					@L2300_hi11_BI_occur_span,
					@L2300_hi11_BI_occur_span_date,
					@L2300_hi12_BI_occur_span,
					@L2300_hi12_BI_occur_span_date,
					@L2300_hi01_BH_occur_info,
					@L2300_hi01_BH_occur_info_date,
					@L2300_hi02_BH_occur_info,
					@L2300_hi02_BH_occur_info_date,
					@L2300_hi03_BH_occur_info,
					@L2300_hi03_BH_occur_info_date,
					@L2300_hi04_BH_occur_info,
					@L2300_hi04_BH_occur_info_date,
					@L2300_hi05_BH_occur_info,
					@L2300_hi05_BH_occur_info_date,
					@L2300_hi06_BH_occur_info,
					@L2300_hi06_BH_occur_info_date,
					@L2300_hi07_BH_occur_info,
					@L2300_hi07_BH_occur_info_date,
					@L2300_hi08_BH_occur_info,
					@L2300_hi08_BH_occur_info_date,
					@L2300_hi09_BH_occur_info,
					@L2300_hi09_BH_occur_info_date,
					@L2300_hi10_BH_occur_info,
					@L2300_hi10_BH_occur_info_date,
					@L2300_hi11_BH_occur_info,
					@L2300_hi11_BH_occur_info_date,
					@L2300_hi12_BH_occur_info,
					@L2300_hi12_BH_occur_info_date,
					@L2300_hi01_BE_value_info,
					@L2300_hi01_BE_value_info_amt,
					@L2300_hi02_BE_value_info,
					@L2300_hi02_BE_value_info_amt,
					@L2300_hi03_BE_value_info,
					@L2300_hi03_BE_value_info_amt,
					@L2300_hi04_BE_value_info,
					@L2300_hi04_BE_value_info_amt,
					@L2300_hi05_BE_value_info,
					@L2300_hi05_BE_value_info_amt,
					@L2300_hi06_BE_value_info,
					@L2300_hi06_BE_value_info_amt,
					@L2300_hi07_BE_value_info,
					@L2300_hi07_BE_value_info_amt,
					@L2300_hi08_BE_value_info,
					@L2300_hi08_BE_value_info_amt,
					@L2300_hi09_BE_value_info,
					@L2300_hi09_BE_value_info_amt,
					@L2300_hi10_BE_value_info,
					@L2300_hi10_BE_value_info_amt,
					@L2300_hi11_BE_value_info,
					@L2300_hi11_BE_value_info_amt,
					@L2300_hi12_BE_value_info,
					@L2300_hi12_BE_value_info_amt,
					@L2300_hi01_BG_cond_info,
					@L2300_hi02_BG_cond_info,
					@L2300_hi03_BG_cond_info,
					@L2300_hi04_BG_cond_info,
					@L2300_hi05_BG_cond_info,
					@L2300_hi06_BG_cond_info,
					@L2300_hi07_BG_cond_info,
					@L2300_hi08_BG_cond_info,
					@L2300_hi09_BG_cond_info,
					@L2300_hi10_BG_cond_info,
					@L2300_hi11_BG_cond_info,
					@L2300_hi12_BG_cond_info,
					@L2300_hi01_TC_treat_code_info,
					@L2300_hi02_TC_treat_code_info,
					@L2300_hi03_TC_treat_code_info,
					@L2300_hi04_TC_treat_code_info,
					@L2300_hi05_TC_treat_code_info,
					@L2300_hi06_TC_treat_code_info,
					@L2300_hi07_TC_treat_code_info,
					@L2300_hi08_TC_treat_code_info,
					@L2300_hi09_TC_treat_code_info,
					@L2300_hi10_TC_treat_code_info,
					@L2300_hi11_TC_treat_code_info,
					@L2300_hi12_TC_treat_code_info,
					@L2300_qty02_CA_claim_qty,
					@L2300_qty02_CD_claim_qty,
					@L2300_qty02_LA_claim_qty,
					@L2300_qty02_NA_claim_qty,
					@L2310A_nm101_entity_id_code,
					@L2310A_nm102_entity_type_qual,
					@L2310A_nm103_attending_prov_last_nm,
					@L2310A_nm104_attending_prov_first_nm,
					@L2310A_nm105_attending_prov_middle_nm,
					@L2310A_nm107_attending_prov_suffix,
					@L2310A_nm108_id_code_qual,
					@L2310A_nm109_attending_prov_id,
					@L2310A_prv01_provider_code,
					@L2310A_prv02_ref_id_qual,
					@L2310A_prv03_taxonomy_code,
					@L2310A_ref02_1C_attending_prov_id,
					@L2310A_ref02_1D_attending_prov_id,
					@L2310A_ref02_1G_attending_prov_id,
					@L2310A_ref02_EI_attending_prov_id,
					@L2310A_ref02_SY_attending_prov_id,
					@L2310A_ref02_FH_attending_prov_id,
					@L2310B_nm102_entity_type_qual,
					@L2310B_nm103_operating_prov_last_nm,
					@L2310B_nm104_operating_prov_first_nm,
					@L2310B_nm105_operating_prov_middle_nm,
					@L2310B_nm107_operating_prov_suffix,
					@L2310B_nm108_id_code_qual,
					@L2310B_nm109_operating_prov_id,
					@L2310B_ref02_1C_operating_prov_id,
					@L2310B_ref02_1D_operating_prov_id,
					@L2310B_ref02_1G_operating_prov_id,
					@L2310B_ref02_EI_operating_prov_id,
					@L2310B_ref02_SY_operating_prov_id,
					@L2310B_ref02_FH_operating_prov_id,
					@L2310C_nm102_entity_type_qual,
					@L2310C_nm103_other_prov_last_nm,
					@L2310C_nm104_other_prov_first_nm,
					@L2310C_nm105_other_prov_middle_nm,
					@L2310C_nm107_other_prov_suffix,
					@L2310C_nm108_id_code_qual,
					@L2310C_nm109_other_prov_id,
					@L2310C_ref02_1C_other_prov_id,
					@L2310C_ref02_1D_other_prov_id,
					@L2310C_ref02_1G_other_prov_id,
					@L2310C_ref02_EI_other_prov_id,
					@L2310C_ref02_SY_other_prov_id,
					@L2310C_ref02_FH_other_prov_id,
					@L2310E_nm101_entity_id_code,
					@L2310E_nm102_entity_type_qual,
					@L2310E_nm103_service_facility_last_nm,
					@L2310E_nm108_id_code_qual,
					@L2310E_nm109_service_facility_id,
					@L2310E_n301_service_facility_address1,
					@L2310E_n302_service_facility_address2,
					@L2310E_n401_service_facility_city,
					@L2310E_n402_service_facility_state,
					@L2310E_n403_service_facility_zip,
					@L2310E_n404_service_facility_country,
					@L2310E_ref02_1C_service_facility_id,
					@L2310E_ref02_1D_service_facility_id,
					@L2310E_ref02_1G_service_facility_id,
					@L2310E_ref02_G2_service_facility_id,
					@L2320_1_sbr01_payer_resp_seq_code,
					@L2320_1_sbr02_ind_relationship_code,
					@L2320_1_sbr03_insured_grp_policy_num,
					@L2320_1_sbr04_insured_grp_nm,
					@L2320_1_sbr09_claim_file_ind_code,
					@L2320_1_cas01_adjustment_group_code,
					@L2320_1_cas02_adjustment_reason_code,
					@L2320_1_cas03_adjustment_amt,
					@L2320_1_cas04_adjustment_qty,
					@L2320_1_cas05_adjustment_reason_code,
					@L2320_1_cas06_adjustment_amt,
					@L2320_1_cas07_adjustment_qty,
					@L2320_1_cas08_adjustment_reason_code,
					@L2320_1_cas09_adjustment_amt,
					@L2320_1_cas10_adjustment_qty,
					@L2320_1_amt02_C4_payer_prior_pmt_amt,
					@L2320_1_amt02_B6_cob_allowed_amt,
					@L2320_1_amt02_T3_cob_submitted_amt,
					@L2320_1_amt02_ZZ_drg_outlier_amt,
					@L2320_1_amt02_N1_cob_medicare_paid_amt,
					@L2320_1_amt02_KF_medicare_paid_100_amt,
					@L2320_1_amt02_PG_medicare_paid_80_amt,
					@L2320_1_amt02_AA_cob_medicare_a_trust_pd_amt,
					@L2320_1_amt02_B1_cob_medicare_b_trust_pd_amt,
					@L2320_1_amt02_A8_cob_non_cvd_amt,
					@L2320_1_amt02_YT_cob_denied_amt,
					@L2320_1_dmg02_other_subscriber_dob,
					@L2320_1_dmg03_other_subscriber_gender,
					@L2320_1_oi03_other_ins_benefit_assign_ind,
					@L2320_1_oi06_other_ins_release_of_info_code,
					@L2330A_1_nm101_entity_id_code,
					@L2330A_1_nm102_entity_type_qual,
					@L2330A_1_nm103_other_subscriber_last_name,
					@L2330A_1_nm104_other_subscriber_first_name,
					@L2330A_1_nm105_other_subscriber_middle_name,
					@L2330A_1_nm107_other_subscriber_name_suffix,
					@L2330A_1_nm108_other_subscriber_id_code_qual,
					@L2330A_1_nm109_other_subscriber_id,
					@L2330B_1_nm101_entity_id_code,
					@L2330B_1_nm102_entity_type_qual,
					@L2330B_1_nm103_other_payer_nm,
					@L2330B_1_nm108_id_code_qual,
					@L2330B_1_nm109_other_payer_id,
					@L2330B_1_dtp03_573_date_claim_paid,
					@L2330B_1_ref02_2U_other_payer_secondary_id,
					@L2330B_1_ref02_F8_other_payer_secondary_id,
					@L2330B_1_ref02_FY_other_payer_secondary_id,
					@L2330B_1_ref02_NF_other_payer_secondary_id,
					@L2330B_1_ref02_TJ_other_payer_secondary_id,
					@L2330B_1_ref02_9F_other_payer_auth_num,
					@L2330B_1_ref02_G1_other_payer_auth_num,
					@L2320_2_sbr01_payer_resp_seq_code,
					@L2320_2_sbr02_ind_relationship_code,
					@L2320_2_sbr03_insured_grp_policy_num,
					@L2320_2_sbr04_insured_grp_nm,
					@L2320_2_sbr09_claim_file_ind_code,
					@L2320_2_cas01_adjustment_group_code,
					@L2320_2_cas02_adjustment_reason_code,
					@L2320_2_cas03_adjustment_amt,
					@L2320_2_cas04_adjustment_qty,
					@L2320_2_cas05_adjustment_reason_code,
					@L2320_2_cas06_adjustment_amt,
					@L2320_2_cas07_adjustment_qty,
					@L2320_2_cas08_adjustment_reason_code,
					@L2320_2_cas09_adjustment_amt,
					@L2320_2_cas10_adjustment_qty,
					@L2320_2_amt02_C4_payer_prior_pmt_amt,
					@L2320_2_amt02_B6_cob_allowed_amt,
					@L2320_2_amt02_T3_cob_submitted_amt,
					@L2320_2_amt02_ZZ_drg_outlier_amt,
					@L2320_2_amt02_N1_cob_medicare_paid_amt,
					@L2320_2_amt02_KF_medicare_paid_100_amt,
					@L2320_2_amt02_PG_medicare_paid_80_amt,
					@L2320_2_amt02_AA_cob_medicare_a_trust_pd_amt,
					@L2320_2_amt02_B1_cob_medicare_b_trust_pd_amt,
					@L2320_2_amt02_A8_cob_non_cvd_amt,
					@L2320_2_amt02_YT_cob_denied_amt,
					@L2320_2_dmg02_other_subscriber_dob,
					@L2320_2_dmg03_other_subscriber_gender,
					@L2320_2_oi03_other_ins_benefit_assign_ind,
					@L2320_2_oi06_other_ins_release_of_info_code,
					@L2330A_2_nm101_entity_id_code,
					@L2330A_2_nm102_entity_type_qual,
					@L2330A_2_nm103_other_subscriber_last_name,
					@L2330A_2_nm104_other_subscriber_first_name,
					@L2330A_2_nm105_other_subscriber_middle_name,
					@L2330A_2_nm107_other_subscriber_name_suffix,
					@L2330A_2_nm108_other_subscriber_id_code_qual,
					@L2330A_2_nm109_other_subscriber_id,
					@L2330B_2_nm101_entity_id_code,
					@L2330B_2_nm102_entity_type_qual,
					@L2330B_2_nm103_other_payer_nm,
					@L2330B_2_nm108_id_code_qual,
					@L2330B_2_nm109_other_payer_id,
					@L2330B_2_dtp03_573_date_claim_paid,
					@L2330B_2_ref02_2U_other_payer_secondary_id,
					@L2330B_2_ref02_F8_other_payer_secondary_id,
					@L2330B_2_ref02_FY_other_payer_secondary_id,
					@L2330B_2_ref02_NF_other_payer_secondary_id,
					@L2330B_2_ref02_TJ_other_payer_secondary_id,
					@L2330B_2_ref02_9F_other_payer_auth_num,
					@L2330B_2_ref02_G1_other_payer_auth_num,
					@L2320_3_sbr01_payer_resp_seq_code,
					@L2320_3_sbr02_ind_relationship_code,
					@L2320_3_sbr03_insured_grp_policy_num,
					@L2320_3_sbr04_insured_grp_nm,
					@L2320_3_sbr09_claim_file_ind_code,
					@L2320_3_cas01_adjustment_group_code,
					@L2320_3_cas02_adjustment_reason_code,
					@L2320_3_cas03_adjustment_amt,
					@L2320_3_cas04_adjustment_qty,
					@L2320_3_cas05_adjustment_reason_code,
					@L2320_3_cas06_adjustment_amt,
					@L2320_3_cas07_adjustment_qty,
					@L2320_3_cas08_adjustment_reason_code,
					@L2320_3_cas09_adjustment_amt,
					@L2320_3_cas10_adjustment_qty,
					@L2320_3_amt02_C4_payer_prior_pmt_amt,
					@L2320_3_amt02_B6_cob_allowed_amt,
					@L2320_3_amt02_T3_cob_submitted_amt,
					@L2320_3_amt02_ZZ_drg_outlier_amt,
					@L2320_3_amt02_N1_cob_medicare_paid_amt,
					@L2320_3_amt02_KF_medicare_paid_100_amt,
					@L2320_3_amt02_PG_medicare_paid_80_amt,
					@L2320_3_amt02_AA_cob_medicare_a_trust_pd_amt,
					@L2320_3_amt02_B1_cob_medicare_b_trust_pd_amt,
					@L2320_3_amt02_A8_cob_non_cvd_amt,
					@L2320_3_amt02_YT_cob_denied_amt,
					@L2320_3_dmg02_other_subscriber_dob,
					@L2320_3_dmg03_other_subscriber_gender,
					@L2320_3_oi03_other_ins_benefit_assign_ind,
					@L2320_3_oi06_other_ins_release_of_info_code,
					@L2330A_3_nm101_entity_id_code,
					@L2330A_3_nm102_entity_type_qual,
					@L2330A_3_nm103_other_subscriber_last_name,
					@L2330A_3_nm104_other_subscriber_first_name,
					@L2330A_3_nm105_other_subscriber_middle_name,
					@L2330A_3_nm107_other_subscriber_name_suffix,
					@L2330A_3_nm108_other_subscriber_id_code_qual,
					@L2330A_3_nm109_other_subscriber_id,
					@L2330B_3_nm101_entity_id_code,
					@L2330B_3_nm102_entity_type_qual,
					@L2330B_3_nm103_other_payer_nm,
					@L2330B_3_nm108_id_code_qual,
					@L2330B_3_nm109_other_payer_id,
					@L2330B_3_dtp03_573_date_claim_paid,
					@L2330B_3_ref02_2U_other_payer_secondary_id,
					@L2330B_3_ref02_F8_other_payer_secondary_id,
					@L2330B_3_ref02_FY_other_payer_secondary_id,
					@L2330B_3_ref02_NF_other_payer_secondary_id,
					@L2330B_3_ref02_TJ_other_payer_secondary_id,
					@L2330B_3_ref02_9F_other_payer_auth_num,
					@L2330B_3_ref02_G1_other_payer_auth_num,
					@L2400_lx01_assigned_num, 
					@L2400_sv201_rev_code, 
					@L2400_sv202_proc_code_qual,
					@L2400_sv202_proc_code, 
					@L2400_sv202_proc_mod1,
					@L2400_sv202_proc_mod2,
					@L2400_sv202_proc_mod3,
					@L2400_sv202_proc_mod4,
					@L2400_sv203_line_charge,
					@L2400_sv204_measurement_code,
					@L2400_sv205_service_unit_count,
					@L2400_sv206_service_line_rate,
					@L2400_sv207_denied_amt, 
					@L2400_dtp02_472_from_service_date,
					@L2400_dtp02_472_to_service_date,
					@L2400_dtp02_866_format_qual,
					@L2400_dtp02_866_assess_date,
					@L2410_1_lin03_N4_ndc,
					@L2420A_nm102_entity_type_qual,
					@L2420A_nm103_attending_physician_last_nm,
					@L2420A_nm104_attending_physician_first_nm,
					@L2420A_nm105_attending_physician_middle_nm,
					@L2420A_nm107_attending_physician_suffix,
					@L2420A_nm108_id_code_qual,
					@L2420A_nm109_attending_physician_id,
					@L2420A_ref02_1C_attending_prov_id,
					@L2420A_ref02_1D_attending_prov_id,
					@L2420A_ref02_1G_attending_prov_id,
					@L2420A_ref02_EI_attending_prov_id,
					@L2420A_ref02_SY_attending_prov_id,
					@L2420A_ref02_FH_attending_prov_id,
					@L2420B_nm102_entity_type_qual,
					@L2420B_nm103_operating_prov_last_nm,
					@L2420B_nm104_operating_prov_first_nm,
					@L2420B_nm105_operating_prov_middle_nm,
					@L2420B_nm107_operating_prov_suffix,
					@L2420B_nm108_id_code_qual,
					@L2420B_nm109_operating_prov_id,
					@L2420B_ref02_1C_operating_prov_id,
					@L2420B_ref02_1D_operating_prov_id,
					@L2420B_ref02_1G_operating_prov_id,
					@L2420B_ref02_EI_operating_prov_id,
					@L2420B_ref02_SY_operating_prov_id,
					@L2420B_ref02_FH_operating_prov_id,
					@L2420C_nm102_entity_type_qual,
					@L2420C_nm103_other_prov_last_nm,
					@L2420C_nm104_other_prov_first_nm,
					@L2420C_nm105_other_prov_middle_nm,
					@L2420C_nm107_other_prov_suffix,
					@L2420C_nm108_id_code_qual,
					@L2420C_nm109_other_prov_id,	
					@L2420C_ref02_1C_other_prov_id,
					@L2420C_ref02_1D_other_prov_id,
					@L2420C_ref02_1G_other_prov_id,
					@L2420C_ref02_G2_other_prov_id,
					@L2430_svd01_payer_id,
					@L2430_svd02_service_line_paid,
					@L2430_svd03_proc_code_qual,
					@L2430_svd03_proc_code, 
					@L2430_svd03_proc_mod1,
					@L2430_svd03_proc_mod2,
					@L2430_svd03_proc_mod3,
					@L2430_svd03_proc_mod4,
					@L2430_svd04_rev_code, 
					@L2430_svd05_adj_qty,
					@L2430_svd06_bundled_line_num, 
					@L2430_cas01_adjustment_group_code,
					@L2430_cas02_adjustment_reason_code, 
					@L2430_cas03_adjustment_amt, 
					@L2430_cas04_adjustment_qty,
					@L2430_cas05_adjustment_reason_code, 
					@L2430_cas06_adjustment_amt, 
					@L2430_cas07_adjustment_qty,
					@L2430_cas08_adjustment_reason_code, 
					@L2430_cas09_adjustment_amt, 
					@L2430_cas10_adjustment_qty,
					@L2430_1_cas01_adjustment_group_code,
					@L2430_1_cas02_adjustment_reason_code,
					@L2430_1_cas03_adjustment_amt,
					@L2430_1_cas04_adjustment_qty,
					@L2430_1_cas05_adjustment_reason_code,
					@L2430_1_cas06_adjustment_amt,
					@L2430_1_cas07_adjustment_qty,
					@L2430_1_cas08_adjustment_reason_code,
					@L2430_1_cas09_adjustment_amt,
					@L2430_1_cas10_adjustment_qty,
					@L2430_1_cas11_adjustment_reason_code,
					@L2430_1_cas12_adjustment_amt,
					@L2430_1_cas13_adjustment_qty,
					@L2430_1_cas14_adjustment_reason_code,
					@L2430_1_cas15_adjustment_amt,
					@L2430_1_cas16_adjustment_qty,
					@L2430_1_cas17_adjustment_reason_code,
					@L2430_1_cas18_adjustment_amt,
					@L2430_1_cas19_adjustment_qty,
					@L2430_2_cas01_adjustment_group_code,
					@L2430_2_cas02_adjustment_reason_code,
					@L2430_2_cas03_adjustment_amt,
					@L2430_2_cas04_adjustment_qty,
					@L2430_2_cas05_adjustment_reason_code,
					@L2430_2_cas06_adjustment_amt,
					@L2430_2_cas07_adjustment_qty,
					@L2430_2_cas08_adjustment_reason_code,
					@L2430_2_cas09_adjustment_amt,
					@L2430_2_cas10_adjustment_qty,
					@L2430_2_cas11_adjustment_reason_code,
					@L2430_2_cas12_adjustment_amt,
					@L2430_2_cas13_adjustment_qty,
					@L2430_2_cas14_adjustment_reason_code,
					@L2430_2_cas15_adjustment_amt,
					@L2430_2_cas16_adjustment_qty,
					@L2430_2_cas17_adjustment_reason_code,
					@L2430_2_cas18_adjustment_amt,
					@L2430_2_cas19_adjustment_qty,
					@L2430_3_cas01_adjustment_group_code,
					@L2430_3_cas02_adjustment_reason_code,
					@L2430_3_cas03_adjustment_amt,
					@L2430_3_cas04_adjustment_qty,
					@L2430_3_cas05_adjustment_reason_code,
					@L2430_3_cas06_adjustment_amt,
					@L2430_3_cas07_adjustment_qty,
					@L2430_3_cas08_adjustment_reason_code,
					@L2430_3_cas09_adjustment_amt,
					@L2430_3_cas10_adjustment_qty,
					@L2430_3_cas11_adjustment_reason_code,
					@L2430_3_cas12_adjustment_amt,
					@L2430_3_cas13_adjustment_qty,
					@L2430_3_cas14_adjustment_reason_code,
					@L2430_3_cas15_adjustment_amt,
					@L2430_3_cas16_adjustment_qty,
					@L2430_3_cas17_adjustment_reason_code,
					@L2430_3_cas18_adjustment_amt,
					@L2430_3_cas19_adjustment_qty,
					@L2430_4_cas01_adjustment_group_code,
					@L2430_4_cas02_adjustment_reason_code,
					@L2430_4_cas03_adjustment_amt,
					@L2430_4_cas04_adjustment_qty,
					@L2430_4_cas05_adjustment_reason_code,
					@L2430_4_cas06_adjustment_amt,
					@L2430_4_cas07_adjustment_qty,
					@L2430_4_cas08_adjustment_reason_code,
					@L2430_4_cas09_adjustment_amt,
					@L2430_4_cas10_adjustment_qty,
					@L2430_4_cas11_adjustment_reason_code,
					@L2430_4_cas12_adjustment_amt,
					@L2430_4_cas13_adjustment_qty,
					@L2430_4_cas14_adjustment_reason_code,
					@L2430_4_cas15_adjustment_amt,
					@L2430_4_cas16_adjustment_qty,
					@L2430_4_cas17_adjustment_reason_code,
					@L2430_4_cas18_adjustment_amt,
					@L2430_4_cas19_adjustment_qty,
					@L2430_5_cas01_adjustment_group_code,
					@L2430_5_cas02_adjustment_reason_code,
					@L2430_5_cas03_adjustment_amt,
					@L2430_5_cas04_adjustment_qty,
					@L2430_5_cas05_adjustment_reason_code,
					@L2430_5_cas06_adjustment_amt,
					@L2430_5_cas07_adjustment_qty,
					@L2430_5_cas08_adjustment_reason_code,
					@L2430_5_cas09_adjustment_amt,
					@L2430_5_cas10_adjustment_qty,
					@L2430_5_cas11_adjustment_reason_code,
					@L2430_5_cas12_adjustment_amt,
					@L2430_5_cas13_adjustment_qty,
					@L2430_5_cas14_adjustment_reason_code,
					@L2430_5_cas15_adjustment_amt,
					@L2430_5_cas16_adjustment_qty,
					@L2430_5_cas17_adjustment_reason_code,
					@L2430_5_cas18_adjustment_amt,
					@L2430_5_cas19_adjustment_qty,
					@L2430_dtp03_573_service_adjudication_date
END --END WHILE LOOP

CLOSE curtX12Doc
DEALLOCATE curtX12Doc

	-- Count up all the segments we just inserted, exclude the transaction header segments, and subtract what was there before.
	select @segment_count = count(x12_parse_temp_id) - @pre_segment_count
	from x12_parse_temp
	where	col001 NOT IN ('ISA', 'GS', 'ST', 'IEA', 'GE', 'SE') AND
		x12_parse_temp_uid = @x12_interchange_uid

--update x12_transaction set processed = 1 where x12_transaction_id = @x12_transaction_id
return (0)

