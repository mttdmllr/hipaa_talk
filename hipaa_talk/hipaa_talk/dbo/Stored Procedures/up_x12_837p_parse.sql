CREATE Procedure [dbo].[up_x12_837p_parse] (@x12_transaction_id int, @se01_num_transaction_segments int = null output)
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

declare @bht01_hierarchical_structure_code char(4)
declare @bht02_trans_set_purpose_code char(2)
declare @bht03_orig_app_tran_id varchar(30)
declare @bht04_trans_set_creation_date varchar(8)
declare @bht05_trans_set_creation_time varchar(8)
declare @bht06_claim_encounter_id char(2)
declare @ref01_receiver_ref_id_qual char (3)
declare @ref02_transmission_type_code varchar (30)
declare @L1000A_nm102_entity_type_qual char (1)
declare @L1000A_nm103_submitter_last_nm varchar (35)
declare @L1000A_nm104_submitter_first_nm varchar (25)
declare @L1000A_nm105_submitter_middle_nm varchar (25)
declare @L1000A_nm108_submitter_id_qual char (2)
declare @L1000A_nm109_submitter_id varchar (80)
declare @L1000A_per01_contact_function_code char (2)
declare @L1000A_per02_contact_nm varchar (60)
declare @L1000A_per03_comm_num_qual char (2)
declare @L1000A_per04_comm_number varchar (80)
declare @L1000B_nm102_entity_type_qual char (1)
declare @L1000B_nm103_receiver_last_nm varchar (35)
declare @L1000B_nm108_receiver_id_qual char (2)
declare @L1000B_nm109_receiver_id varchar (80)
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
declare @L2000B_sbr05_insurance_type_code char(3)
declare @L2000B_sbr09_claim_filing_ind_code char(2)
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
declare @L2010BB_nm103_payer_nm varchar(35)
declare @L2010BB_nm108_payer_id_qual char(2)
declare @L2010BB_nm109_payer_id varchar(80)
declare @L2010BB_n301_payer_address1 varchar(55)
declare @L2010BB_n302_payer_address2 varchar(55)
declare @L2010BB_n401_payer_city varchar(30)
declare @L2010BB_n402_payer_state char(2)
declare @L2010BB_n403_payer_zip varchar(15)
declare @L2010BB_n404_payer_country char(3)
declare @L2010BB_ref02_2U_payer_id varchar(30)
declare @L2010BB_ref02_FY_payer_id varchar(30)
declare @L2010BB_ref02_NF_payer_id varchar(30)
declare @L2010BB_ref02_TJ_payer_id varchar(30)
declare @L2010BC_nm102_entity_type_qual char(1)
declare @L2010BC_nm103_resp_party_last_nm varchar(35)
declare @L2010BC_nm104_resp_party_first_nm varchar(25)
declare @L2010BC_nm105_resp_party_middle_nm varchar(25)
declare @L2010BC_nm107_resp_party_suffix varchar(10)
declare @L2010BC_n301_resp_party_address1 varchar(55)
declare @L2010BC_n302_resp_party_address2 varchar(55)
declare @L2010BC_n401_resp_party_city varchar(30)
declare @L2010BC_n402_resp_party_state char(2)
declare @L2010BC_n403_resp_party_zip varchar(15)
declare @L2010BC_n404_resp_party_country char(3)
declare @L2010BD_nm102_entity_type_qual char(1)
declare @L2010BD_nm103_card_holder_last_nm varchar(35)
declare @L2010BD_nm104_card_holder_first_nm varchar(25)
declare @L2010BD_nm105_card_holder_middle_nm varchar(25)
declare @L2010BD_nm107_card_holder_suffix varchar(10)
declare @L2010BD_nm108_card_id_qual char(2)
declare @L2010BD_nm109_card_num varchar(80)
declare @L2010BD_ref02_AB_card_num varchar(30)
declare @L2010BD_ref02_BB_card_num varchar(30)
declare @L2000C_hl01_hierarchical_id_num varchar(12)
declare @L2000C_hl02_hierarchical_parent_id_num varchar(12)
declare @L2000C_hl03_hierarchical_level_code char(2)
declare @L2000C_hl04_hierarchical_child_code char(1)
declare @L2000C_pat01_ind_relationship_code char(2)
declare @L2000C_pat06_insured_ind_death_date varchar(35)
declare @L2000C_pat08_patient_weight varchar(10)
declare @L2000C_pat09_pregnancy_indicator char(1)
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
declare @L2300_clm05_claim_freq_code char(1)
declare @L2300_clm06_provider_signature_ind char(1)
declare @L2300_clm07_medicare_assign_code char(1)
declare @L2300_clm08_benefit_assign_ind char(1)
declare @L2300_clm09_release_of_info_code char(1)
declare @L2300_clm10_patient_signature_code char(1)
declare @L2300_clm11_related_causes_code1 char(3)
declare @L2300_clm11_related_causes_code2 char(3)
declare @L2300_clm11_related_causes_code3 char(3)
declare @L2300_clm11_auto_accident_state_code char(2)
declare @L2300_clm11_country_code char(3)
declare @L2300_clm12_special_prog_ind char(3)
declare @L2300_clm16_participation_agreement char(1)
declare @L2300_clm20_delay_reason_code char(2)
declare @L2300_dtp03_454_initial_tmt_date varchar(35)
declare @L2300_dtp03_304_last_seen_date varchar(35)
declare @L2300_dtp03_431_onset_of_injury_date varchar(35)
declare @L2300_dtp03_453_acute_manifestation_date varchar(35)
declare @L2300_dtp03_438_symptom_date varchar(35)
declare @L2300_dtp03_439_accident_date varchar(35)
declare @L2300_dtp03_484_last_menstrual_period_date varchar(35)
declare @L2300_dtp03_455_last_xray_date varchar(35)
declare @L2300_dtp03_471_prescription_date varchar(35)
declare @L2300_dtp03_360_disability_begin_date varchar(35)
declare @L2300_dtp03_361_disability_end_date varchar(35)
declare @L2300_dtp03_297_last_worked_date varchar(35)
declare @L2300_dtp03_296_work_return_date varchar(35)
declare @L2300_dtp03_435_admission_date varchar(35)
declare @L2300_dtp03_096_discharge_date varchar(35)
declare @L2300_dtp03_090_assumed_care_date varchar(35)
declare @L2300_dtp03_091_relinquished_care_date varchar(35)
declare @L2300_pwk01_attachment_type_code char(2)
declare @L2300_pwk02_attachment_trans_code char(2)
declare @L2300_pwk06_attachment_control_num varchar(80)
declare @L2300_amt02_patient_paid_amt money
declare @L2300_amt02_total_purchased_amt money
declare @L2300_ref02_9F_prior_auth_num varchar(30)
declare @L2300_ref02_G1_referral_num varchar(30)
declare @L2300_ref02_F8_original_ref_num varchar(30)
declare @L2300_ref02_9A_repriced_claim_num varchar(30)
declare @L2300_ref02_9C_adj_repriced_claim_num varchar(30)
declare @L2300_ref02_EA_medical_record_num varchar(30)
declare @L2300_k301_fixed_format_info varchar(80)
declare @L2300_nte01_note_ref_code char(3)
declare @L2300_nte02_claim_note_text varchar(80)
declare @L2300_hi01_diag_code varchar(30)
declare @L2300_hi02_diag_code varchar(30)
declare @L2300_hi03_diag_code varchar(30)
declare @L2300_hi04_diag_code varchar(30)
declare @L2300_hi05_diag_code varchar(30)
declare @L2300_hi06_diag_code varchar(30)
declare @L2300_hi07_diag_code varchar(30)
declare @L2300_hi08_diag_code varchar(30)
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
declare @L2310A_ref02_1G_referring_prov_id varchar(30)
declare @L2310A_ref02_EI_referring_prov_id varchar(30)
declare @L2310A_ref02_SY_referring_prov_id varchar(30)
declare @L2310A_ref02_FH_referring_prov_id varchar(30)
declare @L2310A_ref02_G2_referring_prov_id varchar(30)
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
declare @L2310B_ref02_1G_rendering_prov_id varchar(30)
declare @L2310B_ref02_EI_rendering_prov_id varchar(30)
declare @L2310B_ref02_SY_rendering_prov_id varchar(30)
declare @L2310B_ref02_FH_rendering_prov_id varchar(30)
declare @L2310B_ref02_G2_rendering_prov_id varchar(30)
declare @L2310D_nm101_entity_id_code char(3)
declare @L2310D_nm102_entity_type_qual char(1)
declare @L2310D_nm103_service_facility_last_nm varchar(35)
declare @L2310D_nm108_id_code_qual char(2)
declare @L2310D_nm109_service_facility_id varchar(80)
declare @L2310D_n301_service_facility_address1 varchar(55)
declare @L2310D_n302_service_facility_address2 varchar(55)
declare @L2310D_n401_service_facility_city varchar(30)
declare @L2310D_n402_service_facility_state char(2)
declare @L2310D_n403_service_facility_zip varchar(15)
declare @L2310D_n404_service_facility_country char(3)
declare @L2310D_ref02_1C_service_facility_id varchar(30)
declare @L2310D_ref02_1D_service_facility_id varchar(30)
declare @L2310D_ref02_1G_service_facility_id varchar(30)
declare @L2310D_ref02_G2_service_facility_id varchar(30)
declare @L2310D_ref02_TJ_service_facility_id varchar(30)
declare @L2310E_nm102_entity_type_qual char(1)
declare @L2310E_nm103_supervising_prov_last_nm varchar(35)
declare @L2310E_nm104_supervising_prov_first_nm varchar(25)
declare @L2310E_nm105_supervising_prov_middle_nm varchar(25)
declare @L2310E_nm107_supervising_prov_suffix varchar(10)
declare @L2310E_nm108_id_code_qual char(2)
declare @L2310E_nm109_supervising_prov_id varchar(80)
declare @L2320_sbr01_payer_resp_seq_code char(1)
declare @L2320_sbr02_ind_relationship_code char(2)
declare @L2320_sbr03_insured_grp_policy_num varchar(30)
declare @L2320_sbr04_insured_grp_nm varchar(60)
declare @L2320_sbr05_insurance_type_code char(3)
declare @L2320_sbr09_claim_filing_ind_code char(2)
declare @L2320_cas01_adjustment_group_code char(2)
declare @L2320_cas02_adjustment_reason_code varchar(5)
declare @L2320_cas03_adjustment_amt money
declare @L2320_cas04_adjustment_qty varchar(15)
declare @L2320_cas05_adjustment_reason_code varchar(5)
declare @L2320_cas06_adjustment_amt money
declare @L2320_cas07_adjustment_qty varchar(15)
declare @L2320_cas08_adjustment_reason_code varchar(5)
declare @L2320_cas09_adjustment_amt money
declare @L2320_cas10_adjustment_qty varchar(15)
declare @L2320_amt02_D_payer_paid_amt money
declare @L2320_amt02_AAE_approved_amt money
declare @L2320_amt02_B6_allowed_amt money
declare @L2320_amt02_F2_pt_responsibility_amt money
declare @L2320_amt02_AU_covered_amt money
declare @L2320_amt02_D8_discount_amt money
declare @L2320_amt02_DY_per_day_limit_amt money
declare @L2320_amt02_F5_pt_paid_amt money
declare @L2320_amt02_T_tax_amt money
declare @L2320_amt02_T2_total_clm_before_tax_amt money

declare @L2320_dmg02_other_subscriber_dob varchar(35)
declare @L2320_dmg03_other_subscriber_gender char(1)
declare @L2320_oi03_other_ins_benefit_assign_ind char(10)
declare @L2320_oi04_other_ins_patient_signature_code char(10)
declare @L2320_oi06_other_ins_release_of_info_code char(10)
declare @L2330A_nm101_entity_id_code char(3)
declare @L2330A_nm102_entity_type_qual varchar(35)
declare @L2330A_nm103_other_insured_last_name varchar(35)
declare @L2330A_nm104_other_insured_first_name varchar(25)
declare @L2330A_nm105_other_insured_middle_name varchar(25)
declare @L2330A_nm107_other_insured_name_suffix varchar(10)
declare @L2330A_nm108_other_insured_id_code_qual char(2)
declare @L2330A_nm109_other_insured_id varchar(80)
declare @L2330B_nm101_entity_id_code char(3)
declare @L2330B_nm102_entity_type_qual char(1)
declare @L2330B_nm103_other_payer_nm varchar(35)
declare @L2330B_nm108_id_code_qual char(2)
declare @L2330B_nm109_other_payer_id varchar(80)
declare @L2330B_dtp03_573_date_claim_paid varchar(35)
declare @L2330B_ref02_2U_other_payer_secondary_id varchar(30)
declare @L2330B_ref02_F8_other_payer_secondary_id varchar(30)
declare @L2330B_ref02_FY_other_payer_secondary_id varchar(30)
declare @L2330B_ref02_NF_other_payer_secondary_id varchar(30)
declare @L2330B_ref02_TJ_other_payer_secondary_id varchar(30)
declare @L2400_lx01_assigned_num varchar(6)
declare @L2400_sv101_proc_code_qual char(2)
declare @L2400_sv101_proc_code varchar(48)
declare @L2400_sv101_proc_mod1 char(2)
declare @L2400_sv101_proc_mod2 char(2)
declare @L2400_sv101_proc_mod3 char(2)
declare @L2400_sv101_proc_mod4 char(2)
declare @L2400_sv102_line_charge money
declare @L2400_sv103_measurement_code char(2)
declare @L2400_sv104_service_unit_count varchar(15)
declare @L2400_sv105_place_of_service char(2)
declare @L2400_sv107_dx_pointer1 char(2)
declare @L2400_sv107_dx_pointer2 char(2)
declare @L2400_sv107_dx_pointer3 char(2)
declare @L2400_sv107_dx_pointer4 char(2)
declare @L2400_sv109_emergency_indicator char(1)
declare @L2400_sv111_epsdt_indicator char(1)
declare @L2400_sv112_family_plan_indicator char(1)
declare @L2400_sv115_copay_status_code char(1)
declare @L2400_dtp02_472_from_service_date varchar(35)
declare @L2400_dtp02_472_to_service_date varchar(35)
declare @L2400_ref02_6R_line_item_control_num varchar(30)
declare @L2400_nte01_note_ref_code char(3)
declare @L2400_nte02_line_note_text varchar(80)
DECLARE @L2410_1_lin03_N4_ndc VARCHAR(48)
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
declare @L2420A_ref02_1G_rendering_prov_id varchar(30)
declare @L2420A_ref02_EI_rendering_prov_id varchar(30)
declare @L2420A_ref02_SY_rendering_prov_id varchar(30)
declare @L2420A_ref02_FH_rendering_prov_id varchar(30)
declare @L2420C_nm101_entity_id_code char(3)
declare @L2420C_nm102_entity_type_qual char(1)
declare @L2420C_nm103_service_facility_last_nm varchar(35)
declare @L2420C_nm108_id_code_qual char(2)
declare @L2420C_nm109_service_facility_id varchar(80)
declare @L2420C_n301_service_facility_address1 varchar(55)
declare @L2420C_n302_service_facility_address2 varchar(55)
declare @L2420C_n401_service_facility_city varchar(30)
declare @L2420C_n402_service_facility_state char(2)
declare @L2420C_n403_service_facility_zip varchar(15)
declare @L2420C_n404_service_facility_country char(3)
declare @L2420C_ref02_1C_service_facility_id varchar(30)
declare @L2420C_ref02_1D_service_facility_id varchar(30)
declare @L2420C_ref02_1G_service_facility_id varchar(30)
declare @L2420C_ref02_G2_service_facility_id varchar(30)
declare @L2420C_ref02_TJ_service_facility_id varchar(30)
declare @L2420D_nm102_entity_type_qual char(1)
declare @L2420D_nm103_supervising_prov_last_nm varchar(35)
declare @L2420D_nm104_supervising_prov_first_nm varchar(25)
declare @L2420D_nm105_supervising_prov_middle_nm varchar(25)
declare @L2420D_nm107_supervising_prov_suffix varchar(10)
declare @L2420D_nm108_id_code_qual char(2)
declare @L2420D_nm109_supervising_prov_id varchar(80)
declare @L2420F_nm101_entity_id_code char(3)
declare @L2420F_nm102_entity_type_qual char(1)
declare @L2420F_nm103_referring_prov_last_nm varchar(35)
declare @L2420F_nm104_referring_prov_first_nm varchar(25)
declare @L2420F_nm105_referring_prov_middle_nm varchar(25)
declare @L2420F_nm107_referring_prov_suffix varchar(10)
declare @L2420F_nm108_id_code_qual char(2)
declare @L2420F_nm109_referring_prov_id varchar(80)
declare @L2420F_prv01_provider_code char(3)
declare @L2420F_prv02_ref_id_qual char(3)
declare @L2420F_prv03_taxonomy_code varchar(30)
declare @L2420F_ref02_1C_referring_prov_id varchar(30)
declare @L2420F_ref02_1D_referring_prov_id varchar(30)
declare @L2420F_ref02_1G_referring_prov_id varchar(30)
declare @L2420F_ref02_EI_referring_prov_id varchar(30)
declare @L2420F_ref02_SY_referring_prov_id varchar(30)
declare @L2420F_ref02_FH_referring_prov_id varchar(30)
declare @L2430_svd01_other_payer_id varchar(80)
declare @L2430_svd02_service_line_paid money
declare @L2430_cas01_adjustment_group_code char(3)
declare @L2430_cas02_adjustment_reason_code varchar(5)
declare @L2430_cas03_adjustment_amt money
declare @L2430_cas04_adjustment_qty varchar(15)
declare @L2430_cas05_adjustment_reason_code varchar(5)
declare @L2430_cas06_adjustment_amt money
declare @L2430_cas07_adjustment_qty varchar(15)
declare @L2430_cas08_adjustment_reason_code varchar(5)
declare @L2430_cas09_adjustment_amt money
declare @L2430_cas10_adjustment_qty varchar(15)
declare @L2430_dtp03_573_date_claim_paid varchar(35) 
-- These are temporary variables
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

DECLARE curt837p SCROLL CURSOR FOR
	select Col001, Col002, Col003, Col004, Col005, Col006, Col007, Col008, Col009, Col010, Col011, Col012, Col013, Col014, Col015, Col016, Col017, Col018, Col019, Col020, Col021
	from x12_parse_temp
	where	x12_parse_temp_id BETWEEN @x12_parse_temp_id_start AND @x12_parse_temp_id_end
		AND x12_parse_temp_uid = @x12_interchange_uid
	order by x12_parse_temp_id

OPEN curt837p

