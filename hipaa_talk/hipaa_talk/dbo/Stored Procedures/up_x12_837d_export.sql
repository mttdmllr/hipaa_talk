
CREATE Procedure [dbo].[up_x12_837d_export] (@x12_transaction_id int = null, @segment_count int output)
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


--BEGIN: DECLARE 837d Variables
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

declare @L2000A_cur02_currency_code char(3)
declare @L2000A_hl01_hierarchical_id_num varchar(12)
declare @L2000A_hl03_hierarchical_level_code char(2)
declare @L2000A_hl04_hierarchical_child_code char(1)
declare @L2000A_prv01_provider_code char(3)
declare @L2000A_prv02_ref_id_qual char(3)
declare @L2000A_prv03_taxonomy_code varchar(30)

declare @L2000B_hl01_hierarchical_id_num varchar(12)
declare @L2000B_hl02_hierarchical_parent_id_num varchar(12)
declare @L2000B_hl03_hierarchical_level_code char(2)
declare @L2000B_hl04_hierarchical_child_code char(1)
declare @L2000B_sbr01_payer_resp_seq_code char(1)
declare @L2000B_sbr02_ind_relationship_code char(2)
declare @L2000B_sbr03_insured_grp_policy_num varchar(30)
declare @L2000B_sbr04_insured_grp_nm varchar(60)
declare @L2000B_sbr06_cob_code char(1)
declare @L2000B_sbr09_claim_filing_ind_code char(2)

declare @L2000C_hl01_hierarchical_id_num varchar(12)
declare @L2000C_hl02_hierarchical_parent_id_num varchar(12)
declare @L2000C_hl03_hierarchical_level_code char(2)
declare @L2000C_hl04_hierarchical_child_code char(1)
declare @L2000C_pat01_ind_relationship_code char(2)
declare @L2000C_pat04_student_status_code char(1)

declare @L2010AA_n301_billing_prov_address1 varchar(55)
declare @L2010AA_n302_billing_prov_address2 varchar(55)
declare @L2010AA_n401_billing_prov_city varchar(30)
declare @L2010AA_n402_billing_prov_state char(2)
declare @L2010AA_n403_billing_prov_zip varchar(15)
declare @L2010AA_n404_billing_prov_country char(3)
declare @L2010AA_nm102_entity_type_qual char(1)
declare @L2010AA_nm103_billing_prov_last_nm varchar(35)
declare @L2010AA_nm104_billing_prov_first_nm varchar(25)
declare @L2010AA_nm105_billing_prov_middle_nm varchar(25)
declare @L2010AA_nm107_billing_prov_suffix varchar(10)
declare @L2010AA_nm108_id_code_qual char(2)
declare @L2010AA_nm109_billing_prov_id varchar(80)
declare @L2010AA_ref02_06_card_billing_id varchar(30)
declare @L2010AA_ref02_1C_billing_prov_id varchar(30)
declare @L2010AA_ref02_1D_billing_prov_id varchar(30)
declare @L2010AA_ref02_1E_billing_prov_id varchar(30)
declare @L2010AA_ref02_8U_card_billing_id varchar(30)
declare @L2010AA_ref02_EI_billing_prov_id varchar(30)
declare @L2010AA_ref02_EM_card_billing_id varchar(30)
declare @L2010AA_ref02_IJ_card_billing_id varchar(30)
declare @L2010AA_ref02_LU_card_billing_id varchar(30)
declare @L2010AA_ref02_ST_card_billing_id varchar(30)
declare @L2010AA_ref02_SY_billing_prov_id varchar(30)
declare @L2010AA_ref02_TJ_billing_prov_id varchar(30)

declare @L2010AB_n301_payto_prov_address1 varchar(55)
declare @L2010AB_n302_payto_prov_address2 varchar(55)
declare @L2010AB_n401_payto_prov_city varchar(30)
declare @L2010AB_n402_payto_prov_state char(2)
declare @L2010AB_n403_payto_prov_zip varchar(15)
declare @L2010AB_n404_payto_prov_country char(3)
declare @L2010AB_nm102_entity_type_qual char(1)
declare @L2010AB_nm103_payto_prov_last_nm varchar(35)
declare @L2010AB_nm104_payto_prov_first_nm varchar(25)
declare @L2010AB_nm105_payto_prov_middle_nm varchar(25)
declare @L2010AB_nm107_payto_prov_suffix varchar(10)
declare @L2010AB_nm108_id_code_qual char(2)
declare @L2010AB_nm109_payto_prov_id varchar(80)
declare @L2010AB_ref02_1C_payto_prov_id varchar(30)
declare @L2010AB_ref02_1D_payto_prov_id varchar(30)
declare @L2010AB_ref02_1E_payto_prov_id varchar(30)
declare @L2010AB_ref02_EI_payto_prov_id varchar(30)
declare @L2010AB_ref02_SY_payto_prov_id varchar(30)
declare @L2010AB_ref02_TJ_payto_prov_id varchar(30)

declare @L2010BA_dmg02_subscriber_dob varchar(35)
declare @L2010BA_dmg03_subscriber_gender char(1)
declare @L2010BA_n301_subscriber_address1 varchar(55)
declare @L2010BA_n302_subscriber_address2 varchar(55)
declare @L2010BA_n401_subscriber_city varchar(30)
declare @L2010BA_n402_subscriber_state char(2)
declare @L2010BA_n403_subscriber_zip varchar(15)
declare @L2010BA_n404_subscriber_country char(3)
declare @L2010BA_nm102_entity_type_qual char(1)
declare @L2010BA_nm103_subscriber_last_nm varchar(35)
declare @L2010BA_nm104_subscriber_first_nm varchar(25)
declare @L2010BA_nm105_subscriber_middle_nm varchar(25)
declare @L2010BA_nm107_subscriber_suffix varchar(10)
declare @L2010BA_nm108_id_code_qual char(2)
declare @L2010BA_nm109_subscriber_id varchar(80)
declare @L2010BA_ref02_1W_subscriber_sup_id varchar(30)
declare @L2010BA_ref02_23_subscriber_sup_id varchar(30)
declare @L2010BA_ref02_IG_subscriber_sup_id varchar(30)
declare @L2010BA_ref02_SY_subscriber_sup_id varchar(30)
declare @L2010BA_ref02_Y4_prop_casualty_claim_num varchar(30)

declare @L2010BB_n301_payer_address1 varchar(55)
declare @L2010BB_n302_payer_address2 varchar(55)
declare @L2010BB_n401_payer_city varchar(30)
declare @L2010BB_n402_payer_state char(2)
declare @L2010BB_n403_payer_zip varchar(15)
declare @L2010BB_n404_payer_country char(3)
declare @L2010BB_nm102_entity_type_qual char(1)
declare @L2010BB_nm103_payer_nm varchar(35)
declare @L2010BB_nm108_payer_id_qual char(2)
declare @L2010BB_nm109_payer_id varchar(80)
declare @L2010BB_ref02_2U_payer_id varchar(30)
declare @L2010BB_ref02_FY_payer_id varchar(30)
declare @L2010BB_ref02_NF_payer_id varchar(30)
declare @L2010BB_ref02_TJ_payer_id varchar(30)

declare @L2010BC_nm102_entity_type_qual char(1)
declare @L2010BC_nm103_resp_party_last_nm varchar(35)
declare @L2010BC_nm104_resp_party_first_nm varchar(25)
declare @L2010BC_nm105_resp_party_middle_nm varchar(25)
declare @L2010BC_nm107_resp_party_suffix varchar(10)
declare @L2010BC_nm109_MI_card_num varchar(80)
declare @L2010BC_ref02_BB_card_num varchar(30)

declare @L2010CA_dmg02_patient_dob varchar(35)
declare @L2010CA_dmg03_patient_gender char(1)
declare @L2010CA_n301_patient_address1 varchar(55)
declare @L2010CA_n302_patient_address2 varchar(55)
declare @L2010CA_n401_patient_city varchar(30)
declare @L2010CA_n402_patient_state char(2)
declare @L2010CA_n403_patient_zip varchar(15)
declare @L2010CA_n404_patient_country char(3)
declare @L2010CA_nm102_entity_type_qual char(1)
declare @L2010CA_nm103_patient_last_nm varchar(35)
declare @L2010CA_nm104_patient_first_nm varchar(25)
declare @L2010CA_nm105_patient_middle_nm varchar(25)
declare @L2010CA_nm107_patient_suffix varchar(10)
declare @L2010CA_nm108_id_code_qual char(2)
declare @L2010CA_nm109_patient_id varchar(80)
declare @L2010CA_ref02_1W_patient_sup_id varchar(30)
declare @L2010CA_ref02_23_patient_sup_id varchar(30)
declare @L2010CA_ref02_IG_patient_sup_id varchar(30)
declare @L2010CA_ref02_SY_patient_sup_id varchar(30)
declare @L2010CA_ref02_Y4_prop_casualty_claim_num varchar(30)

declare @L2300_amt02_card_maximum_amt money
declare @L2300_amt02_patient_paid_amt money
declare @L2300_clm01_pt_acct_num varchar(38)
declare @L2300_clm02_total_claim_chg_amt money
declare @L2300_clm05_claim_freq_code char(1)
declare @L2300_clm05_facility_type_code char(2)
declare @L2300_clm06_provider_signature_ind char(1)
declare @L2300_clm07_medicare_assign_code char(1)
declare @L2300_clm08_benefit_assign_ind char(1)
declare @L2300_clm09_release_of_info_code char(1)
declare @L2300_clm11_auto_accident_state_code char(2)
declare @L2300_clm11_country_code char(3)
declare @L2300_clm11_related_causes_code1 char(3)
declare @L2300_clm11_related_causes_code2 char(3)
declare @L2300_clm11_related_causes_code3 char(3)
declare @L2300_clm12_special_prog_ind char(3)
declare @L2300_clm19_claim_submission_reason_code char(2)
declare @L2300_clm20_delay_reason_code char(2)
declare @L2300_dn101_orthodontic_treatment_months_count varchar(15)
declare @L2300_dn102_orthodontic_treatment_months_remaining_count varchar(15)
declare @L2300_dn103_question_response char(1)
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
declare @L2300_dtp03_096_discharge_end_of_care_date varchar(35)
declare @L2300_dtp03_330_referral_date varchar(35)
declare @L2300_dtp03_435_related_hospitalization_admission_date varchar(35)
declare @L2300_dtp03_439_accident_date varchar(35)
declare @L2300_dtp03_452_orthodontic_banding_date varchar(35)
declare @L2300_dtp03_472_service_date varchar(35)
declare @L2300_nte01_note_ref_code char(3)
declare @L2300_nte02_claim_note_text varchar(80)
declare @L2300_pwk01_attachment_type_code char(2)
declare @L2300_pwk02_attachment_trans_code char(2)
declare @L2300_pwk06_attachment_control_num varchar(80)
declare @L2300_ref02_4N_service_auth_exception_code varchar(30)
declare @L2300_ref02_9F_prior_auth_num varchar(30)
declare @L2300_ref02_9F_referral_num varchar(30)
declare @L2300_ref02_D9_value_added_network_trace_num varchar(30)
declare @L2300_ref02_F8_original_ref_num varchar(30)
declare @L2300_ref02_G1_prior_auth_num varchar(30)
declare @L2300_ref02_G3_predetermination_id varchar(30)

declare @L2310A_nm101_entity_id_code char(3)
declare @L2310A_nm102_entity_type_qual char(1)
declare @L2310A_nm103_referring_prov_last_nm varchar(35)
declare @L2310A_nm104_referring_prov_first_nm varchar(25)
declare @L2310A_nm105_referring_prov_middle_nm varchar(25)
declare @L2310A_nm107_referring_prov_suffix varchar(10)
declare @L2310A_nm108_id_code_qual char(2)
declare @L2310A_nm109_referring_prov_id varchar(80)
declare @L2310A_prv01_provider_code char(3)
declare @L2310A_prv02_ref_id_qual char(3)
declare @L2310A_prv03_taxonomy_code varchar(30)
declare @L2310A_ref02_1C_referring_prov_id varchar(30)
declare @L2310A_ref02_1D_referring_prov_id varchar(30)
declare @L2310A_ref02_1E_referring_prov_id varchar(30)
declare @L2310A_ref02_EI_referring_prov_id varchar(30)
declare @L2310A_ref02_G2_referring_prov_id varchar(30)
declare @L2310A_ref02_SY_referring_prov_id varchar(30)
declare @L2310A_ref02_TJ_referring_prov_id varchar(30)

declare @L2310B_nm102_entity_type_qual char(1)
declare @L2310B_nm103_rendering_prov_last_nm varchar(35)
declare @L2310B_nm104_rendering_prov_first_nm varchar(25)
declare @L2310B_nm105_rendering_prov_middle_nm varchar(25)
declare @L2310B_nm107_rendering_prov_suffix varchar(10)
declare @L2310B_nm108_id_code_qual char(2)
declare @L2310B_nm109_rendering_prov_id varchar(80)
declare @L2310B_prv01_provider_code char(3)
declare @L2310B_prv02_ref_id_qual char(3)
declare @L2310B_prv03_taxonomy_code varchar(30)
declare @L2310B_ref02_1C_rendering_prov_id varchar(30)
declare @L2310B_ref02_1D_rendering_prov_id varchar(30)
declare @L2310B_ref02_1E_rendering_prov_id varchar(30)
declare @L2310B_ref02_EI_rendering_prov_id varchar(30)
declare @L2310B_ref02_G2_rendering_prov_id varchar(30)
declare @L2310B_ref02_SY_rendering_prov_id varchar(30)
declare @L2310B_ref02_TJ_rendering_prov_id varchar(30)

declare @L2310C_nm102_entity_type_qual char(1)
declare @L2310C_nm103_service_facility_last_nm varchar(35)
declare @L2310C_nm108_id_code_qual char(2)
declare @L2310C_nm109_service_facility_id varchar(80)
declare @L2310C_ref02_1C_lab_or_facility_prov_id varchar(30)
declare @L2310C_ref02_1D_lab_or_facility_prov_id varchar(30)
declare @L2310C_ref02_1G_lab_or_facility_prov_id varchar(30)
declare @L2310C_ref02_EI_lab_or_facility_prov_id varchar(30)
declare @L2310C_ref02_G2_lab_or_facility_prov_id varchar(30)
declare @L2310C_ref02_TJ_lab_or_facility_prov_id varchar(30)

declare @L2310D_nm102_entity_type_qual char(1)
declare @L2310D_nm103_assistant_surgeon_last_nm varchar(35)
declare @L2310D_nm104_assistant_surgeon_first_nm varchar(25)
declare @L2310D_nm105_assistant_surgeon_middle_nm varchar(25)
declare @L2310D_nm107_assistant_surgeon_suffix varchar(10)
declare @L2310D_nm108_id_code_qual char(2)
declare @L2310D_nm109_assistant_surgeon_prov_id varchar(80)
declare @L2310D_prv01_provider_code char(3)
declare @L2310D_prv02_id_code_qual char(2)
declare @L2310D_prv03_taxonomy_code varchar(30)
declare @L2310D_ref02_1C_service_facility_id varchar(30)
declare @L2310D_ref02_1D_service_facility_id varchar(30)
declare @L2310D_ref02_1E_service_facility_id varchar(30)
declare @L2310D_ref02_G2_service_facility_id varchar(30)
declare @L2310D_ref02_TJ_service_facility_id varchar(30)

declare @L2320_1_1_cas01_adjustment_group_code char(2)
declare @L2320_1_1_cas02_adjustment_reason_code varchar(5)
declare @L2320_1_1_cas03_adjustment_amt money
declare @L2320_1_1_cas04_adjustment_qty varchar(15)
declare @L2320_1_1_cas05_adjustment_reason_code varchar(5)
declare @L2320_1_1_cas06_adjustment_amt money
declare @L2320_1_1_cas07_adjustment_qty varchar(15)
declare @L2320_1_1_cas08_adjustment_reason_code varchar(5)
declare @L2320_1_1_cas09_adjustment_amt money
declare @L2320_1_1_cas10_adjustment_qty varchar(15)

declare @L2320_1_2_cas01_adjustment_group_code char(2)
declare @L2320_1_2_cas02_adjustment_reason_code varchar(5)
declare @L2320_1_2_cas03_adjustment_amt money
declare @L2320_1_2_cas04_adjustment_qty varchar(15)
declare @L2320_1_2_cas05_adjustment_reason_code varchar(5)
declare @L2320_1_2_cas06_adjustment_amt money
declare @L2320_1_2_cas07_adjustment_qty varchar(15)
declare @L2320_1_2_cas08_adjustment_reason_code varchar(5)
declare @L2320_1_2_cas09_adjustment_amt money
declare @L2320_1_2_cas10_adjustment_qty varchar(15)

