


CREATE Procedure [dbo].[up_x12_837d_parse] (@x12_transaction_id int, @se01_num_transaction_segments int = null output)
As

SET NOCOUNT ON -- We don't need to report row-counts when running this.

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

declare @bht01_hierarchical_structure_code	char(4)
declare @bht02_trans_set_purpose_code	char(2)
declare @bht03_orig_app_tran_id	varchar(30)
declare @bht04_trans_set_creation_date	varchar(8)
declare @bht05_trans_set_creation_time	varchar(8)
declare @bht06_claim_encounter_id	char(2)
declare @ref01_receiver_ref_id_qual	char(3)
declare @ref02_transmission_type_code	varchar(30)
declare @L1000A_nm102_entity_type_qual	char(1)
declare @L1000A_nm103_submitter_last_nm	varchar(35)
declare @L1000A_nm104_submitter_first_nm	varchar(25)
declare @L1000A_nm105_submitter_middle_nm	varchar(25)
declare @L1000A_nm108_submitter_id_qual	char(2)
declare @L1000A_nm109_submitter_id	varchar(80)
declare @L1000A_per01_contact_function_code	char(2)
declare @L1000A_per02_contact_nm	varchar(60)
declare @L1000A_per03_comm_num_qual	char(2)
declare @L1000A_per04_comm_number	varchar(80)
declare @L1000B_nm102_entity_type_qual	char(1)
declare @L1000B_nm103_receiver_last_nm	varchar(35)
declare @L1000B_nm108_receiver_id_qual	char(2)
declare @L1000B_nm109_receiver_id	varchar(80)
declare @L2000A_hl01_hierarchical_id_num	varchar(12)
declare @L2000A_hl03_hierarchical_level_code	char(2)
declare @L2000A_hl04_hierarchical_child_code	char(1)
declare @L2000A_prv01_provider_code	char(3)
declare @L2000A_prv02_ref_id_qual	char(3)
declare @L2000A_prv03_taxonomy_code	varchar(30)
declare @L2000A_cur02_currency_code	char(3)
declare @L2010AA_nm102_entity_type_qual	char(1)
declare @L2010AA_nm103_billing_prov_last_nm	varchar(35)
declare @L2010AA_nm104_billing_prov_first_nm	varchar(25)
declare @L2010AA_nm105_billing_prov_middle_nm	varchar(25)
declare @L2010AA_nm107_billing_prov_suffix	varchar(10)
declare @L2010AA_nm108_id_code_qual	char(2)
declare @L2010AA_nm109_billing_prov_id	varchar(80)
declare @L2010AA_n301_billing_prov_address1	varchar(55)
declare @L2010AA_n302_billing_prov_address2	varchar(55)
declare @L2010AA_n401_billing_prov_city	varchar(30)
declare @L2010AA_n402_billing_prov_state	char(2)
declare @L2010AA_n403_billing_prov_zip	varchar(15)
declare @L2010AA_n404_billing_prov_country	char(3)
declare @L2010AA_ref02_1C_billing_prov_id	varchar(30)
declare @L2010AA_ref02_1D_billing_prov_id	varchar(30)
declare @L2010AA_ref02_1E_billing_prov_id	varchar(30)
declare @L2010AA_ref02_EI_billing_prov_id	varchar(30)
declare @L2010AA_ref02_SY_billing_prov_id	varchar(30)
declare @L2010AA_ref02_TJ_billing_prov_id	varchar(30)
declare @L2010AA_ref02_06_card_billing_id	varchar(30)
declare @L2010AA_ref02_8U_card_billing_id	varchar(30)
declare @L2010AA_ref02_EM_card_billing_id	varchar(30)
declare @L2010AA_ref02_IJ_card_billing_id	varchar(30)
declare @L2010AA_ref02_LU_card_billing_id	varchar(30)
declare @L2010AA_ref02_ST_card_billing_id	varchar(30)
declare @L2010AB_nm102_entity_type_qual	char(1)
declare @L2010AB_nm103_payto_prov_last_nm	varchar(35)
declare @L2010AB_nm104_payto_prov_first_nm	varchar(25)
declare @L2010AB_nm105_payto_prov_middle_nm	varchar(25)
declare @L2010AB_nm107_payto_prov_suffix	varchar(10)
declare @L2010AB_nm108_id_code_qual	char(2)
declare @L2010AB_nm109_payto_prov_id	varchar(80)
declare @L2010AB_n301_payto_prov_address1	varchar(55)
declare @L2010AB_n302_payto_prov_address2	varchar(55)
declare @L2010AB_n401_payto_prov_city	varchar(30)
declare @L2010AB_n402_payto_prov_state	char(2)
declare @L2010AB_n403_payto_prov_zip	varchar(15)
declare @L2010AB_n404_payto_prov_country	char(3)
declare @L2010AB_ref02_1C_payto_prov_id	varchar(30)
declare @L2010AB_ref02_1D_payto_prov_id	varchar(30)
declare @L2010AB_ref02_1E_payto_prov_id	varchar(30)
declare @L2010AB_ref02_EI_payto_prov_id	varchar(30)
declare @L2010AB_ref02_SY_payto_prov_id	varchar(30)
declare @L2010AB_ref02_TJ_payto_prov_id	varchar(30)
declare @L2000B_hl01_hierarchical_id_num	varchar(12)
declare @L2000B_hl02_hierarchical_parent_id_num	varchar(12)
declare @L2000B_hl03_hierarchical_level_code	char(2)
declare @L2000B_hl04_hierarchical_child_code	char(1)
declare @L2000B_sbr01_payer_resp_seq_code	char(1)
declare @L2000B_sbr02_ind_relationship_code	char(2)
declare @L2000B_sbr03_insured_grp_policy_num	varchar(30)
declare @L2000B_sbr04_insured_grp_nm	varchar(60)
declare @L2000B_sbr06_cob_code	char(1)
declare @L2000B_sbr09_claim_filing_ind_code	char(2)
declare @L2010BA_nm102_entity_type_qual	char(1)
declare @L2010BA_nm103_subscriber_last_nm	varchar(35)
declare @L2010BA_nm104_subscriber_first_nm	varchar(25)
declare @L2010BA_nm105_subscriber_middle_nm	varchar(25)
declare @L2010BA_nm107_subscriber_suffix	varchar(10)
declare @L2010BA_nm108_id_code_qual	char(2)
declare @L2010BA_nm109_subscriber_id	varchar(80)
declare @L2010BA_n301_subscriber_address1	varchar(55)
declare @L2010BA_n302_subscriber_address2	varchar(55)
declare @L2010BA_n401_subscriber_city	varchar(30)
declare @L2010BA_n402_subscriber_state	char(2)
declare @L2010BA_n403_subscriber_zip	varchar(15)
declare @L2010BA_n404_subscriber_country	char(3)
declare @L2010BA_dmg02_subscriber_dob	varchar(35)
declare @L2010BA_dmg03_subscriber_gender	char(1)
declare @L2010BA_ref02_1W_subscriber_sup_id	varchar(30)
declare @L2010BA_ref02_23_subscriber_sup_id	varchar(30)
declare @L2010BA_ref02_IG_subscriber_sup_id	varchar(30)
declare @L2010BA_ref02_SY_subscriber_sup_id	varchar(30)
declare @L2010BA_ref02_Y4_prop_casualty_claim_num	varchar(30)
declare @L2010BB_nm102_entity_type_qual	char(1)
declare @L2010BB_nm103_payer_nm	varchar(35)
declare @L2010BB_nm108_payer_id_qual	char(2)
declare @L2010BB_nm109_payer_id	varchar(80)
declare @L2010BB_n301_payer_address1	varchar(55)
declare @L2010BB_n302_payer_address2	varchar(55)
declare @L2010BB_n401_payer_city	varchar(30)
declare @L2010BB_n402_payer_state	char(2)
declare @L2010BB_n403_payer_zip	varchar(15)
declare @L2010BB_n404_payer_country	char(3)
declare @L2010BB_ref02_2U_payer_id	varchar(30)
declare @L2010BB_ref02_FY_payer_id	varchar(30)
declare @L2010BB_ref02_NF_payer_id	varchar(30)
declare @L2010BB_ref02_TJ_payer_id	varchar(30)
declare @L2010BC_nm102_entity_type_qual	char(1)
declare @L2010BC_nm103_resp_party_last_nm	varchar(35)
declare @L2010BC_nm104_resp_party_first_nm	varchar(25)
declare @L2010BC_nm105_resp_party_middle_nm	varchar(25)
declare @L2010BC_nm107_resp_party_suffix	varchar(10)
declare @L2010BC_nm109_MI_card_num	varchar(80)
declare @L2010BC_ref02_BB_card_num	varchar(30)
declare @L2000C_hl01_hierarchical_id_num	varchar(12)
declare @L2000C_hl02_hierarchical_parent_id_num	varchar(12)
declare @L2000C_hl03_hierarchical_level_code	char(2)
declare @L2000C_hl04_hierarchical_child_code	char(1)
declare @L2000C_pat01_ind_relationship_code	char(2)
declare @L2000C_pat04_student_status_code	char(1)
declare @L2010CA_nm102_entity_type_qual	char(1)
declare @L2010CA_nm103_patient_last_nm	varchar(35)
declare @L2010CA_nm104_patient_first_nm	varchar(25)
declare @L2010CA_nm105_patient_middle_nm	varchar(25)
declare @L2010CA_nm107_patient_suffix	varchar(10)
declare @L2010CA_nm108_id_code_qual	char(2)
declare @L2010CA_nm109_patient_id	varchar(80)
declare @L2010CA_n301_patient_address1	varchar(55)
declare @L2010CA_n302_patient_address2	varchar(55)
declare @L2010CA_n401_patient_city	varchar(30)
declare @L2010CA_n402_patient_state	char(2)
declare @L2010CA_n403_patient_zip	varchar(15)
declare @L2010CA_n404_patient_country	char(3)
declare @L2010CA_dmg02_patient_dob	varchar(35)
declare @L2010CA_dmg03_patient_gender	char(1)
declare @L2010CA_ref02_1W_patient_sup_id	varchar(30)
declare @L2010CA_ref02_23_patient_sup_id	varchar(30)
declare @L2010CA_ref02_IG_patient_sup_id	varchar(30)
declare @L2010CA_ref02_SY_patient_sup_id	varchar(30)
declare @L2010CA_ref02_Y4_prop_casualty_claim_num	varchar(30)
declare @L2300_clm01_pt_acct_num	varchar(38)
declare @L2300_clm02_total_claim_chg_amt	money
declare @L2300_clm05_facility_type_code	char(2)
declare @L2300_clm05_claim_freq_code	char(1)
declare @L2300_clm06_provider_signature_ind	char(1)
declare @L2300_clm07_medicare_assign_code	char(1)
declare @L2300_clm08_benefit_assign_ind	char(1)
declare @L2300_clm09_release_of_info_code	char(1)
declare @L2300_clm11_related_causes_code1	char(3)
declare @L2300_clm11_related_causes_code2	char(3)
declare @L2300_clm11_related_causes_code3	char(3)
declare @L2300_clm11_auto_accident_state_code	char(2)
declare @L2300_clm11_country_code	char(3)
declare @L2300_clm12_special_prog_ind	char(3)
declare @L2300_clm19_claim_submission_reason_code	char(2)
declare @L2300_clm20_delay_reason_code	char(2)
declare @L2300_dtp03_435_related_hospitalization_admission_date	varchar(35)
declare @L2300_dtp03_096_discharge_end_of_care_date	varchar(35)
declare @L2300_dtp03_330_referral_date	varchar(35)
declare @L2300_dtp03_439_accident_date	varchar(35)
declare @L2300_dtp03_452_orthodontic_banding_date	varchar(35)
declare @L2300_dtp03_472_service_date	varchar(35)
declare @L2300_dn101_orthodontic_treatment_months_count	varchar(15)
declare @L2300_dn102_orthodontic_treatment_months_remaining_count	varchar(15)
declare @L2300_dn103_question_response	char(1)
declare @L2300_1_dn201_tooth_number varchar(30)
declare @L2300_1_dn202_tooth_status_code varchar(2)
declare @L2300_2_dn201_tooth_number varchar(30)
declare @L2300_2_dn202_tooth_status_code varchar(2)
declare @L2300_3_dn201_tooth_number varchar(30)
declare @L2300_3_dn202_tooth_status_code varchar(2)
declare @L2300_4_dn201_tooth_number varchar(30)
declare @L2300_4_dn202_tooth_status_code varchar(2)
declare @L2300_5_dn201_tooth_number varchar(30)
declare @L2300_5_dn202_tooth_status_code varchar(2)
declare @L2300_6_dn201_tooth_number varchar(30)
declare @L2300_6_dn202_tooth_status_code varchar(2)
declare @L2300_7_dn201_tooth_number varchar(30)
declare @L2300_7_dn202_tooth_status_code varchar(2)
declare @L2300_8_dn201_tooth_number varchar(30)
declare @L2300_8_dn202_tooth_status_code varchar(2)
declare @L2300_9_dn201_tooth_number varchar(30)
declare @L2300_9_dn202_tooth_status_code varchar(2)
declare @L2300_10_dn201_tooth_number varchar(30)
declare @L2300_10_dn202_tooth_status_code varchar(2)
declare @L2300_11_dn201_tooth_number varchar(30)
declare @L2300_11_dn202_tooth_status_code varchar(2)
declare @L2300_12_dn201_tooth_number varchar(30)
declare @L2300_12_dn202_tooth_status_code varchar(2)
declare @L2300_13_dn201_tooth_number varchar(30)
declare @L2300_13_dn202_tooth_status_code varchar(2)
declare @L2300_14_dn201_tooth_number varchar(30)
declare @L2300_14_dn202_tooth_status_code varchar(2)
declare @L2300_15_dn201_tooth_number varchar(30)
declare @L2300_15_dn202_tooth_status_code varchar(2)
declare @L2300_16_dn201_tooth_number varchar(30)
declare @L2300_16_dn202_tooth_status_code varchar(2)
declare @L2300_17_dn201_tooth_number varchar(30)
declare @L2300_17_dn202_tooth_status_code varchar(2)
declare @L2300_18_dn201_tooth_number varchar(30)
declare @L2300_18_dn202_tooth_status_code varchar(2)
declare @L2300_19_dn201_tooth_number varchar(30)
declare @L2300_19_dn202_tooth_status_code varchar(2)
declare @L2300_20_dn201_tooth_number varchar(30)
declare @L2300_20_dn202_tooth_status_code varchar(2)
declare @L2300_21_dn201_tooth_number varchar(30)
declare @L2300_21_dn202_tooth_status_code varchar(2)
declare @L2300_22_dn201_tooth_number varchar(30)
declare @L2300_22_dn202_tooth_status_code varchar(2)
declare @L2300_23_dn201_tooth_number varchar(30)
declare @L2300_23_dn202_tooth_status_code varchar(2)
declare @L2300_24_dn201_tooth_number varchar(30)
declare @L2300_24_dn202_tooth_status_code varchar(2)
declare @L2300_25_dn201_tooth_number varchar(30)
declare @L2300_25_dn202_tooth_status_code varchar(2)
declare @L2300_26_dn201_tooth_number varchar(30)
declare @L2300_26_dn202_tooth_status_code varchar(2)
declare @L2300_27_dn201_tooth_number varchar(30)
declare @L2300_27_dn202_tooth_status_code varchar(2)
declare @L2300_28_dn201_tooth_number varchar(30)
declare @L2300_28_dn202_tooth_status_code varchar(2)
declare @L2300_29_dn201_tooth_number varchar(30)
declare @L2300_29_dn202_tooth_status_code varchar(2)
declare @L2300_30_dn201_tooth_number varchar(30)
declare @L2300_30_dn202_tooth_status_code varchar(2)
declare @L2300_31_dn201_tooth_number varchar(30)
declare @L2300_31_dn202_tooth_status_code varchar(2)
declare @L2300_32_dn201_tooth_number varchar(30)
declare @L2300_32_dn202_tooth_status_code varchar(2)
declare @L2300_33_dn201_tooth_number varchar(30)
declare @L2300_33_dn202_tooth_status_code varchar(2)
declare @L2300_34_dn201_tooth_number varchar(30)
declare @L2300_34_dn202_tooth_status_code varchar(2)
declare @L2300_35_dn201_tooth_number varchar(30)
declare @L2300_35_dn202_tooth_status_code varchar(2)
declare @L2300_pwk01_attachment_type_code	char(2)
declare @L2300_pwk02_attachment_trans_code	char(2)
declare @L2300_pwk06_attachment_control_num	varchar(80)
declare @L2300_amt02_patient_paid_amt	money
declare @L2300_amt02_card_maximum_amt	money
declare @L2300_ref02_G3_predetermination_id	varchar(30)
declare @L2300_ref02_4N_service_auth_exception_code	varchar(30)
declare @L2300_ref02_F8_original_ref_num	varchar(30)
declare @L2300_ref02_9F_referral_num	varchar(30)
declare @L2300_ref02_G1_prior_auth_num	varchar(30)
declare @L2300_ref02_D9_value_added_network_trace_num	varchar(30)
declare @L2300_nte01_note_ref_code	char(3)
declare @L2300_nte02_claim_note_text	varchar(80)
declare @L2310A_nm101_entity_id_code	char(3)
declare @L2310A_nm102_entity_type_qual	char(1)
declare @L2310A_nm103_referring_prov_last_nm	varchar(35)
declare @L2310A_nm104_referring_prov_first_nm	varchar(25)
declare @L2310A_nm105_referring_prov_middle_nm	varchar(25)
declare @L2310A_nm107_referring_prov_suffix	varchar(10)
declare @L2310A_nm108_id_code_qual	char(2)
declare @L2310A_nm109_referring_prov_id	varchar(80)
declare @L2310A_prv01_provider_code	char(3)
declare @L2310A_prv02_ref_id_qual	char(3)
declare @L2310A_prv03_taxonomy_code	varchar(30)
declare @L2310A_ref02_1C_referring_prov_id	varchar(30)
declare @L2310A_ref02_1D_referring_prov_id	varchar(30)
declare @L2310A_ref02_1E_referring_prov_id	varchar(30)
declare @L2310A_ref02_EI_referring_prov_id	varchar(30)
declare @L2310A_ref02_G2_referring_prov_id	varchar(30)
declare @L2310A_ref02_SY_referring_prov_id	varchar(30)
declare @L2310A_ref02_TJ_referring_prov_id	varchar(30)
declare @L2310B_nm102_entity_type_qual char(1)
declare @L2310B_nm103_rendering_prov_last_nm	varchar(35)
declare @L2310B_nm104_rendering_prov_first_nm	varchar(25)
declare @L2310B_nm105_rendering_prov_middle_nm	varchar(25)
declare @L2310B_nm107_rendering_prov_suffix	varchar(10)
declare @L2310B_nm108_id_code_qual	char(2)
declare @L2310B_nm109_rendering_prov_id	varchar(80)
declare @L2310B_prv01_provider_code	char(3)
declare @L2310B_prv02_ref_id_qual	char(3)
declare @L2310B_prv03_taxonomy_code	varchar(30)
declare @L2310B_ref02_1C_rendering_prov_id	varchar(30)
declare @L2310B_ref02_1D_rendering_prov_id	varchar(30)
declare @L2310B_ref02_1E_rendering_prov_id	varchar(30)
declare @L2310B_ref02_EI_rendering_prov_id	varchar(30)
declare @L2310B_ref02_G2_rendering_prov_id	varchar(30)
declare @L2310B_ref02_SY_rendering_prov_id	varchar(30)
declare @L2310B_ref02_TJ_rendering_prov_id	varchar(30)
declare @L2310C_nm102_entity_type_qual	char(1)
declare @L2310C_nm103_service_facility_last_nm	varchar(35)
declare @L2310C_nm108_id_code_qual	char(2)
declare @L2310C_nm109_service_facility_id	varchar(80)
declare @L2310C_ref02_1C_lab_or_facility_prov_id	varchar(30)
declare @L2310C_ref02_1D_lab_or_facility_prov_id	varchar(30)
declare @L2310C_ref02_1G_lab_or_facility_prov_id	varchar(30)
declare @L2310C_ref02_G2_lab_or_facility_prov_id	varchar(30)
declare @L2310C_ref02_TJ_lab_or_facility_prov_id	varchar(30)
declare @L2310D_nm102_entity_type_qual	char(1)
declare @L2310D_nm103_assistant_surgeon_last_nm	varchar(35)
declare @L2310D_nm104_assistant_surgeon_first_nm	varchar(25)
declare @L2310D_nm105_assistant_surgeon_middle_nm	varchar(25)
declare @L2310D_nm107_assistant_surgeon_suffix	varchar(10)
declare @L2310D_nm108_id_code_qual	char(2)
declare @L2310D_nm109_assistant_surgeon_prov_id	varchar(80)
declare @L2310D_prv01_provider_code	char(3)
declare @L2310D_prv02_id_code_qual	char(2)
declare @L2310D_prv03_taxonomy_code	varchar(30)
declare @L2310D_ref02_1C_service_facility_id	varchar(30)
declare @L2310D_ref02_1D_service_facility_id	varchar(30)
declare @L2310D_ref02_1E_service_facility_id	varchar(30)
declare @L2310D_ref02_G2_service_facility_id	varchar(30)
declare @L2310D_ref02_TJ_service_facility_id	varchar(30)
declare @L2320_1_sbr01_payer_resp_seq_code	char(1)
declare @L2320_1_sbr02_ind_relationship_code	char(2)
declare @L2320_1_sbr03_insured_grp_policy_num	varchar(30)
declare @L2320_1_sbr04_insured_grp_nm	varchar(60)
declare @L2320_1_sbr09_claim_file_ind_code	char(3)
declare @L2320_1_1_cas01_adjustment_group_code	char(2)
declare @L2320_1_1_cas02_adjustment_reason_code	varchar(5)
declare @L2320_1_1_cas03_adjustment_amt	money
declare @L2320_1_1_cas04_adjustment_qty	varchar(15)
declare @L2320_1_1_cas05_adjustment_reason_code	varchar(5)
declare @L2320_1_1_cas06_adjustment_amt	money
declare @L2320_1_1_cas07_adjustment_qty	varchar(15)
declare @L2320_1_1_cas08_adjustment_reason_code	varchar(5)
declare @L2320_1_1_cas09_adjustment_amt	money
declare @L2320_1_1_cas10_adjustment_qty	varchar(15)
declare @L2320_1_2_cas01_adjustment_group_code	char(2)
declare @L2320_1_2_cas02_adjustment_reason_code	varchar(5)
declare @L2320_1_2_cas03_adjustment_amt	money
declare @L2320_1_2_cas04_adjustment_qty	varchar(15)
declare @L2320_1_2_cas05_adjustment_reason_code	varchar(5)
declare @L2320_1_2_cas06_adjustment_amt	money
declare @L2320_1_2_cas07_adjustment_qty	varchar(15)
declare @L2320_1_2_cas08_adjustment_reason_code	varchar(5)
declare @L2320_1_2_cas09_adjustment_amt	money
declare @L2320_1_2_cas10_adjustment_qty	varchar(15)
declare @L2320_1_3_cas01_adjustment_group_code	char(2)
declare @L2320_1_3_cas02_adjustment_reason_code	varchar(5)
declare @L2320_1_3_cas03_adjustment_amt	money
declare @L2320_1_3_cas04_adjustment_qty	varchar(15)
declare @L2320_1_3_cas05_adjustment_reason_code	varchar(5)
declare @L2320_1_3_cas06_adjustment_amt	money
declare @L2320_1_3_cas07_adjustment_qty	varchar(15)
declare @L2320_1_3_cas08_adjustment_reason_code	varchar(5)
declare @L2320_1_3_cas09_adjustment_amt	money
declare @L2320_1_3_cas10_adjustment_qty	varchar(15)
declare @L2320_1_4_cas01_adjustment_group_code	char(2)
declare @L2320_1_4_cas02_adjustment_reason_code	varchar(5)
declare @L2320_1_4_cas03_adjustment_amt	money
declare @L2320_1_4_cas04_adjustment_qty	varchar(15)
declare @L2320_1_4_cas05_adjustment_reason_code	varchar(5)
declare @L2320_1_4_cas06_adjustment_amt	money
declare @L2320_1_4_cas07_adjustment_qty	varchar(15)
declare @L2320_1_4_cas08_adjustment_reason_code	varchar(5)
declare @L2320_1_4_cas09_adjustment_amt	money
declare @L2320_1_4_cas10_adjustment_qty	varchar(15)
declare @L2320_1_5_cas01_adjustment_group_code	char(2)
declare @L2320_1_5_cas02_adjustment_reason_code	varchar(5)
declare @L2320_1_5_cas03_adjustment_amt	money
declare @L2320_1_5_cas04_adjustment_qty	varchar(15)
declare @L2320_1_5_cas05_adjustment_reason_code	varchar(5)
declare @L2320_1_5_cas06_adjustment_amt	money
declare @L2320_1_5_cas07_adjustment_qty	varchar(15)
declare @L2320_1_5_cas08_adjustment_reason_code	varchar(5)
declare @L2320_1_5_cas09_adjustment_amt	money
declare @L2320_1_5_cas10_adjustment_qty	varchar(15)
declare @L2320_1_amt02_D_payer_paid_amt	money
declare @L2320_1_amt02_AAE_cob_approved_amt	money
declare @L2320_1_amt02_B6_cob_allowed_amt	money
declare @L2320_1_amt02_F2_patient_responsibility_amt	money
declare @L2320_1_amt02_AU_cob_covered_amt	money
declare @L2320_1_amt02_D8_discount_amt	money
declare @L2320_1_amt02_F5_payer_patient_paid_amt	money
declare @L2320_1_dmg02_other_subscriber_dob	varchar(35)
declare @L2320_1_dmg03_other_subscriber_gender	char(1)
declare @L2320_1_oi03_other_ins_benefit_assign_ind	char(10)
declare @L2320_1_oi06_other_ins_release_of_info_code	char(10)
declare @L2330A_1_nm101_entity_id_code	char(3)
declare @L2330A_1_nm102_entity_type_qual	varchar(35)
declare @L2330A_1_nm103_other_subscriber_last_name	varchar(35)
declare @L2330A_1_nm104_other_subscriber_first_name	varchar(25)
declare @L2330A_1_nm105_other_subscriber_middle_name	varchar(25)
declare @L2330A_1_nm107_other_subscriber_name_suffix	varchar(10)
declare @L2330A_1_nm108_other_subscriber_id_code_qual	char(2)
declare @L2330A_1_nm109_other_subscriber_id	varchar(80)
declare @L2330A_1_n301_other_subscriber_address1 varchar(55)
declare @L2330A_1_n302_other_subscriber_address2 varchar(55)
declare @L2330A_1_n401_other_subscriber_city varchar(30)
declare @L2330A_1_n403_other_subscriber_zip varchar(15)
declare @L2330A_1_ref02_1W_other_subscriber_sup_id varchar(30)
declare @L2330A_1_ref02_23_other_subscriber_sup_id varchar(30)
declare @L2330A_1_ref02_IG_other_subscriber_sup_id varchar(30)
declare @L2330A_1_ref02_SY_other_subscriber_sup_id varchar(30)
declare @L2330A_1_n402_other_subscriber_state char(2)
declare @L2330A_1_n404_other_subscriber_country char(3)
declare @L2330B_1_nm101_entity_id_code	char(3)
declare @L2330B_1_nm102_entity_type_qual	char(1)
declare @L2330B_1_nm103_other_payer_nm	varchar(35)
declare @L2330B_1_nm108_id_code_qual	char(2)
declare @L2330B_1_nm109_other_payer_id	varchar(80)
declare @L2330B_1_dtp03_573_date_claim_paid	varchar(35)
declare @L2330B_1_ref02_2U_other_payer_secondary_id	varchar(30)
declare @L2330B_1_ref02_F8_other_payer_secondary_id	varchar(30)
declare @L2330B_1_ref02_FY_other_payer_secondary_id	varchar(30)
declare @L2330B_1_ref02_NF_other_payer_secondary_id	varchar(30)
declare @L2330B_1_ref02_TJ_other_payer_secondary_id	varchar(30)
declare @L2330B_1_ref02_9F_other_payer_auth_num	varchar(30)
declare @L2330B_1_ref02_G1_other_payer_auth_num	varchar(30)
declare @L2330B_1_ref02_T4_other_payer_claim_adj_ind	varchar(30)
declare @L2320_2_sbr01_payer_resp_seq_code	char(1)
declare @L2320_2_sbr02_ind_relationship_code	char(2)
declare @L2320_2_sbr03_insured_grp_policy_num	varchar(30)
declare @L2320_2_sbr04_insured_grp_nm	varchar(60)
declare @L2320_2_sbr09_claim_file_ind_code	char(3)
declare @L2320_2_1_cas01_adjustment_group_code	char(2)
declare @L2320_2_1_cas02_adjustment_reason_code	varchar(5)
declare @L2320_2_1_cas03_adjustment_amt	money
declare @L2320_2_1_cas04_adjustment_qty	varchar(15)
declare @L2320_2_1_cas05_adjustment_reason_code	varchar(5)
declare @L2320_2_1_cas06_adjustment_amt	money
declare @L2320_2_1_cas07_adjustment_qty	varchar(15)
declare @L2320_2_1_cas08_adjustment_reason_code	varchar(5)
declare @L2320_2_1_cas09_adjustment_amt	money
declare @L2320_2_1_cas10_adjustment_qty	varchar(15)
declare @L2320_2_2_cas01_adjustment_group_code	char(2)
declare @L2320_2_2_cas02_adjustment_reason_code	varchar(5)
declare @L2320_2_2_cas03_adjustment_amt	money
declare @L2320_2_2_cas04_adjustment_qty	varchar(15)
declare @L2320_2_2_cas05_adjustment_reason_code	varchar(5)
declare @L2320_2_2_cas06_adjustment_amt	money
declare @L2320_2_2_cas07_adjustment_qty	varchar(15)
declare @L2320_2_2_cas08_adjustment_reason_code	varchar(5)
declare @L2320_2_2_cas09_adjustment_amt	money
declare @L2320_2_2_cas10_adjustment_qty	varchar(15)
declare @L2320_2_3_cas01_adjustment_group_code	char(2)
declare @L2320_2_3_cas02_adjustment_reason_code	varchar(5)
declare @L2320_2_3_cas03_adjustment_amt	money
declare @L2320_2_3_cas04_adjustment_qty	varchar(15)
declare @L2320_2_3_cas05_adjustment_reason_code	varchar(5)
declare @L2320_2_3_cas06_adjustment_amt	money
declare @L2320_2_3_cas07_adjustment_qty	varchar(15)
declare @L2320_2_3_cas08_adjustment_reason_code	varchar(5)
declare @L2320_2_3_cas09_adjustment_amt	money
declare @L2320_2_3_cas10_adjustment_qty	varchar(15)
declare @L2320_2_4_cas01_adjustment_group_code	char(2)
declare @L2320_2_4_cas02_adjustment_reason_code	varchar(5)
declare @L2320_2_4_cas03_adjustment_amt	money
declare @L2320_2_4_cas04_adjustment_qty	varchar(15)
declare @L2320_2_4_cas05_adjustment_reason_code	varchar(5)
declare @L2320_2_4_cas06_adjustment_amt	money
declare @L2320_2_4_cas07_adjustment_qty	varchar(15)
declare @L2320_2_4_cas08_adjustment_reason_code	varchar(5)
declare @L2320_2_4_cas09_adjustment_amt	money
declare @L2320_2_4_cas10_adjustment_qty	varchar(15)
declare @L2320_2_5_cas01_adjustment_group_code	char(2)
declare @L2320_2_5_cas02_adjustment_reason_code	varchar(5)
declare @L2320_2_5_cas03_adjustment_amt	money
declare @L2320_2_5_cas04_adjustment_qty	varchar(15)
declare @L2320_2_5_cas05_adjustment_reason_code	varchar(5)
declare @L2320_2_5_cas06_adjustment_amt	money
declare @L2320_2_5_cas07_adjustment_qty	varchar(15)
declare @L2320_2_5_cas08_adjustment_reason_code	varchar(5)
declare @L2320_2_5_cas09_adjustment_amt	money
declare @L2320_2_5_cas10_adjustment_qty	varchar(15)
declare @L2320_2_amt02_D_payer_paid_amt	money
declare @L2320_2_amt02_AAE_cob_approved_amt	money
declare @L2320_2_amt02_B6_cob_allowed_amt	money
declare @L2320_2_amt02_F2_patient_responsibility_amt	money
declare @L2320_2_amt02_AU_cob_covered_amt	money
declare @L2320_2_amt02_D8_discount_amt	money
declare @L2320_2_amt02_F5_payer_patient_paid_amt	money
declare @L2320_2_dmg02_other_subscriber_dob	varchar(35)
declare @L2320_2_dmg03_other_subscriber_gender	char(1)
declare @L2320_2_oi03_other_ins_benefit_assign_ind	char(10)
declare @L2320_2_oi06_other_ins_release_of_info_code	char(10)
declare @L2330A_2_nm101_entity_id_code	char(3)
declare @L2330A_2_nm102_entity_type_qual	varchar(35)
declare @L2330A_2_nm103_other_subscriber_last_name	varchar(35)
declare @L2330A_2_nm104_other_subscriber_first_name	varchar(25)
declare @L2330A_2_nm105_other_subscriber_middle_name	varchar(25)
declare @L2330A_2_nm107_other_subscriber_name_suffix	varchar(10)
declare @L2330A_2_nm108_other_subscriber_id_code_qual	char(2)
declare @L2330A_2_nm109_other_subscriber_id	varchar(80)
declare @L2330A_2_n301_other_subscriber_address1 varchar(55)
declare @L2330A_2_n302_other_subscriber_address2 varchar(55)
declare @L2330A_2_n401_other_subscriber_city varchar(30)
declare @L2330A_2_n403_other_subscriber_zip varchar(15)
declare @L2330A_2_ref02_1W_other_subscriber_sup_id varchar(30)
declare @L2330A_2_ref02_23_other_subscriber_sup_id varchar(30)
declare @L2330A_2_ref02_IG_other_subscriber_sup_id varchar(30)
declare @L2330A_2_ref02_SY_other_subscriber_sup_id varchar(30)
declare @L2330A_2_n402_other_subscriber_state char(2)
declare @L2330A_2_n404_other_subscriber_country char(3)
declare @L2330B_2_nm101_entity_id_code	char(3)
declare @L2330B_2_nm102_entity_type_qual	char(1)
declare @L2330B_2_nm103_other_payer_nm	varchar(35)
declare @L2330B_2_nm108_id_code_qual	char(2)
declare @L2330B_2_nm109_other_payer_id	varchar(80)
declare @L2330B_2_dtp03_573_date_claim_paid	varchar(35)
declare @L2330B_2_ref02_2U_other_payer_secondary_id	varchar(30)
declare @L2330B_2_ref02_F8_other_payer_secondary_id	varchar(30)
declare @L2330B_2_ref02_FY_other_payer_secondary_id	varchar(30)
declare @L2330B_2_ref02_NF_other_payer_secondary_id	varchar(30)
declare @L2330B_2_ref02_TJ_other_payer_secondary_id	varchar(30)
declare @L2330B_2_ref02_9F_other_payer_auth_num	varchar(30)
declare @L2330B_2_ref02_G1_other_payer_auth_num	varchar(30)
declare @L2330B_2_ref02_T4_other_payer_claim_adj_ind	varchar(30)
declare @L2320_3_sbr01_payer_resp_seq_code	char(1)
declare @L2320_3_sbr02_ind_relationship_code	char(2)
declare @L2320_3_sbr03_insured_grp_policy_num	varchar(30)
declare @L2320_3_sbr04_insured_grp_nm	varchar(60)
declare @L2320_3_sbr09_claim_file_ind_code	char(3)
declare @L2320_3_1_cas01_adjustment_group_code	char(2)
declare @L2320_3_1_cas02_adjustment_reason_code	varchar(5)
declare @L2320_3_1_cas03_adjustment_amt	money
declare @L2320_3_1_cas04_adjustment_qty	varchar(15)
declare @L2320_3_1_cas05_adjustment_reason_code	varchar(5)
declare @L2320_3_1_cas06_adjustment_amt	money
declare @L2320_3_1_cas07_adjustment_qty	varchar(15)
declare @L2320_3_1_cas08_adjustment_reason_code	varchar(5)
declare @L2320_3_1_cas09_adjustment_amt	money
declare @L2320_3_1_cas10_adjustment_qty	varchar(15)
declare @L2320_3_2_cas01_adjustment_group_code	char(2)
declare @L2320_3_2_cas02_adjustment_reason_code	varchar(5)
declare @L2320_3_2_cas03_adjustment_amt	money
declare @L2320_3_2_cas04_adjustment_qty	varchar(15)
declare @L2320_3_2_cas05_adjustment_reason_code	varchar(5)
declare @L2320_3_2_cas06_adjustment_amt	money
declare @L2320_3_2_cas07_adjustment_qty	varchar(15)
declare @L2320_3_2_cas08_adjustment_reason_code	varchar(5)
declare @L2320_3_2_cas09_adjustment_amt	money
declare @L2320_3_2_cas10_adjustment_qty	varchar(15)
declare @L2320_3_3_cas01_adjustment_group_code	char(2)
declare @L2320_3_3_cas02_adjustment_reason_code	varchar(5)
declare @L2320_3_3_cas03_adjustment_amt	money
declare @L2320_3_3_cas04_adjustment_qty	varchar(15)
declare @L2320_3_3_cas05_adjustment_reason_code	varchar(5)
declare @L2320_3_3_cas06_adjustment_amt	money
declare @L2320_3_3_cas07_adjustment_qty	varchar(15)
declare @L2320_3_3_cas08_adjustment_reason_code	varchar(5)
declare @L2320_3_3_cas09_adjustment_amt	money
declare @L2320_3_3_cas10_adjustment_qty	varchar(15)
declare @L2320_3_4_cas01_adjustment_group_code	char(2)
declare @L2320_3_4_cas02_adjustment_reason_code	varchar(5)
declare @L2320_3_4_cas03_adjustment_amt	money
declare @L2320_3_4_cas04_adjustment_qty	varchar(15)
declare @L2320_3_4_cas05_adjustment_reason_code	varchar(5)
declare @L2320_3_4_cas06_adjustment_amt	money
declare @L2320_3_4_cas07_adjustment_qty	varchar(15)
declare @L2320_3_4_cas08_adjustment_reason_code	varchar(5)
declare @L2320_3_4_cas09_adjustment_amt	money
declare @L2320_3_4_cas10_adjustment_qty	varchar(15)
declare @L2320_3_5_cas01_adjustment_group_code	char(2)
declare @L2320_3_5_cas02_adjustment_reason_code	varchar(5)
declare @L2320_3_5_cas03_adjustment_amt	money
declare @L2320_3_5_cas04_adjustment_qty	varchar(15)
declare @L2320_3_5_cas05_adjustment_reason_code	varchar(5)
declare @L2320_3_5_cas06_adjustment_amt	money
declare @L2320_3_5_cas07_adjustment_qty	varchar(15)
declare @L2320_3_5_cas08_adjustment_reason_code	varchar(5)
declare @L2320_3_5_cas09_adjustment_amt	money
declare @L2320_3_5_cas10_adjustment_qty	varchar(15)
declare @L2320_3_amt02_D_payer_paid_amt	money
declare @L2320_3_amt02_AAE_cob_approved_amt	money
declare @L2320_3_amt02_B6_cob_allowed_amt	money
declare @L2320_3_amt02_F2_patient_responsibility_amt	money
declare @L2320_3_amt02_AU_cob_covered_amt	money
declare @L2320_3_amt02_D8_discount_amt	money
declare @L2320_3_amt02_F5_payer_patient_paid_amt	money
declare @L2320_3_dmg02_other_subscriber_dob	varchar(35)
declare @L2320_3_dmg03_other_subscriber_gender	char(1)
declare @L2320_3_oi03_other_ins_benefit_assign_ind	char(10)
declare @L2320_3_oi06_other_ins_release_of_info_code	char(10)
declare @L2330A_3_nm101_entity_id_code	char(3)
declare @L2330A_3_nm102_entity_type_qual	varchar(35)
declare @L2330A_3_nm103_other_subscriber_last_name	varchar(35)
declare @L2330A_3_nm104_other_subscriber_first_name	varchar(25)
declare @L2330A_3_nm105_other_subscriber_middle_name	varchar(25)
declare @L2330A_3_nm107_other_subscriber_name_suffix	varchar(10)
declare @L2330A_3_nm108_other_subscriber_id_code_qual	char(2)
declare @L2330A_3_nm109_other_subscriber_id	varchar(80)
declare @L2330A_3_n301_other_subscriber_address1 varchar(55)
declare @L2330A_3_n302_other_subscriber_address2 varchar(55)
declare @L2330A_3_n401_other_subscriber_city varchar(30)
declare @L2330A_3_n403_other_subscriber_zip varchar(15)
declare @L2330A_3_ref02_1W_other_subscriber_sup_id varchar(30)
declare @L2330A_3_ref02_23_other_subscriber_sup_id varchar(30)
declare @L2330A_3_ref02_IG_other_subscriber_sup_id varchar(30)
declare @L2330A_3_ref02_SY_other_subscriber_sup_id varchar(30)
declare @L2330A_3_n402_other_subscriber_state char(2)
declare @L2330A_3_n404_other_subscriber_country char(3)
declare @L2330B_3_nm101_entity_id_code	char(3)
declare @L2330B_3_nm102_entity_type_qual	char(1)
declare @L2330B_3_nm103_other_payer_nm	varchar(35)
declare @L2330B_3_nm108_id_code_qual	char(2)
declare @L2330B_3_nm109_other_payer_id	varchar(80)
declare @L2330B_3_dtp03_573_date_claim_paid	varchar(35)
declare @L2330B_3_ref02_2U_other_payer_secondary_id	varchar(30)
declare @L2330B_3_ref02_F8_other_payer_secondary_id	varchar(30)
declare @L2330B_3_ref02_FY_other_payer_secondary_id	varchar(30)
declare @L2330B_3_ref02_NF_other_payer_secondary_id	varchar(30)
declare @L2330B_3_ref02_TJ_other_payer_secondary_id	varchar(30)
declare @L2330B_3_ref02_9F_other_payer_auth_num	varchar(30)
declare @L2330B_3_ref02_G1_other_payer_auth_num	varchar(30)
declare @L2330B_3_ref02_T4_other_payer_claim_adj_ind	varchar(30)
declare @L2400_lx01_assigned_num	varchar(6)
declare @L2400_sv301_proc_code_qual	char(2)
declare @L2400_sv301_proc_code	varchar(48)
declare @L2400_sv301_proc_mod1	char(2)
declare @L2400_sv301_proc_mod2	char(2)
declare @L2400_sv301_proc_mod3	char(2)
declare @L2400_sv301_proc_mod4	char(2)
declare @L2400_sv302_line_charge	money
declare @L2400_sv303_facility_type_code	varchar(3)
declare @L2400_sv304_oral_cavity_designation_code_1	char(3)
declare @L2400_sv304_oral_cavity_designation_code_2	char(3)
declare @L2400_sv304_oral_cavity_designation_code_3	char(3)
declare @L2400_sv304_oral_cavity_designation_code_4	char(3)
declare @L2400_sv304_oral_cavity_designation_code_5	char(3)
declare @L2400_sv305_prosthesis_crown_inlay_code	char(1)
declare @L2400_sv306_procedure_count	varchar(15)
declare @L2400_1_too02_JP_tooth_code varchar(30)
declare @L2400_1_too03_tooth_surface_code_1 char(2)
declare @L2400_1_too03_tooth_surface_code_2 char(2)
declare @L2400_1_too03_tooth_surface_code_3 char(2)
declare @L2400_1_too03_tooth_surface_code_4 char(2)
declare @L2400_1_too03_tooth_surface_code_5 char(2)
declare @L2400_2_too02_JP_tooth_code varchar(30)
declare @L2400_2_too03_tooth_surface_code_1 char(2)
declare @L2400_2_too03_tooth_surface_code_2 char(2)
declare @L2400_2_too03_tooth_surface_code_3 char(2)
declare @L2400_2_too03_tooth_surface_code_4 char(2)
declare @L2400_2_too03_tooth_surface_code_5 char(2)
declare @L2400_3_too02_JP_tooth_code varchar(30)
declare @L2400_3_too03_tooth_surface_code_1 char(2)
declare @L2400_3_too03_tooth_surface_code_2 char(2)
declare @L2400_3_too03_tooth_surface_code_3 char(2)
declare @L2400_3_too03_tooth_surface_code_4 char(2)
declare @L2400_3_too03_tooth_surface_code_5 char(2)
declare @L2400_4_too02_JP_tooth_code varchar(30)
declare @L2400_4_too03_tooth_surface_code_1 char(2)
declare @L2400_4_too03_tooth_surface_code_2 char(2)
declare @L2400_4_too03_tooth_surface_code_3 char(2)
declare @L2400_4_too03_tooth_surface_code_4 char(2)
declare @L2400_4_too03_tooth_surface_code_5 char(2)
declare @L2400_5_too02_JP_tooth_code varchar(30)
declare @L2400_5_too03_tooth_surface_code_1 char(2)
declare @L2400_5_too03_tooth_surface_code_2 char(2)
declare @L2400_5_too03_tooth_surface_code_3 char(2)
declare @L2400_5_too03_tooth_surface_code_4 char(2)
declare @L2400_5_too03_tooth_surface_code_5 char(2)
declare @L2400_6_too02_JP_tooth_code varchar(30)
declare @L2400_6_too03_tooth_surface_code_1 char(2)
declare @L2400_6_too03_tooth_surface_code_2 char(2)
declare @L2400_6_too03_tooth_surface_code_3 char(2)
declare @L2400_6_too03_tooth_surface_code_4 char(2)
declare @L2400_6_too03_tooth_surface_code_5 char(2)
declare @L2400_7_too02_JP_tooth_code varchar(30)
declare @L2400_7_too03_tooth_surface_code_1 char(2)
declare @L2400_7_too03_tooth_surface_code_2 char(2)
declare @L2400_7_too03_tooth_surface_code_3 char(2)
declare @L2400_7_too03_tooth_surface_code_4 char(2)
declare @L2400_7_too03_tooth_surface_code_5 char(2)
declare @L2400_8_too02_JP_tooth_code varchar(30)
declare @L2400_8_too03_tooth_surface_code_1 char(2)
declare @L2400_8_too03_tooth_surface_code_2 char(2)
declare @L2400_8_too03_tooth_surface_code_3 char(2)
declare @L2400_8_too03_tooth_surface_code_4 char(2)
declare @L2400_8_too03_tooth_surface_code_5 char(2)
declare @L2400_9_too02_JP_tooth_code varchar(30)
declare @L2400_9_too03_tooth_surface_code_1 char(2)
declare @L2400_9_too03_tooth_surface_code_2 char(2)
declare @L2400_9_too03_tooth_surface_code_3 char(2)
declare @L2400_9_too03_tooth_surface_code_4 char(2)
declare @L2400_9_too03_tooth_surface_code_5 char(2)
declare @L2400_10_too02_JP_tooth_code varchar(30)
declare @L2400_10_too03_tooth_surface_code_1 char(2)
declare @L2400_10_too03_tooth_surface_code_2 char(2)
declare @L2400_10_too03_tooth_surface_code_3 char(2)
declare @L2400_10_too03_tooth_surface_code_4 char(2)
declare @L2400_10_too03_tooth_surface_code_5 char(2)
declare @L2400_11_too02_JP_tooth_code varchar(30)
declare @L2400_11_too03_tooth_surface_code_1 char(2)
declare @L2400_11_too03_tooth_surface_code_2 char(2)
declare @L2400_11_too03_tooth_surface_code_3 char(2)
declare @L2400_11_too03_tooth_surface_code_4 char(2)
declare @L2400_11_too03_tooth_surface_code_5 char(2)
declare @L2400_12_too02_JP_tooth_code varchar(30)
declare @L2400_12_too03_tooth_surface_code_1 char(2)
declare @L2400_12_too03_tooth_surface_code_2 char(2)
declare @L2400_12_too03_tooth_surface_code_3 char(2)
declare @L2400_12_too03_tooth_surface_code_4 char(2)
declare @L2400_12_too03_tooth_surface_code_5 char(2)
declare @L2400_13_too02_JP_tooth_code varchar(30)
declare @L2400_13_too03_tooth_surface_code_1 char(2)
declare @L2400_13_too03_tooth_surface_code_2 char(2)
declare @L2400_13_too03_tooth_surface_code_3 char(2)
declare @L2400_13_too03_tooth_surface_code_4 char(2)
declare @L2400_13_too03_tooth_surface_code_5 char(2)
declare @L2400_14_too02_JP_tooth_code varchar(30)
declare @L2400_14_too03_tooth_surface_code_1 char(2)
declare @L2400_14_too03_tooth_surface_code_2 char(2)
declare @L2400_14_too03_tooth_surface_code_3 char(2)
declare @L2400_14_too03_tooth_surface_code_4 char(2)
declare @L2400_14_too03_tooth_surface_code_5 char(2)
declare @L2400_15_too02_JP_tooth_code varchar(30)
declare @L2400_15_too03_tooth_surface_code_1 char(2)
declare @L2400_15_too03_tooth_surface_code_2 char(2)
declare @L2400_15_too03_tooth_surface_code_3 char(2)
declare @L2400_15_too03_tooth_surface_code_4 char(2)
declare @L2400_15_too03_tooth_surface_code_5 char(2)
declare @L2400_16_too02_JP_tooth_code varchar(30)
declare @L2400_16_too03_tooth_surface_code_1 char(2)
declare @L2400_16_too03_tooth_surface_code_2 char(2)
declare @L2400_16_too03_tooth_surface_code_3 char(2)
declare @L2400_16_too03_tooth_surface_code_4 char(2)
declare @L2400_16_too03_tooth_surface_code_5 char(2)
declare @L2400_17_too02_JP_tooth_code varchar(30)
declare @L2400_17_too03_tooth_surface_code_1 char(2)
declare @L2400_17_too03_tooth_surface_code_2 char(2)
declare @L2400_17_too03_tooth_surface_code_3 char(2)
declare @L2400_17_too03_tooth_surface_code_4 char(2)
declare @L2400_17_too03_tooth_surface_code_5 char(2)
declare @L2400_18_too02_JP_tooth_code varchar(30)
declare @L2400_18_too03_tooth_surface_code_1 char(2)
declare @L2400_18_too03_tooth_surface_code_2 char(2)
declare @L2400_18_too03_tooth_surface_code_3 char(2)
declare @L2400_18_too03_tooth_surface_code_4 char(2)
declare @L2400_18_too03_tooth_surface_code_5 char(2)
declare @L2400_19_too02_JP_tooth_code varchar(30)
declare @L2400_19_too03_tooth_surface_code_1 char(2)
declare @L2400_19_too03_tooth_surface_code_2 char(2)
declare @L2400_19_too03_tooth_surface_code_3 char(2)
declare @L2400_19_too03_tooth_surface_code_4 char(2)
declare @L2400_19_too03_tooth_surface_code_5 char(2)
declare @L2400_20_too02_JP_tooth_code varchar(30)
declare @L2400_20_too03_tooth_surface_code_1 char(2)
declare @L2400_20_too03_tooth_surface_code_2 char(2)
declare @L2400_20_too03_tooth_surface_code_3 char(2)
declare @L2400_20_too03_tooth_surface_code_4 char(2)
declare @L2400_20_too03_tooth_surface_code_5 char(2)
declare @L2400_21_too02_JP_tooth_code varchar(30)
declare @L2400_21_too03_tooth_surface_code_1 char(2)
declare @L2400_21_too03_tooth_surface_code_2 char(2)
declare @L2400_21_too03_tooth_surface_code_3 char(2)
declare @L2400_21_too03_tooth_surface_code_4 char(2)
declare @L2400_21_too03_tooth_surface_code_5 char(2)
declare @L2400_22_too02_JP_tooth_code varchar(30)
declare @L2400_22_too03_tooth_surface_code_1 char(2)
declare @L2400_22_too03_tooth_surface_code_2 char(2)
declare @L2400_22_too03_tooth_surface_code_3 char(2)
declare @L2400_22_too03_tooth_surface_code_4 char(2)
declare @L2400_22_too03_tooth_surface_code_5 char(2)
declare @L2400_23_too02_JP_tooth_code varchar(30)
declare @L2400_23_too03_tooth_surface_code_1 char(2)
declare @L2400_23_too03_tooth_surface_code_2 char(2)
declare @L2400_23_too03_tooth_surface_code_3 char(2)
declare @L2400_23_too03_tooth_surface_code_4 char(2)
declare @L2400_23_too03_tooth_surface_code_5 char(2)
declare @L2400_24_too02_JP_tooth_code varchar(30)
declare @L2400_24_too03_tooth_surface_code_1 char(2)
declare @L2400_24_too03_tooth_surface_code_2 char(2)
declare @L2400_24_too03_tooth_surface_code_3 char(2)
declare @L2400_24_too03_tooth_surface_code_4 char(2)
declare @L2400_24_too03_tooth_surface_code_5 char(2)
declare @L2400_25_too02_JP_tooth_code varchar(30)
declare @L2400_25_too03_tooth_surface_code_1 char(2)
declare @L2400_25_too03_tooth_surface_code_2 char(2)
declare @L2400_25_too03_tooth_surface_code_3 char(2)
declare @L2400_25_too03_tooth_surface_code_4 char(2)
declare @L2400_25_too03_tooth_surface_code_5 char(2)
declare @L2400_26_too02_JP_tooth_code varchar(30)
declare @L2400_26_too03_tooth_surface_code_1 char(2)
declare @L2400_26_too03_tooth_surface_code_2 char(2)
declare @L2400_26_too03_tooth_surface_code_3 char(2)
declare @L2400_26_too03_tooth_surface_code_4 char(2)
declare @L2400_26_too03_tooth_surface_code_5 char(2)
declare @L2400_27_too02_JP_tooth_code varchar(30)
declare @L2400_27_too03_tooth_surface_code_1 char(2)
declare @L2400_27_too03_tooth_surface_code_2 char(2)
declare @L2400_27_too03_tooth_surface_code_3 char(2)
declare @L2400_27_too03_tooth_surface_code_4 char(2)
declare @L2400_27_too03_tooth_surface_code_5 char(2)
declare @L2400_28_too02_JP_tooth_code varchar(30)
declare @L2400_28_too03_tooth_surface_code_1 char(2)
declare @L2400_28_too03_tooth_surface_code_2 char(2)
declare @L2400_28_too03_tooth_surface_code_3 char(2)
declare @L2400_28_too03_tooth_surface_code_4 char(2)
declare @L2400_28_too03_tooth_surface_code_5 char(2)
declare @L2400_29_too02_JP_tooth_code varchar(30)
declare @L2400_29_too03_tooth_surface_code_1 char(2)
declare @L2400_29_too03_tooth_surface_code_2 char(2)
declare @L2400_29_too03_tooth_surface_code_3 char(2)
declare @L2400_29_too03_tooth_surface_code_4 char(2)
declare @L2400_29_too03_tooth_surface_code_5 char(2)
declare @L2400_30_too02_JP_tooth_code varchar(30)
declare @L2400_30_too03_tooth_surface_code_1 char(2)
declare @L2400_30_too03_tooth_surface_code_2 char(2)
declare @L2400_30_too03_tooth_surface_code_3 char(2)
declare @L2400_30_too03_tooth_surface_code_4 char(2)
declare @L2400_30_too03_tooth_surface_code_5 char(2)
declare @L2400_31_too02_JP_tooth_code varchar(30)
declare @L2400_31_too03_tooth_surface_code_1 char(2)
declare @L2400_31_too03_tooth_surface_code_2 char(2)
declare @L2400_31_too03_tooth_surface_code_3 char(2)
declare @L2400_31_too03_tooth_surface_code_4 char(2)
declare @L2400_31_too03_tooth_surface_code_5 char(2)
declare @L2400_32_too02_JP_tooth_code varchar(30)
declare @L2400_32_too03_tooth_surface_code_1 char(2)
declare @L2400_32_too03_tooth_surface_code_2 char(2)
declare @L2400_32_too03_tooth_surface_code_3 char(2)
declare @L2400_32_too03_tooth_surface_code_4 char(2)
declare @L2400_32_too03_tooth_surface_code_5 char(2)
declare @L2400_dtp02_472_service_date	varchar(35)
declare @L2400_dtp02_441_prior_placement_date	varchar(35)
declare @L2400_dtp02_452_orthodontic_banding_date	varchar(35)
declare @L2400_dtp02_446_replacement_date	varchar(35)
declare @L2400_1_qty01_qty_qual	char(2)
declare @L2400_1_qty02_anesthesia_unit_count	varchar(15)
declare @L2400_2_qty01_qty_qual	char(2)
declare @L2400_2_qty02_anesthesia_unit_count	varchar(15)
declare @L2400_3_qty01_qty_qual	char(2)
declare @L2400_3_qty02_anesthesia_unit_count	varchar(15)
declare @L2400_4_qty01_qty_qual	char(2)
declare @L2400_4_qty02_anesthesia_unit_count	varchar(15)
declare @L2400_5_qty01_qty_qual	char(2)
declare @L2400_5_qty02_anesthesia_unit_count	varchar(15)
declare @L2400_ref02_G3_predetermination_of_benefits_id	varchar(30)
declare @L2400_ref02_9F_referral_number	varchar(30)
declare @L2400_ref02_G1_prior_auth_number	varchar(30)
declare @L2400_ref02_6R_line_item_control_num	varchar(30)
declare @L2400_amt02_AAE_approved_amt	money
declare @L2400_amt02_T_sales_tax_amt	money
declare @L2400_nte01_note_ref_code	char(3)
declare @L2400_nte02_line_note_text	varchar(80)
declare @L2420A_nm102_entity_type_qual	char(1)
declare @L2420A_nm103_rendering_prov_last_nm	varchar(35)
declare @L2420A_nm104_rendering_prov_first_nm	varchar(25)
declare @L2420A_nm105_rendering_prov_middle_nm	varchar(25)
declare @L2420A_nm107_rendering_prov_suffix	varchar(10)
declare @L2420A_nm108_id_code_qual	char(2)
declare @L2420A_nm109_rendering_prov_id	varchar(80)
declare @L2420A_prv01_provider_code	char(3)
declare @L2420A_prv02_ref_id_qual	char(3)
declare @L2420A_prv03_taxonomy_code	varchar(30)
declare @L2420A_ref02_1C_rendering_prov_id	varchar(30)
declare @L2420A_ref02_1D_rendering_prov_id	varchar(30)
declare @L2420A_ref02_1E_rendering_prov_id	varchar(30)
declare @L2420A_ref02_EI_rendering_prov_id	varchar(30)
declare @L2420A_ref02_SY_rendering_prov_id	varchar(30)
declare @L2420A_ref02_TJ_rendering_prov_id	varchar(30)
declare @L2420B_nm102_entity_type_qual	char(1)
declare @L2420B_nm103_payer_last_nm	varchar(35)
declare @L2420B_nm108_id_code_qual	char(2)
declare @L2420B_nm109_other_payer_id	varchar(80)
declare @L2420B_ref02_9F_referral_number	varchar(30)
declare @L2420B_ref02_G1_prior_auth_number	varchar(30)
declare @L2420C_nm101_entity_id_code	char(3)
declare @L2420C_nm102_entity_type_qual	char(1)
declare @L2420C_nm103_assistant_surgeon_last_nm	varchar(35)
declare @L2420C_nm104_assistant_surgeon_first_nm	varchar(25)
declare @L2420C_nm105_assistant_surgeon_middle_nm	varchar(25)
declare @L2420C_nm107_assistant_surgeon_suffix	varchar(10)
declare @L2420C_nm108_id_code_qual	char(2)
declare @L2420C_nm109_assistant_surgeon_id	varchar(80)
declare @L2420C_prv01_provider_code	char(3)
declare @L2420C_prv02_ref_id_qual	char(3)
declare @L2420C_prv03_taxonomy_code	varchar(30)
declare @L2420C_ref02_1C_service_facility_id	varchar(30)
declare @L2420C_ref02_1D_service_facility_id	varchar(30)
declare @L2420C_ref02_1E_service_facility_id	varchar(30)
declare @L2420C_ref02_G2_service_facility_id	varchar(30)
declare @L2420C_ref02_TJ_service_facility_id	varchar(30)
declare @L2430_svd01_other_payer_id	varchar(80)
declare @L2430_svd02_service_line_paid	money
declare @L2430_svd03_service_id_qual	char(2)
declare @L2430_svd03_proc_code	varchar(48)
declare @L2430_svd03_proc_mod1	char(2)
declare @L2430_svd03_proc_mod2	char(2)
declare @L2430_svd03_proc_mod3	char(2)
declare @L2430_svd03_proc_mod4	char(2)
declare @L2430_svd03_proc_code_desc	varchar(80)
declare @L2430_svd05_paid_service_unit	varchar(15)
declare @L2430_svd06_bundled_unbundled_line_num	varchar(6)
declare @L2430_cas01_adjustment_group_code	char(2)
declare @L2430_cas02_adjustment_reason_code	varchar(5)
declare @L2430_cas03_adjustment_amt	money
declare @L2430_cas04_adjustment_qty	varchar(15)
declare @L2430_cas05_adjustment_reason_code	varchar(5)
declare @L2430_cas06_adjustment_amt	money
declare @L2430_cas07_adjustment_qty	varchar(15)
declare @L2430_cas08_adjustment_reason_code	varchar(5)
declare @L2430_cas09_adjustment_amt	money
declare @L2430_cas10_adjustment_qty	varchar(15)
declare @L2430_dtp03_573_date_claim_paid	varchar(35)	

-- These are temporary variables
declare @SQLString nvarchar(4000)
declare @loopcount int
declare @ProcString varchar(25)
declare @DXPointerString varchar(15)
declare @ColonPOS int
declare @EndStringPos int
declare @prev_L2300_clm01_pt_acct_num varchar (38)
 -- This variable is used to determine what Loop the previous segment was in, so the data is gathered correctly.
declare @curLoop varchar(8)
declare @errmsg varchar(250)
declare @errcode int
declare @x12_parse_temp_id_start int
declare @x12_parse_temp_id_end int
declare @x12_interchange_uid uniqueidentifier
declare @isa16_component_element_seperator char(1)
declare @Other2400QTYLoopCount int
declare @Other2320SBRLoopCount int
declare @Other2320CASLoopCount int
declare @Other2300DNLoopCount int
declare @Other2400TOOLoopCount int

-- temporary tooth variables
declare @tmp_tooth_surface_code_1 char(2)
declare @tmp_tooth_surface_code_2 char(2)
declare @tmp_tooth_surface_code_3 char(2)
declare @tmp_tooth_surface_code_4 char(2)
declare @tmp_tooth_surface_code_5 char(2)

set @Other2400QTYLoopCount = 0
set @Other2320SBRLoopCount = 0
set @Other2320CASLoopCount = 0
set @Other2300DNLoopCount = 0
set @Other2400TOOLoopCount = 0
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

DECLARE curt837d SCROLL CURSOR FOR
	select Col001, Col002, Col003, Col004, Col005, Col006, Col007, Col008, Col009, Col010, Col011, Col012, Col013, Col014, Col015, Col016, Col017, Col018, Col019, Col020, Col021
	from x12_parse_temp
	where	x12_parse_temp_id BETWEEN @x12_parse_temp_id_start AND @x12_parse_temp_id_end
		AND x12_parse_temp_uid = @x12_interchange_uid
	order by x12_parse_temp_id

OPEN curt837d

FETCH NEXT FROM curt837d INTO @Col001, @Col002, @Col003, @Col004, @Col005, @Col006, @Col007, @Col008, @Col009, @Col010, @Col011, @Col012, @Col013, @Col014, @Col015, @Col016, @Col017, @Col018, @Col019, @Col020, @Col021
WHILE (@@fetch_status <> -1)
BEGIN
	set @se01_num_transaction_segments = @se01_num_transaction_segments + 1




	-- If the current segment is an HL or CLM segment, we're definitely getting ready for a new claim.
	if ( RTrim(@col001) = 'HL' OR RTrim(@col001) = 'CLM' )
	begin
		if (@L2400_sv301_proc_code IS NOT NULL AND @L2400_lx01_assigned_num IS NOT NULL)
		begin
			-- insert a record when we start a new claim (meaning we're done with the last service line on the previous claim)
			insert into x12_837_claim_dental
						(	x12_transaction_id,
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
							L2010AA_ref02_1C_billing_prov_id,
							L2010AA_ref02_1D_billing_prov_id,
							L2010AA_ref02_1E_billing_prov_id,
							L2010AA_ref02_EI_billing_prov_id,
							L2010AA_ref02_SY_billing_prov_id,
							L2010AA_ref02_TJ_billing_prov_id,
							L2010AA_ref02_06_card_billing_id,
							L2010AA_ref02_8U_card_billing_id,
							L2010AA_ref02_EM_card_billing_id,
							L2010AA_ref02_IJ_card_billing_id,
							L2010AA_ref02_LU_card_billing_id,
							L2010AA_ref02_ST_card_billing_id,
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
							L2010AB_ref02_1E_payto_prov_id,
							L2010AB_ref02_EI_payto_prov_id,
							L2010AB_ref02_SY_payto_prov_id,
							L2010AB_ref02_TJ_payto_prov_id,
							L2000B_hl01_hierarchical_id_num,
							L2000B_hl02_hierarchical_parent_id_num,
							L2000B_hl03_hierarchical_level_code,
							L2000B_hl04_hierarchical_child_code,
							L2000B_sbr01_payer_resp_seq_code,
							L2000B_sbr02_ind_relationship_code,
							L2000B_sbr03_insured_grp_policy_num,
							L2000B_sbr04_insured_grp_nm,
							L2000B_sbr06_cob_code,
							L2000B_sbr09_claim_filing_ind_code,
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
							L2010BB_nm103_payer_nm,
							L2010BB_nm108_payer_id_qual,
							L2010BB_nm109_payer_id,
							L2010BB_n301_payer_address1,
							L2010BB_n302_payer_address2,
							L2010BB_n401_payer_city,
							L2010BB_n402_payer_state,
							L2010BB_n403_payer_zip,
							L2010BB_n404_payer_country,
							L2010BB_ref02_2U_payer_id,
							L2010BB_ref02_FY_payer_id,
							L2010BB_ref02_NF_payer_id,
							L2010BB_ref02_TJ_payer_id,
							L2010BC_nm102_entity_type_qual,
							L2010BC_nm103_resp_party_last_nm,
							L2010BC_nm104_resp_party_first_nm,
							L2010BC_nm105_resp_party_middle_nm,
							L2010BC_nm107_resp_party_suffix,
							L2010BC_nm109_MI_card_num,
							L2010BC_ref02_BB_card_num,
							L2000C_hl01_hierarchical_id_num,
							L2000C_hl02_hierarchical_parent_id_num,
							L2000C_hl03_hierarchical_level_code,
							L2000C_hl04_hierarchical_child_code,
							L2000C_pat01_ind_relationship_code,
							L2000C_pat04_student_status_code,
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
							L2300_clm05_claim_freq_code,
							L2300_clm06_provider_signature_ind,
							L2300_clm07_medicare_assign_code,
							L2300_clm08_benefit_assign_ind,
							L2300_clm09_release_of_info_code,
							L2300_clm11_related_causes_code1,
							L2300_clm11_related_causes_code2,
							L2300_clm11_related_causes_code3,
							L2300_clm11_auto_accident_state_code,
							L2300_clm11_country_code,
							L2300_clm12_special_prog_ind,
							L2300_clm19_claim_submission_reason_code,
							L2300_clm20_delay_reason_code,
							L2300_dtp03_435_related_hospitalization_admission_date,
							L2300_dtp03_096_discharge_end_of_care_date,
							L2300_dtp03_330_referral_date,
							L2300_dtp03_439_accident_date,
							L2300_dtp03_452_orthodontic_banding_date,
							L2300_dtp03_472_service_date,
							L2300_dn101_orthodontic_treatment_months_count,
							L2300_dn102_orthodontic_treatment_months_remaining_count,
							L2300_dn103_question_response,
							L2300_1_dn201_tooth_number,
							L2300_1_dn202_tooth_status_code,
							L2300_2_dn201_tooth_number,
							L2300_2_dn202_tooth_status_code,
							L2300_3_dn201_tooth_number,
							L2300_3_dn202_tooth_status_code,
							L2300_4_dn201_tooth_number,
							L2300_4_dn202_tooth_status_code,
							L2300_5_dn201_tooth_number,
							L2300_5_dn202_tooth_status_code,
							L2300_6_dn201_tooth_number,
							L2300_6_dn202_tooth_status_code,
							L2300_7_dn201_tooth_number,
							L2300_7_dn202_tooth_status_code,
							L2300_8_dn201_tooth_number,
							L2300_8_dn202_tooth_status_code,
							L2300_9_dn201_tooth_number,
							L2300_9_dn202_tooth_status_code,
							L2300_10_dn201_tooth_number,
							L2300_10_dn202_tooth_status_code,
							L2300_11_dn201_tooth_number,
							L2300_11_dn202_tooth_status_code,
							L2300_12_dn201_tooth_number,
							L2300_12_dn202_tooth_status_code,
							L2300_13_dn201_tooth_number,
							L2300_13_dn202_tooth_status_code,
							L2300_14_dn201_tooth_number,
							L2300_14_dn202_tooth_status_code,
							L2300_15_dn201_tooth_number,
							L2300_15_dn202_tooth_status_code,
							L2300_16_dn201_tooth_number,
							L2300_16_dn202_tooth_status_code,
							L2300_17_dn201_tooth_number,
							L2300_17_dn202_tooth_status_code,
							L2300_18_dn201_tooth_number,
							L2300_18_dn202_tooth_status_code,
							L2300_19_dn201_tooth_number,
							L2300_19_dn202_tooth_status_code,
							L2300_20_dn201_tooth_number,
							L2300_20_dn202_tooth_status_code,
							L2300_21_dn201_tooth_number,
							L2300_21_dn202_tooth_status_code,
							L2300_22_dn201_tooth_number,
							L2300_22_dn202_tooth_status_code,
							L2300_23_dn201_tooth_number,
							L2300_23_dn202_tooth_status_code,
							L2300_24_dn201_tooth_number,
							L2300_24_dn202_tooth_status_code,
							L2300_25_dn201_tooth_number,
							L2300_25_dn202_tooth_status_code,
							L2300_26_dn201_tooth_number,
							L2300_26_dn202_tooth_status_code,
							L2300_27_dn201_tooth_number,
							L2300_27_dn202_tooth_status_code,
							L2300_28_dn201_tooth_number,
							L2300_28_dn202_tooth_status_code,
							L2300_29_dn201_tooth_number,
							L2300_29_dn202_tooth_status_code,
							L2300_30_dn201_tooth_number,
							L2300_30_dn202_tooth_status_code,
							L2300_31_dn201_tooth_number,
							L2300_31_dn202_tooth_status_code,
							L2300_32_dn201_tooth_number,
							L2300_32_dn202_tooth_status_code,
							L2300_33_dn201_tooth_number,
							L2300_33_dn202_tooth_status_code,
							L2300_34_dn201_tooth_number,
							L2300_34_dn202_tooth_status_code,
							L2300_35_dn201_tooth_number,
							L2300_35_dn202_tooth_status_code,
							L2300_pwk01_attachment_type_code,
							L2300_pwk02_attachment_trans_code,
							L2300_pwk06_attachment_control_num,
							L2300_amt02_patient_paid_amt,
							L2300_amt02_card_maximum_amt,
							L2300_ref02_G3_predetermination_id,
							L2300_ref02_4N_service_auth_exception_code,
							L2300_ref02_F8_original_ref_num,
							L2300_ref02_9F_referral_num,
							L2300_ref02_G1_prior_auth_num,
							L2300_ref02_D9_value_added_network_trace_num,
							L2300_nte01_note_ref_code,
							L2300_nte02_claim_note_text,
							L2310A_nm101_entity_id_code,
							L2310A_nm102_entity_type_qual,
							L2310A_nm103_referring_prov_last_nm,
							L2310A_nm104_referring_prov_first_nm,
							L2310A_nm105_referring_prov_middle_nm,
							L2310A_nm107_referring_prov_suffix,
							L2310A_nm108_id_code_qual,
							L2310A_nm109_referring_prov_id,
							L2310A_prv01_provider_code,
							L2310A_prv02_ref_id_qual,
							L2310A_prv03_taxonomy_code,
							L2310A_ref02_1C_referring_prov_id,
							L2310A_ref02_1D_referring_prov_id,
							L2310A_ref02_1E_referring_prov_id,
							L2310A_ref02_EI_referring_prov_id,
							L2310A_ref02_G2_referring_prov_id,
							L2310A_ref02_SY_referring_prov_id,
							L2310A_ref02_TJ_referring_prov_id,
							L2310B_nm102_entity_type_qual,
							L2310B_nm103_rendering_prov_last_nm,
							L2310B_nm104_rendering_prov_first_nm,
							L2310B_nm105_rendering_prov_middle_nm,
							L2310B_nm107_rendering_prov_suffix,
							L2310B_nm108_id_code_qual,
							L2310B_nm109_rendering_prov_id,
							L2310B_prv01_provider_code,
							L2310B_prv02_ref_id_qual,
							L2310B_prv03_taxonomy_code,
							L2310B_ref02_1C_rendering_prov_id,
							L2310B_ref02_1D_rendering_prov_id,
							L2310B_ref02_1E_rendering_prov_id,
							L2310B_ref02_EI_rendering_prov_id,
							L2310B_ref02_G2_rendering_prov_id,
							L2310B_ref02_SY_rendering_prov_id,
							L2310B_ref02_TJ_rendering_prov_id,
							L2310C_nm102_entity_type_qual,
							L2310C_nm103_service_facility_last_nm,
							L2310C_nm108_id_code_qual,
							L2310C_nm109_service_facility_id,
							L2310C_ref02_1C_lab_or_facility_prov_id,
							L2310C_ref02_1D_lab_or_facility_prov_id,
							L2310C_ref02_1G_lab_or_facility_prov_id,
							L2310C_ref02_G2_lab_or_facility_prov_id,
							L2310C_ref02_TJ_lab_or_facility_prov_id,
							L2310D_nm102_entity_type_qual,
							L2310D_nm103_assistant_surgeon_last_nm,
							L2310D_nm104_assistant_surgeon_first_nm,
							L2310D_nm105_assistant_surgeon_middle_nm,
							L2310D_nm107_assistant_surgeon_suffix,
							L2310D_nm108_id_code_qual,
							L2310D_nm109_assistant_surgeon_prov_id,
							L2310D_prv01_provider_code,
							L2310D_prv02_id_code_qual,
							L2310D_prv03_taxonomy_code,
							L2310D_ref02_1C_service_facility_id,
							L2310D_ref02_1D_service_facility_id,
							L2310D_ref02_1E_service_facility_id,
							L2310D_ref02_G2_service_facility_id,
							L2310D_ref02_TJ_service_facility_id,
							L2320_1_sbr01_payer_resp_seq_code,
							L2320_1_sbr02_ind_relationship_code,
							L2320_1_sbr03_insured_grp_policy_num,
							L2320_1_sbr04_insured_grp_nm,
							L2320_1_sbr09_claim_file_ind_code,
							L2320_1_1_cas01_adjustment_group_code,
							L2320_1_1_cas02_adjustment_reason_code,
							L2320_1_1_cas03_adjustment_amt,
							L2320_1_1_cas04_adjustment_qty,
							L2320_1_1_cas05_adjustment_reason_code,
							L2320_1_1_cas06_adjustment_amt,
							L2320_1_1_cas07_adjustment_qty,
							L2320_1_1_cas08_adjustment_reason_code,
							L2320_1_1_cas09_adjustment_amt,
							L2320_1_1_cas10_adjustment_qty,
							L2320_1_2_cas01_adjustment_group_code,
							L2320_1_2_cas02_adjustment_reason_code,
							L2320_1_2_cas03_adjustment_amt,
							L2320_1_2_cas04_adjustment_qty,
							L2320_1_2_cas05_adjustment_reason_code,
							L2320_1_2_cas06_adjustment_amt,
							L2320_1_2_cas07_adjustment_qty,
							L2320_1_2_cas08_adjustment_reason_code,
							L2320_1_2_cas09_adjustment_amt,
							L2320_1_2_cas10_adjustment_qty,
							L2320_1_3_cas01_adjustment_group_code,
							L2320_1_3_cas02_adjustment_reason_code,
							L2320_1_3_cas03_adjustment_amt,
							L2320_1_3_cas04_adjustment_qty,
							L2320_1_3_cas05_adjustment_reason_code,
							L2320_1_3_cas06_adjustment_amt,
							L2320_1_3_cas07_adjustment_qty,
							L2320_1_3_cas08_adjustment_reason_code,
							L2320_1_3_cas09_adjustment_amt,
							L2320_1_3_cas10_adjustment_qty,
							L2320_1_4_cas01_adjustment_group_code,
							L2320_1_4_cas02_adjustment_reason_code,
							L2320_1_4_cas03_adjustment_amt,
							L2320_1_4_cas04_adjustment_qty,
							L2320_1_4_cas05_adjustment_reason_code,
							L2320_1_4_cas06_adjustment_amt,
							L2320_1_4_cas07_adjustment_qty,
							L2320_1_4_cas08_adjustment_reason_code,
							L2320_1_4_cas09_adjustment_amt,
							L2320_1_4_cas10_adjustment_qty,
							L2320_1_5_cas01_adjustment_group_code,
							L2320_1_5_cas02_adjustment_reason_code,
							L2320_1_5_cas03_adjustment_amt,
							L2320_1_5_cas04_adjustment_qty,
							L2320_1_5_cas05_adjustment_reason_code,
							L2320_1_5_cas06_adjustment_amt,
							L2320_1_5_cas07_adjustment_qty,
							L2320_1_5_cas08_adjustment_reason_code,
							L2320_1_5_cas09_adjustment_amt,
							L2320_1_5_cas10_adjustment_qty,
							L2320_1_amt02_D_payer_paid_amt,
							L2320_1_amt02_AAE_cob_approved_amt,
							L2320_1_amt02_B6_cob_allowed_amt,
							L2320_1_amt02_F2_patient_responsibility_amt,
							L2320_1_amt02_AU_cob_covered_amt,
							L2320_1_amt02_D8_discount_amt,
							L2320_1_amt02_F5_payer_patient_paid_amt,
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
							L2330A_1_n301_other_subscriber_address1,
							L2330A_1_n302_other_subscriber_address2,
							L2330A_1_n401_other_subscriber_city,
							L2330A_1_n402_other_subscriber_state,
							L2330A_1_n403_other_subscriber_zip,
							L2330A_1_n404_other_subscriber_country,
							L2330A_1_ref02_1W_other_subscriber_sup_id,
							L2330A_1_ref02_23_other_subscriber_sup_id,
							L2330A_1_ref02_IG_other_subscriber_sup_id,
							L2330A_1_ref02_SY_other_subscriber_sup_id,
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
							L2330B_1_ref02_T4_other_payer_claim_adj_ind,
							L2320_2_sbr01_payer_resp_seq_code,
							L2320_2_sbr02_ind_relationship_code,
							L2320_2_sbr03_insured_grp_policy_num,
							L2320_2_sbr04_insured_grp_nm,
							L2320_2_sbr09_claim_file_ind_code,
							L2320_2_1_cas01_adjustment_group_code,
							L2320_2_1_cas02_adjustment_reason_code,
							L2320_2_1_cas03_adjustment_amt,
							L2320_2_1_cas04_adjustment_qty,
							L2320_2_1_cas05_adjustment_reason_code,
							L2320_2_1_cas06_adjustment_amt,
							L2320_2_1_cas07_adjustment_qty,
							L2320_2_1_cas08_adjustment_reason_code,
							L2320_2_1_cas09_adjustment_amt,
							L2320_2_1_cas10_adjustment_qty,
							L2320_2_2_cas01_adjustment_group_code,
							L2320_2_2_cas02_adjustment_reason_code,
							L2320_2_2_cas03_adjustment_amt,
							L2320_2_2_cas04_adjustment_qty,
							L2320_2_2_cas05_adjustment_reason_code,
							L2320_2_2_cas06_adjustment_amt,
							L2320_2_2_cas07_adjustment_qty,
							L2320_2_2_cas08_adjustment_reason_code,
							L2320_2_2_cas09_adjustment_amt,
							L2320_2_2_cas10_adjustment_qty,
							L2320_2_3_cas01_adjustment_group_code,
							L2320_2_3_cas02_adjustment_reason_code,
							L2320_2_3_cas03_adjustment_amt,
							L2320_2_3_cas04_adjustment_qty,
							L2320_2_3_cas05_adjustment_reason_code,
							L2320_2_3_cas06_adjustment_amt,
							L2320_2_3_cas07_adjustment_qty,
							L2320_2_3_cas08_adjustment_reason_code,
							L2320_2_3_cas09_adjustment_amt,
							L2320_2_3_cas10_adjustment_qty,
							L2320_2_4_cas01_adjustment_group_code,
							L2320_2_4_cas02_adjustment_reason_code,
							L2320_2_4_cas03_adjustment_amt,
							L2320_2_4_cas04_adjustment_qty,
							L2320_2_4_cas05_adjustment_reason_code,
							L2320_2_4_cas06_adjustment_amt,
							L2320_2_4_cas07_adjustment_qty,
							L2320_2_4_cas08_adjustment_reason_code,
							L2320_2_4_cas09_adjustment_amt,
							L2320_2_4_cas10_adjustment_qty,
							L2320_2_5_cas01_adjustment_group_code,
							L2320_2_5_cas02_adjustment_reason_code,
							L2320_2_5_cas03_adjustment_amt,
							L2320_2_5_cas04_adjustment_qty,
							L2320_2_5_cas05_adjustment_reason_code,
							L2320_2_5_cas06_adjustment_amt,
							L2320_2_5_cas07_adjustment_qty,
							L2320_2_5_cas08_adjustment_reason_code,
							L2320_2_5_cas09_adjustment_amt,
							L2320_2_5_cas10_adjustment_qty,
							L2320_2_amt02_D_payer_paid_amt,
							L2320_2_amt02_AAE_cob_approved_amt,
							L2320_2_amt02_B6_cob_allowed_amt,
							L2320_2_amt02_F2_patient_responsibility_amt,
							L2320_2_amt02_AU_cob_covered_amt,
							L2320_2_amt02_D8_discount_amt,
							L2320_2_amt02_F5_payer_patient_paid_amt,
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
							L2330A_2_n301_other_subscriber_address1,
							L2330A_2_n302_other_subscriber_address2,
							L2330A_2_n401_other_subscriber_city,
							L2330A_2_n402_other_subscriber_state,
							L2330A_2_n403_other_subscriber_zip,
							L2330A_2_n404_other_subscriber_country,
							L2330A_2_ref02_1W_other_subscriber_sup_id,
							L2330A_2_ref02_23_other_subscriber_sup_id,
							L2330A_2_ref02_IG_other_subscriber_sup_id,
							L2330A_2_ref02_SY_other_subscriber_sup_id,
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
							L2330B_2_ref02_T4_other_payer_claim_adj_ind,
							L2320_3_sbr01_payer_resp_seq_code,
							L2320_3_sbr02_ind_relationship_code,
							L2320_3_sbr03_insured_grp_policy_num,
							L2320_3_sbr04_insured_grp_nm,
							L2320_3_sbr09_claim_file_ind_code,
							L2320_3_1_cas01_adjustment_group_code,
							L2320_3_1_cas02_adjustment_reason_code,
							L2320_3_1_cas03_adjustment_amt,
							L2320_3_1_cas04_adjustment_qty,
							L2320_3_1_cas05_adjustment_reason_code,
							L2320_3_1_cas06_adjustment_amt,
							L2320_3_1_cas07_adjustment_qty,
							L2320_3_1_cas08_adjustment_reason_code,
							L2320_3_1_cas09_adjustment_amt,
							L2320_3_1_cas10_adjustment_qty,
							L2320_3_2_cas01_adjustment_group_code,
							L2320_3_2_cas02_adjustment_reason_code,
							L2320_3_2_cas03_adjustment_amt,
							L2320_3_2_cas04_adjustment_qty,
							L2320_3_2_cas05_adjustment_reason_code,
							L2320_3_2_cas06_adjustment_amt,
							L2320_3_2_cas07_adjustment_qty,
							L2320_3_2_cas08_adjustment_reason_code,
							L2320_3_2_cas09_adjustment_amt,
							L2320_3_2_cas10_adjustment_qty,
							L2320_3_3_cas01_adjustment_group_code,
							L2320_3_3_cas02_adjustment_reason_code,
							L2320_3_3_cas03_adjustment_amt,
							L2320_3_3_cas04_adjustment_qty,
							L2320_3_3_cas05_adjustment_reason_code,
							L2320_3_3_cas06_adjustment_amt,
							L2320_3_3_cas07_adjustment_qty,
							L2320_3_3_cas08_adjustment_reason_code,
							L2320_3_3_cas09_adjustment_amt,
							L2320_3_3_cas10_adjustment_qty,
							L2320_3_4_cas01_adjustment_group_code,
							L2320_3_4_cas02_adjustment_reason_code,
							L2320_3_4_cas03_adjustment_amt,
							L2320_3_4_cas04_adjustment_qty,
							L2320_3_4_cas05_adjustment_reason_code,
							L2320_3_4_cas06_adjustment_amt,
							L2320_3_4_cas07_adjustment_qty,
							L2320_3_4_cas08_adjustment_reason_code,
							L2320_3_4_cas09_adjustment_amt,
							L2320_3_4_cas10_adjustment_qty,
							L2320_3_5_cas01_adjustment_group_code,
							L2320_3_5_cas02_adjustment_reason_code,
							L2320_3_5_cas03_adjustment_amt,
							L2320_3_5_cas04_adjustment_qty,
							L2320_3_5_cas05_adjustment_reason_code,
							L2320_3_5_cas06_adjustment_amt,
							L2320_3_5_cas07_adjustment_qty,
							L2320_3_5_cas08_adjustment_reason_code,
							L2320_3_5_cas09_adjustment_amt,
							L2320_3_5_cas10_adjustment_qty,
							L2320_3_amt02_D_payer_paid_amt,
							L2320_3_amt02_AAE_cob_approved_amt,
							L2320_3_amt02_B6_cob_allowed_amt,
							L2320_3_amt02_F2_patient_responsibility_amt,
							L2320_3_amt02_AU_cob_covered_amt,
							L2320_3_amt02_D8_discount_amt,
							L2320_3_amt02_F5_payer_patient_paid_amt,
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
							L2330A_3_n301_other_subscriber_address1,
							L2330A_3_n302_other_subscriber_address2,
							L2330A_3_n401_other_subscriber_city,
							L2330A_3_n402_other_subscriber_state,
							L2330A_3_n403_other_subscriber_zip,
							L2330A_3_n404_other_subscriber_country,
							L2330A_3_ref02_1W_other_subscriber_sup_id,
							L2330A_3_ref02_23_other_subscriber_sup_id,
							L2330A_3_ref02_IG_other_subscriber_sup_id,
							L2330A_3_ref02_SY_other_subscriber_sup_id,
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
							L2330B_3_ref02_T4_other_payer_claim_adj_ind,
							L2400_lx01_assigned_num,
							L2400_sv301_proc_code_qual,
							L2400_sv301_proc_code,
							L2400_sv301_proc_mod1,
							L2400_sv301_proc_mod2,
							L2400_sv301_proc_mod3,
							L2400_sv301_proc_mod4,
							L2400_sv302_line_charge,
							L2400_sv303_facility_type_code,
							L2400_sv304_oral_cavity_designation_code_1,
							L2400_sv304_oral_cavity_designation_code_2,
							L2400_sv304_oral_cavity_designation_code_3,
							L2400_sv304_oral_cavity_designation_code_4,
							L2400_sv304_oral_cavity_designation_code_5,
							L2400_sv305_prosthesis_crown_inlay_code,
							L2400_sv306_procedure_count,
							L2400_1_too02_JP_tooth_code,
							L2400_1_too03_tooth_surface_code_1,
							L2400_1_too03_tooth_surface_code_2,
							L2400_1_too03_tooth_surface_code_3,
							L2400_1_too03_tooth_surface_code_4,
							L2400_1_too03_tooth_surface_code_5,
							L2400_2_too02_JP_tooth_code,
							L2400_2_too03_tooth_surface_code_1,
							L2400_2_too03_tooth_surface_code_2,
							L2400_2_too03_tooth_surface_code_3,
							L2400_2_too03_tooth_surface_code_4,
							L2400_2_too03_tooth_surface_code_5,
							L2400_3_too02_JP_tooth_code,
							L2400_3_too03_tooth_surface_code_1,
							L2400_3_too03_tooth_surface_code_2,
							L2400_3_too03_tooth_surface_code_3,
							L2400_3_too03_tooth_surface_code_4,
							L2400_3_too03_tooth_surface_code_5,
							L2400_4_too02_JP_tooth_code,
							L2400_4_too03_tooth_surface_code_1,
							L2400_4_too03_tooth_surface_code_2,
							L2400_4_too03_tooth_surface_code_3,
							L2400_4_too03_tooth_surface_code_4,
							L2400_4_too03_tooth_surface_code_5,
							L2400_5_too02_JP_tooth_code,
							L2400_5_too03_tooth_surface_code_1,
							L2400_5_too03_tooth_surface_code_2,
							L2400_5_too03_tooth_surface_code_3,
							L2400_5_too03_tooth_surface_code_4,
							L2400_5_too03_tooth_surface_code_5,
							L2400_6_too02_JP_tooth_code,
							L2400_6_too03_tooth_surface_code_1,
							L2400_6_too03_tooth_surface_code_2,
							L2400_6_too03_tooth_surface_code_3,
							L2400_6_too03_tooth_surface_code_4,
							L2400_6_too03_tooth_surface_code_5,
							L2400_7_too02_JP_tooth_code,
							L2400_7_too03_tooth_surface_code_1,
							L2400_7_too03_tooth_surface_code_2,
							L2400_7_too03_tooth_surface_code_3,
							L2400_7_too03_tooth_surface_code_4,
							L2400_7_too03_tooth_surface_code_5,
							L2400_8_too02_JP_tooth_code,
							L2400_8_too03_tooth_surface_code_1,
							L2400_8_too03_tooth_surface_code_2,
							L2400_8_too03_tooth_surface_code_3,
							L2400_8_too03_tooth_surface_code_4,
							L2400_8_too03_tooth_surface_code_5,
							L2400_9_too02_JP_tooth_code,
							L2400_9_too03_tooth_surface_code_1,
							L2400_9_too03_tooth_surface_code_2,
							L2400_9_too03_tooth_surface_code_3,
							L2400_9_too03_tooth_surface_code_4,
							L2400_9_too03_tooth_surface_code_5,
							L2400_10_too02_JP_tooth_code,
							L2400_10_too03_tooth_surface_code_1,
							L2400_10_too03_tooth_surface_code_2,
							L2400_10_too03_tooth_surface_code_3,
							L2400_10_too03_tooth_surface_code_4,
							L2400_10_too03_tooth_surface_code_5,
							L2400_11_too02_JP_tooth_code,
							L2400_11_too03_tooth_surface_code_1,
							L2400_11_too03_tooth_surface_code_2,
							L2400_11_too03_tooth_surface_code_3,
							L2400_11_too03_tooth_surface_code_4,
							L2400_11_too03_tooth_surface_code_5,
							L2400_12_too02_JP_tooth_code,
							L2400_12_too03_tooth_surface_code_1,
							L2400_12_too03_tooth_surface_code_2,
							L2400_12_too03_tooth_surface_code_3,
							L2400_12_too03_tooth_surface_code_4,
							L2400_12_too03_tooth_surface_code_5,
							L2400_13_too02_JP_tooth_code,
							L2400_13_too03_tooth_surface_code_1,
							L2400_13_too03_tooth_surface_code_2,
							L2400_13_too03_tooth_surface_code_3,
							L2400_13_too03_tooth_surface_code_4,
							L2400_13_too03_tooth_surface_code_5,
							L2400_14_too02_JP_tooth_code,
							L2400_14_too03_tooth_surface_code_1,
							L2400_14_too03_tooth_surface_code_2,
							L2400_14_too03_tooth_surface_code_3,
							L2400_14_too03_tooth_surface_code_4,
							L2400_14_too03_tooth_surface_code_5,
							L2400_15_too02_JP_tooth_code,
							L2400_15_too03_tooth_surface_code_1,
							L2400_15_too03_tooth_surface_code_2,
							L2400_15_too03_tooth_surface_code_3,
							L2400_15_too03_tooth_surface_code_4,
							L2400_15_too03_tooth_surface_code_5,
							L2400_16_too02_JP_tooth_code,
							L2400_16_too03_tooth_surface_code_1,
							L2400_16_too03_tooth_surface_code_2,
							L2400_16_too03_tooth_surface_code_3,
							L2400_16_too03_tooth_surface_code_4,
							L2400_16_too03_tooth_surface_code_5,
							L2400_17_too02_JP_tooth_code,
							L2400_17_too03_tooth_surface_code_1,
							L2400_17_too03_tooth_surface_code_2,
							L2400_17_too03_tooth_surface_code_3,
							L2400_17_too03_tooth_surface_code_4,
							L2400_17_too03_tooth_surface_code_5,
							L2400_18_too02_JP_tooth_code,
							L2400_18_too03_tooth_surface_code_1,
							L2400_18_too03_tooth_surface_code_2,
							L2400_18_too03_tooth_surface_code_3,
							L2400_18_too03_tooth_surface_code_4,
							L2400_18_too03_tooth_surface_code_5,
							L2400_19_too02_JP_tooth_code,
							L2400_19_too03_tooth_surface_code_1,
							L2400_19_too03_tooth_surface_code_2,
							L2400_19_too03_tooth_surface_code_3,
							L2400_19_too03_tooth_surface_code_4,
							L2400_19_too03_tooth_surface_code_5,
							L2400_20_too02_JP_tooth_code,
							L2400_20_too03_tooth_surface_code_1,
							L2400_20_too03_tooth_surface_code_2,
							L2400_20_too03_tooth_surface_code_3,
							L2400_20_too03_tooth_surface_code_4,
							L2400_20_too03_tooth_surface_code_5,
							L2400_21_too02_JP_tooth_code,
							L2400_21_too03_tooth_surface_code_1,
							L2400_21_too03_tooth_surface_code_2,
							L2400_21_too03_tooth_surface_code_3,
							L2400_21_too03_tooth_surface_code_4,
							L2400_21_too03_tooth_surface_code_5,
							L2400_22_too02_JP_tooth_code,
							L2400_22_too03_tooth_surface_code_1,
							L2400_22_too03_tooth_surface_code_2,
							L2400_22_too03_tooth_surface_code_3,
							L2400_22_too03_tooth_surface_code_4,
							L2400_22_too03_tooth_surface_code_5,
							L2400_23_too02_JP_tooth_code,
							L2400_23_too03_tooth_surface_code_1,
							L2400_23_too03_tooth_surface_code_2,
							L2400_23_too03_tooth_surface_code_3,
							L2400_23_too03_tooth_surface_code_4,
							L2400_23_too03_tooth_surface_code_5,
							L2400_24_too02_JP_tooth_code,
							L2400_24_too03_tooth_surface_code_1,
							L2400_24_too03_tooth_surface_code_2,
							L2400_24_too03_tooth_surface_code_3,
							L2400_24_too03_tooth_surface_code_4,
							L2400_24_too03_tooth_surface_code_5,
							L2400_25_too02_JP_tooth_code,
							L2400_25_too03_tooth_surface_code_1,
							L2400_25_too03_tooth_surface_code_2,
							L2400_25_too03_tooth_surface_code_3,
							L2400_25_too03_tooth_surface_code_4,
							L2400_25_too03_tooth_surface_code_5,
							L2400_26_too02_JP_tooth_code,
							L2400_26_too03_tooth_surface_code_1,
							L2400_26_too03_tooth_surface_code_2,
							L2400_26_too03_tooth_surface_code_3,
							L2400_26_too03_tooth_surface_code_4,
							L2400_26_too03_tooth_surface_code_5,
							L2400_27_too02_JP_tooth_code,
							L2400_27_too03_tooth_surface_code_1,
							L2400_27_too03_tooth_surface_code_2,
							L2400_27_too03_tooth_surface_code_3,
							L2400_27_too03_tooth_surface_code_4,
							L2400_27_too03_tooth_surface_code_5,
							L2400_28_too02_JP_tooth_code,
							L2400_28_too03_tooth_surface_code_1,
							L2400_28_too03_tooth_surface_code_2,
							L2400_28_too03_tooth_surface_code_3,
							L2400_28_too03_tooth_surface_code_4,
							L2400_28_too03_tooth_surface_code_5,
							L2400_29_too02_JP_tooth_code,
							L2400_29_too03_tooth_surface_code_1,
							L2400_29_too03_tooth_surface_code_2,
							L2400_29_too03_tooth_surface_code_3,
							L2400_29_too03_tooth_surface_code_4,
							L2400_29_too03_tooth_surface_code_5,
							L2400_30_too02_JP_tooth_code,
							L2400_30_too03_tooth_surface_code_1,
							L2400_30_too03_tooth_surface_code_2,
							L2400_30_too03_tooth_surface_code_3,
							L2400_30_too03_tooth_surface_code_4,
							L2400_30_too03_tooth_surface_code_5,
							L2400_31_too02_JP_tooth_code,
							L2400_31_too03_tooth_surface_code_1,
							L2400_31_too03_tooth_surface_code_2,
							L2400_31_too03_tooth_surface_code_3,
							L2400_31_too03_tooth_surface_code_4,
							L2400_31_too03_tooth_surface_code_5,
							L2400_32_too02_JP_tooth_code,
							L2400_32_too03_tooth_surface_code_1,
							L2400_32_too03_tooth_surface_code_2,
							L2400_32_too03_tooth_surface_code_3,
							L2400_32_too03_tooth_surface_code_4,
							L2400_32_too03_tooth_surface_code_5,
							L2400_dtp02_472_service_date,
							L2400_dtp02_441_prior_placement_date,
							L2400_dtp02_452_orthodontic_banding_date,
							L2400_dtp02_446_replacement_date,
							L2400_1_qty01_qty_qual,
							L2400_1_qty02_anesthesia_unit_count,
							L2400_2_qty01_qty_qual,
							L2400_2_qty02_anesthesia_unit_count,
							L2400_3_qty01_qty_qual,
							L2400_3_qty02_anesthesia_unit_count,
							L2400_4_qty01_qty_qual,
							L2400_4_qty02_anesthesia_unit_count,
							L2400_5_qty01_qty_qual,
							L2400_5_qty02_anesthesia_unit_count,
							L2400_ref02_G3_predetermination_of_benefits_id,
							L2400_ref02_9F_referral_number,
							L2400_ref02_G1_prior_auth_number,
							L2400_ref02_6R_line_item_control_num,
							L2400_amt02_AAE_approved_amt,
							L2400_amt02_T_sales_tax_amt,
							L2400_nte01_note_ref_code,
							L2400_nte02_line_note_text,
							L2420A_nm102_entity_type_qual,
							L2420A_nm103_rendering_prov_last_nm,
							L2420A_nm104_rendering_prov_first_nm,
							L2420A_nm105_rendering_prov_middle_nm,
							L2420A_nm107_rendering_prov_suffix,
							L2420A_nm108_id_code_qual,
							L2420A_nm109_rendering_prov_id,
							L2420A_prv01_provider_code,
							L2420A_prv02_ref_id_qual,
							L2420A_prv03_taxonomy_code,
							L2420A_ref02_1C_rendering_prov_id,
							L2420A_ref02_1D_rendering_prov_id,
							L2420A_ref02_1E_rendering_prov_id,
							L2420A_ref02_EI_rendering_prov_id,
							L2420A_ref02_SY_rendering_prov_id,
							L2420A_ref02_TJ_rendering_prov_id,
							L2420B_nm102_entity_type_qual,
							L2420B_nm103_payer_last_nm,
							L2420B_nm108_id_code_qual,
							L2420B_nm109_other_payer_id,
							L2420B_ref02_9F_referral_number,
							L2420B_ref02_G1_prior_auth_number,
							L2420C_nm101_entity_id_code,
							L2420C_nm102_entity_type_qual,
							L2420C_nm103_assistant_surgeon_last_nm,
							L2420C_nm104_assistant_surgeon_first_nm,
							L2420C_nm105_assistant_surgeon_middle_nm,
							L2420C_nm107_assistant_surgeon_suffix,
							L2420C_nm108_id_code_qual,
							L2420C_nm109_assistant_surgeon_id,
							L2420C_prv01_provider_code,
							L2420C_prv02_ref_id_qual,
							L2420C_prv03_taxonomy_code,
							L2420C_ref02_1C_service_facility_id,
							L2420C_ref02_1D_service_facility_id,
							L2420C_ref02_1E_service_facility_id,
							L2420C_ref02_G2_service_facility_id,
							L2420C_ref02_TJ_service_facility_id,
							L2430_svd01_other_payer_id,
							L2430_svd02_service_line_paid,
							L2430_svd03_service_id_qual,
							L2430_svd03_proc_code,
							L2430_svd03_proc_mod1,
							L2430_svd03_proc_mod2,
							L2430_svd03_proc_mod3,
							L2430_svd03_proc_mod4,
							L2430_svd03_proc_code_desc,
							L2430_svd05_paid_service_unit,
							L2430_svd06_bundled_unbundled_line_num,
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
							L2430_dtp03_573_date_claim_paid
						)
				values
				(	@x12_transaction_id,
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
					@L2010AA_ref02_1C_billing_prov_id,
					@L2010AA_ref02_1D_billing_prov_id,
					@L2010AA_ref02_1E_billing_prov_id,
					@L2010AA_ref02_EI_billing_prov_id,
					@L2010AA_ref02_SY_billing_prov_id,
					@L2010AA_ref02_TJ_billing_prov_id,
					@L2010AA_ref02_06_card_billing_id,
					@L2010AA_ref02_8U_card_billing_id,
					@L2010AA_ref02_EM_card_billing_id,
					@L2010AA_ref02_IJ_card_billing_id,
					@L2010AA_ref02_LU_card_billing_id,
					@L2010AA_ref02_ST_card_billing_id,
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
					@L2010AB_ref02_1E_payto_prov_id,
					@L2010AB_ref02_EI_payto_prov_id,
					@L2010AB_ref02_SY_payto_prov_id,
					@L2010AB_ref02_TJ_payto_prov_id,
					@L2000B_hl01_hierarchical_id_num,
					@L2000B_hl02_hierarchical_parent_id_num,
					@L2000B_hl03_hierarchical_level_code,
					@L2000B_hl04_hierarchical_child_code,
					@L2000B_sbr01_payer_resp_seq_code,
					@L2000B_sbr02_ind_relationship_code,
					@L2000B_sbr03_insured_grp_policy_num,
					@L2000B_sbr04_insured_grp_nm,
					@L2000B_sbr06_cob_code,
					@L2000B_sbr09_claim_filing_ind_code,
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
					@L2010BB_nm103_payer_nm,
					@L2010BB_nm108_payer_id_qual,
					@L2010BB_nm109_payer_id,
					@L2010BB_n301_payer_address1,
					@L2010BB_n302_payer_address2,
					@L2010BB_n401_payer_city,
					@L2010BB_n402_payer_state,
					@L2010BB_n403_payer_zip,
					@L2010BB_n404_payer_country,
					@L2010BB_ref02_2U_payer_id,
					@L2010BB_ref02_FY_payer_id,
					@L2010BB_ref02_NF_payer_id,
					@L2010BB_ref02_TJ_payer_id,
					@L2010BC_nm102_entity_type_qual,
					@L2010BC_nm103_resp_party_last_nm,
					@L2010BC_nm104_resp_party_first_nm,
					@L2010BC_nm105_resp_party_middle_nm,
					@L2010BC_nm107_resp_party_suffix,
					@L2010BC_nm109_MI_card_num,
					@L2010BC_ref02_BB_card_num,
					@L2000C_hl01_hierarchical_id_num,
					@L2000C_hl02_hierarchical_parent_id_num,
					@L2000C_hl03_hierarchical_level_code,
					@L2000C_hl04_hierarchical_child_code,
					@L2000C_pat01_ind_relationship_code,
					@L2000C_pat04_student_status_code,
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
					@L2300_clm05_claim_freq_code,
					@L2300_clm06_provider_signature_ind,
					@L2300_clm07_medicare_assign_code,
					@L2300_clm08_benefit_assign_ind,
					@L2300_clm09_release_of_info_code,
					@L2300_clm11_related_causes_code1,
					@L2300_clm11_related_causes_code2,
					@L2300_clm11_related_causes_code3,
					@L2300_clm11_auto_accident_state_code,
					@L2300_clm11_country_code,
					@L2300_clm12_special_prog_ind,
					@L2300_clm19_claim_submission_reason_code,
					@L2300_clm20_delay_reason_code,
					@L2300_dtp03_435_related_hospitalization_admission_date,
					@L2300_dtp03_096_discharge_end_of_care_date,
					@L2300_dtp03_330_referral_date,
					@L2300_dtp03_439_accident_date,
					@L2300_dtp03_452_orthodontic_banding_date,
					@L2300_dtp03_472_service_date,
					@L2300_dn101_orthodontic_treatment_months_count,
					@L2300_dn102_orthodontic_treatment_months_remaining_count,
					@L2300_dn103_question_response,
					@L2300_1_dn201_tooth_number,
					@L2300_1_dn202_tooth_status_code,
					@L2300_2_dn201_tooth_number,
					@L2300_2_dn202_tooth_status_code,
					@L2300_3_dn201_tooth_number,
					@L2300_3_dn202_tooth_status_code,
					@L2300_4_dn201_tooth_number,
					@L2300_4_dn202_tooth_status_code,
					@L2300_5_dn201_tooth_number,
					@L2300_5_dn202_tooth_status_code,
					@L2300_6_dn201_tooth_number,
					@L2300_6_dn202_tooth_status_code,
					@L2300_7_dn201_tooth_number,
					@L2300_7_dn202_tooth_status_code,
					@L2300_8_dn201_tooth_number,
					@L2300_8_dn202_tooth_status_code,
					@L2300_9_dn201_tooth_number,
					@L2300_9_dn202_tooth_status_code,
					@L2300_10_dn201_tooth_number,
					@L2300_10_dn202_tooth_status_code,
					@L2300_11_dn201_tooth_number,
					@L2300_11_dn202_tooth_status_code,
					@L2300_12_dn201_tooth_number,
					@L2300_12_dn202_tooth_status_code,
					@L2300_13_dn201_tooth_number,
					@L2300_13_dn202_tooth_status_code,
					@L2300_14_dn201_tooth_number,
					@L2300_14_dn202_tooth_status_code,
					@L2300_15_dn201_tooth_number,
					@L2300_15_dn202_tooth_status_code,
					@L2300_16_dn201_tooth_number,
					@L2300_16_dn202_tooth_status_code,
					@L2300_17_dn201_tooth_number,
					@L2300_17_dn202_tooth_status_code,
					@L2300_18_dn201_tooth_number,
					@L2300_18_dn202_tooth_status_code,
					@L2300_19_dn201_tooth_number,
					@L2300_19_dn202_tooth_status_code,
					@L2300_20_dn201_tooth_number,
					@L2300_20_dn202_tooth_status_code,
					@L2300_21_dn201_tooth_number,
					@L2300_21_dn202_tooth_status_code,
					@L2300_22_dn201_tooth_number,
					@L2300_22_dn202_tooth_status_code,
					@L2300_23_dn201_tooth_number,
					@L2300_23_dn202_tooth_status_code,
					@L2300_24_dn201_tooth_number,
					@L2300_24_dn202_tooth_status_code,
					@L2300_25_dn201_tooth_number,
					@L2300_25_dn202_tooth_status_code,
					@L2300_26_dn201_tooth_number,
					@L2300_26_dn202_tooth_status_code,
					@L2300_27_dn201_tooth_number,
					@L2300_27_dn202_tooth_status_code,
					@L2300_28_dn201_tooth_number,
					@L2300_28_dn202_tooth_status_code,
					@L2300_29_dn201_tooth_number,
					@L2300_29_dn202_tooth_status_code,
					@L2300_30_dn201_tooth_number,
					@L2300_30_dn202_tooth_status_code,
					@L2300_31_dn201_tooth_number,
					@L2300_31_dn202_tooth_status_code,
					@L2300_32_dn201_tooth_number,
					@L2300_32_dn202_tooth_status_code,
					@L2300_33_dn201_tooth_number,
					@L2300_33_dn202_tooth_status_code,
					@L2300_34_dn201_tooth_number,
					@L2300_34_dn202_tooth_status_code,
					@L2300_35_dn201_tooth_number,
					@L2300_35_dn202_tooth_status_code,
					@L2300_pwk01_attachment_type_code,
					@L2300_pwk02_attachment_trans_code,
					@L2300_pwk06_attachment_control_num,
					@L2300_amt02_patient_paid_amt,
					@L2300_amt02_card_maximum_amt,
					@L2300_ref02_G3_predetermination_id,
					@L2300_ref02_4N_service_auth_exception_code,
					@L2300_ref02_F8_original_ref_num,
					@L2300_ref02_9F_referral_num,
					@L2300_ref02_G1_prior_auth_num,
					@L2300_ref02_D9_value_added_network_trace_num,
					@L2300_nte01_note_ref_code,
					@L2300_nte02_claim_note_text,
					@L2310A_nm101_entity_id_code,
					@L2310A_nm102_entity_type_qual,
					@L2310A_nm103_referring_prov_last_nm,
					@L2310A_nm104_referring_prov_first_nm,
					@L2310A_nm105_referring_prov_middle_nm,
					@L2310A_nm107_referring_prov_suffix,
					@L2310A_nm108_id_code_qual,
					@L2310A_nm109_referring_prov_id,
					@L2310A_prv01_provider_code,
					@L2310A_prv02_ref_id_qual,
					@L2310A_prv03_taxonomy_code,
					@L2310A_ref02_1C_referring_prov_id,
					@L2310A_ref02_1D_referring_prov_id,
					@L2310A_ref02_1E_referring_prov_id,
					@L2310A_ref02_EI_referring_prov_id,
					@L2310A_ref02_G2_referring_prov_id,
					@L2310A_ref02_SY_referring_prov_id,
					@L2310A_ref02_TJ_referring_prov_id,
					@L2310B_nm102_entity_type_qual,
					@L2310B_nm103_rendering_prov_last_nm,
					@L2310B_nm104_rendering_prov_first_nm,
					@L2310B_nm105_rendering_prov_middle_nm,
					@L2310B_nm107_rendering_prov_suffix,
					@L2310B_nm108_id_code_qual,
					@L2310B_nm109_rendering_prov_id,
					@L2310B_prv01_provider_code,
					@L2310B_prv02_ref_id_qual,
					@L2310B_prv03_taxonomy_code,
					@L2310B_ref02_1C_rendering_prov_id,
					@L2310B_ref02_1D_rendering_prov_id,
					@L2310B_ref02_1E_rendering_prov_id,
					@L2310B_ref02_EI_rendering_prov_id,
					@L2310B_ref02_G2_rendering_prov_id,
					@L2310B_ref02_SY_rendering_prov_id,
					@L2310B_ref02_TJ_rendering_prov_id,
					@L2310C_nm102_entity_type_qual,
					@L2310C_nm103_service_facility_last_nm,
					@L2310C_nm108_id_code_qual,
					@L2310C_nm109_service_facility_id,
					@L2310C_ref02_1C_lab_or_facility_prov_id,
					@L2310C_ref02_1D_lab_or_facility_prov_id,
					@L2310C_ref02_1G_lab_or_facility_prov_id,
					@L2310C_ref02_G2_lab_or_facility_prov_id,
					@L2310C_ref02_TJ_lab_or_facility_prov_id,
					@L2310D_nm102_entity_type_qual,
					@L2310D_nm103_assistant_surgeon_last_nm,
					@L2310D_nm104_assistant_surgeon_first_nm,
					@L2310D_nm105_assistant_surgeon_middle_nm,
					@L2310D_nm107_assistant_surgeon_suffix,
					@L2310D_nm108_id_code_qual,
					@L2310D_nm109_assistant_surgeon_prov_id,
					@L2310D_prv01_provider_code,
					@L2310D_prv02_id_code_qual,
					@L2310D_prv03_taxonomy_code,
					@L2310D_ref02_1C_service_facility_id,
					@L2310D_ref02_1D_service_facility_id,
					@L2310D_ref02_1E_service_facility_id,
					@L2310D_ref02_G2_service_facility_id,
					@L2310D_ref02_TJ_service_facility_id,
					@L2320_1_sbr01_payer_resp_seq_code,
					@L2320_1_sbr02_ind_relationship_code,
					@L2320_1_sbr03_insured_grp_policy_num,
					@L2320_1_sbr04_insured_grp_nm,
					@L2320_1_sbr09_claim_file_ind_code,
					@L2320_1_1_cas01_adjustment_group_code,
					@L2320_1_1_cas02_adjustment_reason_code,
					@L2320_1_1_cas03_adjustment_amt,
					@L2320_1_1_cas04_adjustment_qty,
					@L2320_1_1_cas05_adjustment_reason_code,
					@L2320_1_1_cas06_adjustment_amt,
					@L2320_1_1_cas07_adjustment_qty,
					@L2320_1_1_cas08_adjustment_reason_code,
					@L2320_1_1_cas09_adjustment_amt,
					@L2320_1_1_cas10_adjustment_qty,
					@L2320_1_2_cas01_adjustment_group_code,
					@L2320_1_2_cas02_adjustment_reason_code,
					@L2320_1_2_cas03_adjustment_amt,
					@L2320_1_2_cas04_adjustment_qty,
					@L2320_1_2_cas05_adjustment_reason_code,
					@L2320_1_2_cas06_adjustment_amt,
					@L2320_1_2_cas07_adjustment_qty,
					@L2320_1_2_cas08_adjustment_reason_code,
					@L2320_1_2_cas09_adjustment_amt,
					@L2320_1_2_cas10_adjustment_qty,
					@L2320_1_3_cas01_adjustment_group_code,
					@L2320_1_3_cas02_adjustment_reason_code,
					@L2320_1_3_cas03_adjustment_amt,
					@L2320_1_3_cas04_adjustment_qty,
					@L2320_1_3_cas05_adjustment_reason_code,
					@L2320_1_3_cas06_adjustment_amt,
					@L2320_1_3_cas07_adjustment_qty,
					@L2320_1_3_cas08_adjustment_reason_code,
					@L2320_1_3_cas09_adjustment_amt,
					@L2320_1_3_cas10_adjustment_qty,
					@L2320_1_4_cas01_adjustment_group_code,
					@L2320_1_4_cas02_adjustment_reason_code,
					@L2320_1_4_cas03_adjustment_amt,
					@L2320_1_4_cas04_adjustment_qty,
					@L2320_1_4_cas05_adjustment_reason_code,
					@L2320_1_4_cas06_adjustment_amt,
					@L2320_1_4_cas07_adjustment_qty,
					@L2320_1_4_cas08_adjustment_reason_code,
					@L2320_1_4_cas09_adjustment_amt,
					@L2320_1_4_cas10_adjustment_qty,
					@L2320_1_5_cas01_adjustment_group_code,
					@L2320_1_5_cas02_adjustment_reason_code,
					@L2320_1_5_cas03_adjustment_amt,
					@L2320_1_5_cas04_adjustment_qty,
					@L2320_1_5_cas05_adjustment_reason_code,
					@L2320_1_5_cas06_adjustment_amt,
					@L2320_1_5_cas07_adjustment_qty,
					@L2320_1_5_cas08_adjustment_reason_code,
					@L2320_1_5_cas09_adjustment_amt,
					@L2320_1_5_cas10_adjustment_qty,
					@L2320_1_amt02_D_payer_paid_amt,
					@L2320_1_amt02_AAE_cob_approved_amt,
					@L2320_1_amt02_B6_cob_allowed_amt,
					@L2320_1_amt02_F2_patient_responsibility_amt,
					@L2320_1_amt02_AU_cob_covered_amt,
					@L2320_1_amt02_D8_discount_amt,
					@L2320_1_amt02_F5_payer_patient_paid_amt,
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
					@L2330A_1_n301_other_subscriber_address1,
					@L2330A_1_n302_other_subscriber_address2,
					@L2330A_1_n401_other_subscriber_city,
					@L2330A_1_n402_other_subscriber_state,
					@L2330A_1_n403_other_subscriber_zip,
					@L2330A_1_n404_other_subscriber_country,
					@L2330A_1_ref02_1W_other_subscriber_sup_id,
					@L2330A_1_ref02_23_other_subscriber_sup_id,
					@L2330A_1_ref02_IG_other_subscriber_sup_id,
					@L2330A_1_ref02_SY_other_subscriber_sup_id,
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
					@L2330B_1_ref02_T4_other_payer_claim_adj_ind,
					@L2320_2_sbr01_payer_resp_seq_code,
					@L2320_2_sbr02_ind_relationship_code,
					@L2320_2_sbr03_insured_grp_policy_num,
					@L2320_2_sbr04_insured_grp_nm,
					@L2320_2_sbr09_claim_file_ind_code,
					@L2320_2_1_cas01_adjustment_group_code,
					@L2320_2_1_cas02_adjustment_reason_code,
					@L2320_2_1_cas03_adjustment_amt,
					@L2320_2_1_cas04_adjustment_qty,
					@L2320_2_1_cas05_adjustment_reason_code,
					@L2320_2_1_cas06_adjustment_amt,
					@L2320_2_1_cas07_adjustment_qty,
					@L2320_2_1_cas08_adjustment_reason_code,
					@L2320_2_1_cas09_adjustment_amt,
					@L2320_2_1_cas10_adjustment_qty,
					@L2320_2_2_cas01_adjustment_group_code,
					@L2320_2_2_cas02_adjustment_reason_code,
					@L2320_2_2_cas03_adjustment_amt,
					@L2320_2_2_cas04_adjustment_qty,
					@L2320_2_2_cas05_adjustment_reason_code,
					@L2320_2_2_cas06_adjustment_amt,
					@L2320_2_2_cas07_adjustment_qty,
					@L2320_2_2_cas08_adjustment_reason_code,
					@L2320_2_2_cas09_adjustment_amt,
					@L2320_2_2_cas10_adjustment_qty,
					@L2320_2_3_cas01_adjustment_group_code,
					@L2320_2_3_cas02_adjustment_reason_code,
					@L2320_2_3_cas03_adjustment_amt,
					@L2320_2_3_cas04_adjustment_qty,
					@L2320_2_3_cas05_adjustment_reason_code,
					@L2320_2_3_cas06_adjustment_amt,
					@L2320_2_3_cas07_adjustment_qty,
					@L2320_2_3_cas08_adjustment_reason_code,
					@L2320_2_3_cas09_adjustment_amt,
					@L2320_2_3_cas10_adjustment_qty,
					@L2320_2_4_cas01_adjustment_group_code,
					@L2320_2_4_cas02_adjustment_reason_code,
					@L2320_2_4_cas03_adjustment_amt,
					@L2320_2_4_cas04_adjustment_qty,
					@L2320_2_4_cas05_adjustment_reason_code,
					@L2320_2_4_cas06_adjustment_amt,
					@L2320_2_4_cas07_adjustment_qty,
					@L2320_2_4_cas08_adjustment_reason_code,
					@L2320_2_4_cas09_adjustment_amt,
					@L2320_2_4_cas10_adjustment_qty,
					@L2320_2_5_cas01_adjustment_group_code,
					@L2320_2_5_cas02_adjustment_reason_code,
					@L2320_2_5_cas03_adjustment_amt,
					@L2320_2_5_cas04_adjustment_qty,
					@L2320_2_5_cas05_adjustment_reason_code,
					@L2320_2_5_cas06_adjustment_amt,
					@L2320_2_5_cas07_adjustment_qty,
					@L2320_2_5_cas08_adjustment_reason_code,
					@L2320_2_5_cas09_adjustment_amt,
					@L2320_2_5_cas10_adjustment_qty,
					@L2320_2_amt02_D_payer_paid_amt,
					@L2320_2_amt02_AAE_cob_approved_amt,
					@L2320_2_amt02_B6_cob_allowed_amt,
					@L2320_2_amt02_F2_patient_responsibility_amt,
					@L2320_2_amt02_AU_cob_covered_amt,
					@L2320_2_amt02_D8_discount_amt,
					@L2320_2_amt02_F5_payer_patient_paid_amt,
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
					@L2330A_2_n301_other_subscriber_address1,
					@L2330A_2_n302_other_subscriber_address2,
					@L2330A_2_n401_other_subscriber_city,
					@L2330A_2_n402_other_subscriber_state,
					@L2330A_2_n403_other_subscriber_zip,
					@L2330A_2_n404_other_subscriber_country,
					@L2330A_2_ref02_1W_other_subscriber_sup_id,
					@L2330A_2_ref02_23_other_subscriber_sup_id,
					@L2330A_2_ref02_IG_other_subscriber_sup_id,
					@L2330A_2_ref02_SY_other_subscriber_sup_id,
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
					@L2330B_2_ref02_T4_other_payer_claim_adj_ind,
					@L2320_3_sbr01_payer_resp_seq_code,
					@L2320_3_sbr02_ind_relationship_code,
					@L2320_3_sbr03_insured_grp_policy_num,
					@L2320_3_sbr04_insured_grp_nm,
					@L2320_3_sbr09_claim_file_ind_code,
					@L2320_3_1_cas01_adjustment_group_code,
					@L2320_3_1_cas02_adjustment_reason_code,
					@L2320_3_1_cas03_adjustment_amt,
					@L2320_3_1_cas04_adjustment_qty,
					@L2320_3_1_cas05_adjustment_reason_code,
					@L2320_3_1_cas06_adjustment_amt,
					@L2320_3_1_cas07_adjustment_qty,
					@L2320_3_1_cas08_adjustment_reason_code,
					@L2320_3_1_cas09_adjustment_amt,
					@L2320_3_1_cas10_adjustment_qty,
					@L2320_3_2_cas01_adjustment_group_code,
					@L2320_3_2_cas02_adjustment_reason_code,
					@L2320_3_2_cas03_adjustment_amt,
					@L2320_3_2_cas04_adjustment_qty,
					@L2320_3_2_cas05_adjustment_reason_code,
					@L2320_3_2_cas06_adjustment_amt,
					@L2320_3_2_cas07_adjustment_qty,
					@L2320_3_2_cas08_adjustment_reason_code,
					@L2320_3_2_cas09_adjustment_amt,
					@L2320_3_2_cas10_adjustment_qty,
					@L2320_3_3_cas01_adjustment_group_code,
					@L2320_3_3_cas02_adjustment_reason_code,
					@L2320_3_3_cas03_adjustment_amt,
					@L2320_3_3_cas04_adjustment_qty,
					@L2320_3_3_cas05_adjustment_reason_code,
					@L2320_3_3_cas06_adjustment_amt,
					@L2320_3_3_cas07_adjustment_qty,
					@L2320_3_3_cas08_adjustment_reason_code,
					@L2320_3_3_cas09_adjustment_amt,
					@L2320_3_3_cas10_adjustment_qty,
					@L2320_3_4_cas01_adjustment_group_code,
					@L2320_3_4_cas02_adjustment_reason_code,
					@L2320_3_4_cas03_adjustment_amt,
					@L2320_3_4_cas04_adjustment_qty,
					@L2320_3_4_cas05_adjustment_reason_code,
					@L2320_3_4_cas06_adjustment_amt,
					@L2320_3_4_cas07_adjustment_qty,
					@L2320_3_4_cas08_adjustment_reason_code,
					@L2320_3_4_cas09_adjustment_amt,
					@L2320_3_4_cas10_adjustment_qty,
					@L2320_3_5_cas01_adjustment_group_code,
					@L2320_3_5_cas02_adjustment_reason_code,
					@L2320_3_5_cas03_adjustment_amt,
					@L2320_3_5_cas04_adjustment_qty,
					@L2320_3_5_cas05_adjustment_reason_code,
					@L2320_3_5_cas06_adjustment_amt,
					@L2320_3_5_cas07_adjustment_qty,
					@L2320_3_5_cas08_adjustment_reason_code,
					@L2320_3_5_cas09_adjustment_amt,
					@L2320_3_5_cas10_adjustment_qty,
					@L2320_3_amt02_D_payer_paid_amt,
					@L2320_3_amt02_AAE_cob_approved_amt,
					@L2320_3_amt02_B6_cob_allowed_amt,
					@L2320_3_amt02_F2_patient_responsibility_amt,
					@L2320_3_amt02_AU_cob_covered_amt,
					@L2320_3_amt02_D8_discount_amt,
					@L2320_3_amt02_F5_payer_patient_paid_amt,
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
					@L2330A_3_n301_other_subscriber_address1,
					@L2330A_3_n302_other_subscriber_address2,
					@L2330A_3_n401_other_subscriber_city,
					@L2330A_3_n402_other_subscriber_state,
					@L2330A_3_n403_other_subscriber_zip,
					@L2330A_3_n404_other_subscriber_country,
					@L2330A_3_ref02_1W_other_subscriber_sup_id,
					@L2330A_3_ref02_23_other_subscriber_sup_id,
					@L2330A_3_ref02_IG_other_subscriber_sup_id,
					@L2330A_3_ref02_SY_other_subscriber_sup_id,
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
					@L2330B_3_ref02_T4_other_payer_claim_adj_ind,
					@L2400_lx01_assigned_num,
					@L2400_sv301_proc_code_qual,
					@L2400_sv301_proc_code,
					@L2400_sv301_proc_mod1,
					@L2400_sv301_proc_mod2,
					@L2400_sv301_proc_mod3,
					@L2400_sv301_proc_mod4,
					@L2400_sv302_line_charge,
					@L2400_sv303_facility_type_code,
					@L2400_sv304_oral_cavity_designation_code_1,
					@L2400_sv304_oral_cavity_designation_code_2,
					@L2400_sv304_oral_cavity_designation_code_3,
					@L2400_sv304_oral_cavity_designation_code_4,
					@L2400_sv304_oral_cavity_designation_code_5,
					@L2400_sv305_prosthesis_crown_inlay_code,
					@L2400_sv306_procedure_count,
					@L2400_1_too02_JP_tooth_code,
					@L2400_1_too03_tooth_surface_code_1,
					@L2400_1_too03_tooth_surface_code_2,
					@L2400_1_too03_tooth_surface_code_3,
					@L2400_1_too03_tooth_surface_code_4,
					@L2400_1_too03_tooth_surface_code_5,
					@L2400_2_too02_JP_tooth_code,
					@L2400_2_too03_tooth_surface_code_1,
					@L2400_2_too03_tooth_surface_code_2,
					@L2400_2_too03_tooth_surface_code_3,
					@L2400_2_too03_tooth_surface_code_4,
					@L2400_2_too03_tooth_surface_code_5,
					@L2400_3_too02_JP_tooth_code,
					@L2400_3_too03_tooth_surface_code_1,
					@L2400_3_too03_tooth_surface_code_2,
					@L2400_3_too03_tooth_surface_code_3,
					@L2400_3_too03_tooth_surface_code_4,
					@L2400_3_too03_tooth_surface_code_5,
					@L2400_4_too02_JP_tooth_code,
					@L2400_4_too03_tooth_surface_code_1,
					@L2400_4_too03_tooth_surface_code_2,
					@L2400_4_too03_tooth_surface_code_3,
					@L2400_4_too03_tooth_surface_code_4,
					@L2400_4_too03_tooth_surface_code_5,
					@L2400_5_too02_JP_tooth_code,
					@L2400_5_too03_tooth_surface_code_1,
					@L2400_5_too03_tooth_surface_code_2,
					@L2400_5_too03_tooth_surface_code_3,
					@L2400_5_too03_tooth_surface_code_4,
					@L2400_5_too03_tooth_surface_code_5,
					@L2400_6_too02_JP_tooth_code,
					@L2400_6_too03_tooth_surface_code_1,
					@L2400_6_too03_tooth_surface_code_2,
					@L2400_6_too03_tooth_surface_code_3,
					@L2400_6_too03_tooth_surface_code_4,
					@L2400_6_too03_tooth_surface_code_5,
					@L2400_7_too02_JP_tooth_code,
					@L2400_7_too03_tooth_surface_code_1,
					@L2400_7_too03_tooth_surface_code_2,
					@L2400_7_too03_tooth_surface_code_3,
					@L2400_7_too03_tooth_surface_code_4,
					@L2400_7_too03_tooth_surface_code_5,
					@L2400_8_too02_JP_tooth_code,
					@L2400_8_too03_tooth_surface_code_1,
					@L2400_8_too03_tooth_surface_code_2,
					@L2400_8_too03_tooth_surface_code_3,
					@L2400_8_too03_tooth_surface_code_4,
					@L2400_8_too03_tooth_surface_code_5,
					@L2400_9_too02_JP_tooth_code,
					@L2400_9_too03_tooth_surface_code_1,
					@L2400_9_too03_tooth_surface_code_2,
					@L2400_9_too03_tooth_surface_code_3,
					@L2400_9_too03_tooth_surface_code_4,
					@L2400_9_too03_tooth_surface_code_5,
					@L2400_10_too02_JP_tooth_code,
					@L2400_10_too03_tooth_surface_code_1,
					@L2400_10_too03_tooth_surface_code_2,
					@L2400_10_too03_tooth_surface_code_3,
					@L2400_10_too03_tooth_surface_code_4,
					@L2400_10_too03_tooth_surface_code_5,
					@L2400_11_too02_JP_tooth_code,
					@L2400_11_too03_tooth_surface_code_1,
					@L2400_11_too03_tooth_surface_code_2,
					@L2400_11_too03_tooth_surface_code_3,
					@L2400_11_too03_tooth_surface_code_4,
					@L2400_11_too03_tooth_surface_code_5,
					@L2400_12_too02_JP_tooth_code,
					@L2400_12_too03_tooth_surface_code_1,
					@L2400_12_too03_tooth_surface_code_2,
					@L2400_12_too03_tooth_surface_code_3,
					@L2400_12_too03_tooth_surface_code_4,
					@L2400_12_too03_tooth_surface_code_5,
					@L2400_13_too02_JP_tooth_code,
					@L2400_13_too03_tooth_surface_code_1,
					@L2400_13_too03_tooth_surface_code_2,
					@L2400_13_too03_tooth_surface_code_3,
					@L2400_13_too03_tooth_surface_code_4,
					@L2400_13_too03_tooth_surface_code_5,
					@L2400_14_too02_JP_tooth_code,
					@L2400_14_too03_tooth_surface_code_1,
					@L2400_14_too03_tooth_surface_code_2,
					@L2400_14_too03_tooth_surface_code_3,
					@L2400_14_too03_tooth_surface_code_4,
					@L2400_14_too03_tooth_surface_code_5,
					@L2400_15_too02_JP_tooth_code,
					@L2400_15_too03_tooth_surface_code_1,
					@L2400_15_too03_tooth_surface_code_2,
					@L2400_15_too03_tooth_surface_code_3,
					@L2400_15_too03_tooth_surface_code_4,
					@L2400_15_too03_tooth_surface_code_5,
					@L2400_16_too02_JP_tooth_code,
					@L2400_16_too03_tooth_surface_code_1,
					@L2400_16_too03_tooth_surface_code_2,
					@L2400_16_too03_tooth_surface_code_3,
					@L2400_16_too03_tooth_surface_code_4,
					@L2400_16_too03_tooth_surface_code_5,
					@L2400_17_too02_JP_tooth_code,
					@L2400_17_too03_tooth_surface_code_1,
					@L2400_17_too03_tooth_surface_code_2,
					@L2400_17_too03_tooth_surface_code_3,
					@L2400_17_too03_tooth_surface_code_4,
					@L2400_17_too03_tooth_surface_code_5,
					@L2400_18_too02_JP_tooth_code,
					@L2400_18_too03_tooth_surface_code_1,
					@L2400_18_too03_tooth_surface_code_2,
					@L2400_18_too03_tooth_surface_code_3,
					@L2400_18_too03_tooth_surface_code_4,
					@L2400_18_too03_tooth_surface_code_5,
					@L2400_19_too02_JP_tooth_code,
					@L2400_19_too03_tooth_surface_code_1,
					@L2400_19_too03_tooth_surface_code_2,
					@L2400_19_too03_tooth_surface_code_3,
					@L2400_19_too03_tooth_surface_code_4,
					@L2400_19_too03_tooth_surface_code_5,
					@L2400_20_too02_JP_tooth_code,
					@L2400_20_too03_tooth_surface_code_1,
					@L2400_20_too03_tooth_surface_code_2,
					@L2400_20_too03_tooth_surface_code_3,
					@L2400_20_too03_tooth_surface_code_4,
					@L2400_20_too03_tooth_surface_code_5,
					@L2400_21_too02_JP_tooth_code,
					@L2400_21_too03_tooth_surface_code_1,
					@L2400_21_too03_tooth_surface_code_2,
					@L2400_21_too03_tooth_surface_code_3,
					@L2400_21_too03_tooth_surface_code_4,
					@L2400_21_too03_tooth_surface_code_5,
					@L2400_22_too02_JP_tooth_code,
					@L2400_22_too03_tooth_surface_code_1,
					@L2400_22_too03_tooth_surface_code_2,
					@L2400_22_too03_tooth_surface_code_3,
					@L2400_22_too03_tooth_surface_code_4,
					@L2400_22_too03_tooth_surface_code_5,
					@L2400_23_too02_JP_tooth_code,
					@L2400_23_too03_tooth_surface_code_1,
					@L2400_23_too03_tooth_surface_code_2,
					@L2400_23_too03_tooth_surface_code_3,
					@L2400_23_too03_tooth_surface_code_4,
					@L2400_23_too03_tooth_surface_code_5,
					@L2400_24_too02_JP_tooth_code,
					@L2400_24_too03_tooth_surface_code_1,
					@L2400_24_too03_tooth_surface_code_2,
					@L2400_24_too03_tooth_surface_code_3,
					@L2400_24_too03_tooth_surface_code_4,
					@L2400_24_too03_tooth_surface_code_5,
					@L2400_25_too02_JP_tooth_code,
					@L2400_25_too03_tooth_surface_code_1,
					@L2400_25_too03_tooth_surface_code_2,
					@L2400_25_too03_tooth_surface_code_3,
					@L2400_25_too03_tooth_surface_code_4,
					@L2400_25_too03_tooth_surface_code_5,
					@L2400_26_too02_JP_tooth_code,
					@L2400_26_too03_tooth_surface_code_1,
					@L2400_26_too03_tooth_surface_code_2,
					@L2400_26_too03_tooth_surface_code_3,
					@L2400_26_too03_tooth_surface_code_4,
					@L2400_26_too03_tooth_surface_code_5,
					@L2400_27_too02_JP_tooth_code,
					@L2400_27_too03_tooth_surface_code_1,
					@L2400_27_too03_tooth_surface_code_2,
					@L2400_27_too03_tooth_surface_code_3,
					@L2400_27_too03_tooth_surface_code_4,
					@L2400_27_too03_tooth_surface_code_5,
					@L2400_28_too02_JP_tooth_code,
					@L2400_28_too03_tooth_surface_code_1,
					@L2400_28_too03_tooth_surface_code_2,
					@L2400_28_too03_tooth_surface_code_3,
					@L2400_28_too03_tooth_surface_code_4,
					@L2400_28_too03_tooth_surface_code_5,
					@L2400_29_too02_JP_tooth_code,
					@L2400_29_too03_tooth_surface_code_1,
					@L2400_29_too03_tooth_surface_code_2,
					@L2400_29_too03_tooth_surface_code_3,
					@L2400_29_too03_tooth_surface_code_4,
					@L2400_29_too03_tooth_surface_code_5,
					@L2400_30_too02_JP_tooth_code,
					@L2400_30_too03_tooth_surface_code_1,
					@L2400_30_too03_tooth_surface_code_2,
					@L2400_30_too03_tooth_surface_code_3,
					@L2400_30_too03_tooth_surface_code_4,
					@L2400_30_too03_tooth_surface_code_5,
					@L2400_31_too02_JP_tooth_code,
					@L2400_31_too03_tooth_surface_code_1,
					@L2400_31_too03_tooth_surface_code_2,
					@L2400_31_too03_tooth_surface_code_3,
					@L2400_31_too03_tooth_surface_code_4,
					@L2400_31_too03_tooth_surface_code_5,
					@L2400_32_too02_JP_tooth_code,
					@L2400_32_too03_tooth_surface_code_1,
					@L2400_32_too03_tooth_surface_code_2,
					@L2400_32_too03_tooth_surface_code_3,
					@L2400_32_too03_tooth_surface_code_4,
					@L2400_32_too03_tooth_surface_code_5,
					@L2400_dtp02_472_service_date,
					@L2400_dtp02_441_prior_placement_date,
					@L2400_dtp02_452_orthodontic_banding_date,
					@L2400_dtp02_446_replacement_date,
					@L2400_1_qty01_qty_qual,
					@L2400_1_qty02_anesthesia_unit_count,
					@L2400_2_qty01_qty_qual,
					@L2400_2_qty02_anesthesia_unit_count,
					@L2400_3_qty01_qty_qual,
					@L2400_3_qty02_anesthesia_unit_count,
					@L2400_4_qty01_qty_qual,
					@L2400_4_qty02_anesthesia_unit_count,
					@L2400_5_qty01_qty_qual,
					@L2400_5_qty02_anesthesia_unit_count,
					@L2400_ref02_G3_predetermination_of_benefits_id,
					@L2400_ref02_9F_referral_number,
					@L2400_ref02_G1_prior_auth_number,
					@L2400_ref02_6R_line_item_control_num,
					@L2400_amt02_AAE_approved_amt,
					@L2400_amt02_T_sales_tax_amt,
					@L2400_nte01_note_ref_code,
					@L2400_nte02_line_note_text,
					@L2420A_nm102_entity_type_qual,
					@L2420A_nm103_rendering_prov_last_nm,
					@L2420A_nm104_rendering_prov_first_nm,
					@L2420A_nm105_rendering_prov_middle_nm,
					@L2420A_nm107_rendering_prov_suffix,
					@L2420A_nm108_id_code_qual,
					@L2420A_nm109_rendering_prov_id,
					@L2420A_prv01_provider_code,
					@L2420A_prv02_ref_id_qual,
					@L2420A_prv03_taxonomy_code,
					@L2420A_ref02_1C_rendering_prov_id,
					@L2420A_ref02_1D_rendering_prov_id,
					@L2420A_ref02_1E_rendering_prov_id,
					@L2420A_ref02_EI_rendering_prov_id,
					@L2420A_ref02_SY_rendering_prov_id,
					@L2420A_ref02_TJ_rendering_prov_id,
					@L2420B_nm102_entity_type_qual,
					@L2420B_nm103_payer_last_nm,
					@L2420B_nm108_id_code_qual,
					@L2420B_nm109_other_payer_id,
					@L2420B_ref02_9F_referral_number,
					@L2420B_ref02_G1_prior_auth_number,
					@L2420C_nm101_entity_id_code,
					@L2420C_nm102_entity_type_qual,
					@L2420C_nm103_assistant_surgeon_last_nm,
					@L2420C_nm104_assistant_surgeon_first_nm,
					@L2420C_nm105_assistant_surgeon_middle_nm,
					@L2420C_nm107_assistant_surgeon_suffix,
					@L2420C_nm108_id_code_qual,
					@L2420C_nm109_assistant_surgeon_id,
					@L2420C_prv01_provider_code,
					@L2420C_prv02_ref_id_qual,
					@L2420C_prv03_taxonomy_code,
					@L2420C_ref02_1C_service_facility_id,
					@L2420C_ref02_1D_service_facility_id,
					@L2420C_ref02_1E_service_facility_id,
					@L2420C_ref02_G2_service_facility_id,
					@L2420C_ref02_TJ_service_facility_id,
					@L2430_svd01_other_payer_id,
					@L2430_svd02_service_line_paid,
					@L2430_svd03_service_id_qual,
					@L2430_svd03_proc_code,
					@L2430_svd03_proc_mod1,
					@L2430_svd03_proc_mod2,
					@L2430_svd03_proc_mod3,
					@L2430_svd03_proc_mod4,
					@L2430_svd03_proc_code_desc,
					@L2430_svd05_paid_service_unit,
					@L2430_svd06_bundled_unbundled_line_num,
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
					@L2430_dtp03_573_date_claim_paid
				)

			-- reset the claim level values
			select	@L2300_clm01_pt_acct_num = null,
					@L2300_clm02_total_claim_chg_amt = null,
					@L2300_clm05_facility_type_code = null,
					@L2300_clm05_claim_freq_code = null,
					@L2300_clm06_provider_signature_ind = null,
					@L2300_clm07_medicare_assign_code = null,
					@L2300_clm08_benefit_assign_ind = null,
					@L2300_clm09_release_of_info_code = null,
					@L2300_clm11_related_causes_code1 = null,
					@L2300_clm11_related_causes_code2 = null,
					@L2300_clm11_related_causes_code3 = null,
					@L2300_clm11_auto_accident_state_code = null,
					@L2300_clm11_country_code = null,
					@L2300_clm12_special_prog_ind = null,
					@L2300_clm19_claim_submission_reason_code = null,
					@L2300_clm20_delay_reason_code = null,
					@L2300_dtp03_435_related_hospitalization_admission_date = null,
					@L2300_dtp03_096_discharge_end_of_care_date = null,
					@L2300_dtp03_330_referral_date = null,
					@L2300_dtp03_439_accident_date = null,
					@L2300_dtp03_452_orthodontic_banding_date = null,
					@L2300_dtp03_472_service_date = null,
					@L2300_dn101_orthodontic_treatment_months_count = null,
					@L2300_dn102_orthodontic_treatment_months_remaining_count = null,
					@L2300_dn103_question_response = null,
					@L2300_1_dn201_tooth_number = null,
					@L2300_1_dn202_tooth_status_code = null,
					@L2300_2_dn201_tooth_number = null,
					@L2300_2_dn202_tooth_status_code = null,
					@L2300_3_dn201_tooth_number = null,
					@L2300_3_dn202_tooth_status_code = null,
					@L2300_4_dn201_tooth_number = null,
					@L2300_4_dn202_tooth_status_code = null,
					@L2300_5_dn201_tooth_number = null,
					@L2300_5_dn202_tooth_status_code = null,
					@L2300_6_dn201_tooth_number = null,
					@L2300_6_dn202_tooth_status_code = null,
					@L2300_7_dn201_tooth_number = null,
					@L2300_7_dn202_tooth_status_code = null,
					@L2300_8_dn201_tooth_number = null,
					@L2300_8_dn202_tooth_status_code = null,
					@L2300_9_dn201_tooth_number = null,
					@L2300_9_dn202_tooth_status_code = null,
					@L2300_10_dn201_tooth_number = null,
					@L2300_10_dn202_tooth_status_code = null,
					@L2300_11_dn201_tooth_number = null,
					@L2300_11_dn202_tooth_status_code = null,
					@L2300_12_dn201_tooth_number = null,
					@L2300_12_dn202_tooth_status_code = null,
					@L2300_13_dn201_tooth_number = null,
					@L2300_13_dn202_tooth_status_code = null,
					@L2300_14_dn201_tooth_number = null,
					@L2300_14_dn202_tooth_status_code = null,
					@L2300_15_dn201_tooth_number = null,
					@L2300_15_dn202_tooth_status_code = null,
					@L2300_16_dn201_tooth_number = null,
					@L2300_16_dn202_tooth_status_code = null,
					@L2300_17_dn201_tooth_number = null,
					@L2300_17_dn202_tooth_status_code = null,
					@L2300_18_dn201_tooth_number = null,
					@L2300_18_dn202_tooth_status_code = null,
					@L2300_19_dn201_tooth_number = null,
					@L2300_19_dn202_tooth_status_code = null,
					@L2300_20_dn201_tooth_number = null,
					@L2300_20_dn202_tooth_status_code = null,
					@L2300_21_dn201_tooth_number = null,
					@L2300_21_dn202_tooth_status_code = null,
					@L2300_22_dn201_tooth_number = null,
					@L2300_22_dn202_tooth_status_code = null,
					@L2300_23_dn201_tooth_number = null,
					@L2300_23_dn202_tooth_status_code = null,
					@L2300_24_dn201_tooth_number = null,
					@L2300_24_dn202_tooth_status_code = null,
					@L2300_25_dn201_tooth_number = null,
					@L2300_25_dn202_tooth_status_code = null,
					@L2300_26_dn201_tooth_number = null,
					@L2300_26_dn202_tooth_status_code = null,
					@L2300_27_dn201_tooth_number = null,
					@L2300_27_dn202_tooth_status_code = null,
					@L2300_28_dn201_tooth_number = null,
					@L2300_28_dn202_tooth_status_code = null,
					@L2300_29_dn201_tooth_number = null,
					@L2300_29_dn202_tooth_status_code = null,
					@L2300_30_dn201_tooth_number = null,
					@L2300_30_dn202_tooth_status_code = null,
					@L2300_31_dn201_tooth_number = null,
					@L2300_31_dn202_tooth_status_code = null,
					@L2300_32_dn201_tooth_number = null,
					@L2300_32_dn202_tooth_status_code = null,
					@L2300_33_dn201_tooth_number = null,
					@L2300_33_dn202_tooth_status_code = null,
					@L2300_34_dn201_tooth_number = null,
					@L2300_34_dn202_tooth_status_code = null,
					@L2300_35_dn201_tooth_number = null,
					@L2300_35_dn202_tooth_status_code = null,
					@L2300_pwk01_attachment_type_code = null,
					@L2300_pwk02_attachment_trans_code = null,
					@L2300_pwk06_attachment_control_num = null,
					@L2300_amt02_patient_paid_amt = null,
					@L2300_amt02_card_maximum_amt = null,
					@L2300_ref02_G3_predetermination_id = null,
					@L2300_ref02_4N_service_auth_exception_code = null,
					@L2300_ref02_F8_original_ref_num = null,
					@L2300_ref02_9F_referral_num = null,
					@L2300_ref02_G1_prior_auth_num = null,
					@L2300_ref02_D9_value_added_network_trace_num = null,
					@L2300_nte01_note_ref_code = null,
					@L2300_nte02_claim_note_text = null,
					
					@L2310A_nm101_entity_id_code = null,
					@L2310A_nm102_entity_type_qual = null,
					@L2310A_nm103_referring_prov_last_nm = null,
					@L2310A_nm104_referring_prov_first_nm = null,
					@L2310A_nm105_referring_prov_middle_nm = null,
					@L2310A_nm107_referring_prov_suffix = null,
					@L2310A_nm108_id_code_qual = null,
					@L2310A_nm109_referring_prov_id = null,
					@L2310A_prv01_provider_code = null,
					@L2310A_prv02_ref_id_qual = null,
					@L2310A_prv03_taxonomy_code = null,
					@L2310A_ref02_1C_referring_prov_id = null,
					@L2310A_ref02_1D_referring_prov_id = null,
					@L2310A_ref02_1E_referring_prov_id = null,
					@L2310A_ref02_EI_referring_prov_id = null,
					@L2310A_ref02_G2_referring_prov_id = null,
					@L2310A_ref02_SY_referring_prov_id = null,
					@L2310A_ref02_TJ_referring_prov_id = null,
					
					@L2310B_nm102_entity_type_qual = null,
					@L2310B_nm103_rendering_prov_last_nm = null,
					@L2310B_nm104_rendering_prov_first_nm = null,
					@L2310B_nm105_rendering_prov_middle_nm = null,
					@L2310B_nm107_rendering_prov_suffix = null,
					@L2310B_nm108_id_code_qual = null,
					@L2310B_nm109_rendering_prov_id = null,
					@L2310B_prv01_provider_code = null,
					@L2310B_prv02_ref_id_qual = null,
					@L2310B_prv03_taxonomy_code = null,
					@L2310B_ref02_1C_rendering_prov_id = null,
					@L2310B_ref02_1D_rendering_prov_id = null,
					@L2310B_ref02_1E_rendering_prov_id = null,
					@L2310B_ref02_EI_rendering_prov_id = null,
					@L2310B_ref02_G2_rendering_prov_id = null,
					@L2310B_ref02_SY_rendering_prov_id = null,
					@L2310B_ref02_TJ_rendering_prov_id = null,
					
					@L2310C_nm102_entity_type_qual = null,
					@L2310C_nm103_service_facility_last_nm = null,
					@L2310C_nm108_id_code_qual = null,
					@L2310C_nm109_service_facility_id = null,
					@L2310C_ref02_1C_lab_or_facility_prov_id = null,
					@L2310C_ref02_1D_lab_or_facility_prov_id = null,
					@L2310C_ref02_1G_lab_or_facility_prov_id = null,
					@L2310C_ref02_G2_lab_or_facility_prov_id = null,
					@L2310C_ref02_TJ_lab_or_facility_prov_id = null,
					
					@L2310D_nm102_entity_type_qual = null,
					@L2310D_nm103_assistant_surgeon_last_nm = null,
					@L2310D_nm104_assistant_surgeon_first_nm = null,
					@L2310D_nm105_assistant_surgeon_middle_nm = null,
					@L2310D_nm107_assistant_surgeon_suffix = null,
					@L2310D_nm108_id_code_qual = null,
					@L2310D_nm109_assistant_surgeon_prov_id = null,
					@L2310D_prv01_provider_code = null,
					@L2310D_prv02_id_code_qual = null,
					@L2310D_prv03_taxonomy_code = null,
					@L2310D_ref02_1C_service_facility_id = null,
					@L2310D_ref02_1D_service_facility_id = null,
					@L2310D_ref02_1E_service_facility_id = null,
					@L2310D_ref02_G2_service_facility_id = null,
					@L2310D_ref02_TJ_service_facility_id = null,
					
					@Other2320SBRLoopCount = 0,
					@Other2320CASLoopCount = 0,
					@Other2300DNLoopCount = 0,

					@L2320_1_sbr01_payer_resp_seq_code = null,
					@L2320_1_sbr02_ind_relationship_code = null,
					@L2320_1_sbr03_insured_grp_policy_num = null,
					@L2320_1_sbr04_insured_grp_nm = null,
					@L2320_1_sbr09_claim_file_ind_code = null,
					@L2320_1_1_cas01_adjustment_group_code = null,
					@L2320_1_1_cas02_adjustment_reason_code = null,
					@L2320_1_1_cas03_adjustment_amt = null,
					@L2320_1_1_cas04_adjustment_qty = null,
					@L2320_1_1_cas05_adjustment_reason_code = null,
					@L2320_1_1_cas06_adjustment_amt = null,
					@L2320_1_1_cas07_adjustment_qty = null,
					@L2320_1_1_cas08_adjustment_reason_code = null,
					@L2320_1_1_cas09_adjustment_amt = null,
					@L2320_1_1_cas10_adjustment_qty = null,
					@L2320_1_2_cas01_adjustment_group_code = null,
					@L2320_1_2_cas02_adjustment_reason_code = null,
					@L2320_1_2_cas03_adjustment_amt = null,
					@L2320_1_2_cas04_adjustment_qty = null,
					@L2320_1_2_cas05_adjustment_reason_code = null,
					@L2320_1_2_cas06_adjustment_amt = null,
					@L2320_1_2_cas07_adjustment_qty = null,
					@L2320_1_2_cas08_adjustment_reason_code = null,
					@L2320_1_2_cas09_adjustment_amt = null,
					@L2320_1_2_cas10_adjustment_qty = null,
					@L2320_1_3_cas01_adjustment_group_code = null,
					@L2320_1_3_cas02_adjustment_reason_code = null,
					@L2320_1_3_cas03_adjustment_amt = null,
					@L2320_1_3_cas04_adjustment_qty = null,
					@L2320_1_3_cas05_adjustment_reason_code = null,
					@L2320_1_3_cas06_adjustment_amt = null,
					@L2320_1_3_cas07_adjustment_qty = null,
					@L2320_1_3_cas08_adjustment_reason_code = null,
					@L2320_1_3_cas09_adjustment_amt = null,
					@L2320_1_3_cas10_adjustment_qty = null,
					@L2320_1_4_cas01_adjustment_group_code = null,
					@L2320_1_4_cas02_adjustment_reason_code = null,
					@L2320_1_4_cas03_adjustment_amt = null,
					@L2320_1_4_cas04_adjustment_qty = null,
					@L2320_1_4_cas05_adjustment_reason_code = null,
					@L2320_1_4_cas06_adjustment_amt = null,
					@L2320_1_4_cas07_adjustment_qty = null,
					@L2320_1_4_cas08_adjustment_reason_code = null,
					@L2320_1_4_cas09_adjustment_amt = null,
					@L2320_1_4_cas10_adjustment_qty = null,
					@L2320_1_5_cas01_adjustment_group_code = null,
					@L2320_1_5_cas02_adjustment_reason_code = null,
					@L2320_1_5_cas03_adjustment_amt = null,
					@L2320_1_5_cas04_adjustment_qty = null,
					@L2320_1_5_cas05_adjustment_reason_code = null,
					@L2320_1_5_cas06_adjustment_amt = null,
					@L2320_1_5_cas07_adjustment_qty = null,
					@L2320_1_5_cas08_adjustment_reason_code = null,
					@L2320_1_5_cas09_adjustment_amt = null,
					@L2320_1_5_cas10_adjustment_qty = null,
					@L2320_1_amt02_D_payer_paid_amt = null,
					@L2320_1_amt02_AAE_cob_approved_amt = null,
					@L2320_1_amt02_B6_cob_allowed_amt = null,
					@L2320_1_amt02_F2_patient_responsibility_amt = null,
					@L2320_1_amt02_AU_cob_covered_amt = null,
					@L2320_1_amt02_D8_discount_amt = null,
					@L2320_1_amt02_F5_payer_patient_paid_amt = null,
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
					@L2330A_1_n301_other_subscriber_address1 = null,
					@L2330A_1_n302_other_subscriber_address2 = null,
					@L2330A_1_n401_other_subscriber_city = null,
					@L2330A_1_n402_other_subscriber_state = null,
					@L2330A_1_n403_other_subscriber_zip = null,
					@L2330A_1_n404_other_subscriber_country = null,
					@L2330A_1_ref02_1W_other_subscriber_sup_id = null,
					@L2330A_1_ref02_23_other_subscriber_sup_id = null,
					@L2330A_1_ref02_IG_other_subscriber_sup_id = null,
					@L2330A_1_ref02_SY_other_subscriber_sup_id = null,
					
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
					@L2330B_1_ref02_T4_other_payer_claim_adj_ind = null,
					
					@L2320_2_sbr01_payer_resp_seq_code = null,
					@L2320_2_sbr02_ind_relationship_code = null,
					@L2320_2_sbr03_insured_grp_policy_num = null,
					@L2320_2_sbr04_insured_grp_nm = null,
					@L2320_2_sbr09_claim_file_ind_code = null,
					@L2320_2_1_cas01_adjustment_group_code = null,
					@L2320_2_1_cas02_adjustment_reason_code = null,
					@L2320_2_1_cas03_adjustment_amt = null,
					@L2320_2_1_cas04_adjustment_qty = null,
					@L2320_2_1_cas05_adjustment_reason_code = null,
					@L2320_2_1_cas06_adjustment_amt = null,
					@L2320_2_1_cas07_adjustment_qty = null,
					@L2320_2_1_cas08_adjustment_reason_code = null,
					@L2320_2_1_cas09_adjustment_amt = null,
					@L2320_2_1_cas10_adjustment_qty = null,
					@L2320_2_2_cas01_adjustment_group_code = null,
					@L2320_2_2_cas02_adjustment_reason_code = null,
					@L2320_2_2_cas03_adjustment_amt = null,
					@L2320_2_2_cas04_adjustment_qty = null,
					@L2320_2_2_cas05_adjustment_reason_code = null,
					@L2320_2_2_cas06_adjustment_amt = null,
					@L2320_2_2_cas07_adjustment_qty = null,
					@L2320_2_2_cas08_adjustment_reason_code = null,
					@L2320_2_2_cas09_adjustment_amt = null,
					@L2320_2_2_cas10_adjustment_qty = null,
					@L2320_2_3_cas01_adjustment_group_code = null,
					@L2320_2_3_cas02_adjustment_reason_code = null,
					@L2320_2_3_cas03_adjustment_amt = null,
					@L2320_2_3_cas04_adjustment_qty = null,
					@L2320_2_3_cas05_adjustment_reason_code = null,
					@L2320_2_3_cas06_adjustment_amt = null,
					@L2320_2_3_cas07_adjustment_qty = null,
					@L2320_2_3_cas08_adjustment_reason_code = null,
					@L2320_2_3_cas09_adjustment_amt = null,
					@L2320_2_3_cas10_adjustment_qty = null,
					@L2320_2_4_cas01_adjustment_group_code = null,
					@L2320_2_4_cas02_adjustment_reason_code = null,
					@L2320_2_4_cas03_adjustment_amt = null,
					@L2320_2_4_cas04_adjustment_qty = null,
					@L2320_2_4_cas05_adjustment_reason_code = null,
					@L2320_2_4_cas06_adjustment_amt = null,
					@L2320_2_4_cas07_adjustment_qty = null,
					@L2320_2_4_cas08_adjustment_reason_code = null,
					@L2320_2_4_cas09_adjustment_amt = null,
					@L2320_2_4_cas10_adjustment_qty = null,
					@L2320_2_5_cas01_adjustment_group_code = null,
					@L2320_2_5_cas02_adjustment_reason_code = null,
					@L2320_2_5_cas03_adjustment_amt = null,
					@L2320_2_5_cas04_adjustment_qty = null,
					@L2320_2_5_cas05_adjustment_reason_code = null,
					@L2320_2_5_cas06_adjustment_amt = null,
					@L2320_2_5_cas07_adjustment_qty = null,
					@L2320_2_5_cas08_adjustment_reason_code = null,
					@L2320_2_5_cas09_adjustment_amt = null,
					@L2320_2_5_cas10_adjustment_qty = null,
					@L2320_2_amt02_D_payer_paid_amt = null,
					@L2320_2_amt02_AAE_cob_approved_amt = null,
					@L2320_2_amt02_B6_cob_allowed_amt = null,
					@L2320_2_amt02_F2_patient_responsibility_amt = null,
					@L2320_2_amt02_AU_cob_covered_amt = null,
					@L2320_2_amt02_D8_discount_amt = null,
					@L2320_2_amt02_F5_payer_patient_paid_amt = null,
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
					@L2330A_2_n301_other_subscriber_address1 = null,
					@L2330A_2_n302_other_subscriber_address2 = null,
					@L2330A_2_n401_other_subscriber_city = null,
					@L2330A_2_n402_other_subscriber_state = null,
					@L2330A_2_n403_other_subscriber_zip = null,
					@L2330A_2_n404_other_subscriber_country = null,
					@L2330A_2_ref02_1W_other_subscriber_sup_id = null,
					@L2330A_2_ref02_23_other_subscriber_sup_id = null,
					@L2330A_2_ref02_IG_other_subscriber_sup_id = null,
					@L2330A_2_ref02_SY_other_subscriber_sup_id = null,
					
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
					@L2330B_2_ref02_T4_other_payer_claim_adj_ind = null,
					
					@L2320_3_sbr01_payer_resp_seq_code = null,
					@L2320_3_sbr02_ind_relationship_code = null,
					@L2320_3_sbr03_insured_grp_policy_num = null,
					@L2320_3_sbr04_insured_grp_nm = null,
					@L2320_3_sbr09_claim_file_ind_code = null,
					@L2320_3_1_cas01_adjustment_group_code = null,
					@L2320_3_1_cas02_adjustment_reason_code = null,
					@L2320_3_1_cas03_adjustment_amt = null,
					@L2320_3_1_cas04_adjustment_qty = null,
					@L2320_3_1_cas05_adjustment_reason_code = null,
					@L2320_3_1_cas06_adjustment_amt = null,
					@L2320_3_1_cas07_adjustment_qty = null,
					@L2320_3_1_cas08_adjustment_reason_code = null,
					@L2320_3_1_cas09_adjustment_amt = null,
					@L2320_3_1_cas10_adjustment_qty = null,
					@L2320_3_2_cas01_adjustment_group_code = null,
					@L2320_3_2_cas02_adjustment_reason_code = null,
					@L2320_3_2_cas03_adjustment_amt = null,
					@L2320_3_2_cas04_adjustment_qty = null,
					@L2320_3_2_cas05_adjustment_reason_code = null,
					@L2320_3_2_cas06_adjustment_amt = null,
					@L2320_3_2_cas07_adjustment_qty = null,
					@L2320_3_2_cas08_adjustment_reason_code = null,
					@L2320_3_2_cas09_adjustment_amt = null,
					@L2320_3_2_cas10_adjustment_qty = null,
					@L2320_3_3_cas01_adjustment_group_code = null,
					@L2320_3_3_cas02_adjustment_reason_code = null,
					@L2320_3_3_cas03_adjustment_amt = null,
					@L2320_3_3_cas04_adjustment_qty = null,
					@L2320_3_3_cas05_adjustment_reason_code = null,
					@L2320_3_3_cas06_adjustment_amt = null,
					@L2320_3_3_cas07_adjustment_qty = null,
					@L2320_3_3_cas08_adjustment_reason_code = null,
					@L2320_3_3_cas09_adjustment_amt = null,
					@L2320_3_3_cas10_adjustment_qty = null,
					@L2320_3_4_cas01_adjustment_group_code = null,
					@L2320_3_4_cas02_adjustment_reason_code = null,
					@L2320_3_4_cas03_adjustment_amt = null,
					@L2320_3_4_cas04_adjustment_qty = null,
					@L2320_3_4_cas05_adjustment_reason_code = null,
					@L2320_3_4_cas06_adjustment_amt = null,
					@L2320_3_4_cas07_adjustment_qty = null,
					@L2320_3_4_cas08_adjustment_reason_code = null,
					@L2320_3_4_cas09_adjustment_amt = null,
					@L2320_3_4_cas10_adjustment_qty = null,
					@L2320_3_5_cas01_adjustment_group_code = null,
					@L2320_3_5_cas02_adjustment_reason_code = null,
					@L2320_3_5_cas03_adjustment_amt = null,
					@L2320_3_5_cas04_adjustment_qty = null,
					@L2320_3_5_cas05_adjustment_reason_code = null,
					@L2320_3_5_cas06_adjustment_amt = null,
					@L2320_3_5_cas07_adjustment_qty = null,
					@L2320_3_5_cas08_adjustment_reason_code = null,
					@L2320_3_5_cas09_adjustment_amt = null,
					@L2320_3_5_cas10_adjustment_qty = null,
					@L2320_3_amt02_D_payer_paid_amt = null,
					@L2320_3_amt02_AAE_cob_approved_amt = null,
					@L2320_3_amt02_B6_cob_allowed_amt = null,
					@L2320_3_amt02_F2_patient_responsibility_amt = null,
					@L2320_3_amt02_AU_cob_covered_amt = null,
					@L2320_3_amt02_D8_discount_amt = null,
					@L2320_3_amt02_F5_payer_patient_paid_amt = null,
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
					@L2330A_3_n301_other_subscriber_address1 = null,
					@L2330A_3_n302_other_subscriber_address2 = null,
					@L2330A_3_n401_other_subscriber_city = null,
					@L2330A_3_n402_other_subscriber_state = null,
					@L2330A_3_n403_other_subscriber_zip = null,
					@L2330A_3_n404_other_subscriber_country = null,
					@L2330A_3_ref02_1W_other_subscriber_sup_id = null,
					@L2330A_3_ref02_23_other_subscriber_sup_id = null,
					@L2330A_3_ref02_IG_other_subscriber_sup_id = null,
					@L2330A_3_ref02_SY_other_subscriber_sup_id = null,

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
					@L2330B_3_ref02_T4_other_payer_claim_adj_ind = null,
					
					@Other2400QTYLoopCount = 0,
					@Other2400TOOLoopCount = 0,

					@L2400_lx01_assigned_num = null,
					@L2400_sv301_proc_code_qual = null,
					@L2400_sv301_proc_code = null,
					@L2400_sv301_proc_mod1 = null,
					@L2400_sv301_proc_mod2 = null,
					@L2400_sv301_proc_mod3 = null,
					@L2400_sv301_proc_mod4 = null,
					@L2400_sv302_line_charge = null,
					@L2400_sv303_facility_type_code = null,
					@L2400_sv304_oral_cavity_designation_code_1 = null,
					@L2400_sv304_oral_cavity_designation_code_2 = null,
					@L2400_sv304_oral_cavity_designation_code_3 = null,
					@L2400_sv304_oral_cavity_designation_code_4 = null,
					@L2400_sv304_oral_cavity_designation_code_5 = null,
					@L2400_sv305_prosthesis_crown_inlay_code = null,
					@L2400_sv306_procedure_count = null,
					@L2400_1_too02_JP_tooth_code = null,
					@L2400_1_too03_tooth_surface_code_1 = null,
					@L2400_1_too03_tooth_surface_code_2 = null,
					@L2400_1_too03_tooth_surface_code_3 = null,
					@L2400_1_too03_tooth_surface_code_4 = null,
					@L2400_1_too03_tooth_surface_code_5 = null,
					@L2400_2_too02_JP_tooth_code = null,
					@L2400_2_too03_tooth_surface_code_1 = null,
					@L2400_2_too03_tooth_surface_code_2 = null,
					@L2400_2_too03_tooth_surface_code_3 = null,
					@L2400_2_too03_tooth_surface_code_4 = null,
					@L2400_2_too03_tooth_surface_code_5 = null,
					@L2400_3_too02_JP_tooth_code = null,
					@L2400_3_too03_tooth_surface_code_1 = null,
					@L2400_3_too03_tooth_surface_code_2 = null,
					@L2400_3_too03_tooth_surface_code_3 = null,
					@L2400_3_too03_tooth_surface_code_4 = null,
					@L2400_3_too03_tooth_surface_code_5 = null,
					@L2400_4_too02_JP_tooth_code = null,
					@L2400_4_too03_tooth_surface_code_1 = null,
					@L2400_4_too03_tooth_surface_code_2 = null,
					@L2400_4_too03_tooth_surface_code_3 = null,
					@L2400_4_too03_tooth_surface_code_4 = null,
					@L2400_4_too03_tooth_surface_code_5 = null,
					@L2400_5_too02_JP_tooth_code = null,
					@L2400_5_too03_tooth_surface_code_1 = null,
					@L2400_5_too03_tooth_surface_code_2 = null,
					@L2400_5_too03_tooth_surface_code_3 = null,
					@L2400_5_too03_tooth_surface_code_4 = null,
					@L2400_5_too03_tooth_surface_code_5 = null,
					@L2400_6_too02_JP_tooth_code = null,
					@L2400_6_too03_tooth_surface_code_1 = null,
					@L2400_6_too03_tooth_surface_code_2 = null,
					@L2400_6_too03_tooth_surface_code_3 = null,
					@L2400_6_too03_tooth_surface_code_4 = null,
					@L2400_6_too03_tooth_surface_code_5 = null,
					@L2400_7_too02_JP_tooth_code = null,
					@L2400_7_too03_tooth_surface_code_1 = null,
					@L2400_7_too03_tooth_surface_code_2 = null,
					@L2400_7_too03_tooth_surface_code_3 = null,
					@L2400_7_too03_tooth_surface_code_4 = null,
					@L2400_7_too03_tooth_surface_code_5 = null,
					@L2400_8_too02_JP_tooth_code = null,
					@L2400_8_too03_tooth_surface_code_1 = null,
					@L2400_8_too03_tooth_surface_code_2 = null,
					@L2400_8_too03_tooth_surface_code_3 = null,
					@L2400_8_too03_tooth_surface_code_4 = null,
					@L2400_8_too03_tooth_surface_code_5 = null,
					@L2400_9_too02_JP_tooth_code = null,
					@L2400_9_too03_tooth_surface_code_1 = null,
					@L2400_9_too03_tooth_surface_code_2 = null,
					@L2400_9_too03_tooth_surface_code_3 = null,
					@L2400_9_too03_tooth_surface_code_4 = null,
					@L2400_9_too03_tooth_surface_code_5 = null,
					@L2400_10_too02_JP_tooth_code = null,
					@L2400_10_too03_tooth_surface_code_1 = null,
					@L2400_10_too03_tooth_surface_code_2 = null,
					@L2400_10_too03_tooth_surface_code_3 = null,
					@L2400_10_too03_tooth_surface_code_4 = null,
					@L2400_10_too03_tooth_surface_code_5 = null,
					@L2400_11_too02_JP_tooth_code = null,
					@L2400_11_too03_tooth_surface_code_1 = null,
					@L2400_11_too03_tooth_surface_code_2 = null,
					@L2400_11_too03_tooth_surface_code_3 = null,
					@L2400_11_too03_tooth_surface_code_4 = null,
					@L2400_11_too03_tooth_surface_code_5 = null,
					@L2400_12_too02_JP_tooth_code = null,
					@L2400_12_too03_tooth_surface_code_1 = null,
					@L2400_12_too03_tooth_surface_code_2 = null,
					@L2400_12_too03_tooth_surface_code_3 = null,
					@L2400_12_too03_tooth_surface_code_4 = null,
					@L2400_12_too03_tooth_surface_code_5 = null,
					@L2400_13_too02_JP_tooth_code = null,
					@L2400_13_too03_tooth_surface_code_1 = null,
					@L2400_13_too03_tooth_surface_code_2 = null,
					@L2400_13_too03_tooth_surface_code_3 = null,
					@L2400_13_too03_tooth_surface_code_4 = null,
					@L2400_13_too03_tooth_surface_code_5 = null,
					@L2400_14_too02_JP_tooth_code = null,
					@L2400_14_too03_tooth_surface_code_1 = null,
					@L2400_14_too03_tooth_surface_code_2 = null,
					@L2400_14_too03_tooth_surface_code_3 = null,
					@L2400_14_too03_tooth_surface_code_4 = null,
					@L2400_14_too03_tooth_surface_code_5 = null,
					@L2400_15_too02_JP_tooth_code = null,
					@L2400_15_too03_tooth_surface_code_1 = null,
					@L2400_15_too03_tooth_surface_code_2 = null,
					@L2400_15_too03_tooth_surface_code_3 = null,
					@L2400_15_too03_tooth_surface_code_4 = null,
					@L2400_15_too03_tooth_surface_code_5 = null,
					@L2400_16_too02_JP_tooth_code = null,
					@L2400_16_too03_tooth_surface_code_1 = null,
					@L2400_16_too03_tooth_surface_code_2 = null,
					@L2400_16_too03_tooth_surface_code_3 = null,
					@L2400_16_too03_tooth_surface_code_4 = null,
					@L2400_16_too03_tooth_surface_code_5 = null,
					@L2400_17_too02_JP_tooth_code = null,
					@L2400_17_too03_tooth_surface_code_1 = null,
					@L2400_17_too03_tooth_surface_code_2 = null,
					@L2400_17_too03_tooth_surface_code_3 = null,
					@L2400_17_too03_tooth_surface_code_4 = null,
					@L2400_17_too03_tooth_surface_code_5 = null,
					@L2400_18_too02_JP_tooth_code = null,
					@L2400_18_too03_tooth_surface_code_1 = null,
					@L2400_18_too03_tooth_surface_code_2 = null,
					@L2400_18_too03_tooth_surface_code_3 = null,
					@L2400_18_too03_tooth_surface_code_4 = null,
					@L2400_18_too03_tooth_surface_code_5 = null,
					@L2400_19_too02_JP_tooth_code = null,
					@L2400_19_too03_tooth_surface_code_1 = null,
					@L2400_19_too03_tooth_surface_code_2 = null,
					@L2400_19_too03_tooth_surface_code_3 = null,
					@L2400_19_too03_tooth_surface_code_4 = null,
					@L2400_19_too03_tooth_surface_code_5 = null,
					@L2400_20_too02_JP_tooth_code = null,
					@L2400_20_too03_tooth_surface_code_1 = null,
					@L2400_20_too03_tooth_surface_code_2 = null,
					@L2400_20_too03_tooth_surface_code_3 = null,
					@L2400_20_too03_tooth_surface_code_4 = null,
					@L2400_20_too03_tooth_surface_code_5 = null,
					@L2400_21_too02_JP_tooth_code = null,
					@L2400_21_too03_tooth_surface_code_1 = null,
					@L2400_21_too03_tooth_surface_code_2 = null,
					@L2400_21_too03_tooth_surface_code_3 = null,
					@L2400_21_too03_tooth_surface_code_4 = null,
					@L2400_21_too03_tooth_surface_code_5 = null,
					@L2400_22_too02_JP_tooth_code = null,
					@L2400_22_too03_tooth_surface_code_1 = null,
					@L2400_22_too03_tooth_surface_code_2 = null,
					@L2400_22_too03_tooth_surface_code_3 = null,
					@L2400_22_too03_tooth_surface_code_4 = null,
					@L2400_22_too03_tooth_surface_code_5 = null,
					@L2400_23_too02_JP_tooth_code = null,
					@L2400_23_too03_tooth_surface_code_1 = null,
					@L2400_23_too03_tooth_surface_code_2 = null,
					@L2400_23_too03_tooth_surface_code_3 = null,
					@L2400_23_too03_tooth_surface_code_4 = null,
					@L2400_23_too03_tooth_surface_code_5 = null,
					@L2400_24_too02_JP_tooth_code = null,
					@L2400_24_too03_tooth_surface_code_1 = null,
					@L2400_24_too03_tooth_surface_code_2 = null,
					@L2400_24_too03_tooth_surface_code_3 = null,
					@L2400_24_too03_tooth_surface_code_4 = null,
					@L2400_24_too03_tooth_surface_code_5 = null,
					@L2400_25_too02_JP_tooth_code = null,
					@L2400_25_too03_tooth_surface_code_1 = null,
					@L2400_25_too03_tooth_surface_code_2 = null,
					@L2400_25_too03_tooth_surface_code_3 = null,
					@L2400_25_too03_tooth_surface_code_4 = null,
					@L2400_25_too03_tooth_surface_code_5 = null,
					@L2400_26_too02_JP_tooth_code = null,
					@L2400_26_too03_tooth_surface_code_1 = null,
					@L2400_26_too03_tooth_surface_code_2 = null,
					@L2400_26_too03_tooth_surface_code_3 = null,
					@L2400_26_too03_tooth_surface_code_4 = null,
					@L2400_26_too03_tooth_surface_code_5 = null,
					@L2400_27_too02_JP_tooth_code = null,
					@L2400_27_too03_tooth_surface_code_1 = null,
					@L2400_27_too03_tooth_surface_code_2 = null,
					@L2400_27_too03_tooth_surface_code_3 = null,
					@L2400_27_too03_tooth_surface_code_4 = null,
					@L2400_27_too03_tooth_surface_code_5 = null,
					@L2400_28_too02_JP_tooth_code = null,
					@L2400_28_too03_tooth_surface_code_1 = null,
					@L2400_28_too03_tooth_surface_code_2 = null,
					@L2400_28_too03_tooth_surface_code_3 = null,
					@L2400_28_too03_tooth_surface_code_4 = null,
					@L2400_28_too03_tooth_surface_code_5 = null,
					@L2400_29_too02_JP_tooth_code = null,
					@L2400_29_too03_tooth_surface_code_1 = null,
					@L2400_29_too03_tooth_surface_code_2 = null,
					@L2400_29_too03_tooth_surface_code_3 = null,
					@L2400_29_too03_tooth_surface_code_4 = null,
					@L2400_29_too03_tooth_surface_code_5 = null,
					@L2400_30_too02_JP_tooth_code = null,
					@L2400_30_too03_tooth_surface_code_1 = null,
					@L2400_30_too03_tooth_surface_code_2 = null,
					@L2400_30_too03_tooth_surface_code_3 = null,
					@L2400_30_too03_tooth_surface_code_4 = null,
					@L2400_30_too03_tooth_surface_code_5 = null,
					@L2400_31_too02_JP_tooth_code = null,
					@L2400_31_too03_tooth_surface_code_1 = null,
					@L2400_31_too03_tooth_surface_code_2 = null,
					@L2400_31_too03_tooth_surface_code_3 = null,
					@L2400_31_too03_tooth_surface_code_4 = null,
					@L2400_31_too03_tooth_surface_code_5 = null,
					@L2400_32_too02_JP_tooth_code = null,
					@L2400_32_too03_tooth_surface_code_1 = null,
					@L2400_32_too03_tooth_surface_code_2 = null,
					@L2400_32_too03_tooth_surface_code_3 = null,
					@L2400_32_too03_tooth_surface_code_4 = null,
					@L2400_32_too03_tooth_surface_code_5 = null,
					@L2400_dtp02_472_service_date = null,
					@L2400_dtp02_441_prior_placement_date = null,
					@L2400_dtp02_452_orthodontic_banding_date = null,
					@L2400_dtp02_446_replacement_date = null,
					@L2400_1_qty01_qty_qual = null,
					@L2400_1_qty02_anesthesia_unit_count = null,
					@L2400_2_qty01_qty_qual = null,
					@L2400_2_qty02_anesthesia_unit_count = null,
					@L2400_3_qty01_qty_qual = null,
					@L2400_3_qty02_anesthesia_unit_count = null,
					@L2400_4_qty01_qty_qual = null,
					@L2400_4_qty02_anesthesia_unit_count = null,
					@L2400_5_qty01_qty_qual = null,
					@L2400_5_qty02_anesthesia_unit_count = null,
					@L2400_ref02_G3_predetermination_of_benefits_id = null,
					@L2400_ref02_9F_referral_number = null,
					@L2400_ref02_G1_prior_auth_number = null,
					@L2400_ref02_6R_line_item_control_num = null,
					@L2400_amt02_AAE_approved_amt = null,
					@L2400_amt02_T_sales_tax_amt = null,
					@L2400_nte01_note_ref_code = null,
					@L2400_nte02_line_note_text = null,
					
					@L2420A_nm102_entity_type_qual = null,
					@L2420A_nm103_rendering_prov_last_nm = null,
					@L2420A_nm104_rendering_prov_first_nm = null,
					@L2420A_nm105_rendering_prov_middle_nm = null,
					@L2420A_nm107_rendering_prov_suffix = null,
					@L2420A_nm108_id_code_qual = null,
					@L2420A_nm109_rendering_prov_id = null,
					@L2420A_prv01_provider_code = null,
					@L2420A_prv02_ref_id_qual = null,
					@L2420A_prv03_taxonomy_code = null,
					@L2420A_ref02_1C_rendering_prov_id = null,
					@L2420A_ref02_1D_rendering_prov_id = null,
					@L2420A_ref02_1E_rendering_prov_id = null,
					@L2420A_ref02_EI_rendering_prov_id = null,
					@L2420A_ref02_SY_rendering_prov_id = null,
					@L2420A_ref02_TJ_rendering_prov_id = null,
					
					@L2420B_nm102_entity_type_qual = null,
					@L2420B_nm103_payer_last_nm = null,
					@L2420B_nm108_id_code_qual = null,
					@L2420B_nm109_other_payer_id = null,
					@L2420B_ref02_9F_referral_number = null,
					@L2420B_ref02_G1_prior_auth_number = null,
					
					@L2420C_nm101_entity_id_code = null,
					@L2420C_nm102_entity_type_qual = null,
					@L2420C_nm103_assistant_surgeon_last_nm = null,
					@L2420C_nm104_assistant_surgeon_first_nm = null,
					@L2420C_nm105_assistant_surgeon_middle_nm = null,
					@L2420C_nm107_assistant_surgeon_suffix = null,
					@L2420C_nm108_id_code_qual = null,
					@L2420C_nm109_assistant_surgeon_id = null,
					@L2420C_prv01_provider_code = null,
					@L2420C_prv02_ref_id_qual = null,
					@L2420C_prv03_taxonomy_code = null,
					@L2420C_ref02_1C_service_facility_id = null,
					@L2420C_ref02_1D_service_facility_id = null,
					@L2420C_ref02_1E_service_facility_id = null,
					@L2420C_ref02_G2_service_facility_id = null,
					@L2420C_ref02_TJ_service_facility_id = null,
					
					@L2430_svd01_other_payer_id = null,
					@L2430_svd02_service_line_paid = null,
					@L2430_svd03_service_id_qual = null,
					@L2430_svd03_proc_code = null,
					@L2430_svd03_proc_mod1 = null,
					@L2430_svd03_proc_mod2 = null,
					@L2430_svd03_proc_mod3 = null,
					@L2430_svd03_proc_mod4 = null,
					@L2430_svd03_proc_code_desc = null,
					@L2430_svd05_paid_service_unit = null,
					@L2430_svd06_bundled_unbundled_line_num = null,
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
					@L2430_dtp03_573_date_claim_paid = null
		end

		-- Billing/Pay-To Provider Loop
		if ( RTrim(@col001) = 'HL' AND LTRIM(RTRIM(@Col004)) = '20')
		begin
			select	@curLoop = '2000A',
				@L2000A_hl01_hierarchical_id_num = LTRIM(RTRIM(@Col002)),
				@L2000A_hl03_hierarchical_level_code = LTRIM(RTRIM(@Col004)),
				@L2000A_hl04_hierarchical_child_code = LTRIM(RTRIM(@Col005))
		end
	
	end
	-- END OF THE HL / CLM segment check


	if ( RTrim(@col001) = 'BHT' AND @curLoop IS NULL)
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
		select	@ref01_receiver_ref_id_qual = LTRIM(RTRIM(@Col002)),
			@ref02_transmission_type_code = LTRIM(RTRIM(@Col003))
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
	begin
		set @L2000A_cur02_currency_code = LTRIM(RTRIM(@Col003))
	end

	-- Billing/Pay-To Provider Loop: Name
	if ( RTrim(@col001) = 'NM1' AND @curLoop = '2000A')
	begin	

			-- Reset all the previous 2010AA Loop values, because we're starting a new 2010AA loop.  This will
			-- prevent any values from being carried over from the previous 2010AA loop.
			set @L2010AA_nm102_entity_type_qual = null
			set @L2010AA_nm103_billing_prov_last_nm = null
			set @L2010AA_nm104_billing_prov_first_nm = null
			set @L2010AA_nm105_billing_prov_middle_nm = null
			set @L2010AA_nm107_billing_prov_suffix = null
			set @L2010AA_nm108_id_code_qual = null
			set @L2010AA_nm109_billing_prov_id = null
			set @L2010AA_n301_billing_prov_address1 = null
			set @L2010AA_n302_billing_prov_address2 = null
			set @L2010AA_n401_billing_prov_city = null
			set @L2010AA_n402_billing_prov_state = null
			set @L2010AA_n403_billing_prov_zip = null
			set @L2010AA_n404_billing_prov_country = null
			set @L2010AA_ref02_1C_billing_prov_id = null
			set @L2010AA_ref02_1D_billing_prov_id = null
			set @L2010AA_ref02_1E_billing_prov_id = null
			set @L2010AA_ref02_EI_billing_prov_id = null
			set @L2010AA_ref02_SY_billing_prov_id = null
			set @L2010AA_ref02_TJ_billing_prov_id = null
			set @L2010AA_ref02_06_card_billing_id = null
			set @L2010AA_ref02_8U_card_billing_id = null
			set @L2010AA_ref02_EM_card_billing_id = null
			set @L2010AA_ref02_IJ_card_billing_id = null
			set @L2010AA_ref02_LU_card_billing_id = null
			set @L2010AA_ref02_ST_card_billing_id = null

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
					@L2010AB_ref02_1E_payto_prov_id = null,
					@L2010AB_ref02_EI_payto_prov_id = null,
					@L2010AB_ref02_SY_payto_prov_id = null,
					@L2010AB_ref02_TJ_payto_prov_id = null

		select	@curLoop = '2010AA',
			@L2010AA_nm102_entity_type_qual = LTRIM(RTRIM(@Col003)),
			@L2010AA_nm103_billing_prov_last_nm = LTRIM(RTRIM(@Col004)),
			@L2010AA_nm104_billing_prov_first_nm = LTRIM(RTRIM(@Col005)),
			@L2010AA_nm105_billing_prov_middle_nm = LTRIM(RTRIM(@Col006)),
			@L2010AA_nm107_billing_prov_suffix = LTRIM(RTRIM(@Col008)),
			@L2010AA_nm108_id_code_qual = LTRIM(RTRIM(@Col009)),
			@L2010AA_nm109_billing_prov_id = LTRIM(RTRIM(@Col010))
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
		set @L2010AA_ref02_1C_billing_prov_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = '1D' )
		set @L2010AA_ref02_1D_billing_prov_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = '1E' )
		set @L2010AA_ref02_1E_billing_prov_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = 'EI' )
		set @L2010AA_ref02_EI_billing_prov_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = 'SY' )
		set @L2010AA_ref02_SY_billing_prov_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = 'TJ' )
		set @L2010AA_ref02_TJ_billing_prov_id = LTRIM(RTRIM(@Col003))
	-- Billing/Pay-To Provider Loop: Credit Card ID
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = '06' )
		set @L2010AA_ref02_06_card_billing_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = '8U' )
		set @L2010AA_ref02_8U_card_billing_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = 'EM' )
		set @L2010AA_ref02_EM_card_billing_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = 'IJ' )
		set @L2010AA_ref02_IJ_card_billing_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = 'LU' )
		set @L2010AA_ref02_LU_card_billing_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = 'ST' )
		set @L2010AA_ref02_ST_card_billing_id = LTRIM(RTRIM(@Col003))
		
	-- Pay-To Provider Loop: Name
	if ( RTrim(@col001) = 'NM1' AND LTRIM(RTRIM(@Col002)) = '87')
	begin
		select	@curLoop = '2010AB',
			@L2010AB_nm102_entity_type_qual = LTRIM(RTRIM(@Col003)),
			@L2010AB_nm103_payto_prov_last_nm = LTRIM(RTRIM(@Col004)),
			@L2010AB_nm104_payto_prov_first_nm = LTRIM(RTRIM(@Col005)),
			@L2010AB_nm105_payto_prov_middle_nm = LTRIM(RTRIM(@Col006)),
			@L2010AB_nm107_payto_prov_suffix = LTRIM(RTRIM(@Col008)),
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
		set @L2010AB_ref02_1C_payto_prov_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AB' AND LTRIM(RTRIM(@Col002)) = '1D' )
		set @L2010AB_ref02_1D_payto_prov_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AB' AND LTRIM(RTRIM(@Col002)) = '1E' )
		set @L2010AB_ref02_1E_payto_prov_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AB' AND LTRIM(RTRIM(@Col002)) = 'EI' )
		set @L2010AB_ref02_EI_payto_prov_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AB' AND LTRIM(RTRIM(@Col002)) = 'SY' )
		set @L2010AB_ref02_SY_payto_prov_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AB' AND LTRIM(RTRIM(@Col002)) = 'TJ' )
		set @L2010AB_ref02_TJ_payto_prov_id = LTRIM(RTRIM(@Col003))
		
	if ( RTrim(@col001) = 'HL' AND LTRIM(RTRIM(@Col004)) = '22')
	begin
		select	@curLoop = '2000B',
			@L2000B_hl01_hierarchical_id_num = LTRIM(RTRIM(@Col002)),
			@L2000B_hl02_hierarchical_parent_id_num = LTRIM(RTRIM(@Col003)),
			@L2000B_hl03_hierarchical_level_code = LTRIM(RTRIM(@Col004)),
			@L2000B_hl04_hierarchical_child_code = LTRIM(RTRIM(@Col005))
	end
		
	if ( RTrim(@col001) = 'SBR' AND @curLoop = '2000B')
	begin
		select	@L2000B_sbr01_payer_resp_seq_code = LTRIM(RTRIM(@Col002)),
			@L2000B_sbr02_ind_relationship_code = LTRIM(RTRIM(@Col003)),
			@L2000B_sbr03_insured_grp_policy_num = LTRIM(RTRIM(@Col004)),
			@L2000B_sbr04_insured_grp_nm = LTRIM(RTRIM(@Col005)),
			@L2000B_sbr06_cob_code = LTRIM(RTRIM(@Col007)),
			@L2000B_sbr09_claim_filing_ind_code = LTRIM(RTRIM(@Col010)),
			-- Reset all the subscriber-level variables
			--@L2000B_pat06_insured_ind_death_date = null,
			--@L2000B_pat08_patient_weight = null,
			--@L2000B_pat09_pregnancy_indicator = null,
	
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
			@L2010BB_nm103_payer_nm = null,
			@L2010BB_nm108_payer_id_qual = null,
			@L2010BB_nm109_payer_id = null,
	
			@L2010BB_n301_payer_address1 = null,
			@L2010BB_n302_payer_address2 = null,
	
			@L2010BB_n401_payer_city = null,
			@L2010BB_n402_payer_state = null,
			@L2010BB_n403_payer_zip = null,
			@L2010BB_n404_payer_country = null,
	
			@L2010BB_ref02_2U_payer_id = null,
			@L2010BB_ref02_FY_payer_id = null,
			@L2010BB_ref02_NF_payer_id = null,
			@L2010BB_ref02_TJ_payer_id = null,
			
			@L2010BC_nm102_entity_type_qual = null,
			@L2010BC_nm103_resp_party_last_nm = null,
			@L2010BC_nm104_resp_party_first_nm = null,
			@L2010BC_nm105_resp_party_middle_nm = null,
			@L2010BC_nm107_resp_party_suffix = null,
			@L2010BC_nm109_MI_card_num = null,

			@L2010BC_ref02_BB_card_num = null,
	
			-- Patient-level variables
			@L2000C_hl01_hierarchical_id_num = null,
			@L2000C_hl02_hierarchical_parent_id_num = null,
			@L2000C_hl03_hierarchical_level_code = null,
			@L2000C_hl04_hierarchical_child_code = null,
	
			@L2000C_pat01_ind_relationship_code = null,
			@L2000C_pat04_student_status_code = null,
	
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
	
	if ( RTrim(@col001) = 'NM1' AND LTRIM(RTRIM(@Col002)) = 'IL' AND @curLoop LIKE '20%')
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
		select	@curLoop = '2010BA',
			@L2010BA_n301_subscriber_address1 = LTRIM(RTRIM(@Col002)),
			@L2010BA_n302_subscriber_address2 = LTRIM(RTRIM(@Col003))
	end
	if ( RTrim(@col001) = 'N4' AND @curLoop = '2010BA')
	begin
		select	@curLoop = '2010BA',
			@L2010BA_n401_subscriber_city = LTRIM(RTRIM(@Col002)),
			@L2010BA_n402_subscriber_state = LTRIM(RTRIM(@Col003)),
			@L2010BA_n403_subscriber_zip = LTRIM(RTRIM(@Col004)),
			@L2010BA_n404_subscriber_country = LTRIM(RTRIM(@Col005))
	end
		
	if ( RTrim(@col001) = 'DMG' AND @curLoop = '2010BA')
	begin
		select	@curLoop = '2010BA',
			@L2010BA_dmg02_subscriber_dob = LTRIM(RTRIM(@Col003)),
			@L2010BA_dmg03_subscriber_gender = LTRIM(RTRIM(@Col004))
	end
		
	-- Subscriber Loop: Supplemental IDs
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010BA' AND LTRIM(RTRIM(@Col002)) = '1W' )
		set @L2010BA_ref02_1W_subscriber_sup_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010BA' AND LTRIM(RTRIM(@Col002)) = '23' )
		set @L2010BA_ref02_23_subscriber_sup_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010BA' AND LTRIM(RTRIM(@Col002)) = 'IG' )
		set @L2010BA_ref02_IG_subscriber_sup_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010BA' AND LTRIM(RTRIM(@Col002)) = 'SY' )
		set @L2010BA_ref02_SY_subscriber_sup_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010BA' AND LTRIM(RTRIM(@Col002)) = 'Y4' )
		set @L2010BA_ref02_Y4_prop_casualty_claim_num = LTRIM(RTRIM(@Col003))
		
	if ( RTrim(@col001) = 'NM1' AND LTRIM(RTRIM(@Col002)) = 'PR' AND @curLoop LIKE '20%' )
	begin
		select	@curLoop = '2010BB',
			@L2010BB_nm102_entity_type_qual = LTRIM(RTRIM(@Col003)),
			@L2010BB_nm103_payer_nm = LTRIM(RTRIM(@Col004)),
			@L2010BB_nm108_payer_id_qual = LTRIM(RTRIM(@Col009)),
			@L2010BB_nm109_payer_id = LTRIM(RTRIM(@Col010))
	end
		
	if ( RTrim(@col001) = 'N3' AND @curLoop = '2010BB')
	begin
		select	@curLoop = '2010BB',
			@L2010BB_n301_payer_address1 = LTRIM(RTRIM(@Col002)),
			@L2010BB_n302_payer_address2 = LTRIM(RTRIM(@Col003))
	end
		
	if ( RTrim(@col001) = 'N4' AND @curLoop = '2010BB')
	begin
		select	@curLoop = '2010BB',
			@L2010BB_n401_payer_city = LTRIM(RTRIM(@Col002)),
			@L2010BB_n402_payer_state = LTRIM(RTRIM(@Col003)),
			@L2010BB_n403_payer_zip = LTRIM(RTRIM(@Col004)),
			@L2010BB_n404_payer_country = LTRIM(RTRIM(@Col005))
	end
		
	-- Payer Loop: Payer IDs
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010BB' AND LTRIM(RTRIM(@Col002)) = '2U' )
		set @L2010BB_ref02_2U_payer_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010BB' AND LTRIM(RTRIM(@Col002)) = 'FY' )
		set @L2010BB_ref02_FY_payer_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010BB' AND LTRIM(RTRIM(@Col002)) = 'NF' )
		set @L2010BB_ref02_NF_payer_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010BB' AND LTRIM(RTRIM(@Col002)) = 'TJ' )
		set @L2010BB_ref02_TJ_payer_id = LTRIM(RTRIM(@Col003))
		
	if ( RTrim(@col001) = 'NM1' AND LTRIM(RTRIM(@Col002)) = 'AO')
	begin
		select	@curLoop = '2010BC',
			@L2010BC_nm102_entity_type_qual = LTRIM(RTRIM(@Col003)),
			@L2010BC_nm103_resp_party_last_nm = LTRIM(RTRIM(@Col004)),
			@L2010BC_nm104_resp_party_first_nm = LTRIM(RTRIM(@Col005)),
			@L2010BC_nm105_resp_party_middle_nm = LTRIM(RTRIM(@Col006)),
			@L2010BC_nm107_resp_party_suffix = LTRIM(RTRIM(@Col008)),
			@L2010BC_nm109_MI_card_num = LTRIM(RTRIM(@Col010))
	end		
	if ( RTrim(@col001) = 'REF' AND LTRIM(RTRIM(@Col002)) = 'BB')
	begin
		select	@L2010BC_ref02_BB_card_num = LTRIM(RTRIM(@Col003))
	end

	if ( RTrim(@col001) = 'HL' AND LTRIM(RTRIM(@Col004)) = '23')
	begin
		select	@curLoop = '2000C',
			@L2000C_hl01_hierarchical_id_num = LTRIM(RTRIM(@Col002)),
			@L2000C_hl02_hierarchical_parent_id_num = LTRIM(RTRIM(@Col003)),
			@L2000C_hl03_hierarchical_level_code = LTRIM(RTRIM(@Col004)),
			@L2000C_hl04_hierarchical_child_code = LTRIM(RTRIM(@Col005))
	end
		
	if ( RTrim(@col001) = 'PAT' AND @curLoop = '2000C')
	begin
		select	@L2000C_pat01_ind_relationship_code = LTRIM(RTRIM(@Col002)),
			@L2000C_pat04_student_status_code = LTRIM(RTRIM(@Col005)),

			-- Reset patient-level variables
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
		select	@L2010CA_n301_patient_address1 = LTRIM(RTRIM(@Col002)),
			@L2010CA_n302_patient_address2 = LTRIM(RTRIM(@Col003))
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
		select	@L2010CA_dmg02_patient_dob = LTRIM(RTRIM(@Col003)),
			@L2010CA_dmg03_patient_gender = LTRIM(RTRIM(@Col004))
	end
		
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010CA' AND LTRIM(RTRIM(@Col002)) = '1W' )
		set @L2010CA_ref02_1W_patient_sup_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010CA' AND LTRIM(RTRIM(@Col002)) = '23' )
		set @L2010CA_ref02_23_patient_sup_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010CA' AND LTRIM(RTRIM(@Col002)) = 'IG' )
		set @L2010CA_ref02_IG_patient_sup_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010CA' AND LTRIM(RTRIM(@Col002)) = 'SY' )
		set @L2010CA_ref02_SY_patient_sup_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010CA' AND LTRIM(RTRIM(@Col002)) = 'Y4' )
		set @L2010CA_ref02_Y4_prop_casualty_claim_num = LTRIM(RTRIM(@Col003))


	-- Get LX service line information (this segment is essentially the "header" of the detail section)
	if ( RTrim(@col001) = 'LX' )
	begin
		set @curLoop = '2400'
		-- insert a record when we start a new service line (meaning we're done with the previous service line)
		-- Only insert a record when we've already picked the procedure code out of the SV1 segment (skips this the first time through only)
		if (@L2400_sv301_proc_code IS NOT NULL AND @L2400_lx01_assigned_num IS NOT NULL)
		begin
			insert into x12_837_claim_dental
						(	x12_transaction_id,
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
							L2010AA_ref02_1C_billing_prov_id,
							L2010AA_ref02_1D_billing_prov_id,
							L2010AA_ref02_1E_billing_prov_id,
							L2010AA_ref02_EI_billing_prov_id,
							L2010AA_ref02_SY_billing_prov_id,
							L2010AA_ref02_TJ_billing_prov_id,
							L2010AA_ref02_06_card_billing_id,
							L2010AA_ref02_8U_card_billing_id,
							L2010AA_ref02_EM_card_billing_id,
							L2010AA_ref02_IJ_card_billing_id,
							L2010AA_ref02_LU_card_billing_id,
							L2010AA_ref02_ST_card_billing_id,
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
							L2010AB_ref02_1E_payto_prov_id,
							L2010AB_ref02_EI_payto_prov_id,
							L2010AB_ref02_SY_payto_prov_id,
							L2010AB_ref02_TJ_payto_prov_id,
							L2000B_hl01_hierarchical_id_num,
							L2000B_hl02_hierarchical_parent_id_num,
							L2000B_hl03_hierarchical_level_code,
							L2000B_hl04_hierarchical_child_code,
							L2000B_sbr01_payer_resp_seq_code,
							L2000B_sbr02_ind_relationship_code,
							L2000B_sbr03_insured_grp_policy_num,
							L2000B_sbr04_insured_grp_nm,
							L2000B_sbr06_cob_code,
							L2000B_sbr09_claim_filing_ind_code,
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
							L2010BB_nm103_payer_nm,
							L2010BB_nm108_payer_id_qual,
							L2010BB_nm109_payer_id,
							L2010BB_n301_payer_address1,
							L2010BB_n302_payer_address2,
							L2010BB_n401_payer_city,
							L2010BB_n402_payer_state,
							L2010BB_n403_payer_zip,
							L2010BB_n404_payer_country,
							L2010BB_ref02_2U_payer_id,
							L2010BB_ref02_FY_payer_id,
							L2010BB_ref02_NF_payer_id,
							L2010BB_ref02_TJ_payer_id,
							L2010BC_nm102_entity_type_qual,
							L2010BC_nm103_resp_party_last_nm,
							L2010BC_nm104_resp_party_first_nm,
							L2010BC_nm105_resp_party_middle_nm,
							L2010BC_nm107_resp_party_suffix,
							L2010BC_nm109_MI_card_num,
							L2010BC_ref02_BB_card_num,
							L2000C_hl01_hierarchical_id_num,
							L2000C_hl02_hierarchical_parent_id_num,
							L2000C_hl03_hierarchical_level_code,
							L2000C_hl04_hierarchical_child_code,
							L2000C_pat01_ind_relationship_code,
							L2000C_pat04_student_status_code,
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
							L2300_clm05_claim_freq_code,
							L2300_clm06_provider_signature_ind,
							L2300_clm07_medicare_assign_code,
							L2300_clm08_benefit_assign_ind,
							L2300_clm09_release_of_info_code,
							L2300_clm11_related_causes_code1,
							L2300_clm11_related_causes_code2,
							L2300_clm11_related_causes_code3,
							L2300_clm11_auto_accident_state_code,
							L2300_clm11_country_code,
							L2300_clm12_special_prog_ind,
							L2300_clm19_claim_submission_reason_code,
							L2300_clm20_delay_reason_code,
							L2300_dtp03_435_related_hospitalization_admission_date,
							L2300_dtp03_096_discharge_end_of_care_date,
							L2300_dtp03_330_referral_date,
							L2300_dtp03_439_accident_date,
							L2300_dtp03_452_orthodontic_banding_date,
							L2300_dtp03_472_service_date,
							L2300_dn101_orthodontic_treatment_months_count,
							L2300_dn102_orthodontic_treatment_months_remaining_count,
							L2300_dn103_question_response,
							L2300_1_dn201_tooth_number,
							L2300_1_dn202_tooth_status_code,
							L2300_2_dn201_tooth_number,
							L2300_2_dn202_tooth_status_code,
							L2300_3_dn201_tooth_number,
							L2300_3_dn202_tooth_status_code,
							L2300_4_dn201_tooth_number,
							L2300_4_dn202_tooth_status_code,
							L2300_5_dn201_tooth_number,
							L2300_5_dn202_tooth_status_code,
							L2300_6_dn201_tooth_number,
							L2300_6_dn202_tooth_status_code,
							L2300_7_dn201_tooth_number,
							L2300_7_dn202_tooth_status_code,
							L2300_8_dn201_tooth_number,
							L2300_8_dn202_tooth_status_code,
							L2300_9_dn201_tooth_number,
							L2300_9_dn202_tooth_status_code,
							L2300_10_dn201_tooth_number,
							L2300_10_dn202_tooth_status_code,
							L2300_11_dn201_tooth_number,
							L2300_11_dn202_tooth_status_code,
							L2300_12_dn201_tooth_number,
							L2300_12_dn202_tooth_status_code,
							L2300_13_dn201_tooth_number,
							L2300_13_dn202_tooth_status_code,
							L2300_14_dn201_tooth_number,
							L2300_14_dn202_tooth_status_code,
							L2300_15_dn201_tooth_number,
							L2300_15_dn202_tooth_status_code,
							L2300_16_dn201_tooth_number,
							L2300_16_dn202_tooth_status_code,
							L2300_17_dn201_tooth_number,
							L2300_17_dn202_tooth_status_code,
							L2300_18_dn201_tooth_number,
							L2300_18_dn202_tooth_status_code,
							L2300_19_dn201_tooth_number,
							L2300_19_dn202_tooth_status_code,
							L2300_20_dn201_tooth_number,
							L2300_20_dn202_tooth_status_code,
							L2300_21_dn201_tooth_number,
							L2300_21_dn202_tooth_status_code,
							L2300_22_dn201_tooth_number,
							L2300_22_dn202_tooth_status_code,
							L2300_23_dn201_tooth_number,
							L2300_23_dn202_tooth_status_code,
							L2300_24_dn201_tooth_number,
							L2300_24_dn202_tooth_status_code,
							L2300_25_dn201_tooth_number,
							L2300_25_dn202_tooth_status_code,
							L2300_26_dn201_tooth_number,
							L2300_26_dn202_tooth_status_code,
							L2300_27_dn201_tooth_number,
							L2300_27_dn202_tooth_status_code,
							L2300_28_dn201_tooth_number,
							L2300_28_dn202_tooth_status_code,
							L2300_29_dn201_tooth_number,
							L2300_29_dn202_tooth_status_code,
							L2300_30_dn201_tooth_number,
							L2300_30_dn202_tooth_status_code,
							L2300_31_dn201_tooth_number,
							L2300_31_dn202_tooth_status_code,
							L2300_32_dn201_tooth_number,
							L2300_32_dn202_tooth_status_code,
							L2300_33_dn201_tooth_number,
							L2300_33_dn202_tooth_status_code,
							L2300_34_dn201_tooth_number,
							L2300_34_dn202_tooth_status_code,
							L2300_35_dn201_tooth_number,
							L2300_35_dn202_tooth_status_code,
							L2300_pwk01_attachment_type_code,
							L2300_pwk02_attachment_trans_code,
							L2300_pwk06_attachment_control_num,
							L2300_amt02_patient_paid_amt,
							L2300_amt02_card_maximum_amt,
							L2300_ref02_G3_predetermination_id,
							L2300_ref02_4N_service_auth_exception_code,
							L2300_ref02_F8_original_ref_num,
							L2300_ref02_9F_referral_num,
							L2300_ref02_G1_prior_auth_num,
							L2300_ref02_D9_value_added_network_trace_num,
							L2300_nte01_note_ref_code,
							L2300_nte02_claim_note_text,
							L2310A_nm101_entity_id_code,
							L2310A_nm102_entity_type_qual,
							L2310A_nm103_referring_prov_last_nm,
							L2310A_nm104_referring_prov_first_nm,
							L2310A_nm105_referring_prov_middle_nm,
							L2310A_nm107_referring_prov_suffix,
							L2310A_nm108_id_code_qual,
							L2310A_nm109_referring_prov_id,
							L2310A_prv01_provider_code,
							L2310A_prv02_ref_id_qual,
							L2310A_prv03_taxonomy_code,
							L2310A_ref02_1C_referring_prov_id,
							L2310A_ref02_1D_referring_prov_id,
							L2310A_ref02_1E_referring_prov_id,
							L2310A_ref02_EI_referring_prov_id,
							L2310A_ref02_G2_referring_prov_id,
							L2310A_ref02_SY_referring_prov_id,
							L2310A_ref02_TJ_referring_prov_id,
							L2310B_nm102_entity_type_qual,
							L2310B_nm103_rendering_prov_last_nm,
							L2310B_nm104_rendering_prov_first_nm,
							L2310B_nm105_rendering_prov_middle_nm,
							L2310B_nm107_rendering_prov_suffix,
							L2310B_nm108_id_code_qual,
							L2310B_nm109_rendering_prov_id,
							L2310B_prv01_provider_code,
							L2310B_prv02_ref_id_qual,
							L2310B_prv03_taxonomy_code,
							L2310B_ref02_1C_rendering_prov_id,
							L2310B_ref02_1D_rendering_prov_id,
							L2310B_ref02_1E_rendering_prov_id,
							L2310B_ref02_EI_rendering_prov_id,
							L2310B_ref02_G2_rendering_prov_id,
							L2310B_ref02_SY_rendering_prov_id,
							L2310B_ref02_TJ_rendering_prov_id,
							L2310C_nm102_entity_type_qual,
							L2310C_nm103_service_facility_last_nm,
							L2310C_nm108_id_code_qual,
							L2310C_nm109_service_facility_id,
							L2310C_ref02_1C_lab_or_facility_prov_id,
							L2310C_ref02_1D_lab_or_facility_prov_id,
							L2310C_ref02_1G_lab_or_facility_prov_id,
							L2310C_ref02_G2_lab_or_facility_prov_id,
							L2310C_ref02_TJ_lab_or_facility_prov_id,
							L2310D_nm102_entity_type_qual,
							L2310D_nm103_assistant_surgeon_last_nm,
							L2310D_nm104_assistant_surgeon_first_nm,
							L2310D_nm105_assistant_surgeon_middle_nm,
							L2310D_nm107_assistant_surgeon_suffix,
							L2310D_nm108_id_code_qual,
							L2310D_nm109_assistant_surgeon_prov_id,
							L2310D_prv01_provider_code,
							L2310D_prv02_id_code_qual,
							L2310D_prv03_taxonomy_code,
							L2310D_ref02_1C_service_facility_id,
							L2310D_ref02_1D_service_facility_id,
							L2310D_ref02_1E_service_facility_id,
							L2310D_ref02_G2_service_facility_id,
							L2310D_ref02_TJ_service_facility_id,
							L2320_1_sbr01_payer_resp_seq_code,
							L2320_1_sbr02_ind_relationship_code,
							L2320_1_sbr03_insured_grp_policy_num,
							L2320_1_sbr04_insured_grp_nm,
							L2320_1_sbr09_claim_file_ind_code,
							L2320_1_1_cas01_adjustment_group_code,
							L2320_1_1_cas02_adjustment_reason_code,
							L2320_1_1_cas03_adjustment_amt,
							L2320_1_1_cas04_adjustment_qty,
							L2320_1_1_cas05_adjustment_reason_code,
							L2320_1_1_cas06_adjustment_amt,
							L2320_1_1_cas07_adjustment_qty,
							L2320_1_1_cas08_adjustment_reason_code,
							L2320_1_1_cas09_adjustment_amt,
							L2320_1_1_cas10_adjustment_qty,
							L2320_1_2_cas01_adjustment_group_code,
							L2320_1_2_cas02_adjustment_reason_code,
							L2320_1_2_cas03_adjustment_amt,
							L2320_1_2_cas04_adjustment_qty,
							L2320_1_2_cas05_adjustment_reason_code,
							L2320_1_2_cas06_adjustment_amt,
							L2320_1_2_cas07_adjustment_qty,
							L2320_1_2_cas08_adjustment_reason_code,
							L2320_1_2_cas09_adjustment_amt,
							L2320_1_2_cas10_adjustment_qty,
							L2320_1_3_cas01_adjustment_group_code,
							L2320_1_3_cas02_adjustment_reason_code,
							L2320_1_3_cas03_adjustment_amt,
							L2320_1_3_cas04_adjustment_qty,
							L2320_1_3_cas05_adjustment_reason_code,
							L2320_1_3_cas06_adjustment_amt,
							L2320_1_3_cas07_adjustment_qty,
							L2320_1_3_cas08_adjustment_reason_code,
							L2320_1_3_cas09_adjustment_amt,
							L2320_1_3_cas10_adjustment_qty,
							L2320_1_4_cas01_adjustment_group_code,
							L2320_1_4_cas02_adjustment_reason_code,
							L2320_1_4_cas03_adjustment_amt,
							L2320_1_4_cas04_adjustment_qty,
							L2320_1_4_cas05_adjustment_reason_code,
							L2320_1_4_cas06_adjustment_amt,
							L2320_1_4_cas07_adjustment_qty,
							L2320_1_4_cas08_adjustment_reason_code,
							L2320_1_4_cas09_adjustment_amt,
							L2320_1_4_cas10_adjustment_qty,
							L2320_1_5_cas01_adjustment_group_code,
							L2320_1_5_cas02_adjustment_reason_code,
							L2320_1_5_cas03_adjustment_amt,
							L2320_1_5_cas04_adjustment_qty,
							L2320_1_5_cas05_adjustment_reason_code,
							L2320_1_5_cas06_adjustment_amt,
							L2320_1_5_cas07_adjustment_qty,
							L2320_1_5_cas08_adjustment_reason_code,
							L2320_1_5_cas09_adjustment_amt,
							L2320_1_5_cas10_adjustment_qty,
							L2320_1_amt02_D_payer_paid_amt,
							L2320_1_amt02_AAE_cob_approved_amt,
							L2320_1_amt02_B6_cob_allowed_amt,
							L2320_1_amt02_F2_patient_responsibility_amt,
							L2320_1_amt02_AU_cob_covered_amt,
							L2320_1_amt02_D8_discount_amt,
							L2320_1_amt02_F5_payer_patient_paid_amt,
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
							L2330A_1_n301_other_subscriber_address1,
							L2330A_1_n302_other_subscriber_address2,
							L2330A_1_n401_other_subscriber_city,
							L2330A_1_n402_other_subscriber_state,
							L2330A_1_n403_other_subscriber_zip,
							L2330A_1_n404_other_subscriber_country,
							L2330A_1_ref02_1W_other_subscriber_sup_id,
							L2330A_1_ref02_23_other_subscriber_sup_id,
							L2330A_1_ref02_IG_other_subscriber_sup_id,
							L2330A_1_ref02_SY_other_subscriber_sup_id,
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
							L2330B_1_ref02_T4_other_payer_claim_adj_ind,
							L2320_2_sbr01_payer_resp_seq_code,
							L2320_2_sbr02_ind_relationship_code,
							L2320_2_sbr03_insured_grp_policy_num,
							L2320_2_sbr04_insured_grp_nm,
							L2320_2_sbr09_claim_file_ind_code,
							L2320_2_1_cas01_adjustment_group_code,
							L2320_2_1_cas02_adjustment_reason_code,
							L2320_2_1_cas03_adjustment_amt,
							L2320_2_1_cas04_adjustment_qty,
							L2320_2_1_cas05_adjustment_reason_code,
							L2320_2_1_cas06_adjustment_amt,
							L2320_2_1_cas07_adjustment_qty,
							L2320_2_1_cas08_adjustment_reason_code,
							L2320_2_1_cas09_adjustment_amt,
							L2320_2_1_cas10_adjustment_qty,
							L2320_2_2_cas01_adjustment_group_code,
							L2320_2_2_cas02_adjustment_reason_code,
							L2320_2_2_cas03_adjustment_amt,
							L2320_2_2_cas04_adjustment_qty,
							L2320_2_2_cas05_adjustment_reason_code,
							L2320_2_2_cas06_adjustment_amt,
							L2320_2_2_cas07_adjustment_qty,
							L2320_2_2_cas08_adjustment_reason_code,
							L2320_2_2_cas09_adjustment_amt,
							L2320_2_2_cas10_adjustment_qty,
							L2320_2_3_cas01_adjustment_group_code,
							L2320_2_3_cas02_adjustment_reason_code,
							L2320_2_3_cas03_adjustment_amt,
							L2320_2_3_cas04_adjustment_qty,
							L2320_2_3_cas05_adjustment_reason_code,
							L2320_2_3_cas06_adjustment_amt,
							L2320_2_3_cas07_adjustment_qty,
							L2320_2_3_cas08_adjustment_reason_code,
							L2320_2_3_cas09_adjustment_amt,
							L2320_2_3_cas10_adjustment_qty,
							L2320_2_4_cas01_adjustment_group_code,
							L2320_2_4_cas02_adjustment_reason_code,
							L2320_2_4_cas03_adjustment_amt,
							L2320_2_4_cas04_adjustment_qty,
							L2320_2_4_cas05_adjustment_reason_code,
							L2320_2_4_cas06_adjustment_amt,
							L2320_2_4_cas07_adjustment_qty,
							L2320_2_4_cas08_adjustment_reason_code,
							L2320_2_4_cas09_adjustment_amt,
							L2320_2_4_cas10_adjustment_qty,
							L2320_2_5_cas01_adjustment_group_code,
							L2320_2_5_cas02_adjustment_reason_code,
							L2320_2_5_cas03_adjustment_amt,
							L2320_2_5_cas04_adjustment_qty,
							L2320_2_5_cas05_adjustment_reason_code,
							L2320_2_5_cas06_adjustment_amt,
							L2320_2_5_cas07_adjustment_qty,
							L2320_2_5_cas08_adjustment_reason_code,
							L2320_2_5_cas09_adjustment_amt,
							L2320_2_5_cas10_adjustment_qty,
							L2320_2_amt02_D_payer_paid_amt,
							L2320_2_amt02_AAE_cob_approved_amt,
							L2320_2_amt02_B6_cob_allowed_amt,
							L2320_2_amt02_F2_patient_responsibility_amt,
							L2320_2_amt02_AU_cob_covered_amt,
							L2320_2_amt02_D8_discount_amt,
							L2320_2_amt02_F5_payer_patient_paid_amt,
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
							L2330A_2_n301_other_subscriber_address1,
							L2330A_2_n302_other_subscriber_address2,
							L2330A_2_n401_other_subscriber_city,
							L2330A_2_n402_other_subscriber_state,
							L2330A_2_n403_other_subscriber_zip,
							L2330A_2_n404_other_subscriber_country,
							L2330A_2_ref02_1W_other_subscriber_sup_id,
							L2330A_2_ref02_23_other_subscriber_sup_id,
							L2330A_2_ref02_IG_other_subscriber_sup_id,
							L2330A_2_ref02_SY_other_subscriber_sup_id,
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
							L2330B_2_ref02_T4_other_payer_claim_adj_ind,
							L2320_3_sbr01_payer_resp_seq_code,
							L2320_3_sbr02_ind_relationship_code,
							L2320_3_sbr03_insured_grp_policy_num,
							L2320_3_sbr04_insured_grp_nm,
							L2320_3_sbr09_claim_file_ind_code,
							L2320_3_1_cas01_adjustment_group_code,
							L2320_3_1_cas02_adjustment_reason_code,
							L2320_3_1_cas03_adjustment_amt,
							L2320_3_1_cas04_adjustment_qty,
							L2320_3_1_cas05_adjustment_reason_code,
							L2320_3_1_cas06_adjustment_amt,
							L2320_3_1_cas07_adjustment_qty,
							L2320_3_1_cas08_adjustment_reason_code,
							L2320_3_1_cas09_adjustment_amt,
							L2320_3_1_cas10_adjustment_qty,
							L2320_3_2_cas01_adjustment_group_code,
							L2320_3_2_cas02_adjustment_reason_code,
							L2320_3_2_cas03_adjustment_amt,
							L2320_3_2_cas04_adjustment_qty,
							L2320_3_2_cas05_adjustment_reason_code,
							L2320_3_2_cas06_adjustment_amt,
							L2320_3_2_cas07_adjustment_qty,
							L2320_3_2_cas08_adjustment_reason_code,
							L2320_3_2_cas09_adjustment_amt,
							L2320_3_2_cas10_adjustment_qty,
							L2320_3_3_cas01_adjustment_group_code,
							L2320_3_3_cas02_adjustment_reason_code,
							L2320_3_3_cas03_adjustment_amt,
							L2320_3_3_cas04_adjustment_qty,
							L2320_3_3_cas05_adjustment_reason_code,
							L2320_3_3_cas06_adjustment_amt,
							L2320_3_3_cas07_adjustment_qty,
							L2320_3_3_cas08_adjustment_reason_code,
							L2320_3_3_cas09_adjustment_amt,
							L2320_3_3_cas10_adjustment_qty,
							L2320_3_4_cas01_adjustment_group_code,
							L2320_3_4_cas02_adjustment_reason_code,
							L2320_3_4_cas03_adjustment_amt,
							L2320_3_4_cas04_adjustment_qty,
							L2320_3_4_cas05_adjustment_reason_code,
							L2320_3_4_cas06_adjustment_amt,
							L2320_3_4_cas07_adjustment_qty,
							L2320_3_4_cas08_adjustment_reason_code,
							L2320_3_4_cas09_adjustment_amt,
							L2320_3_4_cas10_adjustment_qty,
							L2320_3_5_cas01_adjustment_group_code,
							L2320_3_5_cas02_adjustment_reason_code,
							L2320_3_5_cas03_adjustment_amt,
							L2320_3_5_cas04_adjustment_qty,
							L2320_3_5_cas05_adjustment_reason_code,
							L2320_3_5_cas06_adjustment_amt,
							L2320_3_5_cas07_adjustment_qty,
							L2320_3_5_cas08_adjustment_reason_code,
							L2320_3_5_cas09_adjustment_amt,
							L2320_3_5_cas10_adjustment_qty,
							L2320_3_amt02_D_payer_paid_amt,
							L2320_3_amt02_AAE_cob_approved_amt,
							L2320_3_amt02_B6_cob_allowed_amt,
							L2320_3_amt02_F2_patient_responsibility_amt,
							L2320_3_amt02_AU_cob_covered_amt,
							L2320_3_amt02_D8_discount_amt,
							L2320_3_amt02_F5_payer_patient_paid_amt,
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
							L2330A_3_n301_other_subscriber_address1,
							L2330A_3_n302_other_subscriber_address2,
							L2330A_3_n401_other_subscriber_city,
							L2330A_3_n402_other_subscriber_state,
							L2330A_3_n403_other_subscriber_zip,
							L2330A_3_n404_other_subscriber_country,
							L2330A_3_ref02_1W_other_subscriber_sup_id,
							L2330A_3_ref02_23_other_subscriber_sup_id,
							L2330A_3_ref02_IG_other_subscriber_sup_id,
							L2330A_3_ref02_SY_other_subscriber_sup_id,
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
							L2330B_3_ref02_T4_other_payer_claim_adj_ind,
							L2400_lx01_assigned_num,
							L2400_sv301_proc_code_qual,
							L2400_sv301_proc_code,
							L2400_sv301_proc_mod1,
							L2400_sv301_proc_mod2,
							L2400_sv301_proc_mod3,
							L2400_sv301_proc_mod4,
							L2400_sv302_line_charge,
							L2400_sv303_facility_type_code,
							L2400_sv304_oral_cavity_designation_code_1,
							L2400_sv304_oral_cavity_designation_code_2,
							L2400_sv304_oral_cavity_designation_code_3,
							L2400_sv304_oral_cavity_designation_code_4,
							L2400_sv304_oral_cavity_designation_code_5,
							L2400_sv305_prosthesis_crown_inlay_code,
							L2400_sv306_procedure_count,
							L2400_1_too02_JP_tooth_code,
							L2400_1_too03_tooth_surface_code_1,
							L2400_1_too03_tooth_surface_code_2,
							L2400_1_too03_tooth_surface_code_3,
							L2400_1_too03_tooth_surface_code_4,
							L2400_1_too03_tooth_surface_code_5,
							L2400_2_too02_JP_tooth_code,
							L2400_2_too03_tooth_surface_code_1,
							L2400_2_too03_tooth_surface_code_2,
							L2400_2_too03_tooth_surface_code_3,
							L2400_2_too03_tooth_surface_code_4,
							L2400_2_too03_tooth_surface_code_5,
							L2400_3_too02_JP_tooth_code,
							L2400_3_too03_tooth_surface_code_1,
							L2400_3_too03_tooth_surface_code_2,
							L2400_3_too03_tooth_surface_code_3,
							L2400_3_too03_tooth_surface_code_4,
							L2400_3_too03_tooth_surface_code_5,
							L2400_4_too02_JP_tooth_code,
							L2400_4_too03_tooth_surface_code_1,
							L2400_4_too03_tooth_surface_code_2,
							L2400_4_too03_tooth_surface_code_3,
							L2400_4_too03_tooth_surface_code_4,
							L2400_4_too03_tooth_surface_code_5,
							L2400_5_too02_JP_tooth_code,
							L2400_5_too03_tooth_surface_code_1,
							L2400_5_too03_tooth_surface_code_2,
							L2400_5_too03_tooth_surface_code_3,
							L2400_5_too03_tooth_surface_code_4,
							L2400_5_too03_tooth_surface_code_5,
							L2400_6_too02_JP_tooth_code,
							L2400_6_too03_tooth_surface_code_1,
							L2400_6_too03_tooth_surface_code_2,
							L2400_6_too03_tooth_surface_code_3,
							L2400_6_too03_tooth_surface_code_4,
							L2400_6_too03_tooth_surface_code_5,
							L2400_7_too02_JP_tooth_code,
							L2400_7_too03_tooth_surface_code_1,
							L2400_7_too03_tooth_surface_code_2,
							L2400_7_too03_tooth_surface_code_3,
							L2400_7_too03_tooth_surface_code_4,
							L2400_7_too03_tooth_surface_code_5,
							L2400_8_too02_JP_tooth_code,
							L2400_8_too03_tooth_surface_code_1,
							L2400_8_too03_tooth_surface_code_2,
							L2400_8_too03_tooth_surface_code_3,
							L2400_8_too03_tooth_surface_code_4,
							L2400_8_too03_tooth_surface_code_5,
							L2400_9_too02_JP_tooth_code,
							L2400_9_too03_tooth_surface_code_1,
							L2400_9_too03_tooth_surface_code_2,
							L2400_9_too03_tooth_surface_code_3,
							L2400_9_too03_tooth_surface_code_4,
							L2400_9_too03_tooth_surface_code_5,
							L2400_10_too02_JP_tooth_code,
							L2400_10_too03_tooth_surface_code_1,
							L2400_10_too03_tooth_surface_code_2,
							L2400_10_too03_tooth_surface_code_3,
							L2400_10_too03_tooth_surface_code_4,
							L2400_10_too03_tooth_surface_code_5,
							L2400_11_too02_JP_tooth_code,
							L2400_11_too03_tooth_surface_code_1,
							L2400_11_too03_tooth_surface_code_2,
							L2400_11_too03_tooth_surface_code_3,
							L2400_11_too03_tooth_surface_code_4,
							L2400_11_too03_tooth_surface_code_5,
							L2400_12_too02_JP_tooth_code,
							L2400_12_too03_tooth_surface_code_1,
							L2400_12_too03_tooth_surface_code_2,
							L2400_12_too03_tooth_surface_code_3,
							L2400_12_too03_tooth_surface_code_4,
							L2400_12_too03_tooth_surface_code_5,
							L2400_13_too02_JP_tooth_code,
							L2400_13_too03_tooth_surface_code_1,
							L2400_13_too03_tooth_surface_code_2,
							L2400_13_too03_tooth_surface_code_3,
							L2400_13_too03_tooth_surface_code_4,
							L2400_13_too03_tooth_surface_code_5,
							L2400_14_too02_JP_tooth_code,
							L2400_14_too03_tooth_surface_code_1,
							L2400_14_too03_tooth_surface_code_2,
							L2400_14_too03_tooth_surface_code_3,
							L2400_14_too03_tooth_surface_code_4,
							L2400_14_too03_tooth_surface_code_5,
							L2400_15_too02_JP_tooth_code,
							L2400_15_too03_tooth_surface_code_1,
							L2400_15_too03_tooth_surface_code_2,
							L2400_15_too03_tooth_surface_code_3,
							L2400_15_too03_tooth_surface_code_4,
							L2400_15_too03_tooth_surface_code_5,
							L2400_16_too02_JP_tooth_code,
							L2400_16_too03_tooth_surface_code_1,
							L2400_16_too03_tooth_surface_code_2,
							L2400_16_too03_tooth_surface_code_3,
							L2400_16_too03_tooth_surface_code_4,
							L2400_16_too03_tooth_surface_code_5,
							L2400_17_too02_JP_tooth_code,
							L2400_17_too03_tooth_surface_code_1,
							L2400_17_too03_tooth_surface_code_2,
							L2400_17_too03_tooth_surface_code_3,
							L2400_17_too03_tooth_surface_code_4,
							L2400_17_too03_tooth_surface_code_5,
							L2400_18_too02_JP_tooth_code,
							L2400_18_too03_tooth_surface_code_1,
							L2400_18_too03_tooth_surface_code_2,
							L2400_18_too03_tooth_surface_code_3,
							L2400_18_too03_tooth_surface_code_4,
							L2400_18_too03_tooth_surface_code_5,
							L2400_19_too02_JP_tooth_code,
							L2400_19_too03_tooth_surface_code_1,
							L2400_19_too03_tooth_surface_code_2,
							L2400_19_too03_tooth_surface_code_3,
							L2400_19_too03_tooth_surface_code_4,
							L2400_19_too03_tooth_surface_code_5,
							L2400_20_too02_JP_tooth_code,
							L2400_20_too03_tooth_surface_code_1,
							L2400_20_too03_tooth_surface_code_2,
							L2400_20_too03_tooth_surface_code_3,
							L2400_20_too03_tooth_surface_code_4,
							L2400_20_too03_tooth_surface_code_5,
							L2400_21_too02_JP_tooth_code,
							L2400_21_too03_tooth_surface_code_1,
							L2400_21_too03_tooth_surface_code_2,
							L2400_21_too03_tooth_surface_code_3,
							L2400_21_too03_tooth_surface_code_4,
							L2400_21_too03_tooth_surface_code_5,
							L2400_22_too02_JP_tooth_code,
							L2400_22_too03_tooth_surface_code_1,
							L2400_22_too03_tooth_surface_code_2,
							L2400_22_too03_tooth_surface_code_3,
							L2400_22_too03_tooth_surface_code_4,
							L2400_22_too03_tooth_surface_code_5,
							L2400_23_too02_JP_tooth_code,
							L2400_23_too03_tooth_surface_code_1,
							L2400_23_too03_tooth_surface_code_2,
							L2400_23_too03_tooth_surface_code_3,
							L2400_23_too03_tooth_surface_code_4,
							L2400_23_too03_tooth_surface_code_5,
							L2400_24_too02_JP_tooth_code,
							L2400_24_too03_tooth_surface_code_1,
							L2400_24_too03_tooth_surface_code_2,
							L2400_24_too03_tooth_surface_code_3,
							L2400_24_too03_tooth_surface_code_4,
							L2400_24_too03_tooth_surface_code_5,
							L2400_25_too02_JP_tooth_code,
							L2400_25_too03_tooth_surface_code_1,
							L2400_25_too03_tooth_surface_code_2,
							L2400_25_too03_tooth_surface_code_3,
							L2400_25_too03_tooth_surface_code_4,
							L2400_25_too03_tooth_surface_code_5,
							L2400_26_too02_JP_tooth_code,
							L2400_26_too03_tooth_surface_code_1,
							L2400_26_too03_tooth_surface_code_2,
							L2400_26_too03_tooth_surface_code_3,
							L2400_26_too03_tooth_surface_code_4,
							L2400_26_too03_tooth_surface_code_5,
							L2400_27_too02_JP_tooth_code,
							L2400_27_too03_tooth_surface_code_1,
							L2400_27_too03_tooth_surface_code_2,
							L2400_27_too03_tooth_surface_code_3,
							L2400_27_too03_tooth_surface_code_4,
							L2400_27_too03_tooth_surface_code_5,
							L2400_28_too02_JP_tooth_code,
							L2400_28_too03_tooth_surface_code_1,
							L2400_28_too03_tooth_surface_code_2,
							L2400_28_too03_tooth_surface_code_3,
							L2400_28_too03_tooth_surface_code_4,
							L2400_28_too03_tooth_surface_code_5,
							L2400_29_too02_JP_tooth_code,
							L2400_29_too03_tooth_surface_code_1,
							L2400_29_too03_tooth_surface_code_2,
							L2400_29_too03_tooth_surface_code_3,
							L2400_29_too03_tooth_surface_code_4,
							L2400_29_too03_tooth_surface_code_5,
							L2400_30_too02_JP_tooth_code,
							L2400_30_too03_tooth_surface_code_1,
							L2400_30_too03_tooth_surface_code_2,
							L2400_30_too03_tooth_surface_code_3,
							L2400_30_too03_tooth_surface_code_4,
							L2400_30_too03_tooth_surface_code_5,
							L2400_31_too02_JP_tooth_code,
							L2400_31_too03_tooth_surface_code_1,
							L2400_31_too03_tooth_surface_code_2,
							L2400_31_too03_tooth_surface_code_3,
							L2400_31_too03_tooth_surface_code_4,
							L2400_31_too03_tooth_surface_code_5,
							L2400_32_too02_JP_tooth_code,
							L2400_32_too03_tooth_surface_code_1,
							L2400_32_too03_tooth_surface_code_2,
							L2400_32_too03_tooth_surface_code_3,
							L2400_32_too03_tooth_surface_code_4,
							L2400_32_too03_tooth_surface_code_5,
							L2400_dtp02_472_service_date,
							L2400_dtp02_441_prior_placement_date,
							L2400_dtp02_452_orthodontic_banding_date,
							L2400_dtp02_446_replacement_date,
							L2400_1_qty01_qty_qual,
							L2400_1_qty02_anesthesia_unit_count,
							L2400_2_qty01_qty_qual,
							L2400_2_qty02_anesthesia_unit_count,
							L2400_3_qty01_qty_qual,
							L2400_3_qty02_anesthesia_unit_count,
							L2400_4_qty01_qty_qual,
							L2400_4_qty02_anesthesia_unit_count,
							L2400_5_qty01_qty_qual,
							L2400_5_qty02_anesthesia_unit_count,
							L2400_ref02_G3_predetermination_of_benefits_id,
							L2400_ref02_9F_referral_number,
							L2400_ref02_G1_prior_auth_number,
							L2400_ref02_6R_line_item_control_num,
							L2400_amt02_AAE_approved_amt,
							L2400_amt02_T_sales_tax_amt,
							L2400_nte01_note_ref_code,
							L2400_nte02_line_note_text,
							L2420A_nm102_entity_type_qual,
							L2420A_nm103_rendering_prov_last_nm,
							L2420A_nm104_rendering_prov_first_nm,
							L2420A_nm105_rendering_prov_middle_nm,
							L2420A_nm107_rendering_prov_suffix,
							L2420A_nm108_id_code_qual,
							L2420A_nm109_rendering_prov_id,
							L2420A_prv01_provider_code,
							L2420A_prv02_ref_id_qual,
							L2420A_prv03_taxonomy_code,
							L2420A_ref02_1C_rendering_prov_id,
							L2420A_ref02_1D_rendering_prov_id,
							L2420A_ref02_1E_rendering_prov_id,
							L2420A_ref02_EI_rendering_prov_id,
							L2420A_ref02_SY_rendering_prov_id,
							L2420A_ref02_TJ_rendering_prov_id,
							L2420B_nm102_entity_type_qual,
							L2420B_nm103_payer_last_nm,
							L2420B_nm108_id_code_qual,
							L2420B_nm109_other_payer_id,
							L2420B_ref02_9F_referral_number,
							L2420B_ref02_G1_prior_auth_number,
							L2420C_nm101_entity_id_code,
							L2420C_nm102_entity_type_qual,
							L2420C_nm103_assistant_surgeon_last_nm,
							L2420C_nm104_assistant_surgeon_first_nm,
							L2420C_nm105_assistant_surgeon_middle_nm,
							L2420C_nm107_assistant_surgeon_suffix,
							L2420C_nm108_id_code_qual,
							L2420C_nm109_assistant_surgeon_id,
							L2420C_prv01_provider_code,
							L2420C_prv02_ref_id_qual,
							L2420C_prv03_taxonomy_code,
							L2420C_ref02_1C_service_facility_id,
							L2420C_ref02_1D_service_facility_id,
							L2420C_ref02_1E_service_facility_id,
							L2420C_ref02_G2_service_facility_id,
							L2420C_ref02_TJ_service_facility_id,
							L2430_svd01_other_payer_id,
							L2430_svd02_service_line_paid,
							L2430_svd03_service_id_qual,
							L2430_svd03_proc_code,
							L2430_svd03_proc_mod1,
							L2430_svd03_proc_mod2,
							L2430_svd03_proc_mod3,
							L2430_svd03_proc_mod4,
							L2430_svd03_proc_code_desc,
							L2430_svd05_paid_service_unit,
							L2430_svd06_bundled_unbundled_line_num,
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
							L2430_dtp03_573_date_claim_paid
						)
				values
				(	@x12_transaction_id,
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
					@L2010AA_ref02_1C_billing_prov_id,
					@L2010AA_ref02_1D_billing_prov_id,
					@L2010AA_ref02_1E_billing_prov_id,
					@L2010AA_ref02_EI_billing_prov_id,
					@L2010AA_ref02_SY_billing_prov_id,
					@L2010AA_ref02_TJ_billing_prov_id,
					@L2010AA_ref02_06_card_billing_id,
					@L2010AA_ref02_8U_card_billing_id,
					@L2010AA_ref02_EM_card_billing_id,
					@L2010AA_ref02_IJ_card_billing_id,
					@L2010AA_ref02_LU_card_billing_id,
					@L2010AA_ref02_ST_card_billing_id,
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
					@L2010AB_ref02_1E_payto_prov_id,
					@L2010AB_ref02_EI_payto_prov_id,
					@L2010AB_ref02_SY_payto_prov_id,
					@L2010AB_ref02_TJ_payto_prov_id,
					@L2000B_hl01_hierarchical_id_num,
					@L2000B_hl02_hierarchical_parent_id_num,
					@L2000B_hl03_hierarchical_level_code,
					@L2000B_hl04_hierarchical_child_code,
					@L2000B_sbr01_payer_resp_seq_code,
					@L2000B_sbr02_ind_relationship_code,
					@L2000B_sbr03_insured_grp_policy_num,
					@L2000B_sbr04_insured_grp_nm,
					@L2000B_sbr06_cob_code,
					@L2000B_sbr09_claim_filing_ind_code,
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
					@L2010BB_nm103_payer_nm,
					@L2010BB_nm108_payer_id_qual,
					@L2010BB_nm109_payer_id,
					@L2010BB_n301_payer_address1,
					@L2010BB_n302_payer_address2,
					@L2010BB_n401_payer_city,
					@L2010BB_n402_payer_state,
					@L2010BB_n403_payer_zip,
					@L2010BB_n404_payer_country,
					@L2010BB_ref02_2U_payer_id,
					@L2010BB_ref02_FY_payer_id,
					@L2010BB_ref02_NF_payer_id,
					@L2010BB_ref02_TJ_payer_id,
					@L2010BC_nm102_entity_type_qual,
					@L2010BC_nm103_resp_party_last_nm,
					@L2010BC_nm104_resp_party_first_nm,
					@L2010BC_nm105_resp_party_middle_nm,
					@L2010BC_nm107_resp_party_suffix,
					@L2010BC_nm109_MI_card_num,
					@L2010BC_ref02_BB_card_num,
					@L2000C_hl01_hierarchical_id_num,
					@L2000C_hl02_hierarchical_parent_id_num,
					@L2000C_hl03_hierarchical_level_code,
					@L2000C_hl04_hierarchical_child_code,
					@L2000C_pat01_ind_relationship_code,
					@L2000C_pat04_student_status_code,
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
					@L2300_clm05_claim_freq_code,
					@L2300_clm06_provider_signature_ind,
					@L2300_clm07_medicare_assign_code,
					@L2300_clm08_benefit_assign_ind,
					@L2300_clm09_release_of_info_code,
					@L2300_clm11_related_causes_code1,
					@L2300_clm11_related_causes_code2,
					@L2300_clm11_related_causes_code3,
					@L2300_clm11_auto_accident_state_code,
					@L2300_clm11_country_code,
					@L2300_clm12_special_prog_ind,
					@L2300_clm19_claim_submission_reason_code,
					@L2300_clm20_delay_reason_code,
					@L2300_dtp03_435_related_hospitalization_admission_date,
					@L2300_dtp03_096_discharge_end_of_care_date,
					@L2300_dtp03_330_referral_date,
					@L2300_dtp03_439_accident_date,
					@L2300_dtp03_452_orthodontic_banding_date,
					@L2300_dtp03_472_service_date,
					@L2300_dn101_orthodontic_treatment_months_count,
					@L2300_dn102_orthodontic_treatment_months_remaining_count,
					@L2300_dn103_question_response,
					@L2300_1_dn201_tooth_number,
					@L2300_1_dn202_tooth_status_code,
					@L2300_2_dn201_tooth_number,
					@L2300_2_dn202_tooth_status_code,
					@L2300_3_dn201_tooth_number,
					@L2300_3_dn202_tooth_status_code,
					@L2300_4_dn201_tooth_number,
					@L2300_4_dn202_tooth_status_code,
					@L2300_5_dn201_tooth_number,
					@L2300_5_dn202_tooth_status_code,
					@L2300_6_dn201_tooth_number,
					@L2300_6_dn202_tooth_status_code,
					@L2300_7_dn201_tooth_number,
					@L2300_7_dn202_tooth_status_code,
					@L2300_8_dn201_tooth_number,
					@L2300_8_dn202_tooth_status_code,
					@L2300_9_dn201_tooth_number,
					@L2300_9_dn202_tooth_status_code,
					@L2300_10_dn201_tooth_number,
					@L2300_10_dn202_tooth_status_code,
					@L2300_11_dn201_tooth_number,
					@L2300_11_dn202_tooth_status_code,
					@L2300_12_dn201_tooth_number,
					@L2300_12_dn202_tooth_status_code,
					@L2300_13_dn201_tooth_number,
					@L2300_13_dn202_tooth_status_code,
					@L2300_14_dn201_tooth_number,
					@L2300_14_dn202_tooth_status_code,
					@L2300_15_dn201_tooth_number,
					@L2300_15_dn202_tooth_status_code,
					@L2300_16_dn201_tooth_number,
					@L2300_16_dn202_tooth_status_code,
					@L2300_17_dn201_tooth_number,
					@L2300_17_dn202_tooth_status_code,
					@L2300_18_dn201_tooth_number,
					@L2300_18_dn202_tooth_status_code,
					@L2300_19_dn201_tooth_number,
					@L2300_19_dn202_tooth_status_code,
					@L2300_20_dn201_tooth_number,
					@L2300_20_dn202_tooth_status_code,
					@L2300_21_dn201_tooth_number,
					@L2300_21_dn202_tooth_status_code,
					@L2300_22_dn201_tooth_number,
					@L2300_22_dn202_tooth_status_code,
					@L2300_23_dn201_tooth_number,
					@L2300_23_dn202_tooth_status_code,
					@L2300_24_dn201_tooth_number,
					@L2300_24_dn202_tooth_status_code,
					@L2300_25_dn201_tooth_number,
					@L2300_25_dn202_tooth_status_code,
					@L2300_26_dn201_tooth_number,
					@L2300_26_dn202_tooth_status_code,
					@L2300_27_dn201_tooth_number,
					@L2300_27_dn202_tooth_status_code,
					@L2300_28_dn201_tooth_number,
					@L2300_28_dn202_tooth_status_code,
					@L2300_29_dn201_tooth_number,
					@L2300_29_dn202_tooth_status_code,
					@L2300_30_dn201_tooth_number,
					@L2300_30_dn202_tooth_status_code,
					@L2300_31_dn201_tooth_number,
					@L2300_31_dn202_tooth_status_code,
					@L2300_32_dn201_tooth_number,
					@L2300_32_dn202_tooth_status_code,
					@L2300_33_dn201_tooth_number,
					@L2300_33_dn202_tooth_status_code,
					@L2300_34_dn201_tooth_number,
					@L2300_34_dn202_tooth_status_code,
					@L2300_35_dn201_tooth_number,
					@L2300_35_dn202_tooth_status_code,
					@L2300_pwk01_attachment_type_code,
					@L2300_pwk02_attachment_trans_code,
					@L2300_pwk06_attachment_control_num,
					@L2300_amt02_patient_paid_amt,
					@L2300_amt02_card_maximum_amt,
					@L2300_ref02_G3_predetermination_id,
					@L2300_ref02_4N_service_auth_exception_code,
					@L2300_ref02_F8_original_ref_num,
					@L2300_ref02_9F_referral_num,
					@L2300_ref02_G1_prior_auth_num,
					@L2300_ref02_D9_value_added_network_trace_num,
					@L2300_nte01_note_ref_code,
					@L2300_nte02_claim_note_text,
					@L2310A_nm101_entity_id_code,
					@L2310A_nm102_entity_type_qual,
					@L2310A_nm103_referring_prov_last_nm,
					@L2310A_nm104_referring_prov_first_nm,
					@L2310A_nm105_referring_prov_middle_nm,
					@L2310A_nm107_referring_prov_suffix,
					@L2310A_nm108_id_code_qual,
					@L2310A_nm109_referring_prov_id,
					@L2310A_prv01_provider_code,
					@L2310A_prv02_ref_id_qual,
					@L2310A_prv03_taxonomy_code,
					@L2310A_ref02_1C_referring_prov_id,
					@L2310A_ref02_1D_referring_prov_id,
					@L2310A_ref02_1E_referring_prov_id,
					@L2310A_ref02_EI_referring_prov_id,
					@L2310A_ref02_G2_referring_prov_id,
					@L2310A_ref02_SY_referring_prov_id,
					@L2310A_ref02_TJ_referring_prov_id,
					@L2310B_nm102_entity_type_qual,
					@L2310B_nm103_rendering_prov_last_nm,
					@L2310B_nm104_rendering_prov_first_nm,
					@L2310B_nm105_rendering_prov_middle_nm,
					@L2310B_nm107_rendering_prov_suffix,
					@L2310B_nm108_id_code_qual,
					@L2310B_nm109_rendering_prov_id,
					@L2310B_prv01_provider_code,
					@L2310B_prv02_ref_id_qual,
					@L2310B_prv03_taxonomy_code,
					@L2310B_ref02_1C_rendering_prov_id,
					@L2310B_ref02_1D_rendering_prov_id,
					@L2310B_ref02_1E_rendering_prov_id,
					@L2310B_ref02_EI_rendering_prov_id,
					@L2310B_ref02_G2_rendering_prov_id,
					@L2310B_ref02_SY_rendering_prov_id,
					@L2310B_ref02_TJ_rendering_prov_id,
					@L2310C_nm102_entity_type_qual,
					@L2310C_nm103_service_facility_last_nm,
					@L2310C_nm108_id_code_qual,
					@L2310C_nm109_service_facility_id,
					@L2310C_ref02_1C_lab_or_facility_prov_id,
					@L2310C_ref02_1D_lab_or_facility_prov_id,
					@L2310C_ref02_1G_lab_or_facility_prov_id,
					@L2310C_ref02_G2_lab_or_facility_prov_id,
					@L2310C_ref02_TJ_lab_or_facility_prov_id,
					@L2310D_nm102_entity_type_qual,
					@L2310D_nm103_assistant_surgeon_last_nm,
					@L2310D_nm104_assistant_surgeon_first_nm,
					@L2310D_nm105_assistant_surgeon_middle_nm,
					@L2310D_nm107_assistant_surgeon_suffix,
					@L2310D_nm108_id_code_qual,
					@L2310D_nm109_assistant_surgeon_prov_id,
					@L2310D_prv01_provider_code,
					@L2310D_prv02_id_code_qual,
					@L2310D_prv03_taxonomy_code,
					@L2310D_ref02_1C_service_facility_id,
					@L2310D_ref02_1D_service_facility_id,
					@L2310D_ref02_1E_service_facility_id,
					@L2310D_ref02_G2_service_facility_id,
					@L2310D_ref02_TJ_service_facility_id,
					@L2320_1_sbr01_payer_resp_seq_code,
					@L2320_1_sbr02_ind_relationship_code,
					@L2320_1_sbr03_insured_grp_policy_num,
					@L2320_1_sbr04_insured_grp_nm,
					@L2320_1_sbr09_claim_file_ind_code,
					@L2320_1_1_cas01_adjustment_group_code,
					@L2320_1_1_cas02_adjustment_reason_code,
					@L2320_1_1_cas03_adjustment_amt,
					@L2320_1_1_cas04_adjustment_qty,
					@L2320_1_1_cas05_adjustment_reason_code,
					@L2320_1_1_cas06_adjustment_amt,
					@L2320_1_1_cas07_adjustment_qty,
					@L2320_1_1_cas08_adjustment_reason_code,
					@L2320_1_1_cas09_adjustment_amt,
					@L2320_1_1_cas10_adjustment_qty,
					@L2320_1_2_cas01_adjustment_group_code,
					@L2320_1_2_cas02_adjustment_reason_code,
					@L2320_1_2_cas03_adjustment_amt,
					@L2320_1_2_cas04_adjustment_qty,
					@L2320_1_2_cas05_adjustment_reason_code,
					@L2320_1_2_cas06_adjustment_amt,
					@L2320_1_2_cas07_adjustment_qty,
					@L2320_1_2_cas08_adjustment_reason_code,
					@L2320_1_2_cas09_adjustment_amt,
					@L2320_1_2_cas10_adjustment_qty,
					@L2320_1_3_cas01_adjustment_group_code,
					@L2320_1_3_cas02_adjustment_reason_code,
					@L2320_1_3_cas03_adjustment_amt,
					@L2320_1_3_cas04_adjustment_qty,
					@L2320_1_3_cas05_adjustment_reason_code,
					@L2320_1_3_cas06_adjustment_amt,
					@L2320_1_3_cas07_adjustment_qty,
					@L2320_1_3_cas08_adjustment_reason_code,
					@L2320_1_3_cas09_adjustment_amt,
					@L2320_1_3_cas10_adjustment_qty,
					@L2320_1_4_cas01_adjustment_group_code,
					@L2320_1_4_cas02_adjustment_reason_code,
					@L2320_1_4_cas03_adjustment_amt,
					@L2320_1_4_cas04_adjustment_qty,
					@L2320_1_4_cas05_adjustment_reason_code,
					@L2320_1_4_cas06_adjustment_amt,
					@L2320_1_4_cas07_adjustment_qty,
					@L2320_1_4_cas08_adjustment_reason_code,
					@L2320_1_4_cas09_adjustment_amt,
					@L2320_1_4_cas10_adjustment_qty,
					@L2320_1_5_cas01_adjustment_group_code,
					@L2320_1_5_cas02_adjustment_reason_code,
					@L2320_1_5_cas03_adjustment_amt,
					@L2320_1_5_cas04_adjustment_qty,
					@L2320_1_5_cas05_adjustment_reason_code,
					@L2320_1_5_cas06_adjustment_amt,
					@L2320_1_5_cas07_adjustment_qty,
					@L2320_1_5_cas08_adjustment_reason_code,
					@L2320_1_5_cas09_adjustment_amt,
					@L2320_1_5_cas10_adjustment_qty,
					@L2320_1_amt02_D_payer_paid_amt,
					@L2320_1_amt02_AAE_cob_approved_amt,
					@L2320_1_amt02_B6_cob_allowed_amt,
					@L2320_1_amt02_F2_patient_responsibility_amt,
					@L2320_1_amt02_AU_cob_covered_amt,
					@L2320_1_amt02_D8_discount_amt,
					@L2320_1_amt02_F5_payer_patient_paid_amt,
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
					@L2330A_1_n301_other_subscriber_address1,
					@L2330A_1_n302_other_subscriber_address2,
					@L2330A_1_n401_other_subscriber_city,
					@L2330A_1_n402_other_subscriber_state,
					@L2330A_1_n403_other_subscriber_zip,
					@L2330A_1_n404_other_subscriber_country,
					@L2330A_1_ref02_1W_other_subscriber_sup_id,
					@L2330A_1_ref02_23_other_subscriber_sup_id,
					@L2330A_1_ref02_IG_other_subscriber_sup_id,
					@L2330A_1_ref02_SY_other_subscriber_sup_id,
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
					@L2330B_1_ref02_T4_other_payer_claim_adj_ind,
					@L2320_2_sbr01_payer_resp_seq_code,
					@L2320_2_sbr02_ind_relationship_code,
					@L2320_2_sbr03_insured_grp_policy_num,
					@L2320_2_sbr04_insured_grp_nm,
					@L2320_2_sbr09_claim_file_ind_code,
					@L2320_2_1_cas01_adjustment_group_code,
					@L2320_2_1_cas02_adjustment_reason_code,
					@L2320_2_1_cas03_adjustment_amt,
					@L2320_2_1_cas04_adjustment_qty,
					@L2320_2_1_cas05_adjustment_reason_code,
					@L2320_2_1_cas06_adjustment_amt,
					@L2320_2_1_cas07_adjustment_qty,
					@L2320_2_1_cas08_adjustment_reason_code,
					@L2320_2_1_cas09_adjustment_amt,
					@L2320_2_1_cas10_adjustment_qty,
					@L2320_2_2_cas01_adjustment_group_code,
					@L2320_2_2_cas02_adjustment_reason_code,
					@L2320_2_2_cas03_adjustment_amt,
					@L2320_2_2_cas04_adjustment_qty,
					@L2320_2_2_cas05_adjustment_reason_code,
					@L2320_2_2_cas06_adjustment_amt,
					@L2320_2_2_cas07_adjustment_qty,
					@L2320_2_2_cas08_adjustment_reason_code,
					@L2320_2_2_cas09_adjustment_amt,
					@L2320_2_2_cas10_adjustment_qty,
					@L2320_2_3_cas01_adjustment_group_code,
					@L2320_2_3_cas02_adjustment_reason_code,
					@L2320_2_3_cas03_adjustment_amt,
					@L2320_2_3_cas04_adjustment_qty,
					@L2320_2_3_cas05_adjustment_reason_code,
					@L2320_2_3_cas06_adjustment_amt,
					@L2320_2_3_cas07_adjustment_qty,
					@L2320_2_3_cas08_adjustment_reason_code,
					@L2320_2_3_cas09_adjustment_amt,
					@L2320_2_3_cas10_adjustment_qty,
					@L2320_2_4_cas01_adjustment_group_code,
					@L2320_2_4_cas02_adjustment_reason_code,
					@L2320_2_4_cas03_adjustment_amt,
					@L2320_2_4_cas04_adjustment_qty,
					@L2320_2_4_cas05_adjustment_reason_code,
					@L2320_2_4_cas06_adjustment_amt,
					@L2320_2_4_cas07_adjustment_qty,
					@L2320_2_4_cas08_adjustment_reason_code,
					@L2320_2_4_cas09_adjustment_amt,
					@L2320_2_4_cas10_adjustment_qty,
					@L2320_2_5_cas01_adjustment_group_code,
					@L2320_2_5_cas02_adjustment_reason_code,
					@L2320_2_5_cas03_adjustment_amt,
					@L2320_2_5_cas04_adjustment_qty,
					@L2320_2_5_cas05_adjustment_reason_code,
					@L2320_2_5_cas06_adjustment_amt,
					@L2320_2_5_cas07_adjustment_qty,
					@L2320_2_5_cas08_adjustment_reason_code,
					@L2320_2_5_cas09_adjustment_amt,
					@L2320_2_5_cas10_adjustment_qty,
					@L2320_2_amt02_D_payer_paid_amt,
					@L2320_2_amt02_AAE_cob_approved_amt,
					@L2320_2_amt02_B6_cob_allowed_amt,
					@L2320_2_amt02_F2_patient_responsibility_amt,
					@L2320_2_amt02_AU_cob_covered_amt,
					@L2320_2_amt02_D8_discount_amt,
					@L2320_2_amt02_F5_payer_patient_paid_amt,
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
					@L2330A_2_n301_other_subscriber_address1,
					@L2330A_2_n302_other_subscriber_address2,
					@L2330A_2_n401_other_subscriber_city,
					@L2330A_2_n402_other_subscriber_state,
					@L2330A_2_n403_other_subscriber_zip,
					@L2330A_2_n404_other_subscriber_country,
					@L2330A_2_ref02_1W_other_subscriber_sup_id,
					@L2330A_2_ref02_23_other_subscriber_sup_id,
					@L2330A_2_ref02_IG_other_subscriber_sup_id,
					@L2330A_2_ref02_SY_other_subscriber_sup_id,
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
					@L2330B_2_ref02_T4_other_payer_claim_adj_ind,
					@L2320_3_sbr01_payer_resp_seq_code,
					@L2320_3_sbr02_ind_relationship_code,
					@L2320_3_sbr03_insured_grp_policy_num,
					@L2320_3_sbr04_insured_grp_nm,
					@L2320_3_sbr09_claim_file_ind_code,
					@L2320_3_1_cas01_adjustment_group_code,
					@L2320_3_1_cas02_adjustment_reason_code,
					@L2320_3_1_cas03_adjustment_amt,
					@L2320_3_1_cas04_adjustment_qty,
					@L2320_3_1_cas05_adjustment_reason_code,
					@L2320_3_1_cas06_adjustment_amt,
					@L2320_3_1_cas07_adjustment_qty,
					@L2320_3_1_cas08_adjustment_reason_code,
					@L2320_3_1_cas09_adjustment_amt,
					@L2320_3_1_cas10_adjustment_qty,
					@L2320_3_2_cas01_adjustment_group_code,
					@L2320_3_2_cas02_adjustment_reason_code,
					@L2320_3_2_cas03_adjustment_amt,
					@L2320_3_2_cas04_adjustment_qty,
					@L2320_3_2_cas05_adjustment_reason_code,
					@L2320_3_2_cas06_adjustment_amt,
					@L2320_3_2_cas07_adjustment_qty,
					@L2320_3_2_cas08_adjustment_reason_code,
					@L2320_3_2_cas09_adjustment_amt,
					@L2320_3_2_cas10_adjustment_qty,
					@L2320_3_3_cas01_adjustment_group_code,
					@L2320_3_3_cas02_adjustment_reason_code,
					@L2320_3_3_cas03_adjustment_amt,
					@L2320_3_3_cas04_adjustment_qty,
					@L2320_3_3_cas05_adjustment_reason_code,
					@L2320_3_3_cas06_adjustment_amt,
					@L2320_3_3_cas07_adjustment_qty,
					@L2320_3_3_cas08_adjustment_reason_code,
					@L2320_3_3_cas09_adjustment_amt,
					@L2320_3_3_cas10_adjustment_qty,
					@L2320_3_4_cas01_adjustment_group_code,
					@L2320_3_4_cas02_adjustment_reason_code,
					@L2320_3_4_cas03_adjustment_amt,
					@L2320_3_4_cas04_adjustment_qty,
					@L2320_3_4_cas05_adjustment_reason_code,
					@L2320_3_4_cas06_adjustment_amt,
					@L2320_3_4_cas07_adjustment_qty,
					@L2320_3_4_cas08_adjustment_reason_code,
					@L2320_3_4_cas09_adjustment_amt,
					@L2320_3_4_cas10_adjustment_qty,
					@L2320_3_5_cas01_adjustment_group_code,
					@L2320_3_5_cas02_adjustment_reason_code,
					@L2320_3_5_cas03_adjustment_amt,
					@L2320_3_5_cas04_adjustment_qty,
					@L2320_3_5_cas05_adjustment_reason_code,
					@L2320_3_5_cas06_adjustment_amt,
					@L2320_3_5_cas07_adjustment_qty,
					@L2320_3_5_cas08_adjustment_reason_code,
					@L2320_3_5_cas09_adjustment_amt,
					@L2320_3_5_cas10_adjustment_qty,
					@L2320_3_amt02_D_payer_paid_amt,
					@L2320_3_amt02_AAE_cob_approved_amt,
					@L2320_3_amt02_B6_cob_allowed_amt,
					@L2320_3_amt02_F2_patient_responsibility_amt,
					@L2320_3_amt02_AU_cob_covered_amt,
					@L2320_3_amt02_D8_discount_amt,
					@L2320_3_amt02_F5_payer_patient_paid_amt,
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
					@L2330A_3_n301_other_subscriber_address1,
					@L2330A_3_n302_other_subscriber_address2,
					@L2330A_3_n401_other_subscriber_city,
					@L2330A_3_n402_other_subscriber_state,
					@L2330A_3_n403_other_subscriber_zip,
					@L2330A_3_n404_other_subscriber_country,
					@L2330A_3_ref02_1W_other_subscriber_sup_id,
					@L2330A_3_ref02_23_other_subscriber_sup_id,
					@L2330A_3_ref02_IG_other_subscriber_sup_id,
					@L2330A_3_ref02_SY_other_subscriber_sup_id,
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
					@L2330B_3_ref02_T4_other_payer_claim_adj_ind,
					@L2400_lx01_assigned_num,
					@L2400_sv301_proc_code_qual,
					@L2400_sv301_proc_code,
					@L2400_sv301_proc_mod1,
					@L2400_sv301_proc_mod2,
					@L2400_sv301_proc_mod3,
					@L2400_sv301_proc_mod4,
					@L2400_sv302_line_charge,
					@L2400_sv303_facility_type_code,
					@L2400_sv304_oral_cavity_designation_code_1,
					@L2400_sv304_oral_cavity_designation_code_2,
					@L2400_sv304_oral_cavity_designation_code_3,
					@L2400_sv304_oral_cavity_designation_code_4,
					@L2400_sv304_oral_cavity_designation_code_5,
					@L2400_sv305_prosthesis_crown_inlay_code,
					@L2400_sv306_procedure_count,
					@L2400_1_too02_JP_tooth_code,
					@L2400_1_too03_tooth_surface_code_1,
					@L2400_1_too03_tooth_surface_code_2,
					@L2400_1_too03_tooth_surface_code_3,
					@L2400_1_too03_tooth_surface_code_4,
					@L2400_1_too03_tooth_surface_code_5,
					@L2400_2_too02_JP_tooth_code,
					@L2400_2_too03_tooth_surface_code_1,
					@L2400_2_too03_tooth_surface_code_2,
					@L2400_2_too03_tooth_surface_code_3,
					@L2400_2_too03_tooth_surface_code_4,
					@L2400_2_too03_tooth_surface_code_5,
					@L2400_3_too02_JP_tooth_code,
					@L2400_3_too03_tooth_surface_code_1,
					@L2400_3_too03_tooth_surface_code_2,
					@L2400_3_too03_tooth_surface_code_3,
					@L2400_3_too03_tooth_surface_code_4,
					@L2400_3_too03_tooth_surface_code_5,
					@L2400_4_too02_JP_tooth_code,
					@L2400_4_too03_tooth_surface_code_1,
					@L2400_4_too03_tooth_surface_code_2,
					@L2400_4_too03_tooth_surface_code_3,
					@L2400_4_too03_tooth_surface_code_4,
					@L2400_4_too03_tooth_surface_code_5,
					@L2400_5_too02_JP_tooth_code,
					@L2400_5_too03_tooth_surface_code_1,
					@L2400_5_too03_tooth_surface_code_2,
					@L2400_5_too03_tooth_surface_code_3,
					@L2400_5_too03_tooth_surface_code_4,
					@L2400_5_too03_tooth_surface_code_5,
					@L2400_6_too02_JP_tooth_code,
					@L2400_6_too03_tooth_surface_code_1,
					@L2400_6_too03_tooth_surface_code_2,
					@L2400_6_too03_tooth_surface_code_3,
					@L2400_6_too03_tooth_surface_code_4,
					@L2400_6_too03_tooth_surface_code_5,
					@L2400_7_too02_JP_tooth_code,
					@L2400_7_too03_tooth_surface_code_1,
					@L2400_7_too03_tooth_surface_code_2,
					@L2400_7_too03_tooth_surface_code_3,
					@L2400_7_too03_tooth_surface_code_4,
					@L2400_7_too03_tooth_surface_code_5,
					@L2400_8_too02_JP_tooth_code,
					@L2400_8_too03_tooth_surface_code_1,
					@L2400_8_too03_tooth_surface_code_2,
					@L2400_8_too03_tooth_surface_code_3,
					@L2400_8_too03_tooth_surface_code_4,
					@L2400_8_too03_tooth_surface_code_5,
					@L2400_9_too02_JP_tooth_code,
					@L2400_9_too03_tooth_surface_code_1,
					@L2400_9_too03_tooth_surface_code_2,
					@L2400_9_too03_tooth_surface_code_3,
					@L2400_9_too03_tooth_surface_code_4,
					@L2400_9_too03_tooth_surface_code_5,
					@L2400_10_too02_JP_tooth_code,
					@L2400_10_too03_tooth_surface_code_1,
					@L2400_10_too03_tooth_surface_code_2,
					@L2400_10_too03_tooth_surface_code_3,
					@L2400_10_too03_tooth_surface_code_4,
					@L2400_10_too03_tooth_surface_code_5,
					@L2400_11_too02_JP_tooth_code,
					@L2400_11_too03_tooth_surface_code_1,
					@L2400_11_too03_tooth_surface_code_2,
					@L2400_11_too03_tooth_surface_code_3,
					@L2400_11_too03_tooth_surface_code_4,
					@L2400_11_too03_tooth_surface_code_5,
					@L2400_12_too02_JP_tooth_code,
					@L2400_12_too03_tooth_surface_code_1,
					@L2400_12_too03_tooth_surface_code_2,
					@L2400_12_too03_tooth_surface_code_3,
					@L2400_12_too03_tooth_surface_code_4,
					@L2400_12_too03_tooth_surface_code_5,
					@L2400_13_too02_JP_tooth_code,
					@L2400_13_too03_tooth_surface_code_1,
					@L2400_13_too03_tooth_surface_code_2,
					@L2400_13_too03_tooth_surface_code_3,
					@L2400_13_too03_tooth_surface_code_4,
					@L2400_13_too03_tooth_surface_code_5,
					@L2400_14_too02_JP_tooth_code,
					@L2400_14_too03_tooth_surface_code_1,
					@L2400_14_too03_tooth_surface_code_2,
					@L2400_14_too03_tooth_surface_code_3,
					@L2400_14_too03_tooth_surface_code_4,
					@L2400_14_too03_tooth_surface_code_5,
					@L2400_15_too02_JP_tooth_code,
					@L2400_15_too03_tooth_surface_code_1,
					@L2400_15_too03_tooth_surface_code_2,
					@L2400_15_too03_tooth_surface_code_3,
					@L2400_15_too03_tooth_surface_code_4,
					@L2400_15_too03_tooth_surface_code_5,
					@L2400_16_too02_JP_tooth_code,
					@L2400_16_too03_tooth_surface_code_1,
					@L2400_16_too03_tooth_surface_code_2,
					@L2400_16_too03_tooth_surface_code_3,
					@L2400_16_too03_tooth_surface_code_4,
					@L2400_16_too03_tooth_surface_code_5,
					@L2400_17_too02_JP_tooth_code,
					@L2400_17_too03_tooth_surface_code_1,
					@L2400_17_too03_tooth_surface_code_2,
					@L2400_17_too03_tooth_surface_code_3,
					@L2400_17_too03_tooth_surface_code_4,
					@L2400_17_too03_tooth_surface_code_5,
					@L2400_18_too02_JP_tooth_code,
					@L2400_18_too03_tooth_surface_code_1,
					@L2400_18_too03_tooth_surface_code_2,
					@L2400_18_too03_tooth_surface_code_3,
					@L2400_18_too03_tooth_surface_code_4,
					@L2400_18_too03_tooth_surface_code_5,
					@L2400_19_too02_JP_tooth_code,
					@L2400_19_too03_tooth_surface_code_1,
					@L2400_19_too03_tooth_surface_code_2,
					@L2400_19_too03_tooth_surface_code_3,
					@L2400_19_too03_tooth_surface_code_4,
					@L2400_19_too03_tooth_surface_code_5,
					@L2400_20_too02_JP_tooth_code,
					@L2400_20_too03_tooth_surface_code_1,
					@L2400_20_too03_tooth_surface_code_2,
					@L2400_20_too03_tooth_surface_code_3,
					@L2400_20_too03_tooth_surface_code_4,
					@L2400_20_too03_tooth_surface_code_5,
					@L2400_21_too02_JP_tooth_code,
					@L2400_21_too03_tooth_surface_code_1,
					@L2400_21_too03_tooth_surface_code_2,
					@L2400_21_too03_tooth_surface_code_3,
					@L2400_21_too03_tooth_surface_code_4,
					@L2400_21_too03_tooth_surface_code_5,
					@L2400_22_too02_JP_tooth_code,
					@L2400_22_too03_tooth_surface_code_1,
					@L2400_22_too03_tooth_surface_code_2,
					@L2400_22_too03_tooth_surface_code_3,
					@L2400_22_too03_tooth_surface_code_4,
					@L2400_22_too03_tooth_surface_code_5,
					@L2400_23_too02_JP_tooth_code,
					@L2400_23_too03_tooth_surface_code_1,
					@L2400_23_too03_tooth_surface_code_2,
					@L2400_23_too03_tooth_surface_code_3,
					@L2400_23_too03_tooth_surface_code_4,
					@L2400_23_too03_tooth_surface_code_5,
					@L2400_24_too02_JP_tooth_code,
					@L2400_24_too03_tooth_surface_code_1,
					@L2400_24_too03_tooth_surface_code_2,
					@L2400_24_too03_tooth_surface_code_3,
					@L2400_24_too03_tooth_surface_code_4,
					@L2400_24_too03_tooth_surface_code_5,
					@L2400_25_too02_JP_tooth_code,
					@L2400_25_too03_tooth_surface_code_1,
					@L2400_25_too03_tooth_surface_code_2,
					@L2400_25_too03_tooth_surface_code_3,
					@L2400_25_too03_tooth_surface_code_4,
					@L2400_25_too03_tooth_surface_code_5,
					@L2400_26_too02_JP_tooth_code,
					@L2400_26_too03_tooth_surface_code_1,
					@L2400_26_too03_tooth_surface_code_2,
					@L2400_26_too03_tooth_surface_code_3,
					@L2400_26_too03_tooth_surface_code_4,
					@L2400_26_too03_tooth_surface_code_5,
					@L2400_27_too02_JP_tooth_code,
					@L2400_27_too03_tooth_surface_code_1,
					@L2400_27_too03_tooth_surface_code_2,
					@L2400_27_too03_tooth_surface_code_3,
					@L2400_27_too03_tooth_surface_code_4,
					@L2400_27_too03_tooth_surface_code_5,
					@L2400_28_too02_JP_tooth_code,
					@L2400_28_too03_tooth_surface_code_1,
					@L2400_28_too03_tooth_surface_code_2,
					@L2400_28_too03_tooth_surface_code_3,
					@L2400_28_too03_tooth_surface_code_4,
					@L2400_28_too03_tooth_surface_code_5,
					@L2400_29_too02_JP_tooth_code,
					@L2400_29_too03_tooth_surface_code_1,
					@L2400_29_too03_tooth_surface_code_2,
					@L2400_29_too03_tooth_surface_code_3,
					@L2400_29_too03_tooth_surface_code_4,
					@L2400_29_too03_tooth_surface_code_5,
					@L2400_30_too02_JP_tooth_code,
					@L2400_30_too03_tooth_surface_code_1,
					@L2400_30_too03_tooth_surface_code_2,
					@L2400_30_too03_tooth_surface_code_3,
					@L2400_30_too03_tooth_surface_code_4,
					@L2400_30_too03_tooth_surface_code_5,
					@L2400_31_too02_JP_tooth_code,
					@L2400_31_too03_tooth_surface_code_1,
					@L2400_31_too03_tooth_surface_code_2,
					@L2400_31_too03_tooth_surface_code_3,
					@L2400_31_too03_tooth_surface_code_4,
					@L2400_31_too03_tooth_surface_code_5,
					@L2400_32_too02_JP_tooth_code,
					@L2400_32_too03_tooth_surface_code_1,
					@L2400_32_too03_tooth_surface_code_2,
					@L2400_32_too03_tooth_surface_code_3,
					@L2400_32_too03_tooth_surface_code_4,
					@L2400_32_too03_tooth_surface_code_5,
					@L2400_dtp02_472_service_date,
					@L2400_dtp02_441_prior_placement_date,
					@L2400_dtp02_452_orthodontic_banding_date,
					@L2400_dtp02_446_replacement_date,
					@L2400_1_qty01_qty_qual,
					@L2400_1_qty02_anesthesia_unit_count,
					@L2400_2_qty01_qty_qual,
					@L2400_2_qty02_anesthesia_unit_count,
					@L2400_3_qty01_qty_qual,
					@L2400_3_qty02_anesthesia_unit_count,
					@L2400_4_qty01_qty_qual,
					@L2400_4_qty02_anesthesia_unit_count,
					@L2400_5_qty01_qty_qual,
					@L2400_5_qty02_anesthesia_unit_count,
					@L2400_ref02_G3_predetermination_of_benefits_id,
					@L2400_ref02_9F_referral_number,
					@L2400_ref02_G1_prior_auth_number,
					@L2400_ref02_6R_line_item_control_num,
					@L2400_amt02_AAE_approved_amt,
					@L2400_amt02_T_sales_tax_amt,
					@L2400_nte01_note_ref_code,
					@L2400_nte02_line_note_text,
					@L2420A_nm102_entity_type_qual,
					@L2420A_nm103_rendering_prov_last_nm,
					@L2420A_nm104_rendering_prov_first_nm,
					@L2420A_nm105_rendering_prov_middle_nm,
					@L2420A_nm107_rendering_prov_suffix,
					@L2420A_nm108_id_code_qual,
					@L2420A_nm109_rendering_prov_id,
					@L2420A_prv01_provider_code,
					@L2420A_prv02_ref_id_qual,
					@L2420A_prv03_taxonomy_code,
					@L2420A_ref02_1C_rendering_prov_id,
					@L2420A_ref02_1D_rendering_prov_id,
					@L2420A_ref02_1E_rendering_prov_id,
					@L2420A_ref02_EI_rendering_prov_id,
					@L2420A_ref02_SY_rendering_prov_id,
					@L2420A_ref02_TJ_rendering_prov_id,
					@L2420B_nm102_entity_type_qual,
					@L2420B_nm103_payer_last_nm,
					@L2420B_nm108_id_code_qual,
					@L2420B_nm109_other_payer_id,
					@L2420B_ref02_9F_referral_number,
					@L2420B_ref02_G1_prior_auth_number,
					@L2420C_nm101_entity_id_code,
					@L2420C_nm102_entity_type_qual,
					@L2420C_nm103_assistant_surgeon_last_nm,
					@L2420C_nm104_assistant_surgeon_first_nm,
					@L2420C_nm105_assistant_surgeon_middle_nm,
					@L2420C_nm107_assistant_surgeon_suffix,
					@L2420C_nm108_id_code_qual,
					@L2420C_nm109_assistant_surgeon_id,
					@L2420C_prv01_provider_code,
					@L2420C_prv02_ref_id_qual,
					@L2420C_prv03_taxonomy_code,
					@L2420C_ref02_1C_service_facility_id,
					@L2420C_ref02_1D_service_facility_id,
					@L2420C_ref02_1E_service_facility_id,
					@L2420C_ref02_G2_service_facility_id,
					@L2420C_ref02_TJ_service_facility_id,
					@L2430_svd01_other_payer_id,
					@L2430_svd02_service_line_paid,
					@L2430_svd03_service_id_qual,
					@L2430_svd03_proc_code,
					@L2430_svd03_proc_mod1,
					@L2430_svd03_proc_mod2,
					@L2430_svd03_proc_mod3,
					@L2430_svd03_proc_mod4,
					@L2430_svd03_proc_code_desc,
					@L2430_svd05_paid_service_unit,
					@L2430_svd06_bundled_unbundled_line_num,
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
					@L2430_dtp03_573_date_claim_paid
				)
		end

		-- reset the procedure code values
		select	@L2400_lx01_assigned_num = NULL,
			@L2400_sv301_proc_code_qual = NULL,
			@L2400_sv301_proc_code = NULL,
			@L2400_sv301_proc_mod1 = NULL,
			@L2400_sv301_proc_mod2 = NULL,
			@L2400_sv301_proc_mod3 = NULL,
			@L2400_sv301_proc_mod4 = NULL,
			@L2400_sv302_line_charge = NULL,
			@L2400_sv303_facility_type_code = NULL,
			@L2400_sv304_oral_cavity_designation_code_1 = NULL,
			@L2400_sv304_oral_cavity_designation_code_2 = NULL,
			@L2400_sv304_oral_cavity_designation_code_3 = NULL,
			@L2400_sv304_oral_cavity_designation_code_4 = NULL,
			@L2400_sv304_oral_cavity_designation_code_5 = NULL,
			@L2400_sv305_prosthesis_crown_inlay_code = NULL,
			@L2400_sv306_procedure_count = NULL,
			@L2400_1_too02_JP_tooth_code = null,
			@L2400_1_too03_tooth_surface_code_1 = null,
			@L2400_1_too03_tooth_surface_code_2 = null,
			@L2400_1_too03_tooth_surface_code_3 = null,
			@L2400_1_too03_tooth_surface_code_4 = null,
			@L2400_1_too03_tooth_surface_code_5 = null,
			@L2400_2_too02_JP_tooth_code = null,
			@L2400_2_too03_tooth_surface_code_1 = null,
			@L2400_2_too03_tooth_surface_code_2 = null,
			@L2400_2_too03_tooth_surface_code_3 = null,
			@L2400_2_too03_tooth_surface_code_4 = null,
			@L2400_2_too03_tooth_surface_code_5 = null,
			@L2400_3_too02_JP_tooth_code = null,
			@L2400_3_too03_tooth_surface_code_1 = null,
			@L2400_3_too03_tooth_surface_code_2 = null,
			@L2400_3_too03_tooth_surface_code_3 = null,
			@L2400_3_too03_tooth_surface_code_4 = null,
			@L2400_3_too03_tooth_surface_code_5 = null,
			@L2400_4_too02_JP_tooth_code = null,
			@L2400_4_too03_tooth_surface_code_1 = null,
			@L2400_4_too03_tooth_surface_code_2 = null,
			@L2400_4_too03_tooth_surface_code_3 = null,
			@L2400_4_too03_tooth_surface_code_4 = null,
			@L2400_4_too03_tooth_surface_code_5 = null,
			@L2400_5_too02_JP_tooth_code = null,
			@L2400_5_too03_tooth_surface_code_1 = null,
			@L2400_5_too03_tooth_surface_code_2 = null,
			@L2400_5_too03_tooth_surface_code_3 = null,
			@L2400_5_too03_tooth_surface_code_4 = null,
			@L2400_5_too03_tooth_surface_code_5 = null,
			@L2400_6_too02_JP_tooth_code = null,
			@L2400_6_too03_tooth_surface_code_1 = null,
			@L2400_6_too03_tooth_surface_code_2 = null,
			@L2400_6_too03_tooth_surface_code_3 = null,
			@L2400_6_too03_tooth_surface_code_4 = null,
			@L2400_6_too03_tooth_surface_code_5 = null,
			@L2400_7_too02_JP_tooth_code = null,
			@L2400_7_too03_tooth_surface_code_1 = null,
			@L2400_7_too03_tooth_surface_code_2 = null,
			@L2400_7_too03_tooth_surface_code_3 = null,
			@L2400_7_too03_tooth_surface_code_4 = null,
			@L2400_7_too03_tooth_surface_code_5 = null,
			@L2400_8_too02_JP_tooth_code = null,
			@L2400_8_too03_tooth_surface_code_1 = null,
			@L2400_8_too03_tooth_surface_code_2 = null,
			@L2400_8_too03_tooth_surface_code_3 = null,
			@L2400_8_too03_tooth_surface_code_4 = null,
			@L2400_8_too03_tooth_surface_code_5 = null,
			@L2400_9_too02_JP_tooth_code = null,
			@L2400_9_too03_tooth_surface_code_1 = null,
			@L2400_9_too03_tooth_surface_code_2 = null,
			@L2400_9_too03_tooth_surface_code_3 = null,
			@L2400_9_too03_tooth_surface_code_4 = null,
			@L2400_9_too03_tooth_surface_code_5 = null,
			@L2400_10_too02_JP_tooth_code = null,
			@L2400_10_too03_tooth_surface_code_1 = null,
			@L2400_10_too03_tooth_surface_code_2 = null,
			@L2400_10_too03_tooth_surface_code_3 = null,
			@L2400_10_too03_tooth_surface_code_4 = null,
			@L2400_10_too03_tooth_surface_code_5 = null,
			@L2400_11_too02_JP_tooth_code = null,
			@L2400_11_too03_tooth_surface_code_1 = null,
			@L2400_11_too03_tooth_surface_code_2 = null,
			@L2400_11_too03_tooth_surface_code_3 = null,
			@L2400_11_too03_tooth_surface_code_4 = null,
			@L2400_11_too03_tooth_surface_code_5 = null,
			@L2400_12_too02_JP_tooth_code = null,
			@L2400_12_too03_tooth_surface_code_1 = null,
			@L2400_12_too03_tooth_surface_code_2 = null,
			@L2400_12_too03_tooth_surface_code_3 = null,
			@L2400_12_too03_tooth_surface_code_4 = null,
			@L2400_12_too03_tooth_surface_code_5 = null,
			@L2400_13_too02_JP_tooth_code = null,
			@L2400_13_too03_tooth_surface_code_1 = null,
			@L2400_13_too03_tooth_surface_code_2 = null,
			@L2400_13_too03_tooth_surface_code_3 = null,
			@L2400_13_too03_tooth_surface_code_4 = null,
			@L2400_13_too03_tooth_surface_code_5 = null,
			@L2400_14_too02_JP_tooth_code = null,
			@L2400_14_too03_tooth_surface_code_1 = null,
			@L2400_14_too03_tooth_surface_code_2 = null,
			@L2400_14_too03_tooth_surface_code_3 = null,
			@L2400_14_too03_tooth_surface_code_4 = null,
			@L2400_14_too03_tooth_surface_code_5 = null,
			@L2400_15_too02_JP_tooth_code = null,
			@L2400_15_too03_tooth_surface_code_1 = null,
			@L2400_15_too03_tooth_surface_code_2 = null,
			@L2400_15_too03_tooth_surface_code_3 = null,
			@L2400_15_too03_tooth_surface_code_4 = null,
			@L2400_15_too03_tooth_surface_code_5 = null,
			@L2400_16_too02_JP_tooth_code = null,
			@L2400_16_too03_tooth_surface_code_1 = null,
			@L2400_16_too03_tooth_surface_code_2 = null,
			@L2400_16_too03_tooth_surface_code_3 = null,
			@L2400_16_too03_tooth_surface_code_4 = null,
			@L2400_16_too03_tooth_surface_code_5 = null,
			@L2400_17_too02_JP_tooth_code = null,
			@L2400_17_too03_tooth_surface_code_1 = null,
			@L2400_17_too03_tooth_surface_code_2 = null,
			@L2400_17_too03_tooth_surface_code_3 = null,
			@L2400_17_too03_tooth_surface_code_4 = null,
			@L2400_17_too03_tooth_surface_code_5 = null,
			@L2400_18_too02_JP_tooth_code = null,
			@L2400_18_too03_tooth_surface_code_1 = null,
			@L2400_18_too03_tooth_surface_code_2 = null,
			@L2400_18_too03_tooth_surface_code_3 = null,
			@L2400_18_too03_tooth_surface_code_4 = null,
			@L2400_18_too03_tooth_surface_code_5 = null,
			@L2400_19_too02_JP_tooth_code = null,
			@L2400_19_too03_tooth_surface_code_1 = null,
			@L2400_19_too03_tooth_surface_code_2 = null,
			@L2400_19_too03_tooth_surface_code_3 = null,
			@L2400_19_too03_tooth_surface_code_4 = null,
			@L2400_19_too03_tooth_surface_code_5 = null,
			@L2400_20_too02_JP_tooth_code = null,
			@L2400_20_too03_tooth_surface_code_1 = null,
			@L2400_20_too03_tooth_surface_code_2 = null,
			@L2400_20_too03_tooth_surface_code_3 = null,
			@L2400_20_too03_tooth_surface_code_4 = null,
			@L2400_20_too03_tooth_surface_code_5 = null,
			@L2400_21_too02_JP_tooth_code = null,
			@L2400_21_too03_tooth_surface_code_1 = null,
			@L2400_21_too03_tooth_surface_code_2 = null,
			@L2400_21_too03_tooth_surface_code_3 = null,
			@L2400_21_too03_tooth_surface_code_4 = null,
			@L2400_21_too03_tooth_surface_code_5 = null,
			@L2400_22_too02_JP_tooth_code = null,
			@L2400_22_too03_tooth_surface_code_1 = null,
			@L2400_22_too03_tooth_surface_code_2 = null,
			@L2400_22_too03_tooth_surface_code_3 = null,
			@L2400_22_too03_tooth_surface_code_4 = null,
			@L2400_22_too03_tooth_surface_code_5 = null,
			@L2400_23_too02_JP_tooth_code = null,
			@L2400_23_too03_tooth_surface_code_1 = null,
			@L2400_23_too03_tooth_surface_code_2 = null,
			@L2400_23_too03_tooth_surface_code_3 = null,
			@L2400_23_too03_tooth_surface_code_4 = null,
			@L2400_23_too03_tooth_surface_code_5 = null,
			@L2400_24_too02_JP_tooth_code = null,
			@L2400_24_too03_tooth_surface_code_1 = null,
			@L2400_24_too03_tooth_surface_code_2 = null,
			@L2400_24_too03_tooth_surface_code_3 = null,
			@L2400_24_too03_tooth_surface_code_4 = null,
			@L2400_24_too03_tooth_surface_code_5 = null,
			@L2400_25_too02_JP_tooth_code = null,
			@L2400_25_too03_tooth_surface_code_1 = null,
			@L2400_25_too03_tooth_surface_code_2 = null,
			@L2400_25_too03_tooth_surface_code_3 = null,
			@L2400_25_too03_tooth_surface_code_4 = null,
			@L2400_25_too03_tooth_surface_code_5 = null,
			@L2400_26_too02_JP_tooth_code = null,
			@L2400_26_too03_tooth_surface_code_1 = null,
			@L2400_26_too03_tooth_surface_code_2 = null,
			@L2400_26_too03_tooth_surface_code_3 = null,
			@L2400_26_too03_tooth_surface_code_4 = null,
			@L2400_26_too03_tooth_surface_code_5 = null,
			@L2400_27_too02_JP_tooth_code = null,
			@L2400_27_too03_tooth_surface_code_1 = null,
			@L2400_27_too03_tooth_surface_code_2 = null,
			@L2400_27_too03_tooth_surface_code_3 = null,
			@L2400_27_too03_tooth_surface_code_4 = null,
			@L2400_27_too03_tooth_surface_code_5 = null,
			@L2400_28_too02_JP_tooth_code = null,
			@L2400_28_too03_tooth_surface_code_1 = null,
			@L2400_28_too03_tooth_surface_code_2 = null,
			@L2400_28_too03_tooth_surface_code_3 = null,
			@L2400_28_too03_tooth_surface_code_4 = null,
			@L2400_28_too03_tooth_surface_code_5 = null,
			@L2400_29_too02_JP_tooth_code = null,
			@L2400_29_too03_tooth_surface_code_1 = null,
			@L2400_29_too03_tooth_surface_code_2 = null,
			@L2400_29_too03_tooth_surface_code_3 = null,
			@L2400_29_too03_tooth_surface_code_4 = null,
			@L2400_29_too03_tooth_surface_code_5 = null,
			@L2400_30_too02_JP_tooth_code = null,
			@L2400_30_too03_tooth_surface_code_1 = null,
			@L2400_30_too03_tooth_surface_code_2 = null,
			@L2400_30_too03_tooth_surface_code_3 = null,
			@L2400_30_too03_tooth_surface_code_4 = null,
			@L2400_30_too03_tooth_surface_code_5 = null,
			@L2400_31_too02_JP_tooth_code = null,
			@L2400_31_too03_tooth_surface_code_1 = null,
			@L2400_31_too03_tooth_surface_code_2 = null,
			@L2400_31_too03_tooth_surface_code_3 = null,
			@L2400_31_too03_tooth_surface_code_4 = null,
			@L2400_31_too03_tooth_surface_code_5 = null,
			@L2400_32_too02_JP_tooth_code = null,
			@L2400_32_too03_tooth_surface_code_1 = null,
			@L2400_32_too03_tooth_surface_code_2 = null,
			@L2400_32_too03_tooth_surface_code_3 = null,
			@L2400_32_too03_tooth_surface_code_4 = null,
			@L2400_32_too03_tooth_surface_code_5 = null,
			@L2400_dtp02_472_service_date = NULL,
			@L2400_dtp02_441_prior_placement_date = NULL,
			@L2400_dtp02_452_orthodontic_banding_date = NULL,
			@L2400_dtp02_446_replacement_date = NULL,
			@L2400_1_qty01_qty_qual = NULL,
			@L2400_1_qty02_anesthesia_unit_count = NULL,
			@L2400_2_qty01_qty_qual = NULL,
			@L2400_2_qty02_anesthesia_unit_count = NULL,
			@L2400_3_qty01_qty_qual = NULL,
			@L2400_3_qty02_anesthesia_unit_count = NULL,
			@L2400_4_qty01_qty_qual = NULL,
			@L2400_4_qty02_anesthesia_unit_count = NULL,
			@L2400_5_qty01_qty_qual = NULL,
			@L2400_5_qty02_anesthesia_unit_count = NULL,
			@L2400_ref02_G3_predetermination_of_benefits_id = NULL,
			@L2400_ref02_9F_referral_number = NULL,
			@L2400_ref02_G1_prior_auth_number = NULL,
			@L2400_ref02_6R_line_item_control_num = NULL,
			@L2400_amt02_AAE_approved_amt = NULL,
			@L2400_amt02_T_sales_tax_amt = NULL,
			@L2400_nte01_note_ref_code = NULL,
			@L2400_nte02_line_note_text = NULL,
			@L2420A_nm102_entity_type_qual = NULL,
			@L2420A_nm103_rendering_prov_last_nm = NULL,
			@L2420A_nm104_rendering_prov_first_nm = NULL,
			@L2420A_nm105_rendering_prov_middle_nm = NULL,
			@L2420A_nm107_rendering_prov_suffix = NULL,
			@L2420A_nm108_id_code_qual = NULL,
			@L2420A_nm109_rendering_prov_id = NULL,
			@L2420A_prv01_provider_code = NULL,
			@L2420A_prv02_ref_id_qual = NULL,
			@L2420A_prv03_taxonomy_code = NULL,
			@L2420A_ref02_1C_rendering_prov_id = NULL,
			@L2420A_ref02_1D_rendering_prov_id = NULL,
			@L2420A_ref02_1E_rendering_prov_id = NULL,
			@L2420A_ref02_EI_rendering_prov_id = NULL,
			@L2420A_ref02_SY_rendering_prov_id = NULL,
			@L2420A_ref02_TJ_rendering_prov_id = NULL,
			@L2420B_nm102_entity_type_qual = NULL,
			@L2420B_nm103_payer_last_nm = NULL,
			@L2420B_nm108_id_code_qual = NULL,
			@L2420B_nm109_other_payer_id = NULL,
			@L2420B_ref02_9F_referral_number = NULL,
			@L2420B_ref02_G1_prior_auth_number = NULL,
			@L2420C_nm101_entity_id_code = NULL,
			@L2420C_nm102_entity_type_qual = NULL,
			@L2420C_nm103_assistant_surgeon_last_nm = NULL,
			@L2420C_nm104_assistant_surgeon_first_nm = NULL,
			@L2420C_nm105_assistant_surgeon_middle_nm = NULL,
			@L2420C_nm107_assistant_surgeon_suffix = NULL,
			@L2420C_nm108_id_code_qual = NULL,
			@L2420C_nm109_assistant_surgeon_id = NULL,
			@L2420C_prv01_provider_code = NULL,
			@L2420C_prv02_ref_id_qual = NULL,
			@L2420C_prv03_taxonomy_code = NULL,
			@L2420C_ref02_1C_service_facility_id = NULL,
			@L2420C_ref02_1D_service_facility_id = NULL,
			@L2420C_ref02_1E_service_facility_id = NULL,
			@L2420C_ref02_G2_service_facility_id = NULL,
			@L2420C_ref02_TJ_service_facility_id = NULL,
			@L2430_svd01_other_payer_id = NULL,
			@L2430_svd02_service_line_paid = NULL,
			@L2430_svd03_service_id_qual = NULL,
			@L2430_svd03_proc_code = NULL,
			@L2430_svd03_proc_mod1 = NULL,
			@L2430_svd03_proc_mod2 = NULL,
			@L2430_svd03_proc_mod3 = NULL,
			@L2430_svd03_proc_mod4 = NULL,
			@L2430_svd03_proc_code_desc = NULL,
			@L2430_svd05_paid_service_unit = NULL,
			@L2430_svd06_bundled_unbundled_line_num = NULL,
			@L2430_cas01_adjustment_group_code = NULL,
			@L2430_cas02_adjustment_reason_code = NULL,
			@L2430_cas03_adjustment_amt = NULL,
			@L2430_cas04_adjustment_qty = NULL,
			@L2430_cas05_adjustment_reason_code = NULL,
			@L2430_cas06_adjustment_amt = NULL,
			@L2430_cas07_adjustment_qty = NULL,
			@L2430_cas08_adjustment_reason_code = NULL,
			@L2430_cas09_adjustment_amt = NULL,
			@L2430_cas10_adjustment_qty = NULL,
			@L2430_dtp03_573_date_claim_paid = NULL,

			@Other2400TOOLoopCount = 0,
	
			@L2400_lx01_assigned_num = LTRIM(RTRIM(@Col002))
	end

	-- Get SV3 service information (this segment is essentially the "header" of the detail section)
	if ( RTrim(@col001) = 'SV3' )
	begin
		set @curLoop = '2400'
		-- col002 will be a string like "HC:T1016:HN" where HC signifies the code type, T1016 is the code, and HN is the modifier
		set @ProcString = LTRIM(RTRIM(@col002))
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
			if (@loopcount = 1) set @L2400_sv301_proc_code_qual = Left(@ProcString, @EndStringPos)
			if (@loopcount = 2) set @L2400_sv301_proc_code = Left(@ProcString, @EndStringPos)
			if (@loopcount = 3) set @L2400_sv301_proc_mod1 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 4) set @L2400_sv301_proc_mod2 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 5) set @L2400_sv301_proc_mod3 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 6) set @L2400_sv301_proc_mod4 = Left(@ProcString, @EndStringPos)
			if (@ColonPos > 0)
				set @ProcString = Right(@ProcString, Len(@ProcString)-@ColonPos)
			else
				set @ProcString = null
		end
		-- Dental codes will look like this, "AD:D0217"
		if (@L2400_sv301_proc_code_qual = 'AD')
		begin
			 -- AD means Dental Code
			set @L2400_sv301_proc_code = Right(RTrim(@L2400_sv301_proc_code), 5) -- the first digit is a 0, leave that off.
		end

		set @ProcString = LTRIM(RTRIM(@col005))
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
			if (@loopcount = 1) set @L2400_sv304_oral_cavity_designation_code_1 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 2) set @L2400_sv304_oral_cavity_designation_code_2 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 3) set @L2400_sv304_oral_cavity_designation_code_3 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 4) set @L2400_sv304_oral_cavity_designation_code_4 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 5) set @L2400_sv304_oral_cavity_designation_code_5 = Left(@ProcString, @EndStringPos)
			if (@ColonPos > 0)
				set @ProcString = Right(@ProcString, Len(@ProcString)-@ColonPos)
			else
				set @ProcString = null
		end

		set @L2400_sv302_line_charge = CAST(LTrim(RTrim(@Col003)) as money)
		set @L2400_sv303_facility_type_code = LTRIM(RTRIM(@Col004))
		set @L2400_sv305_prosthesis_crown_inlay_code = LTRIM(RTRIM(@Col006))
		set @L2400_sv306_procedure_count = LTRIM(RTRIM(@Col007))
	end

	/*
	if ( RTrim(@col001) = 'TOO' AND RTrim(@col002) = 'JP' )
	begin
		set @curLoop = '2400'
		-- col004 will be a string like "L:O:I" where L, O, and I are Tooth Surface Codes
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
			if (@loopcount = 1) set @L2400_too03_tooth_surface_code_1 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 2) set @L2400_too03_tooth_surface_code_2 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 3) set @L2400_too03_tooth_surface_code_3 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 4) set @L2400_too03_tooth_surface_code_4 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 5) set @L2400_too03_tooth_surface_code_5 = Left(@ProcString, @EndStringPos)
			if (@ColonPos > 0)
				set @ProcString = Right(@ProcString, Len(@ProcString)-@ColonPos)
			else
				set @ProcString = null
		end

		set @L2400_too02_JP_tooth_code = LTrim(RTrim(@col003))
	end
	*/
	
	if ( RTrim(@col001) = 'TOO' AND RTrim(@col002) = 'JP' )
	begin
		set @curLoop = '2400'

		-- place holder tooth codes
		set @tmp_tooth_surface_code_1 = null
		set @tmp_tooth_surface_code_2 = null
		set @tmp_tooth_surface_code_3 = null
		set @tmp_tooth_surface_code_4 = null
		set @tmp_tooth_surface_code_5 = null
		
		set @Other2400TOOLoopCount = @Other2400TOOLoopCount + 1
		
		-- col004 will be a string like "L:O:I" where L, O, and I are Tooth Surface Codes
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
			if (@loopcount = 1) set @tmp_tooth_surface_code_1 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 2) set @tmp_tooth_surface_code_2 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 3) set @tmp_tooth_surface_code_3 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 4) set @tmp_tooth_surface_code_4 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 5) set @tmp_tooth_surface_code_5 = Left(@ProcString, @EndStringPos)
			if (@ColonPos > 0)
				set @ProcString = Right(@ProcString, Len(@ProcString)-@ColonPos)
			else
				set @ProcString = null
		end

		set @SQLString = 
			'select 
				@L2400_' + cast(@Other2400TOOLoopCount AS varchar) + '_too02_JP_tooth_code = LTRIM(RTRIM(@col003)),
				@L2400_' + cast(@Other2400TOOLoopCount AS varchar) + '_too03_tooth_surface_code_1 = @tmp_tooth_surface_code_1,
				@L2400_' + cast(@Other2400TOOLoopCount AS varchar) + '_too03_tooth_surface_code_2 = @tmp_tooth_surface_code_2,
				@L2400_' + cast(@Other2400TOOLoopCount AS varchar) + '_too03_tooth_surface_code_3 = @tmp_tooth_surface_code_3,
				@L2400_' + cast(@Other2400TOOLoopCount AS varchar) + '_too03_tooth_surface_code_4 = @tmp_tooth_surface_code_4,
				@L2400_' + cast(@Other2400TOOLoopCount AS varchar) + '_too03_tooth_surface_code_5 = @tmp_tooth_surface_code_5'
		exec sp_executesql	@SQLString,
				N'@col003 varchar(80), 
					@tmp_tooth_surface_code_1 char(2), 
					@tmp_tooth_surface_code_2 char(2),
					@tmp_tooth_surface_code_3 char(2),
					@tmp_tooth_surface_code_4 char(2),
					@tmp_tooth_surface_code_5 char(2),
					@L2400_1_too02_JP_tooth_code varchar(30) output,
					@L2400_1_too03_tooth_surface_code_1 char(2) output,
					@L2400_1_too03_tooth_surface_code_2 char(2) output,
					@L2400_1_too03_tooth_surface_code_3 char(2) output,
					@L2400_1_too03_tooth_surface_code_4 char(2) output,
					@L2400_1_too03_tooth_surface_code_5 char(2) output,
					@L2400_2_too02_JP_tooth_code varchar(30) output,
					@L2400_2_too03_tooth_surface_code_1 char(2) output,
					@L2400_2_too03_tooth_surface_code_2 char(2) output,
					@L2400_2_too03_tooth_surface_code_3 char(2) output,
					@L2400_2_too03_tooth_surface_code_4 char(2) output,
					@L2400_2_too03_tooth_surface_code_5 char(2) output,
					@L2400_3_too02_JP_tooth_code varchar(30) output,
					@L2400_3_too03_tooth_surface_code_1 char(2) output,
					@L2400_3_too03_tooth_surface_code_2 char(2) output,
					@L2400_3_too03_tooth_surface_code_3 char(2) output,
					@L2400_3_too03_tooth_surface_code_4 char(2) output,
					@L2400_3_too03_tooth_surface_code_5 char(2) output,
					@L2400_4_too02_JP_tooth_code varchar(30) output,
					@L2400_4_too03_tooth_surface_code_1 char(2) output,
					@L2400_4_too03_tooth_surface_code_2 char(2) output,
					@L2400_4_too03_tooth_surface_code_3 char(2) output,
					@L2400_4_too03_tooth_surface_code_4 char(2) output,
					@L2400_4_too03_tooth_surface_code_5 char(2) output,
					@L2400_5_too02_JP_tooth_code varchar(30) output,
					@L2400_5_too03_tooth_surface_code_1 char(2) output,
					@L2400_5_too03_tooth_surface_code_2 char(2) output,
					@L2400_5_too03_tooth_surface_code_3 char(2) output,
					@L2400_5_too03_tooth_surface_code_4 char(2) output,
					@L2400_5_too03_tooth_surface_code_5 char(2) output,
					@L2400_6_too02_JP_tooth_code varchar(30) output,
					@L2400_6_too03_tooth_surface_code_1 char(2) output,
					@L2400_6_too03_tooth_surface_code_2 char(2) output,
					@L2400_6_too03_tooth_surface_code_3 char(2) output,
					@L2400_6_too03_tooth_surface_code_4 char(2) output,
					@L2400_6_too03_tooth_surface_code_5 char(2) output,
					@L2400_7_too02_JP_tooth_code varchar(30) output,
					@L2400_7_too03_tooth_surface_code_1 char(2) output,
					@L2400_7_too03_tooth_surface_code_2 char(2) output,
					@L2400_7_too03_tooth_surface_code_3 char(2) output,
					@L2400_7_too03_tooth_surface_code_4 char(2) output,
					@L2400_7_too03_tooth_surface_code_5 char(2) output,
					@L2400_8_too02_JP_tooth_code varchar(30) output,
					@L2400_8_too03_tooth_surface_code_1 char(2) output,
					@L2400_8_too03_tooth_surface_code_2 char(2) output,
					@L2400_8_too03_tooth_surface_code_3 char(2) output,
					@L2400_8_too03_tooth_surface_code_4 char(2) output,
					@L2400_8_too03_tooth_surface_code_5 char(2) output,
					@L2400_9_too02_JP_tooth_code varchar(30) output,
					@L2400_9_too03_tooth_surface_code_1 char(2) output,
					@L2400_9_too03_tooth_surface_code_2 char(2) output,
					@L2400_9_too03_tooth_surface_code_3 char(2) output,
					@L2400_9_too03_tooth_surface_code_4 char(2) output,
					@L2400_9_too03_tooth_surface_code_5 char(2) output,
					@L2400_10_too02_JP_tooth_code varchar(30) output,
					@L2400_10_too03_tooth_surface_code_1 char(2) output,
					@L2400_10_too03_tooth_surface_code_2 char(2) output,
					@L2400_10_too03_tooth_surface_code_3 char(2) output,
					@L2400_10_too03_tooth_surface_code_4 char(2) output,
					@L2400_10_too03_tooth_surface_code_5 char(2) output,
					@L2400_11_too02_JP_tooth_code varchar(30) output,
					@L2400_11_too03_tooth_surface_code_1 char(2) output,
					@L2400_11_too03_tooth_surface_code_2 char(2) output,
					@L2400_11_too03_tooth_surface_code_3 char(2) output,
					@L2400_11_too03_tooth_surface_code_4 char(2) output,
					@L2400_11_too03_tooth_surface_code_5 char(2) output,
					@L2400_12_too02_JP_tooth_code varchar(30) output,
					@L2400_12_too03_tooth_surface_code_1 char(2) output,
					@L2400_12_too03_tooth_surface_code_2 char(2) output,
					@L2400_12_too03_tooth_surface_code_3 char(2) output,
					@L2400_12_too03_tooth_surface_code_4 char(2) output,
					@L2400_12_too03_tooth_surface_code_5 char(2) output,
					@L2400_13_too02_JP_tooth_code varchar(30) output,
					@L2400_13_too03_tooth_surface_code_1 char(2) output,
					@L2400_13_too03_tooth_surface_code_2 char(2) output,
					@L2400_13_too03_tooth_surface_code_3 char(2) output,
					@L2400_13_too03_tooth_surface_code_4 char(2) output,
					@L2400_13_too03_tooth_surface_code_5 char(2) output,
					@L2400_14_too02_JP_tooth_code varchar(30) output,
					@L2400_14_too03_tooth_surface_code_1 char(2) output,
					@L2400_14_too03_tooth_surface_code_2 char(2) output,
					@L2400_14_too03_tooth_surface_code_3 char(2) output,
					@L2400_14_too03_tooth_surface_code_4 char(2) output,
					@L2400_14_too03_tooth_surface_code_5 char(2) output,
					@L2400_15_too02_JP_tooth_code varchar(30) output,
					@L2400_15_too03_tooth_surface_code_1 char(2) output,
					@L2400_15_too03_tooth_surface_code_2 char(2) output,
					@L2400_15_too03_tooth_surface_code_3 char(2) output,
					@L2400_15_too03_tooth_surface_code_4 char(2) output,
					@L2400_15_too03_tooth_surface_code_5 char(2) output,
					@L2400_16_too02_JP_tooth_code varchar(30) output,
					@L2400_16_too03_tooth_surface_code_1 char(2) output,
					@L2400_16_too03_tooth_surface_code_2 char(2) output,
					@L2400_16_too03_tooth_surface_code_3 char(2) output,
					@L2400_16_too03_tooth_surface_code_4 char(2) output,
					@L2400_16_too03_tooth_surface_code_5 char(2) output,
					@L2400_17_too02_JP_tooth_code varchar(30) output,
					@L2400_17_too03_tooth_surface_code_1 char(2) output,
					@L2400_17_too03_tooth_surface_code_2 char(2) output,
					@L2400_17_too03_tooth_surface_code_3 char(2) output,
					@L2400_17_too03_tooth_surface_code_4 char(2) output,
					@L2400_17_too03_tooth_surface_code_5 char(2) output,
					@L2400_18_too02_JP_tooth_code varchar(30) output,
					@L2400_18_too03_tooth_surface_code_1 char(2) output,
					@L2400_18_too03_tooth_surface_code_2 char(2) output,
					@L2400_18_too03_tooth_surface_code_3 char(2) output,
					@L2400_18_too03_tooth_surface_code_4 char(2) output,
					@L2400_18_too03_tooth_surface_code_5 char(2) output,
					@L2400_19_too02_JP_tooth_code varchar(30) output,
					@L2400_19_too03_tooth_surface_code_1 char(2) output,
					@L2400_19_too03_tooth_surface_code_2 char(2) output,
					@L2400_19_too03_tooth_surface_code_3 char(2) output,
					@L2400_19_too03_tooth_surface_code_4 char(2) output,
					@L2400_19_too03_tooth_surface_code_5 char(2) output,
					@L2400_20_too02_JP_tooth_code varchar(30) output,
					@L2400_20_too03_tooth_surface_code_1 char(2) output,
					@L2400_20_too03_tooth_surface_code_2 char(2) output,
					@L2400_20_too03_tooth_surface_code_3 char(2) output,
					@L2400_20_too03_tooth_surface_code_4 char(2) output,
					@L2400_20_too03_tooth_surface_code_5 char(2) output,
					@L2400_21_too02_JP_tooth_code varchar(30) output,
					@L2400_21_too03_tooth_surface_code_1 char(2) output,
					@L2400_21_too03_tooth_surface_code_2 char(2) output,
					@L2400_21_too03_tooth_surface_code_3 char(2) output,
					@L2400_21_too03_tooth_surface_code_4 char(2) output,
					@L2400_21_too03_tooth_surface_code_5 char(2) output,
					@L2400_22_too02_JP_tooth_code varchar(30) output,
					@L2400_22_too03_tooth_surface_code_1 char(2) output,
					@L2400_22_too03_tooth_surface_code_2 char(2) output,
					@L2400_22_too03_tooth_surface_code_3 char(2) output,
					@L2400_22_too03_tooth_surface_code_4 char(2) output,
					@L2400_22_too03_tooth_surface_code_5 char(2) output,
					@L2400_23_too02_JP_tooth_code varchar(30) output,
					@L2400_23_too03_tooth_surface_code_1 char(2) output,
					@L2400_23_too03_tooth_surface_code_2 char(2) output,
					@L2400_23_too03_tooth_surface_code_3 char(2) output,
					@L2400_23_too03_tooth_surface_code_4 char(2) output,
					@L2400_23_too03_tooth_surface_code_5 char(2) output,
					@L2400_24_too02_JP_tooth_code varchar(30) output,
					@L2400_24_too03_tooth_surface_code_1 char(2) output,
					@L2400_24_too03_tooth_surface_code_2 char(2) output,
					@L2400_24_too03_tooth_surface_code_3 char(2) output,
					@L2400_24_too03_tooth_surface_code_4 char(2) output,
					@L2400_24_too03_tooth_surface_code_5 char(2) output,
					@L2400_25_too02_JP_tooth_code varchar(30) output,
					@L2400_25_too03_tooth_surface_code_1 char(2) output,
					@L2400_25_too03_tooth_surface_code_2 char(2) output,
					@L2400_25_too03_tooth_surface_code_3 char(2) output,
					@L2400_25_too03_tooth_surface_code_4 char(2) output,
					@L2400_25_too03_tooth_surface_code_5 char(2) output,
					@L2400_26_too02_JP_tooth_code varchar(30) output,
					@L2400_26_too03_tooth_surface_code_1 char(2) output,
					@L2400_26_too03_tooth_surface_code_2 char(2) output,
					@L2400_26_too03_tooth_surface_code_3 char(2) output,
					@L2400_26_too03_tooth_surface_code_4 char(2) output,
					@L2400_26_too03_tooth_surface_code_5 char(2) output,
					@L2400_27_too02_JP_tooth_code varchar(30) output,
					@L2400_27_too03_tooth_surface_code_1 char(2) output,
					@L2400_27_too03_tooth_surface_code_2 char(2) output,
					@L2400_27_too03_tooth_surface_code_3 char(2) output,
					@L2400_27_too03_tooth_surface_code_4 char(2) output,
					@L2400_27_too03_tooth_surface_code_5 char(2) output,
					@L2400_28_too02_JP_tooth_code varchar(30) output,
					@L2400_28_too03_tooth_surface_code_1 char(2) output,
					@L2400_28_too03_tooth_surface_code_2 char(2) output,
					@L2400_28_too03_tooth_surface_code_3 char(2) output,
					@L2400_28_too03_tooth_surface_code_4 char(2) output,
					@L2400_28_too03_tooth_surface_code_5 char(2) output,
					@L2400_29_too02_JP_tooth_code varchar(30) output,
					@L2400_29_too03_tooth_surface_code_1 char(2) output,
					@L2400_29_too03_tooth_surface_code_2 char(2) output,
					@L2400_29_too03_tooth_surface_code_3 char(2) output,
					@L2400_29_too03_tooth_surface_code_4 char(2) output,
					@L2400_29_too03_tooth_surface_code_5 char(2) output,
					@L2400_30_too02_JP_tooth_code varchar(30) output,
					@L2400_30_too03_tooth_surface_code_1 char(2) output,
					@L2400_30_too03_tooth_surface_code_2 char(2) output,
					@L2400_30_too03_tooth_surface_code_3 char(2) output,
					@L2400_30_too03_tooth_surface_code_4 char(2) output,
					@L2400_30_too03_tooth_surface_code_5 char(2) output,
					@L2400_31_too02_JP_tooth_code varchar(30) output,
					@L2400_31_too03_tooth_surface_code_1 char(2) output,
					@L2400_31_too03_tooth_surface_code_2 char(2) output,
					@L2400_31_too03_tooth_surface_code_3 char(2) output,
					@L2400_31_too03_tooth_surface_code_4 char(2) output,
					@L2400_31_too03_tooth_surface_code_5 char(2) output,
					@L2400_32_too02_JP_tooth_code varchar(30) output,
					@L2400_32_too03_tooth_surface_code_1 char(2) output,
					@L2400_32_too03_tooth_surface_code_2 char(2) output,
					@L2400_32_too03_tooth_surface_code_3 char(2) output,
					@L2400_32_too03_tooth_surface_code_4 char(2) output,
					@L2400_32_too03_tooth_surface_code_5 char(2) output',
					@col003, 
					@tmp_tooth_surface_code_1, 
					@tmp_tooth_surface_code_2, 
					@tmp_tooth_surface_code_3,
					@tmp_tooth_surface_code_4,
					@tmp_tooth_surface_code_5,
					@L2400_1_too02_JP_tooth_code output,
					@L2400_1_too03_tooth_surface_code_1 output,
					@L2400_1_too03_tooth_surface_code_2 output,
					@L2400_1_too03_tooth_surface_code_3 output,
					@L2400_1_too03_tooth_surface_code_4 output,
					@L2400_1_too03_tooth_surface_code_5 output,
					@L2400_2_too02_JP_tooth_code output,
					@L2400_2_too03_tooth_surface_code_1 output,
					@L2400_2_too03_tooth_surface_code_2 output,
					@L2400_2_too03_tooth_surface_code_3 output,
					@L2400_2_too03_tooth_surface_code_4 output,
					@L2400_2_too03_tooth_surface_code_5 output,
					@L2400_3_too02_JP_tooth_code output,
					@L2400_3_too03_tooth_surface_code_1 output,
					@L2400_3_too03_tooth_surface_code_2 output,
					@L2400_3_too03_tooth_surface_code_3 output,
					@L2400_3_too03_tooth_surface_code_4 output,
					@L2400_3_too03_tooth_surface_code_5 output,
					@L2400_4_too02_JP_tooth_code output,
					@L2400_4_too03_tooth_surface_code_1 output,
					@L2400_4_too03_tooth_surface_code_2 output,
					@L2400_4_too03_tooth_surface_code_3 output,
					@L2400_4_too03_tooth_surface_code_4 output,
					@L2400_4_too03_tooth_surface_code_5 output,
					@L2400_5_too02_JP_tooth_code output,
					@L2400_5_too03_tooth_surface_code_1 output,
					@L2400_5_too03_tooth_surface_code_2 output,
					@L2400_5_too03_tooth_surface_code_3 output,
					@L2400_5_too03_tooth_surface_code_4 output,
					@L2400_5_too03_tooth_surface_code_5 output,
					@L2400_6_too02_JP_tooth_code output,
					@L2400_6_too03_tooth_surface_code_1 output,
					@L2400_6_too03_tooth_surface_code_2 output,
					@L2400_6_too03_tooth_surface_code_3 output,
					@L2400_6_too03_tooth_surface_code_4 output,
					@L2400_6_too03_tooth_surface_code_5 output,
					@L2400_7_too02_JP_tooth_code output,
					@L2400_7_too03_tooth_surface_code_1 output,
					@L2400_7_too03_tooth_surface_code_2 output,
					@L2400_7_too03_tooth_surface_code_3 output,
					@L2400_7_too03_tooth_surface_code_4 output,
					@L2400_7_too03_tooth_surface_code_5 output,
					@L2400_8_too02_JP_tooth_code output,
					@L2400_8_too03_tooth_surface_code_1 output,
					@L2400_8_too03_tooth_surface_code_2 output,
					@L2400_8_too03_tooth_surface_code_3 output,
					@L2400_8_too03_tooth_surface_code_4 output,
					@L2400_8_too03_tooth_surface_code_5 output,
					@L2400_9_too02_JP_tooth_code output,
					@L2400_9_too03_tooth_surface_code_1 output,
					@L2400_9_too03_tooth_surface_code_2 output,
					@L2400_9_too03_tooth_surface_code_3 output,
					@L2400_9_too03_tooth_surface_code_4 output,
					@L2400_9_too03_tooth_surface_code_5 output,
					@L2400_10_too02_JP_tooth_code output,
					@L2400_10_too03_tooth_surface_code_1 output,
					@L2400_10_too03_tooth_surface_code_2 output,
					@L2400_10_too03_tooth_surface_code_3 output,
					@L2400_10_too03_tooth_surface_code_4 output,
					@L2400_10_too03_tooth_surface_code_5 output,
					@L2400_11_too02_JP_tooth_code output,
					@L2400_11_too03_tooth_surface_code_1 output,
					@L2400_11_too03_tooth_surface_code_2 output,
					@L2400_11_too03_tooth_surface_code_3 output,
					@L2400_11_too03_tooth_surface_code_4 output,
					@L2400_11_too03_tooth_surface_code_5 output,
					@L2400_12_too02_JP_tooth_code output,
					@L2400_12_too03_tooth_surface_code_1 output,
					@L2400_12_too03_tooth_surface_code_2 output,
					@L2400_12_too03_tooth_surface_code_3 output,
					@L2400_12_too03_tooth_surface_code_4 output,
					@L2400_12_too03_tooth_surface_code_5 output,
					@L2400_13_too02_JP_tooth_code output,
					@L2400_13_too03_tooth_surface_code_1 output,
					@L2400_13_too03_tooth_surface_code_2 output,
					@L2400_13_too03_tooth_surface_code_3 output,
					@L2400_13_too03_tooth_surface_code_4 output,
					@L2400_13_too03_tooth_surface_code_5 output,
					@L2400_14_too02_JP_tooth_code output,
					@L2400_14_too03_tooth_surface_code_1 output,
					@L2400_14_too03_tooth_surface_code_2 output,
					@L2400_14_too03_tooth_surface_code_3 output,
					@L2400_14_too03_tooth_surface_code_4 output,
					@L2400_14_too03_tooth_surface_code_5 output,
					@L2400_15_too02_JP_tooth_code output,
					@L2400_15_too03_tooth_surface_code_1 output,
					@L2400_15_too03_tooth_surface_code_2 output,
					@L2400_15_too03_tooth_surface_code_3 output,
					@L2400_15_too03_tooth_surface_code_4 output,
					@L2400_15_too03_tooth_surface_code_5 output,
					@L2400_16_too02_JP_tooth_code output,
					@L2400_16_too03_tooth_surface_code_1 output,
					@L2400_16_too03_tooth_surface_code_2 output,
					@L2400_16_too03_tooth_surface_code_3 output,
					@L2400_16_too03_tooth_surface_code_4 output,
					@L2400_16_too03_tooth_surface_code_5 output,
					@L2400_17_too02_JP_tooth_code output,
					@L2400_17_too03_tooth_surface_code_1 output,
					@L2400_17_too03_tooth_surface_code_2 output,
					@L2400_17_too03_tooth_surface_code_3 output,
					@L2400_17_too03_tooth_surface_code_4 output,
					@L2400_17_too03_tooth_surface_code_5 output,
					@L2400_18_too02_JP_tooth_code output,
					@L2400_18_too03_tooth_surface_code_1 output,
					@L2400_18_too03_tooth_surface_code_2 output,
					@L2400_18_too03_tooth_surface_code_3 output,
					@L2400_18_too03_tooth_surface_code_4 output,
					@L2400_18_too03_tooth_surface_code_5 output,
					@L2400_19_too02_JP_tooth_code output,
					@L2400_19_too03_tooth_surface_code_1 output,
					@L2400_19_too03_tooth_surface_code_2 output,
					@L2400_19_too03_tooth_surface_code_3 output,
					@L2400_19_too03_tooth_surface_code_4 output,
					@L2400_19_too03_tooth_surface_code_5 output,
					@L2400_20_too02_JP_tooth_code output,
					@L2400_20_too03_tooth_surface_code_1 output,
					@L2400_20_too03_tooth_surface_code_2 output,
					@L2400_20_too03_tooth_surface_code_3 output,
					@L2400_20_too03_tooth_surface_code_4 output,
					@L2400_20_too03_tooth_surface_code_5 output,
					@L2400_21_too02_JP_tooth_code output,
					@L2400_21_too03_tooth_surface_code_1 output,
					@L2400_21_too03_tooth_surface_code_2 output,
					@L2400_21_too03_tooth_surface_code_3 output,
					@L2400_21_too03_tooth_surface_code_4 output,
					@L2400_21_too03_tooth_surface_code_5 output,
					@L2400_22_too02_JP_tooth_code output,
					@L2400_22_too03_tooth_surface_code_1 output,
					@L2400_22_too03_tooth_surface_code_2 output,
					@L2400_22_too03_tooth_surface_code_3 output,
					@L2400_22_too03_tooth_surface_code_4 output,
					@L2400_22_too03_tooth_surface_code_5 output,
					@L2400_23_too02_JP_tooth_code output,
					@L2400_23_too03_tooth_surface_code_1 output,
					@L2400_23_too03_tooth_surface_code_2 output,
					@L2400_23_too03_tooth_surface_code_3 output,
					@L2400_23_too03_tooth_surface_code_4 output,
					@L2400_23_too03_tooth_surface_code_5 output,
					@L2400_24_too02_JP_tooth_code output,
					@L2400_24_too03_tooth_surface_code_1 output,
					@L2400_24_too03_tooth_surface_code_2 output,
					@L2400_24_too03_tooth_surface_code_3 output,
					@L2400_24_too03_tooth_surface_code_4 output,
					@L2400_24_too03_tooth_surface_code_5 output,
					@L2400_25_too02_JP_tooth_code output,
					@L2400_25_too03_tooth_surface_code_1 output,
					@L2400_25_too03_tooth_surface_code_2 output,
					@L2400_25_too03_tooth_surface_code_3 output,
					@L2400_25_too03_tooth_surface_code_4 output,
					@L2400_25_too03_tooth_surface_code_5 output,
					@L2400_26_too02_JP_tooth_code output,
					@L2400_26_too03_tooth_surface_code_1 output,
					@L2400_26_too03_tooth_surface_code_2 output,
					@L2400_26_too03_tooth_surface_code_3 output,
					@L2400_26_too03_tooth_surface_code_4 output,
					@L2400_26_too03_tooth_surface_code_5 output,
					@L2400_27_too02_JP_tooth_code output,
					@L2400_27_too03_tooth_surface_code_1 output,
					@L2400_27_too03_tooth_surface_code_2 output,
					@L2400_27_too03_tooth_surface_code_3 output,
					@L2400_27_too03_tooth_surface_code_4 output,
					@L2400_27_too03_tooth_surface_code_5 output,
					@L2400_28_too02_JP_tooth_code output,
					@L2400_28_too03_tooth_surface_code_1 output,
					@L2400_28_too03_tooth_surface_code_2 output,
					@L2400_28_too03_tooth_surface_code_3 output,
					@L2400_28_too03_tooth_surface_code_4 output,
					@L2400_28_too03_tooth_surface_code_5 output,
					@L2400_29_too02_JP_tooth_code output,
					@L2400_29_too03_tooth_surface_code_1 output,
					@L2400_29_too03_tooth_surface_code_2 output,
					@L2400_29_too03_tooth_surface_code_3 output,
					@L2400_29_too03_tooth_surface_code_4 output,
					@L2400_29_too03_tooth_surface_code_5 output,
					@L2400_30_too02_JP_tooth_code output,
					@L2400_30_too03_tooth_surface_code_1 output,
					@L2400_30_too03_tooth_surface_code_2 output,
					@L2400_30_too03_tooth_surface_code_3 output,
					@L2400_30_too03_tooth_surface_code_4 output,
					@L2400_30_too03_tooth_surface_code_5 output,
					@L2400_31_too02_JP_tooth_code output,
					@L2400_31_too03_tooth_surface_code_1 output,
					@L2400_31_too03_tooth_surface_code_2 output,
					@L2400_31_too03_tooth_surface_code_3 output,
					@L2400_31_too03_tooth_surface_code_4 output,
					@L2400_31_too03_tooth_surface_code_5 output,
					@L2400_32_too02_JP_tooth_code output,
					@L2400_32_too03_tooth_surface_code_1 output,
					@L2400_32_too03_tooth_surface_code_2 output,
					@L2400_32_too03_tooth_surface_code_3 output,
					@L2400_32_too03_tooth_surface_code_4 output,
					@L2400_32_too03_tooth_surface_code_5 output
	end

	-- Claim Header Segment
	if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '472' )
	begin
		select	@L2400_dtp02_472_service_date = LTrim(RTrim(@col004))
	end
	if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '441' )
	begin
		select	@L2400_dtp02_441_prior_placement_date = LTrim(RTrim(@col004))
	end
	if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '452' )
	begin
		select	@L2400_dtp02_452_orthodontic_banding_date = LTrim(RTrim(@col004))
	end
	if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '446' )
	begin
		select	@L2400_dtp02_446_replacement_date = LTrim(RTrim(@col004))
	end

-- FIFTH 2400 LOOP
	if ( RTrim(@col001) = 'QTY' AND @curLoop LIKE '24%' AND @Other2400QTYLoopCount = 4)
	begin
		select	@curLoop = '2400',
			@Other2400QTYLoopCount = 5,
			@L2400_5_qty01_qty_qual = LTrim(RTrim(@col002)),
			@L2400_5_qty02_anesthesia_unit_count = LTrim(RTrim(@col003))
	end
-- FOURTH 2400 LOOP
	if ( RTrim(@col001) = 'QTY' AND @curLoop LIKE '24%' AND @Other2400QTYLoopCount = 3)
	begin
		select	@curLoop = '2400',
			@Other2400QTYLoopCount = 4,
			@L2400_4_qty01_qty_qual = LTrim(RTrim(@col002)),
			@L2400_4_qty02_anesthesia_unit_count = LTrim(RTrim(@col003))
	end
-- THIRD 2400 LOOP
	if ( RTrim(@col001) = 'QTY' AND @curLoop LIKE '24%' AND @Other2400QTYLoopCount = 2)
	begin
		select	@curLoop = '2400',
			@Other2400QTYLoopCount = 3,
			@L2400_3_qty01_qty_qual = LTrim(RTrim(@col002)),
			@L2400_3_qty02_anesthesia_unit_count = LTrim(RTrim(@col003))
	end
-- SECOND 2400 LOOP
	if ( RTrim(@col001) = 'QTY' AND @curLoop LIKE '24%' AND @Other2400QTYLoopCount = 1)
	begin
		select	@curLoop = '2400',
			@Other2400QTYLoopCount = 2,
			@L2400_2_qty01_qty_qual = LTrim(RTrim(@col002)),
			@L2400_2_qty02_anesthesia_unit_count = LTrim(RTrim(@col003))
	end
-- FIRST 2400 LOOP
	if ( RTrim(@col001) = 'QTY' AND @curLoop LIKE '24%' AND @Other2400QTYLoopCount = 0)
	begin
		select	@curLoop = '2400',
			@Other2400QTYLoopCount = 1,
			@L2400_1_qty01_qty_qual = LTrim(RTrim(@col002)),
			@L2400_1_qty02_anesthesia_unit_count = LTrim(RTrim(@col003))
	end

	if ( RTrim(@col001) = 'REF' AND RTrim(@col002) = 'G3' )
	begin
		set @L2400_ref02_G3_predetermination_of_benefits_id = LTrim(RTrim(@col003))
	end

	if ( RTrim(@col001) = 'REF' AND RTrim(@col002) = '9F' )
	begin
		set @L2400_ref02_9F_referral_number = LTrim(RTrim(@col003))
	end

	if ( RTrim(@col001) = 'REF' AND RTrim(@col002) = 'G1' )
	begin
		set @L2400_ref02_G1_prior_auth_number = LTrim(RTrim(@col003))
	end

	if ( RTrim(@col001) = 'REF' AND RTrim(@col002) = '6R' )
	begin
		set @L2400_ref02_6R_line_item_control_num = LTrim(RTrim(@col003))
	end

	if ( RTrim(@col001) = 'NTE' AND @curLoop = '2400' )
	begin
		select	@L2400_nte01_note_ref_code = LTrim(RTrim(@col002)),
			@L2400_nte02_line_note_text = LTrim(RTrim(@col003))
	end
-- Line Item Rendering Provider Loop
	if ( RTrim(@col001) = 'NM1' AND RTrim(@col002) = '82' AND Left(@curLoop, 2) = '24' )
	begin
		select	@curLoop = '2420A',
			@L2420A_nm102_entity_type_qual = LTrim(RTrim(@col003)),
			@L2420A_nm103_rendering_prov_last_nm = LTrim(RTrim(@col004)),
			@L2420A_nm104_rendering_prov_first_nm = LTrim(RTrim(@col005)),
			@L2420A_nm105_rendering_prov_middle_nm = LTrim(RTrim(@col006)),
			@L2420A_nm107_rendering_prov_suffix = LTrim(RTrim(@col008)),
			@L2420A_nm108_id_code_qual = LTrim(RTrim(@col009)),
			@L2420A_nm109_rendering_prov_id = LTrim(RTrim(@col010))
	end
	if ( RTrim(@col001) = 'PRV' AND @curLoop = '2420A' AND RTrim(@col002) = 'PE' )
	begin
		select	@L2420A_prv01_provider_code = LTrim(RTrim(@col002)),
			@L2420A_prv02_ref_id_qual = LTrim(RTrim(@col003)),
			@L2420A_prv03_taxonomy_code = LTrim(RTrim(@col004))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420A' AND RTrim(@col002) = '1C' )
	begin
		set @L2420A_ref02_1C_rendering_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420A' AND RTrim(@col002) = '1D' )
	begin
		set @L2420A_ref02_1D_rendering_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420A' AND RTrim(@col002) = '1E' )
	begin
		set @L2420A_ref02_1E_rendering_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420A' AND RTrim(@col002) = 'EI' )
	begin
		set @L2420A_ref02_EI_rendering_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420A' AND RTrim(@col002) = 'SY' )
	begin
		set @L2420A_ref02_SY_rendering_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420A' AND RTrim(@col002) = 'TJ' )
	begin
		set @L2420A_ref02_TJ_rendering_prov_id = LTrim(RTrim(@col003))
	end
-- END LOOP: Line Item Rendering Provider
-- Line Item Service Facility Loop
	if ( RTrim(@col001) = 'NM1' AND Left(@curLoop, 2) = '24' AND RTrim(@col002) = 'DD')
	begin
		select	@curLoop = '2420C',
			@L2420C_nm101_entity_id_code = LTrim(RTrim(@col002)),
			@L2420C_nm102_entity_type_qual = LTrim(RTrim(@col003)),
			@L2420C_nm103_assistant_surgeon_last_nm = LTrim(RTrim(@col004)),
			@L2420C_nm104_assistant_surgeon_first_nm = LTrim(RTrim(@col005)),
			@L2420C_nm105_assistant_surgeon_middle_nm = LTrim(RTrim(@col006)),
			@L2420C_nm107_assistant_surgeon_suffix = LTrim(RTrim(@col008)),
			@L2420C_nm108_id_code_qual = LTrim(RTrim(@col009)),
			@L2420C_nm109_assistant_surgeon_id = LTrim(RTrim(@col010))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2420C' AND RTrim(@col002) = '1C' )
	begin
		set @L2420C_ref02_1C_service_facility_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2420C' AND RTrim(@col002) = '1D' )
	begin
		set @L2420C_ref02_1D_service_facility_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2420C' AND RTrim(@col002) = '1E' )
	begin
		set @L2420C_ref02_1E_service_facility_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2420C' AND RTrim(@col002) = 'G2' )
	begin
		set @L2420C_ref02_G2_service_facility_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2420C' AND RTrim(@col002) = 'TJ' )
	begin
		set @L2420C_ref02_TJ_service_facility_id = LTrim(RTrim(@col003))
	end

	-- Get SV1 service information (this segment is essentially the "header" of the detail section)
	if ( RTrim(@col001) = 'SVD' )
	begin
		set @curLoop = '2430'
		-- col004 will be a string like "AD:T1016:HN" where AD signifies the code type, T1016 is the code, and HN is the modifier
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
			if (@loopcount = 1) set @L2430_svd03_service_id_qual = Left(@ProcString, @EndStringPos)
			if (@loopcount = 2) set @L2430_svd03_proc_code = Left(@ProcString, @EndStringPos)
			if (@loopcount = 3) set @L2430_svd03_proc_mod1 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 4) set @L2430_svd03_proc_mod2 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 5) set @L2430_svd03_proc_mod3 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 6) set @L2430_svd03_proc_mod4 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 7) set @L2430_svd03_proc_code_desc = Left(@ProcString, @EndStringPos)
			if (@ColonPos > 0)
				set @ProcString = Right(@ProcString, Len(@ProcString)-@ColonPos)
			else
				set @ProcString = null
		end
		-- Dental codes will look like this, "AD:0217"
		if (@L2430_svd03_service_id_qual = 'AD')
		begin
			 -- AD means American Dental Association Code
			set @L2430_svd03_proc_code = Right(RTrim(@L2430_svd03_proc_code), 5) -- the first digit is a 0, leave that off.
		end

		set @L2430_svd01_other_payer_id = LTrim(RTrim(@col002))
		set @L2430_svd02_service_line_paid = CAST(LTrim(RTrim(@col003)) as money)
		set @L2430_svd05_paid_service_unit = LTrim(RTrim(@col006))
		set @L2430_svd06_bundled_unbundled_line_num = LTrim(RTrim(@col007))
	end

	if (RTrim(@col001) = 'CAS' AND @curLoop = '2430')
	begin
		select	@curLoop = '2430',
			@L2430_cas01_adjustment_group_code = LTrim(RTrim(@col002)),
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

	if (RTrim(@col001) = 'DTP' AND @curLoop = '2430' AND RTrim(@col002) = '573' )
	begin
		select	@curLoop = '2430',
			@L2430_dtp03_573_date_claim_paid = LTrim(RTrim(@col004))
	end

	-- Claim Header Segment
	if ( RTrim(@col001) = 'CLM' )
	begin
		select	@curLoop = '2300',
		-- set the new claim and ICN values
			@prev_L2300_clm01_pt_acct_num = @L2300_clm01_pt_acct_num,
			@L2300_clm01_pt_acct_num = LTRIM(RTRIM(@Col002)),
			@L2300_clm02_total_claim_chg_amt = CAST(LTRIM(RTRIM(@Col003)) as money),
			@ColonPos = CHARINDEX(@isa16_component_element_seperator, LTRIM(RTRIM(@Col006))),	-- find the first colon position
			@L2300_clm05_facility_type_code = Left( LTRIM(RTRIM(@Col006)), @ColonPos-1 ),
			@L2300_clm05_claim_freq_code = Substring( LTRIM(RTRIM(@Col006)), @ColonPos + 2, 1 ), -- +1 because there is an empty sub-element here
			@L2300_clm06_provider_signature_ind = LTRIM(RTRIM(@Col007)),
			@L2300_clm07_medicare_assign_code = LTRIM(RTRIM(@Col008)),
			@L2300_clm08_benefit_assign_ind = LTRIM(RTRIM(@Col009)),
			@L2300_clm09_release_of_info_code = LTRIM(RTRIM(@Col010)),
/*		whitea, TT4967, 8/28/2008: Per Chad, these can remain commented out.
			@L2300_clm11_related_causes_code1 = LTRIM(RTRIM(@Col012)),
			@L2300_clm11_related_causes_code2 = LTRIM(RTRIM(@Col012)),
			@L2300_clm11_related_causes_code3 = LTRIM(RTRIM(@Col012)),
			@L2300_clm11_auto_accident_state_code = LTRIM(RTRIM(@Col012)),
			@L2300_clm11_country_code = LTRIM(RTRIM(@Col012)),
*/
			@L2300_clm12_special_prog_ind = LTRIM(RTRIM(@Col013)),
			@L2300_clm19_claim_submission_reason_code = LTRIM(RTRIM(@Col020)),
			@L2300_clm20_delay_reason_code = LTRIM(RTRIM(@Col021))
	end

	if (@curLoop = '2300')
	begin
		if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '435' )
		begin
			set @L2300_dtp03_435_related_hospitalization_admission_date = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '096' )
		begin
			set @L2300_dtp03_096_discharge_end_of_care_date = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '330' )
		begin
			set @L2300_dtp03_330_referral_date = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '439' )
		begin
			set @L2300_dtp03_439_accident_date = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '452' )
		begin
			set @L2300_dtp03_452_orthodontic_banding_date = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '472' )
		begin
			set @L2300_dtp03_472_service_date = LTRIM(RTRIM(@Col004))
		end
	end

	if ( RTrim(@col001) = 'DN1' AND @CurLoop = '2300' )
	begin
		select	@L2300_dn101_orthodontic_treatment_months_count = LTRIM(RTRIM(@Col002)),
			@L2300_dn102_orthodontic_treatment_months_remaining_count = LTRIM(RTRIM(@Col003)),
			@L2300_dn103_question_response = LTRIM(RTRIM(@Col004))
	end
	
	if ( RTrim(@col001) = 'DN2' AND @CurLoop = '2300' )
	begin
			set @Other2300DNLoopCount = @Other2300DNLoopCount + 1
			set @SQLString = 
				'select 
					@L2300_' + cast(@Other2300DNLoopCount AS varchar) + '_dn201_tooth_number = LTRIM(RTRIM(@Col002)),
					@L2300_' + cast(@Other2300DNLoopCount AS varchar) + '_dn202_tooth_status_code = LTRIM(RTRIM(@Col003))'
			exec sp_executesql	@SQLString,
					N'@Col002 varchar(80), 
						@Col003 varchar(80),
						@L2300_1_dn201_tooth_number varchar(30) output,
						@L2300_1_dn202_tooth_status_code varchar(2) output,
						@L2300_2_dn201_tooth_number varchar(30) output,
						@L2300_2_dn202_tooth_status_code varchar(2) output,
						@L2300_3_dn201_tooth_number varchar(30) output,
						@L2300_3_dn202_tooth_status_code varchar(2) output,
						@L2300_4_dn201_tooth_number varchar(30) output,
						@L2300_4_dn202_tooth_status_code varchar(2) output,
						@L2300_5_dn201_tooth_number varchar(30) output,
						@L2300_5_dn202_tooth_status_code varchar(2) output,
						@L2300_6_dn201_tooth_number varchar(30) output,
						@L2300_6_dn202_tooth_status_code varchar(2) output,
						@L2300_7_dn201_tooth_number varchar(30) output,
						@L2300_7_dn202_tooth_status_code varchar(2) output,
						@L2300_8_dn201_tooth_number varchar(30) output,
						@L2300_8_dn202_tooth_status_code varchar(2) output,
						@L2300_9_dn201_tooth_number varchar(30) output,
						@L2300_9_dn202_tooth_status_code varchar(2) output,
						@L2300_10_dn201_tooth_number varchar(30) output,
						@L2300_10_dn202_tooth_status_code varchar(2) output,
						@L2300_11_dn201_tooth_number varchar(30) output,
						@L2300_11_dn202_tooth_status_code varchar(2) output,
						@L2300_12_dn201_tooth_number varchar(30) output,
						@L2300_12_dn202_tooth_status_code varchar(2) output,
						@L2300_13_dn201_tooth_number varchar(30) output,
						@L2300_13_dn202_tooth_status_code varchar(2) output,
						@L2300_14_dn201_tooth_number varchar(30) output,
						@L2300_14_dn202_tooth_status_code varchar(2) output,
						@L2300_15_dn201_tooth_number varchar(30) output,
						@L2300_15_dn202_tooth_status_code varchar(2) output,
						@L2300_16_dn201_tooth_number varchar(30) output,
						@L2300_16_dn202_tooth_status_code varchar(2) output,
						@L2300_17_dn201_tooth_number varchar(30) output,
						@L2300_17_dn202_tooth_status_code varchar(2) output,
						@L2300_18_dn201_tooth_number varchar(30) output,
						@L2300_18_dn202_tooth_status_code varchar(2) output,
						@L2300_19_dn201_tooth_number varchar(30) output,
						@L2300_19_dn202_tooth_status_code varchar(2) output,
						@L2300_20_dn201_tooth_number varchar(30) output,
						@L2300_20_dn202_tooth_status_code varchar(2) output,
						@L2300_21_dn201_tooth_number varchar(30) output,
						@L2300_21_dn202_tooth_status_code varchar(2) output,
						@L2300_22_dn201_tooth_number varchar(30) output,
						@L2300_22_dn202_tooth_status_code varchar(2) output,
						@L2300_23_dn201_tooth_number varchar(30) output,
						@L2300_23_dn202_tooth_status_code varchar(2) output,
						@L2300_24_dn201_tooth_number varchar(30) output,
						@L2300_24_dn202_tooth_status_code varchar(2) output,
						@L2300_25_dn201_tooth_number varchar(30) output,
						@L2300_25_dn202_tooth_status_code varchar(2) output,
						@L2300_26_dn201_tooth_number varchar(30) output,
						@L2300_26_dn202_tooth_status_code varchar(2) output,
						@L2300_27_dn201_tooth_number varchar(30) output,
						@L2300_27_dn202_tooth_status_code varchar(2) output,
						@L2300_28_dn201_tooth_number varchar(30) output,
						@L2300_28_dn202_tooth_status_code varchar(2) output,
						@L2300_29_dn201_tooth_number varchar(30) output,
						@L2300_29_dn202_tooth_status_code varchar(2) output,
						@L2300_30_dn201_tooth_number varchar(30) output,
						@L2300_30_dn202_tooth_status_code varchar(2) output,
						@L2300_31_dn201_tooth_number varchar(30) output,
						@L2300_31_dn202_tooth_status_code varchar(2) output,
						@L2300_32_dn201_tooth_number varchar(30) output,
						@L2300_32_dn202_tooth_status_code varchar(2) output,
						@L2300_33_dn201_tooth_number varchar(30) output,
						@L2300_33_dn202_tooth_status_code varchar(2) output,
						@L2300_34_dn201_tooth_number varchar(30) output,
						@L2300_34_dn202_tooth_status_code varchar(2) output,
						@L2300_35_dn201_tooth_number varchar(30) output,
						@L2300_35_dn202_tooth_status_code varchar(2) output',
						@Col002, 
						@Col003,
						@L2300_1_dn201_tooth_number output,
						@L2300_1_dn202_tooth_status_code output,
						@L2300_2_dn201_tooth_number output,
						@L2300_2_dn202_tooth_status_code output,
						@L2300_3_dn201_tooth_number output,
						@L2300_3_dn202_tooth_status_code output,
						@L2300_4_dn201_tooth_number output,
						@L2300_4_dn202_tooth_status_code output,
						@L2300_5_dn201_tooth_number output,
						@L2300_5_dn202_tooth_status_code output,
						@L2300_6_dn201_tooth_number output,
						@L2300_6_dn202_tooth_status_code output,
						@L2300_7_dn201_tooth_number output,
						@L2300_7_dn202_tooth_status_code output,
						@L2300_8_dn201_tooth_number output,
						@L2300_8_dn202_tooth_status_code output,
						@L2300_9_dn201_tooth_number output,
						@L2300_9_dn202_tooth_status_code output,
						@L2300_10_dn201_tooth_number output,
						@L2300_10_dn202_tooth_status_code output,
						@L2300_11_dn201_tooth_number output,
						@L2300_11_dn202_tooth_status_code output,
						@L2300_12_dn201_tooth_number output,
						@L2300_12_dn202_tooth_status_code output,
						@L2300_13_dn201_tooth_number output,
						@L2300_13_dn202_tooth_status_code output,
						@L2300_14_dn201_tooth_number output,
						@L2300_14_dn202_tooth_status_code output,
						@L2300_15_dn201_tooth_number output,
						@L2300_15_dn202_tooth_status_code output,
						@L2300_16_dn201_tooth_number output,
						@L2300_16_dn202_tooth_status_code output,
						@L2300_17_dn201_tooth_number output,
						@L2300_17_dn202_tooth_status_code output,
						@L2300_18_dn201_tooth_number output,
						@L2300_18_dn202_tooth_status_code output,
						@L2300_19_dn201_tooth_number output,
						@L2300_19_dn202_tooth_status_code output,
						@L2300_20_dn201_tooth_number output,
						@L2300_20_dn202_tooth_status_code output,
						@L2300_21_dn201_tooth_number output,
						@L2300_21_dn202_tooth_status_code output,
						@L2300_22_dn201_tooth_number output,
						@L2300_22_dn202_tooth_status_code output,
						@L2300_23_dn201_tooth_number output,
						@L2300_23_dn202_tooth_status_code output,
						@L2300_24_dn201_tooth_number output,
						@L2300_24_dn202_tooth_status_code output,
						@L2300_25_dn201_tooth_number output,
						@L2300_25_dn202_tooth_status_code output,
						@L2300_26_dn201_tooth_number output,
						@L2300_26_dn202_tooth_status_code output,
						@L2300_27_dn201_tooth_number output,
						@L2300_27_dn202_tooth_status_code output,
						@L2300_28_dn201_tooth_number output,
						@L2300_28_dn202_tooth_status_code output,
						@L2300_29_dn201_tooth_number output,
						@L2300_29_dn202_tooth_status_code output,
						@L2300_30_dn201_tooth_number output,
						@L2300_30_dn202_tooth_status_code output,
						@L2300_31_dn201_tooth_number output,
						@L2300_31_dn202_tooth_status_code output,
						@L2300_32_dn201_tooth_number output,
						@L2300_32_dn202_tooth_status_code output,
						@L2300_33_dn201_tooth_number output,
						@L2300_33_dn202_tooth_status_code output,
						@L2300_34_dn201_tooth_number output,
						@L2300_34_dn202_tooth_status_code output,
						@L2300_35_dn201_tooth_number output,
						@L2300_35_dn202_tooth_status_code output
	end

	if ( RTrim(@col001) = 'PWK' AND @CurLoop = '2300' )
	begin
		select	@L2300_pwk01_attachment_type_code = LTRIM(RTRIM(@Col002)),
			@L2300_pwk02_attachment_trans_code = LTRIM(RTRIM(@Col003)),
			@L2300_pwk06_attachment_control_num = LTRIM(RTRIM(@Col007))
	end
	
	if ( RTrim(@col001) = 'AMT' AND @CurLoop = '2300' AND RTrim(@col002) = 'F5' )
		set @L2300_amt02_patient_paid_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
	if ( RTrim(@col001) = 'AMT' AND @CurLoop = '2300' AND RTrim(@col002) = 'MA' )
		set @L2300_amt02_card_maximum_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
	
	if ( RTrim(@col001) = 'REF' AND @CurLoop = '2300' AND RTrim(@col002) = 'G3' )
		set @L2300_ref02_G3_predetermination_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @CurLoop = '2300' AND RTrim(@col002) = '4N' )
		set @L2300_ref02_4N_service_auth_exception_code = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @CurLoop = '2300' AND RTrim(@col002) = 'F8' )
		set @L2300_ref02_F8_original_ref_num = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @CurLoop = '2300' AND RTrim(@col002) = '9F' )
		set @L2300_ref02_9F_referral_num = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @CurLoop = '2300' AND RTrim(@col002) = 'G1' )
		set @L2300_ref02_G1_prior_auth_num = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @CurLoop = '2300' AND RTrim(@col002) = 'D9' )
		set @L2300_ref02_D9_value_added_network_trace_num = LTRIM(RTRIM(@Col003))
	
	if ( RTrim(@col001) = 'NTE' AND @CurLoop = '2300')
	begin
		select	@L2300_nte01_note_ref_code = LTRIM(RTRIM(@Col002)),
			@L2300_nte02_claim_note_text = LTRIM(RTRIM(@Col003))
	end

-- Claim Rendering Provider Loop
	if ( RTrim(@col001) = 'NM1' AND RTrim(@col002) = '82' AND Left(@curLoop, 2) = '23')
	begin
		select	@curLoop = '2310B',
			@L2310B_nm102_entity_type_qual = LTrim(RTrim(@col003)),
			@L2310B_nm103_rendering_prov_last_nm = LTrim(RTrim(@col004)),
			@L2310B_nm104_rendering_prov_first_nm = LTrim(RTrim(@col005)),
			@L2310B_nm105_rendering_prov_middle_nm = LTrim(RTrim(@col006)),
			@L2310B_nm107_rendering_prov_suffix = LTrim(RTrim(@col008)),
			@L2310B_nm108_id_code_qual = LTrim(RTrim(@col009)),
			@L2310B_nm109_rendering_prov_id = LTrim(RTrim(@col010))
	end
	if ( RTrim(@col001) = 'PRV' AND @curLoop = '2310B' AND RTrim(@col002) = 'PE' )
	begin
		select	@L2310B_prv01_provider_code = LTrim(RTrim(@col002)),
			@L2310B_prv02_ref_id_qual = LTrim(RTrim(@col003)),
			@L2310B_prv03_taxonomy_code = LTrim(RTrim(@col004))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310B' AND RTrim(@col002) = '1C' )
	begin
		set @L2310B_ref02_1C_rendering_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310B' AND RTrim(@col002) = '1D' )
	begin
		set @L2310B_ref02_1D_rendering_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310B' AND RTrim(@col002) = '1E' )
	begin
		set @L2310B_ref02_1E_rendering_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310B' AND RTrim(@col002) = 'EI' )
	begin
		set @L2310B_ref02_EI_rendering_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310B' AND RTrim(@col002) = 'G2' )
	begin
		set @L2310B_ref02_G2_rendering_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310B' AND RTrim(@col002) = 'SY' )
	begin
		set @L2310B_ref02_SY_rendering_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310B' AND RTrim(@col002) = 'TJ' )
	begin
		set @L2310B_ref02_TJ_rendering_prov_id = LTrim(RTrim(@col003))
	end

-- END LOOP: Claim Rendering Provider

-- Claim Lab or Facility Loop
	if ( RTrim(@col001) = 'NM1' AND RTrim(@col002) = 'FA' AND Left(@curLoop, 2) = '23')
	begin
		select	@curLoop = '2310C',
			@L2310C_nm102_entity_type_qual = LTrim(RTrim(@col003)),
			@L2310C_nm103_service_facility_last_nm = LTrim(RTrim(@col004)),
			@L2310C_nm108_id_code_qual = LTrim(RTrim(@col009)),
			@L2310C_nm109_service_facility_id = LTrim(RTrim(@col010))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = 'L2310C' AND RTrim(@col002) = '1C' )
	begin
		set @L2310C_ref02_1C_lab_or_facility_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = 'L2310C' AND RTrim(@col002) = '1D' )
	begin
		set @L2310C_ref02_1D_lab_or_facility_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = 'L2310C' AND RTrim(@col002) = '1G' )
	begin
		set @L2310C_ref02_1G_lab_or_facility_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = 'L2310C' AND RTrim(@col002) = 'G2' )
	begin
		set @L2310C_ref02_G2_lab_or_facility_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = 'L2310C' AND RTrim(@col002) = 'TJ' )
	begin
		set @L2310C_ref02_TJ_lab_or_facility_prov_id = LTrim(RTrim(@col003))
	end


-- Claim Service Facility Loop
	if ( RTrim(@col001) = 'NM1' AND Left(@curLoop, 2) = '23' AND RTrim(@col002) = 'DD')
	begin
		select	@curLoop = '2310D',
			@L2310D_nm102_entity_type_qual = LTrim(RTrim(@col003)),
			@L2310D_nm103_assistant_surgeon_last_nm = LTrim(RTrim(@col004)),
			@L2310D_nm104_assistant_surgeon_first_nm = LTrim(RTrim(@col005)),
			@L2310D_nm105_assistant_surgeon_middle_nm = LTrim(RTrim(@col006)),
			@L2310D_nm107_assistant_surgeon_suffix = LTrim(RTrim(@col008)),
			@L2310D_nm108_id_code_qual = LTrim(RTrim(@col009)),
			@L2310D_nm109_assistant_surgeon_prov_id = LTrim(RTrim(@col010))
	end
	if ( RTrim(@col001) = 'PRV' AND @curLoop = '2310D' )
	begin
		select	@L2310D_prv01_provider_code = LTrim(RTrim(@col002)),
			@L2310D_prv02_id_code_qual = LTrim(RTrim(@col003)),
			@L2310D_prv03_taxonomy_code = LTrim(RTrim(@col004))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310D' AND RTrim(@col002) = '1C' )
	begin
		set @L2310D_ref02_1C_service_facility_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310D' AND RTrim(@col002) = '1D' )
	begin
		set @L2310D_ref02_1D_service_facility_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310D' AND RTrim(@col002) = '1E' )
	begin
		set @L2310D_ref02_1E_service_facility_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310D' AND RTrim(@col002) = 'G2' )
	begin
		set @L2310D_ref02_G2_service_facility_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310D' AND RTrim(@col002) = 'TJ' )
	begin
		set @L2310D_ref02_TJ_service_facility_id = LTrim(RTrim(@col003))
	end

-- Claim Referring Provider Loop
	if ( RTrim(@col001) = 'NM1' AND (RTrim(@col002) = 'DN' OR RTrim(@col002) = 'P3') AND LEFT(@curLoop, 2) = '23' )
	begin
		select	@curLoop = '2310A',
			@L2310A_nm101_entity_id_code = LTrim(RTrim(@col002)),
			@L2310A_nm102_entity_type_qual = LTrim(RTrim(@col003)),
			@L2310A_nm103_referring_prov_last_nm = LTrim(RTrim(@col004)),
			@L2310A_nm104_referring_prov_first_nm = LTrim(RTrim(@col005)),
			@L2310A_nm105_referring_prov_middle_nm = LTrim(RTrim(@col006)),
			@L2310A_nm107_referring_prov_suffix = LTrim(RTrim(@col008)),
			@L2310A_nm108_id_code_qual = LTrim(RTrim(@col009)),
			@L2310A_nm109_referring_prov_id = LTrim(RTrim(@col010))
	end
	if ( RTrim(@col001) = 'PRV' AND @curLoop = '2310A' AND RTrim(@col002) = 'RF' )
	begin
		select	@L2310A_prv01_provider_code = LTrim(RTrim(@col002)),
			@L2310A_prv02_ref_id_qual = LTrim(RTrim(@col003)),
			@L2310A_prv03_taxonomy_code = LTrim(RTrim(@col004))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310A' AND RTrim(@col002) = '1C' )
	begin
		set @L2310A_ref02_1C_referring_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310A' AND RTrim(@col002) = '1D' )
	begin
		set @L2310A_ref02_1D_referring_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310A' AND RTrim(@col002) = '1E' )
	begin
		set @L2310A_ref02_1E_referring_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310A' AND RTrim(@col002) = 'EI' )
	begin
		set @L2310A_ref02_EI_referring_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310A' AND RTrim(@col002) = 'G2' )
	begin
		set @L2310A_ref02_G2_referring_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310A' AND RTrim(@col002) = 'SY' )
	begin
		set @L2310A_ref02_SY_referring_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310A' AND RTrim(@col002) = 'TJ' )
	begin
		set @L2310A_ref02_TJ_referring_prov_id = LTrim(RTrim(@col003))
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
				@L2320_3_1_cas01_adjustment_group_code = LTrim(RTrim(@col002)),
				@L2320_3_1_cas02_adjustment_reason_code = LTrim(RTrim(@col003)),
				@L2320_3_1_cas03_adjustment_amt = CAST(LTrim(RTrim(@col004)) as money),
				@L2320_3_1_cas04_adjustment_qty = LTrim(RTrim(@col005)),
				@L2320_3_1_cas05_adjustment_reason_code = LTrim(RTrim(@col006)),
				@L2320_3_1_cas06_adjustment_amt = CAST(LTrim(RTrim(@col007)) as money),
				@L2320_3_1_cas07_adjustment_qty = LTrim(RTrim(@col008)),
				@L2320_3_1_cas08_adjustment_reason_code = LTrim(RTrim(@col009)),
				@L2320_3_1_cas09_adjustment_amt = CAST(LTrim(RTrim(@col010)) as money),
				@L2320_3_1_cas10_adjustment_qty = LTrim(RTrim(@col011))
		end
	
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'D' )
		begin
			set @L2320_3_amt02_D_payer_paid_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'AAE' )
		begin
			set @L2320_3_amt02_AAE_cob_approved_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'B6' )
		begin
			set @L2320_3_amt02_B6_cob_allowed_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'F2' )
		begin
			set @L2320_3_amt02_F2_patient_responsibility_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'AU' )
		begin
			set @L2320_3_amt02_AU_cob_covered_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'D8' )
		begin
			set @L2320_3_amt02_D8_discount_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'F5' )
		begin
			set @L2320_3_amt02_F5_payer_patient_paid_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
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

		if ( RTrim(@col001) = 'N3' AND @curLoop = '2330A' )
		begin
			select
				@L2330A_3_n301_other_subscriber_address1 = LTrim(RTrim(@col002)),
				@L2330A_3_n302_other_subscriber_address2 = LTrim(RTrim(@col003))
		end

		if ( RTrim(@col001) = 'N4' AND @curLoop = '2330A' )
		begin
			select
				@L2330A_3_n401_other_subscriber_city = LTrim(RTrim(@col002)),
				@L2330A_3_n402_other_subscriber_state = LTrim(RTrim(@col003)),
				@L2330A_3_n403_other_subscriber_zip = LTrim(RTrim(@col004)),
				@L2330A_3_n404_other_subscriber_country = LTrim(RTrim(@col005))
		end

		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330A' AND RTrim(@col002) = '1W' )
		begin
			set @L2330A_3_ref02_1W_other_subscriber_sup_id = LTrim(RTrim(@col003))
		end

		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330A' AND RTrim(@col002) = '23' )
		begin
			set @L2330A_3_ref02_23_other_subscriber_sup_id = LTrim(RTrim(@col003))
		end

		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330A' AND RTrim(@col002) = 'IG' )
		begin
			set @L2330A_3_ref02_IG_other_subscriber_sup_id = LTrim(RTrim(@col003))
		end

		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330A' AND RTrim(@col002) = 'SY' )
		begin
			set @L2330A_3_ref02_SY_other_subscriber_sup_id = LTrim(RTrim(@col003))
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
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = 'T4' )
		begin
			set @L2330B_3_ref02_T4_other_payer_claim_adj_ind = LTrim(RTrim(@col003))
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
				@L2320_2_1_cas01_adjustment_group_code = LTrim(RTrim(@col002)),
				@L2320_2_1_cas02_adjustment_reason_code = LTrim(RTrim(@col003)),
				@L2320_2_1_cas03_adjustment_amt = CAST(LTrim(RTrim(@col004)) as money),
				@L2320_2_1_cas04_adjustment_qty = LTrim(RTrim(@col005)),
				@L2320_2_1_cas05_adjustment_reason_code = LTrim(RTrim(@col006)),
				@L2320_2_1_cas06_adjustment_amt = CAST(LTrim(RTrim(@col007)) as money),
				@L2320_2_1_cas07_adjustment_qty = LTrim(RTrim(@col008)),
				@L2320_2_1_cas08_adjustment_reason_code = LTrim(RTrim(@col009)),
				@L2320_2_1_cas09_adjustment_amt = CAST(LTrim(RTrim(@col010)) as money),
				@L2320_2_1_cas10_adjustment_qty = LTrim(RTrim(@col011))
		end
	
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'D' )
		begin
			set @L2320_2_amt02_D_payer_paid_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'AAE' )
		begin
			set @L2320_2_amt02_AAE_cob_approved_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'B6' )
		begin
			set @L2320_2_amt02_B6_cob_allowed_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'F2' )
		begin
			set @L2320_2_amt02_F2_patient_responsibility_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'AU' )
		begin
			set @L2320_2_amt02_AU_cob_covered_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'D8' )
		begin
			set @L2320_2_amt02_D8_discount_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'F5' )
		begin
			set @L2320_2_amt02_F5_payer_patient_paid_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
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

		if ( RTrim(@col001) = 'N3' AND @curLoop = '2330A' )
		begin
			select
				@L2330A_2_n301_other_subscriber_address1 = LTrim(RTrim(@col002)),
				@L2330A_2_n302_other_subscriber_address2 = LTrim(RTrim(@col003))
		end

		if ( RTrim(@col001) = 'N4' AND @curLoop = '2330A' )
		begin
			select
				@L2330A_2_n401_other_subscriber_city = LTrim(RTrim(@col002)),
				@L2330A_2_n402_other_subscriber_state = LTrim(RTrim(@col003)),
				@L2330A_2_n403_other_subscriber_zip = LTrim(RTrim(@col004)),
				@L2330A_2_n404_other_subscriber_country = LTrim(RTrim(@col005))
		end

		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330A' AND RTrim(@col002) = '1W' )
		begin
			set @L2330A_2_ref02_1W_other_subscriber_sup_id = LTrim(RTrim(@col003))
		end

		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330A' AND RTrim(@col002) = '23' )
		begin
			set @L2330A_2_ref02_23_other_subscriber_sup_id = LTrim(RTrim(@col003))
		end

		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330A' AND RTrim(@col002) = 'IG' )
		begin
			set @L2330A_2_ref02_IG_other_subscriber_sup_id = LTrim(RTrim(@col003))
		end

		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330A' AND RTrim(@col002) = 'SY' )
		begin
			set @L2330A_2_ref02_SY_other_subscriber_sup_id = LTrim(RTrim(@col003))
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
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = 'T4' )
		begin
			set @L2330B_2_ref02_T4_other_payer_claim_adj_ind = LTrim(RTrim(@col003))
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
				@L2320_1_1_cas01_adjustment_group_code = LTrim(RTrim(@col002)),
				@L2320_1_1_cas02_adjustment_reason_code = LTrim(RTrim(@col003)),
				@L2320_1_1_cas03_adjustment_amt = CAST(LTrim(RTrim(@col004)) as money),
				@L2320_1_1_cas04_adjustment_qty = LTrim(RTrim(@col005)),
				@L2320_1_1_cas05_adjustment_reason_code = LTrim(RTrim(@col006)),
				@L2320_1_1_cas06_adjustment_amt = CAST(LTrim(RTrim(@col007)) as money),
				@L2320_1_1_cas07_adjustment_qty = LTrim(RTrim(@col008)),
				@L2320_1_1_cas08_adjustment_reason_code = LTrim(RTrim(@col009)),
				@L2320_1_1_cas09_adjustment_amt = CAST(LTrim(RTrim(@col010)) as money),
				@L2320_1_1_cas10_adjustment_qty = LTrim(RTrim(@col011))
		end
	
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'D' )
		begin
			set @L2320_1_amt02_D_payer_paid_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'AAE' )
		begin
			set @L2320_1_amt02_AAE_cob_approved_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'B6' )
		begin
			set @L2320_1_amt02_B6_cob_allowed_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'F2' )
		begin
			set @L2320_1_amt02_F2_patient_responsibility_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'AU' )
		begin
			set @L2320_1_amt02_AU_cob_covered_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'D8' )
		begin
			set @L2320_1_amt02_D8_discount_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		end
		if ( RTrim(@col001) = 'AMT' AND @curLoop = '2320' AND RTrim(@col002) = 'F5' )
		begin
			set @L2320_1_amt02_F5_payer_patient_paid_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
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
		if ( RTrim(@col001) = 'NM1' AND RTrim(@col002) = 'IL' AND @curLoop = '2320' )
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

		if ( RTrim(@col001) = 'N3' AND @curLoop = '2330A' )
		begin
			select
				@L2330A_1_n301_other_subscriber_address1 = LTrim(RTrim(@col002)),
				@L2330A_1_n302_other_subscriber_address2 = LTrim(RTrim(@col003))
		end

		if ( RTrim(@col001) = 'N4' AND @curLoop = '2330A' )
		begin
			select
				@L2330A_1_n401_other_subscriber_city = LTrim(RTrim(@col002)),
				@L2330A_1_n402_other_subscriber_state = LTrim(RTrim(@col003)),
				@L2330A_1_n403_other_subscriber_zip = LTrim(RTrim(@col004)),
				@L2330A_1_n404_other_subscriber_country = LTrim(RTrim(@col005))
		end

		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330A' AND RTrim(@col002) = '1W' )
		begin
			set @L2330A_1_ref02_1W_other_subscriber_sup_id = LTrim(RTrim(@col003))
		end

		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330A' AND RTrim(@col002) = '23' )
		begin
			set @L2330A_1_ref02_23_other_subscriber_sup_id = LTrim(RTrim(@col003))
		end

		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330A' AND RTrim(@col002) = 'IG' )
		begin
			set @L2330A_1_ref02_IG_other_subscriber_sup_id = LTrim(RTrim(@col003))
		end

		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330A' AND RTrim(@col002) = 'SY' )
		begin
			set @L2330A_1_ref02_SY_other_subscriber_sup_id = LTrim(RTrim(@col003))
		end
	
		if ( RTrim(@col001) = 'NM1' AND RTrim(@col002) = 'PR' AND @curLoop LIKE '23%')  
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
		if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B' AND RTrim(@col002) = 'T4' )
		begin
			set @L2330B_1_ref02_T4_other_payer_claim_adj_ind = LTrim(RTrim(@col003))
		end
	end -- END FIRST 2320 LOOP

	FETCH NEXT FROM curt837d INTO @Col001, @Col002, @Col003, @Col004, @Col005, @Col006, @Col007, @Col008, @Col009, @Col010, @Col011, @Col012, @Col013, @Col014, @Col015, @Col016, @Col017, @Col018, @Col019, @Col020, @Col021
END
CLOSE curt837d
DEALLOCATE curt837d
-- after going through the recordset, the last record must be inserted because we're done with the last service line in the file
			insert into x12_837_claim_dental
						(	x12_transaction_id,
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
							L2010AA_ref02_1C_billing_prov_id,
							L2010AA_ref02_1D_billing_prov_id,
							L2010AA_ref02_1E_billing_prov_id,
							L2010AA_ref02_EI_billing_prov_id,
							L2010AA_ref02_SY_billing_prov_id,
							L2010AA_ref02_TJ_billing_prov_id,
							L2010AA_ref02_06_card_billing_id,
							L2010AA_ref02_8U_card_billing_id,
							L2010AA_ref02_EM_card_billing_id,
							L2010AA_ref02_IJ_card_billing_id,
							L2010AA_ref02_LU_card_billing_id,
							L2010AA_ref02_ST_card_billing_id,
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
							L2010AB_ref02_1E_payto_prov_id,
							L2010AB_ref02_EI_payto_prov_id,
							L2010AB_ref02_SY_payto_prov_id,
							L2010AB_ref02_TJ_payto_prov_id,
							L2000B_hl01_hierarchical_id_num,
							L2000B_hl02_hierarchical_parent_id_num,
							L2000B_hl03_hierarchical_level_code,
							L2000B_hl04_hierarchical_child_code,
							L2000B_sbr01_payer_resp_seq_code,
							L2000B_sbr02_ind_relationship_code,
							L2000B_sbr03_insured_grp_policy_num,
							L2000B_sbr04_insured_grp_nm,
							L2000B_sbr06_cob_code,
							L2000B_sbr09_claim_filing_ind_code,
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
							L2010BB_nm103_payer_nm,
							L2010BB_nm108_payer_id_qual,
							L2010BB_nm109_payer_id,
							L2010BB_n301_payer_address1,
							L2010BB_n302_payer_address2,
							L2010BB_n401_payer_city,
							L2010BB_n402_payer_state,
							L2010BB_n403_payer_zip,
							L2010BB_n404_payer_country,
							L2010BB_ref02_2U_payer_id,
							L2010BB_ref02_FY_payer_id,
							L2010BB_ref02_NF_payer_id,
							L2010BB_ref02_TJ_payer_id,
							L2010BC_nm102_entity_type_qual,
							L2010BC_nm103_resp_party_last_nm,
							L2010BC_nm104_resp_party_first_nm,
							L2010BC_nm105_resp_party_middle_nm,
							L2010BC_nm107_resp_party_suffix,
							L2010BC_nm109_MI_card_num,
							L2010BC_ref02_BB_card_num,
							L2000C_hl01_hierarchical_id_num,
							L2000C_hl02_hierarchical_parent_id_num,
							L2000C_hl03_hierarchical_level_code,
							L2000C_hl04_hierarchical_child_code,
							L2000C_pat01_ind_relationship_code,
							L2000C_pat04_student_status_code,
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
							L2300_clm05_claim_freq_code,
							L2300_clm06_provider_signature_ind,
							L2300_clm07_medicare_assign_code,
							L2300_clm08_benefit_assign_ind,
							L2300_clm09_release_of_info_code,
							L2300_clm11_related_causes_code1,
							L2300_clm11_related_causes_code2,
							L2300_clm11_related_causes_code3,
							L2300_clm11_auto_accident_state_code,
							L2300_clm11_country_code,
							L2300_clm12_special_prog_ind,
							L2300_clm19_claim_submission_reason_code,
							L2300_clm20_delay_reason_code,
							L2300_dtp03_435_related_hospitalization_admission_date,
							L2300_dtp03_096_discharge_end_of_care_date,
							L2300_dtp03_330_referral_date,
							L2300_dtp03_439_accident_date,
							L2300_dtp03_452_orthodontic_banding_date,
							L2300_dtp03_472_service_date,
							L2300_dn101_orthodontic_treatment_months_count,
							L2300_dn102_orthodontic_treatment_months_remaining_count,
							L2300_dn103_question_response,
							L2300_1_dn201_tooth_number,
							L2300_1_dn202_tooth_status_code,
							L2300_2_dn201_tooth_number,
							L2300_2_dn202_tooth_status_code,
							L2300_3_dn201_tooth_number,
							L2300_3_dn202_tooth_status_code,
							L2300_4_dn201_tooth_number,
							L2300_4_dn202_tooth_status_code,
							L2300_5_dn201_tooth_number,
							L2300_5_dn202_tooth_status_code,
							L2300_6_dn201_tooth_number,
							L2300_6_dn202_tooth_status_code,
							L2300_7_dn201_tooth_number,
							L2300_7_dn202_tooth_status_code,
							L2300_8_dn201_tooth_number,
							L2300_8_dn202_tooth_status_code,
							L2300_9_dn201_tooth_number,
							L2300_9_dn202_tooth_status_code,
							L2300_10_dn201_tooth_number,
							L2300_10_dn202_tooth_status_code,
							L2300_11_dn201_tooth_number,
							L2300_11_dn202_tooth_status_code,
							L2300_12_dn201_tooth_number,
							L2300_12_dn202_tooth_status_code,
							L2300_13_dn201_tooth_number,
							L2300_13_dn202_tooth_status_code,
							L2300_14_dn201_tooth_number,
							L2300_14_dn202_tooth_status_code,
							L2300_15_dn201_tooth_number,
							L2300_15_dn202_tooth_status_code,
							L2300_16_dn201_tooth_number,
							L2300_16_dn202_tooth_status_code,
							L2300_17_dn201_tooth_number,
							L2300_17_dn202_tooth_status_code,
							L2300_18_dn201_tooth_number,
							L2300_18_dn202_tooth_status_code,
							L2300_19_dn201_tooth_number,
							L2300_19_dn202_tooth_status_code,
							L2300_20_dn201_tooth_number,
							L2300_20_dn202_tooth_status_code,
							L2300_21_dn201_tooth_number,
							L2300_21_dn202_tooth_status_code,
							L2300_22_dn201_tooth_number,
							L2300_22_dn202_tooth_status_code,
							L2300_23_dn201_tooth_number,
							L2300_23_dn202_tooth_status_code,
							L2300_24_dn201_tooth_number,
							L2300_24_dn202_tooth_status_code,
							L2300_25_dn201_tooth_number,
							L2300_25_dn202_tooth_status_code,
							L2300_26_dn201_tooth_number,
							L2300_26_dn202_tooth_status_code,
							L2300_27_dn201_tooth_number,
							L2300_27_dn202_tooth_status_code,
							L2300_28_dn201_tooth_number,
							L2300_28_dn202_tooth_status_code,
							L2300_29_dn201_tooth_number,
							L2300_29_dn202_tooth_status_code,
							L2300_30_dn201_tooth_number,
							L2300_30_dn202_tooth_status_code,
							L2300_31_dn201_tooth_number,
							L2300_31_dn202_tooth_status_code,
							L2300_32_dn201_tooth_number,
							L2300_32_dn202_tooth_status_code,
							L2300_33_dn201_tooth_number,
							L2300_33_dn202_tooth_status_code,
							L2300_34_dn201_tooth_number,
							L2300_34_dn202_tooth_status_code,
							L2300_35_dn201_tooth_number,
							L2300_35_dn202_tooth_status_code,
							L2300_pwk01_attachment_type_code,
							L2300_pwk02_attachment_trans_code,
							L2300_pwk06_attachment_control_num,
							L2300_amt02_patient_paid_amt,
							L2300_amt02_card_maximum_amt,
							L2300_ref02_G3_predetermination_id,
							L2300_ref02_4N_service_auth_exception_code,
							L2300_ref02_F8_original_ref_num,
							L2300_ref02_9F_referral_num,
							L2300_ref02_G1_prior_auth_num,
							L2300_ref02_D9_value_added_network_trace_num,
							L2300_nte01_note_ref_code,
							L2300_nte02_claim_note_text,
							L2310A_nm101_entity_id_code,
							L2310A_nm102_entity_type_qual,
							L2310A_nm103_referring_prov_last_nm,
							L2310A_nm104_referring_prov_first_nm,
							L2310A_nm105_referring_prov_middle_nm,
							L2310A_nm107_referring_prov_suffix,
							L2310A_nm108_id_code_qual,
							L2310A_nm109_referring_prov_id,
							L2310A_prv01_provider_code,
							L2310A_prv02_ref_id_qual,
							L2310A_prv03_taxonomy_code,
							L2310A_ref02_1C_referring_prov_id,
							L2310A_ref02_1D_referring_prov_id,
							L2310A_ref02_1E_referring_prov_id,
							L2310A_ref02_EI_referring_prov_id,
							L2310A_ref02_G2_referring_prov_id,
							L2310A_ref02_SY_referring_prov_id,
							L2310A_ref02_TJ_referring_prov_id,
							L2310B_nm102_entity_type_qual,
							L2310B_nm103_rendering_prov_last_nm,
							L2310B_nm104_rendering_prov_first_nm,
							L2310B_nm105_rendering_prov_middle_nm,
							L2310B_nm107_rendering_prov_suffix,
							L2310B_nm108_id_code_qual,
							L2310B_nm109_rendering_prov_id,
							L2310B_prv01_provider_code,
							L2310B_prv02_ref_id_qual,
							L2310B_prv03_taxonomy_code,
							L2310B_ref02_1C_rendering_prov_id,
							L2310B_ref02_1D_rendering_prov_id,
							L2310B_ref02_1E_rendering_prov_id,
							L2310B_ref02_EI_rendering_prov_id,
							L2310B_ref02_G2_rendering_prov_id,
							L2310B_ref02_SY_rendering_prov_id,
							L2310B_ref02_TJ_rendering_prov_id,
							L2310C_nm102_entity_type_qual,
							L2310C_nm103_service_facility_last_nm,
							L2310C_nm108_id_code_qual,
							L2310C_nm109_service_facility_id,
							L2310C_ref02_1C_lab_or_facility_prov_id,
							L2310C_ref02_1D_lab_or_facility_prov_id,
							L2310C_ref02_1G_lab_or_facility_prov_id,
							L2310C_ref02_G2_lab_or_facility_prov_id,
							L2310C_ref02_TJ_lab_or_facility_prov_id,
							L2310D_nm102_entity_type_qual,
							L2310D_nm103_assistant_surgeon_last_nm,
							L2310D_nm104_assistant_surgeon_first_nm,
							L2310D_nm105_assistant_surgeon_middle_nm,
							L2310D_nm107_assistant_surgeon_suffix,
							L2310D_nm108_id_code_qual,
							L2310D_nm109_assistant_surgeon_prov_id,
							L2310D_prv01_provider_code,
							L2310D_prv02_id_code_qual,
							L2310D_prv03_taxonomy_code,
							L2310D_ref02_1C_service_facility_id,
							L2310D_ref02_1D_service_facility_id,
							L2310D_ref02_1E_service_facility_id,
							L2310D_ref02_G2_service_facility_id,
							L2310D_ref02_TJ_service_facility_id,
							L2320_1_sbr01_payer_resp_seq_code,
							L2320_1_sbr02_ind_relationship_code,
							L2320_1_sbr03_insured_grp_policy_num,
							L2320_1_sbr04_insured_grp_nm,
							L2320_1_sbr09_claim_file_ind_code,
							L2320_1_1_cas01_adjustment_group_code,
							L2320_1_1_cas02_adjustment_reason_code,
							L2320_1_1_cas03_adjustment_amt,
							L2320_1_1_cas04_adjustment_qty,
							L2320_1_1_cas05_adjustment_reason_code,
							L2320_1_1_cas06_adjustment_amt,
							L2320_1_1_cas07_adjustment_qty,
							L2320_1_1_cas08_adjustment_reason_code,
							L2320_1_1_cas09_adjustment_amt,
							L2320_1_1_cas10_adjustment_qty,
							L2320_1_2_cas01_adjustment_group_code,
							L2320_1_2_cas02_adjustment_reason_code,
							L2320_1_2_cas03_adjustment_amt,
							L2320_1_2_cas04_adjustment_qty,
							L2320_1_2_cas05_adjustment_reason_code,
							L2320_1_2_cas06_adjustment_amt,
							L2320_1_2_cas07_adjustment_qty,
							L2320_1_2_cas08_adjustment_reason_code,
							L2320_1_2_cas09_adjustment_amt,
							L2320_1_2_cas10_adjustment_qty,
							L2320_1_3_cas01_adjustment_group_code,
							L2320_1_3_cas02_adjustment_reason_code,
							L2320_1_3_cas03_adjustment_amt,
							L2320_1_3_cas04_adjustment_qty,
							L2320_1_3_cas05_adjustment_reason_code,
							L2320_1_3_cas06_adjustment_amt,
							L2320_1_3_cas07_adjustment_qty,
							L2320_1_3_cas08_adjustment_reason_code,
							L2320_1_3_cas09_adjustment_amt,
							L2320_1_3_cas10_adjustment_qty,
							L2320_1_4_cas01_adjustment_group_code,
							L2320_1_4_cas02_adjustment_reason_code,
							L2320_1_4_cas03_adjustment_amt,
							L2320_1_4_cas04_adjustment_qty,
							L2320_1_4_cas05_adjustment_reason_code,
							L2320_1_4_cas06_adjustment_amt,
							L2320_1_4_cas07_adjustment_qty,
							L2320_1_4_cas08_adjustment_reason_code,
							L2320_1_4_cas09_adjustment_amt,
							L2320_1_4_cas10_adjustment_qty,
							L2320_1_5_cas01_adjustment_group_code,
							L2320_1_5_cas02_adjustment_reason_code,
							L2320_1_5_cas03_adjustment_amt,
							L2320_1_5_cas04_adjustment_qty,
							L2320_1_5_cas05_adjustment_reason_code,
							L2320_1_5_cas06_adjustment_amt,
							L2320_1_5_cas07_adjustment_qty,
							L2320_1_5_cas08_adjustment_reason_code,
							L2320_1_5_cas09_adjustment_amt,
							L2320_1_5_cas10_adjustment_qty,
							L2320_1_amt02_D_payer_paid_amt,
							L2320_1_amt02_AAE_cob_approved_amt,
							L2320_1_amt02_B6_cob_allowed_amt,
							L2320_1_amt02_F2_patient_responsibility_amt,
							L2320_1_amt02_AU_cob_covered_amt,
							L2320_1_amt02_D8_discount_amt,
							L2320_1_amt02_F5_payer_patient_paid_amt,
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
							L2330A_1_n301_other_subscriber_address1,
							L2330A_1_n302_other_subscriber_address2,
							L2330A_1_n401_other_subscriber_city,
							L2330A_1_n402_other_subscriber_state,
							L2330A_1_n403_other_subscriber_zip,
							L2330A_1_n404_other_subscriber_country,
							L2330A_1_ref02_1W_other_subscriber_sup_id,
							L2330A_1_ref02_23_other_subscriber_sup_id,
							L2330A_1_ref02_IG_other_subscriber_sup_id,
							L2330A_1_ref02_SY_other_subscriber_sup_id,
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
							L2330B_1_ref02_T4_other_payer_claim_adj_ind,
							L2320_2_sbr01_payer_resp_seq_code,
							L2320_2_sbr02_ind_relationship_code,
							L2320_2_sbr03_insured_grp_policy_num,
							L2320_2_sbr04_insured_grp_nm,
							L2320_2_sbr09_claim_file_ind_code,
							L2320_2_1_cas01_adjustment_group_code,
							L2320_2_1_cas02_adjustment_reason_code,
							L2320_2_1_cas03_adjustment_amt,
							L2320_2_1_cas04_adjustment_qty,
							L2320_2_1_cas05_adjustment_reason_code,
							L2320_2_1_cas06_adjustment_amt,
							L2320_2_1_cas07_adjustment_qty,
							L2320_2_1_cas08_adjustment_reason_code,
							L2320_2_1_cas09_adjustment_amt,
							L2320_2_1_cas10_adjustment_qty,
							L2320_2_2_cas01_adjustment_group_code,
							L2320_2_2_cas02_adjustment_reason_code,
							L2320_2_2_cas03_adjustment_amt,
							L2320_2_2_cas04_adjustment_qty,
							L2320_2_2_cas05_adjustment_reason_code,
							L2320_2_2_cas06_adjustment_amt,
							L2320_2_2_cas07_adjustment_qty,
							L2320_2_2_cas08_adjustment_reason_code,
							L2320_2_2_cas09_adjustment_amt,
							L2320_2_2_cas10_adjustment_qty,
							L2320_2_3_cas01_adjustment_group_code,
							L2320_2_3_cas02_adjustment_reason_code,
							L2320_2_3_cas03_adjustment_amt,
							L2320_2_3_cas04_adjustment_qty,
							L2320_2_3_cas05_adjustment_reason_code,
							L2320_2_3_cas06_adjustment_amt,
							L2320_2_3_cas07_adjustment_qty,
							L2320_2_3_cas08_adjustment_reason_code,
							L2320_2_3_cas09_adjustment_amt,
							L2320_2_3_cas10_adjustment_qty,
							L2320_2_4_cas01_adjustment_group_code,
							L2320_2_4_cas02_adjustment_reason_code,
							L2320_2_4_cas03_adjustment_amt,
							L2320_2_4_cas04_adjustment_qty,
							L2320_2_4_cas05_adjustment_reason_code,
							L2320_2_4_cas06_adjustment_amt,
							L2320_2_4_cas07_adjustment_qty,
							L2320_2_4_cas08_adjustment_reason_code,
							L2320_2_4_cas09_adjustment_amt,
							L2320_2_4_cas10_adjustment_qty,
							L2320_2_5_cas01_adjustment_group_code,
							L2320_2_5_cas02_adjustment_reason_code,
							L2320_2_5_cas03_adjustment_amt,
							L2320_2_5_cas04_adjustment_qty,
							L2320_2_5_cas05_adjustment_reason_code,
							L2320_2_5_cas06_adjustment_amt,
							L2320_2_5_cas07_adjustment_qty,
							L2320_2_5_cas08_adjustment_reason_code,
							L2320_2_5_cas09_adjustment_amt,
							L2320_2_5_cas10_adjustment_qty,
							L2320_2_amt02_D_payer_paid_amt,
							L2320_2_amt02_AAE_cob_approved_amt,
							L2320_2_amt02_B6_cob_allowed_amt,
							L2320_2_amt02_F2_patient_responsibility_amt,
							L2320_2_amt02_AU_cob_covered_amt,
							L2320_2_amt02_D8_discount_amt,
							L2320_2_amt02_F5_payer_patient_paid_amt,
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
							L2330A_2_n301_other_subscriber_address1,
							L2330A_2_n302_other_subscriber_address2,
							L2330A_2_n401_other_subscriber_city,
							L2330A_2_n402_other_subscriber_state,
							L2330A_2_n403_other_subscriber_zip,
							L2330A_2_n404_other_subscriber_country,
							L2330A_2_ref02_1W_other_subscriber_sup_id,
							L2330A_2_ref02_23_other_subscriber_sup_id,
							L2330A_2_ref02_IG_other_subscriber_sup_id,
							L2330A_2_ref02_SY_other_subscriber_sup_id,
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
							L2330B_2_ref02_T4_other_payer_claim_adj_ind,
							L2320_3_sbr01_payer_resp_seq_code,
							L2320_3_sbr02_ind_relationship_code,
							L2320_3_sbr03_insured_grp_policy_num,
							L2320_3_sbr04_insured_grp_nm,
							L2320_3_sbr09_claim_file_ind_code,
							L2320_3_1_cas01_adjustment_group_code,
							L2320_3_1_cas02_adjustment_reason_code,
							L2320_3_1_cas03_adjustment_amt,
							L2320_3_1_cas04_adjustment_qty,
							L2320_3_1_cas05_adjustment_reason_code,
							L2320_3_1_cas06_adjustment_amt,
							L2320_3_1_cas07_adjustment_qty,
							L2320_3_1_cas08_adjustment_reason_code,
							L2320_3_1_cas09_adjustment_amt,
							L2320_3_1_cas10_adjustment_qty,
							L2320_3_2_cas01_adjustment_group_code,
							L2320_3_2_cas02_adjustment_reason_code,
							L2320_3_2_cas03_adjustment_amt,
							L2320_3_2_cas04_adjustment_qty,
							L2320_3_2_cas05_adjustment_reason_code,
							L2320_3_2_cas06_adjustment_amt,
							L2320_3_2_cas07_adjustment_qty,
							L2320_3_2_cas08_adjustment_reason_code,
							L2320_3_2_cas09_adjustment_amt,
							L2320_3_2_cas10_adjustment_qty,
							L2320_3_3_cas01_adjustment_group_code,
							L2320_3_3_cas02_adjustment_reason_code,
							L2320_3_3_cas03_adjustment_amt,
							L2320_3_3_cas04_adjustment_qty,
							L2320_3_3_cas05_adjustment_reason_code,
							L2320_3_3_cas06_adjustment_amt,
							L2320_3_3_cas07_adjustment_qty,
							L2320_3_3_cas08_adjustment_reason_code,
							L2320_3_3_cas09_adjustment_amt,
							L2320_3_3_cas10_adjustment_qty,
							L2320_3_4_cas01_adjustment_group_code,
							L2320_3_4_cas02_adjustment_reason_code,
							L2320_3_4_cas03_adjustment_amt,
							L2320_3_4_cas04_adjustment_qty,
							L2320_3_4_cas05_adjustment_reason_code,
							L2320_3_4_cas06_adjustment_amt,
							L2320_3_4_cas07_adjustment_qty,
							L2320_3_4_cas08_adjustment_reason_code,
							L2320_3_4_cas09_adjustment_amt,
							L2320_3_4_cas10_adjustment_qty,
							L2320_3_5_cas01_adjustment_group_code,
							L2320_3_5_cas02_adjustment_reason_code,
							L2320_3_5_cas03_adjustment_amt,
							L2320_3_5_cas04_adjustment_qty,
							L2320_3_5_cas05_adjustment_reason_code,
							L2320_3_5_cas06_adjustment_amt,
							L2320_3_5_cas07_adjustment_qty,
							L2320_3_5_cas08_adjustment_reason_code,
							L2320_3_5_cas09_adjustment_amt,
							L2320_3_5_cas10_adjustment_qty,
							L2320_3_amt02_D_payer_paid_amt,
							L2320_3_amt02_AAE_cob_approved_amt,
							L2320_3_amt02_B6_cob_allowed_amt,
							L2320_3_amt02_F2_patient_responsibility_amt,
							L2320_3_amt02_AU_cob_covered_amt,
							L2320_3_amt02_D8_discount_amt,
							L2320_3_amt02_F5_payer_patient_paid_amt,
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
							L2330A_3_n301_other_subscriber_address1,
							L2330A_3_n302_other_subscriber_address2,
							L2330A_3_n401_other_subscriber_city,
							L2330A_3_n402_other_subscriber_state,
							L2330A_3_n403_other_subscriber_zip,
							L2330A_3_n404_other_subscriber_country,
							L2330A_3_ref02_1W_other_subscriber_sup_id,
							L2330A_3_ref02_23_other_subscriber_sup_id,
							L2330A_3_ref02_IG_other_subscriber_sup_id,
							L2330A_3_ref02_SY_other_subscriber_sup_id,
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
							L2330B_3_ref02_T4_other_payer_claim_adj_ind,
							L2400_lx01_assigned_num,
							L2400_sv301_proc_code_qual,
							L2400_sv301_proc_code,
							L2400_sv301_proc_mod1,
							L2400_sv301_proc_mod2,
							L2400_sv301_proc_mod3,
							L2400_sv301_proc_mod4,
							L2400_sv302_line_charge,
							L2400_sv303_facility_type_code,
							L2400_sv304_oral_cavity_designation_code_1,
							L2400_sv304_oral_cavity_designation_code_2,
							L2400_sv304_oral_cavity_designation_code_3,
							L2400_sv304_oral_cavity_designation_code_4,
							L2400_sv304_oral_cavity_designation_code_5,
							L2400_sv305_prosthesis_crown_inlay_code,
							L2400_sv306_procedure_count,
							L2400_1_too02_JP_tooth_code,
							L2400_1_too03_tooth_surface_code_1,
							L2400_1_too03_tooth_surface_code_2,
							L2400_1_too03_tooth_surface_code_3,
							L2400_1_too03_tooth_surface_code_4,
							L2400_1_too03_tooth_surface_code_5,
							L2400_2_too02_JP_tooth_code,
							L2400_2_too03_tooth_surface_code_1,
							L2400_2_too03_tooth_surface_code_2,
							L2400_2_too03_tooth_surface_code_3,
							L2400_2_too03_tooth_surface_code_4,
							L2400_2_too03_tooth_surface_code_5,
							L2400_3_too02_JP_tooth_code,
							L2400_3_too03_tooth_surface_code_1,
							L2400_3_too03_tooth_surface_code_2,
							L2400_3_too03_tooth_surface_code_3,
							L2400_3_too03_tooth_surface_code_4,
							L2400_3_too03_tooth_surface_code_5,
							L2400_4_too02_JP_tooth_code,
							L2400_4_too03_tooth_surface_code_1,
							L2400_4_too03_tooth_surface_code_2,
							L2400_4_too03_tooth_surface_code_3,
							L2400_4_too03_tooth_surface_code_4,
							L2400_4_too03_tooth_surface_code_5,
							L2400_5_too02_JP_tooth_code,
							L2400_5_too03_tooth_surface_code_1,
							L2400_5_too03_tooth_surface_code_2,
							L2400_5_too03_tooth_surface_code_3,
							L2400_5_too03_tooth_surface_code_4,
							L2400_5_too03_tooth_surface_code_5,
							L2400_6_too02_JP_tooth_code,
							L2400_6_too03_tooth_surface_code_1,
							L2400_6_too03_tooth_surface_code_2,
							L2400_6_too03_tooth_surface_code_3,
							L2400_6_too03_tooth_surface_code_4,
							L2400_6_too03_tooth_surface_code_5,
							L2400_7_too02_JP_tooth_code,
							L2400_7_too03_tooth_surface_code_1,
							L2400_7_too03_tooth_surface_code_2,
							L2400_7_too03_tooth_surface_code_3,
							L2400_7_too03_tooth_surface_code_4,
							L2400_7_too03_tooth_surface_code_5,
							L2400_8_too02_JP_tooth_code,
							L2400_8_too03_tooth_surface_code_1,
							L2400_8_too03_tooth_surface_code_2,
							L2400_8_too03_tooth_surface_code_3,
							L2400_8_too03_tooth_surface_code_4,
							L2400_8_too03_tooth_surface_code_5,
							L2400_9_too02_JP_tooth_code,
							L2400_9_too03_tooth_surface_code_1,
							L2400_9_too03_tooth_surface_code_2,
							L2400_9_too03_tooth_surface_code_3,
							L2400_9_too03_tooth_surface_code_4,
							L2400_9_too03_tooth_surface_code_5,
							L2400_10_too02_JP_tooth_code,
							L2400_10_too03_tooth_surface_code_1,
							L2400_10_too03_tooth_surface_code_2,
							L2400_10_too03_tooth_surface_code_3,
							L2400_10_too03_tooth_surface_code_4,
							L2400_10_too03_tooth_surface_code_5,
							L2400_11_too02_JP_tooth_code,
							L2400_11_too03_tooth_surface_code_1,
							L2400_11_too03_tooth_surface_code_2,
							L2400_11_too03_tooth_surface_code_3,
							L2400_11_too03_tooth_surface_code_4,
							L2400_11_too03_tooth_surface_code_5,
							L2400_12_too02_JP_tooth_code,
							L2400_12_too03_tooth_surface_code_1,
							L2400_12_too03_tooth_surface_code_2,
							L2400_12_too03_tooth_surface_code_3,
							L2400_12_too03_tooth_surface_code_4,
							L2400_12_too03_tooth_surface_code_5,
							L2400_13_too02_JP_tooth_code,
							L2400_13_too03_tooth_surface_code_1,
							L2400_13_too03_tooth_surface_code_2,
							L2400_13_too03_tooth_surface_code_3,
							L2400_13_too03_tooth_surface_code_4,
							L2400_13_too03_tooth_surface_code_5,
							L2400_14_too02_JP_tooth_code,
							L2400_14_too03_tooth_surface_code_1,
							L2400_14_too03_tooth_surface_code_2,
							L2400_14_too03_tooth_surface_code_3,
							L2400_14_too03_tooth_surface_code_4,
							L2400_14_too03_tooth_surface_code_5,
							L2400_15_too02_JP_tooth_code,
							L2400_15_too03_tooth_surface_code_1,
							L2400_15_too03_tooth_surface_code_2,
							L2400_15_too03_tooth_surface_code_3,
							L2400_15_too03_tooth_surface_code_4,
							L2400_15_too03_tooth_surface_code_5,
							L2400_16_too02_JP_tooth_code,
							L2400_16_too03_tooth_surface_code_1,
							L2400_16_too03_tooth_surface_code_2,
							L2400_16_too03_tooth_surface_code_3,
							L2400_16_too03_tooth_surface_code_4,
							L2400_16_too03_tooth_surface_code_5,
							L2400_17_too02_JP_tooth_code,
							L2400_17_too03_tooth_surface_code_1,
							L2400_17_too03_tooth_surface_code_2,
							L2400_17_too03_tooth_surface_code_3,
							L2400_17_too03_tooth_surface_code_4,
							L2400_17_too03_tooth_surface_code_5,
							L2400_18_too02_JP_tooth_code,
							L2400_18_too03_tooth_surface_code_1,
							L2400_18_too03_tooth_surface_code_2,
							L2400_18_too03_tooth_surface_code_3,
							L2400_18_too03_tooth_surface_code_4,
							L2400_18_too03_tooth_surface_code_5,
							L2400_19_too02_JP_tooth_code,
							L2400_19_too03_tooth_surface_code_1,
							L2400_19_too03_tooth_surface_code_2,
							L2400_19_too03_tooth_surface_code_3,
							L2400_19_too03_tooth_surface_code_4,
							L2400_19_too03_tooth_surface_code_5,
							L2400_20_too02_JP_tooth_code,
							L2400_20_too03_tooth_surface_code_1,
							L2400_20_too03_tooth_surface_code_2,
							L2400_20_too03_tooth_surface_code_3,
							L2400_20_too03_tooth_surface_code_4,
							L2400_20_too03_tooth_surface_code_5,
							L2400_21_too02_JP_tooth_code,
							L2400_21_too03_tooth_surface_code_1,
							L2400_21_too03_tooth_surface_code_2,
							L2400_21_too03_tooth_surface_code_3,
							L2400_21_too03_tooth_surface_code_4,
							L2400_21_too03_tooth_surface_code_5,
							L2400_22_too02_JP_tooth_code,
							L2400_22_too03_tooth_surface_code_1,
							L2400_22_too03_tooth_surface_code_2,
							L2400_22_too03_tooth_surface_code_3,
							L2400_22_too03_tooth_surface_code_4,
							L2400_22_too03_tooth_surface_code_5,
							L2400_23_too02_JP_tooth_code,
							L2400_23_too03_tooth_surface_code_1,
							L2400_23_too03_tooth_surface_code_2,
							L2400_23_too03_tooth_surface_code_3,
							L2400_23_too03_tooth_surface_code_4,
							L2400_23_too03_tooth_surface_code_5,
							L2400_24_too02_JP_tooth_code,
							L2400_24_too03_tooth_surface_code_1,
							L2400_24_too03_tooth_surface_code_2,
							L2400_24_too03_tooth_surface_code_3,
							L2400_24_too03_tooth_surface_code_4,
							L2400_24_too03_tooth_surface_code_5,
							L2400_25_too02_JP_tooth_code,
							L2400_25_too03_tooth_surface_code_1,
							L2400_25_too03_tooth_surface_code_2,
							L2400_25_too03_tooth_surface_code_3,
							L2400_25_too03_tooth_surface_code_4,
							L2400_25_too03_tooth_surface_code_5,
							L2400_26_too02_JP_tooth_code,
							L2400_26_too03_tooth_surface_code_1,
							L2400_26_too03_tooth_surface_code_2,
							L2400_26_too03_tooth_surface_code_3,
							L2400_26_too03_tooth_surface_code_4,
							L2400_26_too03_tooth_surface_code_5,
							L2400_27_too02_JP_tooth_code,
							L2400_27_too03_tooth_surface_code_1,
							L2400_27_too03_tooth_surface_code_2,
							L2400_27_too03_tooth_surface_code_3,
							L2400_27_too03_tooth_surface_code_4,
							L2400_27_too03_tooth_surface_code_5,
							L2400_28_too02_JP_tooth_code,
							L2400_28_too03_tooth_surface_code_1,
							L2400_28_too03_tooth_surface_code_2,
							L2400_28_too03_tooth_surface_code_3,
							L2400_28_too03_tooth_surface_code_4,
							L2400_28_too03_tooth_surface_code_5,
							L2400_29_too02_JP_tooth_code,
							L2400_29_too03_tooth_surface_code_1,
							L2400_29_too03_tooth_surface_code_2,
							L2400_29_too03_tooth_surface_code_3,
							L2400_29_too03_tooth_surface_code_4,
							L2400_29_too03_tooth_surface_code_5,
							L2400_30_too02_JP_tooth_code,
							L2400_30_too03_tooth_surface_code_1,
							L2400_30_too03_tooth_surface_code_2,
							L2400_30_too03_tooth_surface_code_3,
							L2400_30_too03_tooth_surface_code_4,
							L2400_30_too03_tooth_surface_code_5,
							L2400_31_too02_JP_tooth_code,
							L2400_31_too03_tooth_surface_code_1,
							L2400_31_too03_tooth_surface_code_2,
							L2400_31_too03_tooth_surface_code_3,
							L2400_31_too03_tooth_surface_code_4,
							L2400_31_too03_tooth_surface_code_5,
							L2400_32_too02_JP_tooth_code,
							L2400_32_too03_tooth_surface_code_1,
							L2400_32_too03_tooth_surface_code_2,
							L2400_32_too03_tooth_surface_code_3,
							L2400_32_too03_tooth_surface_code_4,
							L2400_32_too03_tooth_surface_code_5,
							L2400_dtp02_472_service_date,
							L2400_dtp02_441_prior_placement_date,
							L2400_dtp02_452_orthodontic_banding_date,
							L2400_dtp02_446_replacement_date,
							L2400_1_qty01_qty_qual,
							L2400_1_qty02_anesthesia_unit_count,
							L2400_2_qty01_qty_qual,
							L2400_2_qty02_anesthesia_unit_count,
							L2400_3_qty01_qty_qual,
							L2400_3_qty02_anesthesia_unit_count,
							L2400_4_qty01_qty_qual,
							L2400_4_qty02_anesthesia_unit_count,
							L2400_5_qty01_qty_qual,
							L2400_5_qty02_anesthesia_unit_count,
							L2400_ref02_G3_predetermination_of_benefits_id,
							L2400_ref02_9F_referral_number,
							L2400_ref02_G1_prior_auth_number,
							L2400_ref02_6R_line_item_control_num,
							L2400_amt02_AAE_approved_amt,
							L2400_amt02_T_sales_tax_amt,
							L2400_nte01_note_ref_code,
							L2400_nte02_line_note_text,
							L2420A_nm102_entity_type_qual,
							L2420A_nm103_rendering_prov_last_nm,
							L2420A_nm104_rendering_prov_first_nm,
							L2420A_nm105_rendering_prov_middle_nm,
							L2420A_nm107_rendering_prov_suffix,
							L2420A_nm108_id_code_qual,
							L2420A_nm109_rendering_prov_id,
							L2420A_prv01_provider_code,
							L2420A_prv02_ref_id_qual,
							L2420A_prv03_taxonomy_code,
							L2420A_ref02_1C_rendering_prov_id,
							L2420A_ref02_1D_rendering_prov_id,
							L2420A_ref02_1E_rendering_prov_id,
							L2420A_ref02_EI_rendering_prov_id,
							L2420A_ref02_SY_rendering_prov_id,
							L2420A_ref02_TJ_rendering_prov_id,
							L2420B_nm102_entity_type_qual,
							L2420B_nm103_payer_last_nm,
							L2420B_nm108_id_code_qual,
							L2420B_nm109_other_payer_id,
							L2420B_ref02_9F_referral_number,
							L2420B_ref02_G1_prior_auth_number,
							L2420C_nm101_entity_id_code,
							L2420C_nm102_entity_type_qual,
							L2420C_nm103_assistant_surgeon_last_nm,
							L2420C_nm104_assistant_surgeon_first_nm,
							L2420C_nm105_assistant_surgeon_middle_nm,
							L2420C_nm107_assistant_surgeon_suffix,
							L2420C_nm108_id_code_qual,
							L2420C_nm109_assistant_surgeon_id,
							L2420C_prv01_provider_code,
							L2420C_prv02_ref_id_qual,
							L2420C_prv03_taxonomy_code,
							L2420C_ref02_1C_service_facility_id,
							L2420C_ref02_1D_service_facility_id,
							L2420C_ref02_1E_service_facility_id,
							L2420C_ref02_G2_service_facility_id,
							L2420C_ref02_TJ_service_facility_id,
							L2430_svd01_other_payer_id,
							L2430_svd02_service_line_paid,
							L2430_svd03_service_id_qual,
							L2430_svd03_proc_code,
							L2430_svd03_proc_mod1,
							L2430_svd03_proc_mod2,
							L2430_svd03_proc_mod3,
							L2430_svd03_proc_mod4,
							L2430_svd03_proc_code_desc,
							L2430_svd05_paid_service_unit,
							L2430_svd06_bundled_unbundled_line_num,
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
							L2430_dtp03_573_date_claim_paid
						)
				values
				(	@x12_transaction_id,
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
					@L2010AA_ref02_1C_billing_prov_id,
					@L2010AA_ref02_1D_billing_prov_id,
					@L2010AA_ref02_1E_billing_prov_id,
					@L2010AA_ref02_EI_billing_prov_id,
					@L2010AA_ref02_SY_billing_prov_id,
					@L2010AA_ref02_TJ_billing_prov_id,
					@L2010AA_ref02_06_card_billing_id,
					@L2010AA_ref02_8U_card_billing_id,
					@L2010AA_ref02_EM_card_billing_id,
					@L2010AA_ref02_IJ_card_billing_id,
					@L2010AA_ref02_LU_card_billing_id,
					@L2010AA_ref02_ST_card_billing_id,
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
					@L2010AB_ref02_1E_payto_prov_id,
					@L2010AB_ref02_EI_payto_prov_id,
					@L2010AB_ref02_SY_payto_prov_id,
					@L2010AB_ref02_TJ_payto_prov_id,
					@L2000B_hl01_hierarchical_id_num,
					@L2000B_hl02_hierarchical_parent_id_num,
					@L2000B_hl03_hierarchical_level_code,
					@L2000B_hl04_hierarchical_child_code,
					@L2000B_sbr01_payer_resp_seq_code,
					@L2000B_sbr02_ind_relationship_code,
					@L2000B_sbr03_insured_grp_policy_num,
					@L2000B_sbr04_insured_grp_nm,
					@L2000B_sbr06_cob_code,
					@L2000B_sbr09_claim_filing_ind_code,
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
					@L2010BB_nm103_payer_nm,
					@L2010BB_nm108_payer_id_qual,
					@L2010BB_nm109_payer_id,
					@L2010BB_n301_payer_address1,
					@L2010BB_n302_payer_address2,
					@L2010BB_n401_payer_city,
					@L2010BB_n402_payer_state,
					@L2010BB_n403_payer_zip,
					@L2010BB_n404_payer_country,
					@L2010BB_ref02_2U_payer_id,
					@L2010BB_ref02_FY_payer_id,
					@L2010BB_ref02_NF_payer_id,
					@L2010BB_ref02_TJ_payer_id,
					@L2010BC_nm102_entity_type_qual,
					@L2010BC_nm103_resp_party_last_nm,
					@L2010BC_nm104_resp_party_first_nm,
					@L2010BC_nm105_resp_party_middle_nm,
					@L2010BC_nm107_resp_party_suffix,
					@L2010BC_nm109_MI_card_num,
					@L2010BC_ref02_BB_card_num,
					@L2000C_hl01_hierarchical_id_num,
					@L2000C_hl02_hierarchical_parent_id_num,
					@L2000C_hl03_hierarchical_level_code,
					@L2000C_hl04_hierarchical_child_code,
					@L2000C_pat01_ind_relationship_code,
					@L2000C_pat04_student_status_code,
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
					@L2300_clm05_claim_freq_code,
					@L2300_clm06_provider_signature_ind,
					@L2300_clm07_medicare_assign_code,
					@L2300_clm08_benefit_assign_ind,
					@L2300_clm09_release_of_info_code,
					@L2300_clm11_related_causes_code1,
					@L2300_clm11_related_causes_code2,
					@L2300_clm11_related_causes_code3,
					@L2300_clm11_auto_accident_state_code,
					@L2300_clm11_country_code,
					@L2300_clm12_special_prog_ind,
					@L2300_clm19_claim_submission_reason_code,
					@L2300_clm20_delay_reason_code,
					@L2300_dtp03_435_related_hospitalization_admission_date,
					@L2300_dtp03_096_discharge_end_of_care_date,
					@L2300_dtp03_330_referral_date,
					@L2300_dtp03_439_accident_date,
					@L2300_dtp03_452_orthodontic_banding_date,
					@L2300_dtp03_472_service_date,
					@L2300_dn101_orthodontic_treatment_months_count,
					@L2300_dn102_orthodontic_treatment_months_remaining_count,
					@L2300_dn103_question_response,
					@L2300_1_dn201_tooth_number,
					@L2300_1_dn202_tooth_status_code,
					@L2300_2_dn201_tooth_number,
					@L2300_2_dn202_tooth_status_code,
					@L2300_3_dn201_tooth_number,
					@L2300_3_dn202_tooth_status_code,
					@L2300_4_dn201_tooth_number,
					@L2300_4_dn202_tooth_status_code,
					@L2300_5_dn201_tooth_number,
					@L2300_5_dn202_tooth_status_code,
					@L2300_6_dn201_tooth_number,
					@L2300_6_dn202_tooth_status_code,
					@L2300_7_dn201_tooth_number,
					@L2300_7_dn202_tooth_status_code,
					@L2300_8_dn201_tooth_number,
					@L2300_8_dn202_tooth_status_code,
					@L2300_9_dn201_tooth_number,
					@L2300_9_dn202_tooth_status_code,
					@L2300_10_dn201_tooth_number,
					@L2300_10_dn202_tooth_status_code,
					@L2300_11_dn201_tooth_number,
					@L2300_11_dn202_tooth_status_code,
					@L2300_12_dn201_tooth_number,
					@L2300_12_dn202_tooth_status_code,
					@L2300_13_dn201_tooth_number,
					@L2300_13_dn202_tooth_status_code,
					@L2300_14_dn201_tooth_number,
					@L2300_14_dn202_tooth_status_code,
					@L2300_15_dn201_tooth_number,
					@L2300_15_dn202_tooth_status_code,
					@L2300_16_dn201_tooth_number,
					@L2300_16_dn202_tooth_status_code,
					@L2300_17_dn201_tooth_number,
					@L2300_17_dn202_tooth_status_code,
					@L2300_18_dn201_tooth_number,
					@L2300_18_dn202_tooth_status_code,
					@L2300_19_dn201_tooth_number,
					@L2300_19_dn202_tooth_status_code,
					@L2300_20_dn201_tooth_number,
					@L2300_20_dn202_tooth_status_code,
					@L2300_21_dn201_tooth_number,
					@L2300_21_dn202_tooth_status_code,
					@L2300_22_dn201_tooth_number,
					@L2300_22_dn202_tooth_status_code,
					@L2300_23_dn201_tooth_number,
					@L2300_23_dn202_tooth_status_code,
					@L2300_24_dn201_tooth_number,
					@L2300_24_dn202_tooth_status_code,
					@L2300_25_dn201_tooth_number,
					@L2300_25_dn202_tooth_status_code,
					@L2300_26_dn201_tooth_number,
					@L2300_26_dn202_tooth_status_code,
					@L2300_27_dn201_tooth_number,
					@L2300_27_dn202_tooth_status_code,
					@L2300_28_dn201_tooth_number,
					@L2300_28_dn202_tooth_status_code,
					@L2300_29_dn201_tooth_number,
					@L2300_29_dn202_tooth_status_code,
					@L2300_30_dn201_tooth_number,
					@L2300_30_dn202_tooth_status_code,
					@L2300_31_dn201_tooth_number,
					@L2300_31_dn202_tooth_status_code,
					@L2300_32_dn201_tooth_number,
					@L2300_32_dn202_tooth_status_code,
					@L2300_33_dn201_tooth_number,
					@L2300_33_dn202_tooth_status_code,
					@L2300_34_dn201_tooth_number,
					@L2300_34_dn202_tooth_status_code,
					@L2300_35_dn201_tooth_number,
					@L2300_35_dn202_tooth_status_code,
					@L2300_pwk01_attachment_type_code,
					@L2300_pwk02_attachment_trans_code,
					@L2300_pwk06_attachment_control_num,
					@L2300_amt02_patient_paid_amt,
					@L2300_amt02_card_maximum_amt,
					@L2300_ref02_G3_predetermination_id,
					@L2300_ref02_4N_service_auth_exception_code,
					@L2300_ref02_F8_original_ref_num,
					@L2300_ref02_9F_referral_num,
					@L2300_ref02_G1_prior_auth_num,
					@L2300_ref02_D9_value_added_network_trace_num,
					@L2300_nte01_note_ref_code,
					@L2300_nte02_claim_note_text,
					@L2310A_nm101_entity_id_code,
					@L2310A_nm102_entity_type_qual,
					@L2310A_nm103_referring_prov_last_nm,
					@L2310A_nm104_referring_prov_first_nm,
					@L2310A_nm105_referring_prov_middle_nm,
					@L2310A_nm107_referring_prov_suffix,
					@L2310A_nm108_id_code_qual,
					@L2310A_nm109_referring_prov_id,
					@L2310A_prv01_provider_code,
					@L2310A_prv02_ref_id_qual,
					@L2310A_prv03_taxonomy_code,
					@L2310A_ref02_1C_referring_prov_id,
					@L2310A_ref02_1D_referring_prov_id,
					@L2310A_ref02_1E_referring_prov_id,
					@L2310A_ref02_EI_referring_prov_id,
					@L2310A_ref02_G2_referring_prov_id,
					@L2310A_ref02_SY_referring_prov_id,
					@L2310A_ref02_TJ_referring_prov_id,
					@L2310B_nm102_entity_type_qual,
					@L2310B_nm103_rendering_prov_last_nm,
					@L2310B_nm104_rendering_prov_first_nm,
					@L2310B_nm105_rendering_prov_middle_nm,
					@L2310B_nm107_rendering_prov_suffix,
					@L2310B_nm108_id_code_qual,
					@L2310B_nm109_rendering_prov_id,
					@L2310B_prv01_provider_code,
					@L2310B_prv02_ref_id_qual,
					@L2310B_prv03_taxonomy_code,
					@L2310B_ref02_1C_rendering_prov_id,
					@L2310B_ref02_1D_rendering_prov_id,
					@L2310B_ref02_1E_rendering_prov_id,
					@L2310B_ref02_EI_rendering_prov_id,
					@L2310B_ref02_G2_rendering_prov_id,
					@L2310B_ref02_SY_rendering_prov_id,
					@L2310B_ref02_TJ_rendering_prov_id,
					@L2310C_nm102_entity_type_qual,
					@L2310C_nm103_service_facility_last_nm,
					@L2310C_nm108_id_code_qual,
					@L2310C_nm109_service_facility_id,
					@L2310C_ref02_1C_lab_or_facility_prov_id,
					@L2310C_ref02_1D_lab_or_facility_prov_id,
					@L2310C_ref02_1G_lab_or_facility_prov_id,
					@L2310C_ref02_G2_lab_or_facility_prov_id,
					@L2310C_ref02_TJ_lab_or_facility_prov_id,
					@L2310D_nm102_entity_type_qual,
					@L2310D_nm103_assistant_surgeon_last_nm,
					@L2310D_nm104_assistant_surgeon_first_nm,
					@L2310D_nm105_assistant_surgeon_middle_nm,
					@L2310D_nm107_assistant_surgeon_suffix,
					@L2310D_nm108_id_code_qual,
					@L2310D_nm109_assistant_surgeon_prov_id,
					@L2310D_prv01_provider_code,
					@L2310D_prv02_id_code_qual,
					@L2310D_prv03_taxonomy_code,
					@L2310D_ref02_1C_service_facility_id,
					@L2310D_ref02_1D_service_facility_id,
					@L2310D_ref02_1E_service_facility_id,
					@L2310D_ref02_G2_service_facility_id,
					@L2310D_ref02_TJ_service_facility_id,
					@L2320_1_sbr01_payer_resp_seq_code,
					@L2320_1_sbr02_ind_relationship_code,
					@L2320_1_sbr03_insured_grp_policy_num,
					@L2320_1_sbr04_insured_grp_nm,
					@L2320_1_sbr09_claim_file_ind_code,
					@L2320_1_1_cas01_adjustment_group_code,
					@L2320_1_1_cas02_adjustment_reason_code,
					@L2320_1_1_cas03_adjustment_amt,
					@L2320_1_1_cas04_adjustment_qty,
					@L2320_1_1_cas05_adjustment_reason_code,
					@L2320_1_1_cas06_adjustment_amt,
					@L2320_1_1_cas07_adjustment_qty,
					@L2320_1_1_cas08_adjustment_reason_code,
					@L2320_1_1_cas09_adjustment_amt,
					@L2320_1_1_cas10_adjustment_qty,
					@L2320_1_2_cas01_adjustment_group_code,
					@L2320_1_2_cas02_adjustment_reason_code,
					@L2320_1_2_cas03_adjustment_amt,
					@L2320_1_2_cas04_adjustment_qty,
					@L2320_1_2_cas05_adjustment_reason_code,
					@L2320_1_2_cas06_adjustment_amt,
					@L2320_1_2_cas07_adjustment_qty,
					@L2320_1_2_cas08_adjustment_reason_code,
					@L2320_1_2_cas09_adjustment_amt,
					@L2320_1_2_cas10_adjustment_qty,
					@L2320_1_3_cas01_adjustment_group_code,
					@L2320_1_3_cas02_adjustment_reason_code,
					@L2320_1_3_cas03_adjustment_amt,
					@L2320_1_3_cas04_adjustment_qty,
					@L2320_1_3_cas05_adjustment_reason_code,
					@L2320_1_3_cas06_adjustment_amt,
					@L2320_1_3_cas07_adjustment_qty,
					@L2320_1_3_cas08_adjustment_reason_code,
					@L2320_1_3_cas09_adjustment_amt,
					@L2320_1_3_cas10_adjustment_qty,
					@L2320_1_4_cas01_adjustment_group_code,
					@L2320_1_4_cas02_adjustment_reason_code,
					@L2320_1_4_cas03_adjustment_amt,
					@L2320_1_4_cas04_adjustment_qty,
					@L2320_1_4_cas05_adjustment_reason_code,
					@L2320_1_4_cas06_adjustment_amt,
					@L2320_1_4_cas07_adjustment_qty,
					@L2320_1_4_cas08_adjustment_reason_code,
					@L2320_1_4_cas09_adjustment_amt,
					@L2320_1_4_cas10_adjustment_qty,
					@L2320_1_5_cas01_adjustment_group_code,
					@L2320_1_5_cas02_adjustment_reason_code,
					@L2320_1_5_cas03_adjustment_amt,
					@L2320_1_5_cas04_adjustment_qty,
					@L2320_1_5_cas05_adjustment_reason_code,
					@L2320_1_5_cas06_adjustment_amt,
					@L2320_1_5_cas07_adjustment_qty,
					@L2320_1_5_cas08_adjustment_reason_code,
					@L2320_1_5_cas09_adjustment_amt,
					@L2320_1_5_cas10_adjustment_qty,
					@L2320_1_amt02_D_payer_paid_amt,
					@L2320_1_amt02_AAE_cob_approved_amt,
					@L2320_1_amt02_B6_cob_allowed_amt,
					@L2320_1_amt02_F2_patient_responsibility_amt,
					@L2320_1_amt02_AU_cob_covered_amt,
					@L2320_1_amt02_D8_discount_amt,
					@L2320_1_amt02_F5_payer_patient_paid_amt,
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
					@L2330A_1_n301_other_subscriber_address1,
					@L2330A_1_n302_other_subscriber_address2,
					@L2330A_1_n401_other_subscriber_city,
					@L2330A_1_n402_other_subscriber_state,
					@L2330A_1_n403_other_subscriber_zip,
					@L2330A_1_n404_other_subscriber_country,
					@L2330A_1_ref02_1W_other_subscriber_sup_id,
					@L2330A_1_ref02_23_other_subscriber_sup_id,
					@L2330A_1_ref02_IG_other_subscriber_sup_id,
					@L2330A_1_ref02_SY_other_subscriber_sup_id,
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
					@L2330B_1_ref02_T4_other_payer_claim_adj_ind,
					@L2320_2_sbr01_payer_resp_seq_code,
					@L2320_2_sbr02_ind_relationship_code,
					@L2320_2_sbr03_insured_grp_policy_num,
					@L2320_2_sbr04_insured_grp_nm,
					@L2320_2_sbr09_claim_file_ind_code,
					@L2320_2_1_cas01_adjustment_group_code,
					@L2320_2_1_cas02_adjustment_reason_code,
					@L2320_2_1_cas03_adjustment_amt,
					@L2320_2_1_cas04_adjustment_qty,
					@L2320_2_1_cas05_adjustment_reason_code,
					@L2320_2_1_cas06_adjustment_amt,
					@L2320_2_1_cas07_adjustment_qty,
					@L2320_2_1_cas08_adjustment_reason_code,
					@L2320_2_1_cas09_adjustment_amt,
					@L2320_2_1_cas10_adjustment_qty,
					@L2320_2_2_cas01_adjustment_group_code,
					@L2320_2_2_cas02_adjustment_reason_code,
					@L2320_2_2_cas03_adjustment_amt,
					@L2320_2_2_cas04_adjustment_qty,
					@L2320_2_2_cas05_adjustment_reason_code,
					@L2320_2_2_cas06_adjustment_amt,
					@L2320_2_2_cas07_adjustment_qty,
					@L2320_2_2_cas08_adjustment_reason_code,
					@L2320_2_2_cas09_adjustment_amt,
					@L2320_2_2_cas10_adjustment_qty,
					@L2320_2_3_cas01_adjustment_group_code,
					@L2320_2_3_cas02_adjustment_reason_code,
					@L2320_2_3_cas03_adjustment_amt,
					@L2320_2_3_cas04_adjustment_qty,
					@L2320_2_3_cas05_adjustment_reason_code,
					@L2320_2_3_cas06_adjustment_amt,
					@L2320_2_3_cas07_adjustment_qty,
					@L2320_2_3_cas08_adjustment_reason_code,
					@L2320_2_3_cas09_adjustment_amt,
					@L2320_2_3_cas10_adjustment_qty,
					@L2320_2_4_cas01_adjustment_group_code,
					@L2320_2_4_cas02_adjustment_reason_code,
					@L2320_2_4_cas03_adjustment_amt,
					@L2320_2_4_cas04_adjustment_qty,
					@L2320_2_4_cas05_adjustment_reason_code,
					@L2320_2_4_cas06_adjustment_amt,
					@L2320_2_4_cas07_adjustment_qty,
					@L2320_2_4_cas08_adjustment_reason_code,
					@L2320_2_4_cas09_adjustment_amt,
					@L2320_2_4_cas10_adjustment_qty,
					@L2320_2_5_cas01_adjustment_group_code,
					@L2320_2_5_cas02_adjustment_reason_code,
					@L2320_2_5_cas03_adjustment_amt,
					@L2320_2_5_cas04_adjustment_qty,
					@L2320_2_5_cas05_adjustment_reason_code,
					@L2320_2_5_cas06_adjustment_amt,
					@L2320_2_5_cas07_adjustment_qty,
					@L2320_2_5_cas08_adjustment_reason_code,
					@L2320_2_5_cas09_adjustment_amt,
					@L2320_2_5_cas10_adjustment_qty,
					@L2320_2_amt02_D_payer_paid_amt,
					@L2320_2_amt02_AAE_cob_approved_amt,
					@L2320_2_amt02_B6_cob_allowed_amt,
					@L2320_2_amt02_F2_patient_responsibility_amt,
					@L2320_2_amt02_AU_cob_covered_amt,
					@L2320_2_amt02_D8_discount_amt,
					@L2320_2_amt02_F5_payer_patient_paid_amt,
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
					@L2330A_2_n301_other_subscriber_address1,
					@L2330A_2_n302_other_subscriber_address2,
					@L2330A_2_n401_other_subscriber_city,
					@L2330A_2_n402_other_subscriber_state,
					@L2330A_2_n403_other_subscriber_zip,
					@L2330A_2_n404_other_subscriber_country,
					@L2330A_2_ref02_1W_other_subscriber_sup_id,
					@L2330A_2_ref02_23_other_subscriber_sup_id,
					@L2330A_2_ref02_IG_other_subscriber_sup_id,
					@L2330A_2_ref02_SY_other_subscriber_sup_id,
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
					@L2330B_2_ref02_T4_other_payer_claim_adj_ind,
					@L2320_3_sbr01_payer_resp_seq_code,
					@L2320_3_sbr02_ind_relationship_code,
					@L2320_3_sbr03_insured_grp_policy_num,
					@L2320_3_sbr04_insured_grp_nm,
					@L2320_3_sbr09_claim_file_ind_code,
					@L2320_3_1_cas01_adjustment_group_code,
					@L2320_3_1_cas02_adjustment_reason_code,
					@L2320_3_1_cas03_adjustment_amt,
					@L2320_3_1_cas04_adjustment_qty,
					@L2320_3_1_cas05_adjustment_reason_code,
					@L2320_3_1_cas06_adjustment_amt,
					@L2320_3_1_cas07_adjustment_qty,
					@L2320_3_1_cas08_adjustment_reason_code,
					@L2320_3_1_cas09_adjustment_amt,
					@L2320_3_1_cas10_adjustment_qty,
					@L2320_3_2_cas01_adjustment_group_code,
					@L2320_3_2_cas02_adjustment_reason_code,
					@L2320_3_2_cas03_adjustment_amt,
					@L2320_3_2_cas04_adjustment_qty,
					@L2320_3_2_cas05_adjustment_reason_code,
					@L2320_3_2_cas06_adjustment_amt,
					@L2320_3_2_cas07_adjustment_qty,
					@L2320_3_2_cas08_adjustment_reason_code,
					@L2320_3_2_cas09_adjustment_amt,
					@L2320_3_2_cas10_adjustment_qty,
					@L2320_3_3_cas01_adjustment_group_code,
					@L2320_3_3_cas02_adjustment_reason_code,
					@L2320_3_3_cas03_adjustment_amt,
					@L2320_3_3_cas04_adjustment_qty,
					@L2320_3_3_cas05_adjustment_reason_code,
					@L2320_3_3_cas06_adjustment_amt,
					@L2320_3_3_cas07_adjustment_qty,
					@L2320_3_3_cas08_adjustment_reason_code,
					@L2320_3_3_cas09_adjustment_amt,
					@L2320_3_3_cas10_adjustment_qty,
					@L2320_3_4_cas01_adjustment_group_code,
					@L2320_3_4_cas02_adjustment_reason_code,
					@L2320_3_4_cas03_adjustment_amt,
					@L2320_3_4_cas04_adjustment_qty,
					@L2320_3_4_cas05_adjustment_reason_code,
					@L2320_3_4_cas06_adjustment_amt,
					@L2320_3_4_cas07_adjustment_qty,
					@L2320_3_4_cas08_adjustment_reason_code,
					@L2320_3_4_cas09_adjustment_amt,
					@L2320_3_4_cas10_adjustment_qty,
					@L2320_3_5_cas01_adjustment_group_code,
					@L2320_3_5_cas02_adjustment_reason_code,
					@L2320_3_5_cas03_adjustment_amt,
					@L2320_3_5_cas04_adjustment_qty,
					@L2320_3_5_cas05_adjustment_reason_code,
					@L2320_3_5_cas06_adjustment_amt,
					@L2320_3_5_cas07_adjustment_qty,
					@L2320_3_5_cas08_adjustment_reason_code,
					@L2320_3_5_cas09_adjustment_amt,
					@L2320_3_5_cas10_adjustment_qty,
					@L2320_3_amt02_D_payer_paid_amt,
					@L2320_3_amt02_AAE_cob_approved_amt,
					@L2320_3_amt02_B6_cob_allowed_amt,
					@L2320_3_amt02_F2_patient_responsibility_amt,
					@L2320_3_amt02_AU_cob_covered_amt,
					@L2320_3_amt02_D8_discount_amt,
					@L2320_3_amt02_F5_payer_patient_paid_amt,
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
					@L2330A_3_n301_other_subscriber_address1,
					@L2330A_3_n302_other_subscriber_address2,
					@L2330A_3_n401_other_subscriber_city,
					@L2330A_3_n402_other_subscriber_state,
					@L2330A_3_n403_other_subscriber_zip,
					@L2330A_3_n404_other_subscriber_country,
					@L2330A_3_ref02_1W_other_subscriber_sup_id,
					@L2330A_3_ref02_23_other_subscriber_sup_id,
					@L2330A_3_ref02_IG_other_subscriber_sup_id,
					@L2330A_3_ref02_SY_other_subscriber_sup_id,
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
					@L2330B_3_ref02_T4_other_payer_claim_adj_ind,
					@L2400_lx01_assigned_num,
					@L2400_sv301_proc_code_qual,
					@L2400_sv301_proc_code,
					@L2400_sv301_proc_mod1,
					@L2400_sv301_proc_mod2,
					@L2400_sv301_proc_mod3,
					@L2400_sv301_proc_mod4,
					@L2400_sv302_line_charge,
					@L2400_sv303_facility_type_code,
					@L2400_sv304_oral_cavity_designation_code_1,
					@L2400_sv304_oral_cavity_designation_code_2,
					@L2400_sv304_oral_cavity_designation_code_3,
					@L2400_sv304_oral_cavity_designation_code_4,
					@L2400_sv304_oral_cavity_designation_code_5,
					@L2400_sv305_prosthesis_crown_inlay_code,
					@L2400_sv306_procedure_count,
					@L2400_1_too02_JP_tooth_code,
					@L2400_1_too03_tooth_surface_code_1,
					@L2400_1_too03_tooth_surface_code_2,
					@L2400_1_too03_tooth_surface_code_3,
					@L2400_1_too03_tooth_surface_code_4,
					@L2400_1_too03_tooth_surface_code_5,
					@L2400_2_too02_JP_tooth_code,
					@L2400_2_too03_tooth_surface_code_1,
					@L2400_2_too03_tooth_surface_code_2,
					@L2400_2_too03_tooth_surface_code_3,
					@L2400_2_too03_tooth_surface_code_4,
					@L2400_2_too03_tooth_surface_code_5,
					@L2400_3_too02_JP_tooth_code,
					@L2400_3_too03_tooth_surface_code_1,
					@L2400_3_too03_tooth_surface_code_2,
					@L2400_3_too03_tooth_surface_code_3,
					@L2400_3_too03_tooth_surface_code_4,
					@L2400_3_too03_tooth_surface_code_5,
					@L2400_4_too02_JP_tooth_code,
					@L2400_4_too03_tooth_surface_code_1,
					@L2400_4_too03_tooth_surface_code_2,
					@L2400_4_too03_tooth_surface_code_3,
					@L2400_4_too03_tooth_surface_code_4,
					@L2400_4_too03_tooth_surface_code_5,
					@L2400_5_too02_JP_tooth_code,
					@L2400_5_too03_tooth_surface_code_1,
					@L2400_5_too03_tooth_surface_code_2,
					@L2400_5_too03_tooth_surface_code_3,
					@L2400_5_too03_tooth_surface_code_4,
					@L2400_5_too03_tooth_surface_code_5,
					@L2400_6_too02_JP_tooth_code,
					@L2400_6_too03_tooth_surface_code_1,
					@L2400_6_too03_tooth_surface_code_2,
					@L2400_6_too03_tooth_surface_code_3,
					@L2400_6_too03_tooth_surface_code_4,
					@L2400_6_too03_tooth_surface_code_5,
					@L2400_7_too02_JP_tooth_code,
					@L2400_7_too03_tooth_surface_code_1,
					@L2400_7_too03_tooth_surface_code_2,
					@L2400_7_too03_tooth_surface_code_3,
					@L2400_7_too03_tooth_surface_code_4,
					@L2400_7_too03_tooth_surface_code_5,
					@L2400_8_too02_JP_tooth_code,
					@L2400_8_too03_tooth_surface_code_1,
					@L2400_8_too03_tooth_surface_code_2,
					@L2400_8_too03_tooth_surface_code_3,
					@L2400_8_too03_tooth_surface_code_4,
					@L2400_8_too03_tooth_surface_code_5,
					@L2400_9_too02_JP_tooth_code,
					@L2400_9_too03_tooth_surface_code_1,
					@L2400_9_too03_tooth_surface_code_2,
					@L2400_9_too03_tooth_surface_code_3,
					@L2400_9_too03_tooth_surface_code_4,
					@L2400_9_too03_tooth_surface_code_5,
					@L2400_10_too02_JP_tooth_code,
					@L2400_10_too03_tooth_surface_code_1,
					@L2400_10_too03_tooth_surface_code_2,
					@L2400_10_too03_tooth_surface_code_3,
					@L2400_10_too03_tooth_surface_code_4,
					@L2400_10_too03_tooth_surface_code_5,
					@L2400_11_too02_JP_tooth_code,
					@L2400_11_too03_tooth_surface_code_1,
					@L2400_11_too03_tooth_surface_code_2,
					@L2400_11_too03_tooth_surface_code_3,
					@L2400_11_too03_tooth_surface_code_4,
					@L2400_11_too03_tooth_surface_code_5,
					@L2400_12_too02_JP_tooth_code,
					@L2400_12_too03_tooth_surface_code_1,
					@L2400_12_too03_tooth_surface_code_2,
					@L2400_12_too03_tooth_surface_code_3,
					@L2400_12_too03_tooth_surface_code_4,
					@L2400_12_too03_tooth_surface_code_5,
					@L2400_13_too02_JP_tooth_code,
					@L2400_13_too03_tooth_surface_code_1,
					@L2400_13_too03_tooth_surface_code_2,
					@L2400_13_too03_tooth_surface_code_3,
					@L2400_13_too03_tooth_surface_code_4,
					@L2400_13_too03_tooth_surface_code_5,
					@L2400_14_too02_JP_tooth_code,
					@L2400_14_too03_tooth_surface_code_1,
					@L2400_14_too03_tooth_surface_code_2,
					@L2400_14_too03_tooth_surface_code_3,
					@L2400_14_too03_tooth_surface_code_4,
					@L2400_14_too03_tooth_surface_code_5,
					@L2400_15_too02_JP_tooth_code,
					@L2400_15_too03_tooth_surface_code_1,
					@L2400_15_too03_tooth_surface_code_2,
					@L2400_15_too03_tooth_surface_code_3,
					@L2400_15_too03_tooth_surface_code_4,
					@L2400_15_too03_tooth_surface_code_5,
					@L2400_16_too02_JP_tooth_code,
					@L2400_16_too03_tooth_surface_code_1,
					@L2400_16_too03_tooth_surface_code_2,
					@L2400_16_too03_tooth_surface_code_3,
					@L2400_16_too03_tooth_surface_code_4,
					@L2400_16_too03_tooth_surface_code_5,
					@L2400_17_too02_JP_tooth_code,
					@L2400_17_too03_tooth_surface_code_1,
					@L2400_17_too03_tooth_surface_code_2,
					@L2400_17_too03_tooth_surface_code_3,
					@L2400_17_too03_tooth_surface_code_4,
					@L2400_17_too03_tooth_surface_code_5,
					@L2400_18_too02_JP_tooth_code,
					@L2400_18_too03_tooth_surface_code_1,
					@L2400_18_too03_tooth_surface_code_2,
					@L2400_18_too03_tooth_surface_code_3,
					@L2400_18_too03_tooth_surface_code_4,
					@L2400_18_too03_tooth_surface_code_5,
					@L2400_19_too02_JP_tooth_code,
					@L2400_19_too03_tooth_surface_code_1,
					@L2400_19_too03_tooth_surface_code_2,
					@L2400_19_too03_tooth_surface_code_3,
					@L2400_19_too03_tooth_surface_code_4,
					@L2400_19_too03_tooth_surface_code_5,
					@L2400_20_too02_JP_tooth_code,
					@L2400_20_too03_tooth_surface_code_1,
					@L2400_20_too03_tooth_surface_code_2,
					@L2400_20_too03_tooth_surface_code_3,
					@L2400_20_too03_tooth_surface_code_4,
					@L2400_20_too03_tooth_surface_code_5,
					@L2400_21_too02_JP_tooth_code,
					@L2400_21_too03_tooth_surface_code_1,
					@L2400_21_too03_tooth_surface_code_2,
					@L2400_21_too03_tooth_surface_code_3,
					@L2400_21_too03_tooth_surface_code_4,
					@L2400_21_too03_tooth_surface_code_5,
					@L2400_22_too02_JP_tooth_code,
					@L2400_22_too03_tooth_surface_code_1,
					@L2400_22_too03_tooth_surface_code_2,
					@L2400_22_too03_tooth_surface_code_3,
					@L2400_22_too03_tooth_surface_code_4,
					@L2400_22_too03_tooth_surface_code_5,
					@L2400_23_too02_JP_tooth_code,
					@L2400_23_too03_tooth_surface_code_1,
					@L2400_23_too03_tooth_surface_code_2,
					@L2400_23_too03_tooth_surface_code_3,
					@L2400_23_too03_tooth_surface_code_4,
					@L2400_23_too03_tooth_surface_code_5,
					@L2400_24_too02_JP_tooth_code,
					@L2400_24_too03_tooth_surface_code_1,
					@L2400_24_too03_tooth_surface_code_2,
					@L2400_24_too03_tooth_surface_code_3,
					@L2400_24_too03_tooth_surface_code_4,
					@L2400_24_too03_tooth_surface_code_5,
					@L2400_25_too02_JP_tooth_code,
					@L2400_25_too03_tooth_surface_code_1,
					@L2400_25_too03_tooth_surface_code_2,
					@L2400_25_too03_tooth_surface_code_3,
					@L2400_25_too03_tooth_surface_code_4,
					@L2400_25_too03_tooth_surface_code_5,
					@L2400_26_too02_JP_tooth_code,
					@L2400_26_too03_tooth_surface_code_1,
					@L2400_26_too03_tooth_surface_code_2,
					@L2400_26_too03_tooth_surface_code_3,
					@L2400_26_too03_tooth_surface_code_4,
					@L2400_26_too03_tooth_surface_code_5,
					@L2400_27_too02_JP_tooth_code,
					@L2400_27_too03_tooth_surface_code_1,
					@L2400_27_too03_tooth_surface_code_2,
					@L2400_27_too03_tooth_surface_code_3,
					@L2400_27_too03_tooth_surface_code_4,
					@L2400_27_too03_tooth_surface_code_5,
					@L2400_28_too02_JP_tooth_code,
					@L2400_28_too03_tooth_surface_code_1,
					@L2400_28_too03_tooth_surface_code_2,
					@L2400_28_too03_tooth_surface_code_3,
					@L2400_28_too03_tooth_surface_code_4,
					@L2400_28_too03_tooth_surface_code_5,
					@L2400_29_too02_JP_tooth_code,
					@L2400_29_too03_tooth_surface_code_1,
					@L2400_29_too03_tooth_surface_code_2,
					@L2400_29_too03_tooth_surface_code_3,
					@L2400_29_too03_tooth_surface_code_4,
					@L2400_29_too03_tooth_surface_code_5,
					@L2400_30_too02_JP_tooth_code,
					@L2400_30_too03_tooth_surface_code_1,
					@L2400_30_too03_tooth_surface_code_2,
					@L2400_30_too03_tooth_surface_code_3,
					@L2400_30_too03_tooth_surface_code_4,
					@L2400_30_too03_tooth_surface_code_5,
					@L2400_31_too02_JP_tooth_code,
					@L2400_31_too03_tooth_surface_code_1,
					@L2400_31_too03_tooth_surface_code_2,
					@L2400_31_too03_tooth_surface_code_3,
					@L2400_31_too03_tooth_surface_code_4,
					@L2400_31_too03_tooth_surface_code_5,
					@L2400_32_too02_JP_tooth_code,
					@L2400_32_too03_tooth_surface_code_1,
					@L2400_32_too03_tooth_surface_code_2,
					@L2400_32_too03_tooth_surface_code_3,
					@L2400_32_too03_tooth_surface_code_4,
					@L2400_32_too03_tooth_surface_code_5,
					@L2400_dtp02_472_service_date,
					@L2400_dtp02_441_prior_placement_date,
					@L2400_dtp02_452_orthodontic_banding_date,
					@L2400_dtp02_446_replacement_date,
					@L2400_1_qty01_qty_qual,
					@L2400_1_qty02_anesthesia_unit_count,
					@L2400_2_qty01_qty_qual,
					@L2400_2_qty02_anesthesia_unit_count,
					@L2400_3_qty01_qty_qual,
					@L2400_3_qty02_anesthesia_unit_count,
					@L2400_4_qty01_qty_qual,
					@L2400_4_qty02_anesthesia_unit_count,
					@L2400_5_qty01_qty_qual,
					@L2400_5_qty02_anesthesia_unit_count,
					@L2400_ref02_G3_predetermination_of_benefits_id,
					@L2400_ref02_9F_referral_number,
					@L2400_ref02_G1_prior_auth_number,
					@L2400_ref02_6R_line_item_control_num,
					@L2400_amt02_AAE_approved_amt,
					@L2400_amt02_T_sales_tax_amt,
					@L2400_nte01_note_ref_code,
					@L2400_nte02_line_note_text,
					@L2420A_nm102_entity_type_qual,
					@L2420A_nm103_rendering_prov_last_nm,
					@L2420A_nm104_rendering_prov_first_nm,
					@L2420A_nm105_rendering_prov_middle_nm,
					@L2420A_nm107_rendering_prov_suffix,
					@L2420A_nm108_id_code_qual,
					@L2420A_nm109_rendering_prov_id,
					@L2420A_prv01_provider_code,
					@L2420A_prv02_ref_id_qual,
					@L2420A_prv03_taxonomy_code,
					@L2420A_ref02_1C_rendering_prov_id,
					@L2420A_ref02_1D_rendering_prov_id,
					@L2420A_ref02_1E_rendering_prov_id,
					@L2420A_ref02_EI_rendering_prov_id,
					@L2420A_ref02_SY_rendering_prov_id,
					@L2420A_ref02_TJ_rendering_prov_id,
					@L2420B_nm102_entity_type_qual,
					@L2420B_nm103_payer_last_nm,
					@L2420B_nm108_id_code_qual,
					@L2420B_nm109_other_payer_id,
					@L2420B_ref02_9F_referral_number,
					@L2420B_ref02_G1_prior_auth_number,
					@L2420C_nm101_entity_id_code,
					@L2420C_nm102_entity_type_qual,
					@L2420C_nm103_assistant_surgeon_last_nm,
					@L2420C_nm104_assistant_surgeon_first_nm,
					@L2420C_nm105_assistant_surgeon_middle_nm,
					@L2420C_nm107_assistant_surgeon_suffix,
					@L2420C_nm108_id_code_qual,
					@L2420C_nm109_assistant_surgeon_id,
					@L2420C_prv01_provider_code,
					@L2420C_prv02_ref_id_qual,
					@L2420C_prv03_taxonomy_code,
					@L2420C_ref02_1C_service_facility_id,
					@L2420C_ref02_1D_service_facility_id,
					@L2420C_ref02_1E_service_facility_id,
					@L2420C_ref02_G2_service_facility_id,
					@L2420C_ref02_TJ_service_facility_id,
					@L2430_svd01_other_payer_id,
					@L2430_svd02_service_line_paid,
					@L2430_svd03_service_id_qual,
					@L2430_svd03_proc_code,
					@L2430_svd03_proc_mod1,
					@L2430_svd03_proc_mod2,
					@L2430_svd03_proc_mod3,
					@L2430_svd03_proc_mod4,
					@L2430_svd03_proc_code_desc,
					@L2430_svd05_paid_service_unit,
					@L2430_svd06_bundled_unbundled_line_num,
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
					@L2430_dtp03_573_date_claim_paid
				)
return (0)





