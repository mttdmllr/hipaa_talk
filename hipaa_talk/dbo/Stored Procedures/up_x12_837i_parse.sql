CREATE Procedure [dbo].[up_x12_837i_parse] (@x12_transaction_id int, @se01_num_transaction_segments int = null output)
As
--Declare Variables

SET NOCOUNT ON -- We don't need to report row-counts when running this.

declare @Col001 varchar(80)
declare @Col002 varchar(80)
declare @Col003 varchar(80)
declare @Col004 varchar(80)
declare @Col005 varchar(80)
declare @Col006 varchar(80)
declare @Col007 varchar(80)
declare @Col008 varchar(80)
declare @Col009 varchar(80)
declare @Col010 varchar(80)
declare @Col011 varchar(80)
declare @Col012 varchar(80)
declare @Col013 varchar(80)
declare @Col014 varchar(80)
declare @Col015 varchar(80)
declare @Col016 varchar(80)
declare @Col017 varchar(80)
declare @Col018 varchar(80)
declare @Col019 varchar(80)
declare @Col020 varchar(80)
declare @Col021 varchar(80)


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
		
declare @L2410_1_lin03_N4_ndc varchar(48) 

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

declare @L2430_dtp03_573_service_adjudication_date varchar(35)

-- These are temporary variables
declare @loopcount int
declare @ProcString varchar(25)
declare @DXPointerString varchar(15)
declare @ColonPOS int
declare @EndStringPos int

declare @prev_L2300_clm01_pt_acct_num varchar (38)

 -- This variable is used to determine what type the previous N1 segment was, so the address is gathered correctly.
declare @curLoop varchar(10)
declare @Other2320SBRLoopCount int

declare @errmsg varchar(250)
declare @errcode int

declare @x12_parse_temp_id_start int
declare @x12_parse_temp_id_end int

set @Other2320SBRLoopCount = 0
declare @isa16_component_element_seperator char(1)
declare @x12_interchange_uid uniqueidentifier

set @se01_num_transaction_segments = 0

select	@isa16_component_element_seperator = isa16_component_element_seperator,
	@x12_interchange_uid = x12_interchange_uid
from vw_x12_transaction
where x12_transaction_id = @x12_transaction_id

if (@isa16_component_element_seperator IS NULL OR @isa16_component_element_seperator = ' ')
begin
	set @isa16_component_element_seperator = ':'
end

select	@x12_parse_temp_id_start = x12_parse_temp_id_start,
	@x12_parse_temp_id_end = x12_parse_temp_id_end
from x12_transaction where x12_transaction_id = @x12_transaction_id

DECLARE curt837i SCROLL CURSOR FOR
	select Col001, Col002, Col003, Col004, Col005, Col006, Col007, Col008, Col009, Col010, Col011, Col012, Col013, Col014, Col015, Col016, Col017, Col018, Col019, Col020, Col021
	from x12_parse_temp
	where	x12_parse_temp_id BETWEEN @x12_parse_temp_id_start AND @x12_parse_temp_id_end
			AND x12_parse_temp_uid = @x12_interchange_uid
	order by x12_parse_temp_id

OPEN curt837i

FETCH NEXT FROM curt837i INTO @Col001, @Col002, @Col003, @Col004, @Col005, @Col006, @Col007, @Col008, @Col009, @Col010, @Col011, @Col012, @Col013, @Col014, @Col015, @Col016, @Col017, @Col018, @Col019, @Col020, @Col021
WHILE (@@fetch_status <> -1)
BEGIN
	set @se01_num_transaction_segments = @se01_num_transaction_segments + 1
	
	-- BHT loop
	if ( RTrim(@col001) = 'BHT' AND @curLoop is Null)		
	begin
		select	@bht01_hierarchical_structure_code = LTRIM(RTRIM(@Col002)),
			@bht02_trans_set_purpose_code = LTRIM(RTRIM(@Col003)),
			@bht03_orig_app_tran_id = LTRIM(RTRIM(@Col004)),
			@bht04_trans_set_creation_date = LTRIM(RTRIM(@Col005)),
			@bht05_trans_set_creation_time = LTRIM(RTRIM(@Col006)),
			@bht06_claim_encounter_id = LTRIM(RTRIM(@Col007))
	end

	if ( RTrim(@col001) = 'REF' AND @curLoop IS NULL)
	begin
		set @ref01_receiver_ref_id_qual = LTRIM(RTRIM(@Col002))
		set @ref02_transmission_type_code = LTRIM(RTRIM(@Col003))
	end

	-- Submitter Loop
	if ( RTrim(@col001) = 'NM1' AND LTRIM(RTRIM(@Col002)) = '41')
	begin
		select	@curLoop = '1000A',
			@L1000A_nm102_entity_type_qual = LTRIM(RTRIM(@Col003)),
			@L1000A_nm103_submitter_last_nm = LTRIM(RTRIM(@Col004)),
			@L1000A_nm104_submitter_first_nm = LTRIM(RTRIM(@Col005)),
			@L1000A_nm105_submitter_middle_nm = LTRIM(RTRIM(@Col006)),
			@L1000A_nm108_submitter_id_qual = LTRIM(RTRIM(@Col009)),
			@L1000A_nm109_submitter_id = LTRIM(RTRIM(@Col010))
	end

	-- Submitter Loop: Contact Segment
	if ( RTrim(@col001) = 'PER' AND LTRIM(RTRIM(@curLoop)) = '1000A')
	begin
		select	@L1000A_per01_contact_function_code = LTRIM(RTRIM(@Col002)),
			@L1000A_per02_contact_nm = LTRIM(RTRIM(@Col003)),
			@L1000A_per03_comm_num_qual = LTRIM(RTRIM(@Col004)),
			@L1000A_per04_comm_number = LTRIM(RTRIM(@Col005))
	end

	-- Receiver Loop
	if ( RTrim(@col001) = 'NM1' AND LTRIM(RTRIM(@Col002)) = '40')
	begin
		select	@curLoop = '1000B',
			@L1000B_nm102_entity_type_qual = LTRIM(RTRIM(@Col003)),
			@L1000B_nm103_receiver_last_nm = LTRIM(RTRIM(@Col004)),
			@L1000B_nm108_receiver_id_qual = LTRIM(RTRIM(@Col009)),
			@L1000B_nm109_receiver_id = LTRIM(RTRIM(@Col010))
	end
 
	-- Billing/Pay-To Provider Loop: PRV Segment
	if ( RTrim(@col001) = 'PRV' AND @curLoop = '2000A')
	begin
		select	@L2000A_prv01_provider_code = LTRIM(RTRIM(@Col002)),
			@L2000A_prv02_ref_id_qual = LTRIM(RTRIM(@Col003)),
			@L2000A_prv03_taxonomy_code = LTRIM(RTRIM(@Col004))
	end
	
	-- Billing/Pay-To Provider Loop: PRV Segment
	if ( RTrim(@col001) = 'CUR' AND @curLoop = '2000A')
	Begin
		set @L2000A_cur02_currency_code = LTRIM(RTRIM(@Col003))
	End

	-- Billing/Pay-To Provider Loop: Name
	if ( RTrim(@col001) = 'NM1' AND @curLoop = '2000A' AND LTRIM(RTRIM(@Col002)) = '85')
	begin
		select	@curLoop = '2010AA',
			@L2010AA_nm102_entity_type_qual = LTRIM(RTRIM(@Col003)),
			@L2010AA_nm103_billing_prov_last_nm = LTRIM(RTRIM(@Col004)),
			@L2010AA_nm104_billing_prov_first_nm = LTRIM(RTRIM(@Col005)),
			@L2010AA_nm105_billing_prov_middle_nm = LTRIM(RTRIM(@Col006)),
			@L2010AA_nm107_billing_prov_suffix = LTRIM(RTRIM(@Col008)),
			@L2010AA_nm108_id_code_qual = LTRIM(RTRIM(@Col009)),
			@L2010AA_nm109_billing_prov_id = LTRIM(RTRIM(@Col010))

			-- Reset all the previous 2010AA Loop values, because we're starting a new 2010AA loop.  This will
			-- prevent any values from being carried over from the previous 2010AA loop.
			set @L2010AA_n301_billing_prov_address1 = null
			set @L2010AA_n302_billing_prov_address2 = null
			set @L2010AA_n401_billing_prov_city = null
			set @L2010AA_n402_billing_prov_state = null
			set @L2010AA_n403_billing_prov_zip = null
			set @L2010AA_n404_billing_prov_country = null
			set @L2010AA_ref02_1C_billing_prov_id = null
			set @L2010AA_ref02_1D_billing_prov_id = null
			set @L2010AA_ref02_1G_billing_prov_id = null
			set @L2010AA_ref02_EI_billing_prov_id = null
			set @L2010AA_ref02_SY_billing_prov_id = null
			set @L2010AA_ref02_FH_billing_prov_id = null
			set @L2010AA_ref02_06_card_billing_id = null
			set @L2010AA_ref02_8U_card_billing_id = null
			set @L2010AA_ref02_EM_card_billing_id = null
			set @L2010AA_ref02_IJ_card_billing_id = null
			set @L2010AA_ref02_LU_card_billing_id = null
			set @L2010AA_ref02_ST_card_billing_id = null
			set @L2010AA_per01_billing_prov_comm_func_code = null
			set @L2010AA_per02_billing_prov_contact_nm = null
			set @L2010AA_per03_billing_prov_comm_num_qual = null
			set @L2010AA_per04_billing_prov_comm = null

			-- Reset pay-to provider information each time a new Billing Provider HL is used
			select	@L2010AB_nm102_entity_type_qual = null,
					@L2010AB_nm103_payto_prov_last_nm = null,
					@L2010AB_nm104_payto_prov_first_nm = null,
					@L2010AB_nm105_payto_prov_middle_nm = null,
					@L2010AB_nm107_payto_prov_suffix = null,
					@L2010AB_nm108_id_code_qual = null,
					@L2010AB_nm109_payto_prov_id = null,
					@L2010AB_n301_payto_prov_address1 = null,
					@L2010AB_n302_payto_prov_address2 = null,
					@L2010AB_n401_payto_prov_city = null,
					@L2010AB_n402_payto_prov_state = null,
					@L2010AB_n403_payto_prov_zip = null,
					@L2010AB_n404_payto_prov_country = null,
					@L2010AB_ref02_1C_payto_prov_id = null,
					@L2010AB_ref02_1D_payto_prov_id = null,
					@L2010AB_ref02_1G_payto_prov_id = null,
					@L2010AB_ref02_EI_payto_prov_id = null,
					@L2010AB_ref02_SY_payto_prov_id = null,
					@L2010AB_ref02_FH_payto_prov_id = null
	end

	-- Billing/Pay-To Provider Loop: Address1
	if ( RTrim(@col001) = 'N3' AND @curLoop = '2010AA')
	begin
		select	@L2010AA_n301_billing_prov_address1 = LTRIM(RTRIM(@Col002)),
			@L2010AA_n302_billing_prov_address2 = LTRIM(RTRIM(@Col003))
	end

	-- Billing/Pay-To Provider Loop: Address2
	if ( RTrim(@col001) = 'N4' AND @curLoop = '2010AA')
	begin
		select	@L2010AA_n401_billing_prov_city = LTRIM(RTRIM(@Col002)),
			@L2010AA_n402_billing_prov_state = LTRIM(RTRIM(@Col003)),
			@L2010AA_n403_billing_prov_zip = LTRIM(RTRIM(@Col004)),
			@L2010AA_n404_billing_prov_country = LTRIM(RTRIM(@Col005))
	end

	-- Billing/Pay-To Provider Loop: Billing Provider ID
	
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = '1C' )
	Begin
		set @L2010AA_ref02_1C_billing_prov_id = LTRIM(RTRIM(@Col003))
	End

	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = '1D' )
	Begin
		set @L2010AA_ref02_1D_billing_prov_id = LTRIM(RTRIM(@Col003))
	End

	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = '1G' )
	Begin	
		set @L2010AA_ref02_1G_billing_prov_id = LTRIM(RTRIM(@Col003))
	End

	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = 'EI' )
	Begin
		set @L2010AA_ref02_EI_billing_prov_id = LTRIM(RTRIM(@Col003))
	End

	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = 'SY' )
	Begin
		set @L2010AA_ref02_SY_billing_prov_id = LTRIM(RTRIM(@Col003))
	End

	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = 'FH' )
	Begin
		set @L2010AA_ref02_FH_billing_prov_id = LTRIM(RTRIM(@Col003))
	End

	-- Billing/Pay-To Provider Loop: Credit Card ID
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = '06' )
	Begin
		set @L2010AA_ref02_06_card_billing_id = LTRIM(RTRIM(@Col003))
	End

	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = '8U' )
	Begin
		set @L2010AA_ref02_8U_card_billing_id = LTRIM(RTRIM(@Col003))
	End

	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = 'EM' )
	Begin
		set @L2010AA_ref02_EM_card_billing_id = LTRIM(RTRIM(@Col003))
	End

	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = 'IJ' )
	Begin
		set @L2010AA_ref02_IJ_card_billing_id = LTRIM(RTRIM(@Col003))
	End

	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = 'LU' )
	Begin
		set @L2010AA_ref02_LU_card_billing_id = LTRIM(RTRIM(@Col003))
	End

	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = 'ST' )
	Begin
		set @L2010AA_ref02_ST_card_billing_id = LTRIM(RTRIM(@Col003))
	End

	-- Billing/Pay-To Provider Loop: Contact Info
	if ( RTrim(@col001) = 'PER' AND @curLoop = '2010AA')
	begin
		select	@L2010AA_per01_billing_prov_comm_func_code = LTRIM(RTRIM(@Col002)),
			@L2010AA_per02_billing_prov_contact_nm = LTRIM(RTRIM(@Col003)),
			@L2010AA_per03_billing_prov_comm_num_qual = LTRIM(RTRIM(@Col004)),
			@L2010AA_per04_billing_prov_comm = LTRIM(RTRIM(@Col005))
	end
		
	-- Pay-To Provider Loop: Name
	if ( RTrim(@col001) = 'NM1' AND LTRIM(RTRIM(@Col002)) = '87' AND LEFT(@curLoop, 2) = '20')
	begin
		select	@curLoop = '2010AB',
			@L2010AB_nm102_entity_type_qual = LTRIM(RTRIM(@Col003)),
			@L2010AB_nm103_payto_prov_last_nm = LTRIM(RTRIM(@Col004)),
			@L2010AB_nm108_id_code_qual = LTRIM(RTRIM(@Col009)),
			@L2010AB_nm109_payto_prov_id = LTRIM(RTRIM(@Col010))
	end

	if ( RTrim(@col001) = 'N3' AND @curLoop = '2010AB')
	begin
		select	@L2010AB_n301_payto_prov_address1 = LTRIM(RTRIM(@Col002)),
			@L2010AB_n302_payto_prov_address2 = LTRIM(RTRIM(@Col003))
	end
		
	if ( RTrim(@col001) = 'N4' AND @curLoop = '2010AB')
	begin
		select	@L2010AB_n401_payto_prov_city = LTRIM(RTRIM(@Col002)),
			@L2010AB_n402_payto_prov_state = LTRIM(RTRIM(@Col003)),
			@L2010AB_n403_payto_prov_zip = LTRIM(RTRIM(@Col004)),
			@L2010AB_n404_payto_prov_country = LTRIM(RTRIM(@Col005))
	end

	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AB' AND LTRIM(RTRIM(@Col002)) = '1C' )
	begin
		set @L2010AB_ref02_1C_payto_prov_id = LTRIM(RTRIM(@Col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AB' AND LTRIM(RTRIM(@Col002)) = '1D' )
	begin
		set @L2010AB_ref02_1D_payto_prov_id = LTRIM(RTRIM(@Col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AB' AND LTRIM(RTRIM(@Col002)) = '1G' )
	begin
		set @L2010AB_ref02_1G_payto_prov_id = LTRIM(RTRIM(@Col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AB' AND LTRIM(RTRIM(@Col002)) = 'EI' )
	begin
		set @L2010AB_ref02_EI_payto_prov_id = LTRIM(RTRIM(@Col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AB' AND LTRIM(RTRIM(@Col002)) = 'SY' )
	begin
		set @L2010AB_ref02_SY_payto_prov_id = LTRIM(RTRIM(@Col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AB' AND LTRIM(RTRIM(@Col002)) = 'FH' )
	begin
		set @L2010AB_ref02_FH_payto_prov_id = LTRIM(RTRIM(@Col003))
	end

	if ( RTrim(@col001) = 'HL' AND LTRIM(RTRIM(@Col004)) = '22' )
	begin
		set @curLoop = '2000B'
	end
		
	if ( RTrim(@col001) = 'SBR' AND @curLoop = '2000B')
	begin
		select	@curLoop = '2000B',
			@L2000B_sbr01_payer_resp_seq_code = LTRIM(RTRIM(@Col002)),
			@L2000B_sbr02_ind_relationship_code = LTRIM(RTRIM(@Col003)),
			@L2000B_sbr03_insured_grp_policy_num = LTRIM(RTRIM(@Col004)),
			@L2000B_sbr04_insured_grp_nm = LTRIM(RTRIM(@Col005)),
			@L2000B_sbr09_claim_id_code = LTRIM(RTRIM(@Col010)),
	
			-- We're starting a new SBR segment, so reall the variables for this loop before continuing.
			@L2010BA_nm102_entity_type_qual = null,
			@L2010BA_nm103_subscriber_last_nm = null,
			@L2010BA_nm104_subscriber_first_nm = null,
			@L2010BA_nm105_subscriber_middle_nm = null,
			@L2010BA_nm107_subscriber_suffix = null,
			@L2010BA_nm108_id_code_qual = null,
			@L2010BA_nm109_subscriber_id = null,
	
			@L2010BA_n301_subscriber_address1 = null,
			@L2010BA_n302_subscriber_address2 = null,
	
			@L2010BA_n401_subscriber_city = null,
			@L2010BA_n402_subscriber_state = null,
			@L2010BA_n403_subscriber_zip = null,
			@L2010BA_n404_subscriber_country = null,
	
			@L2010BA_dmg02_subscriber_dob = null,
			@L2010BA_dmg03_subscriber_gender = null,
	
			@L2010BA_ref02_1W_subscriber_sup_id = null,
			@L2010BA_ref02_23_subscriber_sup_id = null,
			@L2010BA_ref02_IG_subscriber_sup_id = null,
			@L2010BA_ref02_SY_subscriber_sup_id = null,
			@L2010BA_ref02_Y4_prop_casualty_claim_num = null,
	
			@L2010BB_nm102_entity_type_qual = null,
			@L2010BB_nm103_card_holder_last_nm = null,
			@L2010BB_nm104_card_holder_first_nm = null,
			@L2010BB_nm105_card_holder_middle_nm = null,
			@L2010BB_nm107_card_holder_suffix = null,
			@L2010BB_nm108_card_id_qual = null,
			@L2010BB_nm109_card_num = null,
	
			@L2010BB_ref02_AB_payer_id = null,
			@L2010BB_ref02_BB_payer_id = null,
	
			@L2010BC_nm102_entity_type_qual = null,
			@L2010BC_nm103_payer_nm = null,
			@L2010BC_nm108_payer_id_qual = null,
			@L2010BC_nm109_payer_id = null,	
	
			@L2010BC_n301_payer_address1 = null,
			@L2010BC_n302_payer_address2 = null,
	
			@L2010BC_n401_payer_city = null,
			@L2010BC_n402_payer_state = null,
			@L2010BC_n403_payer_zip = null,
			@L2010BC_n404_payer_country = null,
	
			@L2010BC_ref02_2U_payer_id = null,
			@L2010BC_ref02_FY_payer_id = null,
			@L2010BC_ref02_NF_payer_id = null,
			@L2010BC_ref02_TJ_payer_id = null,
	
			@L2010BD_nm102_entity_type_qual = null,
			@L2010BD_nm103_resp_party_last_nm = null,
			@L2010BD_nm104_resp_party_first_nm = null,
			@L2010BD_nm105_resp_party_middle_nm = null,
			@L2010BD_nm107_resp_party_suffix = null,
	
			@L2010BD_n301_resp_party_address1 = null,
			@L2010BD_n302_resp_party_address2 = null,
	
			@L2010BD_n401_resp_party_city = null,
			@L2010BD_n402_resp_party_state = null,
			@L2010BD_n403_resp_party_zip = null,
			@L2010BD_n404_resp_party_country = null,
	
			@L2000C_hl01_hierarchical_id_num = null,
			@L2000C_hl02_hierarchical_parent_id_num = null,
			@L2000C_hl03_hierarchical_level_code = null,
			@L2000C_hl04_hierarchical_child_code = null,
	
			@L2000C_pat01_ind_relationship_code = null,
	
			@L2010CA_nm102_entity_type_qual = null,
			@L2010CA_nm103_patient_last_nm = null,
			@L2010CA_nm104_patient_first_nm = null,
			@L2010CA_nm105_patient_middle_nm = null,
			@L2010CA_nm107_patient_suffix = null,
			@L2010CA_nm108_id_code_qual = null,
			@L2010CA_nm109_patient_id = null,
	
			@L2010CA_n301_patient_address1 = null,
			@L2010CA_n302_patient_address2 = null,
	
			@L2010CA_n401_patient_city = null,
			@L2010CA_n402_patient_state = null,
			@L2010CA_n403_patient_zip = null,
			@L2010CA_n404_patient_country = null,
	
			@L2010CA_dmg02_patient_dob = null,
			@L2010CA_dmg03_patient_gender = null,
	
			@L2010CA_ref02_1W_patient_sup_id = null,
			@L2010CA_ref02_23_patient_sup_id = null,
			@L2010CA_ref02_IG_patient_sup_id = null,
			@L2010CA_ref02_SY_patient_sup_id = null,
			@L2010CA_ref02_Y4_prop_casualty_claim_num = null
	end
		
/* Added by mistake, this segment doesn't exist in the 837I
	if ( RTrim(@col001) = 'PAT' AND @curLoop = '2000B')
	begin
		set @L2000B_pat06_insured_ind_death_date = LTRIM(RTRIM(@Col007))
		set @L2000B_pat08_patient_weight = LTRIM(RTRIM(@Col009))
		set @L2000B_pat09_pregnancy_indicator = LTRIM(RTRIM(@Col010))
	end
*/		
	if ( RTrim(@col001) = 'NM1' AND LTRIM(RTRIM(@Col002)) = 'IL' AND LEFT(@curLoop, 2) = '20' )
	begin
		select	@curLoop = '2010BA',
			@L2010BA_nm102_entity_type_qual = LTRIM(RTRIM(@Col003)),
			@L2010BA_nm103_subscriber_last_nm = LTRIM(RTRIM(@Col004)),
			@L2010BA_nm104_subscriber_first_nm = LTRIM(RTRIM(@Col005)),
			@L2010BA_nm105_subscriber_middle_nm = LTRIM(RTRIM(@Col006)),
			@L2010BA_nm107_subscriber_suffix = LTRIM(RTRIM(@Col008)),
			@L2010BA_nm108_id_code_qual = LTRIM(RTRIM(@Col009)),
			@L2010BA_nm109_subscriber_id = LTRIM(RTRIM(@Col010))
	end
		
	if ( RTrim(@col001) = 'N3' AND @curLoop = '2010BA')
	begin
		select	@L2010BA_n301_subscriber_address1 = LTRIM(RTRIM(@Col002)),
			@L2010BA_n302_subscriber_address2 = LTRIM(RTRIM(@Col003))
	end

	if ( RTrim(@col001) = 'N4' AND @curLoop = '2010BA')
	begin
		select	@L2010BA_n401_subscriber_city = LTRIM(RTRIM(@Col002)),
			@L2010BA_n402_subscriber_state = LTRIM(RTRIM(@Col003)),
			@L2010BA_n403_subscriber_zip = LTRIM(RTRIM(@Col004)),
			@L2010BA_n404_subscriber_country = LTRIM(RTRIM(@Col005))
	end
		
	if ( RTrim(@col001) = 'DMG' AND @curLoop = '2010BA')
	begin
		select	@L2010BA_dmg02_subscriber_dob = LTRIM(RTRIM(@Col003)),
			@L2010BA_dmg03_subscriber_gender = LTRIM(RTRIM(@Col004))
	end
		
	-- Subscriber Loop: Supplemental IDs
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010BA' AND LTRIM(RTRIM(@Col002)) = '1W' )
	begin
		set @L2010BA_ref02_1W_subscriber_sup_id = LTRIM(RTRIM(@Col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010BA' AND LTRIM(RTRIM(@Col002)) = '23' )
	begin
		set @L2010BA_ref02_23_subscriber_sup_id = LTRIM(RTRIM(@Col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010BA' AND LTRIM(RTRIM(@Col002)) = 'IG' )
	begin
		set @L2010BA_ref02_IG_subscriber_sup_id = LTRIM(RTRIM(@Col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010BA' AND LTRIM(RTRIM(@Col002)) = 'SY' )
	begin
		set @L2010BA_ref02_SY_subscriber_sup_id = LTRIM(RTRIM(@Col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010BA' AND LTRIM(RTRIM(@Col002)) = 'Y4' )
	begin
		set @L2010BA_ref02_Y4_prop_casualty_claim_num = LTRIM(RTRIM(@Col003))
	end

	if ( RTrim(@col001) = 'NM1' AND LTRIM(RTRIM(@Col002)) = 'AO' AND @curLoop LIKE '20%' )
	begin
		select	@curLoop = '2010BB',
			@L2010BB_nm102_entity_type_qual = LTRIM(RTRIM(@Col003)),
			@L2010BB_nm103_card_holder_last_nm = LTRIM(RTRIM(@Col004)),
			@L2010BB_nm104_card_holder_first_nm = LTRIM(RTRIM(@Col005)),
			@L2010BB_nm105_card_holder_middle_nm = LTRIM(RTRIM(@Col006)),
			@L2010BB_nm107_card_holder_suffix = LTRIM(RTRIM(@Col008)),
			@L2010BB_nm108_card_id_qual = LTRIM(RTRIM(@Col009)),
			@L2010BB_nm109_card_num = LTRIM(RTRIM(@Col010))
	end
	--ref statements for 2010BB loop

	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010BB' AND LTRIM(RTRIM(@Col002)) = 'AB' )
	begin
		set @L2010BB_ref02_AB_payer_id = LTRIM(RTRIM(@Col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010BB' AND LTRIM(RTRIM(@Col002)) = 'BB' )
	begin
		set @L2010BB_ref02_BB_payer_id = LTRIM(RTRIM(@Col003))
	end

	if ( RTrim(@col001) = 'NM1' AND LTRIM(RTRIM(@Col002)) = 'PR' AND LEFT(@curLoop, 2) = '20' ) --AND @curLoop LIKE '20%' )
	begin
		select	@curLoop = '2010BC',
			@L2010BC_nm102_entity_type_qual = LTRIM(RTRIM(@Col003)),
			@L2010BC_nm103_payer_nm = LTRIM(RTRIM(@Col004)),
			@L2010BC_nm108_payer_id_qual = LTRIM(RTRIM(@Col009)),
			@L2010BC_nm109_payer_id = LTRIM(RTRIM(@Col010))	
	end
	
	if ( RTrim(@col001) = 'N3' AND @curLoop = '2010BC')
	begin
		select	@L2010BC_n301_payer_address1 = LTRIM(RTRIM(@Col002)),
			@L2010BC_n302_payer_address2 = LTRIM(RTRIM(@Col003))
	end
		
	if ( RTrim(@col001) = 'N4' AND @curLoop = '2010BC')
	begin
		select	@L2010BC_n401_payer_city = LTRIM(RTRIM(@Col002)),
			@L2010BC_n402_payer_state = LTRIM(RTRIM(@Col003)),
			@L2010BC_n403_payer_zip = LTRIM(RTRIM(@Col004)),
			@L2010BC_n404_payer_country = LTRIM(RTRIM(@Col005))
	end
		
	-- Payer Loop: Payer IDs
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010BC' AND LTRIM(RTRIM(@Col002)) = '2U' )
	begin
		set @L2010BC_ref02_2U_payer_id = LTRIM(RTRIM(@Col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010BC' AND LTRIM(RTRIM(@Col002)) = 'FY' )
	begin
		set @L2010BC_ref02_FY_payer_id = LTRIM(RTRIM(@Col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010BC' AND LTRIM(RTRIM(@Col002)) = 'NF' )
	begin
		set @L2010BC_ref02_NF_payer_id = LTRIM(RTRIM(@Col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010BC' AND LTRIM(RTRIM(@Col002)) = 'TJ' )
	begin
		set @L2010BC_ref02_TJ_payer_id = LTRIM(RTRIM(@Col003))
	end
		
	if ( RTrim(@col001) = 'NM1' AND LTRIM(RTRIM(@Col002)) = 'QD'AND @curLoop LIKE '20%' )
	begin
		select	@curLoop = '2010BD',
			@L2010BD_nm102_entity_type_qual = LTRIM(RTRIM(@Col003)),
			@L2010BD_nm103_resp_party_last_nm = LTRIM(RTRIM(@Col004)),
			@L2010BD_nm104_resp_party_first_nm = LTRIM(RTRIM(@Col005)),
			@L2010BD_nm105_resp_party_middle_nm = LTRIM(RTRIM(@Col006)),
			@L2010BD_nm107_resp_party_suffix = LTRIM(RTRIM(@Col008))
	end		

	if ( RTrim(@col001) = 'N3' AND @curLoop = '2010BD')
	begin
		select	@L2010BD_n301_resp_party_address1 = LTRIM(RTRIM(@Col002)),
			@L2010BD_n302_resp_party_address2 = LTRIM(RTRIM(@Col003))
	end
		
	if ( RTrim(@col001) = 'N4' AND @curLoop = '2010BD')
	begin
		select	@L2010BD_n401_resp_party_city = LTRIM(RTRIM(@Col002)),
			@L2010BD_n402_resp_party_state = LTRIM(RTRIM(@Col003)),
			@L2010BD_n403_resp_party_zip = LTRIM(RTRIM(@Col004)),
			@L2010BD_n404_resp_party_country = LTRIM(RTRIM(@Col005))
	end
		
	if ( RTrim(@col001) = 'HL' AND LTRIM(RTRIM(@Col004)) = '23')
	begin
		set @curLoop = '2000C'
	end
		
	if ( RTrim(@col001) = 'PAT' AND @curLoop = '2000C')
	begin
		set @curLoop = '2000C'
		set @L2000C_pat01_ind_relationship_code = LTRIM(RTRIM(@Col002))
	end
		
	if ( RTrim(@col001) = 'NM1' AND LTRIM(RTRIM(@Col002)) = 'QC')
	begin
		select	@curLoop = '2010CA',
			@L2010CA_nm102_entity_type_qual = LTRIM(RTRIM(@Col003)),
			@L2010CA_nm103_patient_last_nm = LTRIM(RTRIM(@Col004)),
			@L2010CA_nm104_patient_first_nm = LTRIM(RTRIM(@Col005)),
			@L2010CA_nm105_patient_middle_nm = LTRIM(RTRIM(@Col006)),
			@L2010CA_nm107_patient_suffix = LTRIM(RTRIM(@Col008)),
			@L2010CA_nm108_id_code_qual = LTRIM(RTRIM(@Col009)),
			@L2010CA_nm109_patient_id = LTRIM(RTRIM(@Col010))
	end
		
	if ( RTrim(@col001) = 'N3' AND @curLoop = '2010CA')
	begin
		set @L2010CA_n301_patient_address1 = LTRIM(RTRIM(@Col002))
		set @L2010CA_n302_patient_address2 = LTRIM(RTRIM(@Col003))
	end
		
	if ( RTrim(@col001) = 'N4' AND @curLoop = '2010CA')
	begin
		select	@L2010CA_n401_patient_city = LTRIM(RTRIM(@Col002)),
			@L2010CA_n402_patient_state = LTRIM(RTRIM(@Col003)),
			@L2010CA_n403_patient_zip = LTRIM(RTRIM(@Col004)),
			@L2010CA_n404_patient_country = LTRIM(RTRIM(@Col005))
	end
			
	if ( RTrim(@col001) = 'DMG' AND @curLoop = '2010CA')
	begin
		set @L2010CA_dmg02_patient_dob = LTRIM(RTRIM(@Col003))
		set @L2010CA_dmg03_patient_gender = LTRIM(RTRIM(@Col004))
	end
			
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010CA' AND LTRIM(RTRIM(@Col002)) = '1W' )
	Begin
		set @L2010CA_ref02_1W_patient_sup_id = LTRIM(RTRIM(@Col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010CA' AND LTRIM(RTRIM(@Col002)) = '23' )
	Begin
		set @L2010CA_ref02_23_patient_sup_id = LTRIM(RTRIM(@Col003))
	End
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010CA' AND LTRIM(RTRIM(@Col002)) = 'IG' )
	Begin
		set @L2010CA_ref02_IG_patient_sup_id = LTRIM(RTRIM(@Col003))
	End
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010CA' AND LTRIM(RTRIM(@Col002)) = 'SY' )
	Begin
		set @L2010CA_ref02_SY_patient_sup_id = LTRIM(RTRIM(@Col003))
	End
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010CA' AND LTRIM(RTRIM(@Col002)) = 'Y4' )
	Begin
		set @L2010CA_ref02_Y4_prop_casualty_claim_num = LTRIM(RTRIM(@Col003))
	End

	-- Service Line LX Segment
	-- Get LX service line information (this segment is essentially the "header" of the detail section)
	-- BEGIN OF LX SEGMENT
	if ( RTrim(@col001) = 'LX' )
	begin
		set @curLoop = '2400'
		-- insert a record when we start a new service line (meaning we're done with the previous service line)
		-- Only insert a record when we've already picked the procedure code out of the SV1 segment (skips this the first time through only)
		if ( @L2400_sv201_rev_code IS NOT NULL AND @L2400_lx01_assigned_num IS NOT NULL )
			begin
			EXEC dbo.up_x12_837i_insert
				@x12_transaction_id  = @x12_transaction_id ,
				@bht01_hierarchical_structure_code  = @bht01_hierarchical_structure_code ,
				@bht02_trans_set_purpose_code  = @bht02_trans_set_purpose_code ,
				@bht03_orig_app_tran_id  = @bht03_orig_app_tran_id ,
				@bht04_trans_set_creation_date  = @bht04_trans_set_creation_date ,
				@bht05_trans_set_creation_time  = @bht05_trans_set_creation_time ,
				@bht06_claim_encounter_id  = @bht06_claim_encounter_id ,
				@ref01_receiver_ref_id_qual  = @ref01_receiver_ref_id_qual ,
				@ref02_transmission_type_code  = @ref02_transmission_type_code ,
				@L1000A_nm102_entity_type_qual  = @L1000A_nm102_entity_type_qual ,
				@L1000A_nm103_submitter_last_nm  = @L1000A_nm103_submitter_last_nm ,
				@L1000A_nm104_submitter_first_nm  = @L1000A_nm104_submitter_first_nm ,
				@L1000A_nm105_submitter_middle_nm  = @L1000A_nm105_submitter_middle_nm ,
				@L1000A_nm108_submitter_id_qual  = @L1000A_nm108_submitter_id_qual ,
				@L1000A_nm109_submitter_id  = @L1000A_nm109_submitter_id ,
				@L1000A_per01_contact_function_code  = @L1000A_per01_contact_function_code ,
				@L1000A_per02_contact_nm  = @L1000A_per02_contact_nm ,
				@L1000A_per03_comm_num_qual  = @L1000A_per03_comm_num_qual ,
				@L1000A_per04_comm_number  = @L1000A_per04_comm_number ,
				@L1000B_nm102_entity_type_qual  = @L1000B_nm102_entity_type_qual ,
				@L1000B_nm103_receiver_last_nm  = @L1000B_nm103_receiver_last_nm ,
				@L1000B_nm108_receiver_id_qual  = @L1000B_nm108_receiver_id_qual ,
				@L1000B_nm109_receiver_id  = @L1000B_nm109_receiver_id ,
				@L2000A_hl01_hierarchical_id_num  = @L2000A_hl01_hierarchical_id_num ,
				@L2000A_hl03_hierarchical_level_code  = @L2000A_hl03_hierarchical_level_code ,
				@L2000A_hl04_hierarchical_child_code  = @L2000A_hl04_hierarchical_child_code ,
				@L2000A_prv01_provider_code  = @L2000A_prv01_provider_code ,
				@L2000A_prv02_ref_id_qual  = @L2000A_prv02_ref_id_qual ,
				@L2000A_prv03_taxonomy_code  = @L2000A_prv03_taxonomy_code ,
				@L2000A_cur02_currency_code  = @L2000A_cur02_currency_code ,
				@L2010AA_nm102_entity_type_qual  = @L2010AA_nm102_entity_type_qual ,
				@L2010AA_nm103_billing_prov_last_nm  = @L2010AA_nm103_billing_prov_last_nm ,
				@L2010AA_nm104_billing_prov_first_nm  = @L2010AA_nm104_billing_prov_first_nm ,
				@L2010AA_nm105_billing_prov_middle_nm  = @L2010AA_nm105_billing_prov_middle_nm ,
				@L2010AA_nm107_billing_prov_suffix  = @L2010AA_nm107_billing_prov_suffix ,
				@L2010AA_nm108_id_code_qual  = @L2010AA_nm108_id_code_qual ,
				@L2010AA_nm109_billing_prov_id  = @L2010AA_nm109_billing_prov_id ,
				@L2010AA_n301_billing_prov_address1  = @L2010AA_n301_billing_prov_address1 ,
				@L2010AA_n302_billing_prov_address2  = @L2010AA_n302_billing_prov_address2 ,
				@L2010AA_n401_billing_prov_city  = @L2010AA_n401_billing_prov_city ,
				@L2010AA_n402_billing_prov_state  = @L2010AA_n402_billing_prov_state ,
				@L2010AA_n403_billing_prov_zip  = @L2010AA_n403_billing_prov_zip ,
				@L2010AA_n404_billing_prov_country  = @L2010AA_n404_billing_prov_country ,
				@L2010AA_ref02_1B_billing_prov_id  = @L2010AA_ref02_1B_billing_prov_id ,
				@L2010AA_ref02_1C_billing_prov_id  = @L2010AA_ref02_1C_billing_prov_id ,
				@L2010AA_ref02_1D_billing_prov_id  = @L2010AA_ref02_1D_billing_prov_id ,
				@L2010AA_ref02_1G_billing_prov_id  = @L2010AA_ref02_1G_billing_prov_id ,
				@L2010AA_ref02_EI_billing_prov_id  = @L2010AA_ref02_EI_billing_prov_id ,
				@L2010AA_ref02_SY_billing_prov_id  = @L2010AA_ref02_SY_billing_prov_id ,
				@L2010AA_ref02_FH_billing_prov_id  = @L2010AA_ref02_FH_billing_prov_id ,
				@L2010AA_ref02_06_card_billing_id  = @L2010AA_ref02_06_card_billing_id ,
				@L2010AA_ref02_8U_card_billing_id  = @L2010AA_ref02_8U_card_billing_id ,
				@L2010AA_ref02_EM_card_billing_id  = @L2010AA_ref02_EM_card_billing_id ,
				@L2010AA_ref02_IJ_card_billing_id  = @L2010AA_ref02_IJ_card_billing_id ,
				@L2010AA_ref02_LU_card_billing_id  = @L2010AA_ref02_LU_card_billing_id ,
				@L2010AA_ref02_ST_card_billing_id  = @L2010AA_ref02_ST_card_billing_id ,
				@L2010AA_per01_billing_prov_comm_func_code  = @L2010AA_per01_billing_prov_comm_func_code ,
				@L2010AA_per02_billing_prov_contact_nm  = @L2010AA_per02_billing_prov_contact_nm ,
				@L2010AA_per03_billing_prov_comm_num_qual  = @L2010AA_per03_billing_prov_comm_num_qual ,
				@L2010AA_per04_billing_prov_comm  = @L2010AA_per04_billing_prov_comm ,
				@L2010AB_nm102_entity_type_qual  = @L2010AB_nm102_entity_type_qual ,
				@L2010AB_nm103_payto_prov_last_nm  = @L2010AB_nm103_payto_prov_last_nm ,
				@L2010AB_nm108_id_code_qual  = @L2010AB_nm108_id_code_qual ,
				@L2010AB_nm109_payto_prov_id  = @L2010AB_nm109_payto_prov_id ,
				@L2010AB_n301_payto_prov_address1  = @L2010AB_n301_payto_prov_address1 ,
				@L2010AB_n302_payto_prov_address2  = @L2010AB_n302_payto_prov_address2 ,
				@L2010AB_n401_payto_prov_city  = @L2010AB_n401_payto_prov_city ,
				@L2010AB_n402_payto_prov_state  = @L2010AB_n402_payto_prov_state ,
				@L2010AB_n403_payto_prov_zip  = @L2010AB_n403_payto_prov_zip ,
				@L2010AB_n404_payto_prov_country  = @L2010AB_n404_payto_prov_country ,
				@L2010AB_ref02_1C_payto_prov_id  = @L2010AB_ref02_1C_payto_prov_id ,
				@L2010AB_ref02_1D_payto_prov_id  = @L2010AB_ref02_1D_payto_prov_id ,
				@L2010AB_ref02_1G_payto_prov_id  = @L2010AB_ref02_1G_payto_prov_id ,
				@L2010AB_ref02_EI_payto_prov_id  = @L2010AB_ref02_EI_payto_prov_id ,
				@L2010AB_ref02_SY_payto_prov_id  = @L2010AB_ref02_SY_payto_prov_id ,
				@L2010AB_ref02_FH_payto_prov_id  = @L2010AB_ref02_FH_payto_prov_id ,
				@L2000B_hl01_hierarchical_id_num  = @L2000B_hl01_hierarchical_id_num ,
				@L2000B_hl02_hierarchical_parent_id_num  = @L2000B_hl02_hierarchical_parent_id_num ,
				@L2000B_hl03_hierarchical_level_code  = @L2000B_hl03_hierarchical_level_code ,
				@L2000B_hl04_hierarchical_child_code  = @L2000B_hl04_hierarchical_child_code ,
				@L2000B_sbr01_payer_resp_seq_code  = @L2000B_sbr01_payer_resp_seq_code ,
				@L2000B_sbr02_ind_relationship_code  = @L2000B_sbr02_ind_relationship_code ,
				@L2000B_sbr03_insured_grp_policy_num  = @L2000B_sbr03_insured_grp_policy_num ,
				@L2000B_sbr04_insured_grp_nm  = @L2000B_sbr04_insured_grp_nm ,
				@L2000B_sbr09_claim_id_code  = @L2000B_sbr09_claim_id_code ,
				@L2000B_pat06_insured_ind_death_date  = @L2000B_pat06_insured_ind_death_date ,
				@L2000B_pat08_patient_weight  = @L2000B_pat08_patient_weight ,
				@L2000B_pat09_pregnancy_indicator  = @L2000B_pat09_pregnancy_indicator ,
				@L2010BA_nm102_entity_type_qual  = @L2010BA_nm102_entity_type_qual ,
				@L2010BA_nm103_subscriber_last_nm  = @L2010BA_nm103_subscriber_last_nm ,
				@L2010BA_nm104_subscriber_first_nm  = @L2010BA_nm104_subscriber_first_nm ,
				@L2010BA_nm105_subscriber_middle_nm  = @L2010BA_nm105_subscriber_middle_nm ,
				@L2010BA_nm107_subscriber_suffix  = @L2010BA_nm107_subscriber_suffix ,
				@L2010BA_nm108_id_code_qual  = @L2010BA_nm108_id_code_qual ,
				@L2010BA_nm109_subscriber_id  = @L2010BA_nm109_subscriber_id ,
				@L2010BA_n301_subscriber_address1  = @L2010BA_n301_subscriber_address1 ,
				@L2010BA_n302_subscriber_address2  = @L2010BA_n302_subscriber_address2 ,
				@L2010BA_n401_subscriber_city  = @L2010BA_n401_subscriber_city ,
				@L2010BA_n402_subscriber_state  = @L2010BA_n402_subscriber_state ,
				@L2010BA_n403_subscriber_zip  = @L2010BA_n403_subscriber_zip ,
				@L2010BA_n404_subscriber_country  = @L2010BA_n404_subscriber_country ,
				@L2010BA_dmg02_subscriber_dob  = @L2010BA_dmg02_subscriber_dob ,
				@L2010BA_dmg03_subscriber_gender  = @L2010BA_dmg03_subscriber_gender ,
				@L2010BA_ref02_1W_subscriber_sup_id  = @L2010BA_ref02_1W_subscriber_sup_id ,
				@L2010BA_ref02_23_subscriber_sup_id  = @L2010BA_ref02_23_subscriber_sup_id ,
				@L2010BA_ref02_IG_subscriber_sup_id  = @L2010BA_ref02_IG_subscriber_sup_id ,
				@L2010BA_ref02_SY_subscriber_sup_id  = @L2010BA_ref02_SY_subscriber_sup_id ,
				@L2010BA_ref02_Y4_prop_casualty_claim_num  = @L2010BA_ref02_Y4_prop_casualty_claim_num ,
				@L2010BB_nm102_entity_type_qual  = @L2010BB_nm102_entity_type_qual ,
				@L2010BB_nm103_card_holder_last_nm  = @L2010BB_nm103_card_holder_last_nm ,
				@L2010BB_nm104_card_holder_first_nm  = @L2010BB_nm104_card_holder_first_nm ,
				@L2010BB_nm105_card_holder_middle_nm  = @L2010BB_nm105_card_holder_middle_nm ,
				@L2010BB_nm107_card_holder_suffix  = @L2010BB_nm107_card_holder_suffix ,
				@L2010BB_nm108_card_id_qual  = @L2010BB_nm108_card_id_qual ,
				@L2010BB_nm109_card_num  = @L2010BB_nm109_card_num ,
				@L2010BB_ref02_AB_payer_id  = @L2010BB_ref02_AB_payer_id ,
				@L2010BB_ref02_BB_payer_id  = @L2010BB_ref02_BB_payer_id ,
				@L2010BC_nm102_entity_type_qual  = @L2010BC_nm102_entity_type_qual ,
				@L2010BC_nm103_payer_nm  = @L2010BC_nm103_payer_nm ,
				@L2010BC_nm108_payer_id_qual  = @L2010BC_nm108_payer_id_qual ,
				@L2010BC_nm109_payer_id  = @L2010BC_nm109_payer_id ,
				@L2010BC_n301_payer_address1  = @L2010BC_n301_payer_address1 ,
				@L2010BC_n302_payer_address2  = @L2010BC_n302_payer_address2 ,
				@L2010BC_n401_payer_city  = @L2010BC_n401_payer_city ,
				@L2010BC_n402_payer_state  = @L2010BC_n402_payer_state ,
				@L2010BC_n403_payer_zip  = @L2010BC_n403_payer_zip ,
				@L2010BC_n404_payer_country  = @L2010BC_n404_payer_country ,
				@L2010BC_ref02_2U_payer_id  = @L2010BC_ref02_2U_payer_id ,
				@L2010BC_ref02_FY_payer_id  = @L2010BC_ref02_FY_payer_id ,
				@L2010BC_ref02_NF_payer_id  = @L2010BC_ref02_NF_payer_id ,
				@L2010BC_ref02_TJ_payer_id  = @L2010BC_ref02_TJ_payer_id ,
				@L2010BD_nm102_entity_type_qual  = @L2010BD_nm102_entity_type_qual ,
				@L2010BD_nm103_resp_party_last_nm  = @L2010BD_nm103_resp_party_last_nm ,
				@L2010BD_nm104_resp_party_first_nm  = @L2010BD_nm104_resp_party_first_nm ,
				@L2010BD_nm105_resp_party_middle_nm  = @L2010BD_nm105_resp_party_middle_nm ,
				@L2010BD_nm107_resp_party_suffix  = @L2010BD_nm107_resp_party_suffix ,
				@L2010BD_n301_resp_party_address1  = @L2010BD_n301_resp_party_address1 ,
				@L2010BD_n302_resp_party_address2  = @L2010BD_n302_resp_party_address2 ,
				@L2010BD_n401_resp_party_city  = @L2010BD_n401_resp_party_city ,
				@L2010BD_n402_resp_party_state  = @L2010BD_n402_resp_party_state ,
				@L2010BD_n403_resp_party_zip  = @L2010BD_n403_resp_party_zip ,
				@L2010BD_n404_resp_party_country  = @L2010BD_n404_resp_party_country ,
				@L2000C_hl01_hierarchical_id_num  = @L2000C_hl01_hierarchical_id_num ,
				@L2000C_hl02_hierarchical_parent_id_num  = @L2000C_hl02_hierarchical_parent_id_num ,
				@L2000C_hl03_hierarchical_level_code  = @L2000C_hl03_hierarchical_level_code ,
				@L2000C_hl04_hierarchical_child_code  = @L2000C_hl04_hierarchical_child_code ,
				@L2000C_pat01_ind_relationship_code  = @L2000C_pat01_ind_relationship_code ,
				@L2010CA_nm102_entity_type_qual  = @L2010CA_nm102_entity_type_qual ,
				@L2010CA_nm103_patient_last_nm  = @L2010CA_nm103_patient_last_nm ,
				@L2010CA_nm104_patient_first_nm  = @L2010CA_nm104_patient_first_nm ,
				@L2010CA_nm105_patient_middle_nm  = @L2010CA_nm105_patient_middle_nm ,
				@L2010CA_nm107_patient_suffix  = @L2010CA_nm107_patient_suffix ,
				@L2010CA_nm108_id_code_qual  = @L2010CA_nm108_id_code_qual ,
				@L2010CA_nm109_patient_id  = @L2010CA_nm109_patient_id ,
				@L2010CA_n301_patient_address1  = @L2010CA_n301_patient_address1 ,
				@L2010CA_n302_patient_address2  = @L2010CA_n302_patient_address2 ,
				@L2010CA_n401_patient_city  = @L2010CA_n401_patient_city ,
				@L2010CA_n402_patient_state  = @L2010CA_n402_patient_state ,
				@L2010CA_n403_patient_zip  = @L2010CA_n403_patient_zip ,
				@L2010CA_n404_patient_country  = @L2010CA_n404_patient_country ,
				@L2010CA_dmg02_patient_dob  = @L2010CA_dmg02_patient_dob ,
				@L2010CA_dmg03_patient_gender  = @L2010CA_dmg03_patient_gender ,
				@L2010CA_ref02_1W_patient_sup_id  = @L2010CA_ref02_1W_patient_sup_id ,
				@L2010CA_ref02_23_patient_sup_id  = @L2010CA_ref02_23_patient_sup_id ,
				@L2010CA_ref02_IG_patient_sup_id  = @L2010CA_ref02_IG_patient_sup_id ,
				@L2010CA_ref02_SY_patient_sup_id  = @L2010CA_ref02_SY_patient_sup_id ,
				@L2010CA_ref02_Y4_prop_casualty_claim_num  = @L2010CA_ref02_Y4_prop_casualty_claim_num ,
				@L2300_clm01_pt_acct_num  = @L2300_clm01_pt_acct_num ,
				@L2300_clm02_total_claim_chg_amt  = @L2300_clm02_total_claim_chg_amt ,
				@L2300_clm05_facility_type_code  = @L2300_clm05_facility_type_code ,
				@L2300_clm05_facility_code_qual  = @L2300_clm05_facility_code_qual ,
				@L2300_clm05_claim_freq_code  = @L2300_clm05_claim_freq_code ,
				@L2300_clm06_provider_signature_ind  = @L2300_clm06_provider_signature_ind ,
				@L2300_clm07_medicare_assign_code  = @L2300_clm07_medicare_assign_code ,
				@L2300_clm08_benefit_assign_ind  = @L2300_clm08_benefit_assign_ind ,
				@L2300_clm09_release_of_info_code  = @L2300_clm09_release_of_info_code ,
				@L2300_clm18_explan_benefits_ind  = @L2300_clm18_explan_benefits_ind ,
				@L2300_clm20_delay_reason_code  = @L2300_clm20_delay_reason_code ,
				@L2300_dtp03_096_discharge_hour  = @L2300_dtp03_096_discharge_hour ,
				@L2300_dtp03_434_begin_statement_date  = @L2300_dtp03_434_begin_statement_date ,
				@L2300_dtp03_434_end_statement_date  = @L2300_dtp03_434_end_statement_date ,
				@L2300_dtp03_435_admission_date  = @L2300_dtp03_435_admission_date ,
				@L2300_cl101_admit_type_code  = @L2300_cl101_admit_type_code ,
				@L2300_cl102_admit_source_code  = @L2300_cl102_admit_source_code ,
				@L2300_cl103_patient_status_code  = @L2300_cl103_patient_status_code ,
				@L2300_pwk01_attachment_type_code  = @L2300_pwk01_attachment_type_code ,
				@L2300_pwk02_attachment_trans_code  = @L2300_pwk02_attachment_trans_code ,
				@L2300_pwk06_attachment_control_num  = @L2300_pwk06_attachment_control_num ,
				@L2300_amt02_patient_paid_amt  = @L2300_amt02_patient_paid_amt ,
				@L2300_amt02_patient_resp_amt  = @L2300_amt02_patient_resp_amt ,
				@L2300_amt02_total_purchased_amt  = @L2300_amt02_total_purchased_amt ,
				@L2300_ref02_9C_adj_repriced_claim_num  = @L2300_ref02_9C_adj_repriced_claim_num ,
				@L2300_ref02_9A_repriced_claim_num  = @L2300_ref02_9A_repriced_claim_num ,
				@L2300_ref02_D9_claim_id_clearing_house  = @L2300_ref02_D9_claim_id_clearing_house ,
				@L2300_ref02_DD_domcument_id  = @L2300_ref02_DD_domcument_id ,
				@L2300_ref02_F8_original_ref_num  = @L2300_ref02_F8_original_ref_num ,
				@L2300_ref02_9F_referral_num  = @L2300_ref02_9F_referral_num ,
				@L2300_ref02_G1_prior_auth_num  = @L2300_ref02_G1_prior_auth_num ,
				@L2300_ref02_EA_medical_record_num  = @L2300_ref02_EA_medical_record_num ,
				@L2300_k301_fixed_format_info  = @L2300_k301_fixed_format_info ,
				@L2300_nte01_note_ref_code  = @L2300_nte01_note_ref_code ,
				@L2300_nte02_claim_note_text  = @L2300_nte02_claim_note_text ,
				@L2300_hi01_BK_diag_admit_ecode  = @L2300_hi01_BK_diag_admit_ecode ,
				@L2300_hi02_BJ_diag_admit_ecode  = @L2300_hi02_BJ_diag_admit_ecode ,
				@L2300_hi02_ZZ_diag_admit_ecode  = @L2300_hi02_ZZ_diag_admit_ecode ,
				@L2300_hi03_BN_diag_admit_ecode  = @L2300_hi03_BN_diag_admit_ecode ,
				@L2300_hi01_DR_diag_drg  = @L2300_hi01_DR_diag_drg ,
				@L2300_hi01_BF_diag_code  = @L2300_hi01_BF_diag_code ,
				@L2300_hi02_BF_diag_code  = @L2300_hi02_BF_diag_code ,
				@L2300_hi03_BF_diag_code  = @L2300_hi03_BF_diag_code ,
				@L2300_hi04_BF_diag_code  = @L2300_hi04_BF_diag_code ,
				@L2300_hi05_BF_diag_code  = @L2300_hi05_BF_diag_code ,
				@L2300_hi06_BF_diag_code  = @L2300_hi06_BF_diag_code ,
				@L2300_hi07_BF_diag_code  = @L2300_hi07_BF_diag_code ,
				@L2300_hi08_BF_diag_code  = @L2300_hi08_BF_diag_code ,
				@L2300_hi09_BF_diag_code  = @L2300_hi09_BF_diag_code ,
				@L2300_hi10_BF_diag_code  = @L2300_hi10_BF_diag_code ,
				@L2300_hi11_BF_diag_code  = @L2300_hi11_BF_diag_code ,
				@L2300_hi12_BF_diag_code  = @L2300_hi12_BF_diag_code ,
				@L2300_hi01_BR_princ_proc_info  = @L2300_hi01_BR_princ_proc_info ,
				@L2300_hi01_BR_princ_proc_info_date  = @L2300_hi01_BR_princ_proc_info_date ,
				@L2300_hi01_BQ_other_proc_info  = @L2300_hi01_BQ_other_proc_info ,
				@L2300_hi01_BQ_other_proc_info_date  = @L2300_hi01_BQ_other_proc_info_date ,
				@L2300_hi02_BQ_other_proc_info  = @L2300_hi02_BQ_other_proc_info ,
				@L2300_hi02_BQ_other_proc_info_date  = @L2300_hi02_BQ_other_proc_info_date ,
				@L2300_hi03_BQ_other_proc_info  = @L2300_hi03_BQ_other_proc_info ,
				@L2300_hi03_BQ_other_proc_info_date  = @L2300_hi03_BQ_other_proc_info_date ,
				@L2300_hi04_BQ_other_proc_info  = @L2300_hi04_BQ_other_proc_info ,
				@L2300_hi04_BQ_other_proc_info_date  = @L2300_hi04_BQ_other_proc_info_date ,
				@L2300_hi05_BQ_other_proc_info  = @L2300_hi05_BQ_other_proc_info ,
				@L2300_hi05_BQ_other_proc_info_date  = @L2300_hi05_BQ_other_proc_info_date ,
				@L2300_hi06_BQ_other_proc_info  = @L2300_hi06_BQ_other_proc_info ,
				@L2300_hi06_BQ_other_proc_info_date  = @L2300_hi06_BQ_other_proc_info_date ,
				@L2300_hi07_BQ_other_proc_info  = @L2300_hi07_BQ_other_proc_info ,
				@L2300_hi07_BQ_other_proc_info_date  = @L2300_hi07_BQ_other_proc_info_date ,
				@L2300_hi08_BQ_other_proc_info  = @L2300_hi08_BQ_other_proc_info ,
				@L2300_hi08_BQ_other_proc_info_date  = @L2300_hi08_BQ_other_proc_info_date ,
				@L2300_hi09_BQ_other_proc_info  = @L2300_hi09_BQ_other_proc_info ,
				@L2300_hi09_BQ_other_proc_info_date  = @L2300_hi09_BQ_other_proc_info_date ,
				@L2300_hi10_BQ_other_proc_info  = @L2300_hi10_BQ_other_proc_info ,
				@L2300_hi10_BQ_other_proc_info_date  = @L2300_hi10_BQ_other_proc_info_date ,
				@L2300_hi11_BQ_other_proc_info  = @L2300_hi11_BQ_other_proc_info ,
				@L2300_hi11_BQ_other_proc_info_date  = @L2300_hi11_BQ_other_proc_info_date ,
				@L2300_hi12_BQ_other_proc_info  = @L2300_hi12_BQ_other_proc_info ,
				@L2300_hi12_BQ_other_proc_info_date  = @L2300_hi12_BQ_other_proc_info_date ,
				@L2300_hi01_BI_occur_span  = @L2300_hi01_BI_occur_span ,
				@L2300_hi01_BI_occur_span_date  = @L2300_hi01_BI_occur_span_date ,
				@L2300_hi02_BI_occur_span  = @L2300_hi02_BI_occur_span ,
				@L2300_hi02_BI_occur_span_date  = @L2300_hi02_BI_occur_span_date ,
				@L2300_hi03_BI_occur_span  = @L2300_hi03_BI_occur_span ,
				@L2300_hi03_BI_occur_span_date  = @L2300_hi03_BI_occur_span_date ,
				@L2300_hi04_BI_occur_span  = @L2300_hi04_BI_occur_span ,
				@L2300_hi04_BI_occur_span_date  = @L2300_hi04_BI_occur_span_date ,
				@L2300_hi05_BI_occur_span  = @L2300_hi05_BI_occur_span ,
				@L2300_hi05_BI_occur_span_date  = @L2300_hi05_BI_occur_span_date ,
				@L2300_hi06_BI_occur_span  = @L2300_hi06_BI_occur_span ,
				@L2300_hi06_BI_occur_span_date  = @L2300_hi06_BI_occur_span_date ,
				@L2300_hi07_BI_occur_span  = @L2300_hi07_BI_occur_span ,
				@L2300_hi07_BI_occur_span_date  = @L2300_hi07_BI_occur_span_date ,
				@L2300_hi08_BI_occur_span  = @L2300_hi08_BI_occur_span ,
				@L2300_hi08_BI_occur_span_date  = @L2300_hi08_BI_occur_span_date ,
				@L2300_hi09_BI_occur_span  = @L2300_hi09_BI_occur_span ,
				@L2300_hi09_BI_occur_span_date  = @L2300_hi09_BI_occur_span_date ,
				@L2300_hi10_BI_occur_span  = @L2300_hi10_BI_occur_span ,
				@L2300_hi10_BI_occur_span_date  = @L2300_hi10_BI_occur_span_date ,
				@L2300_hi11_BI_occur_span  = @L2300_hi11_BI_occur_span ,
				@L2300_hi11_BI_occur_span_date  = @L2300_hi11_BI_occur_span_date ,
				@L2300_hi12_BI_occur_span  = @L2300_hi12_BI_occur_span ,
				@L2300_hi12_BI_occur_span_date  = @L2300_hi12_BI_occur_span_date ,
				@L2300_hi01_BH_occur_info  = @L2300_hi01_BH_occur_info ,
				@L2300_hi01_BH_occur_info_date  = @L2300_hi01_BH_occur_info_date ,
				@L2300_hi02_BH_occur_info  = @L2300_hi02_BH_occur_info ,
				@L2300_hi02_BH_occur_info_date  = @L2300_hi02_BH_occur_info_date ,
				@L2300_hi03_BH_occur_info  = @L2300_hi03_BH_occur_info ,
				@L2300_hi03_BH_occur_info_date  = @L2300_hi03_BH_occur_info_date ,
				@L2300_hi04_BH_occur_info  = @L2300_hi04_BH_occur_info ,
				@L2300_hi04_BH_occur_info_date  = @L2300_hi04_BH_occur_info_date ,
				@L2300_hi05_BH_occur_info  = @L2300_hi05_BH_occur_info ,
				@L2300_hi05_BH_occur_info_date  = @L2300_hi05_BH_occur_info_date ,
				@L2300_hi06_BH_occur_info  = @L2300_hi06_BH_occur_info ,
				@L2300_hi06_BH_occur_info_date  = @L2300_hi06_BH_occur_info_date ,
				@L2300_hi07_BH_occur_info  = @L2300_hi07_BH_occur_info ,
				@L2300_hi07_BH_occur_info_date  = @L2300_hi07_BH_occur_info_date ,
				@L2300_hi08_BH_occur_info  = @L2300_hi08_BH_occur_info ,
				@L2300_hi08_BH_occur_info_date  = @L2300_hi08_BH_occur_info_date ,
				@L2300_hi09_BH_occur_info  = @L2300_hi09_BH_occur_info ,
				@L2300_hi09_BH_occur_info_date  = @L2300_hi09_BH_occur_info_date ,
				@L2300_hi10_BH_occur_info  = @L2300_hi10_BH_occur_info ,
				@L2300_hi10_BH_occur_info_date  = @L2300_hi10_BH_occur_info_date ,
				@L2300_hi11_BH_occur_info  = @L2300_hi11_BH_occur_info ,
				@L2300_hi11_BH_occur_info_date  = @L2300_hi11_BH_occur_info_date ,
				@L2300_hi12_BH_occur_info  = @L2300_hi12_BH_occur_info ,
				@L2300_hi12_BH_occur_info_date  = @L2300_hi12_BH_occur_info_date ,
				@L2300_hi01_BE_value_info  = @L2300_hi01_BE_value_info ,
				@L2300_hi01_BE_value_info_amt  = @L2300_hi01_BE_value_info_amt ,
				@L2300_hi02_BE_value_info  = @L2300_hi02_BE_value_info ,
				@L2300_hi02_BE_value_info_amt  = @L2300_hi02_BE_value_info_amt ,
				@L2300_hi03_BE_value_info  = @L2300_hi03_BE_value_info ,
				@L2300_hi03_BE_value_info_amt  = @L2300_hi03_BE_value_info_amt ,
				@L2300_hi04_BE_value_info  = @L2300_hi04_BE_value_info ,
				@L2300_hi04_BE_value_info_amt  = @L2300_hi04_BE_value_info_amt ,
				@L2300_hi05_BE_value_info  = @L2300_hi05_BE_value_info ,
				@L2300_hi05_BE_value_info_amt  = @L2300_hi05_BE_value_info_amt ,
				@L2300_hi06_BE_value_info  = @L2300_hi06_BE_value_info ,
				@L2300_hi06_BE_value_info_amt  = @L2300_hi06_BE_value_info_amt ,
				@L2300_hi07_BE_value_info  = @L2300_hi07_BE_value_info ,
				@L2300_hi07_BE_value_info_amt  = @L2300_hi07_BE_value_info_amt ,
				@L2300_hi08_BE_value_info  = @L2300_hi08_BE_value_info ,
				@L2300_hi08_BE_value_info_amt  = @L2300_hi08_BE_value_info_amt ,
				@L2300_hi09_BE_value_info  = @L2300_hi09_BE_value_info ,
				@L2300_hi09_BE_value_info_amt  = @L2300_hi09_BE_value_info_amt ,
				@L2300_hi10_BE_value_info  = @L2300_hi10_BE_value_info ,
				@L2300_hi10_BE_value_info_amt  = @L2300_hi10_BE_value_info_amt ,
				@L2300_hi11_BE_value_info  = @L2300_hi11_BE_value_info ,
				@L2300_hi11_BE_value_info_amt  = @L2300_hi11_BE_value_info_amt ,
				@L2300_hi12_BE_value_info  = @L2300_hi12_BE_value_info ,
				@L2300_hi12_BE_value_info_amt  = @L2300_hi12_BE_value_info_amt ,
				@L2300_hi01_BG_cond_info  = @L2300_hi01_BG_cond_info ,
				@L2300_hi02_BG_cond_info  = @L2300_hi02_BG_cond_info ,
				@L2300_hi03_BG_cond_info  = @L2300_hi03_BG_cond_info ,
				@L2300_hi04_BG_cond_info  = @L2300_hi04_BG_cond_info ,
				@L2300_hi05_BG_cond_info  = @L2300_hi05_BG_cond_info ,
				@L2300_hi06_BG_cond_info  = @L2300_hi06_BG_cond_info ,
				@L2300_hi07_BG_cond_info  = @L2300_hi07_BG_cond_info ,
				@L2300_hi08_BG_cond_info  = @L2300_hi08_BG_cond_info ,
				@L2300_hi09_BG_cond_info  = @L2300_hi09_BG_cond_info ,
				@L2300_hi10_BG_cond_info  = @L2300_hi10_BG_cond_info ,
				@L2300_hi11_BG_cond_info  = @L2300_hi11_BG_cond_info ,
				@L2300_hi12_BG_cond_info  = @L2300_hi12_BG_cond_info ,
				@L2300_hi01_TC_treat_code_info  = @L2300_hi01_TC_treat_code_info ,
				@L2300_hi02_TC_treat_code_info  = @L2300_hi02_TC_treat_code_info ,
				@L2300_hi03_TC_treat_code_info  = @L2300_hi03_TC_treat_code_info ,
				@L2300_hi04_TC_treat_code_info  = @L2300_hi04_TC_treat_code_info ,
				@L2300_hi05_TC_treat_code_info  = @L2300_hi05_TC_treat_code_info ,
				@L2300_hi06_TC_treat_code_info  = @L2300_hi06_TC_treat_code_info ,
				@L2300_hi07_TC_treat_code_info  = @L2300_hi07_TC_treat_code_info ,
				@L2300_hi08_TC_treat_code_info  = @L2300_hi08_TC_treat_code_info ,
				@L2300_hi09_TC_treat_code_info  = @L2300_hi09_TC_treat_code_info ,
				@L2300_hi10_TC_treat_code_info  = @L2300_hi10_TC_treat_code_info ,
				@L2300_hi11_TC_treat_code_info  = @L2300_hi11_TC_treat_code_info ,
				@L2300_hi12_TC_treat_code_info  = @L2300_hi12_TC_treat_code_info ,
				@L2300_qty02_CA_claim_qty  = @L2300_qty02_CA_claim_qty ,
				@L2300_qty02_CD_claim_qty  = @L2300_qty02_CD_claim_qty ,
				@L2300_qty02_LA_claim_qty  = @L2300_qty02_LA_claim_qty ,
				@L2300_qty02_NA_claim_qty  = @L2300_qty02_NA_claim_qty ,
				@L2310A_nm101_entity_id_code  = @L2310A_nm101_entity_id_code ,
				@L2310A_nm102_entity_type_qual  = @L2310A_nm102_entity_type_qual ,
				@L2310A_nm103_attending_prov_last_nm  = @L2310A_nm103_attending_prov_last_nm ,
				@L2310A_nm104_attending_prov_first_nm  = @L2310A_nm104_attending_prov_first_nm ,
				@L2310A_nm105_attending_prov_middle_nm  = @L2310A_nm105_attending_prov_middle_nm ,
				@L2310A_nm107_attending_prov_suffix  = @L2310A_nm107_attending_prov_suffix ,
				@L2310A_nm108_id_code_qual  = @L2310A_nm108_id_code_qual ,
				@L2310A_nm109_attending_prov_id  = @L2310A_nm109_attending_prov_id ,
				@L2310A_prv01_provider_code  = @L2310A_prv01_provider_code ,
				@L2310A_prv02_ref_id_qual  = @L2310A_prv02_ref_id_qual ,
				@L2310A_prv03_taxonomy_code  = @L2310A_prv03_taxonomy_code ,
				@L2310A_ref02_1C_attending_prov_id  = @L2310A_ref02_1C_attending_prov_id ,
				@L2310A_ref02_1D_attending_prov_id  = @L2310A_ref02_1D_attending_prov_id ,
				@L2310A_ref02_1G_attending_prov_id  = @L2310A_ref02_1G_attending_prov_id ,
				@L2310A_ref02_EI_attending_prov_id  = @L2310A_ref02_EI_attending_prov_id ,
				@L2310A_ref02_SY_attending_prov_id  = @L2310A_ref02_SY_attending_prov_id ,
				@L2310A_ref02_FH_attending_prov_id  = @L2310A_ref02_FH_attending_prov_id ,
				@L2310B_nm102_entity_type_qual  = @L2310B_nm102_entity_type_qual ,
				@L2310B_nm103_operating_prov_last_nm  = @L2310B_nm103_operating_prov_last_nm ,
				@L2310B_nm104_operating_prov_first_nm  = @L2310B_nm104_operating_prov_first_nm ,
				@L2310B_nm105_operating_prov_middle_nm  = @L2310B_nm105_operating_prov_middle_nm ,
				@L2310B_nm107_operating_prov_suffix  = @L2310B_nm107_operating_prov_suffix ,
				@L2310B_nm108_id_code_qual  = @L2310B_nm108_id_code_qual ,
				@L2310B_nm109_operating_prov_id  = @L2310B_nm109_operating_prov_id ,
				@L2310B_ref02_1C_operating_prov_id  = @L2310B_ref02_1C_operating_prov_id ,
				@L2310B_ref02_1D_operating_prov_id  = @L2310B_ref02_1D_operating_prov_id ,
				@L2310B_ref02_1G_operating_prov_id  = @L2310B_ref02_1G_operating_prov_id ,
				@L2310B_ref02_EI_operating_prov_id  = @L2310B_ref02_EI_operating_prov_id ,
				@L2310B_ref02_SY_operating_prov_id  = @L2310B_ref02_SY_operating_prov_id ,
				@L2310B_ref02_FH_operating_prov_id  = @L2310B_ref02_FH_operating_prov_id ,
				@L2310C_nm102_entity_type_qual  = @L2310C_nm102_entity_type_qual ,
				@L2310C_nm103_other_prov_last_nm  = @L2310C_nm103_other_prov_last_nm ,
				@L2310C_nm104_other_prov_first_nm  = @L2310C_nm104_other_prov_first_nm ,
				@L2310C_nm105_other_prov_middle_nm  = @L2310C_nm105_other_prov_middle_nm ,
				@L2310C_nm107_other_prov_suffix  = @L2310C_nm107_other_prov_suffix ,
				@L2310C_nm108_id_code_qual  = @L2310C_nm108_id_code_qual ,
				@L2310C_nm109_other_prov_id  = @L2310C_nm109_other_prov_id ,
				@L2310C_ref02_1C_other_prov_id  = @L2310C_ref02_1C_other_prov_id ,
				@L2310C_ref02_1D_other_prov_id  = @L2310C_ref02_1D_other_prov_id ,
				@L2310C_ref02_1G_other_prov_id  = @L2310C_ref02_1G_other_prov_id ,
				@L2310C_ref02_EI_other_prov_id  = @L2310C_ref02_EI_other_prov_id ,
				@L2310C_ref02_SY_other_prov_id  = @L2310C_ref02_SY_other_prov_id ,
				@L2310C_ref02_FH_other_prov_id  = @L2310C_ref02_FH_other_prov_id ,
				@L2310E_nm101_entity_id_code  = @L2310E_nm101_entity_id_code ,
				@L2310E_nm102_entity_type_qual  = @L2310E_nm102_entity_type_qual ,
				@L2310E_nm103_service_facility_last_nm  = @L2310E_nm103_service_facility_last_nm ,
				@L2310E_nm108_id_code_qual  = @L2310E_nm108_id_code_qual ,
				@L2310E_nm109_service_facility_id  = @L2310E_nm109_service_facility_id ,
				@L2310E_n301_service_facility_address1  = @L2310E_n301_service_facility_address1 ,
				@L2310E_n302_service_facility_address2  = @L2310E_n302_service_facility_address2 ,
				@L2310E_n401_service_facility_city  = @L2310E_n401_service_facility_city ,
				@L2310E_n402_service_facility_state  = @L2310E_n402_service_facility_state ,
				@L2310E_n403_service_facility_zip  = @L2310E_n403_service_facility_zip ,
				@L2310E_n404_service_facility_country  = @L2310E_n404_service_facility_country ,
				@L2310E_ref02_1C_service_facility_id  = @L2310E_ref02_1C_service_facility_id ,
				@L2310E_ref02_1D_service_facility_id  = @L2310E_ref02_1D_service_facility_id ,
				@L2310E_ref02_1G_service_facility_id  = @L2310E_ref02_1G_service_facility_id ,
				@L2310E_ref02_G2_service_facility_id  = @L2310E_ref02_G2_service_facility_id ,
				@L2320_1_sbr01_payer_resp_seq_code  = @L2320_1_sbr01_payer_resp_seq_code ,
				@L2320_1_sbr02_ind_relationship_code  = @L2320_1_sbr02_ind_relationship_code ,
				@L2320_1_sbr03_insured_grp_policy_num  = @L2320_1_sbr03_insured_grp_policy_num ,
				@L2320_1_sbr04_insured_grp_nm  = @L2320_1_sbr04_insured_grp_nm ,
				@L2320_1_sbr09_claim_file_ind_code  = @L2320_1_sbr09_claim_file_ind_code ,
				@L2320_1_cas01_adjustment_group_code  = @L2320_1_cas01_adjustment_group_code ,
				@L2320_1_cas02_adjustment_reason_code  = @L2320_1_cas02_adjustment_reason_code ,
				@L2320_1_cas03_adjustment_amt  = @L2320_1_cas03_adjustment_amt ,
				@L2320_1_cas04_adjustment_qty  = @L2320_1_cas04_adjustment_qty ,
				@L2320_1_cas05_adjustment_reason_code  = @L2320_1_cas05_adjustment_reason_code ,
				@L2320_1_cas06_adjustment_amt  = @L2320_1_cas06_adjustment_amt ,
				@L2320_1_cas07_adjustment_qty  = @L2320_1_cas07_adjustment_qty ,
				@L2320_1_cas08_adjustment_reason_code  = @L2320_1_cas08_adjustment_reason_code ,
				@L2320_1_cas09_adjustment_amt  = @L2320_1_cas09_adjustment_amt ,
				@L2320_1_cas10_adjustment_qty  = @L2320_1_cas10_adjustment_qty ,
				@L2320_1_amt02_C4_payer_prior_pmt_amt  = @L2320_1_amt02_C4_payer_prior_pmt_amt ,
				@L2320_1_amt02_B6_cob_allowed_amt  = @L2320_1_amt02_B6_cob_allowed_amt ,
				@L2320_1_amt02_T3_cob_submitted_amt  = @L2320_1_amt02_T3_cob_submitted_amt ,
				@L2320_1_amt02_ZZ_drg_outlier_amt  = @L2320_1_amt02_ZZ_drg_outlier_amt ,
				@L2320_1_amt02_N1_cob_medicare_paid_amt  = @L2320_1_amt02_N1_cob_medicare_paid_amt ,
				@L2320_1_amt02_KF_medicare_paid_100_amt  = @L2320_1_amt02_KF_medicare_paid_100_amt ,
				@L2320_1_amt02_PG_medicare_paid_80_amt  = @L2320_1_amt02_PG_medicare_paid_80_amt ,
				@L2320_1_amt02_AA_cob_medicare_a_trust_pd_amt  = @L2320_1_amt02_AA_cob_medicare_a_trust_pd_amt ,
				@L2320_1_amt02_B1_cob_medicare_b_trust_pd_amt  = @L2320_1_amt02_B1_cob_medicare_b_trust_pd_amt ,
				@L2320_1_amt02_A8_cob_non_cvd_amt  = @L2320_1_amt02_A8_cob_non_cvd_amt ,
				@L2320_1_amt02_YT_cob_denied_amt  = @L2320_1_amt02_YT_cob_denied_amt ,
				@L2320_1_dmg02_other_subscriber_dob  = @L2320_1_dmg02_other_subscriber_dob ,
				@L2320_1_dmg03_other_subscriber_gender  = @L2320_1_dmg03_other_subscriber_gender ,
				@L2320_1_oi03_other_ins_benefit_assign_ind  = @L2320_1_oi03_other_ins_benefit_assign_ind ,
				@L2320_1_oi06_other_ins_release_of_info_code  = @L2320_1_oi06_other_ins_release_of_info_code ,
				@L2330A_1_nm101_entity_id_code  = @L2330A_1_nm101_entity_id_code ,
				@L2330A_1_nm102_entity_type_qual  = @L2330A_1_nm102_entity_type_qual ,
				@L2330A_1_nm103_other_subscriber_last_name  = @L2330A_1_nm103_other_subscriber_last_name ,
				@L2330A_1_nm104_other_subscriber_first_name  = @L2330A_1_nm104_other_subscriber_first_name ,
				@L2330A_1_nm105_other_subscriber_middle_name  = @L2330A_1_nm105_other_subscriber_middle_name ,
				@L2330A_1_nm107_other_subscriber_name_suffix  = @L2330A_1_nm107_other_subscriber_name_suffix ,
				@L2330A_1_nm108_other_subscriber_id_code_qual  = @L2330A_1_nm108_other_subscriber_id_code_qual ,
				@L2330A_1_nm109_other_subscriber_id  = @L2330A_1_nm109_other_subscriber_id ,
				@L2330B_1_nm101_entity_id_code  = @L2330B_1_nm101_entity_id_code ,
				@L2330B_1_nm102_entity_type_qual  = @L2330B_1_nm102_entity_type_qual ,
				@L2330B_1_nm103_other_payer_nm  = @L2330B_1_nm103_other_payer_nm ,
				@L2330B_1_nm108_id_code_qual  = @L2330B_1_nm108_id_code_qual ,
				@L2330B_1_nm109_other_payer_id  = @L2330B_1_nm109_other_payer_id ,
				@L2330B_1_dtp03_573_date_claim_paid  = @L2330B_1_dtp03_573_date_claim_paid ,
				@L2330B_1_ref02_2U_other_payer_secondary_id  = @L2330B_1_ref02_2U_other_payer_secondary_id ,
				@L2330B_1_ref02_F8_other_payer_secondary_id  = @L2330B_1_ref02_F8_other_payer_secondary_id ,
				@L2330B_1_ref02_FY_other_payer_secondary_id  = @L2330B_1_ref02_FY_other_payer_secondary_id ,
				@L2330B_1_ref02_NF_other_payer_secondary_id  = @L2330B_1_ref02_NF_other_payer_secondary_id ,
				@L2330B_1_ref02_TJ_other_payer_secondary_id  = @L2330B_1_ref02_TJ_other_payer_secondary_id ,
				@L2330B_1_ref02_9F_other_payer_auth_num  = @L2330B_1_ref02_9F_other_payer_auth_num ,
				@L2330B_1_ref02_G1_other_payer_auth_num  = @L2330B_1_ref02_G1_other_payer_auth_num ,
				@L2320_2_sbr01_payer_resp_seq_code  = @L2320_2_sbr01_payer_resp_seq_code ,
				@L2320_2_sbr02_ind_relationship_code  = @L2320_2_sbr02_ind_relationship_code ,
				@L2320_2_sbr03_insured_grp_policy_num  = @L2320_2_sbr03_insured_grp_policy_num ,
				@L2320_2_sbr04_insured_grp_nm  = @L2320_2_sbr04_insured_grp_nm ,
				@L2320_2_sbr09_claim_file_ind_code  = @L2320_2_sbr09_claim_file_ind_code ,
				@L2320_2_cas01_adjustment_group_code  = @L2320_2_cas01_adjustment_group_code ,
				@L2320_2_cas02_adjustment_reason_code  = @L2320_2_cas02_adjustment_reason_code ,
				@L2320_2_cas03_adjustment_amt  = @L2320_2_cas03_adjustment_amt ,
				@L2320_2_cas04_adjustment_qty  = @L2320_2_cas04_adjustment_qty ,
				@L2320_2_cas05_adjustment_reason_code  = @L2320_2_cas05_adjustment_reason_code ,
				@L2320_2_cas06_adjustment_amt  = @L2320_2_cas06_adjustment_amt ,
				@L2320_2_cas07_adjustment_qty  = @L2320_2_cas07_adjustment_qty ,
				@L2320_2_cas08_adjustment_reason_code  = @L2320_2_cas08_adjustment_reason_code ,
				@L2320_2_cas09_adjustment_amt  = @L2320_2_cas09_adjustment_amt ,
				@L2320_2_cas10_adjustment_qty  = @L2320_2_cas10_adjustment_qty ,
				@L2320_2_amt02_C4_payer_prior_pmt_amt  = @L2320_2_amt02_C4_payer_prior_pmt_amt ,
				@L2320_2_amt02_B6_cob_allowed_amt  = @L2320_2_amt02_B6_cob_allowed_amt ,
				@L2320_2_amt02_T3_cob_submitted_amt  = @L2320_2_amt02_T3_cob_submitted_amt ,
				@L2320_2_amt02_ZZ_drg_outlier_amt  = @L2320_2_amt02_ZZ_drg_outlier_amt ,
				@L2320_2_amt02_N1_cob_medicare_paid_amt  = @L2320_2_amt02_N1_cob_medicare_paid_amt ,
				@L2320_2_amt02_KF_medicare_paid_100_amt  = @L2320_2_amt02_KF_medicare_paid_100_amt ,
				@L2320_2_amt02_PG_medicare_paid_80_amt  = @L2320_2_amt02_PG_medicare_paid_80_amt ,
				@L2320_2_amt02_AA_cob_medicare_a_trust_pd_amt  = @L2320_2_amt02_AA_cob_medicare_a_trust_pd_amt ,
				@L2320_2_amt02_B1_cob_medicare_b_trust_pd_amt  = @L2320_2_amt02_B1_cob_medicare_b_trust_pd_amt ,
				@L2320_2_amt02_A8_cob_non_cvd_amt  = @L2320_2_amt02_A8_cob_non_cvd_amt ,
				@L2320_2_amt02_YT_cob_denied_amt  = @L2320_2_amt02_YT_cob_denied_amt ,
				@L2320_2_dmg02_other_subscriber_dob  = @L2320_2_dmg02_other_subscriber_dob ,
				@L2320_2_dmg03_other_subscriber_gender  = @L2320_2_dmg03_other_subscriber_gender ,
				@L2320_2_oi03_other_ins_benefit_assign_ind  = @L2320_2_oi03_other_ins_benefit_assign_ind ,
				@L2320_2_oi06_other_ins_release_of_info_code  = @L2320_2_oi06_other_ins_release_of_info_code ,
				@L2330A_2_nm101_entity_id_code  = @L2330A_2_nm101_entity_id_code ,
				@L2330A_2_nm102_entity_type_qual  = @L2330A_2_nm102_entity_type_qual ,
				@L2330A_2_nm103_other_subscriber_last_name  = @L2330A_2_nm103_other_subscriber_last_name ,
				@L2330A_2_nm104_other_subscriber_first_name  = @L2330A_2_nm104_other_subscriber_first_name ,
				@L2330A_2_nm105_other_subscriber_middle_name  = @L2330A_2_nm105_other_subscriber_middle_name ,
				@L2330A_2_nm107_other_subscriber_name_suffix  = @L2330A_2_nm107_other_subscriber_name_suffix ,
				@L2330A_2_nm108_other_subscriber_id_code_qual  = @L2330A_2_nm108_other_subscriber_id_code_qual ,
				@L2330A_2_nm109_other_subscriber_id  = @L2330A_2_nm109_other_subscriber_id ,
				@L2330B_2_nm101_entity_id_code  = @L2330B_2_nm101_entity_id_code ,
				@L2330B_2_nm102_entity_type_qual  = @L2330B_2_nm102_entity_type_qual ,
				@L2330B_2_nm103_other_payer_nm  = @L2330B_2_nm103_other_payer_nm ,
				@L2330B_2_nm108_id_code_qual  = @L2330B_2_nm108_id_code_qual ,
				@L2330B_2_nm109_other_payer_id  = @L2330B_2_nm109_other_payer_id ,
				@L2330B_2_dtp03_573_date_claim_paid  = @L2330B_2_dtp03_573_date_claim_paid ,
				@L2330B_2_ref02_2U_other_payer_secondary_id  = @L2330B_2_ref02_2U_other_payer_secondary_id ,
				@L2330B_2_ref02_F8_other_payer_secondary_id  = @L2330B_2_ref02_F8_other_payer_secondary_id ,
				@L2330B_2_ref02_FY_other_payer_secondary_id  = @L2330B_2_ref02_FY_other_payer_secondary_id ,
				@L2330B_2_ref02_NF_other_payer_secondary_id  = @L2330B_2_ref02_NF_other_payer_secondary_id ,
				@L2330B_2_ref02_TJ_other_payer_secondary_id  = @L2330B_2_ref02_TJ_other_payer_secondary_id ,
				@L2330B_2_ref02_9F_other_payer_auth_num  = @L2330B_2_ref02_9F_other_payer_auth_num ,
				@L2330B_2_ref02_G1_other_payer_auth_num  = @L2330B_2_ref02_G1_other_payer_auth_num ,
				@L2320_3_sbr01_payer_resp_seq_code  = @L2320_3_sbr01_payer_resp_seq_code ,
				@L2320_3_sbr02_ind_relationship_code  = @L2320_3_sbr02_ind_relationship_code ,
				@L2320_3_sbr03_insured_grp_policy_num  = @L2320_3_sbr03_insured_grp_policy_num ,
				@L2320_3_sbr04_insured_grp_nm  = @L2320_3_sbr04_insured_grp_nm ,
				@L2320_3_sbr09_claim_file_ind_code  = @L2320_3_sbr09_claim_file_ind_code ,
				@L2320_3_cas01_adjustment_group_code  = @L2320_3_cas01_adjustment_group_code ,
				@L2320_3_cas02_adjustment_reason_code  = @L2320_3_cas02_adjustment_reason_code ,
				@L2320_3_cas03_adjustment_amt  = @L2320_3_cas03_adjustment_amt ,
				@L2320_3_cas04_adjustment_qty  = @L2320_3_cas04_adjustment_qty ,
				@L2320_3_cas05_adjustment_reason_code  = @L2320_3_cas05_adjustment_reason_code ,
				@L2320_3_cas06_adjustment_amt  = @L2320_3_cas06_adjustment_amt ,
				@L2320_3_cas07_adjustment_qty  = @L2320_3_cas07_adjustment_qty ,
				@L2320_3_cas08_adjustment_reason_code  = @L2320_3_cas08_adjustment_reason_code ,
				@L2320_3_cas09_adjustment_amt  = @L2320_3_cas09_adjustment_amt ,
				@L2320_3_cas10_adjustment_qty  = @L2320_3_cas10_adjustment_qty ,
				@L2320_3_amt02_C4_payer_prior_pmt_amt  = @L2320_3_amt02_C4_payer_prior_pmt_amt ,
				@L2320_3_amt02_B6_cob_allowed_amt  = @L2320_3_amt02_B6_cob_allowed_amt ,
				@L2320_3_amt02_T3_cob_submitted_amt  = @L2320_3_amt02_T3_cob_submitted_amt ,
				@L2320_3_amt02_ZZ_drg_outlier_amt  = @L2320_3_amt02_ZZ_drg_outlier_amt ,
				@L2320_3_amt02_N1_cob_medicare_paid_amt  = @L2320_3_amt02_N1_cob_medicare_paid_amt ,
				@L2320_3_amt02_KF_medicare_paid_100_amt  = @L2320_3_amt02_KF_medicare_paid_100_amt ,
				@L2320_3_amt02_PG_medicare_paid_80_amt  = @L2320_3_amt02_PG_medicare_paid_80_amt ,
				@L2320_3_amt02_AA_cob_medicare_a_trust_pd_amt  = @L2320_3_amt02_AA_cob_medicare_a_trust_pd_amt ,
				@L2320_3_amt02_B1_cob_medicare_b_trust_pd_amt  = @L2320_3_amt02_B1_cob_medicare_b_trust_pd_amt ,
				@L2320_3_amt02_A8_cob_non_cvd_amt  = @L2320_3_amt02_A8_cob_non_cvd_amt ,
				@L2320_3_amt02_YT_cob_denied_amt  = @L2320_3_amt02_YT_cob_denied_amt ,
				@L2320_3_dmg02_other_subscriber_dob  = @L2320_3_dmg02_other_subscriber_dob ,
				@L2320_3_dmg03_other_subscriber_gender  = @L2320_3_dmg03_other_subscriber_gender ,
				@L2320_3_oi03_other_ins_benefit_assign_ind  = @L2320_3_oi03_other_ins_benefit_assign_ind ,
				@L2320_3_oi06_other_ins_release_of_info_code  = @L2320_3_oi06_other_ins_release_of_info_code ,
				@L2330A_3_nm101_entity_id_code  = @L2330A_3_nm101_entity_id_code ,
				@L2330A_3_nm102_entity_type_qual  = @L2330A_3_nm102_entity_type_qual ,
				@L2330A_3_nm103_other_subscriber_last_name  = @L2330A_3_nm103_other_subscriber_last_name ,
				@L2330A_3_nm104_other_subscriber_first_name  = @L2330A_3_nm104_other_subscriber_first_name ,
				@L2330A_3_nm105_other_subscriber_middle_name  = @L2330A_3_nm105_other_subscriber_middle_name ,
				@L2330A_3_nm107_other_subscriber_name_suffix  = @L2330A_3_nm107_other_subscriber_name_suffix ,
				@L2330A_3_nm108_other_subscriber_id_code_qual  = @L2330A_3_nm108_other_subscriber_id_code_qual ,
				@L2330A_3_nm109_other_subscriber_id  = @L2330A_3_nm109_other_subscriber_id ,
				@L2330B_3_nm101_entity_id_code  = @L2330B_3_nm101_entity_id_code ,
				@L2330B_3_nm102_entity_type_qual  = @L2330B_3_nm102_entity_type_qual ,
				@L2330B_3_nm103_other_payer_nm  = @L2330B_3_nm103_other_payer_nm ,
				@L2330B_3_nm108_id_code_qual  = @L2330B_3_nm108_id_code_qual ,
				@L2330B_3_nm109_other_payer_id  = @L2330B_3_nm109_other_payer_id ,
				@L2330B_3_dtp03_573_date_claim_paid  = @L2330B_3_dtp03_573_date_claim_paid ,
				@L2330B_3_ref02_2U_other_payer_secondary_id  = @L2330B_3_ref02_2U_other_payer_secondary_id ,
				@L2330B_3_ref02_F8_other_payer_secondary_id  = @L2330B_3_ref02_F8_other_payer_secondary_id ,
				@L2330B_3_ref02_FY_other_payer_secondary_id  = @L2330B_3_ref02_FY_other_payer_secondary_id ,
				@L2330B_3_ref02_NF_other_payer_secondary_id  = @L2330B_3_ref02_NF_other_payer_secondary_id ,
				@L2330B_3_ref02_TJ_other_payer_secondary_id  = @L2330B_3_ref02_TJ_other_payer_secondary_id ,
				@L2330B_3_ref02_9F_other_payer_auth_num  = @L2330B_3_ref02_9F_other_payer_auth_num ,
				@L2330B_3_ref02_G1_other_payer_auth_num  = @L2330B_3_ref02_G1_other_payer_auth_num ,
				@L2400_lx01_assigned_num  = @L2400_lx01_assigned_num ,
				@L2400_sv201_rev_code  = @L2400_sv201_rev_code ,
				@L2400_sv202_proc_code_qual  = @L2400_sv202_proc_code_qual ,
				@L2400_sv202_proc_code  = @L2400_sv202_proc_code ,
				@L2400_sv202_proc_mod1  = @L2400_sv202_proc_mod1 ,
				@L2400_sv202_proc_mod2  = @L2400_sv202_proc_mod2 ,
				@L2400_sv202_proc_mod3  = @L2400_sv202_proc_mod3 ,
				@L2400_sv202_proc_mod4  = @L2400_sv202_proc_mod4 ,
				@L2400_sv203_line_charge  = @L2400_sv203_line_charge ,
				@L2400_sv204_measurement_code  = @L2400_sv204_measurement_code ,
				@L2400_sv205_service_unit_count  = @L2400_sv205_service_unit_count ,
				@L2400_sv206_service_line_rate  = @L2400_sv206_service_line_rate ,
				@L2400_sv207_denied_amt  = @L2400_sv207_denied_amt ,
				@L2400_dtp02_472_from_service_date  = @L2400_dtp02_472_from_service_date ,
				@L2400_dtp02_472_to_service_date  = @L2400_dtp02_472_to_service_date ,
				@L2400_dtp02_866_format_qual  = @L2400_dtp02_866_format_qual ,
				@L2400_dtp02_866_assess_date  = @L2400_dtp02_866_assess_date ,
				@L2410_1_lin03_N4_ndc  = @L2410_1_lin03_N4_ndc ,
				@L2420A_nm102_entity_type_qual  = @L2420A_nm102_entity_type_qual ,
				@L2420A_nm103_attending_physician_last_nm  = @L2420A_nm103_attending_physician_last_nm ,
				@L2420A_nm104_attending_physician_first_nm  = @L2420A_nm104_attending_physician_first_nm ,
				@L2420A_nm105_attending_physician_middle_nm  = @L2420A_nm105_attending_physician_middle_nm ,
				@L2420A_nm107_attending_physician_suffix  = @L2420A_nm107_attending_physician_suffix ,
				@L2420A_nm108_id_code_qual  = @L2420A_nm108_id_code_qual ,
				@L2420A_nm109_attending_physician_id  = @L2420A_nm109_attending_physician_id ,
				@L2420A_ref02_1C_attending_prov_id  = @L2420A_ref02_1C_attending_prov_id ,
				@L2420A_ref02_1D_attending_prov_id  = @L2420A_ref02_1D_attending_prov_id ,
				@L2420A_ref02_1G_attending_prov_id  = @L2420A_ref02_1G_attending_prov_id ,
				@L2420A_ref02_EI_attending_prov_id  = @L2420A_ref02_EI_attending_prov_id ,
				@L2420A_ref02_SY_attending_prov_id  = @L2420A_ref02_SY_attending_prov_id ,
				@L2420A_ref02_FH_attending_prov_id  = @L2420A_ref02_FH_attending_prov_id ,
				@L2420B_nm102_entity_type_qual  = @L2420B_nm102_entity_type_qual ,
				@L2420B_nm103_operating_prov_last_nm  = @L2420B_nm103_operating_prov_last_nm ,
				@L2420B_nm104_operating_prov_first_nm  = @L2420B_nm104_operating_prov_first_nm ,
				@L2420B_nm105_operating_prov_middle_nm  = @L2420B_nm105_operating_prov_middle_nm ,
				@L2420B_nm107_operating_prov_suffix  = @L2420B_nm107_operating_prov_suffix ,
				@L2420B_nm108_id_code_qual  = @L2420B_nm108_id_code_qual ,
				@L2420B_nm109_operating_prov_id  = @L2420B_nm109_operating_prov_id ,
				@L2420B_ref02_1C_operating_prov_id  = @L2420B_ref02_1C_operating_prov_id ,
				@L2420B_ref02_1D_operating_prov_id  = @L2420B_ref02_1D_operating_prov_id ,
				@L2420B_ref02_1G_operating_prov_id  = @L2420B_ref02_1G_operating_prov_id ,
				@L2420B_ref02_EI_operating_prov_id  = @L2420B_ref02_EI_operating_prov_id ,
				@L2420B_ref02_SY_operating_prov_id  = @L2420B_ref02_SY_operating_prov_id ,
				@L2420B_ref02_FH_operating_prov_id  = @L2420B_ref02_FH_operating_prov_id ,
				@L2420C_nm102_entity_type_qual  = @L2420C_nm102_entity_type_qual ,
				@L2420C_nm103_other_prov_last_nm  = @L2420C_nm103_other_prov_last_nm ,
				@L2420C_nm104_other_prov_first_nm  = @L2420C_nm104_other_prov_first_nm ,
				@L2420C_nm105_other_prov_middle_nm  = @L2420C_nm105_other_prov_middle_nm ,
				@L2420C_nm107_other_prov_suffix  = @L2420C_nm107_other_prov_suffix ,
				@L2420C_nm108_id_code_qual  = @L2420C_nm108_id_code_qual ,
				@L2420C_nm109_other_prov_id  = @L2420C_nm109_other_prov_id ,
				@L2420C_ref02_1C_other_prov_id  = @L2420C_ref02_1C_other_prov_id ,
				@L2420C_ref02_1D_other_prov_id  = @L2420C_ref02_1D_other_prov_id ,
				@L2420C_ref02_1G_other_prov_id  = @L2420C_ref02_1G_other_prov_id ,
				@L2420C_ref02_G2_other_prov_id  = @L2420C_ref02_G2_other_prov_id ,
				@L2430_svd01_payer_id  = @L2430_svd01_payer_id ,
				@L2430_svd02_service_line_paid  = @L2430_svd02_service_line_paid ,
				@L2430_svd03_proc_code_qual  = @L2430_svd03_proc_code_qual ,
				@L2430_svd03_proc_code  = @L2430_svd03_proc_code ,
				@L2430_svd03_proc_mod1  = @L2430_svd03_proc_mod1 ,
				@L2430_svd03_proc_mod2  = @L2430_svd03_proc_mod2 ,
				@L2430_svd03_proc_mod3  = @L2430_svd03_proc_mod3 ,
				@L2430_svd03_proc_mod4  = @L2430_svd03_proc_mod4 ,
				@L2430_svd04_rev_code  = @L2430_svd04_rev_code ,
				@L2430_svd05_adj_qty  = @L2430_svd05_adj_qty ,
				@L2430_svd06_bundled_line_num  = @L2430_svd06_bundled_line_num ,
				@L2430_cas01_adjustment_group_code  = @L2430_cas01_adjustment_group_code ,
				@L2430_cas02_adjustment_reason_code  = @L2430_cas02_adjustment_reason_code ,
				@L2430_cas03_adjustment_amt  = @L2430_cas03_adjustment_amt ,
				@L2430_cas04_adjustment_qty  = @L2430_cas04_adjustment_qty ,
				@L2430_cas05_adjustment_reason_code  = @L2430_cas05_adjustment_reason_code ,
				@L2430_cas06_adjustment_amt  = @L2430_cas06_adjustment_amt ,
				@L2430_cas07_adjustment_qty  = @L2430_cas07_adjustment_qty ,
				@L2430_cas08_adjustment_reason_code  = @L2430_cas08_adjustment_reason_code ,
				@L2430_cas09_adjustment_amt  = @L2430_cas09_adjustment_amt ,
				@L2430_cas10_adjustment_qty  = @L2430_cas10_adjustment_qty ,
				@L2430_dtp03_573_service_adjudication_date = @L2430_dtp03_573_service_adjudication_date


			end

		-- reset the procedure code values
			select	@L2400_lx01_assigned_num  = null,
				@L2400_sv201_rev_code = null,
				@L2400_sv202_proc_code_qual = null, 
				@L2400_sv202_proc_code = null,
				@L2400_sv202_proc_mod1 = null, 
				@L2400_sv202_proc_mod2 = null, 
				@L2400_sv202_proc_mod3 = null, 
				@L2400_sv202_proc_mod4 = null, 
				@L2400_sv203_line_charge = null,
				@L2400_sv204_measurement_code = null, 
				@L2400_sv205_service_unit_count = null, 
				@L2400_sv206_service_line_rate = null, 
				@L2400_sv207_denied_amt = null,
				
				@L2400_dtp02_472_from_service_date = null, 
				@L2400_dtp02_472_to_service_date = null, 
				
				@L2400_dtp02_866_format_qual = null, 
				@L2400_dtp02_866_assess_date = null, 
				
				@L2410_1_lin03_N4_ndc = NULL,
				
				@L2420A_nm102_entity_type_qual = null, 
				@L2420A_nm103_attending_physician_last_nm = null, 
				@L2420A_nm104_attending_physician_first_nm = null,
				@L2420A_nm105_attending_physician_middle_nm = null,
				@L2420A_nm107_attending_physician_suffix = null, 
				@L2420A_nm108_id_code_qual = null, 
				@L2420A_nm109_attending_physician_id = null, 
				
				
				@L2420A_ref02_1C_attending_prov_id = null, 
				@L2420A_ref02_1D_attending_prov_id = null, 
				@L2420A_ref02_1G_attending_prov_id = null, 
				@L2420A_ref02_EI_attending_prov_id = null, 
				@L2420A_ref02_SY_attending_prov_id = null, 
				@L2420A_ref02_FH_attending_prov_id = null, 
				
				
				@L2420B_nm102_entity_type_qual = null, 
				@L2420B_nm103_operating_prov_last_nm = null, 
				@L2420B_nm104_operating_prov_first_nm = null,
				@L2420B_nm105_operating_prov_middle_nm = null,
				@L2420B_nm107_operating_prov_suffix = null, 
				@L2420B_nm108_id_code_qual = null, 
				@L2420B_nm109_operating_prov_id = null, 
				
				@L2420B_ref02_1C_operating_prov_id = null, 
				@L2420B_ref02_1D_operating_prov_id = null, 
				@L2420B_ref02_1G_operating_prov_id = null, 
				@L2420B_ref02_EI_operating_prov_id = null, 
				@L2420B_ref02_SY_operating_prov_id = null, 
				@L2420B_ref02_FH_operating_prov_id = null, 
				
				
				@L2420C_nm102_entity_type_qual = null, 
				@L2420C_nm103_other_prov_last_nm = null, 
				@L2420C_nm104_other_prov_first_nm = null,
				@L2420C_nm105_other_prov_middle_nm = null,
				@L2420C_nm107_other_prov_suffix = null, 
				@L2420C_nm108_id_code_qual = null, 
				@L2420C_nm109_other_prov_id = null, 	
				
				@L2420C_ref02_1C_other_prov_id = null, 
				@L2420C_ref02_1D_other_prov_id = null, 
				@L2420C_ref02_1G_other_prov_id = null, 
				@L2420C_ref02_G2_other_prov_id = null, 
				@L2420C_ref02_EI_other_prov_id = null, 
				@L2420C_ref02_SY_other_prov_id = null, 
				@L2420C_ref02_FH_other_prov_id = null, 
				
				@L2430_svd01_payer_id = null, 
				@L2430_svd02_service_line_paid = null,
				@L2430_svd03_proc_code_qual = null, 
				@L2430_svd03_proc_code = null,
				@L2430_svd03_proc_mod1 = null, 
				@L2430_svd03_proc_mod2 = null, 
				@L2430_svd03_proc_mod3 = null, 
				@L2430_svd03_proc_mod4 = null, 
				@L2430_svd04_rev_code = null,
				@L2430_svd05_adj_qty = null, 
				@L2430_svd06_bundled_line_num = null,
				
				@L2430_cas01_adjustment_group_code = null, 
				@L2430_cas02_adjustment_reason_code = null, 
				@L2430_cas03_adjustment_amt = null,
				@L2430_cas04_adjustment_qty = null, 
				@L2430_cas05_adjustment_reason_code = null, 
				@L2430_cas06_adjustment_amt = null,
				@L2430_cas07_adjustment_qty = null, 
				@L2430_cas08_adjustment_reason_code = null, 
				@L2430_cas09_adjustment_amt = null,
				@L2430_cas10_adjustment_qty = null, 
				
				@L2430_dtp03_573_service_adjudication_date = null,
				
				@L2400_lx01_assigned_num = LTRIM(RTRIM(@Col002))
	end
	-- END OF LX SEGMENT

	-- BEGIN OF SV2 SEGMENT
	if ( RTrim(@col001) = 'SV2' )	
	Begin
		set @curLoop = '2400'
		-- col002 will be a string like "HC:T1016:HN" where HC signifies the code type, T1016 is the code, and HN is the modifier
		set @ProcString = LTRIM(RTRIM(@col003))
		set @loopcount = 0

		-- loop over the procedure string and scoop out the values between colons
		while (Len(@ProcString) > 0)
		begin
			set @ColonPos = CHARINDEX(@isa16_component_element_seperator, @ProcString)	-- find the first colon position
			if (@ColonPos > 0)
				set @EndStringPos = @ColonPos-1		-- set the end position for the first value
			else if (@ColonPos = 0)
				set @EndStringPos = Len(@ProcString)	-- if no colon in the string, the value is the string

			set @loopcount = @loopcount + 1
			if (@loopcount = 1) set @L2400_sv202_proc_code_qual = Left(@ProcString, @EndStringPos)
			if (@loopcount = 2) set @L2400_sv202_proc_code = Left(@ProcString, @EndStringPos)
			if (@loopcount = 3) set @L2400_sv202_proc_mod1 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 4) set @L2400_sv202_proc_mod2 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 5) set @L2400_sv202_proc_mod3 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 6) set @L2400_sv202_proc_mod4 = Left(@ProcString, @EndStringPos)

			if (@ColonPos > 0)
				set @ProcString = Right(@ProcString, Len(@ProcString)-@ColonPos)
			else
				set @ProcString = null
		end

		-- UB92 codes (revenue codes) will look like this, "NU:0217"
		if (@L2400_sv202_proc_code_qual = 'NU') -- NU means UB92 Code
		Begin	
			set @L2400_sv202_proc_code = Right(RTrim(@L2400_sv202_proc_code), 3) -- the first digit is a 0, leave that off.
		End

		select	@L2400_sv201_rev_code = LTRIM(RTRIM(@Col002)),
			@L2400_sv203_line_charge = CAST(LTRIM(RTRIM(@Col004)) as money),
			@L2400_sv204_measurement_code = LTRIM(RTRIM(@Col005)),
			@L2400_sv205_service_unit_count = LTRIM(RTRIM(@Col006)),
			@L2400_sv206_service_line_rate = LTRIM(RTRIM(@Col007)),
			@L2400_sv207_denied_amt = CAST(LTRIM(RTRIM(@Col008)) as money)
	end
	-- END OF SV2 SEGMENT

	if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '472' AND @curLoop = '2400')
	begin
		if (RTrim(@col003) = 'D8')
		begin
			set @L2400_dtp02_472_from_service_date = LTrim(RTrim(@col004))
			set @L2400_dtp02_472_to_service_date = LTrim(RTrim(@col004))
		end
		else if (RTrim(@col003) = 'RD8')
		begin
			set @L2400_dtp02_472_from_service_date = Left(LTrim(RTrim(@col004)), 8)
			set @L2400_dtp02_472_to_service_date = Right(LTrim(RTrim(@col004)), 8)
		end
	end

	if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '866' AND @curLoop = '2400' )
	begin
		if (RTrim(@col003) = 'D8')
		begin
			set @L2400_dtp02_866_format_qual = LTrim(RTrim(@col004))
			set @L2400_dtp02_866_assess_date = LTrim(RTrim(@col004))
		end
	end

	
-- Line Item National Drug Code
	IF( 	RTrim(@col001) = 'LIN' AND RTrim(@col003) = 'N4' AND Left(@curLoop, 2) = '24' )
	begin
		select	@curLoop = '2410',
				@L2410_1_lin03_N4_ndc = LTrim(RTrim(@col004))
	END
-- END LOOP: Line Item National Drug Code

-- BEGIN 2420A LOOP: Line Item Rendering Provider
	if ( RTrim(@col001) = 'NM1' AND RTrim(@col002) = '71' AND LEFT(@curLoop, 2) = '24' )
	begin
		select	@curLoop = '2420A',
			@L2420A_nm102_entity_type_qual = LTrim(RTrim(@col003)),
			@L2420A_nm103_attending_physician_last_nm = LTrim(RTrim(@col004)),
			@L2420A_nm104_attending_physician_first_nm = LTrim(RTrim(@col005)),
			@L2420A_nm105_attending_physician_middle_nm = LTrim(RTrim(@col006)),
			@L2420A_nm107_attending_physician_suffix = LTrim(RTrim(@col008)),
			@L2420A_nm108_id_code_qual = LTrim(RTrim(@col009)),
			@L2420A_nm109_attending_physician_id = LTrim(RTrim(@col010))
	end
	
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420A' AND RTrim(@col002) = '1C' )
	begin
		set @L2420A_ref02_1C_attending_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420A' AND RTrim(@col002) = '1D' )
	begin
		set @L2420A_ref02_1D_attending_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420A' AND RTrim(@col002) = '1G' )
	begin
		set @L2420A_ref02_1G_attending_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420A' AND RTrim(@col002) = 'EI' )
	begin
		set @L2420A_ref02_EI_attending_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420A' AND RTrim(@col002) = 'SY' )
	begin
		set @L2420A_ref02_SY_attending_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420A' AND RTrim(@col002) = 'FH' )
	begin
		set @L2420A_ref02_FH_attending_prov_id = LTrim(RTrim(@col003))
	end
-- END 2420A LOOP: Line Item Rendering Provider


-- Begin 2420B LOOP: Operating Physician Name
	if ( RTrim(@col001) = 'NM1' AND RTrim(@col002) = '72' AND @curLoop = '2420A' )
	begin
		select	@curLoop = '2420B',
			@L2420B_nm102_entity_type_qual = LTrim(RTrim(@col003)),
			@L2420B_nm103_operating_prov_last_nm = LTrim(RTrim(@col004)),
			@L2420B_nm104_operating_prov_first_nm = LTrim(RTrim(@col005)),
			@L2420B_nm105_operating_prov_middle_nm = LTrim(RTrim(@col006)),
			@L2420B_nm107_operating_prov_suffix = LTrim(RTrim(@col008)),
			@L2420B_nm108_id_code_qual = LTrim(RTrim(@col009)),
			@L2420B_nm109_operating_prov_id = LTrim(RTrim(@col010))
	end
	
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420B' AND RTrim(@col002) = '1C' )
	begin
		set @L2420B_ref02_1C_operating_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420B' AND RTrim(@col002) = '1D' )
	begin
		set @L2420B_ref02_1D_operating_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420B' AND RTrim(@col002) = '1G' )
	begin
		set @L2420B_ref02_1G_operating_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420B' AND RTrim(@col002) = 'EI' )
	begin
		set @L2420B_ref02_EI_operating_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420B' AND RTrim(@col002) = 'SY' )
	begin
		set @L2420B_ref02_SY_operating_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420B' AND RTrim(@col002) = 'FH' )
	begin
		set @L2420B_ref02_FH_operating_prov_id = LTrim(RTrim(@col003))
	end
-- END 2420B LOOP: Operating Physician Name


-- BEGIN 2420C LOOP: Other Physician Name
	if ( RTrim(@col001) = 'NM1' AND RTrim(@col002) = '73' AND LEFT(@curLoop, 2) = '24' )
	begin
		select	@curLoop = '2420C',
			@L2420C_nm102_entity_type_qual = LTrim(RTrim(@col003)),
			@L2420C_nm103_other_prov_last_nm = LTrim(RTrim(@col004)),
			@L2420C_nm104_other_prov_first_nm = LTrim(RTrim(@col005)),
			@L2420C_nm105_other_prov_middle_nm = LTrim(RTrim(@col006)),
			@L2420C_nm107_other_prov_suffix = LTrim(RTrim(@col008)),
			@L2420C_nm108_id_code_qual = LTrim(RTrim(@col009)),
			@L2420C_nm109_other_prov_id = LTrim(RTrim(@col010))
	end
	
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420C' AND RTrim(@col002) = '1C' )
	begin
		set @L2420C_ref02_1C_other_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420C' AND RTrim(@col002) = '1D' )
	begin
		set @L2420C_ref02_1D_other_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420C' AND RTrim(@col002) = '1G' )
	begin
		set @L2420C_ref02_1G_other_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420C' AND RTrim(@col002) = 'G2' )
	begin
		set @L2420C_ref02_G2_other_prov_id = LTrim(RTrim(@col003))
	end
-- END 2420C LOOP: Other Physician Name

--BEGIN 2430 LOOP: Service Adjudication Information
	if ( RTrim(@col001) = 'SVD')
	Begin
		-- col002 will be a string like "HC:T1016:HN" where HC signifies the code type, T1016 is the code, and HN is the modifier
		set @curLoop = '2430'
		set @ProcString = LTRIM(RTRIM(@col004))
		set @loopcount = 0

		-- loop over the procedure string and scoop out the values between colons
		while (Len(@ProcString) > 0)
		begin
			set @ColonPos = CHARINDEX(@isa16_component_element_seperator, @ProcString)	-- find the first colon position
			if (@ColonPos > 0)
				set @EndStringPos = @ColonPos-1		-- set the end position for the first value
			else if (@ColonPos = 0)
				set @EndStringPos = Len(@ProcString)	-- if no colon in the string, the value is the string

			set @loopcount = @loopcount + 1
			if (@loopcount = 1) set @L2430_svd03_proc_code_qual = Left(@ProcString, @EndStringPos)
			if (@loopcount = 2) set @L2430_svd03_proc_code = Left(@ProcString, @EndStringPos)
			if (@loopcount = 3) set @L2430_svd03_proc_mod1 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 4) set @L2430_svd03_proc_mod2 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 5) set @L2430_svd03_proc_mod3 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 6) set @L2430_svd03_proc_mod4 = Left(@ProcString, @EndStringPos)

			if (@ColonPos > 0)
				set @ProcString = Right(@ProcString, Len(@ProcString)-@ColonPos)
			else
				set @ProcString = null
		end

		-- UB92 codes (revenue codes) will look like this, "NU:0217"
		if (@L2430_svd03_proc_code_qual = 'NU') -- NU means UB92 Code
		begin
			set @L2430_svd03_proc_code = Right(RTrim(@L2430_svd03_proc_code), 3) -- the first digit is a 0, leave that off.
		end
		
		select	@L2430_svd01_payer_id = LTRIM(RTRIM(@Col002)),
			@L2430_svd02_service_line_paid = CAST(RTrim(LTrim(@Col003)) as money),
			@L2430_svd04_rev_code = LTRIM(RTRIM(@Col005)),
			@L2430_svd05_adj_qty = LTRIM(RTRIM(@Col006)),
			@L2430_svd06_bundled_line_num = LTRIM(RTRIM(@Col007))
	End
	-- END SVD SEGMENT: Service Adjudication Information

	if (RTrim(@col001) = 'CAS' AND @curLoop = '2430')
	begin
		select	@L2430_cas01_adjustment_group_code = LTrim(RTrim(@col002)),
			@L2430_cas02_adjustment_reason_code = LTrim(RTrim(@col003)),
			@L2430_cas03_adjustment_amt = CAST(LTrim(RTrim(@col004)) as money),
			@L2430_cas04_adjustment_qty = LTrim(RTrim(@col005)),
			@L2430_cas05_adjustment_reason_code = LTrim(RTrim(@col006)),
			@L2430_cas06_adjustment_amt = CAST(LTrim(RTrim(@col007)) as money),
			@L2430_cas07_adjustment_qty = LTrim(RTrim(@col008)),
			@L2430_cas08_adjustment_reason_code = LTrim(RTrim(@col009)),
			@L2430_cas09_adjustment_amt = CAST(LTrim(RTrim(@col010)) as money),
			@L2430_cas10_adjustment_qty = LTrim(RTrim(@col011))
	end
	if (RTrim(@col001) = 'DTP' AND @curLoop = '2430')
	begin
		set @L2430_dtp03_573_service_adjudication_date = LTrim(RTrim(@col004))
	end
-- END 2430 LOOP: Service Adjudication Information

-- Claim Header Segment
	-- If the current segment is an HL or CLM segment, we're definitely getting ready for a new claim.
	if ( RTrim(@col001) = 'HL' OR RTrim(@col001) = 'CLM' )
	begin
		if (@L2400_sv201_rev_code IS NOT NULL AND @L2400_lx01_assigned_num IS NOT NULL)
		begin
			-- insert a record when we start a new claim (meaning we're done with the last service line on the previous claim)
			EXEC dbo.up_x12_837i_insert
				@x12_transaction_id  = @x12_transaction_id ,
				@bht01_hierarchical_structure_code  = @bht01_hierarchical_structure_code ,
				@bht02_trans_set_purpose_code  = @bht02_trans_set_purpose_code ,
				@bht03_orig_app_tran_id  = @bht03_orig_app_tran_id ,
				@bht04_trans_set_creation_date  = @bht04_trans_set_creation_date ,
				@bht05_trans_set_creation_time  = @bht05_trans_set_creation_time ,
				@bht06_claim_encounter_id  = @bht06_claim_encounter_id ,
				@ref01_receiver_ref_id_qual  = @ref01_receiver_ref_id_qual ,
				@ref02_transmission_type_code  = @ref02_transmission_type_code ,
				@L1000A_nm102_entity_type_qual  = @L1000A_nm102_entity_type_qual ,
				@L1000A_nm103_submitter_last_nm  = @L1000A_nm103_submitter_last_nm ,
				@L1000A_nm104_submitter_first_nm  = @L1000A_nm104_submitter_first_nm ,
				@L1000A_nm105_submitter_middle_nm  = @L1000A_nm105_submitter_middle_nm ,
				@L1000A_nm108_submitter_id_qual  = @L1000A_nm108_submitter_id_qual ,
				@L1000A_nm109_submitter_id  = @L1000A_nm109_submitter_id ,
				@L1000A_per01_contact_function_code  = @L1000A_per01_contact_function_code ,
				@L1000A_per02_contact_nm  = @L1000A_per02_contact_nm ,
				@L1000A_per03_comm_num_qual  = @L1000A_per03_comm_num_qual ,
				@L1000A_per04_comm_number  = @L1000A_per04_comm_number ,
				@L1000B_nm102_entity_type_qual  = @L1000B_nm102_entity_type_qual ,
				@L1000B_nm103_receiver_last_nm  = @L1000B_nm103_receiver_last_nm ,
				@L1000B_nm108_receiver_id_qual  = @L1000B_nm108_receiver_id_qual ,
				@L1000B_nm109_receiver_id  = @L1000B_nm109_receiver_id ,
				@L2000A_hl01_hierarchical_id_num  = @L2000A_hl01_hierarchical_id_num ,
				@L2000A_hl03_hierarchical_level_code  = @L2000A_hl03_hierarchical_level_code ,
				@L2000A_hl04_hierarchical_child_code  = @L2000A_hl04_hierarchical_child_code ,
				@L2000A_prv01_provider_code  = @L2000A_prv01_provider_code ,
				@L2000A_prv02_ref_id_qual  = @L2000A_prv02_ref_id_qual ,
				@L2000A_prv03_taxonomy_code  = @L2000A_prv03_taxonomy_code ,
				@L2000A_cur02_currency_code  = @L2000A_cur02_currency_code ,
				@L2010AA_nm102_entity_type_qual  = @L2010AA_nm102_entity_type_qual ,
				@L2010AA_nm103_billing_prov_last_nm  = @L2010AA_nm103_billing_prov_last_nm ,
				@L2010AA_nm104_billing_prov_first_nm  = @L2010AA_nm104_billing_prov_first_nm ,
				@L2010AA_nm105_billing_prov_middle_nm  = @L2010AA_nm105_billing_prov_middle_nm ,
				@L2010AA_nm107_billing_prov_suffix  = @L2010AA_nm107_billing_prov_suffix ,
				@L2010AA_nm108_id_code_qual  = @L2010AA_nm108_id_code_qual ,
				@L2010AA_nm109_billing_prov_id  = @L2010AA_nm109_billing_prov_id ,
				@L2010AA_n301_billing_prov_address1  = @L2010AA_n301_billing_prov_address1 ,
				@L2010AA_n302_billing_prov_address2  = @L2010AA_n302_billing_prov_address2 ,
				@L2010AA_n401_billing_prov_city  = @L2010AA_n401_billing_prov_city ,
				@L2010AA_n402_billing_prov_state  = @L2010AA_n402_billing_prov_state ,
				@L2010AA_n403_billing_prov_zip  = @L2010AA_n403_billing_prov_zip ,
				@L2010AA_n404_billing_prov_country  = @L2010AA_n404_billing_prov_country ,
				@L2010AA_ref02_1B_billing_prov_id  = @L2010AA_ref02_1B_billing_prov_id ,
				@L2010AA_ref02_1C_billing_prov_id  = @L2010AA_ref02_1C_billing_prov_id ,
				@L2010AA_ref02_1D_billing_prov_id  = @L2010AA_ref02_1D_billing_prov_id ,
				@L2010AA_ref02_1G_billing_prov_id  = @L2010AA_ref02_1G_billing_prov_id ,
				@L2010AA_ref02_EI_billing_prov_id  = @L2010AA_ref02_EI_billing_prov_id ,
				@L2010AA_ref02_SY_billing_prov_id  = @L2010AA_ref02_SY_billing_prov_id ,
				@L2010AA_ref02_FH_billing_prov_id  = @L2010AA_ref02_FH_billing_prov_id ,
				@L2010AA_ref02_06_card_billing_id  = @L2010AA_ref02_06_card_billing_id ,
				@L2010AA_ref02_8U_card_billing_id  = @L2010AA_ref02_8U_card_billing_id ,
				@L2010AA_ref02_EM_card_billing_id  = @L2010AA_ref02_EM_card_billing_id ,
				@L2010AA_ref02_IJ_card_billing_id  = @L2010AA_ref02_IJ_card_billing_id ,
				@L2010AA_ref02_LU_card_billing_id  = @L2010AA_ref02_LU_card_billing_id ,
				@L2010AA_ref02_ST_card_billing_id  = @L2010AA_ref02_ST_card_billing_id ,
				@L2010AA_per01_billing_prov_comm_func_code  = @L2010AA_per01_billing_prov_comm_func_code ,
				@L2010AA_per02_billing_prov_contact_nm  = @L2010AA_per02_billing_prov_contact_nm ,
				@L2010AA_per03_billing_prov_comm_num_qual  = @L2010AA_per03_billing_prov_comm_num_qual ,
				@L2010AA_per04_billing_prov_comm  = @L2010AA_per04_billing_prov_comm ,
				@L2010AB_nm102_entity_type_qual  = @L2010AB_nm102_entity_type_qual ,
				@L2010AB_nm103_payto_prov_last_nm  = @L2010AB_nm103_payto_prov_last_nm ,
				@L2010AB_nm108_id_code_qual  = @L2010AB_nm108_id_code_qual ,
				@L2010AB_nm109_payto_prov_id  = @L2010AB_nm109_payto_prov_id ,
				@L2010AB_n301_payto_prov_address1  = @L2010AB_n301_payto_prov_address1 ,
				@L2010AB_n302_payto_prov_address2  = @L2010AB_n302_payto_prov_address2 ,
				@L2010AB_n401_payto_prov_city  = @L2010AB_n401_payto_prov_city ,
				@L2010AB_n402_payto_prov_state  = @L2010AB_n402_payto_prov_state ,
				@L2010AB_n403_payto_prov_zip  = @L2010AB_n403_payto_prov_zip ,
				@L2010AB_n404_payto_prov_country  = @L2010AB_n404_payto_prov_country ,
				@L2010AB_ref02_1C_payto_prov_id  = @L2010AB_ref02_1C_payto_prov_id ,
				@L2010AB_ref02_1D_payto_prov_id  = @L2010AB_ref02_1D_payto_prov_id ,
				@L2010AB_ref02_1G_payto_prov_id  = @L2010AB_ref02_1G_payto_prov_id ,
				@L2010AB_ref02_EI_payto_prov_id  = @L2010AB_ref02_EI_payto_prov_id ,
				@L2010AB_ref02_SY_payto_prov_id  = @L2010AB_ref02_SY_payto_prov_id ,
				@L2010AB_ref02_FH_payto_prov_id  = @L2010AB_ref02_FH_payto_prov_id ,
				@L2000B_hl01_hierarchical_id_num  = @L2000B_hl01_hierarchical_id_num ,
				@L2000B_hl02_hierarchical_parent_id_num  = @L2000B_hl02_hierarchical_parent_id_num ,
				@L2000B_hl03_hierarchical_level_code  = @L2000B_hl03_hierarchical_level_code ,
				@L2000B_hl04_hierarchical_child_code  = @L2000B_hl04_hierarchical_child_code ,
				@L2000B_sbr01_payer_resp_seq_code  = @L2000B_sbr01_payer_resp_seq_code ,
				@L2000B_sbr02_ind_relationship_code  = @L2000B_sbr02_ind_relationship_code ,
				@L2000B_sbr03_insured_grp_policy_num  = @L2000B_sbr03_insured_grp_policy_num ,
				@L2000B_sbr04_insured_grp_nm  = @L2000B_sbr04_insured_grp_nm ,
				@L2000B_sbr09_claim_id_code  = @L2000B_sbr09_claim_id_code ,
				@L2000B_pat06_insured_ind_death_date  = @L2000B_pat06_insured_ind_death_date ,
				@L2000B_pat08_patient_weight  = @L2000B_pat08_patient_weight ,
				@L2000B_pat09_pregnancy_indicator  = @L2000B_pat09_pregnancy_indicator ,
				@L2010BA_nm102_entity_type_qual  = @L2010BA_nm102_entity_type_qual ,
				@L2010BA_nm103_subscriber_last_nm  = @L2010BA_nm103_subscriber_last_nm ,
				@L2010BA_nm104_subscriber_first_nm  = @L2010BA_nm104_subscriber_first_nm ,
				@L2010BA_nm105_subscriber_middle_nm  = @L2010BA_nm105_subscriber_middle_nm ,
				@L2010BA_nm107_subscriber_suffix  = @L2010BA_nm107_subscriber_suffix ,
				@L2010BA_nm108_id_code_qual  = @L2010BA_nm108_id_code_qual ,
				@L2010BA_nm109_subscriber_id  = @L2010BA_nm109_subscriber_id ,
				@L2010BA_n301_subscriber_address1  = @L2010BA_n301_subscriber_address1 ,
				@L2010BA_n302_subscriber_address2  = @L2010BA_n302_subscriber_address2 ,
				@L2010BA_n401_subscriber_city  = @L2010BA_n401_subscriber_city ,
				@L2010BA_n402_subscriber_state  = @L2010BA_n402_subscriber_state ,
				@L2010BA_n403_subscriber_zip  = @L2010BA_n403_subscriber_zip ,
				@L2010BA_n404_subscriber_country  = @L2010BA_n404_subscriber_country ,
				@L2010BA_dmg02_subscriber_dob  = @L2010BA_dmg02_subscriber_dob ,
				@L2010BA_dmg03_subscriber_gender  = @L2010BA_dmg03_subscriber_gender ,
				@L2010BA_ref02_1W_subscriber_sup_id  = @L2010BA_ref02_1W_subscriber_sup_id ,
				@L2010BA_ref02_23_subscriber_sup_id  = @L2010BA_ref02_23_subscriber_sup_id ,
				@L2010BA_ref02_IG_subscriber_sup_id  = @L2010BA_ref02_IG_subscriber_sup_id ,
				@L2010BA_ref02_SY_subscriber_sup_id  = @L2010BA_ref02_SY_subscriber_sup_id ,
				@L2010BA_ref02_Y4_prop_casualty_claim_num  = @L2010BA_ref02_Y4_prop_casualty_claim_num ,
				@L2010BB_nm102_entity_type_qual  = @L2010BB_nm102_entity_type_qual ,
				@L2010BB_nm103_card_holder_last_nm  = @L2010BB_nm103_card_holder_last_nm ,
				@L2010BB_nm104_card_holder_first_nm  = @L2010BB_nm104_card_holder_first_nm ,
				@L2010BB_nm105_card_holder_middle_nm  = @L2010BB_nm105_card_holder_middle_nm ,
				@L2010BB_nm107_card_holder_suffix  = @L2010BB_nm107_card_holder_suffix ,
				@L2010BB_nm108_card_id_qual  = @L2010BB_nm108_card_id_qual ,
				@L2010BB_nm109_card_num  = @L2010BB_nm109_card_num ,
				@L2010BB_ref02_AB_payer_id  = @L2010BB_ref02_AB_payer_id ,
				@L2010BB_ref02_BB_payer_id  = @L2010BB_ref02_BB_payer_id ,
				@L2010BC_nm102_entity_type_qual  = @L2010BC_nm102_entity_type_qual ,
				@L2010BC_nm103_payer_nm  = @L2010BC_nm103_payer_nm ,
				@L2010BC_nm108_payer_id_qual  = @L2010BC_nm108_payer_id_qual ,
				@L2010BC_nm109_payer_id  = @L2010BC_nm109_payer_id ,
				@L2010BC_n301_payer_address1  = @L2010BC_n301_payer_address1 ,
				@L2010BC_n302_payer_address2  = @L2010BC_n302_payer_address2 ,
				@L2010BC_n401_payer_city  = @L2010BC_n401_payer_city ,
				@L2010BC_n402_payer_state  = @L2010BC_n402_payer_state ,
				@L2010BC_n403_payer_zip  = @L2010BC_n403_payer_zip ,
				@L2010BC_n404_payer_country  = @L2010BC_n404_payer_country ,
				@L2010BC_ref02_2U_payer_id  = @L2010BC_ref02_2U_payer_id ,
				@L2010BC_ref02_FY_payer_id  = @L2010BC_ref02_FY_payer_id ,
				@L2010BC_ref02_NF_payer_id  = @L2010BC_ref02_NF_payer_id ,
				@L2010BC_ref02_TJ_payer_id  = @L2010BC_ref02_TJ_payer_id ,
				@L2010BD_nm102_entity_type_qual  = @L2010BD_nm102_entity_type_qual ,
				@L2010BD_nm103_resp_party_last_nm  = @L2010BD_nm103_resp_party_last_nm ,
				@L2010BD_nm104_resp_party_first_nm  = @L2010BD_nm104_resp_party_first_nm ,
				@L2010BD_nm105_resp_party_middle_nm  = @L2010BD_nm105_resp_party_middle_nm ,
				@L2010BD_nm107_resp_party_suffix  = @L2010BD_nm107_resp_party_suffix ,
				@L2010BD_n301_resp_party_address1  = @L2010BD_n301_resp_party_address1 ,
				@L2010BD_n302_resp_party_address2  = @L2010BD_n302_resp_party_address2 ,
				@L2010BD_n401_resp_party_city  = @L2010BD_n401_resp_party_city ,
				@L2010BD_n402_resp_party_state  = @L2010BD_n402_resp_party_state ,
				@L2010BD_n403_resp_party_zip  = @L2010BD_n403_resp_party_zip ,
				@L2010BD_n404_resp_party_country  = @L2010BD_n404_resp_party_country ,
				@L2000C_hl01_hierarchical_id_num  = @L2000C_hl01_hierarchical_id_num ,
				@L2000C_hl02_hierarchical_parent_id_num  = @L2000C_hl02_hierarchical_parent_id_num ,
				@L2000C_hl03_hierarchical_level_code  = @L2000C_hl03_hierarchical_level_code ,
				@L2000C_hl04_hierarchical_child_code  = @L2000C_hl04_hierarchical_child_code ,
				@L2000C_pat01_ind_relationship_code  = @L2000C_pat01_ind_relationship_code ,
				@L2010CA_nm102_entity_type_qual  = @L2010CA_nm102_entity_type_qual ,
				@L2010CA_nm103_patient_last_nm  = @L2010CA_nm103_patient_last_nm ,
				@L2010CA_nm104_patient_first_nm  = @L2010CA_nm104_patient_first_nm ,
				@L2010CA_nm105_patient_middle_nm  = @L2010CA_nm105_patient_middle_nm ,
				@L2010CA_nm107_patient_suffix  = @L2010CA_nm107_patient_suffix ,
				@L2010CA_nm108_id_code_qual  = @L2010CA_nm108_id_code_qual ,
				@L2010CA_nm109_patient_id  = @L2010CA_nm109_patient_id ,
				@L2010CA_n301_patient_address1  = @L2010CA_n301_patient_address1 ,
				@L2010CA_n302_patient_address2  = @L2010CA_n302_patient_address2 ,
				@L2010CA_n401_patient_city  = @L2010CA_n401_patient_city ,
				@L2010CA_n402_patient_state  = @L2010CA_n402_patient_state ,
				@L2010CA_n403_patient_zip  = @L2010CA_n403_patient_zip ,
				@L2010CA_n404_patient_country  = @L2010CA_n404_patient_country ,
				@L2010CA_dmg02_patient_dob  = @L2010CA_dmg02_patient_dob ,
				@L2010CA_dmg03_patient_gender  = @L2010CA_dmg03_patient_gender ,
				@L2010CA_ref02_1W_patient_sup_id  = @L2010CA_ref02_1W_patient_sup_id ,
				@L2010CA_ref02_23_patient_sup_id  = @L2010CA_ref02_23_patient_sup_id ,
				@L2010CA_ref02_IG_patient_sup_id  = @L2010CA_ref02_IG_patient_sup_id ,
				@L2010CA_ref02_SY_patient_sup_id  = @L2010CA_ref02_SY_patient_sup_id ,
				@L2010CA_ref02_Y4_prop_casualty_claim_num  = @L2010CA_ref02_Y4_prop_casualty_claim_num ,
				@L2300_clm01_pt_acct_num  = @L2300_clm01_pt_acct_num ,
				@L2300_clm02_total_claim_chg_amt  = @L2300_clm02_total_claim_chg_amt ,
				@L2300_clm05_facility_type_code  = @L2300_clm05_facility_type_code ,
				@L2300_clm05_facility_code_qual  = @L2300_clm05_facility_code_qual ,
				@L2300_clm05_claim_freq_code  = @L2300_clm05_claim_freq_code ,
				@L2300_clm06_provider_signature_ind  = @L2300_clm06_provider_signature_ind ,
				@L2300_clm07_medicare_assign_code  = @L2300_clm07_medicare_assign_code ,
				@L2300_clm08_benefit_assign_ind  = @L2300_clm08_benefit_assign_ind ,
				@L2300_clm09_release_of_info_code  = @L2300_clm09_release_of_info_code ,
				@L2300_clm18_explan_benefits_ind  = @L2300_clm18_explan_benefits_ind ,
				@L2300_clm20_delay_reason_code  = @L2300_clm20_delay_reason_code ,
				@L2300_dtp03_096_discharge_hour  = @L2300_dtp03_096_discharge_hour ,
				@L2300_dtp03_434_begin_statement_date  = @L2300_dtp03_434_begin_statement_date ,
				@L2300_dtp03_434_end_statement_date  = @L2300_dtp03_434_end_statement_date ,
				@L2300_dtp03_435_admission_date  = @L2300_dtp03_435_admission_date ,
				@L2300_cl101_admit_type_code  = @L2300_cl101_admit_type_code ,
				@L2300_cl102_admit_source_code  = @L2300_cl102_admit_source_code ,
				@L2300_cl103_patient_status_code  = @L2300_cl103_patient_status_code ,
				@L2300_pwk01_attachment_type_code  = @L2300_pwk01_attachment_type_code ,
				@L2300_pwk02_attachment_trans_code  = @L2300_pwk02_attachment_trans_code ,
				@L2300_pwk06_attachment_control_num  = @L2300_pwk06_attachment_control_num ,
				@L2300_amt02_patient_paid_amt  = @L2300_amt02_patient_paid_amt ,
				@L2300_amt02_patient_resp_amt  = @L2300_amt02_patient_resp_amt ,
				@L2300_amt02_total_purchased_amt  = @L2300_amt02_total_purchased_amt ,
				@L2300_ref02_9C_adj_repriced_claim_num  = @L2300_ref02_9C_adj_repriced_claim_num ,
				@L2300_ref02_9A_repriced_claim_num  = @L2300_ref02_9A_repriced_claim_num ,
				@L2300_ref02_D9_claim_id_clearing_house  = @L2300_ref02_D9_claim_id_clearing_house ,
				@L2300_ref02_DD_domcument_id  = @L2300_ref02_DD_domcument_id ,
				@L2300_ref02_F8_original_ref_num  = @L2300_ref02_F8_original_ref_num ,
				@L2300_ref02_9F_referral_num  = @L2300_ref02_9F_referral_num ,
				@L2300_ref02_G1_prior_auth_num  = @L2300_ref02_G1_prior_auth_num ,
				@L2300_ref02_EA_medical_record_num  = @L2300_ref02_EA_medical_record_num ,
				@L2300_k301_fixed_format_info  = @L2300_k301_fixed_format_info ,
				@L2300_nte01_note_ref_code  = @L2300_nte01_note_ref_code ,
				@L2300_nte02_claim_note_text  = @L2300_nte02_claim_note_text ,
				@L2300_hi01_BK_diag_admit_ecode  = @L2300_hi01_BK_diag_admit_ecode ,
				@L2300_hi02_BJ_diag_admit_ecode  = @L2300_hi02_BJ_diag_admit_ecode ,
				@L2300_hi02_ZZ_diag_admit_ecode  = @L2300_hi02_ZZ_diag_admit_ecode ,
				@L2300_hi03_BN_diag_admit_ecode  = @L2300_hi03_BN_diag_admit_ecode ,
				@L2300_hi01_DR_diag_drg  = @L2300_hi01_DR_diag_drg ,
				@L2300_hi01_BF_diag_code  = @L2300_hi01_BF_diag_code ,
				@L2300_hi02_BF_diag_code  = @L2300_hi02_BF_diag_code ,
				@L2300_hi03_BF_diag_code  = @L2300_hi03_BF_diag_code ,
				@L2300_hi04_BF_diag_code  = @L2300_hi04_BF_diag_code ,
				@L2300_hi05_BF_diag_code  = @L2300_hi05_BF_diag_code ,
				@L2300_hi06_BF_diag_code  = @L2300_hi06_BF_diag_code ,
				@L2300_hi07_BF_diag_code  = @L2300_hi07_BF_diag_code ,
				@L2300_hi08_BF_diag_code  = @L2300_hi08_BF_diag_code ,
				@L2300_hi09_BF_diag_code  = @L2300_hi09_BF_diag_code ,
				@L2300_hi10_BF_diag_code  = @L2300_hi10_BF_diag_code ,
				@L2300_hi11_BF_diag_code  = @L2300_hi11_BF_diag_code ,
				@L2300_hi12_BF_diag_code  = @L2300_hi12_BF_diag_code ,
				@L2300_hi01_BR_princ_proc_info  = @L2300_hi01_BR_princ_proc_info ,
				@L2300_hi01_BR_princ_proc_info_date  = @L2300_hi01_BR_princ_proc_info_date ,
				@L2300_hi01_BQ_other_proc_info  = @L2300_hi01_BQ_other_proc_info ,
				@L2300_hi01_BQ_other_proc_info_date  = @L2300_hi01_BQ_other_proc_info_date ,
				@L2300_hi02_BQ_other_proc_info  = @L2300_hi02_BQ_other_proc_info ,
				@L2300_hi02_BQ_other_proc_info_date  = @L2300_hi02_BQ_other_proc_info_date ,
				@L2300_hi03_BQ_other_proc_info  = @L2300_hi03_BQ_other_proc_info ,
				@L2300_hi03_BQ_other_proc_info_date  = @L2300_hi03_BQ_other_proc_info_date ,
				@L2300_hi04_BQ_other_proc_info  = @L2300_hi04_BQ_other_proc_info ,
				@L2300_hi04_BQ_other_proc_info_date  = @L2300_hi04_BQ_other_proc_info_date ,
				@L2300_hi05_BQ_other_proc_info  = @L2300_hi05_BQ_other_proc_info ,
				@L2300_hi05_BQ_other_proc_info_date  = @L2300_hi05_BQ_other_proc_info_date ,
				@L2300_hi06_BQ_other_proc_info  = @L2300_hi06_BQ_other_proc_info ,
				@L2300_hi06_BQ_other_proc_info_date  = @L2300_hi06_BQ_other_proc_info_date ,
				@L2300_hi07_BQ_other_proc_info  = @L2300_hi07_BQ_other_proc_info ,
				@L2300_hi07_BQ_other_proc_info_date  = @L2300_hi07_BQ_other_proc_info_date ,
				@L2300_hi08_BQ_other_proc_info  = @L2300_hi08_BQ_other_proc_info ,
				@L2300_hi08_BQ_other_proc_info_date  = @L2300_hi08_BQ_other_proc_info_date ,
				@L2300_hi09_BQ_other_proc_info  = @L2300_hi09_BQ_other_proc_info ,
				@L2300_hi09_BQ_other_proc_info_date  = @L2300_hi09_BQ_other_proc_info_date ,
				@L2300_hi10_BQ_other_proc_info  = @L2300_hi10_BQ_other_proc_info ,
				@L2300_hi10_BQ_other_proc_info_date  = @L2300_hi10_BQ_other_proc_info_date ,
				@L2300_hi11_BQ_other_proc_info  = @L2300_hi11_BQ_other_proc_info ,
				@L2300_hi11_BQ_other_proc_info_date  = @L2300_hi11_BQ_other_proc_info_date ,
				@L2300_hi12_BQ_other_proc_info  = @L2300_hi12_BQ_other_proc_info ,
				@L2300_hi12_BQ_other_proc_info_date  = @L2300_hi12_BQ_other_proc_info_date ,
				@L2300_hi01_BI_occur_span  = @L2300_hi01_BI_occur_span ,
				@L2300_hi01_BI_occur_span_date  = @L2300_hi01_BI_occur_span_date ,
				@L2300_hi02_BI_occur_span  = @L2300_hi02_BI_occur_span ,
				@L2300_hi02_BI_occur_span_date  = @L2300_hi02_BI_occur_span_date ,
				@L2300_hi03_BI_occur_span  = @L2300_hi03_BI_occur_span ,
				@L2300_hi03_BI_occur_span_date  = @L2300_hi03_BI_occur_span_date ,
				@L2300_hi04_BI_occur_span  = @L2300_hi04_BI_occur_span ,
				@L2300_hi04_BI_occur_span_date  = @L2300_hi04_BI_occur_span_date ,
				@L2300_hi05_BI_occur_span  = @L2300_hi05_BI_occur_span ,
				@L2300_hi05_BI_occur_span_date  = @L2300_hi05_BI_occur_span_date ,
				@L2300_hi06_BI_occur_span  = @L2300_hi06_BI_occur_span ,
				@L2300_hi06_BI_occur_span_date  = @L2300_hi06_BI_occur_span_date ,
				@L2300_hi07_BI_occur_span  = @L2300_hi07_BI_occur_span ,
				@L2300_hi07_BI_occur_span_date  = @L2300_hi07_BI_occur_span_date ,
				@L2300_hi08_BI_occur_span  = @L2300_hi08_BI_occur_span ,
				@L2300_hi08_BI_occur_span_date  = @L2300_hi08_BI_occur_span_date ,
				@L2300_hi09_BI_occur_span  = @L2300_hi09_BI_occur_span ,
				@L2300_hi09_BI_occur_span_date  = @L2300_hi09_BI_occur_span_date ,
				@L2300_hi10_BI_occur_span  = @L2300_hi10_BI_occur_span ,
				@L2300_hi10_BI_occur_span_date  = @L2300_hi10_BI_occur_span_date ,
				@L2300_hi11_BI_occur_span  = @L2300_hi11_BI_occur_span ,
				@L2300_hi11_BI_occur_span_date  = @L2300_hi11_BI_occur_span_date ,
				@L2300_hi12_BI_occur_span  = @L2300_hi12_BI_occur_span ,
				@L2300_hi12_BI_occur_span_date  = @L2300_hi12_BI_occur_span_date ,
				@L2300_hi01_BH_occur_info  = @L2300_hi01_BH_occur_info ,
				@L2300_hi01_BH_occur_info_date  = @L2300_hi01_BH_occur_info_date ,
				@L2300_hi02_BH_occur_info  = @L2300_hi02_BH_occur_info ,
				@L2300_hi02_BH_occur_info_date  = @L2300_hi02_BH_occur_info_date ,
				@L2300_hi03_BH_occur_info  = @L2300_hi03_BH_occur_info ,
				@L2300_hi03_BH_occur_info_date  = @L2300_hi03_BH_occur_info_date ,
				@L2300_hi04_BH_occur_info  = @L2300_hi04_BH_occur_info ,
				@L2300_hi04_BH_occur_info_date  = @L2300_hi04_BH_occur_info_date ,
				@L2300_hi05_BH_occur_info  = @L2300_hi05_BH_occur_info ,
				@L2300_hi05_BH_occur_info_date  = @L2300_hi05_BH_occur_info_date ,
				@L2300_hi06_BH_occur_info  = @L2300_hi06_BH_occur_info ,
				@L2300_hi06_BH_occur_info_date  = @L2300_hi06_BH_occur_info_date ,
				@L2300_hi07_BH_occur_info  = @L2300_hi07_BH_occur_info ,
				@L2300_hi07_BH_occur_info_date  = @L2300_hi07_BH_occur_info_date ,
				@L2300_hi08_BH_occur_info  = @L2300_hi08_BH_occur_info ,
				@L2300_hi08_BH_occur_info_date  = @L2300_hi08_BH_occur_info_date ,
				@L2300_hi09_BH_occur_info  = @L2300_hi09_BH_occur_info ,
				@L2300_hi09_BH_occur_info_date  = @L2300_hi09_BH_occur_info_date ,
				@L2300_hi10_BH_occur_info  = @L2300_hi10_BH_occur_info ,
				@L2300_hi10_BH_occur_info_date  = @L2300_hi10_BH_occur_info_date ,
				@L2300_hi11_BH_occur_info  = @L2300_hi11_BH_occur_info ,
				@L2300_hi11_BH_occur_info_date  = @L2300_hi11_BH_occur_info_date ,
				@L2300_hi12_BH_occur_info  = @L2300_hi12_BH_occur_info ,
				@L2300_hi12_BH_occur_info_date  = @L2300_hi12_BH_occur_info_date ,
				@L2300_hi01_BE_value_info  = @L2300_hi01_BE_value_info ,
				@L2300_hi01_BE_value_info_amt  = @L2300_hi01_BE_value_info_amt ,
				@L2300_hi02_BE_value_info  = @L2300_hi02_BE_value_info ,
				@L2300_hi02_BE_value_info_amt  = @L2300_hi02_BE_value_info_amt ,
				@L2300_hi03_BE_value_info  = @L2300_hi03_BE_value_info ,
				@L2300_hi03_BE_value_info_amt  = @L2300_hi03_BE_value_info_amt ,
				@L2300_hi04_BE_value_info  = @L2300_hi04_BE_value_info ,
				@L2300_hi04_BE_value_info_amt  = @L2300_hi04_BE_value_info_amt ,
				@L2300_hi05_BE_value_info  = @L2300_hi05_BE_value_info ,
				@L2300_hi05_BE_value_info_amt  = @L2300_hi05_BE_value_info_amt ,
				@L2300_hi06_BE_value_info  = @L2300_hi06_BE_value_info ,
				@L2300_hi06_BE_value_info_amt  = @L2300_hi06_BE_value_info_amt ,
				@L2300_hi07_BE_value_info  = @L2300_hi07_BE_value_info ,
				@L2300_hi07_BE_value_info_amt  = @L2300_hi07_BE_value_info_amt ,
				@L2300_hi08_BE_value_info  = @L2300_hi08_BE_value_info ,
				@L2300_hi08_BE_value_info_amt  = @L2300_hi08_BE_value_info_amt ,
				@L2300_hi09_BE_value_info  = @L2300_hi09_BE_value_info ,
				@L2300_hi09_BE_value_info_amt  = @L2300_hi09_BE_value_info_amt ,
				@L2300_hi10_BE_value_info  = @L2300_hi10_BE_value_info ,
				@L2300_hi10_BE_value_info_amt  = @L2300_hi10_BE_value_info_amt ,
				@L2300_hi11_BE_value_info  = @L2300_hi11_BE_value_info ,
				@L2300_hi11_BE_value_info_amt  = @L2300_hi11_BE_value_info_amt ,
				@L2300_hi12_BE_value_info  = @L2300_hi12_BE_value_info ,
				@L2300_hi12_BE_value_info_amt  = @L2300_hi12_BE_value_info_amt ,
				@L2300_hi01_BG_cond_info  = @L2300_hi01_BG_cond_info ,
				@L2300_hi02_BG_cond_info  = @L2300_hi02_BG_cond_info ,
				@L2300_hi03_BG_cond_info  = @L2300_hi03_BG_cond_info ,
				@L2300_hi04_BG_cond_info  = @L2300_hi04_BG_cond_info ,
				@L2300_hi05_BG_cond_info  = @L2300_hi05_BG_cond_info ,
				@L2300_hi06_BG_cond_info  = @L2300_hi06_BG_cond_info ,
				@L2300_hi07_BG_cond_info  = @L2300_hi07_BG_cond_info ,
				@L2300_hi08_BG_cond_info  = @L2300_hi08_BG_cond_info ,
				@L2300_hi09_BG_cond_info  = @L2300_hi09_BG_cond_info ,
				@L2300_hi10_BG_cond_info  = @L2300_hi10_BG_cond_info ,
				@L2300_hi11_BG_cond_info  = @L2300_hi11_BG_cond_info ,
				@L2300_hi12_BG_cond_info  = @L2300_hi12_BG_cond_info ,
				@L2300_hi01_TC_treat_code_info  = @L2300_hi01_TC_treat_code_info ,
				@L2300_hi02_TC_treat_code_info  = @L2300_hi02_TC_treat_code_info ,
				@L2300_hi03_TC_treat_code_info  = @L2300_hi03_TC_treat_code_info ,
				@L2300_hi04_TC_treat_code_info  = @L2300_hi04_TC_treat_code_info ,
				@L2300_hi05_TC_treat_code_info  = @L2300_hi05_TC_treat_code_info ,
				@L2300_hi06_TC_treat_code_info  = @L2300_hi06_TC_treat_code_info ,
				@L2300_hi07_TC_treat_code_info  = @L2300_hi07_TC_treat_code_info ,
				@L2300_hi08_TC_treat_code_info  = @L2300_hi08_TC_treat_code_info ,
				@L2300_hi09_TC_treat_code_info  = @L2300_hi09_TC_treat_code_info ,
				@L2300_hi10_TC_treat_code_info  = @L2300_hi10_TC_treat_code_info ,
				@L2300_hi11_TC_treat_code_info  = @L2300_hi11_TC_treat_code_info ,
				@L2300_hi12_TC_treat_code_info  = @L2300_hi12_TC_treat_code_info ,
				@L2300_qty02_CA_claim_qty  = @L2300_qty02_CA_claim_qty ,
				@L2300_qty02_CD_claim_qty  = @L2300_qty02_CD_claim_qty ,
				@L2300_qty02_LA_claim_qty  = @L2300_qty02_LA_claim_qty ,
				@L2300_qty02_NA_claim_qty  = @L2300_qty02_NA_claim_qty ,
				@L2310A_nm101_entity_id_code  = @L2310A_nm101_entity_id_code ,
				@L2310A_nm102_entity_type_qual  = @L2310A_nm102_entity_type_qual ,
				@L2310A_nm103_attending_prov_last_nm  = @L2310A_nm103_attending_prov_last_nm ,
				@L2310A_nm104_attending_prov_first_nm  = @L2310A_nm104_attending_prov_first_nm ,
				@L2310A_nm105_attending_prov_middle_nm  = @L2310A_nm105_attending_prov_middle_nm ,
				@L2310A_nm107_attending_prov_suffix  = @L2310A_nm107_attending_prov_suffix ,
				@L2310A_nm108_id_code_qual  = @L2310A_nm108_id_code_qual ,
				@L2310A_nm109_attending_prov_id  = @L2310A_nm109_attending_prov_id ,
				@L2310A_prv01_provider_code  = @L2310A_prv01_provider_code ,
				@L2310A_prv02_ref_id_qual  = @L2310A_prv02_ref_id_qual ,
				@L2310A_prv03_taxonomy_code  = @L2310A_prv03_taxonomy_code ,
				@L2310A_ref02_1C_attending_prov_id  = @L2310A_ref02_1C_attending_prov_id ,
				@L2310A_ref02_1D_attending_prov_id  = @L2310A_ref02_1D_attending_prov_id ,
				@L2310A_ref02_1G_attending_prov_id  = @L2310A_ref02_1G_attending_prov_id ,
				@L2310A_ref02_EI_attending_prov_id  = @L2310A_ref02_EI_attending_prov_id ,
				@L2310A_ref02_SY_attending_prov_id  = @L2310A_ref02_SY_attending_prov_id ,
				@L2310A_ref02_FH_attending_prov_id  = @L2310A_ref02_FH_attending_prov_id ,
				@L2310B_nm102_entity_type_qual  = @L2310B_nm102_entity_type_qual ,
				@L2310B_nm103_operating_prov_last_nm  = @L2310B_nm103_operating_prov_last_nm ,
				@L2310B_nm104_operating_prov_first_nm  = @L2310B_nm104_operating_prov_first_nm ,
				@L2310B_nm105_operating_prov_middle_nm  = @L2310B_nm105_operating_prov_middle_nm ,
				@L2310B_nm107_operating_prov_suffix  = @L2310B_nm107_operating_prov_suffix ,
				@L2310B_nm108_id_code_qual  = @L2310B_nm108_id_code_qual ,
				@L2310B_nm109_operating_prov_id  = @L2310B_nm109_operating_prov_id ,
				@L2310B_ref02_1C_operating_prov_id  = @L2310B_ref02_1C_operating_prov_id ,
				@L2310B_ref02_1D_operating_prov_id  = @L2310B_ref02_1D_operating_prov_id ,
				@L2310B_ref02_1G_operating_prov_id  = @L2310B_ref02_1G_operating_prov_id ,
				@L2310B_ref02_EI_operating_prov_id  = @L2310B_ref02_EI_operating_prov_id ,
				@L2310B_ref02_SY_operating_prov_id  = @L2310B_ref02_SY_operating_prov_id ,
				@L2310B_ref02_FH_operating_prov_id  = @L2310B_ref02_FH_operating_prov_id ,
				@L2310C_nm102_entity_type_qual  = @L2310C_nm102_entity_type_qual ,
				@L2310C_nm103_other_prov_last_nm  = @L2310C_nm103_other_prov_last_nm ,
				@L2310C_nm104_other_prov_first_nm  = @L2310C_nm104_other_prov_first_nm ,
				@L2310C_nm105_other_prov_middle_nm  = @L2310C_nm105_other_prov_middle_nm ,
				@L2310C_nm107_other_prov_suffix  = @L2310C_nm107_other_prov_suffix ,
				@L2310C_nm108_id_code_qual  = @L2310C_nm108_id_code_qual ,
				@L2310C_nm109_other_prov_id  = @L2310C_nm109_other_prov_id ,
				@L2310C_ref02_1C_other_prov_id  = @L2310C_ref02_1C_other_prov_id ,
				@L2310C_ref02_1D_other_prov_id  = @L2310C_ref02_1D_other_prov_id ,
				@L2310C_ref02_1G_other_prov_id  = @L2310C_ref02_1G_other_prov_id ,
				@L2310C_ref02_EI_other_prov_id  = @L2310C_ref02_EI_other_prov_id ,
				@L2310C_ref02_SY_other_prov_id  = @L2310C_ref02_SY_other_prov_id ,
				@L2310C_ref02_FH_other_prov_id  = @L2310C_ref02_FH_other_prov_id ,
				@L2310E_nm101_entity_id_code  = @L2310E_nm101_entity_id_code ,
				@L2310E_nm102_entity_type_qual  = @L2310E_nm102_entity_type_qual ,
				@L2310E_nm103_service_facility_last_nm  = @L2310E_nm103_service_facility_last_nm ,
				@L2310E_nm108_id_code_qual  = @L2310E_nm108_id_code_qual ,
				@L2310E_nm109_service_facility_id  = @L2310E_nm109_service_facility_id ,
				@L2310E_n301_service_facility_address1  = @L2310E_n301_service_facility_address1 ,
				@L2310E_n302_service_facility_address2  = @L2310E_n302_service_facility_address2 ,
				@L2310E_n401_service_facility_city  = @L2310E_n401_service_facility_city ,
				@L2310E_n402_service_facility_state  = @L2310E_n402_service_facility_state ,
				@L2310E_n403_service_facility_zip  = @L2310E_n403_service_facility_zip ,
				@L2310E_n404_service_facility_country  = @L2310E_n404_service_facility_country ,
				@L2310E_ref02_1C_service_facility_id  = @L2310E_ref02_1C_service_facility_id ,
				@L2310E_ref02_1D_service_facility_id  = @L2310E_ref02_1D_service_facility_id ,
				@L2310E_ref02_1G_service_facility_id  = @L2310E_ref02_1G_service_facility_id ,
				@L2310E_ref02_G2_service_facility_id  = @L2310E_ref02_G2_service_facility_id ,
				@L2320_1_sbr01_payer_resp_seq_code  = @L2320_1_sbr01_payer_resp_seq_code ,
				@L2320_1_sbr02_ind_relationship_code  = @L2320_1_sbr02_ind_relationship_code ,
				@L2320_1_sbr03_insured_grp_policy_num  = @L2320_1_sbr03_insured_grp_policy_num ,
				@L2320_1_sbr04_insured_grp_nm  = @L2320_1_sbr04_insured_grp_nm ,
				@L2320_1_sbr09_claim_file_ind_code  = @L2320_1_sbr09_claim_file_ind_code ,
				@L2320_1_cas01_adjustment_group_code  = @L2320_1_cas01_adjustment_group_code ,
				@L2320_1_cas02_adjustment_reason_code  = @L2320_1_cas02_adjustment_reason_code ,
				@L2320_1_cas03_adjustment_amt  = @L2320_1_cas03_adjustment_amt ,
				@L2320_1_cas04_adjustment_qty  = @L2320_1_cas04_adjustment_qty ,
				@L2320_1_cas05_adjustment_reason_code  = @L2320_1_cas05_adjustment_reason_code ,
				@L2320_1_cas06_adjustment_amt  = @L2320_1_cas06_adjustment_amt ,
				@L2320_1_cas07_adjustment_qty  = @L2320_1_cas07_adjustment_qty ,
				@L2320_1_cas08_adjustment_reason_code  = @L2320_1_cas08_adjustment_reason_code ,
				@L2320_1_cas09_adjustment_amt  = @L2320_1_cas09_adjustment_amt ,
				@L2320_1_cas10_adjustment_qty  = @L2320_1_cas10_adjustment_qty ,
				@L2320_1_amt02_C4_payer_prior_pmt_amt  = @L2320_1_amt02_C4_payer_prior_pmt_amt ,
				@L2320_1_amt02_B6_cob_allowed_amt  = @L2320_1_amt02_B6_cob_allowed_amt ,
				@L2320_1_amt02_T3_cob_submitted_amt  = @L2320_1_amt02_T3_cob_submitted_amt ,
				@L2320_1_amt02_ZZ_drg_outlier_amt  = @L2320_1_amt02_ZZ_drg_outlier_amt ,
				@L2320_1_amt02_N1_cob_medicare_paid_amt  = @L2320_1_amt02_N1_cob_medicare_paid_amt ,
				@L2320_1_amt02_KF_medicare_paid_100_amt  = @L2320_1_amt02_KF_medicare_paid_100_amt ,
				@L2320_1_amt02_PG_medicare_paid_80_amt  = @L2320_1_amt02_PG_medicare_paid_80_amt ,
				@L2320_1_amt02_AA_cob_medicare_a_trust_pd_amt  = @L2320_1_amt02_AA_cob_medicare_a_trust_pd_amt ,
				@L2320_1_amt02_B1_cob_medicare_b_trust_pd_amt  = @L2320_1_amt02_B1_cob_medicare_b_trust_pd_amt ,
				@L2320_1_amt02_A8_cob_non_cvd_amt  = @L2320_1_amt02_A8_cob_non_cvd_amt ,
				@L2320_1_amt02_YT_cob_denied_amt  = @L2320_1_amt02_YT_cob_denied_amt ,
				@L2320_1_dmg02_other_subscriber_dob  = @L2320_1_dmg02_other_subscriber_dob ,
				@L2320_1_dmg03_other_subscriber_gender  = @L2320_1_dmg03_other_subscriber_gender ,
				@L2320_1_oi03_other_ins_benefit_assign_ind  = @L2320_1_oi03_other_ins_benefit_assign_ind ,
				@L2320_1_oi06_other_ins_release_of_info_code  = @L2320_1_oi06_other_ins_release_of_info_code ,
				@L2330A_1_nm101_entity_id_code  = @L2330A_1_nm101_entity_id_code ,
				@L2330A_1_nm102_entity_type_qual  = @L2330A_1_nm102_entity_type_qual ,
				@L2330A_1_nm103_other_subscriber_last_name  = @L2330A_1_nm103_other_subscriber_last_name ,
				@L2330A_1_nm104_other_subscriber_first_name  = @L2330A_1_nm104_other_subscriber_first_name ,
				@L2330A_1_nm105_other_subscriber_middle_name  = @L2330A_1_nm105_other_subscriber_middle_name ,
				@L2330A_1_nm107_other_subscriber_name_suffix  = @L2330A_1_nm107_other_subscriber_name_suffix ,
				@L2330A_1_nm108_other_subscriber_id_code_qual  = @L2330A_1_nm108_other_subscriber_id_code_qual ,
				@L2330A_1_nm109_other_subscriber_id  = @L2330A_1_nm109_other_subscriber_id ,
				@L2330B_1_nm101_entity_id_code  = @L2330B_1_nm101_entity_id_code ,
				@L2330B_1_nm102_entity_type_qual  = @L2330B_1_nm102_entity_type_qual ,
				@L2330B_1_nm103_other_payer_nm  = @L2330B_1_nm103_other_payer_nm ,
				@L2330B_1_nm108_id_code_qual  = @L2330B_1_nm108_id_code_qual ,
				@L2330B_1_nm109_other_payer_id  = @L2330B_1_nm109_other_payer_id ,
				@L2330B_1_dtp03_573_date_claim_paid  = @L2330B_1_dtp03_573_date_claim_paid ,
				@L2330B_1_ref02_2U_other_payer_secondary_id  = @L2330B_1_ref02_2U_other_payer_secondary_id ,
				@L2330B_1_ref02_F8_other_payer_secondary_id  = @L2330B_1_ref02_F8_other_payer_secondary_id ,
				@L2330B_1_ref02_FY_other_payer_secondary_id  = @L2330B_1_ref02_FY_other_payer_secondary_id ,
				@L2330B_1_ref02_NF_other_payer_secondary_id  = @L2330B_1_ref02_NF_other_payer_secondary_id ,
				@L2330B_1_ref02_TJ_other_payer_secondary_id  = @L2330B_1_ref02_TJ_other_payer_secondary_id ,
				@L2330B_1_ref02_9F_other_payer_auth_num  = @L2330B_1_ref02_9F_other_payer_auth_num ,
				@L2330B_1_ref02_G1_other_payer_auth_num  = @L2330B_1_ref02_G1_other_payer_auth_num ,
				@L2320_2_sbr01_payer_resp_seq_code  = @L2320_2_sbr01_payer_resp_seq_code ,
				@L2320_2_sbr02_ind_relationship_code  = @L2320_2_sbr02_ind_relationship_code ,
				@L2320_2_sbr03_insured_grp_policy_num  = @L2320_2_sbr03_insured_grp_policy_num ,
				@L2320_2_sbr04_insured_grp_nm  = @L2320_2_sbr04_insured_grp_nm ,
				@L2320_2_sbr09_claim_file_ind_code  = @L2320_2_sbr09_claim_file_ind_code ,
				@L2320_2_cas01_adjustment_group_code  = @L2320_2_cas01_adjustment_group_code ,
				@L2320_2_cas02_adjustment_reason_code  = @L2320_2_cas02_adjustment_reason_code ,
				@L2320_2_cas03_adjustment_amt  = @L2320_2_cas03_adjustment_amt ,
				@L2320_2_cas04_adjustment_qty  = @L2320_2_cas04_adjustment_qty ,
				@L2320_2_cas05_adjustment_reason_code  = @L2320_2_cas05_adjustment_reason_code ,
				@L2320_2_cas06_adjustment_amt  = @L2320_2_cas06_adjustment_amt ,
				@L2320_2_cas07_adjustment_qty  = @L2320_2_cas07_adjustment_qty ,
				@L2320_2_cas08_adjustment_reason_code  = @L2320_2_cas08_adjustment_reason_code ,
				@L2320_2_cas09_adjustment_amt  = @L2320_2_cas09_adjustment_amt ,
				@L2320_2_cas10_adjustment_qty  = @L2320_2_cas10_adjustment_qty ,
				@L2320_2_amt02_C4_payer_prior_pmt_amt  = @L2320_2_amt02_C4_payer_prior_pmt_amt ,
				@L2320_2_amt02_B6_cob_allowed_amt  = @L2320_2_amt02_B6_cob_allowed_amt ,
				@L2320_2_amt02_T3_cob_submitted_amt  = @L2320_2_amt02_T3_cob_submitted_amt ,
				@L2320_2_amt02_ZZ_drg_outlier_amt  = @L2320_2_amt02_ZZ_drg_outlier_amt ,
				@L2320_2_amt02_N1_cob_medicare_paid_amt  = @L2320_2_amt02_N1_cob_medicare_paid_amt ,
				@L2320_2_amt02_KF_medicare_paid_100_amt  = @L2320_2_amt02_KF_medicare_paid_100_amt ,
				@L2320_2_amt02_PG_medicare_paid_80_amt  = @L2320_2_amt02_PG_medicare_paid_80_amt ,
				@L2320_2_amt02_AA_cob_medicare_a_trust_pd_amt  = @L2320_2_amt02_AA_cob_medicare_a_trust_pd_amt ,
				@L2320_2_amt02_B1_cob_medicare_b_trust_pd_amt  = @L2320_2_amt02_B1_cob_medicare_b_trust_pd_amt ,
				@L2320_2_amt02_A8_cob_non_cvd_amt  = @L2320_2_amt02_A8_cob_non_cvd_amt ,
				@L2320_2_amt02_YT_cob_denied_amt  = @L2320_2_amt02_YT_cob_denied_amt ,
				@L2320_2_dmg02_other_subscriber_dob  = @L2320_2_dmg02_other_subscriber_dob ,
				@L2320_2_dmg03_other_subscriber_gender  = @L2320_2_dmg03_other_subscriber_gender ,
				@L2320_2_oi03_other_ins_benefit_assign_ind  = @L2320_2_oi03_other_ins_benefit_assign_ind ,
				@L2320_2_oi06_other_ins_release_of_info_code  = @L2320_2_oi06_other_ins_release_of_info_code ,
				@L2330A_2_nm101_entity_id_code  = @L2330A_2_nm101_entity_id_code ,
				@L2330A_2_nm102_entity_type_qual  = @L2330A_2_nm102_entity_type_qual ,
				@L2330A_2_nm103_other_subscriber_last_name  = @L2330A_2_nm103_other_subscriber_last_name ,
				@L2330A_2_nm104_other_subscriber_first_name  = @L2330A_2_nm104_other_subscriber_first_name ,
				@L2330A_2_nm105_other_subscriber_middle_name  = @L2330A_2_nm105_other_subscriber_middle_name ,
				@L2330A_2_nm107_other_subscriber_name_suffix  = @L2330A_2_nm107_other_subscriber_name_suffix ,
				@L2330A_2_nm108_other_subscriber_id_code_qual  = @L2330A_2_nm108_other_subscriber_id_code_qual ,
				@L2330A_2_nm109_other_subscriber_id  = @L2330A_2_nm109_other_subscriber_id ,
				@L2330B_2_nm101_entity_id_code  = @L2330B_2_nm101_entity_id_code ,
				@L2330B_2_nm102_entity_type_qual  = @L2330B_2_nm102_entity_type_qual ,
				@L2330B_2_nm103_other_payer_nm  = @L2330B_2_nm103_other_payer_nm ,
				@L2330B_2_nm108_id_code_qual  = @L2330B_2_nm108_id_code_qual ,
				@L2330B_2_nm109_other_payer_id  = @L2330B_2_nm109_other_payer_id ,
				@L2330B_2_dtp03_573_date_claim_paid  = @L2330B_2_dtp03_573_date_claim_paid ,
				@L2330B_2_ref02_2U_other_payer_secondary_id  = @L2330B_2_ref02_2U_other_payer_secondary_id ,
				@L2330B_2_ref02_F8_other_payer_secondary_id  = @L2330B_2_ref02_F8_other_payer_secondary_id ,
				@L2330B_2_ref02_FY_other_payer_secondary_id  = @L2330B_2_ref02_FY_other_payer_secondary_id ,
				@L2330B_2_ref02_NF_other_payer_secondary_id  = @L2330B_2_ref02_NF_other_payer_secondary_id ,
				@L2330B_2_ref02_TJ_other_payer_secondary_id  = @L2330B_2_ref02_TJ_other_payer_secondary_id ,
				@L2330B_2_ref02_9F_other_payer_auth_num  = @L2330B_2_ref02_9F_other_payer_auth_num ,
				@L2330B_2_ref02_G1_other_payer_auth_num  = @L2330B_2_ref02_G1_other_payer_auth_num ,
				@L2320_3_sbr01_payer_resp_seq_code  = @L2320_3_sbr01_payer_resp_seq_code ,
				@L2320_3_sbr02_ind_relationship_code  = @L2320_3_sbr02_ind_relationship_code ,
				@L2320_3_sbr03_insured_grp_policy_num  = @L2320_3_sbr03_insured_grp_policy_num ,
				@L2320_3_sbr04_insured_grp_nm  = @L2320_3_sbr04_insured_grp_nm ,
				@L2320_3_sbr09_claim_file_ind_code  = @L2320_3_sbr09_claim_file_ind_code ,
				@L2320_3_cas01_adjustment_group_code  = @L2320_3_cas01_adjustment_group_code ,
				@L2320_3_cas02_adjustment_reason_code  = @L2320_3_cas02_adjustment_reason_code ,
				@L2320_3_cas03_adjustment_amt  = @L2320_3_cas03_adjustment_amt ,
				@L2320_3_cas04_adjustment_qty  = @L2320_3_cas04_adjustment_qty ,
				@L2320_3_cas05_adjustment_reason_code  = @L2320_3_cas05_adjustment_reason_code ,
				@L2320_3_cas06_adjustment_amt  = @L2320_3_cas06_adjustment_amt ,
				@L2320_3_cas07_adjustment_qty  = @L2320_3_cas07_adjustment_qty ,
				@L2320_3_cas08_adjustment_reason_code  = @L2320_3_cas08_adjustment_reason_code ,
				@L2320_3_cas09_adjustment_amt  = @L2320_3_cas09_adjustment_amt ,
				@L2320_3_cas10_adjustment_qty  = @L2320_3_cas10_adjustment_qty ,
				@L2320_3_amt02_C4_payer_prior_pmt_amt  = @L2320_3_amt02_C4_payer_prior_pmt_amt ,
				@L2320_3_amt02_B6_cob_allowed_amt  = @L2320_3_amt02_B6_cob_allowed_amt ,
				@L2320_3_amt02_T3_cob_submitted_amt  = @L2320_3_amt02_T3_cob_submitted_amt ,
				@L2320_3_amt02_ZZ_drg_outlier_amt  = @L2320_3_amt02_ZZ_drg_outlier_amt ,
				@L2320_3_amt02_N1_cob_medicare_paid_amt  = @L2320_3_amt02_N1_cob_medicare_paid_amt ,
				@L2320_3_amt02_KF_medicare_paid_100_amt  = @L2320_3_amt02_KF_medicare_paid_100_amt ,
				@L2320_3_amt02_PG_medicare_paid_80_amt  = @L2320_3_amt02_PG_medicare_paid_80_amt ,
				@L2320_3_amt02_AA_cob_medicare_a_trust_pd_amt  = @L2320_3_amt02_AA_cob_medicare_a_trust_pd_amt ,
				@L2320_3_amt02_B1_cob_medicare_b_trust_pd_amt  = @L2320_3_amt02_B1_cob_medicare_b_trust_pd_amt ,
				@L2320_3_amt02_A8_cob_non_cvd_amt  = @L2320_3_amt02_A8_cob_non_cvd_amt ,
				@L2320_3_amt02_YT_cob_denied_amt  = @L2320_3_amt02_YT_cob_denied_amt ,
				@L2320_3_dmg02_other_subscriber_dob  = @L2320_3_dmg02_other_subscriber_dob ,
				@L2320_3_dmg03_other_subscriber_gender  = @L2320_3_dmg03_other_subscriber_gender ,
				@L2320_3_oi03_other_ins_benefit_assign_ind  = @L2320_3_oi03_other_ins_benefit_assign_ind ,
				@L2320_3_oi06_other_ins_release_of_info_code  = @L2320_3_oi06_other_ins_release_of_info_code ,
				@L2330A_3_nm101_entity_id_code  = @L2330A_3_nm101_entity_id_code ,
				@L2330A_3_nm102_entity_type_qual  = @L2330A_3_nm102_entity_type_qual ,
				@L2330A_3_nm103_other_subscriber_last_name  = @L2330A_3_nm103_other_subscriber_last_name ,
				@L2330A_3_nm104_other_subscriber_first_name  = @L2330A_3_nm104_other_subscriber_first_name ,
				@L2330A_3_nm105_other_subscriber_middle_name  = @L2330A_3_nm105_other_subscriber_middle_name ,
				@L2330A_3_nm107_other_subscriber_name_suffix  = @L2330A_3_nm107_other_subscriber_name_suffix ,
				@L2330A_3_nm108_other_subscriber_id_code_qual  = @L2330A_3_nm108_other_subscriber_id_code_qual ,
				@L2330A_3_nm109_other_subscriber_id  = @L2330A_3_nm109_other_subscriber_id ,
				@L2330B_3_nm101_entity_id_code  = @L2330B_3_nm101_entity_id_code ,
				@L2330B_3_nm102_entity_type_qual  = @L2330B_3_nm102_entity_type_qual ,
				@L2330B_3_nm103_other_payer_nm  = @L2330B_3_nm103_other_payer_nm ,
				@L2330B_3_nm108_id_code_qual  = @L2330B_3_nm108_id_code_qual ,
				@L2330B_3_nm109_other_payer_id  = @L2330B_3_nm109_other_payer_id ,
				@L2330B_3_dtp03_573_date_claim_paid  = @L2330B_3_dtp03_573_date_claim_paid ,
				@L2330B_3_ref02_2U_other_payer_secondary_id  = @L2330B_3_ref02_2U_other_payer_secondary_id ,
				@L2330B_3_ref02_F8_other_payer_secondary_id  = @L2330B_3_ref02_F8_other_payer_secondary_id ,
				@L2330B_3_ref02_FY_other_payer_secondary_id  = @L2330B_3_ref02_FY_other_payer_secondary_id ,
				@L2330B_3_ref02_NF_other_payer_secondary_id  = @L2330B_3_ref02_NF_other_payer_secondary_id ,
				@L2330B_3_ref02_TJ_other_payer_secondary_id  = @L2330B_3_ref02_TJ_other_payer_secondary_id ,
				@L2330B_3_ref02_9F_other_payer_auth_num  = @L2330B_3_ref02_9F_other_payer_auth_num ,
				@L2330B_3_ref02_G1_other_payer_auth_num  = @L2330B_3_ref02_G1_other_payer_auth_num ,
				@L2400_lx01_assigned_num  = @L2400_lx01_assigned_num ,
				@L2400_sv201_rev_code  = @L2400_sv201_rev_code ,
				@L2400_sv202_proc_code_qual  = @L2400_sv202_proc_code_qual ,
				@L2400_sv202_proc_code  = @L2400_sv202_proc_code ,
				@L2400_sv202_proc_mod1  = @L2400_sv202_proc_mod1 ,
				@L2400_sv202_proc_mod2  = @L2400_sv202_proc_mod2 ,
				@L2400_sv202_proc_mod3  = @L2400_sv202_proc_mod3 ,
				@L2400_sv202_proc_mod4  = @L2400_sv202_proc_mod4 ,
				@L2400_sv203_line_charge  = @L2400_sv203_line_charge ,
				@L2400_sv204_measurement_code  = @L2400_sv204_measurement_code ,
				@L2400_sv205_service_unit_count  = @L2400_sv205_service_unit_count ,
				@L2400_sv206_service_line_rate  = @L2400_sv206_service_line_rate ,
				@L2400_sv207_denied_amt  = @L2400_sv207_denied_amt ,
				@L2400_dtp02_472_from_service_date  = @L2400_dtp02_472_from_service_date ,
				@L2400_dtp02_472_to_service_date  = @L2400_dtp02_472_to_service_date ,
				@L2400_dtp02_866_format_qual  = @L2400_dtp02_866_format_qual ,
				@L2400_dtp02_866_assess_date  = @L2400_dtp02_866_assess_date ,
				@L2410_1_lin03_N4_ndc  = @L2410_1_lin03_N4_ndc ,
				@L2420A_nm102_entity_type_qual  = @L2420A_nm102_entity_type_qual ,
				@L2420A_nm103_attending_physician_last_nm  = @L2420A_nm103_attending_physician_last_nm ,
				@L2420A_nm104_attending_physician_first_nm  = @L2420A_nm104_attending_physician_first_nm ,
				@L2420A_nm105_attending_physician_middle_nm  = @L2420A_nm105_attending_physician_middle_nm ,
				@L2420A_nm107_attending_physician_suffix  = @L2420A_nm107_attending_physician_suffix ,
				@L2420A_nm108_id_code_qual  = @L2420A_nm108_id_code_qual ,
				@L2420A_nm109_attending_physician_id  = @L2420A_nm109_attending_physician_id ,
				@L2420A_ref02_1C_attending_prov_id  = @L2420A_ref02_1C_attending_prov_id ,
				@L2420A_ref02_1D_attending_prov_id  = @L2420A_ref02_1D_attending_prov_id ,
				@L2420A_ref02_1G_attending_prov_id  = @L2420A_ref02_1G_attending_prov_id ,
				@L2420A_ref02_EI_attending_prov_id  = @L2420A_ref02_EI_attending_prov_id ,
				@L2420A_ref02_SY_attending_prov_id  = @L2420A_ref02_SY_attending_prov_id ,
				@L2420A_ref02_FH_attending_prov_id  = @L2420A_ref02_FH_attending_prov_id ,
				@L2420B_nm102_entity_type_qual  = @L2420B_nm102_entity_type_qual ,
				@L2420B_nm103_operating_prov_last_nm  = @L2420B_nm103_operating_prov_last_nm ,
				@L2420B_nm104_operating_prov_first_nm  = @L2420B_nm104_operating_prov_first_nm ,
				@L2420B_nm105_operating_prov_middle_nm  = @L2420B_nm105_operating_prov_middle_nm ,
				@L2420B_nm107_operating_prov_suffix  = @L2420B_nm107_operating_prov_suffix ,
				@L2420B_nm108_id_code_qual  = @L2420B_nm108_id_code_qual ,
				@L2420B_nm109_operating_prov_id  = @L2420B_nm109_operating_prov_id ,
				@L2420B_ref02_1C_operating_prov_id  = @L2420B_ref02_1C_operating_prov_id ,
				@L2420B_ref02_1D_operating_prov_id  = @L2420B_ref02_1D_operating_prov_id ,
				@L2420B_ref02_1G_operating_prov_id  = @L2420B_ref02_1G_operating_prov_id ,
				@L2420B_ref02_EI_operating_prov_id  = @L2420B_ref02_EI_operating_prov_id ,
				@L2420B_ref02_SY_operating_prov_id  = @L2420B_ref02_SY_operating_prov_id ,
				@L2420B_ref02_FH_operating_prov_id  = @L2420B_ref02_FH_operating_prov_id ,
				@L2420C_nm102_entity_type_qual  = @L2420C_nm102_entity_type_qual ,
				@L2420C_nm103_other_prov_last_nm  = @L2420C_nm103_other_prov_last_nm ,
				@L2420C_nm104_other_prov_first_nm  = @L2420C_nm104_other_prov_first_nm ,
				@L2420C_nm105_other_prov_middle_nm  = @L2420C_nm105_other_prov_middle_nm ,
				@L2420C_nm107_other_prov_suffix  = @L2420C_nm107_other_prov_suffix ,
				@L2420C_nm108_id_code_qual  = @L2420C_nm108_id_code_qual ,
				@L2420C_nm109_other_prov_id  = @L2420C_nm109_other_prov_id ,
				@L2420C_ref02_1C_other_prov_id  = @L2420C_ref02_1C_other_prov_id ,
				@L2420C_ref02_1D_other_prov_id  = @L2420C_ref02_1D_other_prov_id ,
				@L2420C_ref02_1G_other_prov_id  = @L2420C_ref02_1G_other_prov_id ,
				@L2420C_ref02_G2_other_prov_id  = @L2420C_ref02_G2_other_prov_id ,
				@L2430_svd01_payer_id  = @L2430_svd01_payer_id ,
				@L2430_svd02_service_line_paid  = @L2430_svd02_service_line_paid ,
				@L2430_svd03_proc_code_qual  = @L2430_svd03_proc_code_qual ,
				@L2430_svd03_proc_code  = @L2430_svd03_proc_code ,
				@L2430_svd03_proc_mod1  = @L2430_svd03_proc_mod1 ,
				@L2430_svd03_proc_mod2  = @L2430_svd03_proc_mod2 ,
				@L2430_svd03_proc_mod3  = @L2430_svd03_proc_mod3 ,
				@L2430_svd03_proc_mod4  = @L2430_svd03_proc_mod4 ,
				@L2430_svd04_rev_code  = @L2430_svd04_rev_code ,
				@L2430_svd05_adj_qty  = @L2430_svd05_adj_qty ,
				@L2430_svd06_bundled_line_num  = @L2430_svd06_bundled_line_num ,
				@L2430_cas01_adjustment_group_code  = @L2430_cas01_adjustment_group_code ,
				@L2430_cas02_adjustment_reason_code  = @L2430_cas02_adjustment_reason_code ,
				@L2430_cas03_adjustment_amt  = @L2430_cas03_adjustment_amt ,
				@L2430_cas04_adjustment_qty  = @L2430_cas04_adjustment_qty ,
				@L2430_cas05_adjustment_reason_code  = @L2430_cas05_adjustment_reason_code ,
				@L2430_cas06_adjustment_amt  = @L2430_cas06_adjustment_amt ,
				@L2430_cas07_adjustment_qty  = @L2430_cas07_adjustment_qty ,
				@L2430_cas08_adjustment_reason_code  = @L2430_cas08_adjustment_reason_code ,
				@L2430_cas09_adjustment_amt  = @L2430_cas09_adjustment_amt ,
				@L2430_cas10_adjustment_qty  = @L2430_cas10_adjustment_qty ,
				@L2430_dtp03_573_service_adjudication_date = @L2430_dtp03_573_service_adjudication_date

			-- reset claim-level values to NULL here
			-- BEGIN: RESET DX FIELDS
			select	@L2300_clm01_pt_acct_num = null, 
				@L2300_clm02_total_claim_chg_amt = null,
				@L2300_clm05_facility_type_code = null, 
				@L2300_clm05_facility_code_qual = null,
				@L2300_clm05_claim_freq_code = null, 
				@L2300_clm06_provider_signature_ind = null, 
				@L2300_clm07_medicare_assign_code = null, 
				@L2300_clm08_benefit_assign_ind = null, 
				@L2300_clm09_release_of_info_code = null, 
				@L2300_clm18_explan_benefits_ind = null, 
				@L2300_clm20_delay_reason_code = null, 
				
				@L2300_dtp03_096_discharge_hour = null, 
				@L2300_dtp03_434_begin_statement_date = null, 
				@L2300_dtp03_434_end_statement_date = null, 
				@L2300_dtp03_435_admission_date = null, 
				
				@L2300_cl101_admit_type_code = null,
				@L2300_cl102_admit_source_code = null,
				@L2300_cl103_patient_status_code = null,
				
				@L2300_pwk01_attachment_type_code = null, 
				@L2300_pwk02_attachment_trans_code = null, 
				@L2300_pwk06_attachment_control_num = null, 
				
				@L2300_amt02_patient_paid_amt  = null,
				@L2300_amt02_patient_resp_amt  = null,
				@L2300_amt02_total_purchased_amt = null,
				
				@L2300_ref02_9C_adj_repriced_claim_num = null, 
				@L2300_ref02_9A_repriced_claim_num = null, 
				@L2300_ref02_D9_claim_id_clearing_house = null, 
				@L2300_ref02_DD_domcument_id = null, 
				@L2300_ref02_F8_original_ref_num = null, 
				@L2300_ref02_9F_referral_num = null, 
				@L2300_ref02_G1_prior_auth_num = null, 
				@L2300_ref02_EA_medical_record_num = null, 
				
				@L2300_k301_fixed_format_info = null, 
				
				@L2300_nte01_note_ref_code = null, 
				@L2300_nte02_claim_note_text = null, 
				
				@L2300_hi01_DR_diag_drg  = null,
	
				@L2300_hi01_BK_diag_admit_ecode  = null,
				@L2300_hi02_BJ_diag_admit_ecode  = null,
				@L2300_hi02_ZZ_diag_admit_ecode  = null,
				@L2300_hi03_BN_diag_admit_ecode  = null,
	
				@L2300_hi01_BF_diag_code  = null,
				@L2300_hi02_BF_diag_code  = null,
				@L2300_hi03_BF_diag_code  = null,
				@L2300_hi04_BF_diag_code  = null,
				@L2300_hi05_BF_diag_code  = null,
				@L2300_hi06_BF_diag_code  = null,
				@L2300_hi07_BF_diag_code  = null,
				@L2300_hi08_BF_diag_code  = null,
				@L2300_hi09_BF_diag_code  = null,
				@L2300_hi10_BF_diag_code  = null,
				@L2300_hi11_BF_diag_code  = null,
				@L2300_hi12_BF_diag_code  = null,
	
				@L2300_hi01_BR_princ_proc_info  = null,
				@L2300_hi01_BR_princ_proc_info_date  = null,
	
				@L2300_hi01_BQ_other_proc_info  = null,
				@L2300_hi02_BQ_other_proc_info  = null,
				@L2300_hi03_BQ_other_proc_info  = null,
				@L2300_hi04_BQ_other_proc_info  = null,
				@L2300_hi05_BQ_other_proc_info  = null,
				@L2300_hi06_BQ_other_proc_info  = null,
				@L2300_hi07_BQ_other_proc_info  = null,
				@L2300_hi08_BQ_other_proc_info  = null,
				@L2300_hi09_BQ_other_proc_info  = null,
				@L2300_hi10_BQ_other_proc_info  = null,
				@L2300_hi11_BQ_other_proc_info  = null,
				@L2300_hi12_BQ_other_proc_info  = null,
	
				@L2300_hi01_BI_occur_span  = null,
				@L2300_hi02_BI_occur_span  = null,
				@L2300_hi03_BI_occur_span  = null,
				@L2300_hi04_BI_occur_span  = null,
				@L2300_hi05_BI_occur_span  = null,
				@L2300_hi06_BI_occur_span  = null,
				@L2300_hi07_BI_occur_span  = null,
				@L2300_hi08_BI_occur_span  = null,
				@L2300_hi09_BI_occur_span  = null,
				@L2300_hi10_BI_occur_span  = null,
				@L2300_hi11_BI_occur_span  = null,
				@L2300_hi12_BI_occur_span  = null,
	
				@L2300_hi01_BH_occur_info  = null,
				@L2300_hi02_BH_occur_info  = null,
				@L2300_hi03_BH_occur_info  = null,
				@L2300_hi04_BH_occur_info  = null,
				@L2300_hi05_BH_occur_info  = null,
				@L2300_hi06_BH_occur_info  = null,
				@L2300_hi07_BH_occur_info  = null,
				@L2300_hi08_BH_occur_info  = null,
				@L2300_hi09_BH_occur_info  = null,
				@L2300_hi10_BH_occur_info  = null,
				@L2300_hi11_BH_occur_info  = null,
				@L2300_hi12_BH_occur_info  = null,
	
				@L2300_hi01_BE_value_info  = null,
				@L2300_hi02_BE_value_info  = null,
				@L2300_hi03_BE_value_info  = null,
				@L2300_hi04_BE_value_info  = null,				
				@L2300_hi05_BE_value_info  = null,
				@L2300_hi06_BE_value_info  = null,
				@L2300_hi07_BE_value_info  = null,
				@L2300_hi08_BE_value_info  = null,
				@L2300_hi09_BE_value_info  = null,
				@L2300_hi10_BE_value_info  = null,
				@L2300_hi11_BE_value_info  = null,
				@L2300_hi12_BE_value_info  = null,
				@L2300_hi01_BE_value_info_amt  = null,
				@L2300_hi02_BE_value_info_amt  = null,
				@L2300_hi03_BE_value_info_amt  = null,
				@L2300_hi04_BE_value_info_amt  = null,
				@L2300_hi05_BE_value_info_amt  = null,
				@L2300_hi06_BE_value_info_amt  = null,
				@L2300_hi07_BE_value_info_amt  = null,
				@L2300_hi08_BE_value_info_amt  = null,
				@L2300_hi09_BE_value_info_amt  = null,
				@L2300_hi10_BE_value_info_amt  = null,
				@L2300_hi11_BE_value_info_amt  = null,
				@L2300_hi12_BE_value_info_amt  = null,
	
				@L2300_hi01_BG_cond_info  = null,
				@L2300_hi02_BG_cond_info  = null,
				@L2300_hi03_BG_cond_info  = null,
				@L2300_hi04_BG_cond_info  = null,
				@L2300_hi05_BG_cond_info  = null,
				@L2300_hi06_BG_cond_info  = null,
				@L2300_hi07_BG_cond_info  = null,
				@L2300_hi08_BG_cond_info  = null,
				@L2300_hi09_BG_cond_info  = null,
				@L2300_hi10_BG_cond_info  = null,
				@L2300_hi11_BG_cond_info  = null,
				@L2300_hi12_BG_cond_info  = null,
	
				@L2300_hi01_TC_treat_code_info  = null,
				@L2300_hi02_TC_treat_code_info  = null,
				@L2300_hi03_TC_treat_code_info  = null,
				@L2300_hi04_TC_treat_code_info  = null,
				@L2300_hi05_TC_treat_code_info  = null,
				@L2300_hi06_TC_treat_code_info  = null,
				@L2300_hi07_TC_treat_code_info  = null,
				@L2300_hi08_TC_treat_code_info  = null,
				@L2300_hi09_TC_treat_code_info  = null,
				@L2300_hi10_TC_treat_code_info  = null,
				@L2300_hi11_TC_treat_code_info  = null,
				@L2300_hi12_TC_treat_code_info  = null,
				
				@L2300_qty02_CA_claim_qty = null, 
				@L2300_qty02_CD_claim_qty = null, 
				@L2300_qty02_LA_claim_qty = null, 
				@L2300_qty02_NA_claim_qty = null, 
				
				
				@L2310A_nm101_entity_id_code = null, 
				@L2310A_nm102_entity_type_qual = null, 
				@L2310A_nm103_attending_prov_last_nm = null, 
				@L2310A_nm104_attending_prov_first_nm = null,
				@L2310A_nm105_attending_prov_middle_nm = null,
				@L2310A_nm107_attending_prov_suffix = null, 
				@L2310A_nm108_id_code_qual = null, 
				@L2310A_nm109_attending_prov_id = null, 
				
				@L2310A_prv01_provider_code = null, 
				@L2310A_prv02_ref_id_qual = null, 
				@L2310A_prv03_taxonomy_code = null, 
				
				@L2310A_ref02_1C_attending_prov_id = null, 
				@L2310A_ref02_1D_attending_prov_id = null, 
				@L2310A_ref02_1G_attending_prov_id = null, 
				@L2310A_ref02_EI_attending_prov_id = null, 
				@L2310A_ref02_SY_attending_prov_id = null, 
				@L2310A_ref02_FH_attending_prov_id = null, 
				
				@L2310B_nm102_entity_type_qual = null, 
				@L2310B_nm103_operating_prov_last_nm = null, 
				@L2310B_nm104_operating_prov_first_nm = null,
				@L2310B_nm105_operating_prov_middle_nm = null,
				@L2310B_nm107_operating_prov_suffix = null, 
				@L2310B_nm108_id_code_qual = null, 
				@L2310B_nm109_operating_prov_id = null, 
				
				@L2310B_ref02_1C_operating_prov_id = null, 
				@L2310B_ref02_1D_operating_prov_id = null, 
				@L2310B_ref02_1G_operating_prov_id = null, 
				@L2310B_ref02_EI_operating_prov_id = null, 
				@L2310B_ref02_SY_operating_prov_id = null, 
				@L2310B_ref02_FH_operating_prov_id = null, 
				
				---check on this other provider may be wrong in the HIPAA guide
				@L2310C_nm102_entity_type_qual = null, 
				@L2310C_nm103_other_prov_last_nm = null, 
				@L2310C_nm104_other_prov_first_nm = null,
				@L2310C_nm105_other_prov_middle_nm = null,
				@L2310C_nm107_other_prov_suffix = null, 
				@L2310C_nm108_id_code_qual = null, 
				@L2310C_nm109_other_prov_id = null, 
				
				@L2310C_ref02_1C_other_prov_id = null, 
				@L2310C_ref02_1D_other_prov_id = null, 
				@L2310C_ref02_1G_other_prov_id = null, 
				@L2310C_ref02_EI_other_prov_id = null, 
				@L2310C_ref02_SY_other_prov_id = null, 
				@L2310C_ref02_FH_other_prov_id = null, 
				
				@L2310E_nm101_entity_id_code = null, 
				@L2310E_nm102_entity_type_qual = null, 
				@L2310E_nm103_service_facility_last_nm = null, 
				@L2310E_nm108_id_code_qual = null, 
				@L2310E_nm109_service_facility_id = null, 
				
				@L2310E_n301_service_facility_address1 = null,
				@L2310E_n302_service_facility_address2 = null,
				
				@L2310E_n401_service_facility_city = null, 
				@L2310E_n402_service_facility_state = null, 
				@L2310E_n403_service_facility_zip = null, 
				@L2310E_n404_service_facility_country = null, 
				
				@L2310E_ref02_1C_service_facility_id = null, 
				@L2310E_ref02_1D_service_facility_id = null, 
				@L2310E_ref02_1G_service_facility_id = null, 
				@L2310E_ref02_G2_service_facility_id = null, 
	
				@Other2320SBRLoopCount = 0,
				
				@L2320_1_sbr01_payer_resp_seq_code = null,
				@L2320_1_sbr02_ind_relationship_code = null,
				@L2320_1_sbr03_insured_grp_policy_num = null,
				@L2320_1_sbr04_insured_grp_nm = null,
				@L2320_1_sbr09_claim_file_ind_code = null,
				@L2320_1_cas01_adjustment_group_code = null,
				@L2320_1_cas02_adjustment_reason_code = null,
				@L2320_1_cas03_adjustment_amt = null,
				@L2320_1_cas04_adjustment_qty = null,
				@L2320_1_cas05_adjustment_reason_code = null,
				@L2320_1_cas06_adjustment_amt = null,
				@L2320_1_cas07_adjustment_qty = null,
				@L2320_1_cas08_adjustment_reason_code = null,
				@L2320_1_cas09_adjustment_amt = null,
				@L2320_1_cas10_adjustment_qty = null,
				@L2320_1_amt02_C4_payer_prior_pmt_amt = null,
				@L2320_1_amt02_B6_cob_allowed_amt = null,
				@L2320_1_amt02_T3_cob_submitted_amt = null,
				@L2320_1_amt02_ZZ_drg_outlier_amt = null,
				@L2320_1_amt02_N1_cob_medicare_paid_amt = null,
				@L2320_1_amt02_KF_medicare_paid_100_amt = null,
				@L2320_1_amt02_PG_medicare_paid_80_amt = null,
				@L2320_1_amt02_AA_cob_medicare_a_trust_pd_amt = null,
				@L2320_1_amt02_B1_cob_medicare_b_trust_pd_amt = null,
				@L2320_1_amt02_A8_cob_non_cvd_amt = null,
				@L2320_1_amt02_YT_cob_denied_amt = null,
				@L2320_1_dmg02_other_subscriber_dob = null,
				@L2320_1_dmg03_other_subscriber_gender = null,
				@L2320_1_oi03_other_ins_benefit_assign_ind = null,
				@L2320_1_oi06_other_ins_release_of_info_code = null,
				@L2330A_1_nm101_entity_id_code = null,
				@L2330A_1_nm102_entity_type_qual = null,
				@L2330A_1_nm103_other_subscriber_last_name = null,
				@L2330A_1_nm104_other_subscriber_first_name = null,
				@L2330A_1_nm105_other_subscriber_middle_name = null,
				@L2330A_1_nm107_other_subscriber_name_suffix = null,
				@L2330A_1_nm108_other_subscriber_id_code_qual = null,
				@L2330A_1_nm109_other_subscriber_id = null,
				@L2330B_1_nm101_entity_id_code = null,
				@L2330B_1_nm102_entity_type_qual = null,
				@L2330B_1_nm103_other_payer_nm = null,
				@L2330B_1_nm108_id_code_qual = null,
				@L2330B_1_nm109_other_payer_id = null,
				@L2330B_1_dtp03_573_date_claim_paid = null,
				@L2330B_1_ref02_2U_other_payer_secondary_id = null,
				@L2330B_1_ref02_F8_other_payer_secondary_id = null,
				@L2330B_1_ref02_FY_other_payer_secondary_id = null,
				@L2330B_1_ref02_NF_other_payer_secondary_id = null,
				@L2330B_1_ref02_TJ_other_payer_secondary_id = null,
				@L2330B_1_ref02_9F_other_payer_auth_num = null,
				@L2330B_1_ref02_G1_other_payer_auth_num = null,
	
				@L2320_2_sbr01_payer_resp_seq_code = null,
				@L2320_2_sbr02_ind_relationship_code = null,
				@L2320_2_sbr03_insured_grp_policy_num = null,
				@L2320_2_sbr04_insured_grp_nm = null,
				@L2320_2_sbr09_claim_file_ind_code = null,
				@L2320_2_cas01_adjustment_group_code = null,
				@L2320_2_cas02_adjustment_reason_code = null,
				@L2320_2_cas03_adjustment_amt = null,
				@L2320_2_cas04_adjustment_qty = null,
				@L2320_2_cas05_adjustment_reason_code = null,
				@L2320_2_cas06_adjustment_amt = null,
				@L2320_2_cas07_adjustment_qty = null,
				@L2320_2_cas08_adjustment_reason_code = null,
				@L2320_2_cas09_adjustment_amt = null,
				@L2320_2_cas10_adjustment_qty = null,
				@L2320_2_amt02_C4_payer_prior_pmt_amt = null,
				@L2320_2_amt02_B6_cob_allowed_amt = null,
				@L2320_2_amt02_T3_cob_submitted_amt = null,
				@L2320_2_amt02_ZZ_drg_outlier_amt = null,
				@L2320_2_amt02_N1_cob_medicare_paid_amt = null,
				@L2320_2_amt02_KF_medicare_paid_100_amt = null,
				@L2320_2_amt02_PG_medicare_paid_80_amt = null,
				@L2320_2_amt02_AA_cob_medicare_a_trust_pd_amt = null,
				@L2320_2_amt02_B1_cob_medicare_b_trust_pd_amt = null,
				@L2320_2_amt02_A8_cob_non_cvd_amt = null,
				@L2320_2_amt02_YT_cob_denied_amt = null,
				@L2320_2_dmg02_other_subscriber_dob = null,
				@L2320_2_dmg03_other_subscriber_gender = null,
				@L2320_2_oi03_other_ins_benefit_assign_ind = null,
				@L2320_2_oi06_other_ins_release_of_info_code = null,
				@L2330A_2_nm101_entity_id_code = null,
				@L2330A_2_nm102_entity_type_qual = null,
				@L2330A_2_nm103_other_subscriber_last_name = null,
				@L2330A_2_nm104_other_subscriber_first_name = null,
				@L2330A_2_nm105_other_subscriber_middle_name = null,
				@L2330A_2_nm107_other_subscriber_name_suffix = null,
				@L2330A_2_nm108_other_subscriber_id_code_qual = null,
				@L2330A_2_nm109_other_subscriber_id = null,
				@L2330B_2_nm101_entity_id_code = null,
				@L2330B_2_nm102_entity_type_qual = null,
				@L2330B_2_nm103_other_payer_nm = null,
				@L2330B_2_nm108_id_code_qual = null,
				@L2330B_2_nm109_other_payer_id = null,
				@L2330B_2_dtp03_573_date_claim_paid = null,
				@L2330B_2_ref02_2U_other_payer_secondary_id = null,
				@L2330B_2_ref02_F8_other_payer_secondary_id = null,
				@L2330B_2_ref02_FY_other_payer_secondary_id = null,
				@L2330B_2_ref02_NF_other_payer_secondary_id = null,
				@L2330B_2_ref02_TJ_other_payer_secondary_id = null,
				@L2330B_2_ref02_9F_other_payer_auth_num = null,
				@L2330B_2_ref02_G1_other_payer_auth_num = null,
	
				@L2320_3_sbr01_payer_resp_seq_code = null,
				@L2320_3_sbr02_ind_relationship_code = null,
				@L2320_3_sbr03_insured_grp_policy_num = null,
				@L2320_3_sbr04_insured_grp_nm = null,
				@L2320_3_sbr09_claim_file_ind_code = null,
				@L2320_3_cas01_adjustment_group_code = null,
				@L2320_3_cas02_adjustment_reason_code = null,
				@L2320_3_cas03_adjustment_amt = null,
				@L2320_3_cas04_adjustment_qty = null,
				@L2320_3_cas05_adjustment_reason_code = null,
				@L2320_3_cas06_adjustment_amt = null,
				@L2320_3_cas07_adjustment_qty = null,
				@L2320_3_cas08_adjustment_reason_code = null,
				@L2320_3_cas09_adjustment_amt = null,
				@L2320_3_cas10_adjustment_qty = null,
				@L2320_3_amt02_C4_payer_prior_pmt_amt = null,
				@L2320_3_amt02_B6_cob_allowed_amt = null,
				@L2320_3_amt02_T3_cob_submitted_amt = null,
				@L2320_3_amt02_ZZ_drg_outlier_amt = null,
				@L2320_3_amt02_N1_cob_medicare_paid_amt = null,
				@L2320_3_amt02_KF_medicare_paid_100_amt = null,
				@L2320_3_amt02_PG_medicare_paid_80_amt = null,
				@L2320_3_amt02_AA_cob_medicare_a_trust_pd_amt = null,
				@L2320_3_amt02_B1_cob_medicare_b_trust_pd_amt = null,
				@L2320_3_amt02_A8_cob_non_cvd_amt = null,
				@L2320_3_amt02_YT_cob_denied_amt = null,
				@L2320_3_dmg02_other_subscriber_dob = null,
				@L2320_3_dmg03_other_subscriber_gender = null,
				@L2320_3_oi03_other_ins_benefit_assign_ind = null,
				@L2320_3_oi06_other_ins_release_of_info_code = null,
				@L2330A_3_nm101_entity_id_code = null,
				@L2330A_3_nm102_entity_type_qual = null,
				@L2330A_3_nm103_other_subscriber_last_name = null,
				@L2330A_3_nm104_other_subscriber_first_name = null,	
				@L2330A_3_nm105_other_subscriber_middle_name = null,
				@L2330A_3_nm107_other_subscriber_name_suffix = null,
				@L2330A_3_nm108_other_subscriber_id_code_qual = null,
				@L2330A_3_nm109_other_subscriber_id = null,
				@L2330B_3_nm101_entity_id_code = null,
				@L2330B_3_nm102_entity_type_qual = null,
				@L2330B_3_nm103_other_payer_nm = null,
				@L2330B_3_nm108_id_code_qual = null,
				@L2330B_3_nm109_other_payer_id = null,
				@L2330B_3_dtp03_573_date_claim_paid = null,
				@L2330B_3_ref02_2U_other_payer_secondary_id = null,
				@L2330B_3_ref02_F8_other_payer_secondary_id = null,
				@L2330B_3_ref02_FY_other_payer_secondary_id = null,
				@L2330B_3_ref02_NF_other_payer_secondary_id = null,
				@L2330B_3_ref02_TJ_other_payer_secondary_id = null,
				@L2330B_3_ref02_9F_other_payer_auth_num = null,
				@L2330B_3_ref02_G1_other_payer_auth_num = null,
				
				@L2400_lx01_assigned_num = null,
				@L2400_sv201_rev_code = null,
				@L2400_sv202_proc_code_qual = null, 
				@L2400_sv202_proc_code = null,
				@L2400_sv202_proc_mod1 = null, 
				@L2400_sv202_proc_mod2 = null, 
				@L2400_sv202_proc_mod3 = null, 
				@L2400_sv202_proc_mod4 = null, 
				@L2400_sv203_line_charge = null,
				@L2400_sv204_measurement_code = null, 
				@L2400_sv205_service_unit_count = null, 
				@L2400_sv206_service_line_rate = null, 
				@L2400_sv207_denied_amt = null,
				
				@L2400_dtp02_472_from_service_date = null, 
				@L2400_dtp02_472_to_service_date = null, 
				
				@L2400_dtp02_866_format_qual = null, 
				@L2400_dtp02_866_assess_date = null, 
				
				@L2410_1_lin03_N4_ndc = NULL,
				
				@L2420A_nm102_entity_type_qual = null, 
				@L2420A_nm103_attending_physician_last_nm = null, 
				@L2420A_nm104_attending_physician_first_nm = null,
				@L2420A_nm105_attending_physician_middle_nm = null,
				@L2420A_nm107_attending_physician_suffix = null, 
				@L2420A_nm108_id_code_qual = null, 
				@L2420A_nm109_attending_physician_id = null, 
				
				@L2420A_ref02_1C_attending_prov_id = null, 
				@L2420A_ref02_1D_attending_prov_id = null, 
				@L2420A_ref02_1G_attending_prov_id = null, 
				@L2420A_ref02_EI_attending_prov_id = null, 
				@L2420A_ref02_SY_attending_prov_id = null, 
				@L2420A_ref02_FH_attending_prov_id = null, 
				
				@L2420B_nm102_entity_type_qual = null, 
				@L2420B_nm103_operating_prov_last_nm = null, 
				@L2420B_nm104_operating_prov_first_nm = null,
				@L2420B_nm105_operating_prov_middle_nm = null,
				@L2420B_nm107_operating_prov_suffix = null, 
				@L2420B_nm108_id_code_qual = null, 
				@L2420B_nm109_operating_prov_id = null, 
				
				@L2420B_ref02_1C_operating_prov_id = null, 
				@L2420B_ref02_1D_operating_prov_id = null, 
				@L2420B_ref02_1G_operating_prov_id = null, 
				@L2420B_ref02_EI_operating_prov_id = null, 
				@L2420B_ref02_SY_operating_prov_id = null, 
				@L2420B_ref02_FH_operating_prov_id = null, 
				
				@L2420C_nm102_entity_type_qual = null, 
				@L2420C_nm103_other_prov_last_nm = null, 
				@L2420C_nm104_other_prov_first_nm = null,
				@L2420C_nm105_other_prov_middle_nm = null,
				@L2420C_nm107_other_prov_suffix = null, 
				@L2420C_nm108_id_code_qual = null, 
				@L2420C_nm109_other_prov_id = null, 	
				
				@L2420C_ref02_1C_other_prov_id = null, 
				@L2420C_ref02_1D_other_prov_id = null, 
				@L2420C_ref02_1G_other_prov_id = null, 
				@L2420C_ref02_G2_other_prov_id = null, 
				@L2420C_ref02_EI_other_prov_id = null, 
				@L2420C_ref02_SY_other_prov_id = null, 
				@L2420C_ref02_FH_other_prov_id = null, 
				
				@L2430_svd01_payer_id = null, 
				@L2430_svd02_service_line_paid = null,
				@L2430_svd03_proc_code_qual = null, 
				@L2430_svd03_proc_code = null,
				@L2430_svd03_proc_mod1 = null, 
				@L2430_svd03_proc_mod2 = null, 
				@L2430_svd03_proc_mod3 = null, 
				@L2430_svd03_proc_mod4 = null, 
				@L2430_svd04_rev_code = null,
				@L2430_svd05_adj_qty = null, 
				@L2430_svd06_bundled_line_num = null,
				
				@L2430_cas01_adjustment_group_code = null, 
				@L2430_cas02_adjustment_reason_code = null, 
				@L2430_cas03_adjustment_amt = null,
				@L2430_cas04_adjustment_qty = null, 
				@L2430_cas05_adjustment_reason_code = null, 
				@L2430_cas06_adjustment_amt = null,
				@L2430_cas07_adjustment_qty = null, 
				@L2430_cas08_adjustment_reason_code = null, 
				@L2430_cas09_adjustment_amt = null,
				@L2430_cas10_adjustment_qty = null, 
				
				@L2430_dtp03_573_service_adjudication_date = null
		end
		-- END OF CHECK FOR INSERT

		-- Billing/Pay-To Provider Loop
		if ( RTrim(@col001) = 'HL' AND LTRIM(RTRIM(@Col004)) = '20')
		begin
			select	@curLoop = '2000A',
				@L2000A_hl01_hierarchical_id_num = LTRIM(RTRIM(@Col002)),
				@L2000A_hl03_hierarchical_level_code = LTRIM(RTRIM(@Col003)),
				@L2000A_hl04_hierarchical_child_code = LTRIM(RTRIM(@Col004))
		end

		if ( RTrim(@col001) = 'HL' AND LTRIM(RTRIM(@Col004)) = '22' )
		begin
			select	@curLoop = '2000B',
				@L2000B_hl01_hierarchical_id_num = LTRIM(RTRIM(@Col002)),
				@L2000B_hl02_hierarchical_parent_id_num = LTRIM(RTRIM(@Col003)),
				@L2000B_hl03_hierarchical_level_code = LTRIM(RTRIM(@Col004)),
				@L2000B_hl04_hierarchical_child_code = LTRIM(RTRIM(@Col005))
		end

		if ( RTrim(@col001) = 'HL' AND LTRIM(RTRIM(@Col004)) = '23')
		begin
			select	@curLoop = '2000C',
				@L2000C_hl01_hierarchical_id_num = LTRIM(RTRIM(@Col002)),
				@L2000C_hl02_hierarchical_parent_id_num = LTRIM(RTRIM(@Col003)),
				@L2000C_hl03_hierarchical_level_code = LTRIM(RTRIM(@Col004)),
				@L2000C_hl04_hierarchical_child_code = LTRIM(RTRIM(@Col005))
		end
	end
	-- END OF THE HL / CLM segment check

	-- Claim Header Segment
	if ( RTrim(@col001) = 'CLM' )
	begin
		select	@curLoop = '2300',
		-- set the new claim and ICN values
			@prev_L2300_clm01_pt_acct_num = @L2300_clm01_pt_acct_num,
			@L2300_clm01_pt_acct_num = LTRIM(RTRIM(@Col002)),
			@L2300_clm02_total_claim_chg_amt = CAST(LTRIM(RTRIM(@Col003)) as money),
			@L2300_clm05_facility_type_code = dbo.fn_ListGetAt(LTRIM(RTRIM(@Col006)), 1, @isa16_component_element_seperator),
			@L2300_clm05_facility_code_qual = dbo.fn_ListGetAt(LTRIM(RTRIM(@Col006)), 2, @isa16_component_element_seperator),
			@L2300_clm05_claim_freq_code = dbo.fn_ListGetAt(LTRIM(RTRIM(@Col006)), 3, @isa16_component_element_seperator),
			@L2300_clm06_provider_signature_ind = LTRIM(RTRIM(@Col007)),
			@L2300_clm07_medicare_assign_code = LTRIM(RTRIM(@Col008)),
			@L2300_clm08_benefit_assign_ind = LTRIM(RTRIM(@Col009)),
			@L2300_clm09_release_of_info_code = LTRIM(RTRIM(@Col010)),
			@L2300_clm18_explan_benefits_ind = LTRIM(RTRIM(@Col019)),
			@L2300_clm20_delay_reason_code = LTRIM(RTRIM(@Col021))
	end


	if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '096' AND @curloop = '2300')
	begin
		set @curloop = '2300'
		set @L2300_dtp03_096_discharge_hour = LTRIM(RTRIM(@Col004))
	end

	-- For the DTP segment where the DTP03 value is a range, split it into two fields
	if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '434' AND @curloop = '2300')
	begin
		set @curloop = '2300'
		if (RTrim(@col003) = 'D8')
		begin
			-- if not a range, set both fields to the same value
			set @L2300_dtp03_434_begin_statement_date = LTRIM(RTRIM(@Col004))
			set @L2300_dtp03_434_end_statement_date = LTRIM(RTRIM(@Col004))
		end
		else if (RTrim(@col003) = 'RD8')
		begin
			-- if a range, split it into two fields
			set @L2300_dtp03_434_begin_statement_date = Left(LTrim(RTrim(@col004)), 8)
			set @L2300_dtp03_434_end_statement_date = Right(LTrim(RTrim(@col004)), 8)
		end
	end

	if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '435' AND @curloop = '2300')
	begin
		set @curloop = '2300'
		set @L2300_dtp03_435_admission_date = LTRIM(RTRIM(@Col004))
	end

	if ( RTrim(@col001) = 'CL1' AND @curloop = '2300')
	begin
		select	@curloop = '2300',
			@L2300_cl101_admit_type_code = LTRIM(RTRIM(@Col002)),
			@L2300_cl102_admit_source_code = LTRIM(RTRIM(@Col003)),
			@L2300_cl103_patient_status_code = LTRIM(RTRIM(@Col004))
	end
	

	if ( RTrim(@col001) = 'PWK' AND @CurLoop = '2300' )
	begin
		select	@L2300_pwk01_attachment_type_code = LTRIM(RTRIM(@Col002)),
			@L2300_pwk02_attachment_trans_code = LTRIM(RTRIM(@Col003)),
			@L2300_pwk06_attachment_control_num = LTRIM(RTRIM(@Col007))
	end

	if ( RTrim(@col001) = 'AMT' AND @CurLoop = '2300' AND RTrim(@col002) = 'F5' )
	begin
		set @L2300_amt02_patient_paid_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
	end

	if ( RTrim(@col001) = 'AMT' AND @CurLoop = '2300' AND RTrim(@col002) = 'F3' )
	begin
		set @L2300_amt02_patient_resp_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
	end

	if ( RTrim(@col001) = 'AMT' AND @CurLoop = '2300' AND RTrim(@col002) = 'NE' )
	begin
		set @L2300_amt02_total_purchased_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
	end


	if ( RTrim(@col001) = 'REF' AND @CurLoop = '2300' AND RTrim(@col002) = '9C' )
	begin
		set @L2300_ref02_9C_adj_repriced_claim_num = LTRIM(RTRIM(@Col003))
	end

	if ( RTrim(@col001) = 'REF' AND @CurLoop = '2300' AND RTrim(@col002) = '9A' )
	begin
		set @L2300_ref02_9A_repriced_claim_num = LTRIM(RTRIM(@Col003))
	end

	if ( RTrim(@col001) = 'REF' AND @CurLoop = '2300' AND RTrim(@col002) = 'D9' )
	begin
		set @L2300_ref02_D9_claim_id_clearing_house = LTRIM(RTRIM(@Col003))
	end

	if ( RTrim(@col001) = 'REF' AND @CurLoop = '2300' AND RTrim(@col002) = 'DD' )
	begin
		set @L2300_ref02_DD_domcument_id = LTRIM(RTRIM(@Col003))
	end

	if ( RTrim(@col001) = 'REF' AND @CurLoop = '2300' AND RTrim(@col002) = 'F8' )
	begin
		set @L2300_ref02_F8_original_ref_num = LTRIM(RTRIM(@Col003))
	end

	if ( RTrim(@col001) = 'REF' AND @CurLoop = '2300' AND RTrim(@col002) = '9F' )
	begin
		set @L2300_ref02_9F_referral_num = LTRIM(RTRIM(@Col003))
	end
		
	if ( RTrim(@col001) = 'REF' AND @CurLoop = '2300' AND RTrim(@col002) = 'G1' )
	begin
		set @L2300_ref02_G1_prior_auth_num = LTRIM(RTRIM(@Col003))
	end
		
	if ( RTrim(@col001) = 'REF' AND @CurLoop = '2300' AND RTrim(@col002) = 'EA' )
	begin
		set @L2300_ref02_EA_medical_record_num = LTRIM(RTRIM(@Col003))
	end
			
	if ( RTrim(@col001) = 'K3' AND @CurLoop = '2300')
	begin
		set @L2300_k301_fixed_format_info = LTRIM(RTRIM(@Col002))
	end

	if ( RTrim(@col001) = 'NTE' AND @CurLoop = '2300')
	begin
		set @L2300_nte01_note_ref_code = LTRIM(RTRIM(@Col002))
		set @L2300_nte02_claim_note_text = LTRIM(RTRIM(@Col003))
	end

	if ( RTrim(@col001) = 'HI' AND Left(RTrim(@col002), 2) = 'BK' AND  @CurLoop = '2300')
	begin
		set @L2300_hi01_BK_diag_admit_ecode = dbo.fn_ListGetAt(@col002, 2, @isa16_component_element_seperator)
		if ( dbo.fn_ListGetAt(@col003, 1, @isa16_component_element_seperator) = 'ZZ')
		begin
			set @L2300_hi02_ZZ_diag_admit_ecode = dbo.fn_ListGetAt(@col003, 2, @isa16_component_element_seperator)
		end
		if ( dbo.fn_ListGetAt(@col003, 1, @isa16_component_element_seperator) = 'BJ')
		begin
			set @L2300_hi02_BJ_diag_admit_ecode = dbo.fn_ListGetAt(@col003, 2, @isa16_component_element_seperator)
		end
		set @L2300_hi03_BN_diag_admit_ecode = dbo.fn_ListGetAt(@col004, 2, @isa16_component_element_seperator)
	end
	
	if ( RTrim(@col001) = 'HI' AND  Left(RTrim(@col002), 2) = 'DR' AND  @CurLoop = '2300')
	begin
		set @L2300_hi01_DR_diag_drg = dbo.fn_ListGetAt(@col002, 2, @isa16_component_element_seperator)
	end
	
	if ( RTrim(@col001) = 'HI' AND  Left(RTrim(@col002), 2) = 'BF' AND  @CurLoop = '2300')
	begin
		select	@L2300_hi01_BF_diag_code = dbo.fn_ListGetAt(@col002, 2, @isa16_component_element_seperator),
			@L2300_hi02_BF_diag_code = dbo.fn_ListGetAt(@col003, 2, @isa16_component_element_seperator),
			@L2300_hi03_BF_diag_code = dbo.fn_ListGetAt(@col004, 2, @isa16_component_element_seperator),
			@L2300_hi04_BF_diag_code = dbo.fn_ListGetAt(@col005, 2, @isa16_component_element_seperator),
			@L2300_hi05_BF_diag_code = dbo.fn_ListGetAt(@col006, 2, @isa16_component_element_seperator),
			@L2300_hi06_BF_diag_code = dbo.fn_ListGetAt(@col007, 2, @isa16_component_element_seperator),
			@L2300_hi07_BF_diag_code = dbo.fn_ListGetAt(@col008, 2, @isa16_component_element_seperator),
			@L2300_hi08_BF_diag_code = dbo.fn_ListGetAt(@col009, 2, @isa16_component_element_seperator),
			@L2300_hi09_BF_diag_code = dbo.fn_ListGetAt(@col010, 2, @isa16_component_element_seperator),
			@L2300_hi10_BF_diag_code = dbo.fn_ListGetAt(@col011, 2, @isa16_component_element_seperator),
			@L2300_hi11_BF_diag_code = dbo.fn_ListGetAt(@col012, 2, @isa16_component_element_seperator),
			@L2300_hi12_BF_diag_code = dbo.fn_ListGetAt(@col013, 2, @isa16_component_element_seperator)
	end

	if ( RTrim(@col001) = 'HI' AND Left(RTrim(@col002), 2) = 'BR' AND  @CurLoop = '2300')
	begin
		set @L2300_hi01_BR_princ_proc_info = dbo.fn_ListGetAt(@col002, 2, @isa16_component_element_seperator)
		set @L2300_hi01_BR_princ_proc_info_date = dbo.fn_ListGetAt(@col002, 4, @isa16_component_element_seperator)
	end
		
	if ( RTrim(@col001) = 'HI' AND Left(RTrim(@col002), 2) = 'BQ' AND  @CurLoop = '2300')
	begin
		select	@L2300_hi01_BQ_other_proc_info = dbo.fn_ListGetAt(@col002, 2, @isa16_component_element_seperator),
			@L2300_hi01_BQ_other_proc_info_date = dbo.fn_ListGetAt(@col002, 4, @isa16_component_element_seperator),
			@L2300_hi02_BQ_other_proc_info = dbo.fn_ListGetAt(@col003, 2, @isa16_component_element_seperator),
			@L2300_hi02_BQ_other_proc_info_date = dbo.fn_ListGetAt(@col003, 4, @isa16_component_element_seperator),
			@L2300_hi03_BQ_other_proc_info = dbo.fn_ListGetAt(@col004, 2, @isa16_component_element_seperator),
			@L2300_hi03_BQ_other_proc_info_date = dbo.fn_ListGetAt(@col004, 4, @isa16_component_element_seperator),
			@L2300_hi04_BQ_other_proc_info = dbo.fn_ListGetAt(@col005, 2, @isa16_component_element_seperator),
			@L2300_hi04_BQ_other_proc_info_date = dbo.fn_ListGetAt(@col005, 4, @isa16_component_element_seperator),
			@L2300_hi05_BQ_other_proc_info = dbo.fn_ListGetAt(@col006, 2, @isa16_component_element_seperator),
			@L2300_hi05_BQ_other_proc_info_date = dbo.fn_ListGetAt(@col006, 4, @isa16_component_element_seperator),
			@L2300_hi06_BQ_other_proc_info = dbo.fn_ListGetAt(@col007, 2, @isa16_component_element_seperator),
			@L2300_hi06_BQ_other_proc_info_date = dbo.fn_ListGetAt(@col007, 4, @isa16_component_element_seperator),
			@L2300_hi07_BQ_other_proc_info = dbo.fn_ListGetAt(@col008, 2, @isa16_component_element_seperator),	
			@L2300_hi07_BQ_other_proc_info_date = dbo.fn_ListGetAt(@col008, 4, @isa16_component_element_seperator),
			@L2300_hi08_BQ_other_proc_info = dbo.fn_ListGetAt(@col009, 2, @isa16_component_element_seperator),
			@L2300_hi08_BQ_other_proc_info_date = dbo.fn_ListGetAt(@col009, 4, @isa16_component_element_seperator),
			@L2300_hi09_BQ_other_proc_info = dbo.fn_ListGetAt(@col010, 2, @isa16_component_element_seperator),
			@L2300_hi09_BQ_other_proc_info_date = dbo.fn_ListGetAt(@col010, 4, @isa16_component_element_seperator),
			@L2300_hi10_BQ_other_proc_info = dbo.fn_ListGetAt(@col011, 2, @isa16_component_element_seperator),
			@L2300_hi10_BQ_other_proc_info_date = dbo.fn_ListGetAt(@col011, 4, @isa16_component_element_seperator),
			@L2300_hi11_BQ_other_proc_info = dbo.fn_ListGetAt(@col012, 2, @isa16_component_element_seperator),
			@L2300_hi11_BQ_other_proc_info_date = dbo.fn_ListGetAt(@col012, 4, @isa16_component_element_seperator),
			@L2300_hi12_BQ_other_proc_info = dbo.fn_ListGetAt(@col013, 2, @isa16_component_element_seperator),
			@L2300_hi12_BQ_other_proc_info_date = dbo.fn_ListGetAt(@col013, 4, @isa16_component_element_seperator)
	end
	
	if ( RTrim(@col001) = 'HI' AND Left(RTrim(@col002), 2) = 'BI' AND  @CurLoop = '2300')
	begin
	
		select	@L2300_hi01_BI_occur_span = dbo.fn_ListGetAt(@col002, 2, @isa16_component_element_seperator),
			@L2300_hi01_BI_occur_span_date = dbo.fn_ListGetAt(@col002, 4, @isa16_component_element_seperator),
			@L2300_hi02_BI_occur_span = dbo.fn_ListGetAt(@col003, 2, @isa16_component_element_seperator),
			@L2300_hi02_BI_occur_span_date = dbo.fn_ListGetAt(@col003, 4, @isa16_component_element_seperator),
			@L2300_hi03_BI_occur_span = dbo.fn_ListGetAt(@col004, 2, @isa16_component_element_seperator),
			@L2300_hi03_BI_occur_span_date = dbo.fn_ListGetAt(@col004, 4, @isa16_component_element_seperator),
			@L2300_hi04_BI_occur_span = dbo.fn_ListGetAt(@col005, 2, @isa16_component_element_seperator),
			@L2300_hi04_BI_occur_span_date = dbo.fn_ListGetAt(@col005, 4, @isa16_component_element_seperator),
			@L2300_hi05_BI_occur_span = dbo.fn_ListGetAt(@col006, 2, @isa16_component_element_seperator),
			@L2300_hi05_BI_occur_span_date = dbo.fn_ListGetAt(@col006, 4, @isa16_component_element_seperator),
			@L2300_hi06_BI_occur_span = dbo.fn_ListGetAt(@col007, 2, @isa16_component_element_seperator),
			@L2300_hi06_BI_occur_span_date = dbo.fn_ListGetAt(@col007, 4, @isa16_component_element_seperator),
			@L2300_hi07_BI_occur_span = dbo.fn_ListGetAt(@col008, 2, @isa16_component_element_seperator),
			@L2300_hi07_BI_occur_span_date = dbo.fn_ListGetAt(@col008, 4, @isa16_component_element_seperator),
			@L2300_hi08_BI_occur_span = dbo.fn_ListGetAt(@col009, 2, @isa16_component_element_seperator),
			@L2300_hi08_BI_occur_span_date = dbo.fn_ListGetAt(@col009, 4, @isa16_component_element_seperator),
			@L2300_hi09_BI_occur_span = dbo.fn_ListGetAt(@col010, 2, @isa16_component_element_seperator),
			@L2300_hi09_BI_occur_span_date = dbo.fn_ListGetAt(@col010, 4, @isa16_component_element_seperator),
			@L2300_hi10_BI_occur_span = dbo.fn_ListGetAt(@col011, 2, @isa16_component_element_seperator),
			@L2300_hi10_BI_occur_span_date = dbo.fn_ListGetAt(@col011, 4, @isa16_component_element_seperator),
			@L2300_hi11_BI_occur_span = dbo.fn_ListGetAt(@col012, 2, @isa16_component_element_seperator),
			@L2300_hi11_BI_occur_span_date = dbo.fn_ListGetAt(@col012, 4, @isa16_component_element_seperator),
			@L2300_hi12_BI_occur_span = dbo.fn_ListGetAt(@col013, 2, @isa16_component_element_seperator),
			@L2300_hi12_BI_occur_span_date = dbo.fn_ListGetAt(@col013, 4, @isa16_component_element_seperator)
	end
				
	if ( RTrim(@col001) = 'HI' AND Left(RTrim(@col002), 2) = 'BH' AND  @CurLoop = '2300')
	begin
		select	@L2300_hi01_BH_occur_info = dbo.fn_ListGetAt(@col002, 2, @isa16_component_element_seperator),
			@L2300_hi01_BH_occur_info_date = dbo.fn_ListGetAt(@col002, 4, @isa16_component_element_seperator),
			@L2300_hi02_BH_occur_info = dbo.fn_ListGetAt(@col003, 2, @isa16_component_element_seperator),
			@L2300_hi02_BH_occur_info_date = dbo.fn_ListGetAt(@col003, 4, @isa16_component_element_seperator),
			@L2300_hi03_BH_occur_info = dbo.fn_ListGetAt(@col004, 2, @isa16_component_element_seperator),
			@L2300_hi03_BH_occur_info_date = dbo.fn_ListGetAt(@col004, 4, @isa16_component_element_seperator),
			@L2300_hi04_BH_occur_info = dbo.fn_ListGetAt(@col005, 2, @isa16_component_element_seperator),
			@L2300_hi04_BH_occur_info_date = dbo.fn_ListGetAt(@col005, 4, @isa16_component_element_seperator),
			@L2300_hi05_BH_occur_info = dbo.fn_ListGetAt(@col006, 2, @isa16_component_element_seperator),
			@L2300_hi05_BH_occur_info_date = dbo.fn_ListGetAt(@col006, 4, @isa16_component_element_seperator),
			@L2300_hi06_BH_occur_info = dbo.fn_ListGetAt(@col007, 2, @isa16_component_element_seperator),
			@L2300_hi06_BH_occur_info_date = dbo.fn_ListGetAt(@col007, 4, @isa16_component_element_seperator),
			@L2300_hi07_BH_occur_info = dbo.fn_ListGetAt(@col008, 2, @isa16_component_element_seperator),
			@L2300_hi07_BH_occur_info_date = dbo.fn_ListGetAt(@col008, 4, @isa16_component_element_seperator),
			@L2300_hi08_BH_occur_info = dbo.fn_ListGetAt(@col009, 2, @isa16_component_element_seperator),
			@L2300_hi08_BH_occur_info_date = dbo.fn_ListGetAt(@col009, 4, @isa16_component_element_seperator),
			@L2300_hi09_BH_occur_info = dbo.fn_ListGetAt(@col010, 2, @isa16_component_element_seperator),
			@L2300_hi09_BH_occur_info_date = dbo.fn_ListGetAt(@col010, 4, @isa16_component_element_seperator),
			@L2300_hi10_BH_occur_info = dbo.fn_ListGetAt(@col011, 2, @isa16_component_element_seperator),
			@L2300_hi10_BH_occur_info_date = dbo.fn_ListGetAt(@col011, 4, @isa16_component_element_seperator),
			@L2300_hi11_BH_occur_info = dbo.fn_ListGetAt(@col012, 2, @isa16_component_element_seperator),
			@L2300_hi11_BH_occur_info_date = dbo.fn_ListGetAt(@col012, 4, @isa16_component_element_seperator),
			@L2300_hi12_BH_occur_info = dbo.fn_ListGetAt(@col013, 2, @isa16_component_element_seperator),
			@L2300_hi12_BH_occur_info_date = dbo.fn_ListGetAt(@col013, 4, @isa16_component_element_seperator)
	end

	if ( RTrim(@col001) = 'HI' AND Left(RTrim(@col002), 2) = 'BE' AND  @CurLoop = '2300')
	begin
		select	@L2300_hi01_BE_value_info = dbo.fn_ListGetAt(@col002, 2, @isa16_component_element_seperator),
			@L2300_hi01_BE_value_info_amt = CAST(dbo.fn_ListGetAt(@col002, 5, @isa16_component_element_seperator) as money),
			@L2300_hi02_BE_value_info = dbo.fn_ListGetAt(@col003, 2, @isa16_component_element_seperator),
			@L2300_hi02_BE_value_info_amt = CAST(dbo.fn_ListGetAt(@col003, 5, @isa16_component_element_seperator) as money),
			@L2300_hi03_BE_value_info = dbo.fn_ListGetAt(@col004, 2, @isa16_component_element_seperator),
			@L2300_hi03_BE_value_info_amt = CAST(dbo.fn_ListGetAt(@col004, 5, @isa16_component_element_seperator) as money),
			@L2300_hi04_BE_value_info = dbo.fn_ListGetAt(@col005, 2, @isa16_component_element_seperator),
			@L2300_hi04_BE_value_info_amt = CAST(dbo.fn_ListGetAt(@col005, 5, @isa16_component_element_seperator) as money),
			@L2300_hi05_BE_value_info = dbo.fn_ListGetAt(@col006, 2, @isa16_component_element_seperator),
			@L2300_hi05_BE_value_info_amt = CAST(dbo.fn_ListGetAt(@col006, 5, @isa16_component_element_seperator) as money),
			@L2300_hi06_BE_value_info = dbo.fn_ListGetAt(@col007, 2, @isa16_component_element_seperator),
			@L2300_hi06_BE_value_info_amt = CAST(dbo.fn_ListGetAt(@col007, 5, @isa16_component_element_seperator) as money),
			@L2300_hi07_BE_value_info = dbo.fn_ListGetAt(@col008, 2, @isa16_component_element_seperator),
			@L2300_hi07_BE_value_info_amt = CAST(dbo.fn_ListGetAt(@col008, 5, @isa16_component_element_seperator) as money),
			@L2300_hi08_BE_value_info = dbo.fn_ListGetAt(@col009, 2, @isa16_component_element_seperator),
			@L2300_hi08_BE_value_info_amt = CAST(dbo.fn_ListGetAt(@col009, 5, @isa16_component_element_seperator) as money),
			@L2300_hi09_BE_value_info = dbo.fn_ListGetAt(@col010, 2, @isa16_component_element_seperator),
			@L2300_hi09_BE_value_info_amt = CAST(dbo.fn_ListGetAt(@col010, 5, @isa16_component_element_seperator) as money),
			@L2300_hi10_BE_value_info = dbo.fn_ListGetAt(@col011, 2, @isa16_component_element_seperator),
			@L2300_hi10_BE_value_info_amt = CAST(dbo.fn_ListGetAt(@col011, 5, @isa16_component_element_seperator) as money),
			@L2300_hi11_BE_value_info = dbo.fn_ListGetAt(@col012, 2, @isa16_component_element_seperator),
			@L2300_hi11_BE_value_info_amt = CAST(dbo.fn_ListGetAt(@col012, 5, @isa16_component_element_seperator) as money),
			@L2300_hi12_BE_value_info = dbo.fn_ListGetAt(@col013, 2, @isa16_component_element_seperator),
			@L2300_hi12_BE_value_info_amt = CAST(dbo.fn_ListGetAt(@col013, 5, @isa16_component_element_seperator) as money)
	end

	if ( RTrim(@col001) = 'HI' AND Left(RTrim(@col002), 2) = 'BG' AND  @CurLoop = '2300')
	begin
		select	@L2300_hi01_BG_cond_info = dbo.fn_ListGetAt(@col002, 2, @isa16_component_element_seperator),
			@L2300_hi02_BG_cond_info = dbo.fn_ListGetAt(@col003, 2, @isa16_component_element_seperator),
			@L2300_hi03_BG_cond_info = dbo.fn_ListGetAt(@col004, 2, @isa16_component_element_seperator),
			@L2300_hi04_BG_cond_info = dbo.fn_ListGetAt(@col005, 2, @isa16_component_element_seperator),
			@L2300_hi05_BG_cond_info = dbo.fn_ListGetAt(@col006, 2, @isa16_component_element_seperator),
			@L2300_hi06_BG_cond_info = dbo.fn_ListGetAt(@col007, 2, @isa16_component_element_seperator),
			@L2300_hi07_BG_cond_info = dbo.fn_ListGetAt(@col008, 2, @isa16_component_element_seperator),
			@L2300_hi08_BG_cond_info = dbo.fn_ListGetAt(@col009, 2, @isa16_component_element_seperator),
			@L2300_hi09_BG_cond_info = dbo.fn_ListGetAt(@col010, 2, @isa16_component_element_seperator),
			@L2300_hi10_BG_cond_info = dbo.fn_ListGetAt(@col011, 2, @isa16_component_element_seperator),
			@L2300_hi11_BG_cond_info = dbo.fn_ListGetAt(@col012, 2, @isa16_component_element_seperator),
			@L2300_hi12_BG_cond_info = dbo.fn_ListGetAt(@col013, 2, @isa16_component_element_seperator)
	end
	
	if ( RTrim(@col001) = 'HI' AND Left(RTrim(@col002), 2) = 'TC' AND  @CurLoop = '2300')
	begin
		select	@L2300_hi01_TC_treat_code_info = dbo.fn_ListGetAt(@col002, 2, @isa16_component_element_seperator),
			@L2300_hi02_TC_treat_code_info = dbo.fn_ListGetAt(@col003, 2, @isa16_component_element_seperator),
			@L2300_hi03_TC_treat_code_info = dbo.fn_ListGetAt(@col004, 2, @isa16_component_element_seperator),
			@L2300_hi04_TC_treat_code_info = dbo.fn_ListGetAt(@col005, 2, @isa16_component_element_seperator),
			@L2300_hi05_TC_treat_code_info = dbo.fn_ListGetAt(@col006, 2, @isa16_component_element_seperator),
			@L2300_hi06_TC_treat_code_info = dbo.fn_ListGetAt(@col007, 2, @isa16_component_element_seperator),
			@L2300_hi07_TC_treat_code_info = dbo.fn_ListGetAt(@col008, 2, @isa16_component_element_seperator),
			@L2300_hi08_TC_treat_code_info = dbo.fn_ListGetAt(@col009, 2, @isa16_component_element_seperator),
			@L2300_hi09_TC_treat_code_info = dbo.fn_ListGetAt(@col010, 2, @isa16_component_element_seperator),
			@L2300_hi10_TC_treat_code_info = dbo.fn_ListGetAt(@col011, 2, @isa16_component_element_seperator),
			@L2300_hi11_TC_treat_code_info = dbo.fn_ListGetAt(@col012, 2, @isa16_component_element_seperator),
			@L2300_hi12_TC_treat_code_info = dbo.fn_ListGetAt(@col013, 2, @isa16_component_element_seperator)
	end		
				
	if ( RTrim(@col001) = 'QTY' AND  RTrim(@col002) = 'CA' AND  @CurLoop = '2300')
	begin			
		set @L2300_qty02_CA_claim_qty = LTrim(RTrim(@col003))
	end	
	
	if ( RTrim(@col001) = 'QTY' AND  RTrim(@col002) = 'CD' AND  @CurLoop = '2300')
	begin
		set @L2300_qty02_CD_claim_qty = LTrim(RTrim(@col003))
	end		
	
	if ( RTrim(@col001) = 'QTY' AND  RTrim(@col002) = 'LA' AND  @CurLoop = '2300')
	begin			
		set @L2300_qty02_LA_claim_qty = LTrim(RTrim(@col003))		
	end			
	
	if ( RTrim(@col001) = 'QTY' AND  RTrim(@col002) = 'NA' AND  @CurLoop = '2300')
	begin			
		set @L2300_qty02_NA_claim_qty = LTrim(RTrim(@col003))	
	end			

-- Claim Referring Provider Loop
	if ( RTrim(@col001) = 'NM1' AND RTrim(@col002) = '71' AND @curLoop = '2300' )
	begin
		select	@curLoop = '2310A',
			@L2310A_nm101_entity_id_code = LTrim(RTrim(@col002)),
			@L2310A_nm102_entity_type_qual = LTrim(RTrim(@col003)),
			@L2310A_nm103_attending_prov_last_nm = LTrim(RTrim(@col004)),
			@L2310A_nm104_attending_prov_first_nm = LTrim(RTrim(@col005)),
			@L2310A_nm105_attending_prov_middle_nm = LTrim(RTrim(@col006)),
			@L2310A_nm107_attending_prov_suffix = LTrim(RTrim(@col008)),
			@L2310A_nm108_id_code_qual = LTrim(RTrim(@col009)),
			@L2310A_nm109_attending_prov_id = LTrim(RTrim(@col010))
	end
	if ( RTrim(@col001) = 'PRV' AND @curLoop = '2310A' AND RTrim(@col002) = 'RF' )
	begin
		select	@L2310A_prv01_provider_code = LTrim(RTrim(@col002)),
			@L2310A_prv02_ref_id_qual = LTrim(RTrim(@col003)),
			@L2310A_prv03_taxonomy_code = LTrim(RTrim(@col004))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310A' AND RTrim(@col002) = '1C' )
	begin
		set @L2310A_ref02_1C_attending_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310A' AND RTrim(@col002) = '1D' )
	begin
		set @L2310A_ref02_1D_attending_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310A' AND RTrim(@col002) = '1G' )
	begin
		set @L2310A_ref02_1G_attending_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310A' AND RTrim(@col002) = 'EI' )
	begin
		set @L2310A_ref02_EI_attending_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310A' AND RTrim(@col002) = 'SY' )
	begin
		set @L2310A_ref02_SY_attending_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310A' AND RTrim(@col002) = 'FH' )
	begin
		set @L2310A_ref02_FH_attending_prov_id = LTrim(RTrim(@col003))
	end

-- Claim Operating Provider Loop
	if ( RTrim(@col001) = 'NM1' AND RTrim(@col002) = '72' AND @curLoop = '2310A' )
	begin
		select	@curLoop = '2310B',
			@L2310B_nm102_entity_type_qual = LTrim(RTrim(@col003)),
			@L2310B_nm103_operating_prov_last_nm = LTrim(RTrim(@col004)),
			@L2310B_nm104_operating_prov_first_nm = LTrim(RTrim(@col005)),
			@L2310B_nm105_operating_prov_middle_nm = LTrim(RTrim(@col006)),
			@L2310B_nm107_operating_prov_suffix = LTrim(RTrim(@col008)),
			@L2310B_nm108_id_code_qual = LTrim(RTrim(@col009)),
			@L2310B_nm109_operating_prov_id = LTrim(RTrim(@col010))
	end

	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310B' AND RTrim(@col002) = '1C' )
	begin
		set @L2310B_ref02_1C_operating_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310B' AND RTrim(@col002) = '1D' )
	begin
		set @L2310B_ref02_1D_operating_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310B' AND RTrim(@col002) = '1G' )
	begin
		set @L2310B_ref02_1G_operating_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310B' AND RTrim(@col002) = 'EI' )
	begin
		set @L2310B_ref02_EI_operating_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310B' AND RTrim(@col002) = 'SY' )
	begin
		set @L2310B_ref02_SY_operating_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310B' AND RTrim(@col002) = 'FH' )
	begin
		set @L2310B_ref02_FH_operating_prov_id = LTrim(RTrim(@col003))
	end
-- END LOOP: Claim operating Provider

-- Claim Rendering Provider Loop
	if ( RTrim(@col001) = 'NM1' AND RTrim(@col002) = '82' AND Left(@curLoop, 2) = '23' )
	begin
		select	@curLoop = '2310C',
			@L2310C_nm102_entity_type_qual = LTrim(RTrim(@col003)),
			@L2310C_nm103_other_prov_last_nm = LTrim(RTrim(@col004)),
			@L2310C_nm104_other_prov_first_nm = LTrim(RTrim(@col005)),
			@L2310C_nm105_other_prov_middle_nm = LTrim(RTrim(@col006)),
			@L2310C_nm107_other_prov_suffix = LTrim(RTrim(@col008)),
			@L2310C_nm108_id_code_qual = LTrim(RTrim(@col009)),
			@L2310C_nm109_other_prov_id = LTrim(RTrim(@col010))
	end

	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310C' AND RTrim(@col002) = '1C' )
	begin
		set @L2310C_ref02_1C_other_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310C' AND RTrim(@col002) = '1D' )
	begin
		set @L2310C_ref02_1D_other_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310C' AND RTrim(@col002) = '1G' )
	begin
		set @L2310C_ref02_1G_other_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310C' AND RTrim(@col002) = 'EI' )
	begin
		set @L2310C_ref02_EI_other_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310C' AND RTrim(@col002) = 'SY' )
	begin
		set @L2310C_ref02_SY_other_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310C' AND RTrim(@col002) = 'FH' )
	begin
		set @L2310C_ref02_FH_other_prov_id = LTrim(RTrim(@col003))
	end
-- END LOOP: Claim operating Provider

-- Claim Supervising Provider Loop
	if ( RTrim(@col001) = 'NM1' AND RTrim(@col002) = 'FA' AND LEFT(@curLoop, 2) = '23' )
	begin
		select	@curLoop = '2310E',
			@L2310E_nm101_entity_id_code = LTrim(RTrim(@col002)),
			@L2310E_nm102_entity_type_qual = LTrim(RTrim(@col003)),
			@L2310E_nm103_service_facility_last_nm = LTrim(RTrim(@col004)),
			@L2310E_nm108_id_code_qual = LTrim(RTrim(@col009)),
			@L2310E_nm109_service_facility_id = LTrim(RTrim(@col010))
	end

	if ( RTrim(@col001) = 'N3' AND @curLoop = '2310E' )
	begin
		set @L2310E_n301_service_facility_address1 = LTrim(RTrim(@col002))
		set @L2310E_n302_service_facility_address2 = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'N4' AND @curLoop = '2310D' )
	begin
		select	@L2310E_n401_service_facility_city = LTrim(RTrim(@col002)),
			@L2310E_n402_service_facility_state = LTrim(RTrim(@col003)),
			@L2310E_n403_service_facility_zip = LTrim(RTrim(@col004)),
			@L2310E_n404_service_facility_country = LTrim(RTrim(@col005))
	end

	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310E' AND RTrim(@col002) = '1C' )
	begin
		set @L2310E_ref02_1C_service_facility_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310E' AND RTrim(@col002) = '1D' )
	begin
		set @L2310E_ref02_1D_service_facility_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310E' AND RTrim(@col002) = '1G' )
	begin
		set @L2310E_ref02_1G_service_facility_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310E' AND RTrim(@col002) = 'G2' )
	begin
		set @L2310E_ref02_G2_service_facility_id = LTrim(RTrim(@col003))
	end

-- THIRD 2320 LOOP
	if ( RTrim(@col001) = 'SBR' AND @curLoop LIKE '23%' AND @Other2320SBRLoopCount = 2)
	begin
		select	@curLoop = '2320',
			@Other2320SBRLoopCount = 3,
			@L2320_3_sbr01_payer_resp_seq_code = LTrim(RTrim(@col002)),
			@L2320_3_sbr02_ind_relationship_code = LTrim(RTrim(@col003)),
			@L2320_3_sbr03_insured_grp_policy_num = LTrim(RTrim(@col004)),
			@L2320_3_sbr04_insured_grp_nm = LTrim(RTrim(@col005)),
			@L2320_3_sbr09_claim_file_ind_code = LTrim(RTrim(@col010))
	end

	if (@Other2320SBRLoopCount = 3)
	begin
		if ( RTrim(@col001) = 'CAS' AND @curLoop LIKE '23%' )
		begin
			select	@curLoop = '2320',
				@L2320_3_cas01_adjustment_group_code = LTrim(RTrim(@col002)),
				@L2320_3_cas02_adjustment_reason_code = LTrim(RTrim(@col003)),
				@L2320_3_cas03_adjustment_amt = CAST(LTrim(RTrim(@col004)) as money),
				@L2320_3_cas04_adjustment_qty = LTrim(RTrim(@col005)),
				@L2320_3_cas05_adjustment_reason_code = LTrim(RTrim(@col006)),
				@L2320_3_cas06_adjustment_amt = CAST(LTrim(RTrim(@col007)) as money),
				@L2320_3_cas07_adjustment_qty = LTrim(RTrim(@col008)),
				@L2320_3_cas08_adjustment_reason_code = LTrim(RTrim(@col009)),
				@L2320_3_cas09_adjustment_amt = CAST(LTrim(RTrim(@col010)) as money),
				@L2320_3_cas10_adjustment_qty = LTrim(RTrim(@col011))
		end
	
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'C4' )
		begin
			set @L2320_3_amt02_C4_payer_prior_pmt_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'B6' )
		begin
			set @L2320_3_amt02_B6_cob_allowed_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'T3' )
		begin
			set @L2320_3_amt02_T3_cob_submitted_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'ZZ' )
		begin
			set @L2320_3_amt02_ZZ_drg_outlier_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'N1' )
		begin
			set @L2320_3_amt02_N1_cob_medicare_paid_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'KF' )
		begin
			set @L2320_3_amt02_KF_medicare_paid_100_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'PG' )
		begin
			set @L2320_3_amt02_PG_medicare_paid_80_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'AA' )
		begin
			set @L2320_3_amt02_AA_cob_medicare_a_trust_pd_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'B1' )
		begin
			set @L2320_3_amt02_B1_cob_medicare_b_trust_pd_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'A8' )
		begin
			set @L2320_3_amt02_A8_cob_non_cvd_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'YT' )
		begin
			set @L2320_3_amt02_YT_cob_denied_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'DMG' AND @curLoop = '2320' )
		begin
			set @L2320_3_dmg02_other_subscriber_dob = LTRIM(RTRIM(@Col003))
			set @L2320_3_dmg03_other_subscriber_gender = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'OI' AND @CurLoop = '2320' )
		begin
			set @L2320_3_oi03_other_ins_benefit_assign_ind = LTRIM(RTRIM(@Col004))
			set @L2320_3_oi06_other_ins_release_of_info_code = LTRIM(RTRIM(@Col007))
		end
		if ( RTrim(@col001) = 'NM1'AND RTrim(@col002) = 'IL' AND @curLoop = '2320' )
		begin
			select	@curLoop = '2330A',
				@L2330A_3_nm101_entity_id_code = LTrim(RTrim(@col002)),
				@L2330A_3_nm102_entity_type_qual = LTrim(RTrim(@col003)),
				@L2330A_3_nm103_other_subscriber_last_name = LTrim(RTrim(@col004)),
				@L2330A_3_nm104_other_subscriber_first_name = LTrim(RTrim(@col005)),
				@L2330A_3_nm105_other_subscriber_middle_name = LTrim(RTrim(@col006)),
				@L2330A_3_nm107_other_subscriber_name_suffix = LTrim(RTrim(@col008)),
				@L2330A_3_nm108_other_subscriber_id_code_qual = LTrim(RTrim(@col009)),
				@L2330A_3_nm109_other_subscriber_id = LTrim(RTrim(@col010))
		end
	
		if ( RTrim(@col001) = 'NM1'AND RTrim(@col002) = 'PR' AND @curLoop LIKE '23%')  
		begin
			select	@CurLoop = '2330B',
				@L2330B_3_nm101_entity_id_code = LTrim(RTrim(@col002)),
				@L2330B_3_nm102_entity_type_qual = LTrim(RTrim(@col003)),
				@L2330B_3_nm103_other_payer_nm = LTrim(RTrim(@col004)),
				@L2330B_3_nm108_id_code_qual = LTrim(RTrim(@col009)),
				@L2330B_3_nm109_other_payer_id = LTrim(RTrim(@col010))
		end
		if ( RTrim(@col001) = 'DTP' AND @CurLoop = '2330B' AND RTrim(@col002) = '573' )
		begin
			set @L2330B_3_dtp03_573_date_claim_paid = LTrim(RTrim(@col004))
		end
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = '2U' )
		begin
			set @L2330B_3_ref02_2U_other_payer_secondary_id = LTrim(RTrim(@col003))
		end
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = 'F8' )
		begin
			set @L2330B_3_ref02_F8_other_payer_secondary_id = LTrim(RTrim(@col003))
		end
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = 'FY' )
		begin
			set @L2330B_3_ref02_FY_other_payer_secondary_id = LTrim(RTrim(@col003))
		end
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = 'NF' )
		begin
			set @L2330B_3_ref02_NF_other_payer_secondary_id = LTrim(RTrim(@col003))
		end
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = 'TJ' )
		begin
			set @L2330B_3_ref02_TJ_other_payer_secondary_id = LTrim(RTrim(@col003))
		end
	
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = '9F' )
		begin
			set @L2330B_3_ref02_9F_other_payer_auth_num = LTrim(RTrim(@col003))
		end
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = 'G1' )
		begin
			set @L2330B_3_ref02_G1_other_payer_auth_num = LTrim(RTrim(@col003))
		end
	end -- END THIRD 2320 LOOP

-- SECOND 2320 LOOP
	if ( RTrim(@col001) = 'SBR' AND @curLoop LIKE '23%' AND @Other2320SBRLoopCount = 1)
	begin
		select	@curLoop = '2320',
			@Other2320SBRLoopCount = 2,
			@L2320_2_sbr01_payer_resp_seq_code = LTrim(RTrim(@col002)),
			@L2320_2_sbr02_ind_relationship_code = LTrim(RTrim(@col003)),
			@L2320_2_sbr03_insured_grp_policy_num = LTrim(RTrim(@col004)),
			@L2320_2_sbr04_insured_grp_nm = LTrim(RTrim(@col005)),
			@L2320_2_sbr09_claim_file_ind_code = LTrim(RTrim(@col010))
	end

	if (@Other2320SBRLoopCount = 2)
	begin
		if ( RTrim(@col001) = 'CAS' AND @curLoop LIKE '23%' )
		begin
			select	@curLoop = '2320',
				@L2320_2_cas01_adjustment_group_code = LTrim(RTrim(@col002)),
				@L2320_2_cas02_adjustment_reason_code = LTrim(RTrim(@col003)),
				@L2320_2_cas03_adjustment_amt = CAST(LTrim(RTrim(@col004)) as money),
				@L2320_2_cas04_adjustment_qty = LTrim(RTrim(@col005)),
				@L2320_2_cas05_adjustment_reason_code = LTrim(RTrim(@col006)),
				@L2320_2_cas06_adjustment_amt = CAST(LTrim(RTrim(@col007)) as money),
				@L2320_2_cas07_adjustment_qty = LTrim(RTrim(@col008)),
				@L2320_2_cas08_adjustment_reason_code = LTrim(RTrim(@col009)),
				@L2320_2_cas09_adjustment_amt = CAST(LTrim(RTrim(@col010)) as money),
				@L2320_2_cas10_adjustment_qty = LTrim(RTrim(@col011))
		end
	
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'C4' )
		begin
			set @L2320_2_amt02_C4_payer_prior_pmt_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'B6' )
		begin
			set @L2320_2_amt02_B6_cob_allowed_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'T3' )
		begin
			set @L2320_2_amt02_T3_cob_submitted_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'ZZ' )
		begin
			set @L2320_2_amt02_ZZ_drg_outlier_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'N1' )
		begin
			set @L2320_2_amt02_N1_cob_medicare_paid_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'KF' )
		begin
			set @L2320_2_amt02_KF_medicare_paid_100_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'PG' )
		begin
			set @L2320_2_amt02_PG_medicare_paid_80_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'AA' )
		begin
			set @L2320_2_amt02_AA_cob_medicare_a_trust_pd_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'B1' )
		begin
			set @L2320_2_amt02_B1_cob_medicare_b_trust_pd_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'A8' )
		begin
			set @L2320_2_amt02_A8_cob_non_cvd_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'YT' )
		begin
			set @L2320_2_amt02_YT_cob_denied_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'DMG' AND @curLoop = '2320' )
		begin
			set @L2320_2_dmg02_other_subscriber_dob = LTRIM(RTRIM(@Col003))
			set @L2320_2_dmg03_other_subscriber_gender = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'OI' AND @CurLoop = '2320' )
		begin
			set @L2320_2_oi03_other_ins_benefit_assign_ind = LTRIM(RTRIM(@Col004))
			set @L2320_2_oi06_other_ins_release_of_info_code = LTRIM(RTRIM(@Col007))
		end
		if ( RTrim(@col001) = 'NM1'AND RTrim(@col002) = 'IL' AND @curLoop = '2320' )
		begin
			select	@curLoop = '2330A',
				@L2330A_2_nm101_entity_id_code = LTrim(RTrim(@col002)),
				@L2330A_2_nm102_entity_type_qual = LTrim(RTrim(@col003)),
				@L2330A_2_nm103_other_subscriber_last_name = LTrim(RTrim(@col004)),
				@L2330A_2_nm104_other_subscriber_first_name = LTrim(RTrim(@col005)),
				@L2330A_2_nm105_other_subscriber_middle_name = LTrim(RTrim(@col006)),
				@L2330A_2_nm107_other_subscriber_name_suffix = LTrim(RTrim(@col008)),
				@L2330A_2_nm108_other_subscriber_id_code_qual = LTrim(RTrim(@col009)),
				@L2330A_2_nm109_other_subscriber_id = LTrim(RTrim(@col010))
		end
	
		if ( RTrim(@col001) = 'NM1'AND RTrim(@col002) = 'PR' AND @curLoop LIKE '23%')  
		begin
			select	@CurLoop = '2330B',
				@L2330B_2_nm101_entity_id_code = LTrim(RTrim(@col002)),
				@L2330B_2_nm102_entity_type_qual = LTrim(RTrim(@col003)),
				@L2330B_2_nm103_other_payer_nm = LTrim(RTrim(@col004)),
				@L2330B_2_nm108_id_code_qual = LTrim(RTrim(@col009)),
				@L2330B_2_nm109_other_payer_id = LTrim(RTrim(@col010))
		end
		if ( RTrim(@col001) = 'DTP' AND @CurLoop = '2330B' AND RTrim(@col002) = '573' )
		begin
			set @L2330B_2_dtp03_573_date_claim_paid = LTrim(RTrim(@col004))
		end
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = '2U' )
		begin
			set @L2330B_2_ref02_2U_other_payer_secondary_id = LTrim(RTrim(@col003))
		end
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = 'F8' )
		begin
			set @L2330B_2_ref02_F8_other_payer_secondary_id = LTrim(RTrim(@col003))
		end
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = 'FY' )
		begin
			set @L2330B_2_ref02_FY_other_payer_secondary_id = LTrim(RTrim(@col003))
		end
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = 'NF' )
		begin
			set @L2330B_2_ref02_NF_other_payer_secondary_id = LTrim(RTrim(@col003))
		end
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = 'TJ' )
		begin
			set @L2330B_2_ref02_TJ_other_payer_secondary_id = LTrim(RTrim(@col003))
		end
	
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = '9F' )
		begin
			set @L2330B_2_ref02_9F_other_payer_auth_num = LTrim(RTrim(@col003))
		end
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = 'G1' )
		begin
			set @L2330B_2_ref02_G1_other_payer_auth_num = LTrim(RTrim(@col003))
		end
	end -- END SECOND 2320 LOOP


-- FIRST 2320 LOOP
	if ( RTrim(@col001) = 'SBR' AND @curLoop LIKE '23%' AND @Other2320SBRLoopCount = 0)
	begin
		select	@curLoop = '2320',
			@Other2320SBRLoopCount = 1,
			@L2320_1_sbr01_payer_resp_seq_code = LTrim(RTrim(@col002)),
			@L2320_1_sbr02_ind_relationship_code = LTrim(RTrim(@col003)),
			@L2320_1_sbr03_insured_grp_policy_num = LTrim(RTrim(@col004)),
			@L2320_1_sbr04_insured_grp_nm = LTrim(RTrim(@col005)),
			@L2320_1_sbr09_claim_file_ind_code = LTrim(RTrim(@col010))
	end

	if (@Other2320SBRLoopCount = 1)
	begin
		if ( RTrim(@col001) = 'CAS' AND @curLoop LIKE '23%' )
		begin
			select	@curLoop = '2320',
				@L2320_1_cas01_adjustment_group_code = LTrim(RTrim(@col002)),
				@L2320_1_cas02_adjustment_reason_code = LTrim(RTrim(@col003)),
				@L2320_1_cas03_adjustment_amt = CAST(LTrim(RTrim(@col004)) as money),
				@L2320_1_cas04_adjustment_qty = LTrim(RTrim(@col005)),
				@L2320_1_cas05_adjustment_reason_code = LTrim(RTrim(@col006)),
				@L2320_1_cas06_adjustment_amt = CAST(LTrim(RTrim(@col007)) as money),
				@L2320_1_cas07_adjustment_qty = LTrim(RTrim(@col008)),
				@L2320_1_cas08_adjustment_reason_code = LTrim(RTrim(@col009)),
				@L2320_1_cas09_adjustment_amt = CAST(LTrim(RTrim(@col010)) as money),
				@L2320_1_cas10_adjustment_qty = LTrim(RTrim(@col011))
		end
	
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'C4' )
		begin
			set @L2320_1_amt02_C4_payer_prior_pmt_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'B6' )
		begin
			set @L2320_1_amt02_B6_cob_allowed_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'T3' )
		begin
			set @L2320_1_amt02_T3_cob_submitted_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'ZZ' )
		begin
			set @L2320_1_amt02_ZZ_drg_outlier_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'N1' )
		begin
			set @L2320_1_amt02_N1_cob_medicare_paid_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'KF' )
		begin
			set @L2320_1_amt02_KF_medicare_paid_100_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'PG' )
		begin
			set @L2320_1_amt02_PG_medicare_paid_80_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'AA' )
		begin
			set @L2320_1_amt02_AA_cob_medicare_a_trust_pd_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'B1' )
		begin
			set @L2320_1_amt02_B1_cob_medicare_b_trust_pd_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'A8' )
		begin
			set @L2320_1_amt02_A8_cob_non_cvd_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'YT' )
		begin
			set @L2320_1_amt02_YT_cob_denied_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'DMG' AND @curLoop = '2320' )
		begin
			set @L2320_1_dmg02_other_subscriber_dob = LTRIM(RTRIM(@Col003))
			set @L2320_1_dmg03_other_subscriber_gender = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'OI' AND @CurLoop = '2320' )
		begin
			set @L2320_1_oi03_other_ins_benefit_assign_ind = LTRIM(RTRIM(@Col004))
			set @L2320_1_oi06_other_ins_release_of_info_code = LTRIM(RTRIM(@Col007))
		end
		if ( RTrim(@col001) = 'NM1'AND RTrim(@col002) = 'IL' AND @curLoop = '2320' )
		begin
			select	@curLoop = '2330A',
				@L2330A_1_nm101_entity_id_code = LTrim(RTrim(@col002)),
				@L2330A_1_nm102_entity_type_qual = LTrim(RTrim(@col003)),
				@L2330A_1_nm103_other_subscriber_last_name = LTrim(RTrim(@col004)),
				@L2330A_1_nm104_other_subscriber_first_name = LTrim(RTrim(@col005)),
				@L2330A_1_nm105_other_subscriber_middle_name = LTrim(RTrim(@col006)),
				@L2330A_1_nm107_other_subscriber_name_suffix = LTrim(RTrim(@col008)),
				@L2330A_1_nm108_other_subscriber_id_code_qual = LTrim(RTrim(@col009)),
				@L2330A_1_nm109_other_subscriber_id = LTrim(RTrim(@col010))
		end
	
		if ( RTrim(@col001) = 'NM1'AND RTrim(@col002) = 'PR' AND @curLoop LIKE '23%')  
		begin
			set @CurLoop = '2330B'
			set @L2330B_1_nm101_entity_id_code = LTrim(RTrim(@col002))
			set @L2330B_1_nm102_entity_type_qual = LTrim(RTrim(@col003))
			set @L2330B_1_nm103_other_payer_nm = LTrim(RTrim(@col004))
			set @L2330B_1_nm108_id_code_qual = LTrim(RTrim(@col009))
			set @L2330B_1_nm109_other_payer_id = LTrim(RTrim(@col010))
		end
		if ( RTrim(@col001) = 'DTP' AND @CurLoop = '2330B' AND RTrim(@col002) = '573' )
		begin
			set @L2330B_1_dtp03_573_date_claim_paid = LTrim(RTrim(@col004))
		end
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = '2U' )
		begin
			set @L2330B_1_ref02_2U_other_payer_secondary_id = LTrim(RTrim(@col003))
		end
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = 'F8' )
		begin
			set @L2330B_1_ref02_F8_other_payer_secondary_id = LTrim(RTrim(@col003))
		end
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = 'FY' )
		begin
			set @L2330B_1_ref02_FY_other_payer_secondary_id = LTrim(RTrim(@col003))
		end
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = 'NF' )
		begin
			set @L2330B_1_ref02_NF_other_payer_secondary_id = LTrim(RTrim(@col003))
		end
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = 'TJ' )
		begin
			set @L2330B_1_ref02_TJ_other_payer_secondary_id = LTrim(RTrim(@col003))
		end
	
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = '9F' )
		begin
			set @L2330B_1_ref02_9F_other_payer_auth_num = LTrim(RTrim(@col003))
		end
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = 'G1' )
		begin
			set @L2330B_1_ref02_G1_other_payer_auth_num = LTrim(RTrim(@col003))
		end
	end -- END FIRST 2320 LOOP

	FETCH NEXT FROM curt837i INTO @Col001, @Col002, @Col003, @Col004, @Col005, @Col006, @Col007, @Col008, @Col009, @Col010, @Col011, @Col012, @Col013, @Col014, @Col015, @Col016, @Col017, @Col018, @Col019, @Col020, @Col021
END
CLOSE curt837i
DEALLOCATE curt837i

-- after going through the recordset, the last record must be inserted because we're done with the last service line in the file
							EXEC dbo.up_x12_837i_insert
				@x12_transaction_id  = @x12_transaction_id ,
				@bht01_hierarchical_structure_code  = @bht01_hierarchical_structure_code ,
				@bht02_trans_set_purpose_code  = @bht02_trans_set_purpose_code ,
				@bht03_orig_app_tran_id  = @bht03_orig_app_tran_id ,
				@bht04_trans_set_creation_date  = @bht04_trans_set_creation_date ,
				@bht05_trans_set_creation_time  = @bht05_trans_set_creation_time ,
				@bht06_claim_encounter_id  = @bht06_claim_encounter_id ,
				@ref01_receiver_ref_id_qual  = @ref01_receiver_ref_id_qual ,
				@ref02_transmission_type_code  = @ref02_transmission_type_code ,
				@L1000A_nm102_entity_type_qual  = @L1000A_nm102_entity_type_qual ,
				@L1000A_nm103_submitter_last_nm  = @L1000A_nm103_submitter_last_nm ,
				@L1000A_nm104_submitter_first_nm  = @L1000A_nm104_submitter_first_nm ,
				@L1000A_nm105_submitter_middle_nm  = @L1000A_nm105_submitter_middle_nm ,
				@L1000A_nm108_submitter_id_qual  = @L1000A_nm108_submitter_id_qual ,
				@L1000A_nm109_submitter_id  = @L1000A_nm109_submitter_id ,
				@L1000A_per01_contact_function_code  = @L1000A_per01_contact_function_code ,
				@L1000A_per02_contact_nm  = @L1000A_per02_contact_nm ,
				@L1000A_per03_comm_num_qual  = @L1000A_per03_comm_num_qual ,
				@L1000A_per04_comm_number  = @L1000A_per04_comm_number ,
				@L1000B_nm102_entity_type_qual  = @L1000B_nm102_entity_type_qual ,
				@L1000B_nm103_receiver_last_nm  = @L1000B_nm103_receiver_last_nm ,
				@L1000B_nm108_receiver_id_qual  = @L1000B_nm108_receiver_id_qual ,
				@L1000B_nm109_receiver_id  = @L1000B_nm109_receiver_id ,
				@L2000A_hl01_hierarchical_id_num  = @L2000A_hl01_hierarchical_id_num ,
				@L2000A_hl03_hierarchical_level_code  = @L2000A_hl03_hierarchical_level_code ,
				@L2000A_hl04_hierarchical_child_code  = @L2000A_hl04_hierarchical_child_code ,
				@L2000A_prv01_provider_code  = @L2000A_prv01_provider_code ,
				@L2000A_prv02_ref_id_qual  = @L2000A_prv02_ref_id_qual ,
				@L2000A_prv03_taxonomy_code  = @L2000A_prv03_taxonomy_code ,
				@L2000A_cur02_currency_code  = @L2000A_cur02_currency_code ,
				@L2010AA_nm102_entity_type_qual  = @L2010AA_nm102_entity_type_qual ,
				@L2010AA_nm103_billing_prov_last_nm  = @L2010AA_nm103_billing_prov_last_nm ,
				@L2010AA_nm104_billing_prov_first_nm  = @L2010AA_nm104_billing_prov_first_nm ,
				@L2010AA_nm105_billing_prov_middle_nm  = @L2010AA_nm105_billing_prov_middle_nm ,
				@L2010AA_nm107_billing_prov_suffix  = @L2010AA_nm107_billing_prov_suffix ,
				@L2010AA_nm108_id_code_qual  = @L2010AA_nm108_id_code_qual ,
				@L2010AA_nm109_billing_prov_id  = @L2010AA_nm109_billing_prov_id ,
				@L2010AA_n301_billing_prov_address1  = @L2010AA_n301_billing_prov_address1 ,
				@L2010AA_n302_billing_prov_address2  = @L2010AA_n302_billing_prov_address2 ,
				@L2010AA_n401_billing_prov_city  = @L2010AA_n401_billing_prov_city ,
				@L2010AA_n402_billing_prov_state  = @L2010AA_n402_billing_prov_state ,
				@L2010AA_n403_billing_prov_zip  = @L2010AA_n403_billing_prov_zip ,
				@L2010AA_n404_billing_prov_country  = @L2010AA_n404_billing_prov_country ,
				@L2010AA_ref02_1B_billing_prov_id  = @L2010AA_ref02_1B_billing_prov_id ,
				@L2010AA_ref02_1C_billing_prov_id  = @L2010AA_ref02_1C_billing_prov_id ,
				@L2010AA_ref02_1D_billing_prov_id  = @L2010AA_ref02_1D_billing_prov_id ,
				@L2010AA_ref02_1G_billing_prov_id  = @L2010AA_ref02_1G_billing_prov_id ,
				@L2010AA_ref02_EI_billing_prov_id  = @L2010AA_ref02_EI_billing_prov_id ,
				@L2010AA_ref02_SY_billing_prov_id  = @L2010AA_ref02_SY_billing_prov_id ,
				@L2010AA_ref02_FH_billing_prov_id  = @L2010AA_ref02_FH_billing_prov_id ,
				@L2010AA_ref02_06_card_billing_id  = @L2010AA_ref02_06_card_billing_id ,
				@L2010AA_ref02_8U_card_billing_id  = @L2010AA_ref02_8U_card_billing_id ,
				@L2010AA_ref02_EM_card_billing_id  = @L2010AA_ref02_EM_card_billing_id ,
				@L2010AA_ref02_IJ_card_billing_id  = @L2010AA_ref02_IJ_card_billing_id ,
				@L2010AA_ref02_LU_card_billing_id  = @L2010AA_ref02_LU_card_billing_id ,
				@L2010AA_ref02_ST_card_billing_id  = @L2010AA_ref02_ST_card_billing_id ,
				@L2010AA_per01_billing_prov_comm_func_code  = @L2010AA_per01_billing_prov_comm_func_code ,
				@L2010AA_per02_billing_prov_contact_nm  = @L2010AA_per02_billing_prov_contact_nm ,
				@L2010AA_per03_billing_prov_comm_num_qual  = @L2010AA_per03_billing_prov_comm_num_qual ,
				@L2010AA_per04_billing_prov_comm  = @L2010AA_per04_billing_prov_comm ,
				@L2010AB_nm102_entity_type_qual  = @L2010AB_nm102_entity_type_qual ,
				@L2010AB_nm103_payto_prov_last_nm  = @L2010AB_nm103_payto_prov_last_nm ,
				@L2010AB_nm108_id_code_qual  = @L2010AB_nm108_id_code_qual ,
				@L2010AB_nm109_payto_prov_id  = @L2010AB_nm109_payto_prov_id ,
				@L2010AB_n301_payto_prov_address1  = @L2010AB_n301_payto_prov_address1 ,
				@L2010AB_n302_payto_prov_address2  = @L2010AB_n302_payto_prov_address2 ,
				@L2010AB_n401_payto_prov_city  = @L2010AB_n401_payto_prov_city ,
				@L2010AB_n402_payto_prov_state  = @L2010AB_n402_payto_prov_state ,
				@L2010AB_n403_payto_prov_zip  = @L2010AB_n403_payto_prov_zip ,
				@L2010AB_n404_payto_prov_country  = @L2010AB_n404_payto_prov_country ,
				@L2010AB_ref02_1C_payto_prov_id  = @L2010AB_ref02_1C_payto_prov_id ,
				@L2010AB_ref02_1D_payto_prov_id  = @L2010AB_ref02_1D_payto_prov_id ,
				@L2010AB_ref02_1G_payto_prov_id  = @L2010AB_ref02_1G_payto_prov_id ,
				@L2010AB_ref02_EI_payto_prov_id  = @L2010AB_ref02_EI_payto_prov_id ,
				@L2010AB_ref02_SY_payto_prov_id  = @L2010AB_ref02_SY_payto_prov_id ,
				@L2010AB_ref02_FH_payto_prov_id  = @L2010AB_ref02_FH_payto_prov_id ,
				@L2000B_hl01_hierarchical_id_num  = @L2000B_hl01_hierarchical_id_num ,
				@L2000B_hl02_hierarchical_parent_id_num  = @L2000B_hl02_hierarchical_parent_id_num ,
				@L2000B_hl03_hierarchical_level_code  = @L2000B_hl03_hierarchical_level_code ,
				@L2000B_hl04_hierarchical_child_code  = @L2000B_hl04_hierarchical_child_code ,
				@L2000B_sbr01_payer_resp_seq_code  = @L2000B_sbr01_payer_resp_seq_code ,
				@L2000B_sbr02_ind_relationship_code  = @L2000B_sbr02_ind_relationship_code ,
				@L2000B_sbr03_insured_grp_policy_num  = @L2000B_sbr03_insured_grp_policy_num ,
				@L2000B_sbr04_insured_grp_nm  = @L2000B_sbr04_insured_grp_nm ,
				@L2000B_sbr09_claim_id_code  = @L2000B_sbr09_claim_id_code ,
				@L2000B_pat06_insured_ind_death_date  = @L2000B_pat06_insured_ind_death_date ,
				@L2000B_pat08_patient_weight  = @L2000B_pat08_patient_weight ,
				@L2000B_pat09_pregnancy_indicator  = @L2000B_pat09_pregnancy_indicator ,
				@L2010BA_nm102_entity_type_qual  = @L2010BA_nm102_entity_type_qual ,
				@L2010BA_nm103_subscriber_last_nm  = @L2010BA_nm103_subscriber_last_nm ,
				@L2010BA_nm104_subscriber_first_nm  = @L2010BA_nm104_subscriber_first_nm ,
				@L2010BA_nm105_subscriber_middle_nm  = @L2010BA_nm105_subscriber_middle_nm ,
				@L2010BA_nm107_subscriber_suffix  = @L2010BA_nm107_subscriber_suffix ,
				@L2010BA_nm108_id_code_qual  = @L2010BA_nm108_id_code_qual ,
				@L2010BA_nm109_subscriber_id  = @L2010BA_nm109_subscriber_id ,
				@L2010BA_n301_subscriber_address1  = @L2010BA_n301_subscriber_address1 ,
				@L2010BA_n302_subscriber_address2  = @L2010BA_n302_subscriber_address2 ,
				@L2010BA_n401_subscriber_city  = @L2010BA_n401_subscriber_city ,
				@L2010BA_n402_subscriber_state  = @L2010BA_n402_subscriber_state ,
				@L2010BA_n403_subscriber_zip  = @L2010BA_n403_subscriber_zip ,
				@L2010BA_n404_subscriber_country  = @L2010BA_n404_subscriber_country ,
				@L2010BA_dmg02_subscriber_dob  = @L2010BA_dmg02_subscriber_dob ,
				@L2010BA_dmg03_subscriber_gender  = @L2010BA_dmg03_subscriber_gender ,
				@L2010BA_ref02_1W_subscriber_sup_id  = @L2010BA_ref02_1W_subscriber_sup_id ,
				@L2010BA_ref02_23_subscriber_sup_id  = @L2010BA_ref02_23_subscriber_sup_id ,
				@L2010BA_ref02_IG_subscriber_sup_id  = @L2010BA_ref02_IG_subscriber_sup_id ,
				@L2010BA_ref02_SY_subscriber_sup_id  = @L2010BA_ref02_SY_subscriber_sup_id ,
				@L2010BA_ref02_Y4_prop_casualty_claim_num  = @L2010BA_ref02_Y4_prop_casualty_claim_num ,
				@L2010BB_nm102_entity_type_qual  = @L2010BB_nm102_entity_type_qual ,
				@L2010BB_nm103_card_holder_last_nm  = @L2010BB_nm103_card_holder_last_nm ,
				@L2010BB_nm104_card_holder_first_nm  = @L2010BB_nm104_card_holder_first_nm ,
				@L2010BB_nm105_card_holder_middle_nm  = @L2010BB_nm105_card_holder_middle_nm ,
				@L2010BB_nm107_card_holder_suffix  = @L2010BB_nm107_card_holder_suffix ,
				@L2010BB_nm108_card_id_qual  = @L2010BB_nm108_card_id_qual ,
				@L2010BB_nm109_card_num  = @L2010BB_nm109_card_num ,
				@L2010BB_ref02_AB_payer_id  = @L2010BB_ref02_AB_payer_id ,
				@L2010BB_ref02_BB_payer_id  = @L2010BB_ref02_BB_payer_id ,
				@L2010BC_nm102_entity_type_qual  = @L2010BC_nm102_entity_type_qual ,
				@L2010BC_nm103_payer_nm  = @L2010BC_nm103_payer_nm ,
				@L2010BC_nm108_payer_id_qual  = @L2010BC_nm108_payer_id_qual ,
				@L2010BC_nm109_payer_id  = @L2010BC_nm109_payer_id ,
				@L2010BC_n301_payer_address1  = @L2010BC_n301_payer_address1 ,
				@L2010BC_n302_payer_address2  = @L2010BC_n302_payer_address2 ,
				@L2010BC_n401_payer_city  = @L2010BC_n401_payer_city ,
				@L2010BC_n402_payer_state  = @L2010BC_n402_payer_state ,
				@L2010BC_n403_payer_zip  = @L2010BC_n403_payer_zip ,
				@L2010BC_n404_payer_country  = @L2010BC_n404_payer_country ,
				@L2010BC_ref02_2U_payer_id  = @L2010BC_ref02_2U_payer_id ,
				@L2010BC_ref02_FY_payer_id  = @L2010BC_ref02_FY_payer_id ,
				@L2010BC_ref02_NF_payer_id  = @L2010BC_ref02_NF_payer_id ,
				@L2010BC_ref02_TJ_payer_id  = @L2010BC_ref02_TJ_payer_id ,
				@L2010BD_nm102_entity_type_qual  = @L2010BD_nm102_entity_type_qual ,
				@L2010BD_nm103_resp_party_last_nm  = @L2010BD_nm103_resp_party_last_nm ,
				@L2010BD_nm104_resp_party_first_nm  = @L2010BD_nm104_resp_party_first_nm ,
				@L2010BD_nm105_resp_party_middle_nm  = @L2010BD_nm105_resp_party_middle_nm ,
				@L2010BD_nm107_resp_party_suffix  = @L2010BD_nm107_resp_party_suffix ,
				@L2010BD_n301_resp_party_address1  = @L2010BD_n301_resp_party_address1 ,
				@L2010BD_n302_resp_party_address2  = @L2010BD_n302_resp_party_address2 ,
				@L2010BD_n401_resp_party_city  = @L2010BD_n401_resp_party_city ,
				@L2010BD_n402_resp_party_state  = @L2010BD_n402_resp_party_state ,
				@L2010BD_n403_resp_party_zip  = @L2010BD_n403_resp_party_zip ,
				@L2010BD_n404_resp_party_country  = @L2010BD_n404_resp_party_country ,
				@L2000C_hl01_hierarchical_id_num  = @L2000C_hl01_hierarchical_id_num ,
				@L2000C_hl02_hierarchical_parent_id_num  = @L2000C_hl02_hierarchical_parent_id_num ,
				@L2000C_hl03_hierarchical_level_code  = @L2000C_hl03_hierarchical_level_code ,
				@L2000C_hl04_hierarchical_child_code  = @L2000C_hl04_hierarchical_child_code ,
				@L2000C_pat01_ind_relationship_code  = @L2000C_pat01_ind_relationship_code ,
				@L2010CA_nm102_entity_type_qual  = @L2010CA_nm102_entity_type_qual ,
				@L2010CA_nm103_patient_last_nm  = @L2010CA_nm103_patient_last_nm ,
				@L2010CA_nm104_patient_first_nm  = @L2010CA_nm104_patient_first_nm ,
				@L2010CA_nm105_patient_middle_nm  = @L2010CA_nm105_patient_middle_nm ,
				@L2010CA_nm107_patient_suffix  = @L2010CA_nm107_patient_suffix ,
				@L2010CA_nm108_id_code_qual  = @L2010CA_nm108_id_code_qual ,
				@L2010CA_nm109_patient_id  = @L2010CA_nm109_patient_id ,
				@L2010CA_n301_patient_address1  = @L2010CA_n301_patient_address1 ,
				@L2010CA_n302_patient_address2  = @L2010CA_n302_patient_address2 ,
				@L2010CA_n401_patient_city  = @L2010CA_n401_patient_city ,
				@L2010CA_n402_patient_state  = @L2010CA_n402_patient_state ,
				@L2010CA_n403_patient_zip  = @L2010CA_n403_patient_zip ,
				@L2010CA_n404_patient_country  = @L2010CA_n404_patient_country ,
				@L2010CA_dmg02_patient_dob  = @L2010CA_dmg02_patient_dob ,
				@L2010CA_dmg03_patient_gender  = @L2010CA_dmg03_patient_gender ,
				@L2010CA_ref02_1W_patient_sup_id  = @L2010CA_ref02_1W_patient_sup_id ,
				@L2010CA_ref02_23_patient_sup_id  = @L2010CA_ref02_23_patient_sup_id ,
				@L2010CA_ref02_IG_patient_sup_id  = @L2010CA_ref02_IG_patient_sup_id ,
				@L2010CA_ref02_SY_patient_sup_id  = @L2010CA_ref02_SY_patient_sup_id ,
				@L2010CA_ref02_Y4_prop_casualty_claim_num  = @L2010CA_ref02_Y4_prop_casualty_claim_num ,
				@L2300_clm01_pt_acct_num  = @L2300_clm01_pt_acct_num ,
				@L2300_clm02_total_claim_chg_amt  = @L2300_clm02_total_claim_chg_amt ,
				@L2300_clm05_facility_type_code  = @L2300_clm05_facility_type_code ,
				@L2300_clm05_facility_code_qual  = @L2300_clm05_facility_code_qual ,
				@L2300_clm05_claim_freq_code  = @L2300_clm05_claim_freq_code ,
				@L2300_clm06_provider_signature_ind  = @L2300_clm06_provider_signature_ind ,
				@L2300_clm07_medicare_assign_code  = @L2300_clm07_medicare_assign_code ,
				@L2300_clm08_benefit_assign_ind  = @L2300_clm08_benefit_assign_ind ,
				@L2300_clm09_release_of_info_code  = @L2300_clm09_release_of_info_code ,
				@L2300_clm18_explan_benefits_ind  = @L2300_clm18_explan_benefits_ind ,
				@L2300_clm20_delay_reason_code  = @L2300_clm20_delay_reason_code ,
				@L2300_dtp03_096_discharge_hour  = @L2300_dtp03_096_discharge_hour ,
				@L2300_dtp03_434_begin_statement_date  = @L2300_dtp03_434_begin_statement_date ,
				@L2300_dtp03_434_end_statement_date  = @L2300_dtp03_434_end_statement_date ,
				@L2300_dtp03_435_admission_date  = @L2300_dtp03_435_admission_date ,
				@L2300_cl101_admit_type_code  = @L2300_cl101_admit_type_code ,
				@L2300_cl102_admit_source_code  = @L2300_cl102_admit_source_code ,
				@L2300_cl103_patient_status_code  = @L2300_cl103_patient_status_code ,
				@L2300_pwk01_attachment_type_code  = @L2300_pwk01_attachment_type_code ,
				@L2300_pwk02_attachment_trans_code  = @L2300_pwk02_attachment_trans_code ,
				@L2300_pwk06_attachment_control_num  = @L2300_pwk06_attachment_control_num ,
				@L2300_amt02_patient_paid_amt  = @L2300_amt02_patient_paid_amt ,
				@L2300_amt02_patient_resp_amt  = @L2300_amt02_patient_resp_amt ,
				@L2300_amt02_total_purchased_amt  = @L2300_amt02_total_purchased_amt ,
				@L2300_ref02_9C_adj_repriced_claim_num  = @L2300_ref02_9C_adj_repriced_claim_num ,
				@L2300_ref02_9A_repriced_claim_num  = @L2300_ref02_9A_repriced_claim_num ,
				@L2300_ref02_D9_claim_id_clearing_house  = @L2300_ref02_D9_claim_id_clearing_house ,
				@L2300_ref02_DD_domcument_id  = @L2300_ref02_DD_domcument_id ,
				@L2300_ref02_F8_original_ref_num  = @L2300_ref02_F8_original_ref_num ,
				@L2300_ref02_9F_referral_num  = @L2300_ref02_9F_referral_num ,
				@L2300_ref02_G1_prior_auth_num  = @L2300_ref02_G1_prior_auth_num ,
				@L2300_ref02_EA_medical_record_num  = @L2300_ref02_EA_medical_record_num ,
				@L2300_k301_fixed_format_info  = @L2300_k301_fixed_format_info ,
				@L2300_nte01_note_ref_code  = @L2300_nte01_note_ref_code ,
				@L2300_nte02_claim_note_text  = @L2300_nte02_claim_note_text ,
				@L2300_hi01_BK_diag_admit_ecode  = @L2300_hi01_BK_diag_admit_ecode ,
				@L2300_hi02_BJ_diag_admit_ecode  = @L2300_hi02_BJ_diag_admit_ecode ,
				@L2300_hi02_ZZ_diag_admit_ecode  = @L2300_hi02_ZZ_diag_admit_ecode ,
				@L2300_hi03_BN_diag_admit_ecode  = @L2300_hi03_BN_diag_admit_ecode ,
				@L2300_hi01_DR_diag_drg  = @L2300_hi01_DR_diag_drg ,
				@L2300_hi01_BF_diag_code  = @L2300_hi01_BF_diag_code ,
				@L2300_hi02_BF_diag_code  = @L2300_hi02_BF_diag_code ,
				@L2300_hi03_BF_diag_code  = @L2300_hi03_BF_diag_code ,
				@L2300_hi04_BF_diag_code  = @L2300_hi04_BF_diag_code ,
				@L2300_hi05_BF_diag_code  = @L2300_hi05_BF_diag_code ,
				@L2300_hi06_BF_diag_code  = @L2300_hi06_BF_diag_code ,
				@L2300_hi07_BF_diag_code  = @L2300_hi07_BF_diag_code ,
				@L2300_hi08_BF_diag_code  = @L2300_hi08_BF_diag_code ,
				@L2300_hi09_BF_diag_code  = @L2300_hi09_BF_diag_code ,
				@L2300_hi10_BF_diag_code  = @L2300_hi10_BF_diag_code ,
				@L2300_hi11_BF_diag_code  = @L2300_hi11_BF_diag_code ,
				@L2300_hi12_BF_diag_code  = @L2300_hi12_BF_diag_code ,
				@L2300_hi01_BR_princ_proc_info  = @L2300_hi01_BR_princ_proc_info ,
				@L2300_hi01_BR_princ_proc_info_date  = @L2300_hi01_BR_princ_proc_info_date ,
				@L2300_hi01_BQ_other_proc_info  = @L2300_hi01_BQ_other_proc_info ,
				@L2300_hi01_BQ_other_proc_info_date  = @L2300_hi01_BQ_other_proc_info_date ,
				@L2300_hi02_BQ_other_proc_info  = @L2300_hi02_BQ_other_proc_info ,
				@L2300_hi02_BQ_other_proc_info_date  = @L2300_hi02_BQ_other_proc_info_date ,
				@L2300_hi03_BQ_other_proc_info  = @L2300_hi03_BQ_other_proc_info ,
				@L2300_hi03_BQ_other_proc_info_date  = @L2300_hi03_BQ_other_proc_info_date ,
				@L2300_hi04_BQ_other_proc_info  = @L2300_hi04_BQ_other_proc_info ,
				@L2300_hi04_BQ_other_proc_info_date  = @L2300_hi04_BQ_other_proc_info_date ,
				@L2300_hi05_BQ_other_proc_info  = @L2300_hi05_BQ_other_proc_info ,
				@L2300_hi05_BQ_other_proc_info_date  = @L2300_hi05_BQ_other_proc_info_date ,
				@L2300_hi06_BQ_other_proc_info  = @L2300_hi06_BQ_other_proc_info ,
				@L2300_hi06_BQ_other_proc_info_date  = @L2300_hi06_BQ_other_proc_info_date ,
				@L2300_hi07_BQ_other_proc_info  = @L2300_hi07_BQ_other_proc_info ,
				@L2300_hi07_BQ_other_proc_info_date  = @L2300_hi07_BQ_other_proc_info_date ,
				@L2300_hi08_BQ_other_proc_info  = @L2300_hi08_BQ_other_proc_info ,
				@L2300_hi08_BQ_other_proc_info_date  = @L2300_hi08_BQ_other_proc_info_date ,
				@L2300_hi09_BQ_other_proc_info  = @L2300_hi09_BQ_other_proc_info ,
				@L2300_hi09_BQ_other_proc_info_date  = @L2300_hi09_BQ_other_proc_info_date ,
				@L2300_hi10_BQ_other_proc_info  = @L2300_hi10_BQ_other_proc_info ,
				@L2300_hi10_BQ_other_proc_info_date  = @L2300_hi10_BQ_other_proc_info_date ,
				@L2300_hi11_BQ_other_proc_info  = @L2300_hi11_BQ_other_proc_info ,
				@L2300_hi11_BQ_other_proc_info_date  = @L2300_hi11_BQ_other_proc_info_date ,
				@L2300_hi12_BQ_other_proc_info  = @L2300_hi12_BQ_other_proc_info ,
				@L2300_hi12_BQ_other_proc_info_date  = @L2300_hi12_BQ_other_proc_info_date ,
				@L2300_hi01_BI_occur_span  = @L2300_hi01_BI_occur_span ,
				@L2300_hi01_BI_occur_span_date  = @L2300_hi01_BI_occur_span_date ,
				@L2300_hi02_BI_occur_span  = @L2300_hi02_BI_occur_span ,
				@L2300_hi02_BI_occur_span_date  = @L2300_hi02_BI_occur_span_date ,
				@L2300_hi03_BI_occur_span  = @L2300_hi03_BI_occur_span ,
				@L2300_hi03_BI_occur_span_date  = @L2300_hi03_BI_occur_span_date ,
				@L2300_hi04_BI_occur_span  = @L2300_hi04_BI_occur_span ,
				@L2300_hi04_BI_occur_span_date  = @L2300_hi04_BI_occur_span_date ,
				@L2300_hi05_BI_occur_span  = @L2300_hi05_BI_occur_span ,
				@L2300_hi05_BI_occur_span_date  = @L2300_hi05_BI_occur_span_date ,
				@L2300_hi06_BI_occur_span  = @L2300_hi06_BI_occur_span ,
				@L2300_hi06_BI_occur_span_date  = @L2300_hi06_BI_occur_span_date ,
				@L2300_hi07_BI_occur_span  = @L2300_hi07_BI_occur_span ,
				@L2300_hi07_BI_occur_span_date  = @L2300_hi07_BI_occur_span_date ,
				@L2300_hi08_BI_occur_span  = @L2300_hi08_BI_occur_span ,
				@L2300_hi08_BI_occur_span_date  = @L2300_hi08_BI_occur_span_date ,
				@L2300_hi09_BI_occur_span  = @L2300_hi09_BI_occur_span ,
				@L2300_hi09_BI_occur_span_date  = @L2300_hi09_BI_occur_span_date ,
				@L2300_hi10_BI_occur_span  = @L2300_hi10_BI_occur_span ,
				@L2300_hi10_BI_occur_span_date  = @L2300_hi10_BI_occur_span_date ,
				@L2300_hi11_BI_occur_span  = @L2300_hi11_BI_occur_span ,
				@L2300_hi11_BI_occur_span_date  = @L2300_hi11_BI_occur_span_date ,
				@L2300_hi12_BI_occur_span  = @L2300_hi12_BI_occur_span ,
				@L2300_hi12_BI_occur_span_date  = @L2300_hi12_BI_occur_span_date ,
				@L2300_hi01_BH_occur_info  = @L2300_hi01_BH_occur_info ,
				@L2300_hi01_BH_occur_info_date  = @L2300_hi01_BH_occur_info_date ,
				@L2300_hi02_BH_occur_info  = @L2300_hi02_BH_occur_info ,
				@L2300_hi02_BH_occur_info_date  = @L2300_hi02_BH_occur_info_date ,
				@L2300_hi03_BH_occur_info  = @L2300_hi03_BH_occur_info ,
				@L2300_hi03_BH_occur_info_date  = @L2300_hi03_BH_occur_info_date ,
				@L2300_hi04_BH_occur_info  = @L2300_hi04_BH_occur_info ,
				@L2300_hi04_BH_occur_info_date  = @L2300_hi04_BH_occur_info_date ,
				@L2300_hi05_BH_occur_info  = @L2300_hi05_BH_occur_info ,
				@L2300_hi05_BH_occur_info_date  = @L2300_hi05_BH_occur_info_date ,
				@L2300_hi06_BH_occur_info  = @L2300_hi06_BH_occur_info ,
				@L2300_hi06_BH_occur_info_date  = @L2300_hi06_BH_occur_info_date ,
				@L2300_hi07_BH_occur_info  = @L2300_hi07_BH_occur_info ,
				@L2300_hi07_BH_occur_info_date  = @L2300_hi07_BH_occur_info_date ,
				@L2300_hi08_BH_occur_info  = @L2300_hi08_BH_occur_info ,
				@L2300_hi08_BH_occur_info_date  = @L2300_hi08_BH_occur_info_date ,
				@L2300_hi09_BH_occur_info  = @L2300_hi09_BH_occur_info ,
				@L2300_hi09_BH_occur_info_date  = @L2300_hi09_BH_occur_info_date ,
				@L2300_hi10_BH_occur_info  = @L2300_hi10_BH_occur_info ,
				@L2300_hi10_BH_occur_info_date  = @L2300_hi10_BH_occur_info_date ,
				@L2300_hi11_BH_occur_info  = @L2300_hi11_BH_occur_info ,
				@L2300_hi11_BH_occur_info_date  = @L2300_hi11_BH_occur_info_date ,
				@L2300_hi12_BH_occur_info  = @L2300_hi12_BH_occur_info ,
				@L2300_hi12_BH_occur_info_date  = @L2300_hi12_BH_occur_info_date ,
				@L2300_hi01_BE_value_info  = @L2300_hi01_BE_value_info ,
				@L2300_hi01_BE_value_info_amt  = @L2300_hi01_BE_value_info_amt ,
				@L2300_hi02_BE_value_info  = @L2300_hi02_BE_value_info ,
				@L2300_hi02_BE_value_info_amt  = @L2300_hi02_BE_value_info_amt ,
				@L2300_hi03_BE_value_info  = @L2300_hi03_BE_value_info ,
				@L2300_hi03_BE_value_info_amt  = @L2300_hi03_BE_value_info_amt ,
				@L2300_hi04_BE_value_info  = @L2300_hi04_BE_value_info ,
				@L2300_hi04_BE_value_info_amt  = @L2300_hi04_BE_value_info_amt ,
				@L2300_hi05_BE_value_info  = @L2300_hi05_BE_value_info ,
				@L2300_hi05_BE_value_info_amt  = @L2300_hi05_BE_value_info_amt ,
				@L2300_hi06_BE_value_info  = @L2300_hi06_BE_value_info ,
				@L2300_hi06_BE_value_info_amt  = @L2300_hi06_BE_value_info_amt ,
				@L2300_hi07_BE_value_info  = @L2300_hi07_BE_value_info ,
				@L2300_hi07_BE_value_info_amt  = @L2300_hi07_BE_value_info_amt ,
				@L2300_hi08_BE_value_info  = @L2300_hi08_BE_value_info ,
				@L2300_hi08_BE_value_info_amt  = @L2300_hi08_BE_value_info_amt ,
				@L2300_hi09_BE_value_info  = @L2300_hi09_BE_value_info ,
				@L2300_hi09_BE_value_info_amt  = @L2300_hi09_BE_value_info_amt ,
				@L2300_hi10_BE_value_info  = @L2300_hi10_BE_value_info ,
				@L2300_hi10_BE_value_info_amt  = @L2300_hi10_BE_value_info_amt ,
				@L2300_hi11_BE_value_info  = @L2300_hi11_BE_value_info ,
				@L2300_hi11_BE_value_info_amt  = @L2300_hi11_BE_value_info_amt ,
				@L2300_hi12_BE_value_info  = @L2300_hi12_BE_value_info ,
				@L2300_hi12_BE_value_info_amt  = @L2300_hi12_BE_value_info_amt ,
				@L2300_hi01_BG_cond_info  = @L2300_hi01_BG_cond_info ,
				@L2300_hi02_BG_cond_info  = @L2300_hi02_BG_cond_info ,
				@L2300_hi03_BG_cond_info  = @L2300_hi03_BG_cond_info ,
				@L2300_hi04_BG_cond_info  = @L2300_hi04_BG_cond_info ,
				@L2300_hi05_BG_cond_info  = @L2300_hi05_BG_cond_info ,
				@L2300_hi06_BG_cond_info  = @L2300_hi06_BG_cond_info ,
				@L2300_hi07_BG_cond_info  = @L2300_hi07_BG_cond_info ,
				@L2300_hi08_BG_cond_info  = @L2300_hi08_BG_cond_info ,
				@L2300_hi09_BG_cond_info  = @L2300_hi09_BG_cond_info ,
				@L2300_hi10_BG_cond_info  = @L2300_hi10_BG_cond_info ,
				@L2300_hi11_BG_cond_info  = @L2300_hi11_BG_cond_info ,
				@L2300_hi12_BG_cond_info  = @L2300_hi12_BG_cond_info ,
				@L2300_hi01_TC_treat_code_info  = @L2300_hi01_TC_treat_code_info ,
				@L2300_hi02_TC_treat_code_info  = @L2300_hi02_TC_treat_code_info ,
				@L2300_hi03_TC_treat_code_info  = @L2300_hi03_TC_treat_code_info ,
				@L2300_hi04_TC_treat_code_info  = @L2300_hi04_TC_treat_code_info ,
				@L2300_hi05_TC_treat_code_info  = @L2300_hi05_TC_treat_code_info ,
				@L2300_hi06_TC_treat_code_info  = @L2300_hi06_TC_treat_code_info ,
				@L2300_hi07_TC_treat_code_info  = @L2300_hi07_TC_treat_code_info ,
				@L2300_hi08_TC_treat_code_info  = @L2300_hi08_TC_treat_code_info ,
				@L2300_hi09_TC_treat_code_info  = @L2300_hi09_TC_treat_code_info ,
				@L2300_hi10_TC_treat_code_info  = @L2300_hi10_TC_treat_code_info ,
				@L2300_hi11_TC_treat_code_info  = @L2300_hi11_TC_treat_code_info ,
				@L2300_hi12_TC_treat_code_info  = @L2300_hi12_TC_treat_code_info ,
				@L2300_qty02_CA_claim_qty  = @L2300_qty02_CA_claim_qty ,
				@L2300_qty02_CD_claim_qty  = @L2300_qty02_CD_claim_qty ,
				@L2300_qty02_LA_claim_qty  = @L2300_qty02_LA_claim_qty ,
				@L2300_qty02_NA_claim_qty  = @L2300_qty02_NA_claim_qty ,
				@L2310A_nm101_entity_id_code  = @L2310A_nm101_entity_id_code ,
				@L2310A_nm102_entity_type_qual  = @L2310A_nm102_entity_type_qual ,
				@L2310A_nm103_attending_prov_last_nm  = @L2310A_nm103_attending_prov_last_nm ,
				@L2310A_nm104_attending_prov_first_nm  = @L2310A_nm104_attending_prov_first_nm ,
				@L2310A_nm105_attending_prov_middle_nm  = @L2310A_nm105_attending_prov_middle_nm ,
				@L2310A_nm107_attending_prov_suffix  = @L2310A_nm107_attending_prov_suffix ,
				@L2310A_nm108_id_code_qual  = @L2310A_nm108_id_code_qual ,
				@L2310A_nm109_attending_prov_id  = @L2310A_nm109_attending_prov_id ,
				@L2310A_prv01_provider_code  = @L2310A_prv01_provider_code ,
				@L2310A_prv02_ref_id_qual  = @L2310A_prv02_ref_id_qual ,
				@L2310A_prv03_taxonomy_code  = @L2310A_prv03_taxonomy_code ,
				@L2310A_ref02_1C_attending_prov_id  = @L2310A_ref02_1C_attending_prov_id ,
				@L2310A_ref02_1D_attending_prov_id  = @L2310A_ref02_1D_attending_prov_id ,
				@L2310A_ref02_1G_attending_prov_id  = @L2310A_ref02_1G_attending_prov_id ,
				@L2310A_ref02_EI_attending_prov_id  = @L2310A_ref02_EI_attending_prov_id ,
				@L2310A_ref02_SY_attending_prov_id  = @L2310A_ref02_SY_attending_prov_id ,
				@L2310A_ref02_FH_attending_prov_id  = @L2310A_ref02_FH_attending_prov_id ,
				@L2310B_nm102_entity_type_qual  = @L2310B_nm102_entity_type_qual ,
				@L2310B_nm103_operating_prov_last_nm  = @L2310B_nm103_operating_prov_last_nm ,
				@L2310B_nm104_operating_prov_first_nm  = @L2310B_nm104_operating_prov_first_nm ,
				@L2310B_nm105_operating_prov_middle_nm  = @L2310B_nm105_operating_prov_middle_nm ,
				@L2310B_nm107_operating_prov_suffix  = @L2310B_nm107_operating_prov_suffix ,
				@L2310B_nm108_id_code_qual  = @L2310B_nm108_id_code_qual ,
				@L2310B_nm109_operating_prov_id  = @L2310B_nm109_operating_prov_id ,
				@L2310B_ref02_1C_operating_prov_id  = @L2310B_ref02_1C_operating_prov_id ,
				@L2310B_ref02_1D_operating_prov_id  = @L2310B_ref02_1D_operating_prov_id ,
				@L2310B_ref02_1G_operating_prov_id  = @L2310B_ref02_1G_operating_prov_id ,
				@L2310B_ref02_EI_operating_prov_id  = @L2310B_ref02_EI_operating_prov_id ,
				@L2310B_ref02_SY_operating_prov_id  = @L2310B_ref02_SY_operating_prov_id ,
				@L2310B_ref02_FH_operating_prov_id  = @L2310B_ref02_FH_operating_prov_id ,
				@L2310C_nm102_entity_type_qual  = @L2310C_nm102_entity_type_qual ,
				@L2310C_nm103_other_prov_last_nm  = @L2310C_nm103_other_prov_last_nm ,
				@L2310C_nm104_other_prov_first_nm  = @L2310C_nm104_other_prov_first_nm ,
				@L2310C_nm105_other_prov_middle_nm  = @L2310C_nm105_other_prov_middle_nm ,
				@L2310C_nm107_other_prov_suffix  = @L2310C_nm107_other_prov_suffix ,
				@L2310C_nm108_id_code_qual  = @L2310C_nm108_id_code_qual ,
				@L2310C_nm109_other_prov_id  = @L2310C_nm109_other_prov_id ,
				@L2310C_ref02_1C_other_prov_id  = @L2310C_ref02_1C_other_prov_id ,
				@L2310C_ref02_1D_other_prov_id  = @L2310C_ref02_1D_other_prov_id ,
				@L2310C_ref02_1G_other_prov_id  = @L2310C_ref02_1G_other_prov_id ,
				@L2310C_ref02_EI_other_prov_id  = @L2310C_ref02_EI_other_prov_id ,
				@L2310C_ref02_SY_other_prov_id  = @L2310C_ref02_SY_other_prov_id ,
				@L2310C_ref02_FH_other_prov_id  = @L2310C_ref02_FH_other_prov_id ,
				@L2310E_nm101_entity_id_code  = @L2310E_nm101_entity_id_code ,
				@L2310E_nm102_entity_type_qual  = @L2310E_nm102_entity_type_qual ,
				@L2310E_nm103_service_facility_last_nm  = @L2310E_nm103_service_facility_last_nm ,
				@L2310E_nm108_id_code_qual  = @L2310E_nm108_id_code_qual ,
				@L2310E_nm109_service_facility_id  = @L2310E_nm109_service_facility_id ,
				@L2310E_n301_service_facility_address1  = @L2310E_n301_service_facility_address1 ,
				@L2310E_n302_service_facility_address2  = @L2310E_n302_service_facility_address2 ,
				@L2310E_n401_service_facility_city  = @L2310E_n401_service_facility_city ,
				@L2310E_n402_service_facility_state  = @L2310E_n402_service_facility_state ,
				@L2310E_n403_service_facility_zip  = @L2310E_n403_service_facility_zip ,
				@L2310E_n404_service_facility_country  = @L2310E_n404_service_facility_country ,
				@L2310E_ref02_1C_service_facility_id  = @L2310E_ref02_1C_service_facility_id ,
				@L2310E_ref02_1D_service_facility_id  = @L2310E_ref02_1D_service_facility_id ,
				@L2310E_ref02_1G_service_facility_id  = @L2310E_ref02_1G_service_facility_id ,
				@L2310E_ref02_G2_service_facility_id  = @L2310E_ref02_G2_service_facility_id ,
				@L2320_1_sbr01_payer_resp_seq_code  = @L2320_1_sbr01_payer_resp_seq_code ,
				@L2320_1_sbr02_ind_relationship_code  = @L2320_1_sbr02_ind_relationship_code ,
				@L2320_1_sbr03_insured_grp_policy_num  = @L2320_1_sbr03_insured_grp_policy_num ,
				@L2320_1_sbr04_insured_grp_nm  = @L2320_1_sbr04_insured_grp_nm ,
				@L2320_1_sbr09_claim_file_ind_code  = @L2320_1_sbr09_claim_file_ind_code ,
				@L2320_1_cas01_adjustment_group_code  = @L2320_1_cas01_adjustment_group_code ,
				@L2320_1_cas02_adjustment_reason_code  = @L2320_1_cas02_adjustment_reason_code ,
				@L2320_1_cas03_adjustment_amt  = @L2320_1_cas03_adjustment_amt ,
				@L2320_1_cas04_adjustment_qty  = @L2320_1_cas04_adjustment_qty ,
				@L2320_1_cas05_adjustment_reason_code  = @L2320_1_cas05_adjustment_reason_code ,
				@L2320_1_cas06_adjustment_amt  = @L2320_1_cas06_adjustment_amt ,
				@L2320_1_cas07_adjustment_qty  = @L2320_1_cas07_adjustment_qty ,
				@L2320_1_cas08_adjustment_reason_code  = @L2320_1_cas08_adjustment_reason_code ,
				@L2320_1_cas09_adjustment_amt  = @L2320_1_cas09_adjustment_amt ,
				@L2320_1_cas10_adjustment_qty  = @L2320_1_cas10_adjustment_qty ,
				@L2320_1_amt02_C4_payer_prior_pmt_amt  = @L2320_1_amt02_C4_payer_prior_pmt_amt ,
				@L2320_1_amt02_B6_cob_allowed_amt  = @L2320_1_amt02_B6_cob_allowed_amt ,
				@L2320_1_amt02_T3_cob_submitted_amt  = @L2320_1_amt02_T3_cob_submitted_amt ,
				@L2320_1_amt02_ZZ_drg_outlier_amt  = @L2320_1_amt02_ZZ_drg_outlier_amt ,
				@L2320_1_amt02_N1_cob_medicare_paid_amt  = @L2320_1_amt02_N1_cob_medicare_paid_amt ,
				@L2320_1_amt02_KF_medicare_paid_100_amt  = @L2320_1_amt02_KF_medicare_paid_100_amt ,
				@L2320_1_amt02_PG_medicare_paid_80_amt  = @L2320_1_amt02_PG_medicare_paid_80_amt ,
				@L2320_1_amt02_AA_cob_medicare_a_trust_pd_amt  = @L2320_1_amt02_AA_cob_medicare_a_trust_pd_amt ,
				@L2320_1_amt02_B1_cob_medicare_b_trust_pd_amt  = @L2320_1_amt02_B1_cob_medicare_b_trust_pd_amt ,
				@L2320_1_amt02_A8_cob_non_cvd_amt  = @L2320_1_amt02_A8_cob_non_cvd_amt ,
				@L2320_1_amt02_YT_cob_denied_amt  = @L2320_1_amt02_YT_cob_denied_amt ,
				@L2320_1_dmg02_other_subscriber_dob  = @L2320_1_dmg02_other_subscriber_dob ,
				@L2320_1_dmg03_other_subscriber_gender  = @L2320_1_dmg03_other_subscriber_gender ,
				@L2320_1_oi03_other_ins_benefit_assign_ind  = @L2320_1_oi03_other_ins_benefit_assign_ind ,
				@L2320_1_oi06_other_ins_release_of_info_code  = @L2320_1_oi06_other_ins_release_of_info_code ,
				@L2330A_1_nm101_entity_id_code  = @L2330A_1_nm101_entity_id_code ,
				@L2330A_1_nm102_entity_type_qual  = @L2330A_1_nm102_entity_type_qual ,
				@L2330A_1_nm103_other_subscriber_last_name  = @L2330A_1_nm103_other_subscriber_last_name ,
				@L2330A_1_nm104_other_subscriber_first_name  = @L2330A_1_nm104_other_subscriber_first_name ,
				@L2330A_1_nm105_other_subscriber_middle_name  = @L2330A_1_nm105_other_subscriber_middle_name ,
				@L2330A_1_nm107_other_subscriber_name_suffix  = @L2330A_1_nm107_other_subscriber_name_suffix ,
				@L2330A_1_nm108_other_subscriber_id_code_qual  = @L2330A_1_nm108_other_subscriber_id_code_qual ,
				@L2330A_1_nm109_other_subscriber_id  = @L2330A_1_nm109_other_subscriber_id ,
				@L2330B_1_nm101_entity_id_code  = @L2330B_1_nm101_entity_id_code ,
				@L2330B_1_nm102_entity_type_qual  = @L2330B_1_nm102_entity_type_qual ,
				@L2330B_1_nm103_other_payer_nm  = @L2330B_1_nm103_other_payer_nm ,
				@L2330B_1_nm108_id_code_qual  = @L2330B_1_nm108_id_code_qual ,
				@L2330B_1_nm109_other_payer_id  = @L2330B_1_nm109_other_payer_id ,
				@L2330B_1_dtp03_573_date_claim_paid  = @L2330B_1_dtp03_573_date_claim_paid ,
				@L2330B_1_ref02_2U_other_payer_secondary_id  = @L2330B_1_ref02_2U_other_payer_secondary_id ,
				@L2330B_1_ref02_F8_other_payer_secondary_id  = @L2330B_1_ref02_F8_other_payer_secondary_id ,
				@L2330B_1_ref02_FY_other_payer_secondary_id  = @L2330B_1_ref02_FY_other_payer_secondary_id ,
				@L2330B_1_ref02_NF_other_payer_secondary_id  = @L2330B_1_ref02_NF_other_payer_secondary_id ,
				@L2330B_1_ref02_TJ_other_payer_secondary_id  = @L2330B_1_ref02_TJ_other_payer_secondary_id ,
				@L2330B_1_ref02_9F_other_payer_auth_num  = @L2330B_1_ref02_9F_other_payer_auth_num ,
				@L2330B_1_ref02_G1_other_payer_auth_num  = @L2330B_1_ref02_G1_other_payer_auth_num ,
				@L2320_2_sbr01_payer_resp_seq_code  = @L2320_2_sbr01_payer_resp_seq_code ,
				@L2320_2_sbr02_ind_relationship_code  = @L2320_2_sbr02_ind_relationship_code ,
				@L2320_2_sbr03_insured_grp_policy_num  = @L2320_2_sbr03_insured_grp_policy_num ,
				@L2320_2_sbr04_insured_grp_nm  = @L2320_2_sbr04_insured_grp_nm ,
				@L2320_2_sbr09_claim_file_ind_code  = @L2320_2_sbr09_claim_file_ind_code ,
				@L2320_2_cas01_adjustment_group_code  = @L2320_2_cas01_adjustment_group_code ,
				@L2320_2_cas02_adjustment_reason_code  = @L2320_2_cas02_adjustment_reason_code ,
				@L2320_2_cas03_adjustment_amt  = @L2320_2_cas03_adjustment_amt ,
				@L2320_2_cas04_adjustment_qty  = @L2320_2_cas04_adjustment_qty ,
				@L2320_2_cas05_adjustment_reason_code  = @L2320_2_cas05_adjustment_reason_code ,
				@L2320_2_cas06_adjustment_amt  = @L2320_2_cas06_adjustment_amt ,
				@L2320_2_cas07_adjustment_qty  = @L2320_2_cas07_adjustment_qty ,
				@L2320_2_cas08_adjustment_reason_code  = @L2320_2_cas08_adjustment_reason_code ,
				@L2320_2_cas09_adjustment_amt  = @L2320_2_cas09_adjustment_amt ,
				@L2320_2_cas10_adjustment_qty  = @L2320_2_cas10_adjustment_qty ,
				@L2320_2_amt02_C4_payer_prior_pmt_amt  = @L2320_2_amt02_C4_payer_prior_pmt_amt ,
				@L2320_2_amt02_B6_cob_allowed_amt  = @L2320_2_amt02_B6_cob_allowed_amt ,
				@L2320_2_amt02_T3_cob_submitted_amt  = @L2320_2_amt02_T3_cob_submitted_amt ,
				@L2320_2_amt02_ZZ_drg_outlier_amt  = @L2320_2_amt02_ZZ_drg_outlier_amt ,
				@L2320_2_amt02_N1_cob_medicare_paid_amt  = @L2320_2_amt02_N1_cob_medicare_paid_amt ,
				@L2320_2_amt02_KF_medicare_paid_100_amt  = @L2320_2_amt02_KF_medicare_paid_100_amt ,
				@L2320_2_amt02_PG_medicare_paid_80_amt  = @L2320_2_amt02_PG_medicare_paid_80_amt ,
				@L2320_2_amt02_AA_cob_medicare_a_trust_pd_amt  = @L2320_2_amt02_AA_cob_medicare_a_trust_pd_amt ,
				@L2320_2_amt02_B1_cob_medicare_b_trust_pd_amt  = @L2320_2_amt02_B1_cob_medicare_b_trust_pd_amt ,
				@L2320_2_amt02_A8_cob_non_cvd_amt  = @L2320_2_amt02_A8_cob_non_cvd_amt ,
				@L2320_2_amt02_YT_cob_denied_amt  = @L2320_2_amt02_YT_cob_denied_amt ,
				@L2320_2_dmg02_other_subscriber_dob  = @L2320_2_dmg02_other_subscriber_dob ,
				@L2320_2_dmg03_other_subscriber_gender  = @L2320_2_dmg03_other_subscriber_gender ,
				@L2320_2_oi03_other_ins_benefit_assign_ind  = @L2320_2_oi03_other_ins_benefit_assign_ind ,
				@L2320_2_oi06_other_ins_release_of_info_code  = @L2320_2_oi06_other_ins_release_of_info_code ,
				@L2330A_2_nm101_entity_id_code  = @L2330A_2_nm101_entity_id_code ,
				@L2330A_2_nm102_entity_type_qual  = @L2330A_2_nm102_entity_type_qual ,
				@L2330A_2_nm103_other_subscriber_last_name  = @L2330A_2_nm103_other_subscriber_last_name ,
				@L2330A_2_nm104_other_subscriber_first_name  = @L2330A_2_nm104_other_subscriber_first_name ,
				@L2330A_2_nm105_other_subscriber_middle_name  = @L2330A_2_nm105_other_subscriber_middle_name ,
				@L2330A_2_nm107_other_subscriber_name_suffix  = @L2330A_2_nm107_other_subscriber_name_suffix ,
				@L2330A_2_nm108_other_subscriber_id_code_qual  = @L2330A_2_nm108_other_subscriber_id_code_qual ,
				@L2330A_2_nm109_other_subscriber_id  = @L2330A_2_nm109_other_subscriber_id ,
				@L2330B_2_nm101_entity_id_code  = @L2330B_2_nm101_entity_id_code ,
				@L2330B_2_nm102_entity_type_qual  = @L2330B_2_nm102_entity_type_qual ,
				@L2330B_2_nm103_other_payer_nm  = @L2330B_2_nm103_other_payer_nm ,
				@L2330B_2_nm108_id_code_qual  = @L2330B_2_nm108_id_code_qual ,
				@L2330B_2_nm109_other_payer_id  = @L2330B_2_nm109_other_payer_id ,
				@L2330B_2_dtp03_573_date_claim_paid  = @L2330B_2_dtp03_573_date_claim_paid ,
				@L2330B_2_ref02_2U_other_payer_secondary_id  = @L2330B_2_ref02_2U_other_payer_secondary_id ,
				@L2330B_2_ref02_F8_other_payer_secondary_id  = @L2330B_2_ref02_F8_other_payer_secondary_id ,
				@L2330B_2_ref02_FY_other_payer_secondary_id  = @L2330B_2_ref02_FY_other_payer_secondary_id ,
				@L2330B_2_ref02_NF_other_payer_secondary_id  = @L2330B_2_ref02_NF_other_payer_secondary_id ,
				@L2330B_2_ref02_TJ_other_payer_secondary_id  = @L2330B_2_ref02_TJ_other_payer_secondary_id ,
				@L2330B_2_ref02_9F_other_payer_auth_num  = @L2330B_2_ref02_9F_other_payer_auth_num ,
				@L2330B_2_ref02_G1_other_payer_auth_num  = @L2330B_2_ref02_G1_other_payer_auth_num ,
				@L2320_3_sbr01_payer_resp_seq_code  = @L2320_3_sbr01_payer_resp_seq_code ,
				@L2320_3_sbr02_ind_relationship_code  = @L2320_3_sbr02_ind_relationship_code ,
				@L2320_3_sbr03_insured_grp_policy_num  = @L2320_3_sbr03_insured_grp_policy_num ,
				@L2320_3_sbr04_insured_grp_nm  = @L2320_3_sbr04_insured_grp_nm ,
				@L2320_3_sbr09_claim_file_ind_code  = @L2320_3_sbr09_claim_file_ind_code ,
				@L2320_3_cas01_adjustment_group_code  = @L2320_3_cas01_adjustment_group_code ,
				@L2320_3_cas02_adjustment_reason_code  = @L2320_3_cas02_adjustment_reason_code ,
				@L2320_3_cas03_adjustment_amt  = @L2320_3_cas03_adjustment_amt ,
				@L2320_3_cas04_adjustment_qty  = @L2320_3_cas04_adjustment_qty ,
				@L2320_3_cas05_adjustment_reason_code  = @L2320_3_cas05_adjustment_reason_code ,
				@L2320_3_cas06_adjustment_amt  = @L2320_3_cas06_adjustment_amt ,
				@L2320_3_cas07_adjustment_qty  = @L2320_3_cas07_adjustment_qty ,
				@L2320_3_cas08_adjustment_reason_code  = @L2320_3_cas08_adjustment_reason_code ,
				@L2320_3_cas09_adjustment_amt  = @L2320_3_cas09_adjustment_amt ,
				@L2320_3_cas10_adjustment_qty  = @L2320_3_cas10_adjustment_qty ,
				@L2320_3_amt02_C4_payer_prior_pmt_amt  = @L2320_3_amt02_C4_payer_prior_pmt_amt ,
				@L2320_3_amt02_B6_cob_allowed_amt  = @L2320_3_amt02_B6_cob_allowed_amt ,
				@L2320_3_amt02_T3_cob_submitted_amt  = @L2320_3_amt02_T3_cob_submitted_amt ,
				@L2320_3_amt02_ZZ_drg_outlier_amt  = @L2320_3_amt02_ZZ_drg_outlier_amt ,
				@L2320_3_amt02_N1_cob_medicare_paid_amt  = @L2320_3_amt02_N1_cob_medicare_paid_amt ,
				@L2320_3_amt02_KF_medicare_paid_100_amt  = @L2320_3_amt02_KF_medicare_paid_100_amt ,
				@L2320_3_amt02_PG_medicare_paid_80_amt  = @L2320_3_amt02_PG_medicare_paid_80_amt ,
				@L2320_3_amt02_AA_cob_medicare_a_trust_pd_amt  = @L2320_3_amt02_AA_cob_medicare_a_trust_pd_amt ,
				@L2320_3_amt02_B1_cob_medicare_b_trust_pd_amt  = @L2320_3_amt02_B1_cob_medicare_b_trust_pd_amt ,
				@L2320_3_amt02_A8_cob_non_cvd_amt  = @L2320_3_amt02_A8_cob_non_cvd_amt ,
				@L2320_3_amt02_YT_cob_denied_amt  = @L2320_3_amt02_YT_cob_denied_amt ,
				@L2320_3_dmg02_other_subscriber_dob  = @L2320_3_dmg02_other_subscriber_dob ,
				@L2320_3_dmg03_other_subscriber_gender  = @L2320_3_dmg03_other_subscriber_gender ,
				@L2320_3_oi03_other_ins_benefit_assign_ind  = @L2320_3_oi03_other_ins_benefit_assign_ind ,
				@L2320_3_oi06_other_ins_release_of_info_code  = @L2320_3_oi06_other_ins_release_of_info_code ,
				@L2330A_3_nm101_entity_id_code  = @L2330A_3_nm101_entity_id_code ,
				@L2330A_3_nm102_entity_type_qual  = @L2330A_3_nm102_entity_type_qual ,
				@L2330A_3_nm103_other_subscriber_last_name  = @L2330A_3_nm103_other_subscriber_last_name ,
				@L2330A_3_nm104_other_subscriber_first_name  = @L2330A_3_nm104_other_subscriber_first_name ,
				@L2330A_3_nm105_other_subscriber_middle_name  = @L2330A_3_nm105_other_subscriber_middle_name ,
				@L2330A_3_nm107_other_subscriber_name_suffix  = @L2330A_3_nm107_other_subscriber_name_suffix ,
				@L2330A_3_nm108_other_subscriber_id_code_qual  = @L2330A_3_nm108_other_subscriber_id_code_qual ,
				@L2330A_3_nm109_other_subscriber_id  = @L2330A_3_nm109_other_subscriber_id ,
				@L2330B_3_nm101_entity_id_code  = @L2330B_3_nm101_entity_id_code ,
				@L2330B_3_nm102_entity_type_qual  = @L2330B_3_nm102_entity_type_qual ,
				@L2330B_3_nm103_other_payer_nm  = @L2330B_3_nm103_other_payer_nm ,
				@L2330B_3_nm108_id_code_qual  = @L2330B_3_nm108_id_code_qual ,
				@L2330B_3_nm109_other_payer_id  = @L2330B_3_nm109_other_payer_id ,
				@L2330B_3_dtp03_573_date_claim_paid  = @L2330B_3_dtp03_573_date_claim_paid ,
				@L2330B_3_ref02_2U_other_payer_secondary_id  = @L2330B_3_ref02_2U_other_payer_secondary_id ,
				@L2330B_3_ref02_F8_other_payer_secondary_id  = @L2330B_3_ref02_F8_other_payer_secondary_id ,
				@L2330B_3_ref02_FY_other_payer_secondary_id  = @L2330B_3_ref02_FY_other_payer_secondary_id ,
				@L2330B_3_ref02_NF_other_payer_secondary_id  = @L2330B_3_ref02_NF_other_payer_secondary_id ,
				@L2330B_3_ref02_TJ_other_payer_secondary_id  = @L2330B_3_ref02_TJ_other_payer_secondary_id ,
				@L2330B_3_ref02_9F_other_payer_auth_num  = @L2330B_3_ref02_9F_other_payer_auth_num ,
				@L2330B_3_ref02_G1_other_payer_auth_num  = @L2330B_3_ref02_G1_other_payer_auth_num ,
				@L2400_lx01_assigned_num  = @L2400_lx01_assigned_num ,
				@L2400_sv201_rev_code  = @L2400_sv201_rev_code ,
				@L2400_sv202_proc_code_qual  = @L2400_sv202_proc_code_qual ,
				@L2400_sv202_proc_code  = @L2400_sv202_proc_code ,
				@L2400_sv202_proc_mod1  = @L2400_sv202_proc_mod1 ,
				@L2400_sv202_proc_mod2  = @L2400_sv202_proc_mod2 ,
				@L2400_sv202_proc_mod3  = @L2400_sv202_proc_mod3 ,
				@L2400_sv202_proc_mod4  = @L2400_sv202_proc_mod4 ,
				@L2400_sv203_line_charge  = @L2400_sv203_line_charge ,
				@L2400_sv204_measurement_code  = @L2400_sv204_measurement_code ,
				@L2400_sv205_service_unit_count  = @L2400_sv205_service_unit_count ,
				@L2400_sv206_service_line_rate  = @L2400_sv206_service_line_rate ,
				@L2400_sv207_denied_amt  = @L2400_sv207_denied_amt ,
				@L2400_dtp02_472_from_service_date  = @L2400_dtp02_472_from_service_date ,
				@L2400_dtp02_472_to_service_date  = @L2400_dtp02_472_to_service_date ,
				@L2400_dtp02_866_format_qual  = @L2400_dtp02_866_format_qual ,
				@L2400_dtp02_866_assess_date  = @L2400_dtp02_866_assess_date ,
				@L2410_1_lin03_N4_ndc  = @L2410_1_lin03_N4_ndc ,
				@L2420A_nm102_entity_type_qual  = @L2420A_nm102_entity_type_qual ,
				@L2420A_nm103_attending_physician_last_nm  = @L2420A_nm103_attending_physician_last_nm ,
				@L2420A_nm104_attending_physician_first_nm  = @L2420A_nm104_attending_physician_first_nm ,
				@L2420A_nm105_attending_physician_middle_nm  = @L2420A_nm105_attending_physician_middle_nm ,
				@L2420A_nm107_attending_physician_suffix  = @L2420A_nm107_attending_physician_suffix ,
				@L2420A_nm108_id_code_qual  = @L2420A_nm108_id_code_qual ,
				@L2420A_nm109_attending_physician_id  = @L2420A_nm109_attending_physician_id ,
				@L2420A_ref02_1C_attending_prov_id  = @L2420A_ref02_1C_attending_prov_id ,
				@L2420A_ref02_1D_attending_prov_id  = @L2420A_ref02_1D_attending_prov_id ,
				@L2420A_ref02_1G_attending_prov_id  = @L2420A_ref02_1G_attending_prov_id ,
				@L2420A_ref02_EI_attending_prov_id  = @L2420A_ref02_EI_attending_prov_id ,
				@L2420A_ref02_SY_attending_prov_id  = @L2420A_ref02_SY_attending_prov_id ,
				@L2420A_ref02_FH_attending_prov_id  = @L2420A_ref02_FH_attending_prov_id ,
				@L2420B_nm102_entity_type_qual  = @L2420B_nm102_entity_type_qual ,
				@L2420B_nm103_operating_prov_last_nm  = @L2420B_nm103_operating_prov_last_nm ,
				@L2420B_nm104_operating_prov_first_nm  = @L2420B_nm104_operating_prov_first_nm ,
				@L2420B_nm105_operating_prov_middle_nm  = @L2420B_nm105_operating_prov_middle_nm ,
				@L2420B_nm107_operating_prov_suffix  = @L2420B_nm107_operating_prov_suffix ,
				@L2420B_nm108_id_code_qual  = @L2420B_nm108_id_code_qual ,
				@L2420B_nm109_operating_prov_id  = @L2420B_nm109_operating_prov_id ,
				@L2420B_ref02_1C_operating_prov_id  = @L2420B_ref02_1C_operating_prov_id ,
				@L2420B_ref02_1D_operating_prov_id  = @L2420B_ref02_1D_operating_prov_id ,
				@L2420B_ref02_1G_operating_prov_id  = @L2420B_ref02_1G_operating_prov_id ,
				@L2420B_ref02_EI_operating_prov_id  = @L2420B_ref02_EI_operating_prov_id ,
				@L2420B_ref02_SY_operating_prov_id  = @L2420B_ref02_SY_operating_prov_id ,
				@L2420B_ref02_FH_operating_prov_id  = @L2420B_ref02_FH_operating_prov_id ,
				@L2420C_nm102_entity_type_qual  = @L2420C_nm102_entity_type_qual ,
				@L2420C_nm103_other_prov_last_nm  = @L2420C_nm103_other_prov_last_nm ,
				@L2420C_nm104_other_prov_first_nm  = @L2420C_nm104_other_prov_first_nm ,
				@L2420C_nm105_other_prov_middle_nm  = @L2420C_nm105_other_prov_middle_nm ,
				@L2420C_nm107_other_prov_suffix  = @L2420C_nm107_other_prov_suffix ,
				@L2420C_nm108_id_code_qual  = @L2420C_nm108_id_code_qual ,
				@L2420C_nm109_other_prov_id  = @L2420C_nm109_other_prov_id ,
				@L2420C_ref02_1C_other_prov_id  = @L2420C_ref02_1C_other_prov_id ,
				@L2420C_ref02_1D_other_prov_id  = @L2420C_ref02_1D_other_prov_id ,
				@L2420C_ref02_1G_other_prov_id  = @L2420C_ref02_1G_other_prov_id ,
				@L2420C_ref02_G2_other_prov_id  = @L2420C_ref02_G2_other_prov_id ,
				@L2430_svd01_payer_id  = @L2430_svd01_payer_id ,
				@L2430_svd02_service_line_paid  = @L2430_svd02_service_line_paid ,
				@L2430_svd03_proc_code_qual  = @L2430_svd03_proc_code_qual ,
				@L2430_svd03_proc_code  = @L2430_svd03_proc_code ,
				@L2430_svd03_proc_mod1  = @L2430_svd03_proc_mod1 ,
				@L2430_svd03_proc_mod2  = @L2430_svd03_proc_mod2 ,
				@L2430_svd03_proc_mod3  = @L2430_svd03_proc_mod3 ,
				@L2430_svd03_proc_mod4  = @L2430_svd03_proc_mod4 ,
				@L2430_svd04_rev_code  = @L2430_svd04_rev_code ,
				@L2430_svd05_adj_qty  = @L2430_svd05_adj_qty ,
				@L2430_svd06_bundled_line_num  = @L2430_svd06_bundled_line_num ,
				@L2430_cas01_adjustment_group_code  = @L2430_cas01_adjustment_group_code ,
				@L2430_cas02_adjustment_reason_code  = @L2430_cas02_adjustment_reason_code ,
				@L2430_cas03_adjustment_amt  = @L2430_cas03_adjustment_amt ,
				@L2430_cas04_adjustment_qty  = @L2430_cas04_adjustment_qty ,
				@L2430_cas05_adjustment_reason_code  = @L2430_cas05_adjustment_reason_code ,
				@L2430_cas06_adjustment_amt  = @L2430_cas06_adjustment_amt ,
				@L2430_cas07_adjustment_qty  = @L2430_cas07_adjustment_qty ,
				@L2430_cas08_adjustment_reason_code  = @L2430_cas08_adjustment_reason_code ,
				@L2430_cas09_adjustment_amt  = @L2430_cas09_adjustment_amt ,
				@L2430_cas10_adjustment_qty  = @L2430_cas10_adjustment_qty ,
				@L2430_dtp03_573_service_adjudication_date = @L2430_dtp03_573_service_adjudication_date

return (0)