FETCH NEXT FROM curt837p INTO @Col001, @Col002, @Col003, @Col004, @Col005, @Col006, @Col007, @Col008, @Col009, @Col010, @Col011, @Col012, @Col013, @Col014, @Col015, @Col016, @Col017, @Col018, @Col019, @Col020, @Col021
WHILE (@@fetch_status <> -1)
BEGIN
	set @se01_num_transaction_segments = @se01_num_transaction_segments + 1




	-- If the current segment is an HL or CLM segment, we're definitely getting ready for a new claim.
	if ( RTrim(@col001) = 'HL' OR RTrim(@col001) = 'CLM' )
	begin
		if (@L2400_sv101_proc_code IS NOT NULL AND @L2400_lx01_assigned_num IS NOT NULL)
		begin
			-- insert a record when we start a new claim (meaning we're done with the last service line on the previous claim)
			EXEC dbo.up_x12_837p_insert 
				@bht01_hierarchical_structure_code = @bht01_hierarchical_structure_code,
				@bht02_trans_set_purpose_code = @bht02_trans_set_purpose_code,
				@bht03_orig_app_tran_id = @bht03_orig_app_tran_id,
				@bht04_trans_set_creation_date = @bht04_trans_set_creation_date,
				@bht05_trans_set_creation_time = @bht05_trans_set_creation_time,
				@bht06_claim_encounter_id = @bht06_claim_encounter_id,
				@L1000A_nm102_entity_type_qual = @L1000A_nm102_entity_type_qual,
				@L1000A_nm103_submitter_last_nm = @L1000A_nm103_submitter_last_nm,
				@L1000A_nm104_submitter_first_nm = @L1000A_nm104_submitter_first_nm,
				@L1000A_nm105_submitter_middle_nm = @L1000A_nm105_submitter_middle_nm,
				@L1000A_nm108_submitter_id_qual = @L1000A_nm108_submitter_id_qual,
				@L1000A_nm109_submitter_id = @L1000A_nm109_submitter_id,
				@L1000A_per01_contact_function_code = @L1000A_per01_contact_function_code,
				@L1000A_per02_contact_nm = @L1000A_per02_contact_nm,
				@L1000A_per03_comm_num_qual = @L1000A_per03_comm_num_qual,
				@L1000A_per04_comm_number = @L1000A_per04_comm_number,
				@L1000B_nm102_entity_type_qual = @L1000B_nm102_entity_type_qual,
				@L1000B_nm103_receiver_last_nm = @L1000B_nm103_receiver_last_nm,
				@L1000B_nm108_receiver_id_qual = @L1000B_nm108_receiver_id_qual,
				@L1000B_nm109_receiver_id = @L1000B_nm109_receiver_id,
				@L2000A_cur02_currency_code = @L2000A_cur02_currency_code,
				@L2000A_hl01_hierarchical_id_num = @L2000A_hl01_hierarchical_id_num,
				@L2000A_hl03_hierarchical_level_code = @L2000A_hl03_hierarchical_level_code,
				@L2000A_hl04_hierarchical_child_code = @L2000A_hl04_hierarchical_child_code,
				@L2000A_prv01_provider_code = @L2000A_prv01_provider_code,
				@L2000A_prv02_ref_id_qual = @L2000A_prv02_ref_id_qual,
				@L2000A_prv03_taxonomy_code = @L2000A_prv03_taxonomy_code,
				@L2000B_hl01_hierarchical_id_num = @L2000B_hl01_hierarchical_id_num,
				@L2000B_hl02_hierarchical_parent_id_num = @L2000B_hl02_hierarchical_parent_id_num,
				@L2000B_hl03_hierarchical_level_code = @L2000B_hl03_hierarchical_level_code,
				@L2000B_hl04_hierarchical_child_code = @L2000B_hl04_hierarchical_child_code,
				@L2000B_pat06_insured_ind_death_date = @L2000B_pat06_insured_ind_death_date,
				@L2000B_pat08_patient_weight = @L2000B_pat08_patient_weight,
				@L2000B_pat09_pregnancy_indicator = @L2000B_pat09_pregnancy_indicator,
				@L2000B_sbr01_payer_resp_seq_code = @L2000B_sbr01_payer_resp_seq_code,
				@L2000B_sbr02_ind_relationship_code = @L2000B_sbr02_ind_relationship_code,
				@L2000B_sbr03_insured_grp_policy_num = @L2000B_sbr03_insured_grp_policy_num,
				@L2000B_sbr04_insured_grp_nm = @L2000B_sbr04_insured_grp_nm,
				@L2000B_sbr05_insurance_type_code = @L2000B_sbr05_insurance_type_code,
				@L2000B_sbr09_claim_filing_ind_code = @L2000B_sbr09_claim_filing_ind_code,
				@L2000C_hl01_hierarchical_id_num = @L2000C_hl01_hierarchical_id_num,
				@L2000C_hl02_hierarchical_parent_id_num = @L2000C_hl02_hierarchical_parent_id_num,
				@L2000C_hl03_hierarchical_level_code = @L2000C_hl03_hierarchical_level_code,
				@L2000C_hl04_hierarchical_child_code = @L2000C_hl04_hierarchical_child_code,
				@L2000C_pat01_ind_relationship_code = @L2000C_pat01_ind_relationship_code,
				@L2000C_pat06_insured_ind_death_date = @L2000C_pat06_insured_ind_death_date,
				@L2000C_pat08_patient_weight = @L2000C_pat08_patient_weight,
				@L2000C_pat09_pregnancy_indicator = @L2000C_pat09_pregnancy_indicator,
				@L2010AA_n301_billing_prov_address1 = @L2010AA_n301_billing_prov_address1,
				@L2010AA_n302_billing_prov_address2 = @L2010AA_n302_billing_prov_address2,
				@L2010AA_n401_billing_prov_city = @L2010AA_n401_billing_prov_city,
				@L2010AA_n402_billing_prov_state = @L2010AA_n402_billing_prov_state,
				@L2010AA_n403_billing_prov_zip = @L2010AA_n403_billing_prov_zip,
				@L2010AA_n404_billing_prov_country = @L2010AA_n404_billing_prov_country,
				@L2010AA_nm102_entity_type_qual = @L2010AA_nm102_entity_type_qual,
				@L2010AA_nm103_billing_prov_last_nm = @L2010AA_nm103_billing_prov_last_nm,
				@L2010AA_nm104_billing_prov_first_nm = @L2010AA_nm104_billing_prov_first_nm,
				@L2010AA_nm105_billing_prov_middle_nm = @L2010AA_nm105_billing_prov_middle_nm,
				@L2010AA_nm107_billing_prov_suffix = @L2010AA_nm107_billing_prov_suffix,
				@L2010AA_nm108_id_code_qual = @L2010AA_nm108_id_code_qual,
				@L2010AA_nm109_billing_prov_id = @L2010AA_nm109_billing_prov_id,
				@L2010AA_per01_billing_prov_comm_func_code = @L2010AA_per01_billing_prov_comm_func_code,
				@L2010AA_per02_billing_prov_contact_nm = @L2010AA_per02_billing_prov_contact_nm,
				@L2010AA_per03_billing_prov_comm_num_qual = @L2010AA_per03_billing_prov_comm_num_qual,
				@L2010AA_per04_billing_prov_comm = @L2010AA_per04_billing_prov_comm,
				@L2010AA_ref02_06_card_billing_id = @L2010AA_ref02_06_card_billing_id,
				@L2010AA_ref02_1C_billing_prov_id = @L2010AA_ref02_1C_billing_prov_id,
				@L2010AA_ref02_1D_billing_prov_id = @L2010AA_ref02_1D_billing_prov_id,
				@L2010AA_ref02_1G_billing_prov_id = @L2010AA_ref02_1G_billing_prov_id,
				@L2010AA_ref02_8U_card_billing_id = @L2010AA_ref02_8U_card_billing_id,
				@L2010AA_ref02_EI_billing_prov_id = @L2010AA_ref02_EI_billing_prov_id,
				@L2010AA_ref02_EM_card_billing_id = @L2010AA_ref02_EM_card_billing_id,
				@L2010AA_ref02_FH_billing_prov_id = @L2010AA_ref02_FH_billing_prov_id,
				@L2010AA_ref02_IJ_card_billing_id = @L2010AA_ref02_IJ_card_billing_id,
				@L2010AA_ref02_LU_card_billing_id = @L2010AA_ref02_LU_card_billing_id,
				@L2010AA_ref02_ST_card_billing_id = @L2010AA_ref02_ST_card_billing_id,
				@L2010AA_ref02_SY_billing_prov_id = @L2010AA_ref02_SY_billing_prov_id,
				@L2010AB_n301_payto_prov_address1 = @L2010AB_n301_payto_prov_address1,
				@L2010AB_n302_payto_prov_address2 = @L2010AB_n302_payto_prov_address2,
				@L2010AB_n401_payto_prov_city = @L2010AB_n401_payto_prov_city,
				@L2010AB_n402_payto_prov_state = @L2010AB_n402_payto_prov_state,
				@L2010AB_n403_payto_prov_zip = @L2010AB_n403_payto_prov_zip,
				@L2010AB_n404_payto_prov_country = @L2010AB_n404_payto_prov_country,
				@L2010AB_nm102_entity_type_qual = @L2010AB_nm102_entity_type_qual,
				@L2010AB_nm103_payto_prov_last_nm = @L2010AB_nm103_payto_prov_last_nm,
				@L2010AB_nm104_payto_prov_first_nm = @L2010AB_nm104_payto_prov_first_nm,
				@L2010AB_nm105_payto_prov_middle_nm = @L2010AB_nm105_payto_prov_middle_nm,
				@L2010AB_nm107_payto_prov_suffix = @L2010AB_nm107_payto_prov_suffix,
				@L2010AB_nm108_id_code_qual = @L2010AB_nm108_id_code_qual,
				@L2010AB_nm109_payto_prov_id = @L2010AB_nm109_payto_prov_id,
				@L2010AB_ref02_1C_payto_prov_id = @L2010AB_ref02_1C_payto_prov_id,
				@L2010AB_ref02_1D_payto_prov_id = @L2010AB_ref02_1D_payto_prov_id,
				@L2010AB_ref02_1G_payto_prov_id = @L2010AB_ref02_1G_payto_prov_id,
				@L2010AB_ref02_EI_payto_prov_id = @L2010AB_ref02_EI_payto_prov_id,
				@L2010AB_ref02_FH_payto_prov_id = @L2010AB_ref02_FH_payto_prov_id,
				@L2010AB_ref02_SY_payto_prov_id = @L2010AB_ref02_SY_payto_prov_id,
				@L2010BA_dmg02_subscriber_dob = @L2010BA_dmg02_subscriber_dob,
				@L2010BA_dmg03_subscriber_gender = @L2010BA_dmg03_subscriber_gender,
				@L2010BA_n301_subscriber_address1 = @L2010BA_n301_subscriber_address1,
				@L2010BA_n302_subscriber_address2 = @L2010BA_n302_subscriber_address2,
				@L2010BA_n401_subscriber_city = @L2010BA_n401_subscriber_city,
				@L2010BA_n402_subscriber_state = @L2010BA_n402_subscriber_state,
				@L2010BA_n403_subscriber_zip = @L2010BA_n403_subscriber_zip,
				@L2010BA_n404_subscriber_country = @L2010BA_n404_subscriber_country,
				@L2010BA_nm102_entity_type_qual = @L2010BA_nm102_entity_type_qual,
				@L2010BA_nm103_subscriber_last_nm = @L2010BA_nm103_subscriber_last_nm,
				@L2010BA_nm104_subscriber_first_nm = @L2010BA_nm104_subscriber_first_nm,
				@L2010BA_nm105_subscriber_middle_nm = @L2010BA_nm105_subscriber_middle_nm,
				@L2010BA_nm107_subscriber_suffix = @L2010BA_nm107_subscriber_suffix,
				@L2010BA_nm108_id_code_qual = @L2010BA_nm108_id_code_qual,
				@L2010BA_nm109_subscriber_id = @L2010BA_nm109_subscriber_id,
				@L2010BA_ref02_1W_subscriber_sup_id = @L2010BA_ref02_1W_subscriber_sup_id,
				@L2010BA_ref02_23_subscriber_sup_id = @L2010BA_ref02_23_subscriber_sup_id,
				@L2010BA_ref02_IG_subscriber_sup_id = @L2010BA_ref02_IG_subscriber_sup_id,
				@L2010BA_ref02_SY_subscriber_sup_id = @L2010BA_ref02_SY_subscriber_sup_id,
				@L2010BA_ref02_Y4_prop_casualty_claim_num = @L2010BA_ref02_Y4_prop_casualty_claim_num,
				@L2010BB_n301_payer_address1 = @L2010BB_n301_payer_address1,
				@L2010BB_n302_payer_address2 = @L2010BB_n302_payer_address2,
				@L2010BB_n401_payer_city = @L2010BB_n401_payer_city,
				@L2010BB_n402_payer_state = @L2010BB_n402_payer_state,
				@L2010BB_n403_payer_zip = @L2010BB_n403_payer_zip,
				@L2010BB_n404_payer_country = @L2010BB_n404_payer_country,
				@L2010BB_nm102_entity_type_qual = @L2010BB_nm102_entity_type_qual,
				@L2010BB_nm103_payer_nm = @L2010BB_nm103_payer_nm,
				@L2010BB_nm108_payer_id_qual = @L2010BB_nm108_payer_id_qual,
				@L2010BB_nm109_payer_id = @L2010BB_nm109_payer_id,
				@L2010BB_ref02_2U_payer_id = @L2010BB_ref02_2U_payer_id,
				@L2010BB_ref02_FY_payer_id = @L2010BB_ref02_FY_payer_id,
				@L2010BB_ref02_NF_payer_id = @L2010BB_ref02_NF_payer_id,
				@L2010BB_ref02_TJ_payer_id = @L2010BB_ref02_TJ_payer_id,
				@L2010BC_n301_resp_party_address1 = @L2010BC_n301_resp_party_address1,
				@L2010BC_n302_resp_party_address2 = @L2010BC_n302_resp_party_address2,
				@L2010BC_n401_resp_party_city = @L2010BC_n401_resp_party_city,
				@L2010BC_n402_resp_party_state = @L2010BC_n402_resp_party_state,
				@L2010BC_n403_resp_party_zip = @L2010BC_n403_resp_party_zip,
				@L2010BC_n404_resp_party_country = @L2010BC_n404_resp_party_country,
				@L2010BC_nm102_entity_type_qual = @L2010BC_nm102_entity_type_qual,
				@L2010BC_nm103_resp_party_last_nm = @L2010BC_nm103_resp_party_last_nm,
				@L2010BC_nm104_resp_party_first_nm = @L2010BC_nm104_resp_party_first_nm,
				@L2010BC_nm105_resp_party_middle_nm = @L2010BC_nm105_resp_party_middle_nm,
				@L2010BC_nm107_resp_party_suffix = @L2010BC_nm107_resp_party_suffix,
				@L2010BD_nm102_entity_type_qual = @L2010BD_nm102_entity_type_qual,
				@L2010BD_nm103_card_holder_last_nm = @L2010BD_nm103_card_holder_last_nm,
				@L2010BD_nm104_card_holder_first_nm = @L2010BD_nm104_card_holder_first_nm,
				@L2010BD_nm105_card_holder_middle_nm = @L2010BD_nm105_card_holder_middle_nm,
				@L2010BD_nm107_card_holder_suffix = @L2010BD_nm107_card_holder_suffix,
				@L2010BD_nm108_card_id_qual = @L2010BD_nm108_card_id_qual,
				@L2010BD_nm109_card_num = @L2010BD_nm109_card_num,
				@L2010BD_ref02_AB_card_num = @L2010BD_ref02_AB_card_num,
				@L2010BD_ref02_BB_card_num = @L2010BD_ref02_BB_card_num,
				@L2010CA_dmg02_patient_dob = @L2010CA_dmg02_patient_dob,
				@L2010CA_dmg03_patient_gender = @L2010CA_dmg03_patient_gender,
				@L2010CA_n301_patient_address1 = @L2010CA_n301_patient_address1,
				@L2010CA_n302_patient_address2 = @L2010CA_n302_patient_address2,
				@L2010CA_n401_patient_city = @L2010CA_n401_patient_city,
				@L2010CA_n402_patient_state = @L2010CA_n402_patient_state,
				@L2010CA_n403_patient_zip = @L2010CA_n403_patient_zip,
				@L2010CA_n404_patient_country = @L2010CA_n404_patient_country,
				@L2010CA_nm102_entity_type_qual = @L2010CA_nm102_entity_type_qual,
				@L2010CA_nm103_patient_last_nm = @L2010CA_nm103_patient_last_nm,
				@L2010CA_nm104_patient_first_nm = @L2010CA_nm104_patient_first_nm,
				@L2010CA_nm105_patient_middle_nm = @L2010CA_nm105_patient_middle_nm,
				@L2010CA_nm107_patient_suffix = @L2010CA_nm107_patient_suffix,
				@L2010CA_nm108_id_code_qual = @L2010CA_nm108_id_code_qual,
				@L2010CA_nm109_patient_id = @L2010CA_nm109_patient_id,
				@L2010CA_ref02_1W_patient_sup_id = @L2010CA_ref02_1W_patient_sup_id,
				@L2010CA_ref02_23_patient_sup_id = @L2010CA_ref02_23_patient_sup_id,
				@L2010CA_ref02_IG_patient_sup_id = @L2010CA_ref02_IG_patient_sup_id,
				@L2010CA_ref02_SY_patient_sup_id = @L2010CA_ref02_SY_patient_sup_id,
				@L2010CA_ref02_Y4_prop_casualty_claim_num = @L2010CA_ref02_Y4_prop_casualty_claim_num,
				@L2300_amt02_patient_paid_amt = @L2300_amt02_patient_paid_amt,
				@L2300_amt02_total_purchased_amt = @L2300_amt02_total_purchased_amt,
				@L2300_clm01_pt_acct_num = @L2300_clm01_pt_acct_num,
				@L2300_clm02_total_claim_chg_amt = @L2300_clm02_total_claim_chg_amt,
				@L2300_clm05_claim_freq_code = @L2300_clm05_claim_freq_code,
				@L2300_clm05_facility_type_code = @L2300_clm05_facility_type_code,
				@L2300_clm06_provider_signature_ind = @L2300_clm06_provider_signature_ind,
				@L2300_clm07_medicare_assign_code = @L2300_clm07_medicare_assign_code,
				@L2300_clm08_benefit_assign_ind = @L2300_clm08_benefit_assign_ind,
				@L2300_clm09_release_of_info_code = @L2300_clm09_release_of_info_code,
				@L2300_clm10_patient_signature_code = @L2300_clm10_patient_signature_code,
				@L2300_clm11_auto_accident_state_code = @L2300_clm11_auto_accident_state_code,
				@L2300_clm11_country_code = @L2300_clm11_country_code,
				@L2300_clm11_related_causes_code1 = @L2300_clm11_related_causes_code1,
				@L2300_clm11_related_causes_code2 = @L2300_clm11_related_causes_code2,
				@L2300_clm11_related_causes_code3 = @L2300_clm11_related_causes_code3,
				@L2300_clm12_special_prog_ind = @L2300_clm12_special_prog_ind,
				@L2300_clm16_participation_agreement = @L2300_clm16_participation_agreement,
				@L2300_clm20_delay_reason_code = @L2300_clm20_delay_reason_code,
				@L2300_dtp03_090_assumed_care_date = @L2300_dtp03_090_assumed_care_date,
				@L2300_dtp03_091_relinquished_care_date = @L2300_dtp03_091_relinquished_care_date,
				@L2300_dtp03_096_discharge_date = @L2300_dtp03_096_discharge_date,
				@L2300_dtp03_296_work_return_date = @L2300_dtp03_296_work_return_date,
				@L2300_dtp03_297_last_worked_date = @L2300_dtp03_297_last_worked_date,
				@L2300_dtp03_304_last_seen_date = @L2300_dtp03_304_last_seen_date,
				@L2300_dtp03_360_disability_begin_date = @L2300_dtp03_360_disability_begin_date,
				@L2300_dtp03_361_disability_end_date = @L2300_dtp03_361_disability_end_date,
				@L2300_dtp03_431_onset_of_injury_date = @L2300_dtp03_431_onset_of_injury_date,
				@L2300_dtp03_435_admission_date = @L2300_dtp03_435_admission_date,
				@L2300_dtp03_438_symptom_date = @L2300_dtp03_438_symptom_date,
				@L2300_dtp03_439_accident_date = @L2300_dtp03_439_accident_date,
				@L2300_dtp03_453_acute_manifestation_date = @L2300_dtp03_453_acute_manifestation_date,
				@L2300_dtp03_454_initial_tmt_date = @L2300_dtp03_454_initial_tmt_date,
				@L2300_dtp03_455_last_xray_date = @L2300_dtp03_455_last_xray_date,
				@L2300_dtp03_471_prescription_date = @L2300_dtp03_471_prescription_date,
				@L2300_dtp03_484_last_menstrual_period_date = @L2300_dtp03_484_last_menstrual_period_date,
				@L2300_hi01_diag_code = @L2300_hi01_diag_code,
				@L2300_hi02_diag_code = @L2300_hi02_diag_code,
				@L2300_hi03_diag_code = @L2300_hi03_diag_code,
				@L2300_hi04_diag_code = @L2300_hi04_diag_code,
				@L2300_hi05_diag_code = @L2300_hi05_diag_code,
				@L2300_hi06_diag_code = @L2300_hi06_diag_code,
				@L2300_hi07_diag_code = @L2300_hi07_diag_code,
				@L2300_hi08_diag_code = @L2300_hi08_diag_code,
				@L2300_k301_fixed_format_info = @L2300_k301_fixed_format_info,
				@L2300_nte01_note_ref_code = @L2300_nte01_note_ref_code,
				@L2300_nte02_claim_note_text = @L2300_nte02_claim_note_text,
				@L2300_pwk01_attachment_type_code = @L2300_pwk01_attachment_type_code,
				@L2300_pwk02_attachment_trans_code = @L2300_pwk02_attachment_trans_code,
				@L2300_pwk06_attachment_control_num = @L2300_pwk06_attachment_control_num,
				@L2300_ref02_9A_repriced_claim_num = @L2300_ref02_9A_repriced_claim_num,
				@L2300_ref02_9C_adj_repriced_claim_num = @L2300_ref02_9C_adj_repriced_claim_num,
				@L2300_ref02_9F_prior_auth_num = @L2300_ref02_9F_prior_auth_num,
				@L2300_ref02_EA_medical_record_num = @L2300_ref02_EA_medical_record_num,
				@L2300_ref02_F8_original_ref_num = @L2300_ref02_F8_original_ref_num,
				@L2300_ref02_G1_referral_num = @L2300_ref02_G1_referral_num,
				@L2310A_nm101_entity_id_code = @L2310A_nm101_entity_id_code,
				@L2310A_nm102_entity_type_qual = @L2310A_nm102_entity_type_qual,
				@L2310A_nm103_referring_prov_last_nm = @L2310A_nm103_referring_prov_last_nm,
				@L2310A_nm104_referring_prov_first_nm = @L2310A_nm104_referring_prov_first_nm,
				@L2310A_nm105_referring_prov_middle_nm = @L2310A_nm105_referring_prov_middle_nm,
				@L2310A_nm107_referring_prov_suffix = @L2310A_nm107_referring_prov_suffix,
				@L2310A_nm108_id_code_qual = @L2310A_nm108_id_code_qual,
				@L2310A_nm109_referring_prov_id = @L2310A_nm109_referring_prov_id,
				@L2310A_prv01_provider_code = @L2310A_prv01_provider_code,
				@L2310A_prv02_ref_id_qual = @L2310A_prv02_ref_id_qual,
				@L2310A_prv03_taxonomy_code = @L2310A_prv03_taxonomy_code,
				@L2310A_ref02_1C_referring_prov_id = @L2310A_ref02_1C_referring_prov_id,
				@L2310A_ref02_1D_referring_prov_id = @L2310A_ref02_1D_referring_prov_id,
				@L2310A_ref02_1G_referring_prov_id = @L2310A_ref02_1G_referring_prov_id,
				@L2310A_ref02_EI_referring_prov_id = @L2310A_ref02_EI_referring_prov_id,
				@L2310A_ref02_FH_referring_prov_id = @L2310A_ref02_FH_referring_prov_id,
				@L2310A_ref02_G2_referring_prov_id = @L2310A_ref02_G2_referring_prov_id,
				@L2310A_ref02_SY_referring_prov_id = @L2310A_ref02_SY_referring_prov_id,
				@L2310B_nm102_entity_type_qual = @L2310B_nm102_entity_type_qual,
				@L2310B_nm103_rendering_prov_last_nm = @L2310B_nm103_rendering_prov_last_nm,
				@L2310B_nm104_rendering_prov_first_nm = @L2310B_nm104_rendering_prov_first_nm,
				@L2310B_nm105_rendering_prov_middle_nm = @L2310B_nm105_rendering_prov_middle_nm,
				@L2310B_nm107_rendering_prov_suffix = @L2310B_nm107_rendering_prov_suffix,
				@L2310B_nm108_id_code_qual = @L2310B_nm108_id_code_qual,
				@L2310B_nm109_rendering_prov_id = @L2310B_nm109_rendering_prov_id,
				@L2310B_prv01_provider_code = @L2310B_prv01_provider_code,
				@L2310B_prv02_ref_id_qual = @L2310B_prv02_ref_id_qual,
				@L2310B_prv03_taxonomy_code = @L2310B_prv03_taxonomy_code,
				@L2310B_ref02_1C_rendering_prov_id = @L2310B_ref02_1C_rendering_prov_id,
				@L2310B_ref02_1D_rendering_prov_id = @L2310B_ref02_1D_rendering_prov_id,
				@L2310B_ref02_1G_rendering_prov_id = @L2310B_ref02_1G_rendering_prov_id,
				@L2310B_ref02_EI_rendering_prov_id = @L2310B_ref02_EI_rendering_prov_id,
				@L2310B_ref02_FH_rendering_prov_id = @L2310B_ref02_FH_rendering_prov_id,
				@L2310B_ref02_G2_rendering_prov_id = @L2310B_ref02_G2_rendering_prov_id,
				@L2310B_ref02_SY_rendering_prov_id = @L2310B_ref02_SY_rendering_prov_id,
				@L2310D_n301_service_facility_address1 = @L2310D_n301_service_facility_address1,
				@L2310D_n302_service_facility_address2 = @L2310D_n302_service_facility_address2,
				@L2310D_n401_service_facility_city = @L2310D_n401_service_facility_city,
				@L2310D_n402_service_facility_state = @L2310D_n402_service_facility_state,
				@L2310D_n403_service_facility_zip = @L2310D_n403_service_facility_zip,
				@L2310D_n404_service_facility_country = @L2310D_n404_service_facility_country,
				@L2310D_nm101_entity_id_code = @L2310D_nm101_entity_id_code,
				@L2310D_nm102_entity_type_qual = @L2310D_nm102_entity_type_qual,
				@L2310D_nm103_service_facility_last_nm = @L2310D_nm103_service_facility_last_nm,
				@L2310D_nm108_id_code_qual = @L2310D_nm108_id_code_qual,
				@L2310D_nm109_service_facility_id = @L2310D_nm109_service_facility_id,
				@L2310D_ref02_1C_service_facility_id = @L2310D_ref02_1C_service_facility_id,
				@L2310D_ref02_1D_service_facility_id = @L2310D_ref02_1D_service_facility_id,
				@L2310D_ref02_1G_service_facility_id = @L2310D_ref02_1G_service_facility_id,
				@L2310D_ref02_G2_service_facility_id = @L2310D_ref02_G2_service_facility_id,
				@L2310D_ref02_TJ_service_facility_id = @L2310D_ref02_TJ_service_facility_id,
				@L2310E_nm102_entity_type_qual = @L2310E_nm102_entity_type_qual,
				@L2310E_nm103_supervising_prov_last_nm = @L2310E_nm103_supervising_prov_last_nm,
				@L2310E_nm104_supervising_prov_first_nm = @L2310E_nm104_supervising_prov_first_nm,
				@L2310E_nm105_supervising_prov_middle_nm = @L2310E_nm105_supervising_prov_middle_nm,
				@L2310E_nm107_supervising_prov_suffix = @L2310E_nm107_supervising_prov_suffix,
				@L2310E_nm108_id_code_qual = @L2310E_nm108_id_code_qual,
				@L2310E_nm109_supervising_prov_id = @L2310E_nm109_supervising_prov_id,
				@L2320_amt02_AAE_approved_amt = @L2320_amt02_AAE_approved_amt,
				@L2320_amt02_AU_covered_amt = @L2320_amt02_AU_covered_amt,
				@L2320_amt02_B6_allowed_amt = @L2320_amt02_B6_allowed_amt,
				@L2320_amt02_D_payer_paid_amt = @L2320_amt02_D_payer_paid_amt,
				@L2320_amt02_D8_discount_amt = @L2320_amt02_D8_discount_amt,
				@L2320_amt02_DY_per_day_limit_amt = @L2320_amt02_DY_per_day_limit_amt,
				@L2320_amt02_F2_pt_responsibility_amt = @L2320_amt02_F2_pt_responsibility_amt,
				@L2320_amt02_F5_pt_paid_amt = @L2320_amt02_F5_pt_paid_amt,
				@L2320_amt02_T_tax_amt = @L2320_amt02_T_tax_amt,
				@L2320_amt02_T2_total_clm_before_tax_amt = @L2320_amt02_T2_total_clm_before_tax_amt,
				@L2320_cas01_adjustment_group_code = @L2320_cas01_adjustment_group_code,
				@L2320_cas02_adjustment_reason_code = @L2320_cas02_adjustment_reason_code,
				@L2320_cas03_adjustment_amt = @L2320_cas03_adjustment_amt,
				@L2320_cas04_adjustment_qty = @L2320_cas04_adjustment_qty,
				@L2320_cas05_adjustment_reason_code = @L2320_cas05_adjustment_reason_code,
				@L2320_cas06_adjustment_amt = @L2320_cas06_adjustment_amt,
				@L2320_cas07_adjustment_qty = @L2320_cas07_adjustment_qty,
				@L2320_cas08_adjustment_reason_code = @L2320_cas08_adjustment_reason_code,
				@L2320_cas09_adjustment_amt = @L2320_cas09_adjustment_amt,
				@L2320_cas10_adjustment_qty = @L2320_cas10_adjustment_qty,
				@L2320_dmg02_other_subscriber_dob = @L2320_dmg02_other_subscriber_dob,
				@L2320_dmg03_other_subscriber_gender = @L2320_dmg03_other_subscriber_gender,
				@L2320_oi03_other_ins_benefit_assign_ind = @L2320_oi03_other_ins_benefit_assign_ind,
				@L2320_oi04_other_ins_patient_signature_code = @L2320_oi04_other_ins_patient_signature_code,
				@L2320_oi06_other_ins_release_of_info_code = @L2320_oi06_other_ins_release_of_info_code,
				@L2320_sbr01_payer_resp_seq_code = @L2320_sbr01_payer_resp_seq_code,
				@L2320_sbr02_ind_relationship_code = @L2320_sbr02_ind_relationship_code,
				@L2320_sbr03_insured_grp_policy_num = @L2320_sbr03_insured_grp_policy_num,
				@L2320_sbr04_insured_grp_nm = @L2320_sbr04_insured_grp_nm,
				@L2320_sbr05_insurance_type_code = @L2320_sbr05_insurance_type_code,
				@L2320_sbr09_claim_filing_ind_code = @L2320_sbr09_claim_filing_ind_code,
				@L2330A_nm101_entity_id_code = @L2330A_nm101_entity_id_code,
				@L2330A_nm102_entity_type_qual = @L2330A_nm102_entity_type_qual,
				@L2330A_nm103_other_insured_last_name = @L2330A_nm103_other_insured_last_name,
				@L2330A_nm104_other_insured_first_name = @L2330A_nm104_other_insured_first_name,
				@L2330A_nm105_other_insured_middle_name = @L2330A_nm105_other_insured_middle_name,
				@L2330A_nm107_other_insured_name_suffix = @L2330A_nm107_other_insured_name_suffix,
				@L2330A_nm108_other_insured_id_code_qual = @L2330A_nm108_other_insured_id_code_qual,
				@L2330A_nm109_other_insured_id = @L2330A_nm109_other_insured_id,
				@L2330B_dtp03_573_date_claim_paid = @L2330B_dtp03_573_date_claim_paid,
				@L2330B_nm101_entity_id_code = @L2330B_nm101_entity_id_code,
				@L2330B_nm102_entity_type_qual = @L2330B_nm102_entity_type_qual,
				@L2330B_nm103_other_payer_nm = @L2330B_nm103_other_payer_nm,
				@L2330B_nm108_id_code_qual = @L2330B_nm108_id_code_qual,
				@L2330B_nm109_other_payer_id = @L2330B_nm109_other_payer_id,
				@L2330B_ref02_2U_other_payer_secondary_id = @L2330B_ref02_2U_other_payer_secondary_id,
				@L2330B_ref02_F8_other_payer_secondary_id = @L2330B_ref02_F8_other_payer_secondary_id,
				@L2330B_ref02_FY_other_payer_secondary_id = @L2330B_ref02_FY_other_payer_secondary_id,
				@L2330B_ref02_NF_other_payer_secondary_id = @L2330B_ref02_NF_other_payer_secondary_id,
				@L2330B_ref02_TJ_other_payer_secondary_id = @L2330B_ref02_TJ_other_payer_secondary_id,
				@L2400_dtp02_472_from_service_date = @L2400_dtp02_472_from_service_date,
				@L2400_dtp02_472_to_service_date = @L2400_dtp02_472_to_service_date,
				@L2400_lx01_assigned_num = @L2400_lx01_assigned_num,
				@L2400_nte01_note_ref_code = @L2400_nte01_note_ref_code,
				@L2400_nte02_line_note_text = @L2400_nte02_line_note_text,
				@L2400_ref02_6R_line_item_control_num = @L2400_ref02_6R_line_item_control_num,
				@L2400_sv101_proc_code = @L2400_sv101_proc_code,
				@L2400_sv101_proc_code_qual = @L2400_sv101_proc_code_qual,
				@L2400_sv101_proc_mod1 = @L2400_sv101_proc_mod1,
				@L2400_sv101_proc_mod2 = @L2400_sv101_proc_mod2,
				@L2400_sv101_proc_mod3 = @L2400_sv101_proc_mod3,
				@L2400_sv101_proc_mod4 = @L2400_sv101_proc_mod4,
				@L2400_sv102_line_charge = @L2400_sv102_line_charge,
				@L2400_sv103_measurement_code = @L2400_sv103_measurement_code,
				@L2400_sv104_service_unit_count = @L2400_sv104_service_unit_count,
				@L2400_sv105_place_of_service = @L2400_sv105_place_of_service,
				@L2400_sv107_dx_pointer1 = @L2400_sv107_dx_pointer1,
				@L2400_sv107_dx_pointer2 = @L2400_sv107_dx_pointer2,
				@L2400_sv107_dx_pointer3 = @L2400_sv107_dx_pointer3,
				@L2400_sv107_dx_pointer4 = @L2400_sv107_dx_pointer4,
				@L2400_sv109_emergency_indicator = @L2400_sv109_emergency_indicator,
				@L2400_sv111_epsdt_indicator = @L2400_sv111_epsdt_indicator,
				@L2400_sv112_family_plan_indicator = @L2400_sv112_family_plan_indicator,
				@L2400_sv115_copay_status_code = @L2400_sv115_copay_status_code,
				@L2410_1_lin03_N4_ndc = @L2410_1_lin03_N4_ndc,
				@L2420A_nm102_entity_type_qual = @L2420A_nm102_entity_type_qual,
				@L2420A_nm103_rendering_prov_last_nm = @L2420A_nm103_rendering_prov_last_nm,
				@L2420A_nm104_rendering_prov_first_nm = @L2420A_nm104_rendering_prov_first_nm,
				@L2420A_nm105_rendering_prov_middle_nm = @L2420A_nm105_rendering_prov_middle_nm,
				@L2420A_nm107_rendering_prov_suffix = @L2420A_nm107_rendering_prov_suffix,
				@L2420A_nm108_id_code_qual = @L2420A_nm108_id_code_qual,
				@L2420A_nm109_rendering_prov_id = @L2420A_nm109_rendering_prov_id,
				@L2420A_prv01_provider_code = @L2420A_prv01_provider_code,
				@L2420A_prv02_ref_id_qual = @L2420A_prv02_ref_id_qual,
				@L2420A_prv03_taxonomy_code = @L2420A_prv03_taxonomy_code,
				@L2420A_ref02_1C_rendering_prov_id = @L2420A_ref02_1C_rendering_prov_id,
				@L2420A_ref02_1D_rendering_prov_id = @L2420A_ref02_1D_rendering_prov_id,
				@L2420A_ref02_1G_rendering_prov_id = @L2420A_ref02_1G_rendering_prov_id,
				@L2420A_ref02_EI_rendering_prov_id = @L2420A_ref02_EI_rendering_prov_id,
				@L2420A_ref02_FH_rendering_prov_id = @L2420A_ref02_FH_rendering_prov_id,
				@L2420A_ref02_SY_rendering_prov_id = @L2420A_ref02_SY_rendering_prov_id,
				@L2420C_n301_service_facility_address1 = @L2420C_n301_service_facility_address1,
				@L2420C_n302_service_facility_address2 = @L2420C_n302_service_facility_address2,
				@L2420C_n401_service_facility_city = @L2420C_n401_service_facility_city,
				@L2420C_n402_service_facility_state = @L2420C_n402_service_facility_state,
				@L2420C_n403_service_facility_zip = @L2420C_n403_service_facility_zip,
				@L2420C_n404_service_facility_country = @L2420C_n404_service_facility_country,
				@L2420C_nm101_entity_id_code = @L2420C_nm101_entity_id_code,
				@L2420C_nm102_entity_type_qual = @L2420C_nm102_entity_type_qual,
				@L2420C_nm103_service_facility_last_nm = @L2420C_nm103_service_facility_last_nm,
				@L2420C_nm108_id_code_qual = @L2420C_nm108_id_code_qual,
				@L2420C_nm109_service_facility_id = @L2420C_nm109_service_facility_id,
				@L2420C_ref02_1C_service_facility_id = @L2420C_ref02_1C_service_facility_id,
				@L2420C_ref02_1D_service_facility_id = @L2420C_ref02_1D_service_facility_id,
				@L2420C_ref02_1G_service_facility_id = @L2420C_ref02_1G_service_facility_id,
				@L2420C_ref02_G2_service_facility_id = @L2420C_ref02_G2_service_facility_id,
				@L2420C_ref02_TJ_service_facility_id = @L2420C_ref02_TJ_service_facility_id,
				@L2420D_nm102_entity_type_qual = @L2420D_nm102_entity_type_qual,
				@L2420D_nm103_supervising_prov_last_nm = @L2420D_nm103_supervising_prov_last_nm,
				@L2420D_nm104_supervising_prov_first_nm = @L2420D_nm104_supervising_prov_first_nm,
				@L2420D_nm105_supervising_prov_middle_nm = @L2420D_nm105_supervising_prov_middle_nm,
				@L2420D_nm107_supervising_prov_suffix = @L2420D_nm107_supervising_prov_suffix,
				@L2420D_nm108_id_code_qual = @L2420D_nm108_id_code_qual,
				@L2420D_nm109_supervising_prov_id = @L2420D_nm109_supervising_prov_id,
				@L2420F_nm101_entity_id_code = @L2420F_nm101_entity_id_code,
				@L2420F_nm102_entity_type_qual = @L2420F_nm102_entity_type_qual,
				@L2420F_nm103_referring_prov_last_nm = @L2420F_nm103_referring_prov_last_nm,
				@L2420F_nm104_referring_prov_first_nm = @L2420F_nm104_referring_prov_first_nm,
				@L2420F_nm105_referring_prov_middle_nm = @L2420F_nm105_referring_prov_middle_nm,
				@L2420F_nm107_referring_prov_suffix = @L2420F_nm107_referring_prov_suffix,
				@L2420F_nm108_id_code_qual = @L2420F_nm108_id_code_qual,
				@L2420F_nm109_referring_prov_id = @L2420F_nm109_referring_prov_id,
				@L2420F_prv01_provider_code = @L2420F_prv01_provider_code,
				@L2420F_prv02_ref_id_qual = @L2420F_prv02_ref_id_qual,
				@L2420F_prv03_taxonomy_code = @L2420F_prv03_taxonomy_code,
				@L2420F_ref02_1C_referring_prov_id = @L2420F_ref02_1C_referring_prov_id,
				@L2420F_ref02_1D_referring_prov_id = @L2420F_ref02_1D_referring_prov_id,
				@L2420F_ref02_1G_referring_prov_id = @L2420F_ref02_1G_referring_prov_id,
				@L2420F_ref02_EI_referring_prov_id = @L2420F_ref02_EI_referring_prov_id,
				@L2420F_ref02_FH_referring_prov_id = @L2420F_ref02_FH_referring_prov_id,
				@L2420F_ref02_SY_referring_prov_id = @L2420F_ref02_SY_referring_prov_id,
				@L2430_cas01_adjustment_group_code = @L2430_cas01_adjustment_group_code,
				@L2430_cas02_adjustment_reason_code = @L2430_cas02_adjustment_reason_code,
				@L2430_cas03_adjustment_amt = @L2430_cas03_adjustment_amt,
				@L2430_cas04_adjustment_qty = @L2430_cas04_adjustment_qty,
				@L2430_cas05_adjustment_reason_code = @L2430_cas05_adjustment_reason_code,
				@L2430_cas06_adjustment_amt = @L2430_cas06_adjustment_amt,
				@L2430_cas07_adjustment_qty = @L2430_cas07_adjustment_qty,
				@L2430_cas08_adjustment_reason_code = @L2430_cas08_adjustment_reason_code,
				@L2430_cas09_adjustment_amt = @L2430_cas09_adjustment_amt,
				@L2430_cas10_adjustment_qty = @L2430_cas10_adjustment_qty,
				@L2430_dtp03_573_date_claim_paid = @L2430_dtp03_573_date_claim_paid,
				@L2430_svd01_other_payer_id = @L2430_svd01_other_payer_id,
				@L2430_svd02_service_line_paid = @L2430_svd02_service_line_paid,
				@ref01_receiver_ref_id_qual = @ref01_receiver_ref_id_qual,
				@ref02_transmission_type_code = @ref02_transmission_type_code,
				@x12_transaction_id = @x12_transaction_id	
			
			
			
			-- reset the claim level values
			select	@L2300_clm01_pt_acct_num = null,
				@L2300_clm02_total_claim_chg_amt = null, 
				@L2300_clm05_facility_type_code = null, 
				@L2300_clm05_claim_freq_code = null, 
				@L2300_clm06_provider_signature_ind = null, 
				@L2300_clm07_medicare_assign_code = null, 
				@L2300_clm08_benefit_assign_ind = null, 
				@L2300_clm09_release_of_info_code = null, 
				@L2300_clm10_patient_signature_code = null, 
				@L2300_clm11_related_causes_code1 = null, 
				@L2300_clm11_related_causes_code2 = null, 
				@L2300_clm11_related_causes_code3 = null, 
				@L2300_clm11_auto_accident_state_code = null, 
				@L2300_clm11_country_code = null, 
				@L2300_clm12_special_prog_ind = null, 
				@L2300_clm16_participation_agreement = null, 
				@L2300_clm20_delay_reason_code = null, 
				@L2300_dtp03_454_initial_tmt_date = null, 
				@L2300_dtp03_304_last_seen_date = null, 
				@L2300_dtp03_431_onset_of_injury_date = null, 
				@L2300_dtp03_453_acute_manifestation_date = null, 
				@L2300_dtp03_438_symptom_date = null, 
				@L2300_dtp03_439_accident_date = null, 
				@L2300_dtp03_484_last_menstrual_period_date = null, 
				@L2300_dtp03_455_last_xray_date = null, 
				@L2300_dtp03_471_prescription_date = null, 
				@L2300_dtp03_360_disability_begin_date = null, 
				@L2300_dtp03_361_disability_end_date = null, 
				@L2300_dtp03_297_last_worked_date = null, 
				@L2300_dtp03_296_work_return_date = null, 
				@L2300_dtp03_435_admission_date = null, 
				@L2300_dtp03_096_discharge_date = null, 
				@L2300_dtp03_090_assumed_care_date = null, 
				@L2300_dtp03_091_relinquished_care_date = null, 
				@L2300_pwk01_attachment_type_code = null, 
				@L2300_pwk02_attachment_trans_code = null, 
				@L2300_pwk06_attachment_control_num = null, 
				@L2300_amt02_patient_paid_amt = null, 
				@L2300_amt02_total_purchased_amt = null, 
				@L2300_ref02_9F_prior_auth_num = null, 
				@L2300_ref02_G1_referral_num = null, 
				@L2300_ref02_F8_original_ref_num = null, 
				@L2300_ref02_9A_repriced_claim_num = null, 
				@L2300_ref02_9C_adj_repriced_claim_num = null, 
				@L2300_ref02_EA_medical_record_num = null, 
				@L2300_k301_fixed_format_info = null, 
				@L2300_nte01_note_ref_code = null, 
				@L2300_nte02_claim_note_text = null, 
				@L2300_hi01_diag_code = null, 
				@L2300_hi02_diag_code = null, 
				@L2300_hi03_diag_code = null, 
				@L2300_hi04_diag_code = null, 
				@L2300_hi05_diag_code = null, 
				@L2300_hi06_diag_code = null, 
				@L2300_hi07_diag_code = null, 
				@L2300_hi08_diag_code = null, 
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
				@L2310A_ref02_1G_referring_prov_id = null, 
				@L2310A_ref02_EI_referring_prov_id = null, 
				@L2310A_ref02_SY_referring_prov_id = null, 
				@L2310A_ref02_FH_referring_prov_id = null, 
				@L2310A_ref02_G2_referring_prov_id = null,
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
				@L2310B_ref02_1G_rendering_prov_id = null, 
				@L2310B_ref02_EI_rendering_prov_id = null, 
				@L2310B_ref02_SY_rendering_prov_id = null, 
				@L2310B_ref02_FH_rendering_prov_id = null,
				@L2310B_ref02_G2_rendering_prov_id = null,
				@L2310D_nm101_entity_id_code = null, 
				@L2310D_nm102_entity_type_qual = null, 
				@L2310D_nm103_service_facility_last_nm = null, 
				@L2310D_nm108_id_code_qual = null, 
				@L2310D_nm109_service_facility_id = null, 
				@L2310D_n301_service_facility_address1 = null, 
				@L2310D_n302_service_facility_address2 = null, 
				@L2310D_n401_service_facility_city = null, 
				@L2310D_n402_service_facility_state = null, 
				@L2310D_n403_service_facility_zip = null, 
				@L2310D_n404_service_facility_country = null, 
				@L2310D_ref02_1C_service_facility_id = null, 
				@L2310D_ref02_1D_service_facility_id = null, 
				@L2310D_ref02_1G_service_facility_id = null, 
				@L2310D_ref02_G2_service_facility_id = null, 
				@L2310D_ref02_TJ_service_facility_id = null, 
				@L2310E_nm102_entity_type_qual = null, 
				@L2310E_nm103_supervising_prov_last_nm = null, 
				@L2310E_nm104_supervising_prov_first_nm = null, 
				@L2310E_nm105_supervising_prov_middle_nm = null, 
				@L2310E_nm107_supervising_prov_suffix = null, 
				@L2310E_nm108_id_code_qual = null, 
				@L2310E_nm109_supervising_prov_id = null, 
				@L2320_sbr01_payer_resp_seq_code = null,
				@L2320_sbr02_ind_relationship_code = null,
				@L2320_sbr03_insured_grp_policy_num = null,
				@L2320_sbr04_insured_grp_nm = null,
				@L2320_sbr05_insurance_type_code = null,
				@L2320_sbr09_claim_filing_ind_code = null,
				@L2320_cas01_adjustment_group_code = null,
				@L2320_cas02_adjustment_reason_code = null,
				@L2320_cas03_adjustment_amt = null,
				@L2320_cas04_adjustment_qty = null,
				@L2320_cas05_adjustment_reason_code = null,
				@L2320_cas06_adjustment_amt = null,
				@L2320_cas07_adjustment_qty = null,
				@L2320_cas08_adjustment_reason_code = null,
				@L2320_cas09_adjustment_amt = null,
				@L2320_cas10_adjustment_qty = null,
				@L2320_amt02_D_payer_paid_amt = null,
				@L2320_amt02_AAE_approved_amt = null,
				@L2320_amt02_B6_allowed_amt = null,
				@L2320_amt02_F2_pt_responsibility_amt = null,
				@L2320_amt02_AU_covered_amt = null,
				@L2320_amt02_D8_discount_amt = null,
				@L2320_amt02_DY_per_day_limit_amt = null,
				@L2320_amt02_F5_pt_paid_amt = null,
				@L2320_amt02_T_tax_amt = null,
				@L2320_amt02_T2_total_clm_before_tax_amt = null,
				@L2320_dmg02_other_subscriber_dob = null,
				@L2320_dmg03_other_subscriber_gender = null,
				@L2320_oi03_other_ins_benefit_assign_ind = null,
				@L2320_oi04_other_ins_patient_signature_code = null,
				@L2320_oi06_other_ins_release_of_info_code = null,
				@L2330A_nm101_entity_id_code = null,
				@L2330A_nm102_entity_type_qual = null,
				@L2330A_nm103_other_insured_last_name = null,
				@L2330A_nm104_other_insured_first_name = null,
				@L2330A_nm105_other_insured_middle_name = null,
				@L2330A_nm107_other_insured_name_suffix = null,
				@L2330A_nm108_other_insured_id_code_qual = null,
				@L2330A_nm109_other_insured_id = null,
				@L2330B_nm101_entity_id_code = null,
				@L2330B_nm102_entity_type_qual = null,
				@L2330B_nm103_other_payer_nm = null,
				@L2330B_nm108_id_code_qual = null,
				@L2330B_nm109_other_payer_id = null,
				@L2330B_dtp03_573_date_claim_paid = null,
				@L2330B_ref02_2U_other_payer_secondary_id = null,
				@L2330B_ref02_F8_other_payer_secondary_id = null,
				@L2330B_ref02_FY_other_payer_secondary_id = null,
				@L2330B_ref02_NF_other_payer_secondary_id = null,
				@L2330B_ref02_TJ_other_payer_secondary_id = null,
				@L2400_lx01_assigned_num = null, 
				@L2400_sv101_proc_code_qual = null, 
				@L2400_sv101_proc_code = null, 
				@L2400_sv101_proc_mod1 = null, 
				@L2400_sv101_proc_mod2 = null, 
				@L2400_sv101_proc_mod3 = null, 
				@L2400_sv101_proc_mod4 = null, 
				@L2400_sv102_line_charge = null, 
				@L2400_sv103_measurement_code = null, 
				@L2400_sv104_service_unit_count = null, 
				@L2400_sv105_place_of_service = null, 
				@L2400_sv107_dx_pointer1 = null, 
				@L2400_sv107_dx_pointer2 = null, 
				@L2400_sv107_dx_pointer3 = null, 
				@L2400_sv107_dx_pointer4 = null, 
				@L2400_sv109_emergency_indicator = null, 
				@L2400_sv111_epsdt_indicator = null, 
				@L2400_sv112_family_plan_indicator = null, 
				@L2400_sv115_copay_status_code = null, 
				@L2400_dtp02_472_from_service_date = null, 
				@L2400_dtp02_472_to_service_date = null, 
				@L2400_ref02_6R_line_item_control_num = null, 
				@L2400_nte01_note_ref_code = null, 
				@L2400_nte02_line_note_text = null, 
				@L2410_1_lin03_N4_ndc = NULL,
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
				@L2420A_ref02_1G_rendering_prov_id = null, 
				@L2420A_ref02_EI_rendering_prov_id = null, 
				@L2420A_ref02_SY_rendering_prov_id = null, 
				@L2420A_ref02_FH_rendering_prov_id = null, 
				@L2420C_nm101_entity_id_code = null, 
				@L2420C_nm102_entity_type_qual = null, 
				@L2420C_nm103_service_facility_last_nm = null, 
				@L2420C_nm108_id_code_qual = null, 
				@L2420C_nm109_service_facility_id = null, 
				@L2420C_n301_service_facility_address1 = null, 
				@L2420C_n302_service_facility_address2 = null, 
				@L2420C_n401_service_facility_city = null, 
				@L2420C_n402_service_facility_state = null, 
				@L2420C_n403_service_facility_zip = null, 
				@L2420C_n404_service_facility_country = null, 
				@L2420C_ref02_1C_service_facility_id = null, 
				@L2420C_ref02_1D_service_facility_id = null, 
				@L2420C_ref02_1G_service_facility_id = null, 
				@L2420C_ref02_G2_service_facility_id = null, 
				@L2420C_ref02_TJ_service_facility_id = null, 
				@L2420D_nm102_entity_type_qual = null, 
				@L2420D_nm103_supervising_prov_last_nm = null, 
				@L2420D_nm104_supervising_prov_first_nm = null, 
				@L2420D_nm105_supervising_prov_middle_nm = null, 
				@L2420D_nm107_supervising_prov_suffix = null, 
				@L2420D_nm108_id_code_qual = null, 
				@L2420D_nm109_supervising_prov_id = null, 
				@L2420F_nm101_entity_id_code = null, 
				@L2420F_nm102_entity_type_qual = null,
				@L2420F_nm103_referring_prov_last_nm = null, 
				@L2420F_nm104_referring_prov_first_nm = null, 
				@L2420F_nm105_referring_prov_middle_nm = null, 
				@L2420F_nm107_referring_prov_suffix = null, 
				@L2420F_nm108_id_code_qual = null, 
				@L2420F_nm109_referring_prov_id = null, 
				@L2420F_prv01_provider_code = null, 
				@L2420F_prv02_ref_id_qual = null, 
				@L2420F_prv03_taxonomy_code = null, 
				@L2420F_ref02_1C_referring_prov_id = null, 
				@L2420F_ref02_1D_referring_prov_id = null, 
				@L2420F_ref02_1G_referring_prov_id = null, 
				@L2420F_ref02_EI_referring_prov_id = null, 
				@L2420F_ref02_SY_referring_prov_id = null, 
				@L2420F_ref02_FH_referring_prov_id = null,
				@L2430_svd01_other_payer_id = null,
				@L2430_svd02_service_line_paid = null,
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
			select	@L2010AB_nm102_entity_type_qual= null,
					@L2010AB_nm103_payto_prov_last_nm = null,
					@L2010AB_nm104_payto_prov_first_nm = null,
					@L2010AB_nm105_payto_prov_middle_nm = null,
					@L2010AB_nm107_payto_prov_suffix = null,
					@L2010AB_nm108_id_code_qual = null,
					@L2010AB_nm109_payto_prov_id = null,
					@L2010AB_n301_payto_prov_address1 = null,
					@L2010AB_n302_payto_prov_address2= null,
					@L2010AB_n401_payto_prov_city = null,
					@L2010AB_n402_payto_prov_state= null,
					@L2010AB_n403_payto_prov_zip = null,
					@L2010AB_n404_payto_prov_country = null,
					@L2010AB_ref02_1C_payto_prov_id= null,
					@L2010AB_ref02_1D_payto_prov_id= null,
					@L2010AB_ref02_1G_payto_prov_id= null,
					@L2010AB_ref02_EI_payto_prov_id= null,
					@L2010AB_ref02_SY_payto_prov_id= null,
					@L2010AB_ref02_FH_payto_prov_id= null

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
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = '1G' )
		set @L2010AA_ref02_1G_billing_prov_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = 'EI' )
		set @L2010AA_ref02_EI_billing_prov_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = 'SY' )
		set @L2010AA_ref02_SY_billing_prov_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AA' AND LTRIM(RTRIM(@Col002)) = 'FH' )
		set @L2010AA_ref02_FH_billing_prov_id = LTRIM(RTRIM(@Col003))
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
	-- Billing/Pay-To Provider Loop: Contact Info
	if ( RTrim(@col001) = 'PER' AND @curLoop = '2010AA')
	begin
		select	@L2010AA_per01_billing_prov_comm_func_code = LTRIM(RTRIM(@Col002)),
			@L2010AA_per02_billing_prov_contact_nm = LTRIM(RTRIM(@Col003)),
			@L2010AA_per03_billing_prov_comm_num_qual = LTRIM(RTRIM(@Col004)),
			@L2010AA_per04_billing_prov_comm = LTRIM(RTRIM(@Col005))
	end
		
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
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AB' AND LTRIM(RTRIM(@Col002)) = '1G' )
		set @L2010AB_ref02_1G_payto_prov_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AB' AND LTRIM(RTRIM(@Col002)) = 'EI' )
		set @L2010AB_ref02_EI_payto_prov_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AB' AND LTRIM(RTRIM(@Col002)) = 'SY' )
		set @L2010AB_ref02_SY_payto_prov_id = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010AB' AND LTRIM(RTRIM(@Col002)) = 'FH' )
		set @L2010AB_ref02_FH_payto_prov_id = LTRIM(RTRIM(@Col003))
		
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
			@L2000B_sbr05_insurance_type_code = LTRIM(RTRIM(@Col006)),
			@L2000B_sbr09_claim_filing_ind_code = LTRIM(RTRIM(@Col010)),
			-- Reset all the subscriber-level variables
			@L2000B_pat06_insured_ind_death_date = null,
			@L2000B_pat08_patient_weight = null,
			@L2000B_pat09_pregnancy_indicator = null,
	
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
	
			@L2010BC_n301_resp_party_address1 = null,
			@L2010BC_n302_resp_party_address2 = null,
	
			@L2010BC_n401_resp_party_city = null,
			@L2010BC_n402_resp_party_state = null,
			@L2010BC_n403_resp_party_zip = null,
			@L2010BC_n404_resp_party_country = null,
	
			@L2010BD_nm102_entity_type_qual = null,
			@L2010BD_nm103_card_holder_last_nm = null,
			@L2010BD_nm104_card_holder_first_nm = null,
			@L2010BD_nm105_card_holder_middle_nm = null,
			@L2010BD_nm107_card_holder_suffix = null,
			@L2010BD_nm108_card_id_qual = null,
			@L2010BD_nm109_card_num = null,
	
			@L2010BD_ref02_AB_card_num = null,
			@L2010BD_ref02_BB_card_num = null,
	
			-- Patient-level variables
			@L2000C_hl01_hierarchical_id_num = null,
			@L2000C_hl02_hierarchical_parent_id_num = null,
			@L2000C_hl03_hierarchical_level_code = null,
			@L2000C_hl04_hierarchical_child_code = null,
	
			@L2000C_pat01_ind_relationship_code = null,
			@L2000C_pat06_insured_ind_death_date = null,
			@L2000C_pat08_patient_weight = null,
			@L2000C_pat09_pregnancy_indicator = null,
	
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
		
	if ( RTrim(@col001) = 'PAT' AND @curLoop = '2000B')
	begin
		select	@L2000B_pat06_insured_ind_death_date = LTRIM(RTRIM(@Col007)),
			@L2000B_pat08_patient_weight = LTRIM(RTRIM(@Col009)),
			@L2000B_pat09_pregnancy_indicator = LTRIM(RTRIM(@Col010))
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
		
	if ( RTrim(@col001) = 'NM1' AND LTRIM(RTRIM(@Col002)) = 'QD')
	begin
		select	@curLoop = '2010BC',
			@L2010BC_nm102_entity_type_qual = LTRIM(RTRIM(@Col003)),
			@L2010BC_nm103_resp_party_last_nm = LTRIM(RTRIM(@Col004)),
			@L2010BC_nm104_resp_party_first_nm = LTRIM(RTRIM(@Col005)),
			@L2010BC_nm105_resp_party_middle_nm = LTRIM(RTRIM(@Col006)),
			@L2010BC_nm107_resp_party_suffix = LTRIM(RTRIM(@Col008))
	end		
	if ( RTrim(@col001) = 'N3' AND @curLoop = '2010BC')
	begin
		select	@L2010BC_n301_resp_party_address1 = LTRIM(RTRIM(@Col002)),
			@L2010BC_n302_resp_party_address2 = LTRIM(RTRIM(@Col003))
	end
		
	if ( RTrim(@col001) = 'N4' AND @curLoop = '2010BC')
	begin
		select	@L2010BC_n401_resp_party_city = LTRIM(RTRIM(@Col002)),
			@L2010BC_n402_resp_party_state = LTRIM(RTRIM(@Col003)),
			@L2010BC_n403_resp_party_zip = LTRIM(RTRIM(@Col004)),
			@L2010BC_n404_resp_party_country = LTRIM(RTRIM(@Col005))
	end
		
	if ( RTrim(@col001) = 'NM1' AND LTRIM(RTRIM(@Col002)) = 'AO')
	begin
		select	@curLoop = '2010BD',
			@L2010BD_nm102_entity_type_qual = LTRIM(RTRIM(@Col003)),
			@L2010BD_nm103_card_holder_last_nm = LTRIM(RTRIM(@Col004)),
			@L2010BD_nm104_card_holder_first_nm = LTRIM(RTRIM(@Col005)),
			@L2010BD_nm105_card_holder_middle_nm = LTRIM(RTRIM(@Col006)),
			@L2010BD_nm107_card_holder_suffix = LTRIM(RTRIM(@Col008)),
			@L2010BD_nm108_card_id_qual = LTRIM(RTRIM(@Col009)),
			@L2010BD_nm109_card_num = LTRIM(RTRIM(@Col010))
	end
		
	-- Credit Card Loop: Card Numbers
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010BD' AND LTRIM(RTRIM(@Col002)) = 'AB' )
		set @L2010BD_ref02_AB_card_num = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2010BD' AND LTRIM(RTRIM(@Col002)) = 'BB' )
		set @L2010BD_ref02_BB_card_num = LTRIM(RTRIM(@Col003))
		
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
			@L2000C_pat06_insured_ind_death_date = LTRIM(RTRIM(@Col007)),
			@L2000C_pat08_patient_weight = LTRIM(RTRIM(@Col009)),
			@L2000C_pat09_pregnancy_indicator = LTRIM(RTRIM(@Col010)),
	
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
		if (@L2400_sv101_proc_code IS NOT NULL AND @L2400_lx01_assigned_num IS NOT NULL)
		begin
							
			EXEC dbo.up_x12_837p_insert 
				@bht01_hierarchical_structure_code = @bht01_hierarchical_structure_code,
				@bht02_trans_set_purpose_code = @bht02_trans_set_purpose_code,
				@bht03_orig_app_tran_id = @bht03_orig_app_tran_id,
				@bht04_trans_set_creation_date = @bht04_trans_set_creation_date,
				@bht05_trans_set_creation_time = @bht05_trans_set_creation_time,
				@bht06_claim_encounter_id = @bht06_claim_encounter_id,
				@L1000A_nm102_entity_type_qual = @L1000A_nm102_entity_type_qual,
				@L1000A_nm103_submitter_last_nm = @L1000A_nm103_submitter_last_nm,
				@L1000A_nm104_submitter_first_nm = @L1000A_nm104_submitter_first_nm,
				@L1000A_nm105_submitter_middle_nm = @L1000A_nm105_submitter_middle_nm,
				@L1000A_nm108_submitter_id_qual = @L1000A_nm108_submitter_id_qual,
				@L1000A_nm109_submitter_id = @L1000A_nm109_submitter_id,
				@L1000A_per01_contact_function_code = @L1000A_per01_contact_function_code,
				@L1000A_per02_contact_nm = @L1000A_per02_contact_nm,
				@L1000A_per03_comm_num_qual = @L1000A_per03_comm_num_qual,
				@L1000A_per04_comm_number = @L1000A_per04_comm_number,
				@L1000B_nm102_entity_type_qual = @L1000B_nm102_entity_type_qual,
				@L1000B_nm103_receiver_last_nm = @L1000B_nm103_receiver_last_nm,
				@L1000B_nm108_receiver_id_qual = @L1000B_nm108_receiver_id_qual,
				@L1000B_nm109_receiver_id = @L1000B_nm109_receiver_id,
				@L2000A_cur02_currency_code = @L2000A_cur02_currency_code,
				@L2000A_hl01_hierarchical_id_num = @L2000A_hl01_hierarchical_id_num,
				@L2000A_hl03_hierarchical_level_code = @L2000A_hl03_hierarchical_level_code,
				@L2000A_hl04_hierarchical_child_code = @L2000A_hl04_hierarchical_child_code,
				@L2000A_prv01_provider_code = @L2000A_prv01_provider_code,
				@L2000A_prv02_ref_id_qual = @L2000A_prv02_ref_id_qual,
				@L2000A_prv03_taxonomy_code = @L2000A_prv03_taxonomy_code,
				@L2000B_hl01_hierarchical_id_num = @L2000B_hl01_hierarchical_id_num,
				@L2000B_hl02_hierarchical_parent_id_num = @L2000B_hl02_hierarchical_parent_id_num,
				@L2000B_hl03_hierarchical_level_code = @L2000B_hl03_hierarchical_level_code,
				@L2000B_hl04_hierarchical_child_code = @L2000B_hl04_hierarchical_child_code,
				@L2000B_pat06_insured_ind_death_date = @L2000B_pat06_insured_ind_death_date,
				@L2000B_pat08_patient_weight = @L2000B_pat08_patient_weight,
				@L2000B_pat09_pregnancy_indicator = @L2000B_pat09_pregnancy_indicator,
				@L2000B_sbr01_payer_resp_seq_code = @L2000B_sbr01_payer_resp_seq_code,
				@L2000B_sbr02_ind_relationship_code = @L2000B_sbr02_ind_relationship_code,
				@L2000B_sbr03_insured_grp_policy_num = @L2000B_sbr03_insured_grp_policy_num,
				@L2000B_sbr04_insured_grp_nm = @L2000B_sbr04_insured_grp_nm,
				@L2000B_sbr05_insurance_type_code = @L2000B_sbr05_insurance_type_code,
				@L2000B_sbr09_claim_filing_ind_code = @L2000B_sbr09_claim_filing_ind_code,
				@L2000C_hl01_hierarchical_id_num = @L2000C_hl01_hierarchical_id_num,
				@L2000C_hl02_hierarchical_parent_id_num = @L2000C_hl02_hierarchical_parent_id_num,
				@L2000C_hl03_hierarchical_level_code = @L2000C_hl03_hierarchical_level_code,
				@L2000C_hl04_hierarchical_child_code = @L2000C_hl04_hierarchical_child_code,
				@L2000C_pat01_ind_relationship_code = @L2000C_pat01_ind_relationship_code,
				@L2000C_pat06_insured_ind_death_date = @L2000C_pat06_insured_ind_death_date,
				@L2000C_pat08_patient_weight = @L2000C_pat08_patient_weight,
				@L2000C_pat09_pregnancy_indicator = @L2000C_pat09_pregnancy_indicator,
				@L2010AA_n301_billing_prov_address1 = @L2010AA_n301_billing_prov_address1,
				@L2010AA_n302_billing_prov_address2 = @L2010AA_n302_billing_prov_address2,
				@L2010AA_n401_billing_prov_city = @L2010AA_n401_billing_prov_city,
				@L2010AA_n402_billing_prov_state = @L2010AA_n402_billing_prov_state,
				@L2010AA_n403_billing_prov_zip = @L2010AA_n403_billing_prov_zip,
				@L2010AA_n404_billing_prov_country = @L2010AA_n404_billing_prov_country,
				@L2010AA_nm102_entity_type_qual = @L2010AA_nm102_entity_type_qual,
				@L2010AA_nm103_billing_prov_last_nm = @L2010AA_nm103_billing_prov_last_nm,
				@L2010AA_nm104_billing_prov_first_nm = @L2010AA_nm104_billing_prov_first_nm,
				@L2010AA_nm105_billing_prov_middle_nm = @L2010AA_nm105_billing_prov_middle_nm,
				@L2010AA_nm107_billing_prov_suffix = @L2010AA_nm107_billing_prov_suffix,
				@L2010AA_nm108_id_code_qual = @L2010AA_nm108_id_code_qual,
				@L2010AA_nm109_billing_prov_id = @L2010AA_nm109_billing_prov_id,
				@L2010AA_per01_billing_prov_comm_func_code = @L2010AA_per01_billing_prov_comm_func_code,
				@L2010AA_per02_billing_prov_contact_nm = @L2010AA_per02_billing_prov_contact_nm,
				@L2010AA_per03_billing_prov_comm_num_qual = @L2010AA_per03_billing_prov_comm_num_qual,
				@L2010AA_per04_billing_prov_comm = @L2010AA_per04_billing_prov_comm,
				@L2010AA_ref02_06_card_billing_id = @L2010AA_ref02_06_card_billing_id,
				@L2010AA_ref02_1C_billing_prov_id = @L2010AA_ref02_1C_billing_prov_id,
				@L2010AA_ref02_1D_billing_prov_id = @L2010AA_ref02_1D_billing_prov_id,
				@L2010AA_ref02_1G_billing_prov_id = @L2010AA_ref02_1G_billing_prov_id,
				@L2010AA_ref02_8U_card_billing_id = @L2010AA_ref02_8U_card_billing_id,
				@L2010AA_ref02_EI_billing_prov_id = @L2010AA_ref02_EI_billing_prov_id,
				@L2010AA_ref02_EM_card_billing_id = @L2010AA_ref02_EM_card_billing_id,
				@L2010AA_ref02_FH_billing_prov_id = @L2010AA_ref02_FH_billing_prov_id,
				@L2010AA_ref02_IJ_card_billing_id = @L2010AA_ref02_IJ_card_billing_id,
				@L2010AA_ref02_LU_card_billing_id = @L2010AA_ref02_LU_card_billing_id,
				@L2010AA_ref02_ST_card_billing_id = @L2010AA_ref02_ST_card_billing_id,
				@L2010AA_ref02_SY_billing_prov_id = @L2010AA_ref02_SY_billing_prov_id,
				@L2010AB_n301_payto_prov_address1 = @L2010AB_n301_payto_prov_address1,
				@L2010AB_n302_payto_prov_address2 = @L2010AB_n302_payto_prov_address2,
				@L2010AB_n401_payto_prov_city = @L2010AB_n401_payto_prov_city,
				@L2010AB_n402_payto_prov_state = @L2010AB_n402_payto_prov_state,
				@L2010AB_n403_payto_prov_zip = @L2010AB_n403_payto_prov_zip,
				@L2010AB_n404_payto_prov_country = @L2010AB_n404_payto_prov_country,
				@L2010AB_nm102_entity_type_qual = @L2010AB_nm102_entity_type_qual,
				@L2010AB_nm103_payto_prov_last_nm = @L2010AB_nm103_payto_prov_last_nm,
				@L2010AB_nm104_payto_prov_first_nm = @L2010AB_nm104_payto_prov_first_nm,
				@L2010AB_nm105_payto_prov_middle_nm = @L2010AB_nm105_payto_prov_middle_nm,
				@L2010AB_nm107_payto_prov_suffix = @L2010AB_nm107_payto_prov_suffix,
				@L2010AB_nm108_id_code_qual = @L2010AB_nm108_id_code_qual,
				@L2010AB_nm109_payto_prov_id = @L2010AB_nm109_payto_prov_id,
				@L2010AB_ref02_1C_payto_prov_id = @L2010AB_ref02_1C_payto_prov_id,
				@L2010AB_ref02_1D_payto_prov_id = @L2010AB_ref02_1D_payto_prov_id,
				@L2010AB_ref02_1G_payto_prov_id = @L2010AB_ref02_1G_payto_prov_id,
				@L2010AB_ref02_EI_payto_prov_id = @L2010AB_ref02_EI_payto_prov_id,
				@L2010AB_ref02_FH_payto_prov_id = @L2010AB_ref02_FH_payto_prov_id,
				@L2010AB_ref02_SY_payto_prov_id = @L2010AB_ref02_SY_payto_prov_id,
				@L2010BA_dmg02_subscriber_dob = @L2010BA_dmg02_subscriber_dob,
				@L2010BA_dmg03_subscriber_gender = @L2010BA_dmg03_subscriber_gender,
				@L2010BA_n301_subscriber_address1 = @L2010BA_n301_subscriber_address1,
				@L2010BA_n302_subscriber_address2 = @L2010BA_n302_subscriber_address2,
				@L2010BA_n401_subscriber_city = @L2010BA_n401_subscriber_city,
				@L2010BA_n402_subscriber_state = @L2010BA_n402_subscriber_state,
				@L2010BA_n403_subscriber_zip = @L2010BA_n403_subscriber_zip,
				@L2010BA_n404_subscriber_country = @L2010BA_n404_subscriber_country,
				@L2010BA_nm102_entity_type_qual = @L2010BA_nm102_entity_type_qual,
				@L2010BA_nm103_subscriber_last_nm = @L2010BA_nm103_subscriber_last_nm,
				@L2010BA_nm104_subscriber_first_nm = @L2010BA_nm104_subscriber_first_nm,
				@L2010BA_nm105_subscriber_middle_nm = @L2010BA_nm105_subscriber_middle_nm,
				@L2010BA_nm107_subscriber_suffix = @L2010BA_nm107_subscriber_suffix,
				@L2010BA_nm108_id_code_qual = @L2010BA_nm108_id_code_qual,
				@L2010BA_nm109_subscriber_id = @L2010BA_nm109_subscriber_id,
				@L2010BA_ref02_1W_subscriber_sup_id = @L2010BA_ref02_1W_subscriber_sup_id,
				@L2010BA_ref02_23_subscriber_sup_id = @L2010BA_ref02_23_subscriber_sup_id,
				@L2010BA_ref02_IG_subscriber_sup_id = @L2010BA_ref02_IG_subscriber_sup_id,
				@L2010BA_ref02_SY_subscriber_sup_id = @L2010BA_ref02_SY_subscriber_sup_id,
				@L2010BA_ref02_Y4_prop_casualty_claim_num = @L2010BA_ref02_Y4_prop_casualty_claim_num,
				@L2010BB_n301_payer_address1 = @L2010BB_n301_payer_address1,
				@L2010BB_n302_payer_address2 = @L2010BB_n302_payer_address2,
				@L2010BB_n401_payer_city = @L2010BB_n401_payer_city,
				@L2010BB_n402_payer_state = @L2010BB_n402_payer_state,
				@L2010BB_n403_payer_zip = @L2010BB_n403_payer_zip,
				@L2010BB_n404_payer_country = @L2010BB_n404_payer_country,
				@L2010BB_nm102_entity_type_qual = @L2010BB_nm102_entity_type_qual,
				@L2010BB_nm103_payer_nm = @L2010BB_nm103_payer_nm,
				@L2010BB_nm108_payer_id_qual = @L2010BB_nm108_payer_id_qual,
				@L2010BB_nm109_payer_id = @L2010BB_nm109_payer_id,
				@L2010BB_ref02_2U_payer_id = @L2010BB_ref02_2U_payer_id,
				@L2010BB_ref02_FY_payer_id = @L2010BB_ref02_FY_payer_id,
				@L2010BB_ref02_NF_payer_id = @L2010BB_ref02_NF_payer_id,
				@L2010BB_ref02_TJ_payer_id = @L2010BB_ref02_TJ_payer_id,
				@L2010BC_n301_resp_party_address1 = @L2010BC_n301_resp_party_address1,
				@L2010BC_n302_resp_party_address2 = @L2010BC_n302_resp_party_address2,
				@L2010BC_n401_resp_party_city = @L2010BC_n401_resp_party_city,
				@L2010BC_n402_resp_party_state = @L2010BC_n402_resp_party_state,
				@L2010BC_n403_resp_party_zip = @L2010BC_n403_resp_party_zip,
				@L2010BC_n404_resp_party_country = @L2010BC_n404_resp_party_country,
				@L2010BC_nm102_entity_type_qual = @L2010BC_nm102_entity_type_qual,
				@L2010BC_nm103_resp_party_last_nm = @L2010BC_nm103_resp_party_last_nm,
				@L2010BC_nm104_resp_party_first_nm = @L2010BC_nm104_resp_party_first_nm,
				@L2010BC_nm105_resp_party_middle_nm = @L2010BC_nm105_resp_party_middle_nm,
				@L2010BC_nm107_resp_party_suffix = @L2010BC_nm107_resp_party_suffix,
				@L2010BD_nm102_entity_type_qual = @L2010BD_nm102_entity_type_qual,
				@L2010BD_nm103_card_holder_last_nm = @L2010BD_nm103_card_holder_last_nm,
				@L2010BD_nm104_card_holder_first_nm = @L2010BD_nm104_card_holder_first_nm,
				@L2010BD_nm105_card_holder_middle_nm = @L2010BD_nm105_card_holder_middle_nm,
				@L2010BD_nm107_card_holder_suffix = @L2010BD_nm107_card_holder_suffix,
				@L2010BD_nm108_card_id_qual = @L2010BD_nm108_card_id_qual,
				@L2010BD_nm109_card_num = @L2010BD_nm109_card_num,
				@L2010BD_ref02_AB_card_num = @L2010BD_ref02_AB_card_num,
				@L2010BD_ref02_BB_card_num = @L2010BD_ref02_BB_card_num,
				@L2010CA_dmg02_patient_dob = @L2010CA_dmg02_patient_dob,
				@L2010CA_dmg03_patient_gender = @L2010CA_dmg03_patient_gender,
				@L2010CA_n301_patient_address1 = @L2010CA_n301_patient_address1,
				@L2010CA_n302_patient_address2 = @L2010CA_n302_patient_address2,
				@L2010CA_n401_patient_city = @L2010CA_n401_patient_city,
				@L2010CA_n402_patient_state = @L2010CA_n402_patient_state,
				@L2010CA_n403_patient_zip = @L2010CA_n403_patient_zip,
				@L2010CA_n404_patient_country = @L2010CA_n404_patient_country,
				@L2010CA_nm102_entity_type_qual = @L2010CA_nm102_entity_type_qual,
				@L2010CA_nm103_patient_last_nm = @L2010CA_nm103_patient_last_nm,
				@L2010CA_nm104_patient_first_nm = @L2010CA_nm104_patient_first_nm,
				@L2010CA_nm105_patient_middle_nm = @L2010CA_nm105_patient_middle_nm,
				@L2010CA_nm107_patient_suffix = @L2010CA_nm107_patient_suffix,
				@L2010CA_nm108_id_code_qual = @L2010CA_nm108_id_code_qual,
				@L2010CA_nm109_patient_id = @L2010CA_nm109_patient_id,
				@L2010CA_ref02_1W_patient_sup_id = @L2010CA_ref02_1W_patient_sup_id,
				@L2010CA_ref02_23_patient_sup_id = @L2010CA_ref02_23_patient_sup_id,
				@L2010CA_ref02_IG_patient_sup_id = @L2010CA_ref02_IG_patient_sup_id,
				@L2010CA_ref02_SY_patient_sup_id = @L2010CA_ref02_SY_patient_sup_id,
				@L2010CA_ref02_Y4_prop_casualty_claim_num = @L2010CA_ref02_Y4_prop_casualty_claim_num,
				@L2300_amt02_patient_paid_amt = @L2300_amt02_patient_paid_amt,
				@L2300_amt02_total_purchased_amt = @L2300_amt02_total_purchased_amt,
				@L2300_clm01_pt_acct_num = @L2300_clm01_pt_acct_num,
				@L2300_clm02_total_claim_chg_amt = @L2300_clm02_total_claim_chg_amt,
				@L2300_clm05_claim_freq_code = @L2300_clm05_claim_freq_code,
				@L2300_clm05_facility_type_code = @L2300_clm05_facility_type_code,
				@L2300_clm06_provider_signature_ind = @L2300_clm06_provider_signature_ind,
				@L2300_clm07_medicare_assign_code = @L2300_clm07_medicare_assign_code,
				@L2300_clm08_benefit_assign_ind = @L2300_clm08_benefit_assign_ind,
				@L2300_clm09_release_of_info_code = @L2300_clm09_release_of_info_code,
				@L2300_clm10_patient_signature_code = @L2300_clm10_patient_signature_code,
				@L2300_clm11_auto_accident_state_code = @L2300_clm11_auto_accident_state_code,
				@L2300_clm11_country_code = @L2300_clm11_country_code,
				@L2300_clm11_related_causes_code1 = @L2300_clm11_related_causes_code1,
				@L2300_clm11_related_causes_code2 = @L2300_clm11_related_causes_code2,
				@L2300_clm11_related_causes_code3 = @L2300_clm11_related_causes_code3,
				@L2300_clm12_special_prog_ind = @L2300_clm12_special_prog_ind,
				@L2300_clm16_participation_agreement = @L2300_clm16_participation_agreement,
				@L2300_clm20_delay_reason_code = @L2300_clm20_delay_reason_code,
				@L2300_dtp03_090_assumed_care_date = @L2300_dtp03_090_assumed_care_date,
				@L2300_dtp03_091_relinquished_care_date = @L2300_dtp03_091_relinquished_care_date,
				@L2300_dtp03_096_discharge_date = @L2300_dtp03_096_discharge_date,
				@L2300_dtp03_296_work_return_date = @L2300_dtp03_296_work_return_date,
				@L2300_dtp03_297_last_worked_date = @L2300_dtp03_297_last_worked_date,
				@L2300_dtp03_304_last_seen_date = @L2300_dtp03_304_last_seen_date,
				@L2300_dtp03_360_disability_begin_date = @L2300_dtp03_360_disability_begin_date,
				@L2300_dtp03_361_disability_end_date = @L2300_dtp03_361_disability_end_date,
				@L2300_dtp03_431_onset_of_injury_date = @L2300_dtp03_431_onset_of_injury_date,
				@L2300_dtp03_435_admission_date = @L2300_dtp03_435_admission_date,
				@L2300_dtp03_438_symptom_date = @L2300_dtp03_438_symptom_date,
				@L2300_dtp03_439_accident_date = @L2300_dtp03_439_accident_date,
				@L2300_dtp03_453_acute_manifestation_date = @L2300_dtp03_453_acute_manifestation_date,
				@L2300_dtp03_454_initial_tmt_date = @L2300_dtp03_454_initial_tmt_date,
				@L2300_dtp03_455_last_xray_date = @L2300_dtp03_455_last_xray_date,
				@L2300_dtp03_471_prescription_date = @L2300_dtp03_471_prescription_date,
				@L2300_dtp03_484_last_menstrual_period_date = @L2300_dtp03_484_last_menstrual_period_date,
				@L2300_hi01_diag_code = @L2300_hi01_diag_code,
				@L2300_hi02_diag_code = @L2300_hi02_diag_code,
				@L2300_hi03_diag_code = @L2300_hi03_diag_code,
				@L2300_hi04_diag_code = @L2300_hi04_diag_code,
				@L2300_hi05_diag_code = @L2300_hi05_diag_code,
				@L2300_hi06_diag_code = @L2300_hi06_diag_code,
				@L2300_hi07_diag_code = @L2300_hi07_diag_code,
				@L2300_hi08_diag_code = @L2300_hi08_diag_code,
				@L2300_k301_fixed_format_info = @L2300_k301_fixed_format_info,
				@L2300_nte01_note_ref_code = @L2300_nte01_note_ref_code,
				@L2300_nte02_claim_note_text = @L2300_nte02_claim_note_text,
				@L2300_pwk01_attachment_type_code = @L2300_pwk01_attachment_type_code,
				@L2300_pwk02_attachment_trans_code = @L2300_pwk02_attachment_trans_code,
				@L2300_pwk06_attachment_control_num = @L2300_pwk06_attachment_control_num,
				@L2300_ref02_9A_repriced_claim_num = @L2300_ref02_9A_repriced_claim_num,
				@L2300_ref02_9C_adj_repriced_claim_num = @L2300_ref02_9C_adj_repriced_claim_num,
				@L2300_ref02_9F_prior_auth_num = @L2300_ref02_9F_prior_auth_num,
				@L2300_ref02_EA_medical_record_num = @L2300_ref02_EA_medical_record_num,
				@L2300_ref02_F8_original_ref_num = @L2300_ref02_F8_original_ref_num,
				@L2300_ref02_G1_referral_num = @L2300_ref02_G1_referral_num,
				@L2310A_nm101_entity_id_code = @L2310A_nm101_entity_id_code,
				@L2310A_nm102_entity_type_qual = @L2310A_nm102_entity_type_qual,
				@L2310A_nm103_referring_prov_last_nm = @L2310A_nm103_referring_prov_last_nm,
				@L2310A_nm104_referring_prov_first_nm = @L2310A_nm104_referring_prov_first_nm,
				@L2310A_nm105_referring_prov_middle_nm = @L2310A_nm105_referring_prov_middle_nm,
				@L2310A_nm107_referring_prov_suffix = @L2310A_nm107_referring_prov_suffix,
				@L2310A_nm108_id_code_qual = @L2310A_nm108_id_code_qual,
				@L2310A_nm109_referring_prov_id = @L2310A_nm109_referring_prov_id,
				@L2310A_prv01_provider_code = @L2310A_prv01_provider_code,
				@L2310A_prv02_ref_id_qual = @L2310A_prv02_ref_id_qual,
				@L2310A_prv03_taxonomy_code = @L2310A_prv03_taxonomy_code,
				@L2310A_ref02_1C_referring_prov_id = @L2310A_ref02_1C_referring_prov_id,
				@L2310A_ref02_1D_referring_prov_id = @L2310A_ref02_1D_referring_prov_id,
				@L2310A_ref02_1G_referring_prov_id = @L2310A_ref02_1G_referring_prov_id,
				@L2310A_ref02_EI_referring_prov_id = @L2310A_ref02_EI_referring_prov_id,
				@L2310A_ref02_FH_referring_prov_id = @L2310A_ref02_FH_referring_prov_id,
				@L2310A_ref02_G2_referring_prov_id = @L2310A_ref02_G2_referring_prov_id,
				@L2310A_ref02_SY_referring_prov_id = @L2310A_ref02_SY_referring_prov_id,
				@L2310B_nm102_entity_type_qual = @L2310B_nm102_entity_type_qual,
				@L2310B_nm103_rendering_prov_last_nm = @L2310B_nm103_rendering_prov_last_nm,
				@L2310B_nm104_rendering_prov_first_nm = @L2310B_nm104_rendering_prov_first_nm,
				@L2310B_nm105_rendering_prov_middle_nm = @L2310B_nm105_rendering_prov_middle_nm,
				@L2310B_nm107_rendering_prov_suffix = @L2310B_nm107_rendering_prov_suffix,
				@L2310B_nm108_id_code_qual = @L2310B_nm108_id_code_qual,
				@L2310B_nm109_rendering_prov_id = @L2310B_nm109_rendering_prov_id,
				@L2310B_prv01_provider_code = @L2310B_prv01_provider_code,
				@L2310B_prv02_ref_id_qual = @L2310B_prv02_ref_id_qual,
				@L2310B_prv03_taxonomy_code = @L2310B_prv03_taxonomy_code,
				@L2310B_ref02_1C_rendering_prov_id = @L2310B_ref02_1C_rendering_prov_id,
				@L2310B_ref02_1D_rendering_prov_id = @L2310B_ref02_1D_rendering_prov_id,
				@L2310B_ref02_1G_rendering_prov_id = @L2310B_ref02_1G_rendering_prov_id,
				@L2310B_ref02_EI_rendering_prov_id = @L2310B_ref02_EI_rendering_prov_id,
				@L2310B_ref02_FH_rendering_prov_id = @L2310B_ref02_FH_rendering_prov_id,
				@L2310B_ref02_G2_rendering_prov_id = @L2310B_ref02_G2_rendering_prov_id,
				@L2310B_ref02_SY_rendering_prov_id = @L2310B_ref02_SY_rendering_prov_id,
				@L2310D_n301_service_facility_address1 = @L2310D_n301_service_facility_address1,
				@L2310D_n302_service_facility_address2 = @L2310D_n302_service_facility_address2,
				@L2310D_n401_service_facility_city = @L2310D_n401_service_facility_city,
				@L2310D_n402_service_facility_state = @L2310D_n402_service_facility_state,
				@L2310D_n403_service_facility_zip = @L2310D_n403_service_facility_zip,
				@L2310D_n404_service_facility_country = @L2310D_n404_service_facility_country,
				@L2310D_nm101_entity_id_code = @L2310D_nm101_entity_id_code,
				@L2310D_nm102_entity_type_qual = @L2310D_nm102_entity_type_qual,
				@L2310D_nm103_service_facility_last_nm = @L2310D_nm103_service_facility_last_nm,
				@L2310D_nm108_id_code_qual = @L2310D_nm108_id_code_qual,
				@L2310D_nm109_service_facility_id = @L2310D_nm109_service_facility_id,
				@L2310D_ref02_1C_service_facility_id = @L2310D_ref02_1C_service_facility_id,
				@L2310D_ref02_1D_service_facility_id = @L2310D_ref02_1D_service_facility_id,
				@L2310D_ref02_1G_service_facility_id = @L2310D_ref02_1G_service_facility_id,
				@L2310D_ref02_G2_service_facility_id = @L2310D_ref02_G2_service_facility_id,
				@L2310D_ref02_TJ_service_facility_id = @L2310D_ref02_TJ_service_facility_id,
				@L2310E_nm102_entity_type_qual = @L2310E_nm102_entity_type_qual,
				@L2310E_nm103_supervising_prov_last_nm = @L2310E_nm103_supervising_prov_last_nm,
				@L2310E_nm104_supervising_prov_first_nm = @L2310E_nm104_supervising_prov_first_nm,
				@L2310E_nm105_supervising_prov_middle_nm = @L2310E_nm105_supervising_prov_middle_nm,
				@L2310E_nm107_supervising_prov_suffix = @L2310E_nm107_supervising_prov_suffix,
				@L2310E_nm108_id_code_qual = @L2310E_nm108_id_code_qual,
				@L2310E_nm109_supervising_prov_id = @L2310E_nm109_supervising_prov_id,
				@L2320_amt02_AAE_approved_amt = @L2320_amt02_AAE_approved_amt,
				@L2320_amt02_AU_covered_amt = @L2320_amt02_AU_covered_amt,
				@L2320_amt02_B6_allowed_amt = @L2320_amt02_B6_allowed_amt,
				@L2320_amt02_D_payer_paid_amt = @L2320_amt02_D_payer_paid_amt,
				@L2320_amt02_D8_discount_amt = @L2320_amt02_D8_discount_amt,
				@L2320_amt02_DY_per_day_limit_amt = @L2320_amt02_DY_per_day_limit_amt,
				@L2320_amt02_F2_pt_responsibility_amt = @L2320_amt02_F2_pt_responsibility_amt,
				@L2320_amt02_F5_pt_paid_amt = @L2320_amt02_F5_pt_paid_amt,
				@L2320_amt02_T_tax_amt = @L2320_amt02_T_tax_amt,
				@L2320_amt02_T2_total_clm_before_tax_amt = @L2320_amt02_T2_total_clm_before_tax_amt,
				@L2320_cas01_adjustment_group_code = @L2320_cas01_adjustment_group_code,
				@L2320_cas02_adjustment_reason_code = @L2320_cas02_adjustment_reason_code,
				@L2320_cas03_adjustment_amt = @L2320_cas03_adjustment_amt,
				@L2320_cas04_adjustment_qty = @L2320_cas04_adjustment_qty,
				@L2320_cas05_adjustment_reason_code = @L2320_cas05_adjustment_reason_code,
				@L2320_cas06_adjustment_amt = @L2320_cas06_adjustment_amt,
				@L2320_cas07_adjustment_qty = @L2320_cas07_adjustment_qty,
				@L2320_cas08_adjustment_reason_code = @L2320_cas08_adjustment_reason_code,
				@L2320_cas09_adjustment_amt = @L2320_cas09_adjustment_amt,
				@L2320_cas10_adjustment_qty = @L2320_cas10_adjustment_qty,
				@L2320_dmg02_other_subscriber_dob = @L2320_dmg02_other_subscriber_dob,
				@L2320_dmg03_other_subscriber_gender = @L2320_dmg03_other_subscriber_gender,
				@L2320_oi03_other_ins_benefit_assign_ind = @L2320_oi03_other_ins_benefit_assign_ind,
				@L2320_oi04_other_ins_patient_signature_code = @L2320_oi04_other_ins_patient_signature_code,
				@L2320_oi06_other_ins_release_of_info_code = @L2320_oi06_other_ins_release_of_info_code,
				@L2320_sbr01_payer_resp_seq_code = @L2320_sbr01_payer_resp_seq_code,
				@L2320_sbr02_ind_relationship_code = @L2320_sbr02_ind_relationship_code,
				@L2320_sbr03_insured_grp_policy_num = @L2320_sbr03_insured_grp_policy_num,
				@L2320_sbr04_insured_grp_nm = @L2320_sbr04_insured_grp_nm,
				@L2320_sbr05_insurance_type_code = @L2320_sbr05_insurance_type_code,
				@L2320_sbr09_claim_filing_ind_code = @L2320_sbr09_claim_filing_ind_code,
				@L2330A_nm101_entity_id_code = @L2330A_nm101_entity_id_code,
				@L2330A_nm102_entity_type_qual = @L2330A_nm102_entity_type_qual,
				@L2330A_nm103_other_insured_last_name = @L2330A_nm103_other_insured_last_name,
				@L2330A_nm104_other_insured_first_name = @L2330A_nm104_other_insured_first_name,
				@L2330A_nm105_other_insured_middle_name = @L2330A_nm105_other_insured_middle_name,
				@L2330A_nm107_other_insured_name_suffix = @L2330A_nm107_other_insured_name_suffix,
				@L2330A_nm108_other_insured_id_code_qual = @L2330A_nm108_other_insured_id_code_qual,
				@L2330A_nm109_other_insured_id = @L2330A_nm109_other_insured_id,
				@L2330B_dtp03_573_date_claim_paid = @L2330B_dtp03_573_date_claim_paid,
				@L2330B_nm101_entity_id_code = @L2330B_nm101_entity_id_code,
				@L2330B_nm102_entity_type_qual = @L2330B_nm102_entity_type_qual,
				@L2330B_nm103_other_payer_nm = @L2330B_nm103_other_payer_nm,
				@L2330B_nm108_id_code_qual = @L2330B_nm108_id_code_qual,
				@L2330B_nm109_other_payer_id = @L2330B_nm109_other_payer_id,
				@L2330B_ref02_2U_other_payer_secondary_id = @L2330B_ref02_2U_other_payer_secondary_id,
				@L2330B_ref02_F8_other_payer_secondary_id = @L2330B_ref02_F8_other_payer_secondary_id,
				@L2330B_ref02_FY_other_payer_secondary_id = @L2330B_ref02_FY_other_payer_secondary_id,
				@L2330B_ref02_NF_other_payer_secondary_id = @L2330B_ref02_NF_other_payer_secondary_id,
				@L2330B_ref02_TJ_other_payer_secondary_id = @L2330B_ref02_TJ_other_payer_secondary_id,
				@L2400_dtp02_472_from_service_date = @L2400_dtp02_472_from_service_date,
				@L2400_dtp02_472_to_service_date = @L2400_dtp02_472_to_service_date,
				@L2400_lx01_assigned_num = @L2400_lx01_assigned_num,
				@L2400_nte01_note_ref_code = @L2400_nte01_note_ref_code,
				@L2400_nte02_line_note_text = @L2400_nte02_line_note_text,
				@L2400_ref02_6R_line_item_control_num = @L2400_ref02_6R_line_item_control_num,
				@L2400_sv101_proc_code = @L2400_sv101_proc_code,
				@L2400_sv101_proc_code_qual = @L2400_sv101_proc_code_qual,
				@L2400_sv101_proc_mod1 = @L2400_sv101_proc_mod1,
				@L2400_sv101_proc_mod2 = @L2400_sv101_proc_mod2,
				@L2400_sv101_proc_mod3 = @L2400_sv101_proc_mod3,
				@L2400_sv101_proc_mod4 = @L2400_sv101_proc_mod4,
				@L2400_sv102_line_charge = @L2400_sv102_line_charge,
				@L2400_sv103_measurement_code = @L2400_sv103_measurement_code,
				@L2400_sv104_service_unit_count = @L2400_sv104_service_unit_count,
				@L2400_sv105_place_of_service = @L2400_sv105_place_of_service,
				@L2400_sv107_dx_pointer1 = @L2400_sv107_dx_pointer1,
				@L2400_sv107_dx_pointer2 = @L2400_sv107_dx_pointer2,
				@L2400_sv107_dx_pointer3 = @L2400_sv107_dx_pointer3,
				@L2400_sv107_dx_pointer4 = @L2400_sv107_dx_pointer4,
				@L2400_sv109_emergency_indicator = @L2400_sv109_emergency_indicator,
				@L2400_sv111_epsdt_indicator = @L2400_sv111_epsdt_indicator,
				@L2400_sv112_family_plan_indicator = @L2400_sv112_family_plan_indicator,
				@L2400_sv115_copay_status_code = @L2400_sv115_copay_status_code,
				@L2410_1_lin03_N4_ndc = @L2410_1_lin03_N4_ndc,
				@L2420A_nm102_entity_type_qual = @L2420A_nm102_entity_type_qual,
				@L2420A_nm103_rendering_prov_last_nm = @L2420A_nm103_rendering_prov_last_nm,
				@L2420A_nm104_rendering_prov_first_nm = @L2420A_nm104_rendering_prov_first_nm,
				@L2420A_nm105_rendering_prov_middle_nm = @L2420A_nm105_rendering_prov_middle_nm,
				@L2420A_nm107_rendering_prov_suffix = @L2420A_nm107_rendering_prov_suffix,
				@L2420A_nm108_id_code_qual = @L2420A_nm108_id_code_qual,
				@L2420A_nm109_rendering_prov_id = @L2420A_nm109_rendering_prov_id,
				@L2420A_prv01_provider_code = @L2420A_prv01_provider_code,
				@L2420A_prv02_ref_id_qual = @L2420A_prv02_ref_id_qual,
				@L2420A_prv03_taxonomy_code = @L2420A_prv03_taxonomy_code,
				@L2420A_ref02_1C_rendering_prov_id = @L2420A_ref02_1C_rendering_prov_id,
				@L2420A_ref02_1D_rendering_prov_id = @L2420A_ref02_1D_rendering_prov_id,
				@L2420A_ref02_1G_rendering_prov_id = @L2420A_ref02_1G_rendering_prov_id,
				@L2420A_ref02_EI_rendering_prov_id = @L2420A_ref02_EI_rendering_prov_id,
				@L2420A_ref02_FH_rendering_prov_id = @L2420A_ref02_FH_rendering_prov_id,
				@L2420A_ref02_SY_rendering_prov_id = @L2420A_ref02_SY_rendering_prov_id,
				@L2420C_n301_service_facility_address1 = @L2420C_n301_service_facility_address1,
				@L2420C_n302_service_facility_address2 = @L2420C_n302_service_facility_address2,
				@L2420C_n401_service_facility_city = @L2420C_n401_service_facility_city,
				@L2420C_n402_service_facility_state = @L2420C_n402_service_facility_state,
				@L2420C_n403_service_facility_zip = @L2420C_n403_service_facility_zip,
				@L2420C_n404_service_facility_country = @L2420C_n404_service_facility_country,
				@L2420C_nm101_entity_id_code = @L2420C_nm101_entity_id_code,
				@L2420C_nm102_entity_type_qual = @L2420C_nm102_entity_type_qual,
				@L2420C_nm103_service_facility_last_nm = @L2420C_nm103_service_facility_last_nm,
				@L2420C_nm108_id_code_qual = @L2420C_nm108_id_code_qual,
				@L2420C_nm109_service_facility_id = @L2420C_nm109_service_facility_id,
				@L2420C_ref02_1C_service_facility_id = @L2420C_ref02_1C_service_facility_id,
				@L2420C_ref02_1D_service_facility_id = @L2420C_ref02_1D_service_facility_id,
				@L2420C_ref02_1G_service_facility_id = @L2420C_ref02_1G_service_facility_id,
				@L2420C_ref02_G2_service_facility_id = @L2420C_ref02_G2_service_facility_id,
				@L2420C_ref02_TJ_service_facility_id = @L2420C_ref02_TJ_service_facility_id,
				@L2420D_nm102_entity_type_qual = @L2420D_nm102_entity_type_qual,
				@L2420D_nm103_supervising_prov_last_nm = @L2420D_nm103_supervising_prov_last_nm,
				@L2420D_nm104_supervising_prov_first_nm = @L2420D_nm104_supervising_prov_first_nm,
				@L2420D_nm105_supervising_prov_middle_nm = @L2420D_nm105_supervising_prov_middle_nm,
				@L2420D_nm107_supervising_prov_suffix = @L2420D_nm107_supervising_prov_suffix,
				@L2420D_nm108_id_code_qual = @L2420D_nm108_id_code_qual,
				@L2420D_nm109_supervising_prov_id = @L2420D_nm109_supervising_prov_id,
				@L2420F_nm101_entity_id_code = @L2420F_nm101_entity_id_code,
				@L2420F_nm102_entity_type_qual = @L2420F_nm102_entity_type_qual,
				@L2420F_nm103_referring_prov_last_nm = @L2420F_nm103_referring_prov_last_nm,
				@L2420F_nm104_referring_prov_first_nm = @L2420F_nm104_referring_prov_first_nm,
				@L2420F_nm105_referring_prov_middle_nm = @L2420F_nm105_referring_prov_middle_nm,
				@L2420F_nm107_referring_prov_suffix = @L2420F_nm107_referring_prov_suffix,
				@L2420F_nm108_id_code_qual = @L2420F_nm108_id_code_qual,
				@L2420F_nm109_referring_prov_id = @L2420F_nm109_referring_prov_id,
				@L2420F_prv01_provider_code = @L2420F_prv01_provider_code,
				@L2420F_prv02_ref_id_qual = @L2420F_prv02_ref_id_qual,
				@L2420F_prv03_taxonomy_code = @L2420F_prv03_taxonomy_code,
				@L2420F_ref02_1C_referring_prov_id = @L2420F_ref02_1C_referring_prov_id,
				@L2420F_ref02_1D_referring_prov_id = @L2420F_ref02_1D_referring_prov_id,
				@L2420F_ref02_1G_referring_prov_id = @L2420F_ref02_1G_referring_prov_id,
				@L2420F_ref02_EI_referring_prov_id = @L2420F_ref02_EI_referring_prov_id,
				@L2420F_ref02_FH_referring_prov_id = @L2420F_ref02_FH_referring_prov_id,
				@L2420F_ref02_SY_referring_prov_id = @L2420F_ref02_SY_referring_prov_id,
				@L2430_cas01_adjustment_group_code = @L2430_cas01_adjustment_group_code,
				@L2430_cas02_adjustment_reason_code = @L2430_cas02_adjustment_reason_code,
				@L2430_cas03_adjustment_amt = @L2430_cas03_adjustment_amt,
				@L2430_cas04_adjustment_qty = @L2430_cas04_adjustment_qty,
				@L2430_cas05_adjustment_reason_code = @L2430_cas05_adjustment_reason_code,
				@L2430_cas06_adjustment_amt = @L2430_cas06_adjustment_amt,
				@L2430_cas07_adjustment_qty = @L2430_cas07_adjustment_qty,
				@L2430_cas08_adjustment_reason_code = @L2430_cas08_adjustment_reason_code,
				@L2430_cas09_adjustment_amt = @L2430_cas09_adjustment_amt,
				@L2430_cas10_adjustment_qty = @L2430_cas10_adjustment_qty,
				@L2430_dtp03_573_date_claim_paid = @L2430_dtp03_573_date_claim_paid,
				@L2430_svd01_other_payer_id = @L2430_svd01_other_payer_id,
				@L2430_svd02_service_line_paid = @L2430_svd02_service_line_paid,
				@ref01_receiver_ref_id_qual = @ref01_receiver_ref_id_qual,
				@ref02_transmission_type_code = @ref02_transmission_type_code,
				@x12_transaction_id = @x12_transaction_id	
		end

		-- reset the procedure code values
		select	@L2400_lx01_assigned_num = null,
			@L2400_sv101_proc_code_qual = null,
			@L2400_sv101_proc_code = NULL,
			@L2400_sv101_proc_mod1 = NULL,
			@L2400_sv101_proc_mod2 = NULL,
			@L2400_sv101_proc_mod3 = NULL,
			@L2400_sv101_proc_mod4 = NULL,
			@L2400_sv102_line_charge = NULL,
			@L2400_sv103_measurement_code = NULL,
			@L2400_sv104_service_unit_count = NULL,
			@L2400_sv105_place_of_service = NULL,
			@L2400_sv107_dx_pointer1 = NULL,
			@L2400_sv107_dx_pointer2 = NULL,
			@L2400_sv107_dx_pointer3 = NULL,
			@L2400_sv107_dx_pointer4 = NULL,
			@L2400_sv109_emergency_indicator = NULL,
			@L2400_sv111_epsdt_indicator = NULL,
			@L2400_sv112_family_plan_indicator = NULL,
			@L2400_sv115_copay_status_code = NULL,
			@L2400_dtp02_472_from_service_date = NULL,
			@L2400_dtp02_472_to_service_date = NULL,
			@L2400_ref02_6R_line_item_control_num = NULL,
			@L2400_nte01_note_ref_code = NULL,
			@L2400_nte02_line_note_text = NULL,
			@L2410_1_lin03_N4_ndc = NULL,
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
			@L2420A_ref02_1G_rendering_prov_id = NULL,
			@L2420A_ref02_EI_rendering_prov_id = NULL,
			@L2420A_ref02_SY_rendering_prov_id = NULL,
			@L2420A_ref02_FH_rendering_prov_id = NULL,
			@L2420C_nm101_entity_id_code = NULL,
			@L2420C_nm102_entity_type_qual = NULL,
			@L2420C_nm103_service_facility_last_nm = NULL,
			@L2420C_nm108_id_code_qual = NULL,
			@L2420C_nm109_service_facility_id = NULL,
			@L2420C_n301_service_facility_address1 = NULL,
			@L2420C_n302_service_facility_address2 = NULL,
			@L2420C_n401_service_facility_city = NULL,
			@L2420C_n402_service_facility_state = NULL,
			@L2420C_n403_service_facility_zip = NULL,
			@L2420C_n404_service_facility_country = NULL,
			@L2420C_ref02_1C_service_facility_id = NULL,
			@L2420C_ref02_1D_service_facility_id = NULL,
			@L2420C_ref02_1G_service_facility_id = NULL,
			@L2420C_ref02_G2_service_facility_id = NULL,
			@L2420C_ref02_TJ_service_facility_id = NULL,
			@L2420D_nm102_entity_type_qual = NULL,
			@L2420D_nm103_supervising_prov_last_nm = NULL,
			@L2420D_nm104_supervising_prov_first_nm = NULL,
			@L2420D_nm105_supervising_prov_middle_nm = NULL,
			@L2420D_nm107_supervising_prov_suffix = NULL,
			@L2420D_nm108_id_code_qual = NULL,
			@L2420D_nm109_supervising_prov_id = NULL,
			@L2420F_nm101_entity_id_code = NULL,
			@L2420F_nm102_entity_type_qual = NULL,
			@L2420F_nm103_referring_prov_last_nm = NULL,
			@L2420F_nm104_referring_prov_first_nm = NULL,
			@L2420F_nm105_referring_prov_middle_nm = NULL,
			@L2420F_nm107_referring_prov_suffix = NULL,
			@L2420F_nm108_id_code_qual = NULL,
			@L2420F_nm109_referring_prov_id = NULL,
			@L2420F_prv01_provider_code = NULL,
			@L2420F_prv02_ref_id_qual = NULL,
			@L2420F_prv03_taxonomy_code = NULL,
			@L2420F_ref02_1C_referring_prov_id = NULL,
			@L2420F_ref02_1D_referring_prov_id = NULL,
			@L2420F_ref02_1G_referring_prov_id = NULL,
			@L2420F_ref02_EI_referring_prov_id = NULL,
			@L2420F_ref02_SY_referring_prov_id = NULL,
			@L2420F_ref02_FH_referring_prov_id = NULL,
			@L2430_svd01_other_payer_id = NULL,
			@L2430_svd02_service_line_paid = NULL,
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
	
			@L2400_lx01_assigned_num = LTRIM(RTRIM(@Col002))
	end


	-- Get SV1 service information (this segment is essentially the "header" of the detail section)
	if ( RTrim(@col001) = 'SV1' )
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
			if (@loopcount = 1) set @L2400_sv101_proc_code_qual = Left(@ProcString, @EndStringPos)
			if (@loopcount = 2) set @L2400_sv101_proc_code = Left(@ProcString, @EndStringPos)
			if (@loopcount = 3) set @L2400_sv101_proc_mod1 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 4) set @L2400_sv101_proc_mod2 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 5) set @L2400_sv101_proc_mod3 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 6) set @L2400_sv101_proc_mod4 = Left(@ProcString, @EndStringPos)
			if (@ColonPos > 0)
				set @ProcString = Right(@ProcString, Len(@ProcString)-@ColonPos)
			else
				set @ProcString = null
		end

		-- UB92 codes (revenue codes) will look like this, "NU:0217"
		if (@L2400_sv101_proc_code_qual = 'NU')
		begin
			 -- NU means UB92 Code
			set @L2400_sv101_proc_code = Right(RTrim(@L2400_sv101_proc_code), 3) -- the first digit is a 0, leave that off.
		end

		set @L2400_sv102_line_charge = CAST(LTrim(RTrim(@Col003)) as money)
		set @L2400_sv103_measurement_code = LTRIM(RTRIM(@Col004))
		set @L2400_sv104_service_unit_count = LTRIM(RTRIM(@Col005))
		set @L2400_sv105_place_of_service = LTRIM(RTRIM(@Col006))

		set @DXPointerString = LTRIM(RTRIM(@col008))
		set @loopcount = 0
		-- loop over the dx-pointer string and scoop out the values between colons
		while (Len(@DXPointerString) > 0)
		begin
			set @ColonPos = CHARINDEX(@isa16_component_element_seperator, @DXPointerString)	-- find the first colon position
			if (@ColonPos > 0)
				set @EndStringPos = @ColonPos-1		-- set the end position for the first value
			else if (@ColonPos = 0)
				set @EndStringPos = Len(@DXPointerString)	-- if no colon in the string, the value is the string
			set @loopcount = @loopcount + 1
			if (@loopcount = 1) set @L2400_sv107_dx_pointer1 = Left(@DXPointerString, @EndStringPos)
			if (@loopcount = 2) set @L2400_sv107_dx_pointer2 = Left(@DXPointerString, @EndStringPos)
			if (@loopcount = 3) set @L2400_sv107_dx_pointer3 = Left(@DXPointerString, @EndStringPos)
			if (@loopcount = 4) set @L2400_sv107_dx_pointer4 = Left(@DXPointerString, @EndStringPos)
			if (@ColonPos > 0)
				set @DXPointerString = Right(@DXPointerString, Len(@DXPointerString)-@ColonPos)
			else
				set @DXPointerString = null
		end
		set @L2400_sv109_emergency_indicator = LTRIM(RTRIM(@Col010))
		set @L2400_sv111_epsdt_indicator = LTRIM(RTRIM(@Col012))
		set @L2400_sv112_family_plan_indicator = LTRIM(RTRIM(@Col013))
		set @L2400_sv115_copay_status_code = LTRIM(RTRIM(@Col016))
	end

	-- Claim Header Segment
	if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '472' )
	begin
		if (RTrim(@col003) = 'D8')
		begin
			select	@L2400_dtp02_472_from_service_date = LTrim(RTrim(@col004)),
				@L2400_dtp02_472_to_service_date = LTrim(RTrim(@col004))
		end
		else if (RTrim(@col003) = 'RD8')
		begin
			select	@L2400_dtp02_472_from_service_date = Left(LTrim(RTrim(@col004)), 8),
				@L2400_dtp02_472_to_service_date = Right(LTrim(RTrim(@col004)), 8)
		end
	end
	if ( RTrim(@col001) = 'REF' AND RTrim(@col002) = '6R' )
	begin
		set @L2400_ref02_6R_line_item_control_num = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'NTE' AND @curLoop = '2400' )
	begin
		select	@L2400_nte01_note_ref_code = LTrim(RTrim(@col002)),
			@L2400_nte02_line_note_text = LTrim(RTrim(@col003))
	END
	
