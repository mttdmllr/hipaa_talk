﻿CREATE TABLE [dbo].[x12_270_eligibility_response] (
    [x12_270_eligibility_response_id]            INT              IDENTITY (1, 1) NOT NULL,
    [x12_transaction_id]                         INT              NOT NULL,
    [bht01_hierarchical_structure_code]          CHAR (4)         NULL,
    [bht02_trans_set_purpose_code]               CHAR (2)         NULL,
    [bht03_trans_batch_id]                       VARCHAR (50)     NULL,
    [bht04_trans_set_creation_date]              VARCHAR (8)      NULL,
    [bht05_trans_set_creation_time]              VARCHAR (8)      NULL,
    [L2000A_hl01_hierarchical_id_num]            VARCHAR (12)     NULL,
    [L2000A_hl03_hierarchical_level_code]        CHAR (2)         NULL,
    [L2000A_hl04_hierarchical_child_code]        CHAR (1)         NULL,
    [L2100A_nm102_entity_type_qual]              CHAR (1)         NULL,
    [L2100A_nm103_info_source_last_nm]           VARCHAR (60)     NULL,
    [L2100A_nm104_info_source_first_nm]          VARCHAR (50)     NULL,
    [L2100A_nm105_info_source_middle_nm]         VARCHAR (50)     NULL,
    [L2100A_nm107_info_source_name_suffix]       VARCHAR (50)     NULL,
    [L2100A_nm108_info_source_id_qual]           VARCHAR (50)     NULL,
    [L2100A_nm109_info_source_id]                VARCHAR (80)     NULL,
    [L2100A_per101_info_receiver_comm_func_code] CHAR (2)         NULL,
    [L2100A_per103_info_receiver_comm_num_qual]  CHAR (2)         NULL,
    [L2100A_per104_info_receiver_comm]           VARCHAR (80)     NULL,
    [L2100A_ref02_18_info_source_add_id]         VARCHAR (30)     NULL,
    [L2100A_ref02_18_info_source_add_id_name]    VARCHAR (80)     NULL,
    [L2100A_ref02_55_info_source_add_id]         VARCHAR (30)     NULL,
    [L2100A_ref02_55_info_source_add_id_name]    VARCHAR (80)     NULL,
    [L2000B_hl01_hierarchical_id_num]            VARCHAR (12)     NULL,
    [L2000B_hl02_hierarchical_parent_id_num]     VARCHAR (12)     NULL,
    [L2000B_hl03_hierarchical_level_code]        CHAR (2)         NULL,
    [L2000B_hl04_hierarchical_child_code]        CHAR (1)         NULL,
    [L2100B_nm102_entity_type_qual]              CHAR (1)         NULL,
    [L2100B_nm103_info_receiver_last_nm]         VARCHAR (60)     NULL,
    [L2100B_nm104_info_receiver_first_nm]        VARCHAR (35)     NULL,
    [L2100B_nm105_info_receiver_middle_nm]       VARCHAR (25)     NULL,
    [L2100B_nm108_info_receiver_id_qual]         CHAR (2)         NULL,
    [L2100B_nm109_info_receiver_id]              VARCHAR (80)     NULL,
    [L2100B_ref02_0B_info_receiver_id]           VARCHAR (30)     NULL,
    [L2100B_ref02_0B_info_receiver_state_code]   VARCHAR (80)     NULL,
    [L2100B_ref02_1C_info_receiver_id]           VARCHAR (30)     NULL,
    [L2100B_ref02_1D_info_receiver_id]           VARCHAR (30)     NULL,
    [L2100B_ref02_1J_info_receiver_id]           VARCHAR (30)     NULL,
    [L2100B_ref02_4A_info_receiver_id]           VARCHAR (30)     NULL,
    [L2100B_ref02_CT_info_receiver_id]           VARCHAR (30)     NULL,
    [L2100B_ref02_EL_info_receiver_id]           VARCHAR (30)     NULL,
    [L2100B_ref02_EO_info_receiver_id]           VARCHAR (30)     NULL,
    [L2100B_ref02_HPI_info_receiver_id]          VARCHAR (30)     NULL,
    [L2100B_ref02_JD_info_receiver_id]           VARCHAR (30)     NULL,
    [L2100B_ref02_N5_info_receiver_id]           VARCHAR (30)     NULL,
    [L2100B_ref02_N7_info_receiver_id]           VARCHAR (30)     NULL,
    [L2100B_ref02_Q4_info_receiver_id]           VARCHAR (30)     NULL,
    [L2100B_ref02_SY_info_receiver_id]           VARCHAR (30)     NULL,
    [L2100B_ref02_TJ_info_receiver_id]           VARCHAR (30)     NULL,
    [L2000C_hl01_hierarchical_id_num]            VARCHAR (12)     NULL,
    [L2000C_hl02_hierarchical_parent_id_num]     VARCHAR (12)     NULL,
    [L2000C_hl03_hierarchical_level_code]        CHAR (2)         NULL,
    [L2000C_hl04_hierarchical_child_code]        CHAR (1)         NULL,
    [L2000C_trn01_trace_type_code]               VARCHAR (2)      NULL,
    [L2000C_trn02_trace_number]                  VARCHAR (30)     NULL,
    [L2000C_trn03_trace_assigning_entity_id]     CHAR (10)        NULL,
    [L2000C_trn04_trace_assigning_entity_add_id] VARCHAR (30)     NULL,
    [L2100C_nm102_entity_type_qual]              CHAR (1)         NULL,
    [L2100C_nm103_subscriber_last_name]          VARCHAR (35)     NULL,
    [L2100C_nm104_subscriber_first_name]         VARCHAR (25)     NULL,
    [L2100C_nm105_subscriber_middle_name]        VARCHAR (25)     NULL,
    [L2100C_nm107_subscriber_name_suffix]        VARCHAR (10)     NULL,
    [L2100C_nm108_subscriber_id_code_qual]       VARCHAR (2)      NULL,
    [L2100C_nm109_subscriber_id]                 VARCHAR (80)     NULL,
    [L2100C_ref02_18_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100C_ref02_18_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100C_ref02_1L_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100C_ref02_1L_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100C_ref02_1W_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100C_ref02_1W_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100C_ref02_49_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100C_ref02_49_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100C_ref02_6P_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100C_ref02_6P_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100C_ref02_A6_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100C_ref02_A6_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100C_ref02_CT_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100C_ref02_CT_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100C_ref02_EA_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100C_ref02_EA_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100C_ref02_EJ_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100C_ref02_EJ_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100C_ref02_F6_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100C_ref02_F6_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100C_ref02_GH_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100C_ref02_GH_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100C_ref02_HJ_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100C_ref02_HJ_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100C_ref02_IG_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100C_ref02_IG_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100C_ref02_N6_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100C_ref02_N6_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100C_ref02_NQ_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100C_ref02_NQ_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100C_ref02_SY_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100C_ref02_SY_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100C_n301_subscriber_address1]            VARCHAR (55)     NULL,
    [L2100C_n302_subscriber_address2]            VARCHAR (55)     NULL,
    [L2100C_n401_subscriber_city]                VARCHAR (30)     NULL,
    [L2100C_n402_subscriber_state]               CHAR (2)         NULL,
    [L2100C_n403_subscriber_zip]                 VARCHAR (15)     NULL,
    [L2100C_n404_subscriber_country]             VARCHAR (3)      NULL,
    [L2100C_n405_subscriber_location_qual]       VARCHAR (2)      NULL,
    [L2100C_n406_subscriber_location_id_code]    VARCHAR (30)     NULL,
    [L2100C_dmg02_subscriber_dob]                VARCHAR (35)     NULL,
    [L2100C_dmg03_subscriber_gender]             CHAR (1)         NULL,
    [L2100C_ins01_insured_indicator]             CHAR (1)         NULL,
    [L2100C_ins02_individual_relationship_code]  CHAR (2)         NULL,
    [L2100C_ins03_maint_type_code]               CHAR (3)         NULL,
    [L2100C_ins04_maint_reason_code]             VARCHAR (3)      NULL,
    [L2100C_ins09_student_status_code]           CHAR (1)         NULL,
    [L2100C_ins10_handicap_indicator]            CHAR (1)         NULL,
    [L2100C_ins17_birth_seq_number]              VARCHAR (9)      NULL,
    [L2100C_dtp03_102_issue_eff_date]            VARCHAR (10)     NULL,
    [L2100C_dtp03_102_issue_term_date]           VARCHAR (10)     NULL,
    [L2100C_dtp03_152_eff_change_date]           VARCHAR (10)     NULL,
    [L2100C_dtp03_291_plan_date]                 VARCHAR (10)     NULL,
    [L2100C_dtp03_307_elig_eff_date]             VARCHAR (10)     NULL,
    [L2100C_dtp03_307_elig_term_date]            VARCHAR (10)     NULL,
    [L2100C_dtp03_318_added_date]                VARCHAR (10)     NULL,
    [L2100C_dtp03_340_cobra_eff_date]            VARCHAR (10)     NULL,
    [L2100C_dtp03_341_cobra_term_date]           VARCHAR (10)     NULL,
    [L2100C_dtp03_342_premium_paid_begin_date]   VARCHAR (10)     NULL,
    [L2100C_dtp03_343_premium_paid_end_date]     VARCHAR (10)     NULL,
    [L2100C_dtp03_346_plan_begin_date]           VARCHAR (10)     NULL,
    [L2100C_dtp03_347_plan_end_date]             VARCHAR (10)     NULL,
    [L2100C_dtp03_356_elig_begin_date]           VARCHAR (10)     NULL,
    [L2100C_dtp03_357_elig_end_date]             VARCHAR (10)     NULL,
    [L2100C_dtp03_382_enrollment_date]           VARCHAR (10)     NULL,
    [L2100C_dtp03_435_admission_eff_date]        VARCHAR (10)     NULL,
    [L2100C_dtp03_435_admission_term_date]       VARCHAR (10)     NULL,
    [L2100C_dtp03_442_death_date]                VARCHAR (10)     NULL,
    [L2100C_dtp03_458_certification_date]        VARCHAR (10)     NULL,
    [L2100C_dtp03_472_service_eff_date]          VARCHAR (10)     NULL,
    [L2100C_dtp03_472_service_term_date]         VARCHAR (10)     NULL,
    [L2100C_dtp03_539_policy_eff_date]           VARCHAR (10)     NULL,
    [L2100C_dtp03_540_policy_term_date]          VARCHAR (10)     NULL,
    [L2100C_dtp03_636_update_date]               VARCHAR (10)     NULL,
    [L2100C_dtp03_771_status_date]               VARCHAR (10)     NULL,
    [L2110C_eb01_elig_info]                      VARCHAR (2)      NULL,
    [L2110C_eb02_benefit_coverage_level_code]    VARCHAR (3)      NULL,
    [L2110C_eb03_service_type_code]              VARCHAR (2)      NULL,
    [L2110C_eb04_insurance_type_code]            VARCHAR (3)      NULL,
    [L2110C_eb05_plan_coverage_desc]             VARCHAR (50)     NULL,
    [L2110C_eb06_time_period_qual]               VARCHAR (2)      NULL,
    [L2110C_eb07_benefit_amt]                    VARCHAR (18)     NULL,
    [L2110C_eb08_benefit_percent]                VARCHAR (10)     NULL,
    [L2110C_eb09_quantity_qual]                  CHAR (2)         NULL,
    [L2110C_eb10_benefit_quantity]               VARCHAR (15)     NULL,
    [L2110C_eb11_authorization_indicator]        CHAR (1)         NULL,
    [L2110C_eb12_in_plan_network_indicator]      CHAR (1)         NULL,
    [L2110C_eb13_service_id_qual]                CHAR (2)         NULL,
    [L2110C_eb13_procedure_code]                 VARCHAR (48)     NULL,
    [L2110C_eb13_procedure_mod1]                 CHAR (2)         NULL,
    [L2110C_eb13_procedure_mod2]                 CHAR (2)         NULL,
    [L2110C_eb13_procedure_mod3]                 CHAR (2)         NULL,
    [L2110C_eb13_procedure_mod4]                 CHAR (2)         NULL,
    [L2110C_hsd01_quantity_qual]                 CHAR (2)         NULL,
    [L2110C_hsd02_benefit_quantity]              VARCHAR (15)     NULL,
    [L2110C_hsd03_measurement_code]              CHAR (2)         NULL,
    [L2110C_hsd04_sample_selection_modulus]      VARCHAR (6)      NULL,
    [L2110C_hsd05_time_period_qual]              VARCHAR (2)      NULL,
    [L2110C_hsd06_period_count]                  VARCHAR (3)      NULL,
    [L2110C_hsd07_delivery_frequency_code]       VARCHAR (2)      NULL,
    [L2110C_hsd08_delivery_pattern_time_code]    CHAR (1)         NULL,
    [L2110C_ref02_18_plan_num]                   VARCHAR (30)     NULL,
    [L2110C_ref02_18_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2110C_ref02_1L_policy_num]                 VARCHAR (30)     NULL,
    [L2110C_ref02_1L_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2110C_ref02_1W_member_id_num]              VARCHAR (30)     NULL,
    [L2110C_ref02_1W_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2110C_ref02_49_family_unit_num]            VARCHAR (30)     NULL,
    [L2110C_ref02_49_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2110C_ref02_6P_group_num]                  VARCHAR (30)     NULL,
    [L2110C_ref02_6P_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2110C_ref02_9F_referral_num]               VARCHAR (30)     NULL,
    [L2110C_ref02_9F_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2110C_ref02_A6_employee_id_num]            VARCHAR (30)     NULL,
    [L2110C_ref02_A6_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2110C_ref02_F6_hic_num]                    VARCHAR (30)     NULL,
    [L2110C_ref02_F6_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2110C_ref02_G1_prior_auth_num]             VARCHAR (30)     NULL,
    [L2110C_ref02_G1_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2110C_ref02_IG_insurance_policy_num]       VARCHAR (30)     NULL,
    [L2110C_ref02_IG_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2110C_ref02_N6_plan_network_id_num]        VARCHAR (30)     NULL,
    [L2110C_ref02_N6_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2110C_ref02_NQ_medicaid_recipient_id_num]  VARCHAR (30)     NULL,
    [L2110C_ref02_NQ_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2110C_dtp03_193_period_start_date]         VARCHAR (10)     NULL,
    [L2110C_dtp03_194_period_end_date]           VARCHAR (10)     NULL,
    [L2110C_dtp03_198_completion_date]           VARCHAR (10)     NULL,
    [L2110C_dtp03_290_cob_begin_date]            VARCHAR (10)     NULL,
    [L2110C_dtp03_290_cob_end_date]              VARCHAR (10)     NULL,
    [L2110C_dtp03_292_benefit_eff_date]          VARCHAR (10)     NULL,
    [L2110C_dtp03_292_benefit_term_date]         VARCHAR (10)     NULL,
    [L2110C_dtp03_295_pcp_eff_date]              VARCHAR (10)     NULL,
    [L2110C_dtp03_295_pcp_term_date]             VARCHAR (10)     NULL,
    [L2110C_dtp03_304_last_visit_date]           VARCHAR (10)     NULL,
    [L2110C_dtp03_307_elig_eff_date]             VARCHAR (10)     NULL,
    [L2110C_dtp03_307_elig_term_date]            VARCHAR (10)     NULL,
    [L2110C_dtp03_318_added_date]                VARCHAR (10)     NULL,
    [L2110C_dtp03_348_benefit_begin_date]        VARCHAR (10)     NULL,
    [L2110C_dtp03_349_benefit_end_date]          VARCHAR (10)     NULL,
    [L2110C_dtp03_356_elig_begin_date]           VARCHAR (10)     NULL,
    [L2110C_dtp03_357_elig_end_date]             VARCHAR (10)     NULL,
    [L2110C_dtp03_435_admission_eff_date]        VARCHAR (10)     NULL,
    [L2110C_dtp03_435_admission_term_date]       VARCHAR (10)     NULL,
    [L2110C_dtp03_472_service_eff_date]          VARCHAR (10)     NULL,
    [L2110C_dtp03_472_service_term_date]         VARCHAR (10)     NULL,
    [L2115C_iii02_BF_industry_code]              VARCHAR (30)     NULL,
    [L2115C_iii02_BK_industry_code]              VARCHAR (30)     NULL,
    [L2115C_iii02_ZZ_industry_code]              VARCHAR (30)     NULL,
    [L2110C_ls01_loop_identifier_code]           VARCHAR (6)      NULL,
    [L2120C_nm101_entity_id_code]                VARCHAR (3)      NULL,
    [L2120C_nm102_entity_type_qual]              CHAR (1)         NULL,
    [L2120C_nm103_benefit_entity_last_name]      VARCHAR (35)     NULL,
    [L2120C_nm104_benefit_entity_first_name]     VARCHAR (25)     NULL,
    [L2120C_nm105_benefit_entity_middle_name]    VARCHAR (25)     NULL,
    [L2120C_nm107_benefit_entity_name_suffix]    VARCHAR (10)     NULL,
    [L2120C_nm108_benefit_entity_id_code_qual]   VARCHAR (2)      NULL,
    [L2120C_nm109_benefit_entity_id]             VARCHAR (80)     NULL,
    [L2120C_n301_benefit_entity_address1]        VARCHAR (55)     NULL,
    [L2120C_n302_benefit_entity_address2]        VARCHAR (55)     NULL,
    [L2120C_n401_benefit_entity_city]            VARCHAR (30)     NULL,
    [L2120C_n402_benefit_entity_state]           CHAR (2)         NULL,
    [L2120C_n403_benefit_entity_zip]             VARCHAR (15)     NULL,
    [L2120C_n404_benefit_entity_country]         VARCHAR (3)      NULL,
    [L2120C_n405_benefit_entity_location_qual]   VARCHAR (2)      NULL,
    [L2120C_n406_dod_hsr_code]                   VARCHAR (30)     NULL,
    [L2120C_per102_benefit_entity_contact_name]  VARCHAR (60)     NULL,
    [L2120C_per103_benefit_entity_comm_num_qual] CHAR (2)         NULL,
    [L2120C_per104_benefit_entity_comm]          VARCHAR (80)     NULL,
    [L2120C_per105_benefit_entity_comm_num_qual] CHAR (2)         NULL,
    [L2120C_per106_benefit_entity_comm]          VARCHAR (80)     NULL,
    [L2120C_per107_benefit_entity_comm_num_qual] CHAR (2)         NULL,
    [L2120C_per108_benefit_entity_comm]          VARCHAR (80)     NULL,
    [L2120C_prv01_provider_code]                 VARCHAR (3)      NULL,
    [L2120C_prv02_provider_id_qual]              VARCHAR (3)      NULL,
    [L2120C_prv03_provider_id]                   VARCHAR (30)     NULL,
    [L2110C_le01_loop_identifier_code]           VARCHAR (6)      NULL,
    [L2000D_hl01_hierarchical_id_num]            VARCHAR (12)     NULL,
    [L2000D_hl02_hierarchical_parent_id_num]     VARCHAR (12)     NULL,
    [L2000D_hl03_hierarchical_level_code]        CHAR (2)         NULL,
    [L2000D_hl04_hierarchical_child_code]        CHAR (1)         NULL,
    [L2000D_trn01_trace_type_code]               VARCHAR (2)      NULL,
    [L2000D_trn02_trace_number]                  VARCHAR (30)     NULL,
    [L2000D_trn03_trace_assigning_entity_id]     CHAR (10)        NULL,
    [L2000D_trn04_trace_assigning_entity_add_id] VARCHAR (30)     NULL,
    [L2100D_nm102_entity_type_qual]              CHAR (1)         NULL,
    [L2100D_nm103_dependent_last_name]           VARCHAR (35)     NULL,
    [L2100D_nm104_dependent_first_name]          VARCHAR (25)     NULL,
    [L2100D_nm105_dependent_middle_name]         VARCHAR (25)     NULL,
    [L2100D_nm107_dependent_name_suffix]         VARCHAR (10)     NULL,
    [L2100D_nm108_dependent_id_qual]             VARCHAR (2)      NULL,
    [L2100D_nm109_dependent_id]                  VARCHAR (80)     NULL,
    [L2100D_ref02_18_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100D_ref02_18_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100D_ref02_1L_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100D_ref02_1L_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100D_ref02_1W_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100D_ref02_1W_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100D_ref02_49_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100D_ref02_49_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100D_ref02_6P_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100D_ref02_6P_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100D_ref02_A6_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100D_ref02_A6_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100D_ref02_CT_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100D_ref02_CT_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100D_ref02_EA_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100D_ref02_EA_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100D_ref02_EJ_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100D_ref02_EJ_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100D_ref02_F6_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100D_ref02_F6_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100D_ref02_GH_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100D_ref02_GH_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100D_ref02_HJ_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100D_ref02_HJ_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100D_ref02_IG_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100D_ref02_IG_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100D_ref02_N6_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100D_ref02_N6_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100D_ref02_NQ_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100D_ref02_NQ_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100D_ref02_SY_subscriber_add_id]          VARCHAR (30)     NULL,
    [L2100D_ref02_SY_plan_sponsor_name]          VARCHAR (80)     NULL,
    [L2100D_n301_dependent_address1]             VARCHAR (55)     NULL,
    [L2100D_n302_dependent_address2]             VARCHAR (55)     NULL,
    [L2100D_n401_dependent_city]                 VARCHAR (30)     NULL,
    [L2100D_n402_dependent_state]                CHAR (2)         NULL,
    [L2100D_n403_dependent_zip]                  VARCHAR (15)     NULL,
    [L2100D_n404_dependent_country]              VARCHAR (3)      NULL,
    [L2100D_prv01_provider_code]                 VARCHAR (3)      NULL,
    [L2100D_prv03_9K_provider_id]                VARCHAR (30)     NULL,
    [L2100D_prv03_D3_provider_id]                VARCHAR (30)     NULL,
    [L2100D_prv03_EI_provider_id]                VARCHAR (30)     NULL,
    [L2100D_prv03_HPI_provider_id]               VARCHAR (30)     NULL,
    [L2100D_prv03_SY_provider_id]                VARCHAR (30)     NULL,
    [L2100D_prv03_TJ_provider_id]                VARCHAR (30)     NULL,
    [L2100D_prv03_ZZ_provider_id]                VARCHAR (30)     NULL,
    [L2100D_dmg02_subscriber_dob]                VARCHAR (35)     NULL,
    [L2100D_dmg03_subscriber_gender]             CHAR (1)         NULL,
    [L2100D_ins01_insured_indicator]             CHAR (1)         NULL,
    [L2100D_ins02_individual_relationship_code]  CHAR (2)         NULL,
    [L2100D_ins17_birth_seq_number]              VARCHAR (9)      NULL,
    [L2100D_dtp03_102_issue_eff_date]            VARCHAR (10)     NULL,
    [L2100D_dtp03_102_issue_term_date]           VARCHAR (10)     NULL,
    [L2100D_dtp03_307_elig_eff_date]             VARCHAR (10)     NULL,
    [L2100D_dtp03_307_elig_term_date]            VARCHAR (10)     NULL,
    [L2100D_dtp03_435_admission_eff_date]        VARCHAR (10)     NULL,
    [L2100D_dtp03_435_admission_term_date]       VARCHAR (10)     NULL,
    [L2100D_dtp03_472_service_eff_date]          VARCHAR (10)     NULL,
    [L2100D_dtp03_472_service_term_date]         VARCHAR (10)     NULL,
    [L2110D_eq01_service_type_code]              VARCHAR (2)      NULL,
    [L2110D_eq02_service_id_qual]                CHAR (2)         NULL,
    [L2110D_eq02_procedure_code]                 VARCHAR (48)     NULL,
    [L2110D_eq02_procedure_mod1]                 CHAR (2)         NULL,
    [L2110D_eq02_procedure_mod2]                 CHAR (2)         NULL,
    [L2110D_eq02_procedure_mod3]                 CHAR (2)         NULL,
    [L2110D_eq02_procedure_mod4]                 CHAR (2)         NULL,
    [L2110D_eq03_benefit_coverage_level_code]    CHAR (3)         NULL,
    [L2110D_eq04_insurance_type_code]            VARCHAR (3)      NULL,
    [L2110D_iii02_BF_industry_code]              VARCHAR (30)     NULL,
    [L2110D_iii02_BK_industry_code]              VARCHAR (30)     NULL,
    [L2110D_iii02_ZZ_industry_code]              VARCHAR (30)     NULL,
    [L2110D_ref02_9F_referral_num]               VARCHAR (30)     NULL,
    [L2110D_ref02_G1_prior_auth_num]             VARCHAR (30)     NULL,
    [L2110D_dtp03_307_elig_eff_date]             VARCHAR (10)     NULL,
    [L2110D_dtp03_307_elig_term_date]            VARCHAR (10)     NULL,
    [L2110D_dtp03_435_admission_eff_date]        VARCHAR (10)     NULL,
    [L2110D_dtp03_435_admission_term_date]       VARCHAR (10)     NULL,
    [L2110D_dtp03_472_service_eff_date]          VARCHAR (10)     NULL,
    [L2110D_dtp03_472_service_term_date]         VARCHAR (10)     NULL,
    [error]                                      BIT              NULL,
    [processed]                                  BIT              NULL,
    [active]                                     BIT              NULL,
    [modified_by]                                UNIQUEIDENTIFIER NULL,
    [modified_date]                              DATETIME         NULL,
    [created_by]                                 UNIQUEIDENTIFIER NULL,
    [created_date]                               DATETIME         NULL,
    [timestamp]                                  ROWVERSION       NULL,
    CONSTRAINT [PK_x12_270_eligibility_response] PRIMARY KEY NONCLUSTERED ([x12_270_eligibility_response_id] ASC),
    CONSTRAINT [FK_x12_270_eligibility_response_x12_transaction] FOREIGN KEY ([x12_transaction_id]) REFERENCES [dbo].[x12_transaction] ([x12_transaction_id])
);


GO
CREATE CLUSTERED INDEX [idx_x12_transaction_id]
    ON [dbo].[x12_270_eligibility_response]([x12_transaction_id] ASC);