declare @L2320_1_3_cas01_adjustment_group_code char(2)
declare @L2320_1_3_cas02_adjustment_reason_code varchar(5)
declare @L2320_1_3_cas03_adjustment_amt money
declare @L2320_1_3_cas04_adjustment_qty varchar(15)
declare @L2320_1_3_cas05_adjustment_reason_code varchar(5)
declare @L2320_1_3_cas06_adjustment_amt money
declare @L2320_1_3_cas07_adjustment_qty varchar(15)
declare @L2320_1_3_cas08_adjustment_reason_code varchar(5)
declare @L2320_1_3_cas09_adjustment_amt money
declare @L2320_1_3_cas10_adjustment_qty varchar(15)

declare @L2320_1_4_cas01_adjustment_group_code char(2)
declare @L2320_1_4_cas02_adjustment_reason_code varchar(5)
declare @L2320_1_4_cas03_adjustment_amt money
declare @L2320_1_4_cas04_adjustment_qty varchar(15)
declare @L2320_1_4_cas05_adjustment_reason_code varchar(5)
declare @L2320_1_4_cas06_adjustment_amt money
declare @L2320_1_4_cas07_adjustment_qty varchar(15)
declare @L2320_1_4_cas08_adjustment_reason_code varchar(5)
declare @L2320_1_4_cas09_adjustment_amt money
declare @L2320_1_4_cas10_adjustment_qty varchar(15)

declare @L2320_1_5_cas01_adjustment_group_code char(2)
declare @L2320_1_5_cas02_adjustment_reason_code varchar(5)
declare @L2320_1_5_cas03_adjustment_amt money
declare @L2320_1_5_cas04_adjustment_qty varchar(15)
declare @L2320_1_5_cas05_adjustment_reason_code varchar(5)
declare @L2320_1_5_cas06_adjustment_amt money
declare @L2320_1_5_cas07_adjustment_qty varchar(15)
declare @L2320_1_5_cas08_adjustment_reason_code varchar(5)
declare @L2320_1_5_cas09_adjustment_amt money
declare @L2320_1_5_cas10_adjustment_qty varchar(15)

declare @L2320_1_amt02_AAE_cob_approved_amt money
declare @L2320_1_amt02_AU_cob_covered_amt money
declare @L2320_1_amt02_B6_cob_allowed_amt money
declare @L2320_1_amt02_D_payer_paid_amt money
declare @L2320_1_amt02_D8_discount_amt money
declare @L2320_1_amt02_F2_patient_responsibility_amt money
declare @L2320_1_amt02_F5_payer_patient_paid_amt money
declare @L2320_1_dmg02_other_subscriber_dob varchar(35)
declare @L2320_1_dmg03_other_subscriber_gender char(1)
declare @L2320_1_oi03_other_ins_benefit_assign_ind char(10)
declare @L2320_1_oi06_other_ins_release_of_info_code char(10)
declare @L2320_1_sbr01_payer_resp_seq_code char(1)
declare @L2320_1_sbr02_ind_relationship_code char(2)
declare @L2320_1_sbr03_insured_grp_policy_num varchar(30)
declare @L2320_1_sbr04_insured_grp_nm varchar(60)
declare @L2320_1_sbr09_claim_file_ind_code char(3)

declare @L2320_2_1_cas01_adjustment_group_code char(2)
declare @L2320_2_1_cas02_adjustment_reason_code varchar(5)
declare @L2320_2_1_cas03_adjustment_amt money
declare @L2320_2_1_cas04_adjustment_qty varchar(15)
declare @L2320_2_1_cas05_adjustment_reason_code varchar(5)
declare @L2320_2_1_cas06_adjustment_amt money
declare @L2320_2_1_cas07_adjustment_qty varchar(15)
declare @L2320_2_1_cas08_adjustment_reason_code varchar(5)
declare @L2320_2_1_cas09_adjustment_amt money
declare @L2320_2_1_cas10_adjustment_qty varchar(15)

declare @L2320_2_2_cas01_adjustment_group_code char(2)
declare @L2320_2_2_cas02_adjustment_reason_code varchar(5)
declare @L2320_2_2_cas03_adjustment_amt money
declare @L2320_2_2_cas04_adjustment_qty varchar(15)
declare @L2320_2_2_cas05_adjustment_reason_code varchar(5)
declare @L2320_2_2_cas06_adjustment_amt money
declare @L2320_2_2_cas07_adjustment_qty varchar(15)
declare @L2320_2_2_cas08_adjustment_reason_code varchar(5)
declare @L2320_2_2_cas09_adjustment_amt money
declare @L2320_2_2_cas10_adjustment_qty varchar(15)

declare @L2320_2_3_cas01_adjustment_group_code char(2)
declare @L2320_2_3_cas02_adjustment_reason_code varchar(5)
declare @L2320_2_3_cas03_adjustment_amt money
declare @L2320_2_3_cas04_adjustment_qty varchar(15)
declare @L2320_2_3_cas05_adjustment_reason_code varchar(5)
declare @L2320_2_3_cas06_adjustment_amt money
declare @L2320_2_3_cas07_adjustment_qty varchar(15)
declare @L2320_2_3_cas08_adjustment_reason_code varchar(5)
declare @L2320_2_3_cas09_adjustment_amt money
declare @L2320_2_3_cas10_adjustment_qty varchar(15)

declare @L2320_2_4_cas01_adjustment_group_code char(2)
declare @L2320_2_4_cas02_adjustment_reason_code varchar(5)
declare @L2320_2_4_cas03_adjustment_amt money
declare @L2320_2_4_cas04_adjustment_qty varchar(15)
declare @L2320_2_4_cas05_adjustment_reason_code varchar(5)
declare @L2320_2_4_cas06_adjustment_amt money
declare @L2320_2_4_cas07_adjustment_qty varchar(15)
declare @L2320_2_4_cas08_adjustment_reason_code varchar(5)
declare @L2320_2_4_cas09_adjustment_amt money
declare @L2320_2_4_cas10_adjustment_qty varchar(15)

declare @L2320_2_5_cas01_adjustment_group_code char(2)
declare @L2320_2_5_cas02_adjustment_reason_code varchar(5)
declare @L2320_2_5_cas03_adjustment_amt money
declare @L2320_2_5_cas04_adjustment_qty varchar(15)
declare @L2320_2_5_cas05_adjustment_reason_code varchar(5)
declare @L2320_2_5_cas06_adjustment_amt money
declare @L2320_2_5_cas07_adjustment_qty varchar(15)
declare @L2320_2_5_cas08_adjustment_reason_code varchar(5)
declare @L2320_2_5_cas09_adjustment_amt money
declare @L2320_2_5_cas10_adjustment_qty varchar(15)

declare @L2320_2_amt02_AAE_cob_approved_amt money
declare @L2320_2_amt02_AU_cob_covered_amt money
declare @L2320_2_amt02_B6_cob_allowed_amt money
declare @L2320_2_amt02_D_payer_paid_amt money
declare @L2320_2_amt02_D8_discount_amt money
declare @L2320_2_amt02_F2_patient_responsibility_amt money
declare @L2320_2_amt02_F5_payer_patient_paid_amt money
declare @L2320_2_dmg02_other_subscriber_dob varchar(35)
declare @L2320_2_dmg03_other_subscriber_gender char(1)
declare @L2320_2_oi03_other_ins_benefit_assign_ind char(10)
declare @L2320_2_oi06_other_ins_release_of_info_code char(10)
declare @L2320_2_sbr01_payer_resp_seq_code char(1)
declare @L2320_2_sbr02_ind_relationship_code char(2)
declare @L2320_2_sbr03_insured_grp_policy_num varchar(30)
declare @L2320_2_sbr04_insured_grp_nm varchar(60)
declare @L2320_2_sbr09_claim_file_ind_code char(3)

declare @L2320_3_1_cas01_adjustment_group_code char(2)
declare @L2320_3_1_cas02_adjustment_reason_code varchar(5)
declare @L2320_3_1_cas03_adjustment_amt money
declare @L2320_3_1_cas04_adjustment_qty varchar(15)
declare @L2320_3_1_cas05_adjustment_reason_code varchar(5)
declare @L2320_3_1_cas06_adjustment_amt money
declare @L2320_3_1_cas07_adjustment_qty varchar(15)
declare @L2320_3_1_cas08_adjustment_reason_code varchar(5)
declare @L2320_3_1_cas09_adjustment_amt money
declare @L2320_3_1_cas10_adjustment_qty varchar(15)

declare @L2320_3_2_cas01_adjustment_group_code char(2)
declare @L2320_3_2_cas02_adjustment_reason_code varchar(5)
declare @L2320_3_2_cas03_adjustment_amt money
declare @L2320_3_2_cas04_adjustment_qty varchar(15)
declare @L2320_3_2_cas05_adjustment_reason_code varchar(5)
declare @L2320_3_2_cas06_adjustment_amt money
declare @L2320_3_2_cas07_adjustment_qty varchar(15)
declare @L2320_3_2_cas08_adjustment_reason_code varchar(5)
declare @L2320_3_2_cas09_adjustment_amt money
declare @L2320_3_2_cas10_adjustment_qty varchar(15)

declare @L2320_3_3_cas01_adjustment_group_code char(2)
declare @L2320_3_3_cas02_adjustment_reason_code varchar(5)
declare @L2320_3_3_cas03_adjustment_amt money
declare @L2320_3_3_cas04_adjustment_qty varchar(15)
declare @L2320_3_3_cas05_adjustment_reason_code varchar(5)
declare @L2320_3_3_cas06_adjustment_amt money
declare @L2320_3_3_cas07_adjustment_qty varchar(15)
declare @L2320_3_3_cas08_adjustment_reason_code varchar(5)
declare @L2320_3_3_cas09_adjustment_amt money
declare @L2320_3_3_cas10_adjustment_qty varchar(15)

declare @L2320_3_4_cas01_adjustment_group_code char(2)
declare @L2320_3_4_cas02_adjustment_reason_code varchar(5)
declare @L2320_3_4_cas03_adjustment_amt money
declare @L2320_3_4_cas04_adjustment_qty varchar(15)
declare @L2320_3_4_cas05_adjustment_reason_code varchar(5)
declare @L2320_3_4_cas06_adjustment_amt money
declare @L2320_3_4_cas07_adjustment_qty varchar(15)
declare @L2320_3_4_cas08_adjustment_reason_code varchar(5)
declare @L2320_3_4_cas09_adjustment_amt money
declare @L2320_3_4_cas10_adjustment_qty varchar(15)

declare @L2320_3_5_cas01_adjustment_group_code char(2)
declare @L2320_3_5_cas02_adjustment_reason_code varchar(5)
declare @L2320_3_5_cas03_adjustment_amt money
declare @L2320_3_5_cas04_adjustment_qty varchar(15)
declare @L2320_3_5_cas05_adjustment_reason_code varchar(5)
declare @L2320_3_5_cas06_adjustment_amt money
declare @L2320_3_5_cas07_adjustment_qty varchar(15)
declare @L2320_3_5_cas08_adjustment_reason_code varchar(5)
declare @L2320_3_5_cas09_adjustment_amt money
declare @L2320_3_5_cas10_adjustment_qty varchar(15)

declare @L2320_3_amt02_AAE_cob_approved_amt money
declare @L2320_3_amt02_AU_cob_covered_amt money
declare @L2320_3_amt02_B6_cob_allowed_amt money
declare @L2320_3_amt02_D_payer_paid_amt money
declare @L2320_3_amt02_D8_discount_amt money
declare @L2320_3_amt02_F2_patient_responsibility_amt money
declare @L2320_3_amt02_F5_payer_patient_paid_amt money
declare @L2320_3_dmg02_other_subscriber_dob varchar(35)
declare @L2320_3_dmg03_other_subscriber_gender char(1)
declare @L2320_3_oi03_other_ins_benefit_assign_ind char(10)
declare @L2320_3_oi06_other_ins_release_of_info_code char(10)
declare @L2320_3_sbr01_payer_resp_seq_code char(1)
declare @L2320_3_sbr02_ind_relationship_code char(2)
declare @L2320_3_sbr03_insured_grp_policy_num varchar(30)
declare @L2320_3_sbr04_insured_grp_nm varchar(60)
declare @L2320_3_sbr09_claim_file_ind_code char(3)

declare @L2330A_1_nm101_entity_id_code char(3)
declare @L2330A_1_nm102_entity_type_qual varchar(35)
declare @L2330A_1_nm103_other_subscriber_last_name varchar(35)
declare @L2330A_1_nm104_other_subscriber_first_name varchar(25)
declare @L2330A_1_nm105_other_subscriber_middle_name varchar(25)
declare @L2330A_1_nm107_other_subscriber_name_suffix varchar(10)
declare @L2330A_1_nm108_other_subscriber_id_code_qual char(2)
declare @L2330A_1_nm109_other_subscriber_id varchar(80)
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

declare @L2330A_2_nm101_entity_id_code char(3)
declare @L2330A_2_nm102_entity_type_qual varchar(35)
declare @L2330A_2_nm103_other_subscriber_last_name varchar(35)
declare @L2330A_2_nm104_other_subscriber_first_name varchar(25)
declare @L2330A_2_nm105_other_subscriber_middle_name varchar(25)
declare @L2330A_2_nm107_other_subscriber_name_suffix varchar(10)
declare @L2330A_2_nm108_other_subscriber_id_code_qual char(2)
declare @L2330A_2_nm109_other_subscriber_id varchar(80)
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

declare @L2330A_3_nm101_entity_id_code char(3)
declare @L2330A_3_nm102_entity_type_qual varchar(35)
declare @L2330A_3_nm103_other_subscriber_last_name varchar(35)
declare @L2330A_3_nm104_other_subscriber_first_name varchar(25)
declare @L2330A_3_nm105_other_subscriber_middle_name varchar(25)
declare @L2330A_3_nm107_other_subscriber_name_suffix varchar(10)
declare @L2330A_3_nm108_other_subscriber_id_code_qual char(2)
declare @L2330A_3_nm109_other_subscriber_id varchar(80)
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

declare @L2330B_1_dtp03_573_date_claim_paid varchar(35)
declare @L2330B_1_nm101_entity_id_code char(3)
declare @L2330B_1_nm102_entity_type_qual char(1)
declare @L2330B_1_nm103_other_payer_nm varchar(35)
declare @L2330B_1_nm108_id_code_qual char(2)
declare @L2330B_1_nm109_other_payer_id varchar(80)
declare @L2330B_1_ref02_2U_other_payer_secondary_id varchar(30)
declare @L2330B_1_ref02_9F_other_payer_auth_num varchar(30)
declare @L2330B_1_ref02_F8_other_payer_secondary_id varchar(30)
declare @L2330B_1_ref02_FY_other_payer_secondary_id varchar(30)
declare @L2330B_1_ref02_G1_other_payer_auth_num varchar(30)
declare @L2330B_1_ref02_NF_other_payer_secondary_id varchar(30)
declare @L2330B_1_ref02_T4_other_payer_claim_adj_ind varchar(30)
declare @L2330B_1_ref02_TJ_other_payer_secondary_id varchar(30)

declare @L2330B_2_dtp03_573_date_claim_paid varchar(35)
declare @L2330B_2_nm101_entity_id_code char(3)
declare @L2330B_2_nm102_entity_type_qual char(1)
declare @L2330B_2_nm103_other_payer_nm varchar(35)
declare @L2330B_2_nm108_id_code_qual char(2)
declare @L2330B_2_nm109_other_payer_id varchar(80)
declare @L2330B_2_ref02_2U_other_payer_secondary_id varchar(30)
declare @L2330B_2_ref02_9F_other_payer_auth_num varchar(30)
declare @L2330B_2_ref02_F8_other_payer_secondary_id varchar(30)
declare @L2330B_2_ref02_FY_other_payer_secondary_id varchar(30)
declare @L2330B_2_ref02_G1_other_payer_auth_num varchar(30)
declare @L2330B_2_ref02_NF_other_payer_secondary_id varchar(30)
declare @L2330B_2_ref02_T4_other_payer_claim_adj_ind varchar(30)
declare @L2330B_2_ref02_TJ_other_payer_secondary_id varchar(30)