-- Line Item National Drug Code
	IF( 	RTrim(@col001) = 'LIN' AND RTrim(@col003) = 'N4' AND Left(@curLoop, 2) = '24' )
	begin
		select	@curLoop = '2410',
				@L2410_1_lin03_N4_ndc = LTrim(RTrim(@col004))
	END
-- END LOOP: Line Item National Drug Code

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
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420A' AND RTrim(@col002) = '1G' )
	begin
		set @L2420A_ref02_1G_rendering_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420A' AND RTrim(@col002) = 'EI' )
	begin
		set @L2420A_ref02_EI_rendering_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420A' AND RTrim(@col002) = 'SY' )
	begin
		set @L2420A_ref02_SY_rendering_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2420A' AND RTrim(@col002) = 'FH' )
	begin
		set @L2420A_ref02_FH_rendering_prov_id = LTrim(RTrim(@col003))
	end
-- END LOOP: Line Item Rendering Provider
-- Line Item Service Facility Loop
	if ( RTrim(@col001) = 'NM1' AND Left(@curLoop, 2) = '24' AND
		(	RTrim(@col002) = '77' OR
			RTrim(@col002) = 'FA' OR
			RTrim(@col002) = 'LI' OR
			RTrim(@col002) = 'TL'
		)
	   )
	begin
		select	@curLoop = '2420C',
			@L2420C_nm101_entity_id_code = LTrim(RTrim(@col002)),
			@L2420C_nm102_entity_type_qual = LTrim(RTrim(@col003)),
			@L2420C_nm103_service_facility_last_nm = LTrim(RTrim(@col004)),
			@L2420C_nm108_id_code_qual = LTrim(RTrim(@col009)),
			@L2420C_nm109_service_facility_id = LTrim(RTrim(@col010))
	end
	if ( RTrim(@col001) = 'N3' AND @curLoop = '2420C' )
	begin
		select	@L2420C_n301_service_facility_address1 = LTrim(RTrim(@col002)),
			@L2420C_n302_service_facility_address2 = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'N4' AND @curLoop = '2420C' )
	begin
		select	@L2420C_n401_service_facility_city = LTrim(RTrim(@col002)),
			@L2420C_n402_service_facility_state = LTrim(RTrim(@col003)),
			@L2420C_n403_service_facility_zip = LTrim(RTrim(@col004)),
			@L2420C_n404_service_facility_country = LTrim(RTrim(@col005))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2420C' AND RTrim(@col002) = '1C' )
	begin
		set @L2420C_ref02_1C_service_facility_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2420C' AND RTrim(@col002) = '1D' )
	begin
		set @L2420C_ref02_1D_service_facility_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2420C' AND RTrim(@col002) = '1G' )
	begin
		set @L2420C_ref02_1G_service_facility_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2420C' AND RTrim(@col002) = 'G2' )
	begin
		set @L2420C_ref02_G2_service_facility_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2420C' AND RTrim(@col002) = 'TJ' )
	begin
		set @L2420C_ref02_TJ_service_facility_id = LTrim(RTrim(@col003))
	end
