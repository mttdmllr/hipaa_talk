﻿CREATE TABLE [dbo].[x12_835_claim_payment_advice] (
    [x12_835_claim_payment_advice_id]                INT              IDENTITY (1, 1) NOT NULL,
    [x12_transaction_id]                             INT              NULL,
    [bpr01_trans_handling_code]                      CHAR (2)         NULL,
    [bpr02_total_prov_pmt_amt]                       MONEY            NULL,
    [bpr03_credit_debit_flag_code]                   CHAR (1)         NULL,
    [bpr04_payment_method_code]                      CHAR (3)         NULL,
    [bpr05_payment_format_code]                      VARCHAR (10)     NULL,
    [bpr06_sender_dfi_id_qual]                       CHAR (2)         NULL,
    [bpr07_sender_dfi_id]                            VARCHAR (12)     NULL,
    [bpr08_sender_account_num_qual]                  CHAR (3)         NULL,
    [bpr09_sender_account_num]                       VARCHAR (35)     NULL,
    [bpr10_payer_id]                                 CHAR (10)        NULL,
    [bpr11_orig_co_supp_code]                        CHAR (9)         NULL,
    [bpr12_receiver_dfi_id_qual]                     CHAR (2)         NULL,
    [bpr13_receiver_dfi_id]                          VARCHAR (12)     NULL,
    [bpr14_receiver_account_num_qual]                CHAR (3)         NULL,
    [bpr15_receiver_account_num]                     VARCHAR (35)     NULL,
    [bpr16_check_date]                               CHAR (8)         NULL,
    [trn01_trace_type_code]                          CHAR (1)         NULL,
    [trn02_trace_number]                             VARCHAR (30)     NULL,
    [trn03_payer_id]                                 CHAR (10)        NULL,
    [ref01_receiver_ref_id_qual]                     CHAR (3)         NULL,
    [ref02_receiver_ref_id]                          VARCHAR (30)     NULL,
    [dtm02_production_date]                          CHAR (8)         NULL,
    [L1000A_n101_entity_id_code]                     CHAR (3)         CONSTRAINT [DF_x12_835_claim_payment_advice_L1000A_n101_entity_id_code] DEFAULT ('PR') NULL,
    [L1000A_n102_payer_nm]                           VARCHAR (60)     NULL,
    [L1000A_n103_payer_id_qual]                      CHAR (2)         NULL,
    [L1000A_n104_payer_id]                           VARCHAR (80)     NULL,
    [L1000A_n301_payer_address1]                     VARCHAR (55)     NULL,
    [L1000A_n302_payer_address2]                     VARCHAR (55)     NULL,
    [L1000A_n401_payer_city]                         VARCHAR (30)     NULL,
    [L1000A_n402_payer_state]                        CHAR (2)         NULL,
    [L1000A_n403_payer_zip]                          VARCHAR (15)     NULL,
    [L1000A_ref01_ref_id_qual]                       CHAR (3)         NULL,
    [L1000A_ref02_add_payer_id]                      VARCHAR (30)     NULL,
    [L1000A_per01_contact_function_code]             CHAR (2)         NULL,
    [L1000B_n101_entity_id_code]                     CHAR (3)         CONSTRAINT [DF_x12_835_claim_payment_advice_L1000B_n101_entity_id_code] DEFAULT ('PE') NULL,
    [L1000B_n102_payee_nm]                           VARCHAR (60)     NULL,
    [L1000B_n103_payee_id_qual]                      CHAR (2)         NULL,
    [L1000B_n104_payee_id]                           VARCHAR (80)     NULL,
    [L1000B_n301_payee_address1]                     VARCHAR (55)     NULL,
    [L1000B_n302_payee_address2]                     VARCHAR (55)     NULL,
    [L1000B_n401_payee_city]                         VARCHAR (30)     NULL,
    [L1000B_n402_payee_state]                        CHAR (2)         NULL,
    [L1000B_n403_payee_zip]                          VARCHAR (15)     NULL,
    [L1000B_ref01_ref_id_qual]                       CHAR (3)         NULL,
    [L1000B_ref02_add_payee_id]                      VARCHAR (30)     NULL,
    [L2000_lx01_assigned_number]                     VARCHAR (6)      NULL,
    [L2000_ts301_provider_identifier]                VARCHAR (30)     NULL,
    [L2000_ts302_facility_type_code]                 CHAR (2)         NULL,
    [L2000_ts303_fiscal_period_date]                 CHAR (8)         NULL,
    [L2000_ts304_total_claim_count]                  INT              NULL,
    [L2000_ts306_total_covered_charge_amount]        MONEY            NULL,
    [L2100_clp01_pt_control_no]                      VARCHAR (38)     NULL,
    [L2100_clp02_claim_status_code]                  CHAR (2)         NULL,
    [L2100_clp03_total_claim_chg_amt]                MONEY            NULL,
    [L2100_clp04_claim_pmt_amt]                      MONEY            NULL,
    [L2100_clp05_pt_resp_amt]                        MONEY            NULL,
    [L2100_clp06_claim_filing_ind_code]              CHAR (2)         NULL,
    [L2100_clp07_payer_claim_control_no]             VARCHAR (30)     NULL,
    [L2100_clp08_facility_type_code]                 CHAR (2)         NULL,
    [L2100_clp09_claim_freq_code]                    CHAR (1)         NULL,
    [L2100_clp11_drg_code]                           VARCHAR (4)      NULL,
    [L2100_clp12_drg_weight]                         VARCHAR (15)     NULL,
    [L2100_clp13_discharge_fraction]                 VARCHAR (10)     NULL,
    [L2100_nm103_TT_cob_carrier_nm]                  VARCHAR (35)     NULL,
    [L2100_nm108_TT_cob_id_qual]                     CHAR (2)         NULL,
    [L2100_nm109_TT_cob_id]                          VARCHAR (80)     NULL,
    [L2100_nm103_PR_corrected_prty_payer_nm]         VARCHAR (35)     NULL,
    [L2100_nm108_PR_corrected_prty_payer_nm_id_qual] CHAR (2)         NULL,
    [L2100_nm109_PR_corrected_prty_payer_nm_id]      VARCHAR (80)     NULL,
    [L2100_nm101_entity_id_code]                     CHAR (3)         NULL,
    [L2100_nm102_entity_type_qual]                   CHAR (1)         NULL,
    [L2100_nm103_QC_patient_last_nm]                 VARCHAR (35)     NULL,
    [L2100_nm104_QC_patient_first_nm]                VARCHAR (25)     NULL,
    [L2100_nm105_QC_patient_middle_nm]               VARCHAR (25)     NULL,
    [L2100_nm108_QC_patient_id_qual]                 CHAR (2)         NULL,
    [L2100_nm109_QC_patient_id]                      VARCHAR (80)     NULL,
    [L2100_nm103_IL_subscriber_last_nm]              VARCHAR (35)     NULL,
    [L2100_nm104_IL_subscriber_first_nm]             VARCHAR (25)     NULL,
    [L2100_nm105_IL_subscriber_middle_nm]            VARCHAR (25)     NULL,
    [L2100_nm108_IL_subscriber_id_qual]              CHAR (2)         NULL,
    [L2100_nm109_IL_subscriber_id]                   VARCHAR (80)     NULL,
    [L2100_mia01_covered_days_or_visits_count]       INT              NULL,
    [L2100_mia02_pps_operating_outlier_amt]          MONEY            NULL,
    [L2100_mia03_lifetime_psy_days_count]            INT              NULL,
    [L2100_mia04_claim_drg_amt]                      MONEY            NULL,
    [L2100_mia05_remark_code]                        VARCHAR (30)     NULL,
    [L2100_mia06_disp_share_amt]                     MONEY            NULL,
    [L2100_mia07_claim_MSP_pass_through_amt]         MONEY            NULL,
    [L2100_mia08_claim_PPS_capital_amt]              MONEY            NULL,
    [L2100_mia09_PPS_capital_FSP_drg_amt]            MONEY            NULL,
    [L2100_mia10_PPS_capital_HSP_drg_amt]            MONEY            NULL,
    [L2100_mia11_PPS_capital_DSH_drg_amt]            MONEY            NULL,
    [L2100_mia12_old_capital_amt]                    MONEY            NULL,
    [L2100_mia13_PPS_capital_IME_amt]                MONEY            NULL,
    [L2100_mia14_PPS_operating_hosp_spec_DRG_amt]    MONEY            NULL,
    [L2100_mia15_cost_rpt_day_count]                 INT              NULL,
    [L2100_mia16_PPS_operating_fed_spec_DRG_amt]     MONEY            NULL,
    [L2100_mia17_claim_PPS_capital_outlier_amt]      MONEY            NULL,
    [L2100_mia18_claim_indirect_teaching_amt]        MONEY            NULL,
    [L2100_mia19_nonpayable_prof_component_amt]      MONEY            NULL,
    [L2100_mia20_remark_code]                        VARCHAR (30)     NULL,
    [L2100_mia21_remark_code]                        VARCHAR (30)     NULL,
    [L2100_mia22_remark_code]                        VARCHAR (30)     NULL,
    [L2100_mia23_remark_code]                        VARCHAR (30)     NULL,
    [L2100_mia24_PPS_capital_exception_amt]          MONEY            NULL,
    [L2100_ref02_9A_other_claim_ref_id]              VARCHAR (30)     NULL,
    [L2100_ref02_BB_other_claim_ref_id]              VARCHAR (30)     NULL,
    [L2100_ref02_G1_other_claim_ref_id]              VARCHAR (30)     NULL,
    [L2100_ref02_EA_other_claim_ref_id]              VARCHAR (30)     NULL,
    [L2100_ref02_F8_other_claim_ref_id]              VARCHAR (30)     NULL,
    [L2100_ref01_rend_prov_sec_ref_id_qual]          CHAR (3)         NULL,
    [L2100_ref02_rend_prov_sec_ref_id]               VARCHAR (30)     NULL,
    [L2100_dtm02_036_expiration_date]                CHAR (8)         NULL,
    [L2100_dtm02_050_received_date]                  CHAR (8)         NULL,
    [L2100_dtm02_232_stmt_start_date]                CHAR (8)         NULL,
    [L2100_dtm02_233_stmt_end_date]                  CHAR (8)         NULL,
    [L2100_amt02_AU_claim_supp_info_amt]             MONEY            NULL,
    [L2100_amt02_D8_claim_supp_info_amt]             MONEY            NULL,
    [L2100_amt02_DY_claim_supp_info_amt]             MONEY            NULL,
    [L2100_amt02_F5_claim_supp_info_amt]             MONEY            NULL,
    [L2100_amt02_I_claim_supp_info_amt]              MONEY            NULL,
    [L2100_amt02_NL_claim_supp_info_amt]             MONEY            NULL,
    [L2100_amt02_T_claim_supp_info_amt]              MONEY            NULL,
    [L2100_amt02_T2_claim_supp_info_amt]             MONEY            NULL,
    [L2100_amt02_ZK_claim_supp_info_amt]             MONEY            NULL,
    [L2100_amt02_ZL_claim_supp_info_amt]             MONEY            NULL,
    [L2100_amt02_ZM_claim_supp_info_amt]             MONEY            NULL,
    [L2100_amt02_ZN_claim_supp_info_amt]             MONEY            NULL,
    [L2100_amt02_ZO_claim_supp_info_amt]             MONEY            NULL,
    [L2100_amt02_ZZ_claim_supp_info_amt]             MONEY            NULL,
    [L2110_svc01_proc_code]                          VARCHAR (48)     NULL,
    [L2110_svc01_proc_mod1]                          CHAR (2)         NULL,
    [L2110_svc01_proc_mod2]                          CHAR (2)         NULL,
    [L2110_svc01_proc_mod3]                          CHAR (2)         NULL,
    [L2110_svc01_proc_mod4]                          CHAR (2)         NULL,
    [L2110_svc02_charge_amt]                         MONEY            NULL,
    [L2110_svc03_provider_pmt_amt]                   MONEY            NULL,
    [L2110_svc04_ub_rev_code]                        VARCHAR (48)     NULL,
    [L2110_svc05_units_paid]                         VARCHAR (15)     NULL,
    [L2110_dtm02_150_service_date]                   CHAR (8)         NULL,
    [L2110_dtm02_151_service_date]                   CHAR (8)         NULL,
    [L2110_dtm02_472_service_date]                   CHAR (8)         NULL,
    [L2110_1_cas02_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_1_cas03_adj_amt]                          MONEY            NULL,
    [L2110_1_cas04_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_1_cas05_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_1_cas06_adj_amt]                          MONEY            NULL,
    [L2110_1_cas07_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_1_cas08_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_1_cas09_adj_amt]                          MONEY            NULL,
    [L2110_1_cas10_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_1_cas11_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_1_cas12_adj_amt]                          MONEY            NULL,
    [L2110_1_cas13_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_1_cas14_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_1_cas15_adj_amt]                          MONEY            NULL,
    [L2110_1_cas16_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_ref01_service_ref_id_qual]                CHAR (3)         NULL,
    [L2110_ref02_service_ref_id]                     VARCHAR (30)     NULL,
    [L2110_ref01_rend_prov_ref_id_qual]              CHAR (3)         NULL,
    [L2110_lq02_remark_code_01]                      VARCHAR (30)     NULL,
    [L2110_lq02_remark_code_02]                      VARCHAR (30)     NULL,
    [L2110_lq02_remark_code_03]                      VARCHAR (30)     NULL,
    [L2110_lq02_remark_code_04]                      VARCHAR (30)     NULL,
    [L2110_lq02_remark_code_05]                      VARCHAR (30)     NULL,
    [plb01_provider_identifier]                      VARCHAR (30)     NULL,
    [plb02_fiscal_period_date]                       CHAR (8)         NULL,
    [plb03_adjustment_reason_code]                   CHAR (2)         NULL,
    [plb03_provider_adjustment_identifier]           VARCHAR (30)     NULL,
    [plb04_provider_adjustment_amount]               MONEY            NULL,
    [plb05_adjustment_reason_code]                   CHAR (2)         NULL,
    [plb05_provider_adjustment_identifier]           VARCHAR (30)     NULL,
    [plb06_provider_adjustment_amount]               MONEY            NULL,
    [plb07_adjustment_reason_code]                   CHAR (2)         NULL,
    [plb07_provider_adjustment_identifier]           VARCHAR (30)     NULL,
    [plb08_provider_adjustment_amount]               MONEY            NULL,
    [plb09_adjustment_reason_code]                   CHAR (2)         NULL,
    [plb09_provider_adjustment_identifier]           VARCHAR (30)     NULL,
    [plb10_provider_adjustment_amount]               MONEY            NULL,
    [plb11_adjustment_reason_code]                   CHAR (2)         NULL,
    [plb11_provider_adjustment_identifier]           VARCHAR (30)     NULL,
    [plb12_provider_adjustment_amount]               MONEY            NULL,
    [plb13_adjustment_reason_code]                   CHAR (2)         NULL,
    [plb13_provider_adjustment_identifier]           VARCHAR (30)     NULL,
    [plb14_provider_adjustment_amount]               MONEY            NULL,
    [processed]                                      BIT              NULL,
    [error]                                          BIT              NULL,
    [active]                                         BIT              NULL,
    [modified_by]                                    UNIQUEIDENTIFIER NULL,
    [modified_date]                                  DATETIME         NULL,
    [created_by]                                     UNIQUEIDENTIFIER NULL,
    [created_date]                                   DATETIME         NULL,
    [timestamp]                                      ROWVERSION       NULL,
    [L1000A_per02_contact_nm]                        VARCHAR (60)     NULL,
    [L1000A_per03_comm_num_qual]                     CHAR (2)         NULL,
    [L1000A_per04_comm_number]                       VARCHAR (80)     NULL,
    [L2110_1_cas01_adj_group_code]                   CHAR (2)         NULL,
    [L2110_1_cas17_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_1_cas18_adj_amt]                          MONEY            NULL,
    [L2110_1_cas19_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_2_cas01_adj_group_code]                   CHAR (2)         NULL,
    [L2110_2_cas02_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_2_cas03_adj_amt]                          MONEY            NULL,
    [L2110_2_cas04_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_2_cas05_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_2_cas06_adj_amt]                          MONEY            NULL,
    [L2110_2_cas07_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_2_cas08_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_2_cas09_adj_amt]                          MONEY            NULL,
    [L2110_2_cas10_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_3_cas01_adj_group_code]                   CHAR (2)         NULL,
    [L2110_3_cas02_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_3_cas03_adj_amt]                          MONEY            NULL,
    [L2110_3_cas04_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_3_cas05_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_3_cas06_adj_amt]                          MONEY            NULL,
    [L2110_3_cas07_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_3_cas08_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_3_cas09_adj_amt]                          MONEY            NULL,
    [L2110_3_cas10_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_4_cas01_adj_group_code]                   CHAR (2)         NULL,
    [L2110_4_cas02_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_4_cas03_adj_amt]                          MONEY            NULL,
    [L2110_4_cas04_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_4_cas05_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_4_cas06_adj_amt]                          MONEY            NULL,
    [L2110_4_cas07_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_4_cas08_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_4_cas09_adj_amt]                          MONEY            NULL,
    [L2110_4_cas10_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_5_cas01_adj_group_code]                   CHAR (2)         NULL,
    [L2110_5_cas02_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_5_cas03_adj_amt]                          MONEY            NULL,
    [L2110_5_cas04_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_5_cas05_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_5_cas06_adj_amt]                          MONEY            NULL,
    [L2110_5_cas07_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_5_cas08_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_5_cas09_adj_amt]                          MONEY            NULL,
    [L2110_5_cas10_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_ref02_rend_prov_ref_id]                   VARCHAR (30)     NULL,
    [L2110_3_cas11_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_3_cas12_adj_amt]                          MONEY            NULL,
    [L2110_3_cas13_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_3_cas14_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_3_cas15_adj_amt]                          MONEY            NULL,
    [L2110_3_cas16_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_3_cas17_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_3_cas18_adj_amt]                          MONEY            NULL,
    [L2110_3_cas19_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_1_cas01_adj_group_code]                   CHAR (2)         NULL,
    [L2100_1_cas02_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_1_cas03_adj_amt]                          MONEY            NULL,
    [L2100_1_cas04_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_1_cas05_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_1_cas06_adj_amt]                          MONEY            NULL,
    [L2100_1_cas07_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_1_cas08_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_1_cas09_adj_amt]                          MONEY            NULL,
    [L2100_1_cas10_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_1_cas11_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_1_cas12_adj_amt]                          MONEY            NULL,
    [L2100_1_cas13_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_1_cas14_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_1_cas15_adj_amt]                          MONEY            NULL,
    [L2100_1_cas16_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_1_cas17_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_1_cas18_adj_amt]                          MONEY            NULL,
    [L2100_1_cas19_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_2_cas01_adj_group_code]                   CHAR (2)         NULL,
    [L2100_2_cas02_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_2_cas03_adj_amt]                          MONEY            NULL,
    [L2100_2_cas04_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_2_cas05_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_2_cas06_adj_amt]                          MONEY            NULL,
    [L2100_2_cas07_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_2_cas08_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_2_cas09_adj_amt]                          MONEY            NULL,
    [L2100_2_cas10_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_2_cas11_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_2_cas12_adj_amt]                          MONEY            NULL,
    [L2100_2_cas13_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_2_cas14_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_2_cas15_adj_amt]                          MONEY            NULL,
    [L2100_2_cas16_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_2_cas17_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_2_cas18_adj_amt]                          MONEY            NULL,
    [L2100_2_cas19_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_3_cas01_adj_group_code]                   CHAR (2)         NULL,
    [L2100_3_cas02_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_3_cas03_adj_amt]                          MONEY            NULL,
    [L2100_3_cas04_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_3_cas05_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_3_cas06_adj_amt]                          MONEY            NULL,
    [L2100_3_cas07_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_3_cas08_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_3_cas09_adj_amt]                          MONEY            NULL,
    [L2100_3_cas10_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_3_cas11_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_3_cas12_adj_amt]                          MONEY            NULL,
    [L2100_3_cas13_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_3_cas14_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_3_cas15_adj_amt]                          MONEY            NULL,
    [L2100_3_cas16_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_3_cas17_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_3_cas18_adj_amt]                          MONEY            NULL,
    [L2100_3_cas19_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_4_cas01_adj_group_code]                   CHAR (2)         NULL,
    [L2100_4_cas02_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_4_cas03_adj_amt]                          MONEY            NULL,
    [L2100_4_cas04_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_4_cas05_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_4_cas06_adj_amt]                          MONEY            NULL,
    [L2100_4_cas07_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_4_cas08_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_4_cas09_adj_amt]                          MONEY            NULL,
    [L2100_4_cas10_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_4_cas11_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_4_cas12_adj_amt]                          MONEY            NULL,
    [L2100_4_cas13_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_4_cas14_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_4_cas15_adj_amt]                          MONEY            NULL,
    [L2100_4_cas16_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_4_cas17_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_4_cas18_adj_amt]                          MONEY            NULL,
    [L2100_4_cas19_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_5_cas01_adj_group_code]                   CHAR (2)         NULL,
    [L2100_5_cas02_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_5_cas03_adj_amt]                          MONEY            NULL,
    [L2100_5_cas04_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_5_cas05_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_5_cas06_adj_amt]                          MONEY            NULL,
    [L2100_5_cas07_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_5_cas08_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_5_cas09_adj_amt]                          MONEY            NULL,
    [L2100_5_cas10_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_5_cas11_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_5_cas12_adj_amt]                          MONEY            NULL,
    [L2100_5_cas13_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_5_cas14_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_5_cas15_adj_amt]                          MONEY            NULL,
    [L2100_5_cas16_adj_qty]                          VARCHAR (15)     NULL,
    [L2100_5_cas17_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2100_5_cas18_adj_amt]                          MONEY            NULL,
    [L2100_5_cas19_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_2_cas11_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_2_cas12_adj_amt]                          MONEY            NULL,
    [L2110_2_cas13_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_2_cas14_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_2_cas15_adj_amt]                          MONEY            NULL,
    [L2110_2_cas16_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_2_cas17_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_2_cas18_adj_amt]                          MONEY            NULL,
    [L2110_2_cas19_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_4_cas11_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_4_cas12_adj_amt]                          MONEY            NULL,
    [L2110_4_cas13_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_4_cas14_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_4_cas15_adj_amt]                          MONEY            NULL,
    [L2110_4_cas16_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_4_cas17_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_4_cas18_adj_amt]                          MONEY            NULL,
    [L2110_4_cas19_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_5_cas11_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_5_cas12_adj_amt]                          MONEY            NULL,
    [L2110_5_cas13_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_5_cas14_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_5_cas15_adj_amt]                          MONEY            NULL,
    [L2110_5_cas16_adj_qty]                          VARCHAR (15)     NULL,
    [L2110_5_cas17_adj_reason_code]                  VARCHAR (5)      NULL,
    [L2110_5_cas18_adj_amt]                          MONEY            NULL,
    [L2110_5_cas19_adj_qty]                          VARCHAR (15)     NULL,
    CONSTRAINT [PK_x12_835_claim_payment_advice] PRIMARY KEY CLUSTERED ([x12_835_claim_payment_advice_id] ASC),
    CONSTRAINT [FK_x12_835_claim_payment_advice_x12_transaction] FOREIGN KEY ([x12_transaction_id]) REFERENCES [dbo].[x12_transaction] ([x12_transaction_id])
);


GO
CREATE NONCLUSTERED INDEX [idx_x12_transaction_header_id]
    ON [dbo].[x12_835_claim_payment_advice]([x12_transaction_id] ASC);