declare @L2330B_3_dtp03_573_date_claim_paid varchar(35)
declare @L2330B_3_nm101_entity_id_code char(3)
declare @L2330B_3_nm102_entity_type_qual char(1)
declare @L2330B_3_nm103_other_payer_nm varchar(35)
declare @L2330B_3_nm108_id_code_qual char(2)
declare @L2330B_3_nm109_other_payer_id varchar(80)
declare @L2330B_3_ref02_2U_other_payer_secondary_id varchar(30)
declare @L2330B_3_ref02_9F_other_payer_auth_num varchar(30)
declare @L2330B_3_ref02_F8_other_payer_secondary_id varchar(30)
declare @L2330B_3_ref02_FY_other_payer_secondary_id varchar(30)
declare @L2330B_3_ref02_G1_other_payer_auth_num varchar(30)
declare @L2330B_3_ref02_NF_other_payer_secondary_id varchar(30)
declare @L2330B_3_ref02_T4_other_payer_claim_adj_ind varchar(30)
declare @L2330B_3_ref02_TJ_other_payer_secondary_id varchar(30)

declare @L2400_1_qty01_qty_qual char(2)
declare @L2400_1_qty02_anesthesia_unit_count varchar(15)
declare @L2400_2_qty01_qty_qual char(2)
declare @L2400_2_qty02_anesthesia_unit_count varchar(15)
declare @L2400_3_qty01_qty_qual char(2)
declare @L2400_3_qty02_anesthesia_unit_count varchar(15)
declare @L2400_4_qty01_qty_qual char(2)
declare @L2400_4_qty02_anesthesia_unit_count varchar(15)
declare @L2400_5_qty01_qty_qual char(2)
declare @L2400_5_qty02_anesthesia_unit_count varchar(15)
declare @L2400_amt02_AAE_approved_amt money
declare @L2400_amt02_T_sales_tax_amt money
declare @L2400_dtp02_441_prior_placement_date varchar(35)
declare @L2400_dtp02_446_replacement_date varchar(35)
declare @L2400_dtp02_452_orthodontic_banding_date varchar(35)
declare @L2400_dtp02_472_service_date varchar(35)
declare @L2400_lx01_assigned_num varchar(6)
declare @L2400_nte01_note_ref_code char(3)
declare @L2400_nte02_line_note_text varchar(80)
declare @L2400_ref02_6R_line_item_control_num varchar(30)
declare @L2400_ref02_9F_referral_number varchar(30)
declare @L2400_ref02_G1_prior_auth_number varchar(30)
declare @L2400_ref02_G3_predetermination_of_benefits_id varchar(30)
declare @L2400_sv301_proc_code varchar(48)
declare @L2400_sv301_proc_code_qual char(2)
declare @L2400_sv301_proc_mod1 char(2)
declare @L2400_sv301_proc_mod2 char(2)
declare @L2400_sv301_proc_mod3 char(2)
declare @L2400_sv301_proc_mod4 char(2)
declare @L2400_sv302_line_charge money
declare @L2400_sv303_facility_type_code varchar(3)
declare @L2400_sv304_oral_cavity_designation_code_1 char(3)
declare @L2400_sv304_oral_cavity_designation_code_2 char(3)
declare @L2400_sv304_oral_cavity_designation_code_3 char(3)
declare @L2400_sv304_oral_cavity_designation_code_4 char(3)
declare @L2400_sv304_oral_cavity_designation_code_5 char(3)
declare @L2400_sv305_prosthesis_crown_inlay_code char(1)
declare @L2400_sv306_procedure_count varchar(15)
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

declare @L2420A_nm102_entity_type_qual char(1)
declare @L2420A_nm103_rendering_prov_last_nm varchar(35)
declare @L2420A_nm104_rendering_prov_first_nm varchar(25)
declare @L2420A_nm105_rendering_prov_middle_nm varchar(25)
declare @L2420A_nm107_rendering_prov_suffix varchar(10)
declare @L2420A_nm108_id_code_qual char(2)
declare @L2420A_nm109_rendering_prov_id varchar(80)
declare @L2420A_prv01_provider_code char(3)
declare @L2420A_prv02_ref_id_qual char(3)
declare @L2420A_prv03_taxonomy_code varchar(30)
declare @L2420A_ref02_1C_rendering_prov_id varchar(30)
declare @L2420A_ref02_1D_rendering_prov_id varchar(30)
declare @L2420A_ref02_1E_rendering_prov_id varchar(30)
declare @L2420A_ref02_EI_rendering_prov_id varchar(30)
declare @L2420A_ref02_SY_rendering_prov_id varchar(30)
declare @L2420A_ref02_TJ_rendering_prov_id varchar(30)

declare @L2420B_nm102_entity_type_qual char(1)
declare @L2420B_nm103_payer_last_nm varchar(35)
declare @L2420B_nm108_id_code_qual char(2)
declare @L2420B_nm109_other_payer_id varchar(80)
declare @L2420B_ref02_9F_referral_number varchar(30)
declare @L2420B_ref02_G1_prior_auth_number varchar(30)

declare @L2420C_nm101_entity_id_code char(3)
declare @L2420C_nm102_entity_type_qual char(1)
declare @L2420C_nm103_assistant_surgeon_last_nm varchar(35)
declare @L2420C_nm104_assistant_surgeon_first_nm varchar(25)
declare @L2420C_nm105_assistant_surgeon_middle_nm varchar(25)
declare @L2420C_nm107_assistant_surgeon_suffix varchar(10)
declare @L2420C_nm108_id_code_qual char(2)
declare @L2420C_nm109_assistant_surgeon_id varchar(80)
declare @L2420C_prv01_provider_code char(3)
declare @L2420C_prv02_ref_id_qual char(3)
declare @L2420C_prv03_taxonomy_code varchar(30)
declare @L2420C_ref02_1C_service_facility_id varchar(30)
declare @L2420C_ref02_1D_service_facility_id varchar(30)
declare @L2420C_ref02_1E_service_facility_id varchar(30)
declare @L2420C_ref02_G2_service_facility_id varchar(30)
declare @L2420C_ref02_TJ_service_facility_id varchar(30)

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

declare @L2430_1_cas01_adjustment_group_code char(2)
declare @L2430_1_cas02_adjustment_reason_code varchar(5)
declare @L2430_1_cas03_adjustment_amt money
declare @L2430_1_cas04_adjustment_qty varchar(15)
declare @L2430_1_cas05_adjustment_reason_code varchar(5)
declare @L2430_1_cas06_adjustment_amt money
declare @L2430_1_cas07_adjustment_qty varchar(15)
declare @L2430_1_cas08_adjustment_reason_code varchar(5)
declare @L2430_1_cas09_adjustment_amt money
declare @L2430_1_cas10_adjustment_qty varchar(15)
declare @L2430_1_cas11_adjustment_reason_code varchar(5)
declare @L2430_1_cas12_adjustment_amt money
declare @L2430_1_cas13_adjustment_qty varchar(15)
declare @L2430_1_cas14_adjustment_reason_code varchar(5)
declare @L2430_1_cas15_adjustment_amt money
declare @L2430_1_cas16_adjustment_qty varchar(15)
declare @L2430_1_cas17_adjustment_reason_code varchar(5)
declare @L2430_1_cas18_adjustment_amt money
declare @L2430_1_cas19_adjustment_qty varchar(15)
declare @L2430_2_cas01_adjustment_group_code char(2)
declare @L2430_2_cas02_adjustment_reason_code varchar(5)
declare @L2430_2_cas03_adjustment_amt money
declare @L2430_2_cas04_adjustment_qty varchar(15)
declare @L2430_2_cas05_adjustment_reason_code varchar(5)
declare @L2430_2_cas06_adjustment_amt money
declare @L2430_2_cas07_adjustment_qty varchar(15)
declare @L2430_2_cas08_adjustment_reason_code varchar(5)
declare @L2430_2_cas09_adjustment_amt money
declare @L2430_2_cas10_adjustment_qty varchar(15)
declare @L2430_2_cas11_adjustment_reason_code varchar(5)
declare @L2430_2_cas12_adjustment_amt money
declare @L2430_2_cas13_adjustment_qty varchar(15)
declare @L2430_2_cas14_adjustment_reason_code varchar(5)
declare @L2430_2_cas15_adjustment_amt money
declare @L2430_2_cas16_adjustment_qty varchar(15)
declare @L2430_2_cas17_adjustment_reason_code varchar(5)
declare @L2430_2_cas18_adjustment_amt money
declare @L2430_2_cas19_adjustment_qty varchar(15)
declare @L2430_3_cas01_adjustment_group_code char(2)
declare @L2430_3_cas02_adjustment_reason_code varchar(5)
declare @L2430_3_cas03_adjustment_amt money
declare @L2430_3_cas04_adjustment_qty varchar(15)
declare @L2430_3_cas05_adjustment_reason_code varchar(5)
declare @L2430_3_cas06_adjustment_amt money
declare @L2430_3_cas07_adjustment_qty varchar(15)
declare @L2430_3_cas08_adjustment_reason_code varchar(5)
declare @L2430_3_cas09_adjustment_amt money
declare @L2430_3_cas10_adjustment_qty varchar(15)
declare @L2430_3_cas11_adjustment_reason_code varchar(5)
declare @L2430_3_cas12_adjustment_amt money
declare @L2430_3_cas13_adjustment_qty varchar(15)
declare @L2430_3_cas14_adjustment_reason_code varchar(5)
declare @L2430_3_cas15_adjustment_amt money
declare @L2430_3_cas16_adjustment_qty varchar(15)
declare @L2430_3_cas17_adjustment_reason_code varchar(5)
declare @L2430_3_cas18_adjustment_amt money
declare @L2430_3_cas19_adjustment_qty varchar(15)
declare @L2430_4_cas01_adjustment_group_code char(2)
declare @L2430_4_cas02_adjustment_reason_code varchar(5)
declare @L2430_4_cas03_adjustment_amt money
declare @L2430_4_cas04_adjustment_qty varchar(15)
declare @L2430_4_cas05_adjustment_reason_code varchar(5)
declare @L2430_4_cas06_adjustment_amt money
declare @L2430_4_cas07_adjustment_qty varchar(15)
declare @L2430_4_cas08_adjustment_reason_code varchar(5)
declare @L2430_4_cas09_adjustment_amt money
declare @L2430_4_cas10_adjustment_qty varchar(15)
declare @L2430_4_cas11_adjustment_reason_code varchar(5)
declare @L2430_4_cas12_adjustment_amt money
declare @L2430_4_cas13_adjustment_qty varchar(15)
declare @L2430_4_cas14_adjustment_reason_code varchar(5)
declare @L2430_4_cas15_adjustment_amt money
declare @L2430_4_cas16_adjustment_qty varchar(15)
declare @L2430_4_cas17_adjustment_reason_code varchar(5)
declare @L2430_4_cas18_adjustment_amt money
declare @L2430_4_cas19_adjustment_qty varchar(15)
declare @L2430_5_cas01_adjustment_group_code char(2)
declare @L2430_5_cas02_adjustment_reason_code varchar(5)
declare @L2430_5_cas03_adjustment_amt money
declare @L2430_5_cas04_adjustment_qty varchar(15)
declare @L2430_5_cas05_adjustment_reason_code varchar(5)
declare @L2430_5_cas06_adjustment_amt money
declare @L2430_5_cas07_adjustment_qty varchar(15)
declare @L2430_5_cas08_adjustment_reason_code varchar(5)
declare @L2430_5_cas09_adjustment_amt money
declare @L2430_5_cas10_adjustment_qty varchar(15)
declare @L2430_5_cas11_adjustment_reason_code varchar(5)
declare @L2430_5_cas12_adjustment_amt money
declare @L2430_5_cas13_adjustment_qty varchar(15)
declare @L2430_5_cas14_adjustment_reason_code varchar(5)
declare @L2430_5_cas15_adjustment_amt money
declare @L2430_5_cas16_adjustment_qty varchar(15)
declare @L2430_5_cas17_adjustment_reason_code varchar(5)
declare @L2430_5_cas18_adjustment_amt money
declare @L2430_5_cas19_adjustment_qty varchar(15)
declare @L2430_dtp03_573_date_claim_paid varchar(35)
declare @L2430_svd01_other_payer_id varchar(80)
declare @L2430_svd02_service_line_paid money
declare @L2430_svd03_proc_code varchar(48)
declare @L2430_svd03_proc_code_desc varchar(80)
declare @L2430_svd03_proc_mod1 char(2)
declare @L2430_svd03_proc_mod2 char(2)
declare @L2430_svd03_proc_mod3 char(2)
declare @L2430_svd03_proc_mod4 char(2)
declare @L2430_svd03_service_id_qual char(2)
declare @L2430_svd05_paid_service_unit varchar(15)
declare @L2430_svd06_bundled_unbundled_line_num varchar(6)
-- END: DECLARE 837d Variables


-- BEGIN: DECLARE PREV_ 837d Variables
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

declare @prev_L2000B_hl01_hierarchical_id_num varchar(12)
declare @prev_L2000B_hl02_hierarchical_parent_id_num varchar(12)
declare @prev_L2000B_hl03_hierarchical_level_code char(2)
declare @prev_L2000B_hl04_hierarchical_child_code char(1)
declare @prev_L2000B_sbr01_payer_resp_seq_code char(1)
declare @prev_L2000B_sbr02_ind_relationship_code char(2)
declare @prev_L2000B_sbr03_insured_grp_policy_num varchar(30)
declare @prev_L2000B_sbr04_insured_grp_nm varchar(60)
declare @prev_L2000B_sbr06_cob_code char(1)
declare @prev_L2000B_sbr09_claim_filing_ind_code char(2)

declare @prev_L2000C_hl01_hierarchical_id_num varchar(12)
declare @prev_L2000C_hl02_hierarchical_parent_id_num varchar(12)
declare @prev_L2000C_hl03_hierarchical_level_code char(2)
declare @prev_L2000C_hl04_hierarchical_child_code char(1)

declare @prev_L2010AA_n301_billing_prov_address1 varchar(55)
declare @prev_L2010AA_n302_billing_prov_address2 varchar(55)
declare @prev_L2010AA_n401_billing_prov_city varchar(30)
declare @prev_L2010AA_n402_billing_prov_state char(2)
declare @prev_L2010AA_n403_billing_prov_zip varchar(15)
declare @prev_L2010AA_n404_billing_prov_country char(3)
declare @prev_L2010AA_nm102_entity_type_qual char(1)
declare @prev_L2010AA_nm103_billing_prov_last_nm varchar(35)
declare @prev_L2010AA_nm104_billing_prov_first_nm varchar(25)
declare @prev_L2010AA_nm105_billing_prov_middle_nm varchar(25)
declare @prev_L2010AA_nm107_billing_prov_suffix varchar(10)
declare @prev_L2010AA_nm108_id_code_qual char(2)
declare @prev_L2010AA_nm109_billing_prov_id varchar(80)
declare @prev_L2010AA_ref02_06_card_billing_id varchar(30)
declare @prev_L2010AA_ref02_1C_billing_prov_id varchar(30)
declare @prev_L2010AA_ref02_1D_billing_prov_id varchar(30)
declare @prev_L2010AA_ref02_1E_billing_prov_id varchar(30)
declare @prev_L2010AA_ref02_8U_card_billing_id varchar(30)
declare @prev_L2010AA_ref02_EI_billing_prov_id varchar(30)
declare @prev_L2010AA_ref02_EM_card_billing_id varchar(30)
declare @prev_L2010AA_ref02_IJ_card_billing_id varchar(30)
declare @prev_L2010AA_ref02_LU_card_billing_id varchar(30)
declare @prev_L2010AA_ref02_ST_card_billing_id varchar(30)
declare @prev_L2010AA_ref02_SY_billing_prov_id varchar(30)
declare @prev_L2010AA_ref02_TJ_billing_prov_id varchar(30)

declare @prev_L2010BA_n301_subscriber_address1 varchar(55)
declare @prev_L2010BA_n302_subscriber_address2 varchar(55)
declare @prev_L2010BA_n401_subscriber_city varchar(30)
declare @prev_L2010BA_n402_subscriber_state char(2)
declare @prev_L2010BA_n403_subscriber_zip varchar(15)
declare @prev_L2010BA_n404_subscriber_country char(3)
declare @prev_L2010BA_nm102_entity_type_qual char(1)
declare @prev_L2010BA_nm103_subscriber_last_nm varchar(35)
declare @prev_L2010BA_nm104_subscriber_first_nm varchar(25)
declare @prev_L2010BA_nm105_subscriber_middle_nm varchar(25)
declare @prev_L2010BA_nm107_subscriber_suffix varchar(10)
declare @prev_L2010BA_nm108_id_code_qual char(2)
declare @prev_L2010BA_nm109_subscriber_id varchar(80)