-- Line Item Supervising Provider Loop
	if ( RTrim(@col001) = 'NM1' AND RTrim(@col002) = 'DQ' AND LEFT(@curLoop, 2) = '24' )
	begin
		select	@curLoop = '2420D',
			@L2420D_nm102_entity_type_qual = LTrim(RTrim(@col003)),
			@L2420D_nm103_supervising_prov_last_nm = LTrim(RTrim(@col004)),
			@L2420D_nm104_supervising_prov_first_nm = LTrim(RTrim(@col005)),
			@L2420D_nm105_supervising_prov_middle_nm = LTrim(RTrim(@col006)),
			@L2420D_nm107_supervising_prov_suffix = LTrim(RTrim(@col008)),
			@L2420D_nm108_id_code_qual = LTrim(RTrim(@col009)),
			@L2420D_nm109_supervising_prov_id = LTrim(RTrim(@col010))
	end
-- Line Item Referring Provider Loop
	if ( RTrim(@col001) = 'NM1' AND (RTrim(@col002) = 'DN' OR RTrim(@col002) = 'P3') AND LEFT(@curLoop, 2) = '24' )
	begin
		select	@curLoop = '2420F',
			@L2420F_nm101_entity_id_code = LTrim(RTrim(@col002)),
			@L2420F_nm102_entity_type_qual = LTrim(RTrim(@col003)),
			@L2420F_nm103_referring_prov_last_nm = LTrim(RTrim(@col004)),
			@L2420F_nm104_referring_prov_first_nm = LTrim(RTrim(@col005)),
			@L2420F_nm105_referring_prov_middle_nm = LTrim(RTrim(@col006)),
			@L2420F_nm107_referring_prov_suffix = LTrim(RTrim(@col008)),
			@L2420F_nm108_id_code_qual = LTrim(RTrim(@col009)),
			@L2420F_nm109_referring_prov_id = LTrim(RTrim(@col010))
	end
	if ( RTrim(@col001) = 'PRV' AND @curLoop = '2420F' AND RTrim(@col002) = 'RF' )
	begin
		select	@L2420F_prv01_provider_code = LTrim(RTrim(@col002)),
			@L2420F_prv02_ref_id_qual = LTrim(RTrim(@col003)),
			@L2420F_prv03_taxonomy_code = LTrim(RTrim(@col004))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2420F' AND RTrim(@col002) = '1C' )
	begin
		set @L2420F_ref02_1C_referring_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2420F' AND RTrim(@col002) = '1D' )
	begin
		set @L2420F_ref02_1D_referring_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2420F' AND RTrim(@col002) = '1G' )
	begin
		set @L2420F_ref02_1G_referring_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2420F' AND RTrim(@col002) = 'EI' )
	begin
		set @L2420F_ref02_EI_referring_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2420F' AND RTrim(@col002) = 'SY' )
	begin
		set @L2420F_ref02_SY_referring_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2420F' AND RTrim(@col002) = 'FH' )
	begin
		set @L2420F_ref02_FH_referring_prov_id = LTrim(RTrim(@col003))
	end
	if (RTrim(@col001) = 'SVD')
	begin
		select	@curLoop = '2430',
			@L2430_svd01_other_payer_id = LTrim(RTrim(@col002)),
			@L2430_svd02_service_line_paid = CAST(LTrim(RTrim(@col003)) as money)
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
			@L2300_clm10_patient_signature_code = LTRIM(RTRIM(@Col011)),
/*		reserved for future use???
			@L2300_clm11_related_causes_code1 = LTRIM(RTRIM(@Col012)),
			@L2300_clm11_related_causes_code2 = LTRIM(RTRIM(@Col012)),
			@L2300_clm11_related_causes_code3 = LTRIM(RTRIM(@Col012)),
			@L2300_clm11_auto_accident_state_code = LTRIM(RTRIM(@Col012)),
			@L2300_clm11_country_code = LTRIM(RTRIM(@Col012)),
*/
			@L2300_clm12_special_prog_ind = LTRIM(RTRIM(@Col013)),
			@L2300_clm16_participation_agreement = LTRIM(RTRIM(@Col017)),
			@L2300_clm20_delay_reason_code = LTRIM(RTRIM(@Col021))
	end

	if (@curLoop = '2300')
	begin
		if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '454' )
		begin
			set @L2300_dtp03_454_initial_tmt_date = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '304' )
		begin
			set @L2300_dtp03_304_last_seen_date = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '431' )
		begin
			set @L2300_dtp03_431_onset_of_injury_date = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '453' )
		begin
			set @L2300_dtp03_453_acute_manifestation_date = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '438' )
		begin
			set @L2300_dtp03_438_symptom_date = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '439' )
		begin
			set @L2300_dtp03_439_accident_date = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '484' )
		begin
			set @L2300_dtp03_484_last_menstrual_period_date = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '455' )
		begin
			set @L2300_dtp03_455_last_xray_date = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '471' )
		begin
			set @L2300_dtp03_471_prescription_date = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '360' )
		begin
			set @L2300_dtp03_360_disability_begin_date = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '361' )
		begin
			set @L2300_dtp03_361_disability_end_date = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '297' )
		begin
			set @L2300_dtp03_297_last_worked_date = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '296' )
		begin
			set @L2300_dtp03_296_work_return_date = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '435' )
		begin
			set @L2300_dtp03_435_admission_date = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '096' )
		begin
			set @L2300_dtp03_096_discharge_date = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '090' )
		begin
			set @L2300_dtp03_090_assumed_care_date = LTRIM(RTRIM(@Col004))
		end
		if ( RTrim(@col001) = 'DTP' AND RTrim(@col002) = '091' )
		begin
			set @L2300_dtp03_091_relinquished_care_date = LTRIM(RTRIM(@Col004))
		end
	end

	if ( RTrim(@col001) = 'PWK' AND @CurLoop = '2300' )
	begin
		select	@L2300_pwk01_attachment_type_code = LTRIM(RTRIM(@Col002)),
			@L2300_pwk02_attachment_trans_code = LTRIM(RTRIM(@Col003)),
			@L2300_pwk06_attachment_control_num = LTRIM(RTRIM(@Col007))
	end
	
	if ( RTrim(@col001) = 'AMT' AND @CurLoop = '2300' AND RTrim(@col002) = 'F5' )
		set @L2300_amt02_patient_paid_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
	if ( RTrim(@col001) = 'AMT' AND @CurLoop = '2300' AND RTrim(@col002) = 'NE' )
		set @L2300_amt02_total_purchased_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
	
	if ( RTrim(@col001) = 'REF' AND @CurLoop = '2300' AND RTrim(@col002) = '9F' )
		set @L2300_ref02_9F_prior_auth_num = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @CurLoop = '2300' AND RTrim(@col002) = 'G1' )
		set @L2300_ref02_G1_referral_num = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @CurLoop = '2300' AND RTrim(@col002) = 'F8' )
		set @L2300_ref02_F8_original_ref_num = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @CurLoop = '2300' AND RTrim(@col002) = '9A' )
		set @L2300_ref02_9A_repriced_claim_num = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @CurLoop = '2300' AND RTrim(@col002) = '9C' )
		set @L2300_ref02_9C_adj_repriced_claim_num = LTRIM(RTRIM(@Col003))
	if ( RTrim(@col001) = 'REF' AND @CurLoop = '2300' AND RTrim(@col002) = 'EA' )
		set @L2300_ref02_EA_medical_record_num = LTRIM(RTRIM(@Col003))
	
	if ( RTrim(@col001) = 'K3' AND @CurLoop = '2300')
		set @L2300_k301_fixed_format_info = LTRIM(RTRIM(@Col002))
	
	if ( RTrim(@col001) = 'NTE' AND @CurLoop = '2300')
	begin
		select	@L2300_nte01_note_ref_code = LTRIM(RTRIM(@Col002)),
			@L2300_nte02_claim_note_text = LTRIM(RTRIM(@Col003))
	end
	if ( RTrim(@col001) = 'HI')
	begin
		select	@CurLoop = '2300',
			@L2300_hi01_diag_code = SUBSTRING( LTRIM(RTRIM(@Col002)), 4, LEN(LTRIM(RTRIM(@Col002)))-3 ),
			@L2300_hi02_diag_code = SUBSTRING( LTRIM(RTRIM(@Col003)), 4, LEN(LTRIM(RTRIM(@Col003)))-3 ),
			@L2300_hi03_diag_code = SUBSTRING( LTRIM(RTRIM(@Col004)), 4, LEN(LTRIM(RTRIM(@Col004)))-3 ),
			@L2300_hi04_diag_code = SUBSTRING( LTRIM(RTRIM(@Col005)), 4, LEN(LTRIM(RTRIM(@Col005)))-3 ),
			@L2300_hi05_diag_code = SUBSTRING( LTRIM(RTRIM(@Col006)), 4, LEN(LTRIM(RTRIM(@Col006)))-3 ),
			@L2300_hi06_diag_code = SUBSTRING( LTRIM(RTRIM(@Col007)), 4, LEN(LTRIM(RTRIM(@Col007)))-3 ),
			@L2300_hi07_diag_code = SUBSTRING( LTRIM(RTRIM(@Col008)), 4, LEN(LTRIM(RTRIM(@Col008)))-3 ),
			@L2300_hi08_diag_code = SUBSTRING( LTRIM(RTRIM(@Col009)), 4, LEN(LTRIM(RTRIM(@Col009)))-3 )
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
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310B' AND RTrim(@col002) = '1G' )
	begin
		set @L2310B_ref02_1G_rendering_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310B' AND RTrim(@col002) = 'EI' )
	begin
		set @L2310B_ref02_EI_rendering_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310B' AND RTrim(@col002) = 'SY' )
	begin
		set @L2310B_ref02_SY_rendering_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310B' AND RTrim(@col002) = 'FH' )
	begin
		set @L2310B_ref02_FH_rendering_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF'  AND @curLoop = '2310B' AND RTrim(@col002) = 'G2' )
	begin
		set @L2310B_ref02_G2_rendering_prov_id = LTrim(RTrim(@col003))
	end