declare @prev_L2010CA_nm102_entity_type_qual char(1)
declare @prev_L2010CA_nm103_patient_last_nm varchar(35)
declare @prev_L2010CA_nm104_patient_first_nm varchar(25)
declare @prev_L2010CA_nm105_patient_middle_nm varchar(25)
declare @prev_L2010CA_nm107_patient_suffix varchar(10)
declare @prev_L2010CA_nm108_id_code_qual char(2)
declare @prev_L2010CA_nm109_patient_id varchar(80)

declare @prev_L2300_clm01_pt_acct_num varchar(38)
declare @prev_L2300_clm02_total_claim_chg_amt money
declare @prev_L2300_ref02_4N_service_auth_exception_code varchar(30)
declare @prev_L2300_ref02_9F_prior_auth_num varchar(30)
declare @prev_L2300_ref02_9F_referral_num varchar(30)
declare @prev_L2300_ref02_D9_value_added_network_trace_num varchar(30)
declare @prev_L2300_ref02_F8_original_ref_num varchar(30)
declare @prev_L2300_ref02_G1_prior_auth_num varchar(30)
declare @prev_L2300_ref02_G3_referral_num varchar(30)

declare @prev_L2330B_1_ref02_2U_other_payer_secondary_id varchar(30)
declare @prev_L2330B_1_ref02_9F_other_payer_auth_num varchar(30)
declare @prev_L2330B_1_ref02_F8_other_payer_secondary_id varchar(30)
declare @prev_L2330B_1_ref02_FY_other_payer_secondary_id varchar(30)
declare @prev_L2330B_1_ref02_G1_other_payer_auth_num varchar(30)
declare @prev_L2330B_1_ref02_NF_other_payer_secondary_id varchar(30)
declare @prev_L2330B_1_ref02_T4_other_payer_claim_adj_ind varchar(30)
declare @prev_L2330B_1_ref02_TJ_other_payer_secondary_id varchar(30)

declare @prev_L2330B_2_ref02_2U_other_payer_secondary_id varchar(30)
declare @prev_L2330B_2_ref02_9F_other_payer_auth_num varchar(30)
declare @prev_L2330B_2_ref02_F8_other_payer_secondary_id varchar(30)
declare @prev_L2330B_2_ref02_FY_other_payer_secondary_id varchar(30)
declare @prev_L2330B_2_ref02_G1_other_payer_auth_num varchar(30)
declare @prev_L2330B_2_ref02_NF_other_payer_secondary_id varchar(30)
declare @prev_L2330B_2_ref02_T4_other_payer_claim_adj_ind varchar(30)
declare @prev_L2330B_2_ref02_TJ_other_payer_secondary_id varchar(30)

declare @prev_L2330B_3_ref02_2U_other_payer_secondary_id varchar(30)
declare @prev_L2330B_3_ref02_9F_other_payer_auth_num varchar(30)
declare @prev_L2330B_3_ref02_F8_other_payer_secondary_id varchar(30)
declare @prev_L2330B_3_ref02_FY_other_payer_secondary_id varchar(30)
declare @prev_L2330B_3_ref02_G1_other_payer_auth_num varchar(30)
declare @prev_L2330B_3_ref02_NF_other_payer_secondary_id varchar(30)
declare @prev_L2330B_3_ref02_T4_other_payer_claim_adj_ind varchar(30)
declare @prev_L2330B_3_ref02_TJ_other_payer_secondary_id varchar(30)

declare @prev_L2400_lx01_assigned_num varchar(6)
-- END: DECLARE PREV_ 837d Variables

declare @x12_interchange_uid uniqueidentifier
declare @patdeathdate as varchar(3)

declare @global_hl01_hierarchical_id_num int

declare @SQLString nvarchar(4000)

declare @Other2300DNLoopCount int
declare @tmp_dn201_tooth_number varchar(30)
declare @tmp_dn202_tooth_status_code varchar(2)

declare @Other2400TOOLoopCount int
declare @tmp_JP_tooth_code varchar(30)
declare @tmp_tooth_surface_code_1 char(2)
declare @tmp_tooth_surface_code_2 char(2)
declare @tmp_tooth_surface_code_3 char(2)
declare @tmp_tooth_surface_code_4 char(2)
declare @tmp_tooth_surface_code_5 char(2)

set @Other2300DNLoopCount = 0
set @Other2400TOOLoopCount = 0

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