-- END LOOP: Claim Rendering Provider
-- Claim Service Facility Loop
	if ( RTrim(@col001) = 'NM1' AND Left(@curLoop, 2) = '23' AND
		(	RTrim(@col002) = '77' OR
			RTrim(@col002) = 'FA' OR
			RTrim(@col002) = 'LI' OR
			RTrim(@col002) = 'TL'
		)
	   )
	begin
		select	@curLoop = '2310D',
			@L2310D_nm101_entity_id_code = LTrim(RTrim(@col002)),
			@L2310D_nm102_entity_type_qual = LTrim(RTrim(@col003)),
			@L2310D_nm103_service_facility_last_nm = LTrim(RTrim(@col004)),
			@L2310D_nm108_id_code_qual = LTrim(RTrim(@col009)),
			@L2310D_nm109_service_facility_id = LTrim(RTrim(@col010))
	end
	if ( RTrim(@col001) = 'N3' AND @curLoop = '2310D' )
	begin
		select	@L2310D_n301_service_facility_address1 = LTrim(RTrim(@col002)),
			@L2310D_n302_service_facility_address2 = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'N4' AND @curLoop = '2310D' )
	begin
		select	@L2310D_n401_service_facility_city = LTrim(RTrim(@col002)),
			@L2310D_n402_service_facility_state = LTrim(RTrim(@col003)),
			@L2310D_n403_service_facility_zip = LTrim(RTrim(@col004)),
			@L2310D_n404_service_facility_country = LTrim(RTrim(@col005))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310D' AND RTrim(@col002) = '1C' )
	begin
		set @L2310D_ref02_1C_service_facility_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310D' AND RTrim(@col002) = '1D' )
	begin
		set @L2310D_ref02_1D_service_facility_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310D' AND RTrim(@col002) = '1G' )
	begin
		set @L2310D_ref02_1G_service_facility_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310D' AND RTrim(@col002) = 'G2' )
	begin
		set @L2310D_ref02_G2_service_facility_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310D' AND RTrim(@col002) = 'TJ' )
	begin
		set @L2310D_ref02_TJ_service_facility_id = LTrim(RTrim(@col003))
	end
-- Claim Supervising Provider Loop
	if ( RTrim(@col001) = 'NM1' AND RTrim(@col002) = 'DQ' AND LEFT(@curLoop, 2) = '23' )
	begin
		select	@curLoop = '2310E',
			@L2310E_nm102_entity_type_qual = LTrim(RTrim(@col003)),
			@L2310E_nm103_supervising_prov_last_nm = LTrim(RTrim(@col004)),
			@L2310E_nm104_supervising_prov_first_nm = LTrim(RTrim(@col005)),
			@L2310E_nm105_supervising_prov_middle_nm = LTrim(RTrim(@col006)),
			@L2310E_nm107_supervising_prov_suffix = LTrim(RTrim(@col008)),
			@L2310E_nm108_id_code_qual = LTrim(RTrim(@col009)),
			@L2310E_nm109_supervising_prov_id = LTrim(RTrim(@col010))
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
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310A' AND RTrim(@col002) = '1G' )
	begin
		set @L2310A_ref02_1G_referring_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310A' AND RTrim(@col002) = 'EI' )
	begin
		set @L2310A_ref02_EI_referring_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310A' AND RTrim(@col002) = 'SY' )
	begin
		set @L2310A_ref02_SY_referring_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310A' AND RTrim(@col002) = 'FH' )
	begin
		set @L2310A_ref02_FH_referring_prov_id = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'REF' AND @curLoop = '2310A' AND RTrim(@col002) = 'G2' )
	begin
		set @L2310A_ref02_G2_referring_prov_id = LTrim(RTrim(@col003))
	end

	if ( RTrim(@col001) = 'SBR' AND @curLoop LIKE '23%' )
	begin
		select	@curLoop = '2320',
			@L2320_sbr01_payer_resp_seq_code = LTrim(RTrim(@col002)),
			@L2320_sbr02_ind_relationship_code = LTrim(RTrim(@col003)),
			@L2320_sbr03_insured_grp_policy_num = LTrim(RTrim(@col004)),
			@L2320_sbr04_insured_grp_nm = LTrim(RTrim(@col005)),
			@L2320_sbr05_insurance_type_code = LTrim(RTrim(@col006)),
			@L2320_sbr09_claim_filing_ind_code = LTrim(RTrim(@col010))
	end
	if ( RTrim(@col001) = 'CAS' AND @curLoop LIKE '23%' )
	begin
		select	@curLoop = '2320',
			@L2320_cas01_adjustment_group_code = LTrim(RTrim(@col002)),
			@L2320_cas02_adjustment_reason_code = LTrim(RTrim(@col003)),
			@L2320_cas03_adjustment_amt = CAST(LTrim(RTrim(@col004)) as money),
			@L2320_cas04_adjustment_qty = LTrim(RTrim(@col005)),
			@L2320_cas05_adjustment_reason_code = LTrim(RTrim(@col006)),
			@L2320_cas06_adjustment_amt = CAST(LTrim(RTrim(@col007)) as money),
			@L2320_cas07_adjustment_qty = LTrim(RTrim(@col008)),
			@L2320_cas08_adjustment_reason_code = LTrim(RTrim(@col009)),
			@L2320_cas09_adjustment_amt = CAST(LTrim(RTrim(@col010)) as money),
			@L2320_cas10_adjustment_qty = LTrim(RTrim(@col011))

	end

	if ( LTRim(RTrim(@col001)) = 'AMT' AND @curLoop = '2320' )
	begin
		set @curLoop = '2320'
		if (LTrim(RTrim(@col002)) = 'D')
		begin
			set @L2320_amt02_D_payer_paid_amt = CAST(LTrim(RTrim(@col003)) as money)
		end
		if (LTrim(RTrim(@col002)) = 'AAE')
		begin
			set @L2320_amt02_AAE_approved_amt = CAST(LTrim(RTrim(@col003)) as money)
		end
		if (LTrim(RTrim(@col002)) = 'B6')
		begin
			set @L2320_amt02_B6_allowed_amt = CAST(LTrim(RTrim(@col003)) as money)
		end
		if (LTrim(RTrim(@col002)) = 'F2')
		begin
			set @L2320_amt02_F2_pt_responsibility_amt = CAST(LTrim(RTrim(@col003)) as money)
		end
		if (LTrim(RTrim(@col002)) = 'AU')
		begin
			set @L2320_amt02_AU_covered_amt = CAST(LTrim(RTrim(@col003)) as money)
		end
		if (LTrim(RTrim(@col002)) = 'D8')
		begin
			set @L2320_amt02_D8_discount_amt = CAST(LTrim(RTrim(@col003)) as money)
		end
		if (LTrim(RTrim(@col002)) = 'DY')
		begin
			set @L2320_amt02_DY_per_day_limit_amt = CAST(LTrim(RTrim(@col003)) as money)
		end
		if (LTrim(RTrim(@col002)) = 'F5')
		begin
			set @L2320_amt02_F5_pt_paid_amt = CAST(LTrim(RTrim(@col003)) as money)
		end
		if (LTrim(RTrim(@col002)) = 'T')
		begin
			set @L2320_amt02_T_tax_amt = CAST(LTrim(RTrim(@col003)) as money)
		end
		if (LTrim(RTrim(@col002)) = 'T2')
		begin
			set @L2320_amt02_T2_total_clm_before_tax_amt = CAST(LTrim(RTrim(@col003)) as money)
		end
	end

	if ( RTrim(@col001) = 'DMG' AND @curLoop LIKE '23%' )
	begin
		select	@curLoop = '2320',
			@L2320_dmg02_other_subscriber_dob = LTrim(RTrim(@col003)),
			@L2320_dmg03_other_subscriber_gender = LTrim(RTrim(@col004))
	end

	if ( RTrim(@col001) = 'OI' AND @curLoop LIKE '23%' )
	begin
		select	@curLoop = '2320',
			@L2320_oi03_other_ins_benefit_assign_ind = LTrim(RTrim(@col004)),
			@L2320_oi04_other_ins_patient_signature_code = LTrim(RTrim(@col005)),
			@L2320_oi06_other_ins_release_of_info_code = LTrim(RTrim(@col007))
	end

	if ( RTrim(@col001) = 'NM1' AND @curLoop LIKE '23%' AND RTrim(@col002) = 'IL')
	begin
		select	@curLoop = '2330A',
			@L2330A_nm101_entity_id_code = LTrim(RTrim(@col002)),
			@L2330A_nm102_entity_type_qual = LTrim(RTrim(@col003)),
			@L2330A_nm103_other_insured_last_name = LTrim(RTrim(@col004)),
			@L2330A_nm104_other_insured_first_name = LTrim(RTrim(@col005)),
			@L2330A_nm105_other_insured_middle_name = LTrim(RTrim(@col006)),
			@L2330A_nm107_other_insured_name_suffix = LTrim(RTrim(@col008)),
			@L2330A_nm108_other_insured_id_code_qual = LTrim(RTrim(@col009)),
			@L2330A_nm109_other_insured_id = LTrim(RTrim(@col010))
	end

	if ( RTrim(@col001) = 'NM1' AND @curLoop LIKE '23%' AND RTrim(@col002) = 'PR')
	begin
		select	@curLoop = '2330B',
			@L2330B_nm101_entity_id_code = LTrim(RTrim(@col002)),
			@L2330B_nm102_entity_type_qual = LTrim(RTrim(@col003)),
			@L2330B_nm103_other_payer_nm = LTrim(RTrim(@col004)),
			@L2330B_nm108_id_code_qual = LTrim(RTrim(@col009)),
			@L2330B_nm109_other_payer_id = LTrim(RTrim(@col010))
	end

	if ( LTrim(RTrim(@col001)) = 'DTP' AND @curLoop = '2330B' AND LTrim(RTrim(@col002)) = '573')
	begin
		select	@curLoop = '2330B',
			@L2330B_dtp03_573_date_claim_paid = LTrim(RTrim(@col004))
	end

	if ( RTrim(@col001) = 'REF' AND @curLoop = '2330B')
	begin
		set @curLoop = '2330B'
		if (LTrim(RTrim(@col002)) = '2U')
		begin
			set @L2330B_ref02_2U_other_payer_secondary_id = LTrim(RTrim(@col003))
		end
		if (LTrim(RTrim(@col002)) = 'F8')
		begin
			set @L2330B_ref02_F8_other_payer_secondary_id = LTrim(RTrim(@col003))
		end
		if (LTrim(RTrim(@col002)) = 'FY')
		begin
			set @L2330B_ref02_FY_other_payer_secondary_id = LTrim(RTrim(@col003))
		end
		if (LTrim(RTrim(@col002)) = 'NF')
		begin
			set @L2330B_ref02_NF_other_payer_secondary_id = LTrim(RTrim(@col003))
		end
		if (LTrim(RTrim(@col002)) = 'TJ')
		begin
			set @L2330B_ref02_TJ_other_payer_secondary_id = LTrim(RTrim(@col003))
		end
	end

	FETCH NEXT FROM curt837p INTO @Col001, @Col002, @Col003, @Col004, @Col005, @Col006, @Col007, @Col008, @Col009, @Col010, @Col011, @Col012, @Col013, @Col014, @Col015, @Col016, @Col017, @Col018, @Col019, @Col020, @Col021