-- Set the x12_interchange_uid value of the 837d transaction that's being exported.
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
	SELECT x12_transaction_id, 
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
		L2430_dtp03_573_date_claim_paid
	from x12_837_claim_dental
	where	x12_transaction_id = @x12_transaction_id
	order by x12_837_claim_dental_id
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
								@L2430_dtp03_573_date_claim_paid
	
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
						@prev_L2010AA_ref02_1E_billing_prov_id,
						@prev_L2010AA_ref02_EI_billing_prov_id,
						@prev_L2010AA_ref02_SY_billing_prov_id,
						@prev_L2010AA_ref02_TJ_billing_prov_id
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
						@L2010AA_ref02_1E_billing_prov_id,
						@L2010AA_ref02_EI_billing_prov_id,
						@L2010AA_ref02_SY_billing_prov_id,
						@L2010AA_ref02_TJ_billing_prov_id

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
	-- 2010AA Loop REF 1E Segment
		if 	(@L2010AA_ref02_1E_billing_prov_id  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = '1E',
						@ref02_reference_number = @L2010AA_ref02_1E_billing_prov_id
	
			 
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
	-- 2010AA Loop REF TJ
		if 	(@L2010AA_ref02_TJ_billing_prov_id  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'TJ',
						@ref02_reference_number = @L2010AA_ref02_TJ_billing_prov_id
				
			 
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
	-- END: 2010 REF SEGMENTS
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
		-- 2010AB Loop REF 1E Segment
			if 	(@L2010AB_ref02_1E_payto_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1E',
							@ref02_reference_number = @L2010AB_ref02_1E_payto_prov_id
					
				 
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
		-- 2010AB Loop REF TJ
			if 	(@L2010AB_ref02_TJ_payto_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'TJ',
							@ref02_reference_number = @L2010AB_ref02_TJ_payto_prov_id
					
				 
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
						@prev_L2000B_sbr06_cob_code,
						@prev_L2000B_sbr09_claim_filing_ind_code,
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
						@L2000B_sbr06_cob_code,
						@L2000B_sbr09_claim_filing_ind_code,
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
						@sbr06_cob_code = @L2000B_sbr06_cob_code,
						@sbr09_claim_filing_ind_code = @L2000B_sbr09_claim_filing_ind_code
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
		if (	@L2010BB_nm108_payer_id_qual IS NOT NULL OR
			@L2010BB_nm109_payer_id IS NOT NULL)
		begin
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = 'PR',
						@nm102_entity_type_qual = @L2010BB_nm102_entity_type_qual,
						@nm103_last_name = @L2010BB_nm103_payer_nm,
						@nm108_id_code_qual = @L2010BB_nm108_payer_id_qual,
						@nm109_id_code = @L2010BB_nm109_payer_id

		-- 2010BB Loop N3 and N4 Segments
			if (@L2010BB_n301_payer_address1 IS NOT NULL)
			begin
				exec up_x12_n3_export	@x12_interchange_uid = @x12_interchange_uid,
					@n301_address1 = @L2010BB_n301_payer_address1,
					@n302_address2 = @L2010BB_n302_payer_address2

				exec up_x12_n4_export	@x12_interchange_uid = @x12_interchange_uid,
					@n401_city = @L2010BB_n401_payer_city,
					@n402_state = @L2010BB_n402_payer_state,
					@n403_zip = @L2010BB_n403_payer_zip,
					@n404_country = @L2010BB_n404_payer_country
			end

		-- 2010BB Loop REF 2U Segment
			if 	(@L2010BB_ref02_2U_payer_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '2U',
							@ref02_reference_number = @L2010BB_ref02_2U_payer_id
					
				 
			end
		-- 2010BB Loop REF FY Segment
			if 	(@L2010BB_ref02_FY_payer_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'FY',
							@ref02_reference_number = @L2010BB_ref02_FY_payer_id
					
				 
			end

		-- 2010BB Loop REF NF Segment
			if 	(@L2010BB_ref02_NF_payer_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'NF',
							@ref02_reference_number = @L2010BB_ref02_NF_payer_id
					
				 
			end

		-- 2010BB Loop REF TJ Segment
			if 	(@L2010BB_ref02_TJ_payer_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'TJ',
							@ref02_reference_number = @L2010BB_ref02_TJ_payer_id
					
				 
			end
		end
	

	-- BEGIN: 2010BC LOOP
		if (	@L2010BC_nm103_resp_party_last_nm IS NOT NULL OR
			@L2010BC_nm109_MI_card_num IS NOT NULL )
		begin
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = 'AO',
						@nm103_last_name = @L2010BC_nm103_resp_party_last_nm,
						@nm104_first_name = @L2010BC_nm104_resp_party_first_nm,
						@nm105_middle_name = @L2010BC_nm105_resp_party_middle_nm,
						@nm107_name_suffix = @L2010BC_nm107_resp_party_suffix,
						@nm109_id_code = @L2010BC_nm109_MI_card_num				
	
		-- 2010BC Loop REF BB segment
			if 	(@L2010BC_ref02_BB_card_num IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'BB',
							@ref02_reference_number = @L2010BC_ref02_BB_card_num
			end
		End	
	-- END: 2010BC LOOP
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
						@prev_L2000B_sbr06_cob_code,
						@prev_L2000B_sbr09_claim_filing_ind_code,
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
						@L2000B_sbr06_cob_code,
						@L2000B_sbr09_claim_filing_ind_code,
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
					@pat01_ind_rel_code = @L2000C_pat01_ind_relationship_code,
					@pat04_student_status_code = @L2000C_pat04_student_status_code
		-- END: 2010CA-PAT

		-- BEGIN: 2010CA-NM1 segment, this segment is always required in the 2010CA loop.
		exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
					@nm101_entity_id_code = 'QC',
					@nm102_entity_type_qual = @L2010CA_nm102_entity_type_qual,
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
/*
	if	(	IsNull(@L2000B_hl01_hierarchical_id_num, '') <> IsNull(@prev_L2000B_hl01_hierarchical_id_num, '') OR
			IsNull(@L2000C_hl01_hierarchical_id_num, '') <> IsNull(@prev_L2000C_hl01_hierarchical_id_num, '') OR
			@L2300_clm01_pt_acct_num <> IsNull(@prev_L2300_clm01_pt_acct_num, '') OR
			@L2300_clm01_pt_acct_num IS NULL OR
			@L2300_clm02_total_claim_chg_amt <> @prev_L2300_clm02_total_claim_chg_amt OR
			@L2330B_ref02_F8_other_payer_secondary_id <> @prev_L2330B_ref02_F8_other_payer_secondary_id OR
			@L2300_ref02_F8_original_ref_num <> @prev_L2300_ref02_F8_original_ref_num
*/
	-- If this is a different subscriber, a different patient, a different patient account number, or the charges are different, start a new 2300 LOOP.
	if	(	IsNull(@L2000B_hl01_hierarchical_id_num, '') <> IsNull(@prev_L2000B_hl01_hierarchical_id_num, '') OR
			IsNull(@L2000C_hl01_hierarchical_id_num, '') <> IsNull(@prev_L2000C_hl01_hierarchical_id_num, '') OR
			@L2300_clm01_pt_acct_num <> IsNull(@prev_L2300_clm01_pt_acct_num, '') OR
			@L2300_clm01_pt_acct_num IS NULL OR
			@L2300_clm02_total_claim_chg_amt <> @prev_L2300_clm02_total_claim_chg_amt OR
			@L2330B_1_ref02_2U_other_payer_secondary_id <> @prev_L2330B_1_ref02_2U_other_payer_secondary_id OR
			@L2330B_1_ref02_F8_other_payer_secondary_id <> @prev_L2330B_1_ref02_F8_other_payer_secondary_id OR
			@L2330B_1_ref02_FY_other_payer_secondary_id <> @prev_L2330B_1_ref02_FY_other_payer_secondary_id OR
			@L2330B_1_ref02_NF_other_payer_secondary_id <> @prev_L2330B_1_ref02_NF_other_payer_secondary_id OR
			@L2330B_1_ref02_TJ_other_payer_secondary_id <> @prev_L2330B_1_ref02_TJ_other_payer_secondary_id OR
			@L2330B_1_ref02_9F_other_payer_auth_num <> @prev_L2330B_1_ref02_9F_other_payer_auth_num OR
			@L2330B_1_ref02_G1_other_payer_auth_num <> @prev_L2330B_1_ref02_G1_other_payer_auth_num OR
			@L2330B_1_ref02_T4_other_payer_claim_adj_ind <> @prev_L2330B_1_ref02_T4_other_payer_claim_adj_ind OR
			@L2330B_2_ref02_2U_other_payer_secondary_id <> @prev_L2330B_2_ref02_2U_other_payer_secondary_id OR
			@L2330B_2_ref02_F8_other_payer_secondary_id <> @prev_L2330B_2_ref02_F8_other_payer_secondary_id OR
			@L2330B_2_ref02_FY_other_payer_secondary_id <> @prev_L2330B_2_ref02_FY_other_payer_secondary_id OR
			@L2330B_2_ref02_NF_other_payer_secondary_id <> @prev_L2330B_2_ref02_NF_other_payer_secondary_id OR
			@L2330B_2_ref02_TJ_other_payer_secondary_id <> @prev_L2330B_2_ref02_TJ_other_payer_secondary_id OR
			@L2330B_2_ref02_9F_other_payer_auth_num <> @prev_L2330B_2_ref02_9F_other_payer_auth_num OR
			@L2330B_2_ref02_G1_other_payer_auth_num <> @prev_L2330B_2_ref02_G1_other_payer_auth_num OR
			@L2330B_2_ref02_T4_other_payer_claim_adj_ind <> @prev_L2330B_2_ref02_T4_other_payer_claim_adj_ind OR
			@L2330B_3_ref02_2U_other_payer_secondary_id <> @prev_L2330B_3_ref02_2U_other_payer_secondary_id OR
			@L2330B_3_ref02_F8_other_payer_secondary_id <> @prev_L2330B_3_ref02_F8_other_payer_secondary_id OR
			@L2330B_3_ref02_FY_other_payer_secondary_id <> @prev_L2330B_3_ref02_FY_other_payer_secondary_id OR
			@L2330B_3_ref02_NF_other_payer_secondary_id <> @prev_L2330B_3_ref02_NF_other_payer_secondary_id OR
			@L2330B_3_ref02_TJ_other_payer_secondary_id <> @prev_L2330B_3_ref02_TJ_other_payer_secondary_id OR
			@L2330B_3_ref02_9F_other_payer_auth_num <> @prev_L2330B_3_ref02_9F_other_payer_auth_num OR
			@L2330B_3_ref02_G1_other_payer_auth_num <> @prev_L2330B_3_ref02_G1_other_payer_auth_num OR
			@L2330B_3_ref02_T4_other_payer_claim_adj_ind <> @prev_L2330B_3_ref02_T4_other_payer_claim_adj_ind OR
			@L2300_ref02_F8_original_ref_num <> @prev_L2300_ref02_F8_original_ref_num
		)
	begin
		-- Reset the previous LX value to NULL because we're definitely going to start a new procedure line.
		set @prev_L2400_lx01_assigned_num = null

		exec up_x12_clm_export	@x12_interchange_uid = @x12_interchange_uid,
					@clm01_pt_acct_num = @L2300_clm01_pt_acct_num,
					@clm02_total_claim_chg_amt = @L2300_clm02_total_claim_chg_amt,
					@clm05_facility_type_code = @L2300_clm05_facility_type_code,
					@clm05_claim_freq_code = @L2300_clm05_claim_freq_code,
					@clm06_provider_signature_ind = @L2300_clm06_provider_signature_ind,
					@clm07_medicare_assign_code = @L2300_clm07_medicare_assign_code,
					@clm08_benefit_assign_ind = @L2300_clm08_benefit_assign_ind,
					@clm09_release_of_info_code = @L2300_clm09_release_of_info_code,
					@clm12_special_prog_ind = @L2300_clm12_special_prog_ind,
					@clm19_claim_submission_reason_code = @L2300_clm19_claim_submission_reason_code,
					@clm20_delay_reason_code = @L2300_clm20_delay_reason_code

	-- Begin DTP 2300 Loops
		if 	(@L2300_dtp03_435_related_hospitalization_admission_date  IS NOT NULL)
		begin
			exec up_x12_dtp_export	@x12_interchange_uid = @x12_interchange_uid,
						@dtp01_date_time_qual = '435',
						@dtp02_date_time_format_qual = 'D8',
						@dtp03_begin_date = @L2300_dtp03_435_related_hospitalization_admission_date
	
			 
		end
		if 	(@L2300_dtp03_096_discharge_end_of_care_date  IS NOT NULL)
		begin
			exec up_x12_dtp_export	@x12_interchange_uid = @x12_interchange_uid,
						@dtp01_date_time_qual = '096',
						@dtp02_date_time_format_qual = 'D8',
						@dtp03_begin_date = @L2300_dtp03_096_discharge_end_of_care_date
	
			 
		end
		if 	(@L2300_dtp03_330_referral_date  IS NOT NULL)
		begin
			exec up_x12_dtp_export	@x12_interchange_uid = @x12_interchange_uid,
						@dtp01_date_time_qual = '330',
						@dtp02_date_time_format_qual = 'D8',
						@dtp03_begin_date = @L2300_dtp03_330_referral_date
	
			 
		end
		if 	(@L2300_dtp03_439_accident_date  IS NOT NULL)
		begin
			exec up_x12_dtp_export	@x12_interchange_uid = @x12_interchange_uid,
						@dtp01_date_time_qual = '439',
						@dtp02_date_time_format_qual = 'D8',
						@dtp03_begin_date = @L2300_dtp03_439_accident_date
	
			 
		end
		if 	(@L2300_dtp03_452_orthodontic_banding_date  IS NOT NULL)
		begin
			exec up_x12_dtp_export	@x12_interchange_uid = @x12_interchange_uid,
						@dtp01_date_time_qual = '452',
						@dtp02_date_time_format_qual = 'D8',
						@dtp03_begin_date = @L2300_dtp03_452_orthodontic_banding_date
	
			 
		end
		if 	(@L2300_dtp03_472_service_date  IS NOT NULL)
		begin
			exec up_x12_dtp_export	@x12_interchange_uid = @x12_interchange_uid,
						@dtp01_date_time_qual = '472',
						@dtp02_date_time_format_qual = 'D8',
						@dtp03_begin_date = @L2300_dtp03_472_service_date
	
			 
		end
	-- End DTP 2300 Loops

	-- Begin DN 2300 Loops
		if (@L2300_dn101_orthodontic_treatment_months_count IS NOT NULL OR
				@L2300_dn102_orthodontic_treatment_months_remaining_count IS NOT NULL OR
				@L2300_dn103_question_response IS NOT NULL)
		begin
			exec up_x12_dn1_export @x12_interchange_uid = @x12_interchange_uid,
						@dn101_orthodontic_treatment_months_count = @L2300_dn101_orthodontic_treatment_months_count,
						@dn102_orthodontic_treatment_months_remaining_count = @L2300_dn102_orthodontic_treatment_months_remaining_count,
						@dn103_question_response = @L2300_dn103_question_response
		end

		while (@Other2300DNLoopCount < 35)
		begin
			set @Other2300DNLoopCount = @Other2300DNLoopCount + 1
			
			set @SQLString = 'select
				@tmp_dn201_tooth_number = @L2300_' + cast(@Other2300DNLoopCount as varchar) + '_dn201_tooth_number,
				@tmp_dn202_tooth_status_code = @L2300_' + cast(@Other2300DNLoopCount as varchar) + '_dn202_tooth_status_code'

			exec sp_executesql	@SQLString, N'@tmp_dn201_tooth_number varchar(30) output,
				@tmp_dn202_tooth_status_code varchar(2) output,
				@L2300_1_dn201_tooth_number varchar(30),
				@L2300_1_dn202_tooth_status_code varchar(2),
				@L2300_2_dn201_tooth_number varchar(30),
				@L2300_2_dn202_tooth_status_code varchar(2),
				@L2300_3_dn201_tooth_number varchar(30),
				@L2300_3_dn202_tooth_status_code varchar(2),
				@L2300_4_dn201_tooth_number varchar(30),
				@L2300_4_dn202_tooth_status_code varchar(2),
				@L2300_5_dn201_tooth_number varchar(30),
				@L2300_5_dn202_tooth_status_code varchar(2),
				@L2300_6_dn201_tooth_number varchar(30),
				@L2300_6_dn202_tooth_status_code varchar(2),
				@L2300_7_dn201_tooth_number varchar(30),
				@L2300_7_dn202_tooth_status_code varchar(2),
				@L2300_8_dn201_tooth_number varchar(30),
				@L2300_8_dn202_tooth_status_code varchar(2),
				@L2300_9_dn201_tooth_number varchar(30),
				@L2300_9_dn202_tooth_status_code varchar(2),
				@L2300_10_dn201_tooth_number varchar(30),
				@L2300_10_dn202_tooth_status_code varchar(2),
				@L2300_11_dn201_tooth_number varchar(30),
				@L2300_11_dn202_tooth_status_code varchar(2),
				@L2300_12_dn201_tooth_number varchar(30),
				@L2300_12_dn202_tooth_status_code varchar(2),
				@L2300_13_dn201_tooth_number varchar(30),
				@L2300_13_dn202_tooth_status_code varchar(2),
				@L2300_14_dn201_tooth_number varchar(30),
				@L2300_14_dn202_tooth_status_code varchar(2),
				@L2300_15_dn201_tooth_number varchar(30),
				@L2300_15_dn202_tooth_status_code varchar(2),
				@L2300_16_dn201_tooth_number varchar(30),
				@L2300_16_dn202_tooth_status_code varchar(2),
				@L2300_17_dn201_tooth_number varchar(30),
				@L2300_17_dn202_tooth_status_code varchar(2),
				@L2300_18_dn201_tooth_number varchar(30),
				@L2300_18_dn202_tooth_status_code varchar(2),
				@L2300_19_dn201_tooth_number varchar(30),
				@L2300_19_dn202_tooth_status_code varchar(2),
				@L2300_20_dn201_tooth_number varchar(30),
				@L2300_20_dn202_tooth_status_code varchar(2),
				@L2300_21_dn201_tooth_number varchar(30),
				@L2300_21_dn202_tooth_status_code varchar(2),
				@L2300_22_dn201_tooth_number varchar(30),
				@L2300_22_dn202_tooth_status_code varchar(2),
				@L2300_23_dn201_tooth_number varchar(30),
				@L2300_23_dn202_tooth_status_code varchar(2),
				@L2300_24_dn201_tooth_number varchar(30),
				@L2300_24_dn202_tooth_status_code varchar(2),
				@L2300_25_dn201_tooth_number varchar(30),
				@L2300_25_dn202_tooth_status_code varchar(2),
				@L2300_26_dn201_tooth_number varchar(30),
				@L2300_26_dn202_tooth_status_code varchar(2),
				@L2300_27_dn201_tooth_number varchar(30),
				@L2300_27_dn202_tooth_status_code varchar(2),
				@L2300_28_dn201_tooth_number varchar(30),
				@L2300_28_dn202_tooth_status_code varchar(2),
				@L2300_29_dn201_tooth_number varchar(30),
				@L2300_29_dn202_tooth_status_code varchar(2),
				@L2300_30_dn201_tooth_number varchar(30),
				@L2300_30_dn202_tooth_status_code varchar(2),
				@L2300_31_dn201_tooth_number varchar(30),
				@L2300_31_dn202_tooth_status_code varchar(2),
				@L2300_32_dn201_tooth_number varchar(30),
				@L2300_32_dn202_tooth_status_code varchar(2),
				@L2300_33_dn201_tooth_number varchar(30),
				@L2300_33_dn202_tooth_status_code varchar(2),
				@L2300_34_dn201_tooth_number varchar(30),
				@L2300_34_dn202_tooth_status_code varchar(2),
				@L2300_35_dn201_tooth_number varchar(30),
				@L2300_35_dn202_tooth_status_code varchar(2)',
				@tmp_dn201_tooth_number output,
				@tmp_dn202_tooth_status_code output,
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
				@L2300_35_dn202_tooth_status_code

			if (@tmp_dn201_tooth_number IS NOT NULL)
			begin
				exec up_x12_dn2_export @x12_interchange_uid = @x12_interchange_uid,
							@dn201_tooth_number = @tmp_dn201_tooth_number,
							@dn202_tooth_status_code = @tmp_dn202_tooth_status_code
			end
			else break
		end
	-- End DN 2300 Loops

		-- Loop 2300-PWK Segment
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
		if ( @L2300_amt02_card_maximum_amt IS NOT NULL )
		begin
			exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
						@amt01_amount_qual_code = 'MA',
						@amt02_amount = @L2300_amt02_card_maximum_amt

		end
	
	-- BEGIN: 2300 REF SEGMENTS
	-- 2300 Loop REF G3
		if 	(@L2300_ref02_G3_predetermination_id  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'G3',
						@ref02_reference_number = @L2300_ref02_G3_predetermination_id
		end
	-- 2300 Loop REF 4N
		if 	(@L2300_ref02_4N_service_auth_exception_code  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = '4N',
						@ref02_reference_number = @L2300_ref02_4N_service_auth_exception_code
		end
	-- 2300 Loop REF F8 Segment
		if 	(@L2300_ref02_F8_original_ref_num  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'F8',
						@ref02_reference_number = @L2300_ref02_F8_original_ref_num
		end
	-- 2300 Loop REF 9F Segment
		if 	(@L2300_ref02_9F_referral_num  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = '9F',
						@ref02_reference_number = @L2300_ref02_9F_referral_num
		end
	-- 2300 Loop REF G1 Segment
		if 	(@L2300_ref02_G1_prior_auth_num  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'G1',
						@ref02_reference_number = @L2300_ref02_G1_prior_auth_num
		end
	-- 2300 Loop REF D9 segment
		if 	(@L2300_ref02_D9_value_added_network_trace_num IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'D9',
						@ref02_reference_number = @L2300_ref02_D9_value_added_network_trace_num
		end
	--End of 2300 REF LOOP
	
	
	--Claim Note
		if (	@L2300_nte01_note_ref_code IS NOT NULL OR
			@L2300_nte02_claim_note_text  IS NOT NULL)
		begin
			exec up_x12_nte_export	@x12_interchange_uid = @x12_interchange_uid,
						@note_reference_code = @L2300_nte01_note_ref_code,
						@note_text = @L2300_nte02_claim_note_text
		end


	--Start 2310A Loop
		if (	@L2310A_nm103_referring_prov_last_nm IS NOT NULL OR
			@L2310A_nm108_id_code_qual IS NOT NULL OR
			@L2310A_nm109_referring_prov_id IS NOT NULL )
		begin
			if (@L2310A_nm101_entity_id_code IS NULL)
			begin
				set @L2310A_nm101_entity_id_code = 'DN'
			end

			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = @L2310A_nm101_entity_id_code,
						@nm102_entity_type_qual = @L2310A_nm102_entity_type_qual,
						@nm103_last_name = @L2310A_nm103_referring_prov_last_nm,
						@nm104_first_name = @L2310A_nm104_referring_prov_first_nm,
						@nm105_middle_name = @L2310A_nm105_referring_prov_middle_nm,
						@nm107_name_suffix = @L2310A_nm107_referring_prov_suffix,
						@nm108_id_code_qual = @L2310A_nm108_id_code_qual,
						@nm109_id_code = @L2310A_nm109_referring_prov_id

			 

			if 	(@L2310A_prv01_provider_code IS NOT NULL)
			begin
				exec up_x12_prv_export	@x12_interchange_uid = @x12_interchange_uid,
							@prv01_provider_code = @L2310A_prv01_provider_code,
							@prv02_provider_id_qual = @L2310A_prv02_ref_id_qual,
							@prv03_provider_id = @L2310A_prv03_taxonomy_code

				 
			end

		-- BEGIN: 2310A REF SEGMENTS
			-- 2310A Loop REF 1C segment
			if 	(@L2310A_ref02_1C_referring_prov_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1C',
							@ref02_reference_number = @L2310A_ref02_1C_referring_prov_id
			end
			-- 2310A Loop REF 1D Segment
			if 	(@L2310A_ref02_1D_referring_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1D',
							@ref02_reference_number = @L2310A_ref02_1D_referring_prov_id
			end
			-- 2310A Loop REF 1E Segment
			if 	(@L2310A_ref02_1E_referring_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1E',
							@ref02_reference_number = @L2310A_ref02_1E_referring_prov_id
			end
			-- 2310A Loop REF EI
			if 	(@L2310A_ref02_EI_referring_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'EI',
							@ref02_reference_number = @L2310A_ref02_EI_referring_prov_id
			end
			-- 2310A Loop REF G2
			if 	(@L2310A_ref02_G2_referring_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'G2',
							@ref02_reference_number = @L2310A_ref02_G2_referring_prov_id
			end
			-- 2310A Loop REF SY
			if 	(@L2310A_ref02_SY_referring_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'SY',
							@ref02_reference_number = @L2310A_ref02_SY_referring_prov_id
			end
			-- 2310A Loop REF TJ
			if 	(@L2310A_ref02_TJ_referring_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'TJ',
							@ref02_reference_number = @L2310A_ref02_TJ_referring_prov_id
			end
		--End of 2310A REF SEGMENTS
		end
	-- END of 2310A Loop
	
	-- BEGIN OF 2310B LOOP
		if (	@L2310B_nm103_rendering_prov_last_nm IS NOT NULL OR
			@L2310B_nm108_id_code_qual IS NOT NULL OR
			@L2310B_nm109_rendering_prov_id IS NOT NULL )
		begin
			-- If the 2310B loop is used, then the NM1 segment is always required.
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = '82',
						@nm102_entity_type_qual = @L2310B_nm102_entity_type_qual,
						@nm103_last_name = @L2310B_nm103_rendering_prov_last_nm,
						@nm104_first_name = @L2310B_nm104_rendering_prov_first_nm,
						@nm105_middle_name = @L2310B_nm105_rendering_prov_middle_nm,
						@nm107_name_suffix = @L2310B_nm107_rendering_prov_suffix,
						@nm108_id_code_qual = @L2310B_nm108_id_code_qual,
						@nm109_id_code = @L2310B_nm109_rendering_prov_id

			-- If there's a taxonomy code, use it.
			if 	(@L2310B_prv03_taxonomy_code IS NOT NULL)
			begin
				exec up_x12_prv_export	@x12_interchange_uid = @x12_interchange_uid,
							@prv01_provider_code = 'PE',
							@prv02_provider_id_qual = 'ZZ',
							@prv03_provider_id = @L2310B_prv03_taxonomy_code

			end

		-- BEGIN: 2310B REF SEGMENTS
			-- 2310B Loop REF 1C segment
			if 	(@L2310B_ref02_1C_rendering_prov_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1C',
							@ref02_reference_number = @L2310B_ref02_1C_rendering_prov_id
			end
			-- 2310B Loop REF 1D Segment
			if 	(@L2310B_ref02_1D_rendering_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1D',
							@ref02_reference_number = @L2310B_ref02_1D_rendering_prov_id
			end
			-- 2310B Loop REF 1E Segment
			if 	(@L2310B_ref02_1E_rendering_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1E',
							@ref02_reference_number = @L2310B_ref02_1E_rendering_prov_id
			end
			-- 2310B Loop REF EI
			if 	(@L2310B_ref02_EI_rendering_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'EI',
							@ref02_reference_number = @L2310B_ref02_EI_rendering_prov_id
			end
			-- 2310B Loop REF G2
			if 	(@L2310B_ref02_G2_rendering_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'G2',
							@ref02_reference_number = @L2310B_ref02_G2_rendering_prov_id
			end
			-- 2310B Loop REF SY
			if 	(@L2310B_ref02_SY_rendering_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'SY',
							@ref02_reference_number = @L2310B_ref02_SY_rendering_prov_id
			end
			-- 2310B Loop REF TJ
			if 	(@L2310B_ref02_TJ_rendering_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'TJ',
							@ref02_reference_number = @L2310B_ref02_TJ_rendering_prov_id
			end
		-- END: 2310B REF SEGMENTS
		End
	-- END OF 2310B LOOP
	
	-- BEGIN OF 2310C LOOP
		if (	@L2310C_nm103_service_facility_last_nm IS NOT NULL OR
			@L2310C_nm102_entity_type_qual IS NOT NULL OR
			@L2310C_nm109_service_facility_id IS NOT NULL )
		begin
			-- If the 2310C loop is used, then the NM1 segment is always required.
			PRINT '2310C LOOP entered'			
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = 'FA',
						@nm102_entity_type_qual = @L2310C_nm102_entity_type_qual,
						@nm103_last_name = @L2310C_nm103_service_facility_last_nm,
						@nm108_id_code_qual = @L2310C_nm108_id_code_qual,
						@nm109_id_code = @L2310C_nm109_service_facility_id

		-- BEGIN: 2310C REF SEGMENTS
			-- 2310C Loop REF 1C segment
			if 	(@L2310C_ref02_1C_lab_or_facility_prov_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1C',
							@ref02_reference_number = @L2310C_ref02_1C_lab_or_facility_prov_id
			end
			-- 2310B Loop REF 1D Segment
			if 	(@L2310C_ref02_1D_lab_or_facility_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1D',
							@ref02_reference_number = @L2310C_ref02_1D_lab_or_facility_prov_id
			end
			-- 2310B Loop REF 1G Segment
			if 	(@L2310C_ref02_1G_lab_or_facility_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1G',
							@ref02_reference_number = @L2310C_ref02_1G_lab_or_facility_prov_id
			end
--			-- 2310B Loop REF EI
--			if 	(@L2310B_ref02_EI_rendering_prov_id  IS NOT NULL)
--			begin
--				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
--							@ref01_id_qual = 'EI',
--							@ref02_reference_number = @L2310B_ref02_EI_rendering_prov_id
--			end
			-- 2310B Loop REF G2
			if 	(@L2310C_ref02_G2_lab_or_facility_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'G2',
							@ref02_reference_number = @L2310C_ref02_G2_lab_or_facility_prov_id
			end
----			-- 2310B Loop REF SY
----			if 	(@L2310C_ref02_SY_lab_or_facility_prov_id  IS NOT NULL)
----			begin
----				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
----							@ref01_id_qual = 'SY',
----							@ref02_reference_number = @L2310B_ref02_SY_rendering_prov_id
----			end
			-- 2310B Loop REF TJ
			if 	(@L2310C_ref02_TJ_lab_or_facility_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'TJ',
							@ref02_reference_number = @L2310C_ref02_TJ_lab_or_facility_prov_id
			end
		-- END: 2310C REF SEGMENTS
		End
	-- END OF 2310C LOOP

	-- BEGIN OF 2310D LOOP
		if (	@L2310D_nm103_assistant_surgeon_last_nm IS NOT NULL OR
			@L2310D_nm108_id_code_qual IS NOT NULL OR
			@L2310D_nm109_assistant_surgeon_prov_id IS NOT NULL )
		begin
			-- If the 2310D loop is used, then the NM1 segment is always required.
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = 'DD',
						@nm102_entity_type_qual = @L2310D_nm102_entity_type_qual,
						@nm103_last_name = @L2310D_nm103_assistant_surgeon_last_nm,
						@nm104_first_name = @L2310D_nm104_assistant_surgeon_first_nm,
						@nm105_middle_name = @L2310D_nm105_assistant_surgeon_middle_nm,
						@nm107_name_suffix = @L2310D_nm107_assistant_surgeon_suffix,
						@nm108_id_code_qual = @L2310D_nm108_id_code_qual,
						@nm109_id_code = @L2310D_nm109_assistant_surgeon_prov_id

			if 	(@L2310D_prv01_provider_code IS NOT NULL)
			begin
				exec up_x12_prv_export	@x12_interchange_uid = @x12_interchange_uid,
							@prv01_provider_code = @L2310D_prv01_provider_code,
							@prv02_provider_id_qual = @L2310D_prv02_id_code_qual,
							@prv03_provider_id = @L2310D_prv03_taxonomy_code

			end
			
		-- BEGIN: 2310D REF SEGMENTS
			-- 2310D Loop REF 1C segment
			if 	(@L2310D_ref02_1C_service_facility_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1C',
							@ref02_reference_number = @L2310D_ref02_1C_service_facility_id
			end
			-- 2310B Loop REF 1D Segment
			if 	(@L2310D_ref02_1D_service_facility_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1D',
							@ref02_reference_number = @L2310B_ref02_1D_rendering_prov_id
			end
			-- 2310B Loop REF 1E Segment
			if 	(@L2310D_ref02_1E_service_facility_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1E',
							@ref02_reference_number = @L2310D_ref02_1E_service_facility_id
			end
			-- 2310B Loop REF G2
			if 	(@L2310D_ref02_G2_service_facility_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'G2',
							@ref02_reference_number = @L2310D_ref02_G2_service_facility_id
			end
			-- 2310B Loop REF TJ
			if 	(@L2310D_ref02_TJ_service_facility_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'TJ',
							@ref02_reference_number = @L2310D_ref02_TJ_service_facility_id
			end
		-- END: 2310D REF SEGMENTS
		End
	-- END OF 2310D LOOP


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
			if (@L2320_1_1_cas01_adjustment_group_code IS NOT NULL)
			begin
				exec up_x12_cas_export	@x12_interchange_uid = @x12_interchange_uid,
							@cas01_adjustment_group_code = @L2320_1_1_cas01_adjustment_group_code,
							@cas02_adjustment_reason_code = @L2320_1_1_cas02_adjustment_reason_code,
							@cas03_adjustment_amt = @L2320_1_1_cas03_adjustment_amt,
							@cas04_adjustment_qty = @L2320_1_1_cas04_adjustment_qty,
							@cas05_adjustment_reason_code = @L2320_1_1_cas05_adjustment_reason_code,
							@cas06_adjustment_amt = @L2320_1_1_cas06_adjustment_amt,
							@cas07_adjustment_qty = @L2320_1_1_cas07_adjustment_qty,
							@cas08_adjustment_reason_code = @L2320_1_1_cas08_adjustment_reason_code,
							@cas09_adjustment_amt = @L2320_1_1_cas09_adjustment_amt,
							@cas10_adjustment_qty = @L2320_1_1_cas10_adjustment_qty
		
				 
			end
	
		-- BEGIN 2320 AMT SEGMENTS
			if ( @L2320_1_amt02_D_payer_paid_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'D',
							@amt02_amount = @L2320_1_amt02_D_payer_paid_amt
			end

			if ( @L2320_1_amt02_AAE_cob_approved_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'AAE',
							@amt02_amount = @L2320_1_amt02_AAE_cob_approved_amt
			end
			if ( @L2320_1_amt02_B6_cob_allowed_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'B6',
							@amt02_amount = @L2320_1_amt02_B6_cob_allowed_amt
			end
			if ( @L2320_1_amt02_F2_patient_responsibility_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'F2',
							@amt02_amount = @L2320_1_amt02_F2_patient_responsibility_amt
			end
			if ( @L2320_1_amt02_AU_cob_covered_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'AU',
							@amt02_amount = @L2320_1_amt02_AU_cob_covered_amt
			end
			if ( @L2320_1_amt02_D8_discount_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'D8',
							@amt02_amount = @L2320_1_amt02_D8_discount_amt
			end
			if ( @L2320_1_amt02_F5_payer_patient_paid_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'F5',
							@amt02_amount = @L2320_1_amt02_F5_payer_patient_paid_amt
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

			-- 2330A Loop N3 segment
			exec up_x12_n3_export	@x12_interchange_uid = @x12_interchange_uid,
						@n301_address1 = @L2330A_1_n301_other_subscriber_address1,
						@n302_address2 = @L2330A_1_n302_other_subscriber_address2

			-- 2330A Loop N4 segment
			exec up_x12_n4_export	@x12_interchange_uid = @x12_interchange_uid,
						@n401_city = @L2330A_1_n401_other_subscriber_city,
						@n402_state = @L2330A_1_n402_other_subscriber_state,
						@n403_zip = @L2330A_1_n403_other_subscriber_zip,
						@n404_country = @L2330A_1_n404_other_subscriber_country

			-- 2330A Loop REF 1W segment
			if 	(@L2330A_1_ref02_1W_other_subscriber_sup_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1W',
							@ref02_reference_number = @L2330A_1_ref02_1W_other_subscriber_sup_id
			end

			-- 2330A Loop REF 23 segment
			if 	(@L2330A_1_ref02_23_other_subscriber_sup_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '23',
							@ref02_reference_number = @L2330A_1_ref02_23_other_subscriber_sup_id
			end

			-- 2330A Loop REF IG segment
			if 	(@L2330A_1_ref02_IG_other_subscriber_sup_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'IG',
							@ref02_reference_number = @L2330A_1_ref02_IG_other_subscriber_sup_id
			end

			-- 2330A Loop REF SY segment
			if 	(@L2330A_1_ref02_SY_other_subscriber_sup_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'SY',
							@ref02_reference_number = @L2330A_1_ref02_SY_other_subscriber_sup_id
			end

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
			-- 2330B Loop REF T4
			if 	(@L2330B_1_ref02_T4_other_payer_claim_adj_ind IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'T4',
							@ref02_reference_number = @L2330B_1_ref02_T4_other_payer_claim_adj_ind
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
			if (@L2320_2_1_cas01_adjustment_group_code IS NOT NULL)
			begin
				exec up_x12_cas_export	@x12_interchange_uid = @x12_interchange_uid,
							@L2320_2_cas01_adjustment_group_code = @L2320_2_1_cas01_adjustment_group_code,
							@L2320_2_cas02_adjustment_reason_code = @L2320_2_1_cas02_adjustment_reason_code,
							@L2320_2_cas03_adjustment_amt = @L2320_2_1_cas03_adjustment_amt,
							@L2320_2_cas04_adjustment_qty = @L2320_2_1_cas04_adjustment_qty,
							@L2320_2_cas05_adjustment_reason_code = @L2320_2_1_cas05_adjustment_reason_code,
							@L2320_2_cas06_adjustment_amt = @L2320_2_1_cas06_adjustment_amt,
							@L2320_2_cas07_adjustment_qty = @L2320_2_1_cas07_adjustment_qty,
							@L2320_2_cas08_adjustment_reason_code = @L2320_2_1_cas08_adjustment_reason_code,
							@L2320_2_cas09_adjustment_amt = @L2320_2_1_cas09_adjustment_amt,
							@L2320_2_cas10_adjustment_qty = @L2320_2_1_cas10_adjustment_qty
			end
	
		-- BEGIN 2320 AMT SEGMENTS
			if ( @L2320_2_amt02_D_payer_paid_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'D',
							@amt02_amount = @L2320_2_amt02_D_payer_paid_amt
			end

			if ( @L2320_2_amt02_AAE_cob_approved_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'AAE',
							@amt02_amount = @L2320_2_amt02_AAE_cob_approved_amt
			end
			if ( @L2320_2_amt02_B6_cob_allowed_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'B6',
							@amt02_amount = @L2320_2_amt02_B6_cob_allowed_amt
			end
			if ( @L2320_2_amt02_F2_patient_responsibility_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'F2',
							@amt02_amount = @L2320_2_amt02_F2_patient_responsibility_amt
			end
			if ( @L2320_2_amt02_AU_cob_covered_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'AU',
							@amt02_amount = @L2320_2_amt02_AU_cob_covered_amt
			end
			if ( @L2320_2_amt02_D8_discount_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'D8',
							@amt02_amount = @L2320_2_amt02_D8_discount_amt
			end
			if ( @L2320_2_amt02_F5_payer_patient_paid_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'F5',
							@amt02_amount = @L2320_2_amt02_F5_payer_patient_paid_amt
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

			 -- 2330A Loop N3 segment
			exec up_x12_n3_export	@x12_interchange_uid = @x12_interchange_uid,
						@n301_address1 = @L2330A_2_n301_other_subscriber_address1,
						@n302_address2 = @L2330A_2_n302_other_subscriber_address2

			-- 2330A Loop N4 segment
			exec up_x12_n4_export	@x12_interchange_uid = @x12_interchange_uid,
						@n401_city = @L2330A_2_n401_other_subscriber_city,
						@n402_state = @L2330A_2_n402_other_subscriber_state,
						@n403_zip = @L2330A_2_n403_other_subscriber_zip,
						@n404_country = @L2330A_2_n404_other_subscriber_country

			-- 2330A Loop REF 1W segment
			if 	(@L2330A_2_ref02_1W_other_subscriber_sup_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1W',
							@ref02_reference_number = @L2330A_2_ref02_1W_other_subscriber_sup_id
			end

			-- 2330A Loop REF 23 segment
			if 	(@L2330A_2_ref02_23_other_subscriber_sup_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '23',
							@ref02_reference_number = @L2330A_2_ref02_23_other_subscriber_sup_id
			end

			-- 2330A Loop REF IG segment
			if 	(@L2330A_2_ref02_IG_other_subscriber_sup_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'IG',
							@ref02_reference_number = @L2330A_2_ref02_IG_other_subscriber_sup_id
			end

			-- 2330A Loop REF SY segment
			if 	(@L2330A_2_ref02_SY_other_subscriber_sup_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'SY',
							@ref02_reference_number = @L2330A_2_ref02_SY_other_subscriber_sup_id
			end

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
			-- 2330B Loop REF T4
			if 	(@L2330B_2_ref02_T4_other_payer_claim_adj_ind IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'T4',
							@ref02_reference_number = @L2330B_2_ref02_T4_other_payer_claim_adj_ind
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
			if (@L2320_3_1_cas01_adjustment_group_code IS NOT NULL)
			begin
				exec up_x12_cas_export	@x12_interchange_uid = @x12_interchange_uid,
							@L2320_3_cas01_adjustment_group_code = @L2320_3_1_cas01_adjustment_group_code,
							@L2320_3_cas02_adjustment_reason_code = @L2320_3_1_cas02_adjustment_reason_code,
							@L2320_3_cas03_adjustment_amt = @L2320_3_1_cas03_adjustment_amt,
							@L2320_3_cas04_adjustment_qty = @L2320_3_1_cas04_adjustment_qty,
							@L2320_3_cas05_adjustment_reason_code = @L2320_3_1_cas05_adjustment_reason_code,
							@L2320_3_cas06_adjustment_amt = @L2320_3_1_cas06_adjustment_amt,
							@L2320_3_cas07_adjustment_qty = @L2320_3_1_cas07_adjustment_qty,
							@L2320_3_cas08_adjustment_reason_code = @L2320_3_1_cas08_adjustment_reason_code,
							@L2320_3_cas09_adjustment_amt = @L2320_3_1_cas09_adjustment_amt,
							@L2320_3_cas10_adjustment_qty = @L2320_3_1_cas10_adjustment_qty
		
				 
			end
	
		-- BEGIN 2320 AMT SEGMENTS
			if ( @L2320_3_amt02_D_payer_paid_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'D',
							@amt02_amount = @L2320_3_amt02_D_payer_paid_amt
			end
			if ( @L2320_3_amt02_AAE_cob_approved_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'AAE',
							@amt02_amount = @L2320_3_amt02_AAE_cob_approved_amt
			end
			if ( @L2320_3_amt02_B6_cob_allowed_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'B6',
							@amt02_amount = @L2320_3_amt02_B6_cob_allowed_amt
			end
			if ( @L2320_3_amt02_F2_patient_responsibility_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'F2',
							@amt02_amount = @L2320_3_amt02_F2_patient_responsibility_amt
			end
			if ( @L2320_3_amt02_AU_cob_covered_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'AU',
							@amt02_amount = @L2320_3_amt02_AU_cob_covered_amt
			end
			if ( @L2320_3_amt02_D8_discount_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'D8',
							@amt02_amount = @L2320_3_amt02_D8_discount_amt
			end
			if ( @L2320_3_amt02_F5_payer_patient_paid_amt IS NOT NULL )
			begin
				exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
							@amt01_amount_qual_code = 'F5',
							@amt02_amount = @L2320_3_amt02_F5_payer_patient_paid_amt
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

			 -- 2330A Loop N3 segment
			exec up_x12_n3_export	@x12_interchange_uid = @x12_interchange_uid,
						@n301_address1 = @L2330A_3_n301_other_subscriber_address1,
						@n302_address2 = @L2330A_3_n302_other_subscriber_address2

			-- 2330A Loop N4 segment
			exec up_x12_n4_export	@x12_interchange_uid = @x12_interchange_uid,
						@n401_city = @L2330A_3_n401_other_subscriber_city,
						@n402_state = @L2330A_3_n402_other_subscriber_state,
						@n403_zip = @L2330A_3_n403_other_subscriber_zip,
						@n404_country = @L2330A_3_n404_other_subscriber_country

			-- 2330A Loop REF 1W segment
			if 	(@L2330A_3_ref02_1W_other_subscriber_sup_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1W',
							@ref02_reference_number = @L2330A_3_ref02_1W_other_subscriber_sup_id
			end

			-- 2330A Loop REF 23 segment
			if 	(@L2330A_3_ref02_23_other_subscriber_sup_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '23',
							@ref02_reference_number = @L2330A_3_ref02_23_other_subscriber_sup_id
			end

			-- 2330A Loop REF IG segment
			if 	(@L2330A_3_ref02_IG_other_subscriber_sup_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'IG',
							@ref02_reference_number = @L2330A_3_ref02_IG_other_subscriber_sup_id
			end

			-- 2330A Loop REF SY segment
			if 	(@L2330A_3_ref02_SY_other_subscriber_sup_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'SY',
							@ref02_reference_number = @L2330A_3_ref02_SY_other_subscriber_sup_id
			end

			set @L2330B_3_nm103_other_payer_nm = IsNull(@L2330B_3_nm103_other_payer_nm, 'UNSPECIFIED')
			set @L2330B_3_nm109_other_payer_id = IsNull(@L2330B_3_nm109_other_payer_id, '999999999')
			-- If the 2320 Loop is used, then the 2330A Loop and 2330A-NM1 segment is required
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = 'PR',
						@nm102_entity_type_qual = @L2330B_3_nm102_entity_type_qual,
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
			-- 2330B Loop REF T4
			if 	(@L2330B_3_ref02_T4_other_payer_claim_adj_ind IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'T4',
							@ref02_reference_number = @L2330B_3_ref02_T4_other_payer_claim_adj_ind
			end
			--End of 2330B LOOP
		end
		-- END OF THIRD 2320 LOOP GROUPING
	end
-- END OF 2300 LOOP GROUPING

--begin 2400 loop
	/*	If the current L2400_lx01_assigned_num value is different than the previous,
		we're starting a new procedure line.  Although it is assumed that each record
		in the 837d table is a procedure line, we use the LX segment as our assurance.

		If @L2400_lx01_assigned_num is null, put in a 1 (but really a valid procedure line should never
		have a NULL value in the LX segment).
	*/
	if ( @L2400_lx01_assigned_num <> IsNull(@prev_L2400_lx01_assigned_num, '') )
	begin
		set @L2400_lx01_assigned_num = IsNull(@L2400_lx01_assigned_num, '1')
		set @Other2400TOOLoopCount = 0
		exec up_x12_lx_export	@x12_interchange_uid = @x12_interchange_uid,
					@lx01_assigned_num = @L2400_lx01_assigned_num

		
		-- Export the 2400-SV3 segment
		exec up_x12_sv3_export	@x12_interchange_uid = @x12_interchange_uid,
					@sv301_proc_code_qual = @L2400_sv301_proc_code_qual,
					@sv301_proc_code = @L2400_sv301_proc_code,
					@sv301_proc_mod1 = @L2400_sv301_proc_mod1,
					@sv301_proc_mod2 = @L2400_sv301_proc_mod2,
					@sv301_proc_mod3 = @L2400_sv301_proc_mod3,
					@sv301_proc_mod4 = @L2400_sv301_proc_mod4,
					@sv302_line_charge = @L2400_sv302_line_charge,
					@sv303_facility_type_code = @L2400_sv303_facility_type_code,
					@sv304_oral_cavity_designation_code_1 = @L2400_sv304_oral_cavity_designation_code_1,
					@sv304_oral_cavity_designation_code_2 = @L2400_sv304_oral_cavity_designation_code_2,
					@sv304_oral_cavity_designation_code_3 = @L2400_sv304_oral_cavity_designation_code_3,
					@sv304_oral_cavity_designation_code_4 = @L2400_sv304_oral_cavity_designation_code_4,
					@sv304_oral_cavity_designation_code_5 = @L2400_sv304_oral_cavity_designation_code_5,
					@sv305_prosthesis_crown_inlay_code = @L2400_sv305_prosthesis_crown_inlay_code,
					@sv306_procedure_count = @L2400_sv306_procedure_count


		-- Export the 2400-TOO segment
		while (@Other2400TOOLoopCount < 32)
		begin
			set @Other2400TOOLoopCount = @Other2400TOOLoopCount + 1

			set @SQLString = 'select
				@tmp_JP_tooth_code = @L2400_' + cast(@Other2400TOOLoopCount AS varchar) + '_too02_JP_tooth_code,
				@tmp_tooth_surface_code_1 = @L2400_' + cast(@Other2400TOOLoopCount as varchar) + '_too03_tooth_surface_code_1,
				@tmp_tooth_surface_code_2 = @L2400_' + cast(@Other2400TOOLoopCount as varchar) + '_too03_tooth_surface_code_2,
				@tmp_tooth_surface_code_3 = @L2400_' + cast(@Other2400TOOLoopCount as varchar) + '_too03_tooth_surface_code_3,
				@tmp_tooth_surface_code_4 = @L2400_' + cast(@Other2400TOOLoopCount as varchar) + '_too03_tooth_surface_code_4,
				@tmp_tooth_surface_code_5 = @L2400_' + cast(@Other2400TOOLoopCount as varchar) + '_too03_tooth_surface_code_5'

			exec sp_executesql	@SQLString, N'@tmp_JP_tooth_code varchar(30) output,
				@tmp_tooth_surface_code_1 char(2) output,
				@tmp_tooth_surface_code_2 char(2) output,
				@tmp_tooth_surface_code_3 char(2) output,
				@tmp_tooth_surface_code_4 char(2) output,
				@tmp_tooth_surface_code_5 char(2) output,				
				@L2400_1_too02_JP_tooth_code varchar(30),
				@L2400_1_too03_tooth_surface_code_1 char(2),
				@L2400_1_too03_tooth_surface_code_2 char(2),
				@L2400_1_too03_tooth_surface_code_3 char(2),
				@L2400_1_too03_tooth_surface_code_4 char(2),
				@L2400_1_too03_tooth_surface_code_5 char(2),
				@L2400_2_too02_JP_tooth_code varchar(30),
				@L2400_2_too03_tooth_surface_code_1 char(2),
				@L2400_2_too03_tooth_surface_code_2 char(2),
				@L2400_2_too03_tooth_surface_code_3 char(2),
				@L2400_2_too03_tooth_surface_code_4 char(2),
				@L2400_2_too03_tooth_surface_code_5 char(2),
				@L2400_3_too02_JP_tooth_code varchar(30),
				@L2400_3_too03_tooth_surface_code_1 char(2),
				@L2400_3_too03_tooth_surface_code_2 char(2),
				@L2400_3_too03_tooth_surface_code_3 char(2),
				@L2400_3_too03_tooth_surface_code_4 char(2),
				@L2400_3_too03_tooth_surface_code_5 char(2),
				@L2400_4_too02_JP_tooth_code varchar(30),
				@L2400_4_too03_tooth_surface_code_1 char(2),
				@L2400_4_too03_tooth_surface_code_2 char(2),
				@L2400_4_too03_tooth_surface_code_3 char(2),
				@L2400_4_too03_tooth_surface_code_4 char(2),
				@L2400_4_too03_tooth_surface_code_5 char(2),
				@L2400_5_too02_JP_tooth_code varchar(30),
				@L2400_5_too03_tooth_surface_code_1 char(2),
				@L2400_5_too03_tooth_surface_code_2 char(2),
				@L2400_5_too03_tooth_surface_code_3 char(2),
				@L2400_5_too03_tooth_surface_code_4 char(2),
				@L2400_5_too03_tooth_surface_code_5 char(2),
				@L2400_6_too02_JP_tooth_code varchar(30),
				@L2400_6_too03_tooth_surface_code_1 char(2),
				@L2400_6_too03_tooth_surface_code_2 char(2),
				@L2400_6_too03_tooth_surface_code_3 char(2),
				@L2400_6_too03_tooth_surface_code_4 char(2),
				@L2400_6_too03_tooth_surface_code_5 char(2),
				@L2400_7_too02_JP_tooth_code varchar(30),
				@L2400_7_too03_tooth_surface_code_1 char(2),
				@L2400_7_too03_tooth_surface_code_2 char(2),
				@L2400_7_too03_tooth_surface_code_3 char(2),
				@L2400_7_too03_tooth_surface_code_4 char(2),
				@L2400_7_too03_tooth_surface_code_5 char(2),
				@L2400_8_too02_JP_tooth_code varchar(30),
				@L2400_8_too03_tooth_surface_code_1 char(2),
				@L2400_8_too03_tooth_surface_code_2 char(2),
				@L2400_8_too03_tooth_surface_code_3 char(2),
				@L2400_8_too03_tooth_surface_code_4 char(2),
				@L2400_8_too03_tooth_surface_code_5 char(2),
				@L2400_9_too02_JP_tooth_code varchar(30),
				@L2400_9_too03_tooth_surface_code_1 char(2),
				@L2400_9_too03_tooth_surface_code_2 char(2),
				@L2400_9_too03_tooth_surface_code_3 char(2),
				@L2400_9_too03_tooth_surface_code_4 char(2),
				@L2400_9_too03_tooth_surface_code_5 char(2),
				@L2400_10_too02_JP_tooth_code varchar(30),
				@L2400_10_too03_tooth_surface_code_1 char(2),
				@L2400_10_too03_tooth_surface_code_2 char(2),
				@L2400_10_too03_tooth_surface_code_3 char(2),
				@L2400_10_too03_tooth_surface_code_4 char(2),
				@L2400_10_too03_tooth_surface_code_5 char(2),
				@L2400_11_too02_JP_tooth_code varchar(30),
				@L2400_11_too03_tooth_surface_code_1 char(2),
				@L2400_11_too03_tooth_surface_code_2 char(2),
				@L2400_11_too03_tooth_surface_code_3 char(2),
				@L2400_11_too03_tooth_surface_code_4 char(2),
				@L2400_11_too03_tooth_surface_code_5 char(2),
				@L2400_12_too02_JP_tooth_code varchar(30),
				@L2400_12_too03_tooth_surface_code_1 char(2),
				@L2400_12_too03_tooth_surface_code_2 char(2),
				@L2400_12_too03_tooth_surface_code_3 char(2),
				@L2400_12_too03_tooth_surface_code_4 char(2),
				@L2400_12_too03_tooth_surface_code_5 char(2),
				@L2400_13_too02_JP_tooth_code varchar(30),
				@L2400_13_too03_tooth_surface_code_1 char(2),
				@L2400_13_too03_tooth_surface_code_2 char(2),
				@L2400_13_too03_tooth_surface_code_3 char(2),
				@L2400_13_too03_tooth_surface_code_4 char(2),
				@L2400_13_too03_tooth_surface_code_5 char(2),
				@L2400_14_too02_JP_tooth_code varchar(30),
				@L2400_14_too03_tooth_surface_code_1 char(2),
				@L2400_14_too03_tooth_surface_code_2 char(2),
				@L2400_14_too03_tooth_surface_code_3 char(2),
				@L2400_14_too03_tooth_surface_code_4 char(2),
				@L2400_14_too03_tooth_surface_code_5 char(2),
				@L2400_15_too02_JP_tooth_code varchar(30),
				@L2400_15_too03_tooth_surface_code_1 char(2),
				@L2400_15_too03_tooth_surface_code_2 char(2),
				@L2400_15_too03_tooth_surface_code_3 char(2),
				@L2400_15_too03_tooth_surface_code_4 char(2),
				@L2400_15_too03_tooth_surface_code_5 char(2),
				@L2400_16_too02_JP_tooth_code varchar(30),
				@L2400_16_too03_tooth_surface_code_1 char(2),
				@L2400_16_too03_tooth_surface_code_2 char(2),
				@L2400_16_too03_tooth_surface_code_3 char(2),
				@L2400_16_too03_tooth_surface_code_4 char(2),
				@L2400_16_too03_tooth_surface_code_5 char(2),
				@L2400_17_too02_JP_tooth_code varchar(30),
				@L2400_17_too03_tooth_surface_code_1 char(2),
				@L2400_17_too03_tooth_surface_code_2 char(2),
				@L2400_17_too03_tooth_surface_code_3 char(2),
				@L2400_17_too03_tooth_surface_code_4 char(2),
				@L2400_17_too03_tooth_surface_code_5 char(2),
				@L2400_18_too02_JP_tooth_code varchar(30),
				@L2400_18_too03_tooth_surface_code_1 char(2),
				@L2400_18_too03_tooth_surface_code_2 char(2),
				@L2400_18_too03_tooth_surface_code_3 char(2),
				@L2400_18_too03_tooth_surface_code_4 char(2),
				@L2400_18_too03_tooth_surface_code_5 char(2),
				@L2400_19_too02_JP_tooth_code varchar(30),
				@L2400_19_too03_tooth_surface_code_1 char(2),
				@L2400_19_too03_tooth_surface_code_2 char(2),
				@L2400_19_too03_tooth_surface_code_3 char(2),
				@L2400_19_too03_tooth_surface_code_4 char(2),
				@L2400_19_too03_tooth_surface_code_5 char(2),
				@L2400_20_too02_JP_tooth_code varchar(30),
				@L2400_20_too03_tooth_surface_code_1 char(2),
				@L2400_20_too03_tooth_surface_code_2 char(2),
				@L2400_20_too03_tooth_surface_code_3 char(2),
				@L2400_20_too03_tooth_surface_code_4 char(2),
				@L2400_20_too03_tooth_surface_code_5 char(2),
				@L2400_21_too02_JP_tooth_code varchar(30),
				@L2400_21_too03_tooth_surface_code_1 char(2),
				@L2400_21_too03_tooth_surface_code_2 char(2),
				@L2400_21_too03_tooth_surface_code_3 char(2),
				@L2400_21_too03_tooth_surface_code_4 char(2),
				@L2400_21_too03_tooth_surface_code_5 char(2),
				@L2400_22_too02_JP_tooth_code varchar(30),
				@L2400_22_too03_tooth_surface_code_1 char(2),
				@L2400_22_too03_tooth_surface_code_2 char(2),
				@L2400_22_too03_tooth_surface_code_3 char(2),
				@L2400_22_too03_tooth_surface_code_4 char(2),
				@L2400_22_too03_tooth_surface_code_5 char(2),
				@L2400_23_too02_JP_tooth_code varchar(30),
				@L2400_23_too03_tooth_surface_code_1 char(2),
				@L2400_23_too03_tooth_surface_code_2 char(2),
				@L2400_23_too03_tooth_surface_code_3 char(2),
				@L2400_23_too03_tooth_surface_code_4 char(2),
				@L2400_23_too03_tooth_surface_code_5 char(2),
				@L2400_24_too02_JP_tooth_code varchar(30),
				@L2400_24_too03_tooth_surface_code_1 char(2),
				@L2400_24_too03_tooth_surface_code_2 char(2),
				@L2400_24_too03_tooth_surface_code_3 char(2),
				@L2400_24_too03_tooth_surface_code_4 char(2),
				@L2400_24_too03_tooth_surface_code_5 char(2),
				@L2400_25_too02_JP_tooth_code varchar(30),
				@L2400_25_too03_tooth_surface_code_1 char(2),
				@L2400_25_too03_tooth_surface_code_2 char(2),
				@L2400_25_too03_tooth_surface_code_3 char(2),
				@L2400_25_too03_tooth_surface_code_4 char(2),
				@L2400_25_too03_tooth_surface_code_5 char(2),
				@L2400_26_too02_JP_tooth_code varchar(30),
				@L2400_26_too03_tooth_surface_code_1 char(2),
				@L2400_26_too03_tooth_surface_code_2 char(2),
				@L2400_26_too03_tooth_surface_code_3 char(2),
				@L2400_26_too03_tooth_surface_code_4 char(2),
				@L2400_26_too03_tooth_surface_code_5 char(2),
				@L2400_27_too02_JP_tooth_code varchar(30),
				@L2400_27_too03_tooth_surface_code_1 char(2),
				@L2400_27_too03_tooth_surface_code_2 char(2),
				@L2400_27_too03_tooth_surface_code_3 char(2),
				@L2400_27_too03_tooth_surface_code_4 char(2),
				@L2400_27_too03_tooth_surface_code_5 char(2),
				@L2400_28_too02_JP_tooth_code varchar(30),
				@L2400_28_too03_tooth_surface_code_1 char(2),
				@L2400_28_too03_tooth_surface_code_2 char(2),
				@L2400_28_too03_tooth_surface_code_3 char(2),
				@L2400_28_too03_tooth_surface_code_4 char(2),
				@L2400_28_too03_tooth_surface_code_5 char(2),
				@L2400_29_too02_JP_tooth_code varchar(30),
				@L2400_29_too03_tooth_surface_code_1 char(2),
				@L2400_29_too03_tooth_surface_code_2 char(2),
				@L2400_29_too03_tooth_surface_code_3 char(2),
				@L2400_29_too03_tooth_surface_code_4 char(2),
				@L2400_29_too03_tooth_surface_code_5 char(2),
				@L2400_30_too02_JP_tooth_code varchar(30),
				@L2400_30_too03_tooth_surface_code_1 char(2),
				@L2400_30_too03_tooth_surface_code_2 char(2),
				@L2400_30_too03_tooth_surface_code_3 char(2),
				@L2400_30_too03_tooth_surface_code_4 char(2),
				@L2400_30_too03_tooth_surface_code_5 char(2),
				@L2400_31_too02_JP_tooth_code varchar(30),
				@L2400_31_too03_tooth_surface_code_1 char(2),
				@L2400_31_too03_tooth_surface_code_2 char(2),
				@L2400_31_too03_tooth_surface_code_3 char(2),
				@L2400_31_too03_tooth_surface_code_4 char(2),
				@L2400_31_too03_tooth_surface_code_5 char(2),
				@L2400_32_too02_JP_tooth_code varchar(30),
				@L2400_32_too03_tooth_surface_code_1 char(2),
				@L2400_32_too03_tooth_surface_code_2 char(2),
				@L2400_32_too03_tooth_surface_code_3 char(2),
				@L2400_32_too03_tooth_surface_code_4 char(2),
				@L2400_32_too03_tooth_surface_code_5 char(2)',
				@tmp_JP_tooth_code output,
				@tmp_tooth_surface_code_1 output,
				@tmp_tooth_surface_code_2 output,
				@tmp_tooth_surface_code_3 output,
				@tmp_tooth_surface_code_4 output,
				@tmp_tooth_surface_code_5 output,
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
				@L2400_32_too03_tooth_surface_code_5
			
			if (@tmp_JP_tooth_code IS NOT NULL)
			begin
				exec up_x12_too_export	@x12_interchange_uid = @x12_interchange_uid,
							@too02_JP_tooth_code = @tmp_JP_tooth_code,
							@too03_tooth_surface_code_1 = @tmp_tooth_surface_code_1,
							@too03_tooth_surface_code_2 = @tmp_tooth_surface_code_2,
							@too03_tooth_surface_code_3 = @tmp_tooth_surface_code_3,
							@too03_tooth_surface_code_4 = @tmp_tooth_surface_code_4,
							@too03_tooth_surface_code_5 = @tmp_tooth_surface_code_5
			end
			else break
		end

		if 	(@L2400_dtp02_472_service_date  IS NOT NULL)
		begin
			exec up_x12_dtp_export	@x12_interchange_uid = @x12_interchange_uid,
						@dtp01_date_time_qual = '472',
						@dtp03_begin_date = @L2400_dtp02_472_service_date
		end
		if 	(@L2400_dtp02_441_prior_placement_date  IS NOT NULL)
		begin
			exec up_x12_dtp_export	@x12_interchange_uid = @x12_interchange_uid,
						@dtp01_date_time_qual = '441',
						@dtp03_begin_date = @L2400_dtp02_441_prior_placement_date
		end
		if 	(@L2400_dtp02_452_orthodontic_banding_date  IS NOT NULL)
		begin
			exec up_x12_dtp_export	@x12_interchange_uid = @x12_interchange_uid,
						@dtp01_date_time_qual = '452',
						@dtp03_begin_date = @L2400_dtp02_452_orthodontic_banding_date
		end
		if 	(@L2400_dtp02_446_replacement_date  IS NOT NULL)
		begin
			exec up_x12_dtp_export	@x12_interchange_uid = @x12_interchange_uid,
						@dtp01_date_time_qual = '446',
						@dtp03_begin_date = @L2400_dtp02_446_replacement_date
		end

		if 	(@L2400_ref02_G3_predetermination_of_benefits_id  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'G3',
						@ref02_reference_number = @L2400_ref02_G3_predetermination_of_benefits_id
		end
		if 	(@L2400_ref02_9F_referral_number  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = '9F',
						@ref02_reference_number = @L2400_ref02_9F_referral_number
		end
		if 	(@L2400_ref02_G1_prior_auth_number  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'G1',
						@ref02_reference_number = @L2400_ref02_G1_prior_auth_number
		end
		if 	(@L2400_ref02_6R_line_item_control_num  IS NOT NULL)
		begin
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = '6R',
						@ref02_reference_number = @L2400_ref02_6R_line_item_control_num
		end
				
	-- BEGIN OF 2420A LOOP
		-- If any of the 2420A attending provider information exists, export the loop.
		if (	@L2420A_nm103_rendering_prov_last_nm IS NOT NULL OR
			@L2420A_nm108_id_code_qual IS NOT NULL OR
			@L2420A_nm109_rendering_prov_id IS NOT NULL)
		begin
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = '82',
						@nm102_entity_type_qual = @L2420A_nm102_entity_type_qual,
						@nm103_last_name = @L2420A_nm103_rendering_prov_last_nm,
						@nm104_first_name = @L2420A_nm104_rendering_prov_first_nm,
						@nm105_middle_name = @L2420A_nm105_rendering_prov_middle_nm,
						@nm107_name_suffix = @L2420A_nm107_rendering_prov_suffix,
						@nm108_id_code_qual = @L2420A_nm108_id_code_qual,
						@nm109_id_code = @L2420A_nm109_rendering_prov_id

			-- BEGIN: 2420A REF SEGMENTS
			-- 2420A Loop REF 1C segment
			if 	(@L2420A_ref02_1C_rendering_prov_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1C',
							@ref02_reference_number = @L2420A_ref02_1C_rendering_prov_id
			end
			-- 2420A Loop REF 1D Segment
			if 	(@L2420A_ref02_1D_rendering_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1D',
							@ref02_reference_number = @L2420A_ref02_1D_rendering_prov_id
			end
			-- 2420A Loop REF 1e Segment
			if 	(@L2420A_ref02_1E_rendering_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1E',
							@ref02_reference_number = @L2420A_ref02_1E_rendering_prov_id
			end
			-- 2420A Loop REF EI Segment
			if 	(@L2420A_ref02_EI_rendering_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'EI',
							@ref02_reference_number = @L2420A_ref02_EI_rendering_prov_id
			end
			-- 2420A Loop REF SY
			if 	(@L2420A_ref02_SY_rendering_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'SY',
							@ref02_reference_number = @L2420A_ref02_SY_rendering_prov_id
			end
			-- 2420A Loop REF TJ
			if 	(@L2420A_ref02_TJ_rendering_prov_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'TJ',
							@ref02_reference_number = @L2420A_ref02_TJ_rendering_prov_id
			end
			--End of 2420A REF SEGMENTS
		End	
	-- END OF 2420A LOOP

	
	-- BEGIN OF 2420B LOOP
		if (	@L2420B_nm103_payer_last_nm IS NOT NULL OR
			@L2420B_nm108_id_code_qual IS NOT NULL OR
			@L2420B_nm109_other_payer_id IS NOT NULL )
		begin
			-- If the 2420B loop is used, then the NM1 segment is always required.
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = 'PR',
						@nm102_entity_type_qual = @L2420B_nm102_entity_type_qual,
						@nm103_last_name = @L2420B_nm103_payer_last_nm,
						@nm108_id_code_qual = @L2420B_nm108_id_code_qual,
						@nm109_id_code = @L2420B_nm109_other_payer_id

		-- BEGIN: 2420B REF SEGMENTS
			-- 2420B Loop REF 9F segment
			if 	(@L2420B_ref02_9F_referral_number IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '9F',
							@ref02_reference_number = @L2420B_ref02_9F_referral_number
			end
			-- 2420B Loop REF G1 Segment
			if 	(@L2420B_ref02_G1_prior_auth_number  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'G1',
							@ref02_reference_number = @L2420B_ref02_G1_prior_auth_number
			end
		-- END: 2420B REF SEGMENTS
		End
	-- END OF 2420B LOOP
	

	-- BEGIN OF 2420C LOOP
		if (	@L2420C_nm103_assistant_surgeon_last_nm IS NOT NULL OR
			@L2420C_nm108_id_code_qual IS NOT NULL OR
			@L2420C_nm109_assistant_surgeon_id IS NOT NULL )
		begin
			-- If the 2420C loop is used, then the NM1 segment is always required.
			exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
						@nm101_entity_id_code = 'DD',
						@nm102_entity_type_qual = @L2420C_nm102_entity_type_qual,
						@nm103_last_name = @L2420C_nm103_assistant_surgeon_last_nm,
						@nm104_first_name = @L2420C_nm104_assistant_surgeon_first_nm,
						@nm105_middle_name = @L2420C_nm105_assistant_surgeon_middle_nm,
						@nm107_name_suffix = @L2420C_nm107_assistant_surgeon_suffix,
						@nm108_id_code_qual = @L2420C_nm108_id_code_qual,
						@nm109_id_code = @L2420C_nm109_assistant_surgeon_id

		-- BEGIN: 2420C REF SEGMENTS
			-- 2420C Loop REF 1C segment
			if 	(@L2420C_ref02_1C_service_facility_id IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1C',
							@ref02_reference_number = @L2420C_ref02_1C_service_facility_id
			end
			-- 2420C Loop REF 1D Segment
			if 	(@L2420C_ref02_1D_service_facility_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1D',
							@ref02_reference_number = @L2420C_ref02_1D_service_facility_id
			end
			-- 2420C Loop REF 1E Segment
			if 	(@L2420C_ref02_1E_service_facility_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = '1E',
							@ref02_reference_number = @L2420C_ref02_1E_service_facility_id
			end
			-- 2420C Loop REF G2
			if 	(@L2420C_ref02_G2_service_facility_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'G2',
							@ref02_reference_number = @L2420C_ref02_G2_service_facility_id
			end
			-- 2420C Loop REF TJ
			if 	(@L2420C_ref02_TJ_service_facility_id  IS NOT NULL)
			begin
				exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
							@ref01_id_qual = 'TJ',
							@ref02_reference_number = @L2420C_ref02_TJ_service_facility_id
			end
		-- END: 2420C REF SEGMENTS
		End
	-- END OF 2420C LOOP

	
	-- Export a CAS segment for EVERY line where the charges don't equal the payment amount
		if (@L2430_svd01_other_payer_id IS NOT NULL)
		begin
			-- Export the SVD Segment
			exec up_x12_svd_export	@x12_interchange_uid = @x12_interchange_uid,
						@svd01_other_payer_id = @L2430_svd01_other_payer_id,
						@svd02_service_line_paid = @L2430_svd02_service_line_paid,
						@svd03_proc_code_qual = @L2430_svd03_service_id_qual,
						@svd103_proc_code = @L2430_svd03_proc_code,
						@svd103_proc_mod1 = @L2430_svd03_proc_mod1,
						@svd103_proc_mod2 = @L2430_svd03_proc_mod2,
						@svd103_proc_mod3 = @L2430_svd03_proc_mod3,
						@svd103_proc_mod4 = @L2430_svd03_proc_mod4,
						@svd103_proc_code_desc = @L2430_svd03_proc_code_desc,
						@svd105_paid_service_count = @L2430_svd05_paid_service_unit,
						@svd106_bundled_line_num = @L2430_svd06_bundled_unbundled_line_num

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
						@dtp03_begin_date = @L2430_dtp03_573_date_claim_paid 
	
			 
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
	set @prev_L2010AA_ref02_1E_billing_prov_id = @L2010AA_ref02_1E_billing_prov_id
	set @prev_L2010AA_ref02_EI_billing_prov_id = @L2010AA_ref02_EI_billing_prov_id
	set @prev_L2010AA_ref02_SY_billing_prov_id = @L2010AA_ref02_SY_billing_prov_id
	set @prev_L2010AA_ref02_TJ_billing_prov_id = @L2010AA_ref02_TJ_billing_prov_id

	set @prev_L2000B_hl01_hierarchical_id_num = @L2000B_hl01_hierarchical_id_num 
	set @prev_L2000B_hl02_hierarchical_parent_id_num = @L2000B_hl02_hierarchical_parent_id_num 
	set @prev_L2000B_hl03_hierarchical_level_code = @L2000B_hl03_hierarchical_level_code 
	set @prev_L2000B_hl04_hierarchical_child_code = @L2000B_hl04_hierarchical_child_code 
	
	set @prev_L2000B_sbr01_payer_resp_seq_code = @L2000B_sbr01_payer_resp_seq_code
	set @prev_L2000B_sbr02_ind_relationship_code = @L2000B_sbr02_ind_relationship_code
	set @prev_L2000B_sbr03_insured_grp_policy_num = @L2000B_sbr03_insured_grp_policy_num
	set @prev_L2000B_sbr04_insured_grp_nm = @L2000B_sbr04_insured_grp_nm
	set @prev_L2000B_sbr06_cob_code = @L2000B_sbr06_cob_code
	set @prev_L2000B_sbr09_claim_filing_ind_code = @L2000B_sbr09_claim_filing_ind_code
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

	set @prev_L2330B_1_ref02_2U_other_payer_secondary_id = @L2330B_1_ref02_2U_other_payer_secondary_id
	set @prev_L2330B_1_ref02_F8_other_payer_secondary_id = @L2330B_1_ref02_F8_other_payer_secondary_id
	set @prev_L2330B_1_ref02_FY_other_payer_secondary_id = @L2330B_1_ref02_FY_other_payer_secondary_id
	set @prev_L2330B_1_ref02_NF_other_payer_secondary_id = @L2330B_1_ref02_NF_other_payer_secondary_id
	set @prev_L2330B_1_ref02_TJ_other_payer_secondary_id = @L2330B_1_ref02_TJ_other_payer_secondary_id
	set @prev_L2330B_1_ref02_9F_other_payer_auth_num = @L2330B_1_ref02_9F_other_payer_auth_num
	set @prev_L2330B_1_ref02_G1_other_payer_auth_num = @L2330B_1_ref02_G1_other_payer_auth_num
	set @prev_L2330B_1_ref02_T4_other_payer_claim_adj_ind = @L2330B_1_ref02_T4_other_payer_claim_adj_ind

	set @prev_L2330B_2_ref02_2U_other_payer_secondary_id = @L2330B_2_ref02_2U_other_payer_secondary_id
	set @prev_L2330B_2_ref02_F8_other_payer_secondary_id = @L2330B_2_ref02_F8_other_payer_secondary_id
	set @prev_L2330B_2_ref02_FY_other_payer_secondary_id = @L2330B_2_ref02_FY_other_payer_secondary_id
	set @prev_L2330B_2_ref02_NF_other_payer_secondary_id = @L2330B_2_ref02_NF_other_payer_secondary_id
	set @prev_L2330B_2_ref02_TJ_other_payer_secondary_id = @L2330B_2_ref02_TJ_other_payer_secondary_id
	set @prev_L2330B_2_ref02_9F_other_payer_auth_num = @L2330B_2_ref02_9F_other_payer_auth_num
	set @prev_L2330B_2_ref02_G1_other_payer_auth_num = @L2330B_2_ref02_G1_other_payer_auth_num
	set @prev_L2330B_2_ref02_T4_other_payer_claim_adj_ind = @L2330B_2_ref02_T4_other_payer_claim_adj_ind

	set @prev_L2330B_3_ref02_2U_other_payer_secondary_id = @L2330B_3_ref02_2U_other_payer_secondary_id
	set @prev_L2330B_3_ref02_F8_other_payer_secondary_id = @L2330B_3_ref02_F8_other_payer_secondary_id
	set @prev_L2330B_3_ref02_FY_other_payer_secondary_id = @L2330B_3_ref02_FY_other_payer_secondary_id
	set @prev_L2330B_3_ref02_NF_other_payer_secondary_id = @L2330B_3_ref02_NF_other_payer_secondary_id
	set @prev_L2330B_3_ref02_TJ_other_payer_secondary_id = @L2330B_3_ref02_TJ_other_payer_secondary_id
	set @prev_L2330B_3_ref02_9F_other_payer_auth_num = @L2330B_3_ref02_9F_other_payer_auth_num
	set @prev_L2330B_3_ref02_G1_other_payer_auth_num = @L2330B_3_ref02_G1_other_payer_auth_num
	set @prev_L2330B_3_ref02_T4_other_payer_claim_adj_ind = @L2330B_3_ref02_T4_other_payer_claim_adj_ind

	set @prev_L2400_lx01_assigned_num = @L2400_lx01_assigned_num
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
					@L2430_dtp03_573_date_claim_paid
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