END
CLOSE curt837p
DEALLOCATE curt837p

		
EXEC dbo.up_x12_837p_insert 
	@bht01_hierarchical_structure_code = @bht01_hierarchical_structure_code,
    @bht02_trans_set_purpose_code = @bht02_trans_set_purpose_code,
    @bht03_orig_app_tran_id = @bht03_orig_app_tran_id,
    @bht04_trans_set_creation_date = @bht04_trans_set_creation_date,
    @bht05_trans_set_creation_time = @bht05_trans_set_creation_time,
    @bht06_claim_encounter_id = @bht06_claim_encounter_id,
    @L1000A_nm102_entity_type_qual = @L1000A_nm102_entity_type_qual,
    @L1000A_nm103_submitter_last_nm = @L1000A_nm103_submitter_last_nm,
    @L1000A_nm104_submitter_first_nm = @L1000A_nm104_submitter_first_nm,
    @L1000A_nm105_submitter_middle_nm = @L1000A_nm105_submitter_middle_nm,
    @L1000A_nm108_submitter_id_qual = @L1000A_nm108_submitter_id_qual,
    @L1000A_nm109_submitter_id = @L1000A_nm109_submitter_id,
    @L1000A_per01_contact_function_code = @L1000A_per01_contact_function_code,
    @L1000A_per02_contact_nm = @L1000A_per02_contact_nm,
    @L1000A_per03_comm_num_qual = @L1000A_per03_comm_num_qual,
    @L1000A_per04_comm_number = @L1000A_per04_comm_number,
    @L1000B_nm102_entity_type_qual = @L1000B_nm102_entity_type_qual,
    @L1000B_nm103_receiver_last_nm = @L1000B_nm103_receiver_last_nm,
    @L1000B_nm108_receiver_id_qual = @L1000B_nm108_receiver_id_qual,
    @L1000B_nm109_receiver_id = @L1000B_nm109_receiver_id,
    @L2000A_cur02_currency_code = @L2000A_cur02_currency_code,
    @L2000A_hl01_hierarchical_id_num = @L2000A_hl01_hierarchical_id_num,
    @L2000A_hl03_hierarchical_level_code = @L2000A_hl03_hierarchical_level_code,
    @L2000A_hl04_hierarchical_child_code = @L2000A_hl04_hierarchical_child_code,
    @L2000A_prv01_provider_code = @L2000A_prv01_provider_code,
    @L2000A_prv02_ref_id_qual = @L2000A_prv02_ref_id_qual,
    @L2000A_prv03_taxonomy_code = @L2000A_prv03_taxonomy_code,
    @L2000B_hl01_hierarchical_id_num = @L2000B_hl01_hierarchical_id_num,
    @L2000B_hl02_hierarchical_parent_id_num = @L2000B_hl02_hierarchical_parent_id_num,
    @L2000B_hl03_hierarchical_level_code = @L2000B_hl03_hierarchical_level_code,
    @L2000B_hl04_hierarchical_child_code = @L2000B_hl04_hierarchical_child_code,
    @L2000B_pat06_insured_ind_death_date = @L2000B_pat06_insured_ind_death_date,
    @L2000B_pat08_patient_weight = @L2000B_pat08_patient_weight,
    @L2000B_pat09_pregnancy_indicator = @L2000B_pat09_pregnancy_indicator,
    @L2000B_sbr01_payer_resp_seq_code = @L2000B_sbr01_payer_resp_seq_code,
    @L2000B_sbr02_ind_relationship_code = @L2000B_sbr02_ind_relationship_code,
    @L2000B_sbr03_insured_grp_policy_num = @L2000B_sbr03_insured_grp_policy_num,
    @L2000B_sbr04_insured_grp_nm = @L2000B_sbr04_insured_grp_nm,
    @L2000B_sbr05_insurance_type_code = @L2000B_sbr05_insurance_type_code,
    @L2000B_sbr09_claim_filing_ind_code = @L2000B_sbr09_claim_filing_ind_code,
    @L2000C_hl01_hierarchical_id_num = @L2000C_hl01_hierarchical_id_num,
    @L2000C_hl02_hierarchical_parent_id_num = @L2000C_hl02_hierarchical_parent_id_num,
    @L2000C_hl03_hierarchical_level_code = @L2000C_hl03_hierarchical_level_code,
    @L2000C_hl04_hierarchical_child_code = @L2000C_hl04_hierarchical_child_code,
    @L2000C_pat01_ind_relationship_code = @L2000C_pat01_ind_relationship_code,
    @L2000C_pat06_insured_ind_death_date = @L2000C_pat06_insured_ind_death_date,
    @L2000C_pat08_patient_weight = @L2000C_pat08_patient_weight,
    @L2000C_pat09_pregnancy_indicator = @L2000C_pat09_pregnancy_indicator,
    @L2010AA_n301_billing_prov_address1 = @L2010AA_n301_billing_prov_address1,
    @L2010AA_n302_billing_prov_address2 = @L2010AA_n302_billing_prov_address2,
    @L2010AA_n401_billing_prov_city = @L2010AA_n401_billing_prov_city,
    @L2010AA_n402_billing_prov_state = @L2010AA_n402_billing_prov_state,
    @L2010AA_n403_billing_prov_zip = @L2010AA_n403_billing_prov_zip,
    @L2010AA_n404_billing_prov_country = @L2010AA_n404_billing_prov_country,
    @L2010AA_nm102_entity_type_qual = @L2010AA_nm102_entity_type_qual,
    @L2010AA_nm103_billing_prov_last_nm = @L2010AA_nm103_billing_prov_last_nm,
    @L2010AA_nm104_billing_prov_first_nm = @L2010AA_nm104_billing_prov_first_nm,
    @L2010AA_nm105_billing_prov_middle_nm = @L2010AA_nm105_billing_prov_middle_nm,
    @L2010AA_nm107_billing_prov_suffix = @L2010AA_nm107_billing_prov_suffix,
    @L2010AA_nm108_id_code_qual = @L2010AA_nm108_id_code_qual,
    @L2010AA_nm109_billing_prov_id = @L2010AA_nm109_billing_prov_id,
    @L2010AA_per01_billing_prov_comm_func_code = @L2010AA_per01_billing_prov_comm_func_code,
    @L2010AA_per02_billing_prov_contact_nm = @L2010AA_per02_billing_prov_contact_nm,
    @L2010AA_per03_billing_prov_comm_num_qual = @L2010AA_per03_billing_prov_comm_num_qual,
    @L2010AA_per04_billing_prov_comm = @L2010AA_per04_billing_prov_comm,
    @L2010AA_ref02_06_card_billing_id = @L2010AA_ref02_06_card_billing_id,
    @L2010AA_ref02_1C_billing_prov_id = @L2010AA_ref02_1C_billing_prov_id,
    @L2010AA_ref02_1D_billing_prov_id = @L2010AA_ref02_1D_billing_prov_id,
    @L2010AA_ref02_1G_billing_prov_id = @L2010AA_ref02_1G_billing_prov_id,
    @L2010AA_ref02_8U_card_billing_id = @L2010AA_ref02_8U_card_billing_id,
    @L2010AA_ref02_EI_billing_prov_id = @L2010AA_ref02_EI_billing_prov_id,
    @L2010AA_ref02_EM_card_billing_id = @L2010AA_ref02_EM_card_billing_id,
    @L2010AA_ref02_FH_billing_prov_id = @L2010AA_ref02_FH_billing_prov_id,
    @L2010AA_ref02_IJ_card_billing_id = @L2010AA_ref02_IJ_card_billing_id,
    @L2010AA_ref02_LU_card_billing_id = @L2010AA_ref02_LU_card_billing_id,
    @L2010AA_ref02_ST_card_billing_id = @L2010AA_ref02_ST_card_billing_id,
    @L2010AA_ref02_SY_billing_prov_id = @L2010AA_ref02_SY_billing_prov_id,
    @L2010AB_n301_payto_prov_address1 = @L2010AB_n301_payto_prov_address1,
    @L2010AB_n302_payto_prov_address2 = @L2010AB_n302_payto_prov_address2,
    @L2010AB_n401_payto_prov_city = @L2010AB_n401_payto_prov_city,
    @L2010AB_n402_payto_prov_state = @L2010AB_n402_payto_prov_state,
    @L2010AB_n403_payto_prov_zip = @L2010AB_n403_payto_prov_zip,
    @L2010AB_n404_payto_prov_country = @L2010AB_n404_payto_prov_country,
    @L2010AB_nm102_entity_type_qual = @L2010AB_nm102_entity_type_qual,
    @L2010AB_nm103_payto_prov_last_nm = @L2010AB_nm103_payto_prov_last_nm,
    @L2010AB_nm104_payto_prov_first_nm = @L2010AB_nm104_payto_prov_first_nm,
    @L2010AB_nm105_payto_prov_middle_nm = @L2010AB_nm105_payto_prov_middle_nm,
    @L2010AB_nm107_payto_prov_suffix = @L2010AB_nm107_payto_prov_suffix,
    @L2010AB_nm108_id_code_qual = @L2010AB_nm108_id_code_qual,
    @L2010AB_nm109_payto_prov_id = @L2010AB_nm109_payto_prov_id,
    @L2010AB_ref02_1C_payto_prov_id = @L2010AB_ref02_1C_payto_prov_id,
    @L2010AB_ref02_1D_payto_prov_id = @L2010AB_ref02_1D_payto_prov_id,
    @L2010AB_ref02_1G_payto_prov_id = @L2010AB_ref02_1G_payto_prov_id,
    @L2010AB_ref02_EI_payto_prov_id = @L2010AB_ref02_EI_payto_prov_id,
    @L2010AB_ref02_FH_payto_prov_id = @L2010AB_ref02_FH_payto_prov_id,
    @L2010AB_ref02_SY_payto_prov_id = @L2010AB_ref02_SY_payto_prov_id,
    @L2010BA_dmg02_subscriber_dob = @L2010BA_dmg02_subscriber_dob,
    @L2010BA_dmg03_subscriber_gender = @L2010BA_dmg03_subscriber_gender,
    @L2010BA_n301_subscriber_address1 = @L2010BA_n301_subscriber_address1,
    @L2010BA_n302_subscriber_address2 = @L2010BA_n302_subscriber_address2,
    @L2010BA_n401_subscriber_city = @L2010BA_n401_subscriber_city,
    @L2010BA_n402_subscriber_state = @L2010BA_n402_subscriber_state,
    @L2010BA_n403_subscriber_zip = @L2010BA_n403_subscriber_zip,
    @L2010BA_n404_subscriber_country = @L2010BA_n404_subscriber_country,
    @L2010BA_nm102_entity_type_qual = @L2010BA_nm102_entity_type_qual,
    @L2010BA_nm103_subscriber_last_nm = @L2010BA_nm103_subscriber_last_nm,
    @L2010BA_nm104_subscriber_first_nm = @L2010BA_nm104_subscriber_first_nm,
    @L2010BA_nm105_subscriber_middle_nm = @L2010BA_nm105_subscriber_middle_nm,
    @L2010BA_nm107_subscriber_suffix = @L2010BA_nm107_subscriber_suffix,
    @L2010BA_nm108_id_code_qual = @L2010BA_nm108_id_code_qual,
    @L2010BA_nm109_subscriber_id = @L2010BA_nm109_subscriber_id,
    @L2010BA_ref02_1W_subscriber_sup_id = @L2010BA_ref02_1W_subscriber_sup_id,
    @L2010BA_ref02_23_subscriber_sup_id = @L2010BA_ref02_23_subscriber_sup_id,
    @L2010BA_ref02_IG_subscriber_sup_id = @L2010BA_ref02_IG_subscriber_sup_id,
    @L2010BA_ref02_SY_subscriber_sup_id = @L2010BA_ref02_SY_subscriber_sup_id,
    @L2010BA_ref02_Y4_prop_casualty_claim_num = @L2010BA_ref02_Y4_prop_casualty_claim_num,
    @L2010BB_n301_payer_address1 = @L2010BB_n301_payer_address1,
    @L2010BB_n302_payer_address2 = @L2010BB_n302_payer_address2,
    @L2010BB_n401_payer_city = @L2010BB_n401_payer_city,
    @L2010BB_n402_payer_state = @L2010BB_n402_payer_state,
    @L2010BB_n403_payer_zip = @L2010BB_n403_payer_zip,
    @L2010BB_n404_payer_country = @L2010BB_n404_payer_country,
    @L2010BB_nm102_entity_type_qual = @L2010BB_nm102_entity_type_qual,
    @L2010BB_nm103_payer_nm = @L2010BB_nm103_payer_nm,
    @L2010BB_nm108_payer_id_qual = @L2010BB_nm108_payer_id_qual,
    @L2010BB_nm109_payer_id = @L2010BB_nm109_payer_id,
    @L2010BB_ref02_2U_payer_id = @L2010BB_ref02_2U_payer_id,
    @L2010BB_ref02_FY_payer_id = @L2010BB_ref02_FY_payer_id,
    @L2010BB_ref02_NF_payer_id = @L2010BB_ref02_NF_payer_id,
    @L2010BB_ref02_TJ_payer_id = @L2010BB_ref02_TJ_payer_id,
    @L2010BC_n301_resp_party_address1 = @L2010BC_n301_resp_party_address1,
    @L2010BC_n302_resp_party_address2 = @L2010BC_n302_resp_party_address2,
    @L2010BC_n401_resp_party_city = @L2010BC_n401_resp_party_city,
    @L2010BC_n402_resp_party_state = @L2010BC_n402_resp_party_state,
    @L2010BC_n403_resp_party_zip = @L2010BC_n403_resp_party_zip,
    @L2010BC_n404_resp_party_country = @L2010BC_n404_resp_party_country,
    @L2010BC_nm102_entity_type_qual = @L2010BC_nm102_entity_type_qual,
    @L2010BC_nm103_resp_party_last_nm = @L2010BC_nm103_resp_party_last_nm,
    @L2010BC_nm104_resp_party_first_nm = @L2010BC_nm104_resp_party_first_nm,
    @L2010BC_nm105_resp_party_middle_nm = @L2010BC_nm105_resp_party_middle_nm,
    @L2010BC_nm107_resp_party_suffix = @L2010BC_nm107_resp_party_suffix,
    @L2010BD_nm102_entity_type_qual = @L2010BD_nm102_entity_type_qual,
    @L2010BD_nm103_card_holder_last_nm = @L2010BD_nm103_card_holder_last_nm,
    @L2010BD_nm104_card_holder_first_nm = @L2010BD_nm104_card_holder_first_nm,
    @L2010BD_nm105_card_holder_middle_nm = @L2010BD_nm105_card_holder_middle_nm,
    @L2010BD_nm107_card_holder_suffix = @L2010BD_nm107_card_holder_suffix,
    @L2010BD_nm108_card_id_qual = @L2010BD_nm108_card_id_qual,
    @L2010BD_nm109_card_num = @L2010BD_nm109_card_num,
    @L2010BD_ref02_AB_card_num = @L2010BD_ref02_AB_card_num,
    @L2010BD_ref02_BB_card_num = @L2010BD_ref02_BB_card_num,
    @L2010CA_dmg02_patient_dob = @L2010CA_dmg02_patient_dob,
    @L2010CA_dmg03_patient_gender = @L2010CA_dmg03_patient_gender,
    @L2010CA_n301_patient_address1 = @L2010CA_n301_patient_address1,
    @L2010CA_n302_patient_address2 = @L2010CA_n302_patient_address2,
    @L2010CA_n401_patient_city = @L2010CA_n401_patient_city,
    @L2010CA_n402_patient_state = @L2010CA_n402_patient_state,
    @L2010CA_n403_patient_zip = @L2010CA_n403_patient_zip,
    @L2010CA_n404_patient_country = @L2010CA_n404_patient_country,
    @L2010CA_nm102_entity_type_qual = @L2010CA_nm102_entity_type_qual,
    @L2010CA_nm103_patient_last_nm = @L2010CA_nm103_patient_last_nm,
    @L2010CA_nm104_patient_first_nm = @L2010CA_nm104_patient_first_nm,
    @L2010CA_nm105_patient_middle_nm = @L2010CA_nm105_patient_middle_nm,
    @L2010CA_nm107_patient_suffix = @L2010CA_nm107_patient_suffix,
    @L2010CA_nm108_id_code_qual = @L2010CA_nm108_id_code_qual,
    @L2010CA_nm109_patient_id = @L2010CA_nm109_patient_id,
    @L2010CA_ref02_1W_patient_sup_id = @L2010CA_ref02_1W_patient_sup_id,
    @L2010CA_ref02_23_patient_sup_id = @L2010CA_ref02_23_patient_sup_id,
    @L2010CA_ref02_IG_patient_sup_id = @L2010CA_ref02_IG_patient_sup_id,
    @L2010CA_ref02_SY_patient_sup_id = @L2010CA_ref02_SY_patient_sup_id,
    @L2010CA_ref02_Y4_prop_casualty_claim_num = @L2010CA_ref02_Y4_prop_casualty_claim_num,
    @L2300_amt02_patient_paid_amt = @L2300_amt02_patient_paid_amt,
    @L2300_amt02_total_purchased_amt = @L2300_amt02_total_purchased_amt,
    @L2300_clm01_pt_acct_num = @L2300_clm01_pt_acct_num,
    @L2300_clm02_total_claim_chg_amt = @L2300_clm02_total_claim_chg_amt,
    @L2300_clm05_claim_freq_code = @L2300_clm05_claim_freq_code,
    @L2300_clm05_facility_type_code = @L2300_clm05_facility_type_code,
    @L2300_clm06_provider_signature_ind = @L2300_clm06_provider_signature_ind,
    @L2300_clm07_medicare_assign_code = @L2300_clm07_medicare_assign_code,
    @L2300_clm08_benefit_assign_ind = @L2300_clm08_benefit_assign_ind,
    @L2300_clm09_release_of_info_code = @L2300_clm09_release_of_info_code,
    @L2300_clm10_patient_signature_code = @L2300_clm10_patient_signature_code,
    @L2300_clm11_auto_accident_state_code = @L2300_clm11_auto_accident_state_code,
    @L2300_clm11_country_code = @L2300_clm11_country_code,
    @L2300_clm11_related_causes_code1 = @L2300_clm11_related_causes_code1,
    @L2300_clm11_related_causes_code2 = @L2300_clm11_related_causes_code2,
    @L2300_clm11_related_causes_code3 = @L2300_clm11_related_causes_code3,
    @L2300_clm12_special_prog_ind = @L2300_clm12_special_prog_ind,
    @L2300_clm16_participation_agreement = @L2300_clm16_participation_agreement,
    @L2300_clm20_delay_reason_code = @L2300_clm20_delay_reason_code,
    @L2300_dtp03_090_assumed_care_date = @L2300_dtp03_090_assumed_care_date,
    @L2300_dtp03_091_relinquished_care_date = @L2300_dtp03_091_relinquished_care_date,
    @L2300_dtp03_096_discharge_date = @L2300_dtp03_096_discharge_date,
    @L2300_dtp03_296_work_return_date = @L2300_dtp03_296_work_return_date,
    @L2300_dtp03_297_last_worked_date = @L2300_dtp03_297_last_worked_date,
    @L2300_dtp03_304_last_seen_date = @L2300_dtp03_304_last_seen_date,
    @L2300_dtp03_360_disability_begin_date = @L2300_dtp03_360_disability_begin_date,
    @L2300_dtp03_361_disability_end_date = @L2300_dtp03_361_disability_end_date,
    @L2300_dtp03_431_onset_of_injury_date = @L2300_dtp03_431_onset_of_injury_date,
    @L2300_dtp03_435_admission_date = @L2300_dtp03_435_admission_date,
    @L2300_dtp03_438_symptom_date = @L2300_dtp03_438_symptom_date,
    @L2300_dtp03_439_accident_date = @L2300_dtp03_439_accident_date,
    @L2300_dtp03_453_acute_manifestation_date = @L2300_dtp03_453_acute_manifestation_date,
    @L2300_dtp03_454_initial_tmt_date = @L2300_dtp03_454_initial_tmt_date,
    @L2300_dtp03_455_last_xray_date = @L2300_dtp03_455_last_xray_date,
    @L2300_dtp03_471_prescription_date = @L2300_dtp03_471_prescription_date,
    @L2300_dtp03_484_last_menstrual_period_date = @L2300_dtp03_484_last_menstrual_period_date,
    @L2300_hi01_diag_code = @L2300_hi01_diag_code,
    @L2300_hi02_diag_code = @L2300_hi02_diag_code,
    @L2300_hi03_diag_code = @L2300_hi03_diag_code,
    @L2300_hi04_diag_code = @L2300_hi04_diag_code,
    @L2300_hi05_diag_code = @L2300_hi05_diag_code,
    @L2300_hi06_diag_code = @L2300_hi06_diag_code,
    @L2300_hi07_diag_code = @L2300_hi07_diag_code,
    @L2300_hi08_diag_code = @L2300_hi08_diag_code,
    @L2300_k301_fixed_format_info = @L2300_k301_fixed_format_info,
    @L2300_nte01_note_ref_code = @L2300_nte01_note_ref_code,
    @L2300_nte02_claim_note_text = @L2300_nte02_claim_note_text,
    @L2300_pwk01_attachment_type_code = @L2300_pwk01_attachment_type_code,
    @L2300_pwk02_attachment_trans_code = @L2300_pwk02_attachment_trans_code,
    @L2300_pwk06_attachment_control_num = @L2300_pwk06_attachment_control_num,
    @L2300_ref02_9A_repriced_claim_num = @L2300_ref02_9A_repriced_claim_num,
    @L2300_ref02_9C_adj_repriced_claim_num = @L2300_ref02_9C_adj_repriced_claim_num,
    @L2300_ref02_9F_prior_auth_num = @L2300_ref02_9F_prior_auth_num,
    @L2300_ref02_EA_medical_record_num = @L2300_ref02_EA_medical_record_num,
    @L2300_ref02_F8_original_ref_num = @L2300_ref02_F8_original_ref_num,
    @L2300_ref02_G1_referral_num = @L2300_ref02_G1_referral_num,
    @L2310A_nm101_entity_id_code = @L2310A_nm101_entity_id_code,
    @L2310A_nm102_entity_type_qual = @L2310A_nm102_entity_type_qual,
    @L2310A_nm103_referring_prov_last_nm = @L2310A_nm103_referring_prov_last_nm,
    @L2310A_nm104_referring_prov_first_nm = @L2310A_nm104_referring_prov_first_nm,
    @L2310A_nm105_referring_prov_middle_nm = @L2310A_nm105_referring_prov_middle_nm,
    @L2310A_nm107_referring_prov_suffix = @L2310A_nm107_referring_prov_suffix,
    @L2310A_nm108_id_code_qual = @L2310A_nm108_id_code_qual,
    @L2310A_nm109_referring_prov_id = @L2310A_nm109_referring_prov_id,
    @L2310A_prv01_provider_code = @L2310A_prv01_provider_code,
    @L2310A_prv02_ref_id_qual = @L2310A_prv02_ref_id_qual,
    @L2310A_prv03_taxonomy_code = @L2310A_prv03_taxonomy_code,
    @L2310A_ref02_1C_referring_prov_id = @L2310A_ref02_1C_referring_prov_id,
    @L2310A_ref02_1D_referring_prov_id = @L2310A_ref02_1D_referring_prov_id,
    @L2310A_ref02_1G_referring_prov_id = @L2310A_ref02_1G_referring_prov_id,
    @L2310A_ref02_EI_referring_prov_id = @L2310A_ref02_EI_referring_prov_id,
    @L2310A_ref02_FH_referring_prov_id = @L2310A_ref02_FH_referring_prov_id,
    @L2310A_ref02_G2_referring_prov_id = @L2310A_ref02_G2_referring_prov_id,
    @L2310A_ref02_SY_referring_prov_id = @L2310A_ref02_SY_referring_prov_id,
    @L2310B_nm102_entity_type_qual = @L2310B_nm102_entity_type_qual,
    @L2310B_nm103_rendering_prov_last_nm = @L2310B_nm103_rendering_prov_last_nm,
    @L2310B_nm104_rendering_prov_first_nm = @L2310B_nm104_rendering_prov_first_nm,
    @L2310B_nm105_rendering_prov_middle_nm = @L2310B_nm105_rendering_prov_middle_nm,
    @L2310B_nm107_rendering_prov_suffix = @L2310B_nm107_rendering_prov_suffix,
    @L2310B_nm108_id_code_qual = @L2310B_nm108_id_code_qual,
    @L2310B_nm109_rendering_prov_id = @L2310B_nm109_rendering_prov_id,
    @L2310B_prv01_provider_code = @L2310B_prv01_provider_code,
    @L2310B_prv02_ref_id_qual = @L2310B_prv02_ref_id_qual,
    @L2310B_prv03_taxonomy_code = @L2310B_prv03_taxonomy_code,
    @L2310B_ref02_1C_rendering_prov_id = @L2310B_ref02_1C_rendering_prov_id,
    @L2310B_ref02_1D_rendering_prov_id = @L2310B_ref02_1D_rendering_prov_id,
    @L2310B_ref02_1G_rendering_prov_id = @L2310B_ref02_1G_rendering_prov_id,
    @L2310B_ref02_EI_rendering_prov_id = @L2310B_ref02_EI_rendering_prov_id,
    @L2310B_ref02_FH_rendering_prov_id = @L2310B_ref02_FH_rendering_prov_id,
    @L2310B_ref02_G2_rendering_prov_id = @L2310B_ref02_G2_rendering_prov_id,
    @L2310B_ref02_SY_rendering_prov_id = @L2310B_ref02_SY_rendering_prov_id,
    @L2310D_n301_service_facility_address1 = @L2310D_n301_service_facility_address1,
    @L2310D_n302_service_facility_address2 = @L2310D_n302_service_facility_address2,
    @L2310D_n401_service_facility_city = @L2310D_n401_service_facility_city,
    @L2310D_n402_service_facility_state = @L2310D_n402_service_facility_state,
    @L2310D_n403_service_facility_zip = @L2310D_n403_service_facility_zip,
    @L2310D_n404_service_facility_country = @L2310D_n404_service_facility_country,
    @L2310D_nm101_entity_id_code = @L2310D_nm101_entity_id_code,
    @L2310D_nm102_entity_type_qual = @L2310D_nm102_entity_type_qual,
    @L2310D_nm103_service_facility_last_nm = @L2310D_nm103_service_facility_last_nm,
    @L2310D_nm108_id_code_qual = @L2310D_nm108_id_code_qual,
    @L2310D_nm109_service_facility_id = @L2310D_nm109_service_facility_id,
    @L2310D_ref02_1C_service_facility_id = @L2310D_ref02_1C_service_facility_id,
    @L2310D_ref02_1D_service_facility_id = @L2310D_ref02_1D_service_facility_id,
    @L2310D_ref02_1G_service_facility_id = @L2310D_ref02_1G_service_facility_id,
    @L2310D_ref02_G2_service_facility_id = @L2310D_ref02_G2_service_facility_id,
    @L2310D_ref02_TJ_service_facility_id = @L2310D_ref02_TJ_service_facility_id,
    @L2310E_nm102_entity_type_qual = @L2310E_nm102_entity_type_qual,
    @L2310E_nm103_supervising_prov_last_nm = @L2310E_nm103_supervising_prov_last_nm,
    @L2310E_nm104_supervising_prov_first_nm = @L2310E_nm104_supervising_prov_first_nm,
    @L2310E_nm105_supervising_prov_middle_nm = @L2310E_nm105_supervising_prov_middle_nm,
    @L2310E_nm107_supervising_prov_suffix = @L2310E_nm107_supervising_prov_suffix,
    @L2310E_nm108_id_code_qual = @L2310E_nm108_id_code_qual,
    @L2310E_nm109_supervising_prov_id = @L2310E_nm109_supervising_prov_id,
    @L2320_amt02_AAE_approved_amt = @L2320_amt02_AAE_approved_amt,
    @L2320_amt02_AU_covered_amt = @L2320_amt02_AU_covered_amt,
    @L2320_amt02_B6_allowed_amt = @L2320_amt02_B6_allowed_amt,
    @L2320_amt02_D_payer_paid_amt = @L2320_amt02_D_payer_paid_amt,
    @L2320_amt02_D8_discount_amt = @L2320_amt02_D8_discount_amt,
    @L2320_amt02_DY_per_day_limit_amt = @L2320_amt02_DY_per_day_limit_amt,
    @L2320_amt02_F2_pt_responsibility_amt = @L2320_amt02_F2_pt_responsibility_amt,
    @L2320_amt02_F5_pt_paid_amt = @L2320_amt02_F5_pt_paid_amt,
    @L2320_amt02_T_tax_amt = @L2320_amt02_T_tax_amt,
    @L2320_amt02_T2_total_clm_before_tax_amt = @L2320_amt02_T2_total_clm_before_tax_amt,
    @L2320_cas01_adjustment_group_code = @L2320_cas01_adjustment_group_code,
    @L2320_cas02_adjustment_reason_code = @L2320_cas02_adjustment_reason_code,
    @L2320_cas03_adjustment_amt = @L2320_cas03_adjustment_amt,
    @L2320_cas04_adjustment_qty = @L2320_cas04_adjustment_qty,
    @L2320_cas05_adjustment_reason_code = @L2320_cas05_adjustment_reason_code,
    @L2320_cas06_adjustment_amt = @L2320_cas06_adjustment_amt,
    @L2320_cas07_adjustment_qty = @L2320_cas07_adjustment_qty,
    @L2320_cas08_adjustment_reason_code = @L2320_cas08_adjustment_reason_code,
    @L2320_cas09_adjustment_amt = @L2320_cas09_adjustment_amt,
    @L2320_cas10_adjustment_qty = @L2320_cas10_adjustment_qty,
    @L2320_dmg02_other_subscriber_dob = @L2320_dmg02_other_subscriber_dob,
    @L2320_dmg03_other_subscriber_gender = @L2320_dmg03_other_subscriber_gender,
    @L2320_oi03_other_ins_benefit_assign_ind = @L2320_oi03_other_ins_benefit_assign_ind,
    @L2320_oi04_other_ins_patient_signature_code = @L2320_oi04_other_ins_patient_signature_code,
    @L2320_oi06_other_ins_release_of_info_code = @L2320_oi06_other_ins_release_of_info_code,
    @L2320_sbr01_payer_resp_seq_code = @L2320_sbr01_payer_resp_seq_code,
    @L2320_sbr02_ind_relationship_code = @L2320_sbr02_ind_relationship_code,
    @L2320_sbr03_insured_grp_policy_num = @L2320_sbr03_insured_grp_policy_num,
    @L2320_sbr04_insured_grp_nm = @L2320_sbr04_insured_grp_nm,
    @L2320_sbr05_insurance_type_code = @L2320_sbr05_insurance_type_code,
    @L2320_sbr09_claim_filing_ind_code = @L2320_sbr09_claim_filing_ind_code,
    @L2330A_nm101_entity_id_code = @L2330A_nm101_entity_id_code,
    @L2330A_nm102_entity_type_qual = @L2330A_nm102_entity_type_qual,
    @L2330A_nm103_other_insured_last_name = @L2330A_nm103_other_insured_last_name,
    @L2330A_nm104_other_insured_first_name = @L2330A_nm104_other_insured_first_name,
    @L2330A_nm105_other_insured_middle_name = @L2330A_nm105_other_insured_middle_name,
    @L2330A_nm107_other_insured_name_suffix = @L2330A_nm107_other_insured_name_suffix,
    @L2330A_nm108_other_insured_id_code_qual = @L2330A_nm108_other_insured_id_code_qual,
    @L2330A_nm109_other_insured_id = @L2330A_nm109_other_insured_id,
    @L2330B_dtp03_573_date_claim_paid = @L2330B_dtp03_573_date_claim_paid,
    @L2330B_nm101_entity_id_code = @L2330B_nm101_entity_id_code,
    @L2330B_nm102_entity_type_qual = @L2330B_nm102_entity_type_qual,
    @L2330B_nm103_other_payer_nm = @L2330B_nm103_other_payer_nm,
    @L2330B_nm108_id_code_qual = @L2330B_nm108_id_code_qual,
    @L2330B_nm109_other_payer_id = @L2330B_nm109_other_payer_id,
    @L2330B_ref02_2U_other_payer_secondary_id = @L2330B_ref02_2U_other_payer_secondary_id,
    @L2330B_ref02_F8_other_payer_secondary_id = @L2330B_ref02_F8_other_payer_secondary_id,
    @L2330B_ref02_FY_other_payer_secondary_id = @L2330B_ref02_FY_other_payer_secondary_id,
    @L2330B_ref02_NF_other_payer_secondary_id = @L2330B_ref02_NF_other_payer_secondary_id,
    @L2330B_ref02_TJ_other_payer_secondary_id = @L2330B_ref02_TJ_other_payer_secondary_id,
    @L2400_dtp02_472_from_service_date = @L2400_dtp02_472_from_service_date,
    @L2400_dtp02_472_to_service_date = @L2400_dtp02_472_to_service_date,
    @L2400_lx01_assigned_num = @L2400_lx01_assigned_num,
    @L2400_nte01_note_ref_code = @L2400_nte01_note_ref_code,
    @L2400_nte02_line_note_text = @L2400_nte02_line_note_text,
    @L2400_ref02_6R_line_item_control_num = @L2400_ref02_6R_line_item_control_num,
    @L2400_sv101_proc_code = @L2400_sv101_proc_code,
    @L2400_sv101_proc_code_qual = @L2400_sv101_proc_code_qual,
    @L2400_sv101_proc_mod1 = @L2400_sv101_proc_mod1,
    @L2400_sv101_proc_mod2 = @L2400_sv101_proc_mod2,
    @L2400_sv101_proc_mod3 = @L2400_sv101_proc_mod3,
    @L2400_sv101_proc_mod4 = @L2400_sv101_proc_mod4,
    @L2400_sv102_line_charge = @L2400_sv102_line_charge,
    @L2400_sv103_measurement_code = @L2400_sv103_measurement_code,
    @L2400_sv104_service_unit_count = @L2400_sv104_service_unit_count,
    @L2400_sv105_place_of_service = @L2400_sv105_place_of_service,
    @L2400_sv107_dx_pointer1 = @L2400_sv107_dx_pointer1,
    @L2400_sv107_dx_pointer2 = @L2400_sv107_dx_pointer2,
    @L2400_sv107_dx_pointer3 = @L2400_sv107_dx_pointer3,
    @L2400_sv107_dx_pointer4 = @L2400_sv107_dx_pointer4,
    @L2400_sv109_emergency_indicator = @L2400_sv109_emergency_indicator,
    @L2400_sv111_epsdt_indicator = @L2400_sv111_epsdt_indicator,
    @L2400_sv112_family_plan_indicator = @L2400_sv112_family_plan_indicator,
    @L2400_sv115_copay_status_code = @L2400_sv115_copay_status_code,
    @L2410_1_lin03_N4_ndc = @L2410_1_lin03_N4_ndc,
    @L2420A_nm102_entity_type_qual = @L2420A_nm102_entity_type_qual,
    @L2420A_nm103_rendering_prov_last_nm = @L2420A_nm103_rendering_prov_last_nm,
    @L2420A_nm104_rendering_prov_first_nm = @L2420A_nm104_rendering_prov_first_nm,
    @L2420A_nm105_rendering_prov_middle_nm = @L2420A_nm105_rendering_prov_middle_nm,
    @L2420A_nm107_rendering_prov_suffix = @L2420A_nm107_rendering_prov_suffix,
    @L2420A_nm108_id_code_qual = @L2420A_nm108_id_code_qual,
    @L2420A_nm109_rendering_prov_id = @L2420A_nm109_rendering_prov_id,
    @L2420A_prv01_provider_code = @L2420A_prv01_provider_code,
    @L2420A_prv02_ref_id_qual = @L2420A_prv02_ref_id_qual,
    @L2420A_prv03_taxonomy_code = @L2420A_prv03_taxonomy_code,
    @L2420A_ref02_1C_rendering_prov_id = @L2420A_ref02_1C_rendering_prov_id,
    @L2420A_ref02_1D_rendering_prov_id = @L2420A_ref02_1D_rendering_prov_id,
    @L2420A_ref02_1G_rendering_prov_id = @L2420A_ref02_1G_rendering_prov_id,
    @L2420A_ref02_EI_rendering_prov_id = @L2420A_ref02_EI_rendering_prov_id,
    @L2420A_ref02_FH_rendering_prov_id = @L2420A_ref02_FH_rendering_prov_id,
    @L2420A_ref02_SY_rendering_prov_id = @L2420A_ref02_SY_rendering_prov_id,
    @L2420C_n301_service_facility_address1 = @L2420C_n301_service_facility_address1,
    @L2420C_n302_service_facility_address2 = @L2420C_n302_service_facility_address2,
    @L2420C_n401_service_facility_city = @L2420C_n401_service_facility_city,
    @L2420C_n402_service_facility_state = @L2420C_n402_service_facility_state,
    @L2420C_n403_service_facility_zip = @L2420C_n403_service_facility_zip,
    @L2420C_n404_service_facility_country = @L2420C_n404_service_facility_country,
    @L2420C_nm101_entity_id_code = @L2420C_nm101_entity_id_code,
    @L2420C_nm102_entity_type_qual = @L2420C_nm102_entity_type_qual,
    @L2420C_nm103_service_facility_last_nm = @L2420C_nm103_service_facility_last_nm,
    @L2420C_nm108_id_code_qual = @L2420C_nm108_id_code_qual,
    @L2420C_nm109_service_facility_id = @L2420C_nm109_service_facility_id,
    @L2420C_ref02_1C_service_facility_id = @L2420C_ref02_1C_service_facility_id,
    @L2420C_ref02_1D_service_facility_id = @L2420C_ref02_1D_service_facility_id,
    @L2420C_ref02_1G_service_facility_id = @L2420C_ref02_1G_service_facility_id,
    @L2420C_ref02_G2_service_facility_id = @L2420C_ref02_G2_service_facility_id,
    @L2420C_ref02_TJ_service_facility_id = @L2420C_ref02_TJ_service_facility_id,
    @L2420D_nm102_entity_type_qual = @L2420D_nm102_entity_type_qual,
    @L2420D_nm103_supervising_prov_last_nm = @L2420D_nm103_supervising_prov_last_nm,
    @L2420D_nm104_supervising_prov_first_nm = @L2420D_nm104_supervising_prov_first_nm,
    @L2420D_nm105_supervising_prov_middle_nm = @L2420D_nm105_supervising_prov_middle_nm,
    @L2420D_nm107_supervising_prov_suffix = @L2420D_nm107_supervising_prov_suffix,
    @L2420D_nm108_id_code_qual = @L2420D_nm108_id_code_qual,
    @L2420D_nm109_supervising_prov_id = @L2420D_nm109_supervising_prov_id,
    @L2420F_nm101_entity_id_code = @L2420F_nm101_entity_id_code,
    @L2420F_nm102_entity_type_qual = @L2420F_nm102_entity_type_qual,
    @L2420F_nm103_referring_prov_last_nm = @L2420F_nm103_referring_prov_last_nm,
    @L2420F_nm104_referring_prov_first_nm = @L2420F_nm104_referring_prov_first_nm,
    @L2420F_nm105_referring_prov_middle_nm = @L2420F_nm105_referring_prov_middle_nm,
    @L2420F_nm107_referring_prov_suffix = @L2420F_nm107_referring_prov_suffix,
    @L2420F_nm108_id_code_qual = @L2420F_nm108_id_code_qual,
    @L2420F_nm109_referring_prov_id = @L2420F_nm109_referring_prov_id,
    @L2420F_prv01_provider_code = @L2420F_prv01_provider_code,
    @L2420F_prv02_ref_id_qual = @L2420F_prv02_ref_id_qual,
    @L2420F_prv03_taxonomy_code = @L2420F_prv03_taxonomy_code,
    @L2420F_ref02_1C_referring_prov_id = @L2420F_ref02_1C_referring_prov_id,
    @L2420F_ref02_1D_referring_prov_id = @L2420F_ref02_1D_referring_prov_id,
    @L2420F_ref02_1G_referring_prov_id = @L2420F_ref02_1G_referring_prov_id,
    @L2420F_ref02_EI_referring_prov_id = @L2420F_ref02_EI_referring_prov_id,
    @L2420F_ref02_FH_referring_prov_id = @L2420F_ref02_FH_referring_prov_id,
    @L2420F_ref02_SY_referring_prov_id = @L2420F_ref02_SY_referring_prov_id,
    @L2430_cas01_adjustment_group_code = @L2430_cas01_adjustment_group_code,
    @L2430_cas02_adjustment_reason_code = @L2430_cas02_adjustment_reason_code,
    @L2430_cas03_adjustment_amt = @L2430_cas03_adjustment_amt,
    @L2430_cas04_adjustment_qty = @L2430_cas04_adjustment_qty,
    @L2430_cas05_adjustment_reason_code = @L2430_cas05_adjustment_reason_code,
    @L2430_cas06_adjustment_amt = @L2430_cas06_adjustment_amt,
    @L2430_cas07_adjustment_qty = @L2430_cas07_adjustment_qty,
    @L2430_cas08_adjustment_reason_code = @L2430_cas08_adjustment_reason_code,
    @L2430_cas09_adjustment_amt = @L2430_cas09_adjustment_amt,
    @L2430_cas10_adjustment_qty = @L2430_cas10_adjustment_qty,
    @L2430_dtp03_573_date_claim_paid = @L2430_dtp03_573_date_claim_paid,
    @L2430_svd01_other_payer_id = @L2430_svd01_other_payer_id,
    @L2430_svd02_service_line_paid = @L2430_svd02_service_line_paid,
    @ref01_receiver_ref_id_qual = @ref01_receiver_ref_id_qual,
    @ref02_transmission_type_code = @ref02_transmission_type_code,
    @x12_transaction_id = @x12_transaction_id							
	
	
---- after going through the recordset, the last record must be inserted because we're done with the l

return (0)





