CREATE TABLE [dbo].[x12_820_remittance_advice] (
    [x12_820_remittance_advice_id]             INT              IDENTITY (1, 1) NOT NULL,
    [x12_transaction_id]                       INT              NULL,
    [bpr01_trans_handling_code]                CHAR (2)         NULL,
    [bpr02_total_prov_pmt_amt]                 MONEY            NULL,
    [bpr03_credit_debit_flag_code]             CHAR (1)         NULL,
    [bpr04_payment_method_code]                CHAR (3)         NULL,
    [bpr05_payment_format_code]                VARCHAR (10)     NULL,
    [bpr06_orig_dfi_id_qual]                   CHAR (2)         NULL,
    [bpr07_orig_dfi_id]                        VARCHAR (12)     NULL,
    [bpr08_orig_account_num_qual]              VARCHAR (3)      NULL,
    [bpr09_orig_account_num]                   VARCHAR (35)     NULL,
    [bpr10_orig_co_id]                         CHAR (10)        NULL,
    [bpr11_orig_co_supp_code]                  CHAR (9)         NULL,
    [bpr12_receiver_dfi_id_qual]               CHAR (2)         NULL,
    [bpr13_receiver_dfi_id]                    VARCHAR (12)     NULL,
    [bpr14_receiver_account_num_qual]          VARCHAR (3)      NULL,
    [bpr15_receiver_account_num]               VARCHAR (35)     NULL,
    [bpr16_check_eff_date]                     DATETIME         NULL,
    [trn01_trace_type_code]                    CHAR (2)         NULL,
    [trn02_trace_number]                       VARCHAR (30)     NULL,
    [trn03_orig_co_id]                         CHAR (10)        NULL,
    [trn04_orig_co_supp_code]                  VARCHAR (30)     NULL,
    [ref01_prem_receiver_ref_id_qual]          CHAR (3)         NULL,
    [ref02_prem_receiver_ref_id]               VARCHAR (30)     NULL,
    [L1000A_n101_entity_id_code]               CHAR (3)         NULL,
    [L1000A_n102_receiver_org_nm]              VARCHAR (60)     NULL,
    [L1000A_n103_receiver_id_qual]             CHAR (2)         NULL,
    [L1000A_n104_receiver_id]                  VARCHAR (80)     NULL,
    [L1000A_n301_receiver_address1]            VARCHAR (55)     NULL,
    [L1000A_n302_receiver_address2]            VARCHAR (55)     NULL,
    [L1000A_n401_receiver_city]                VARCHAR (30)     NULL,
    [L1000A_n402_receiver_state]               CHAR (2)         NULL,
    [L1000A_n403_receiver_zip]                 VARCHAR (15)     NULL,
    [L1000B_n101_entity_id_code]               CHAR (3)         NULL,
    [L1000B_n102_payer_nm]                     VARCHAR (60)     NULL,
    [L1000B_n103_payer_id_qual]                CHAR (2)         NULL,
    [L1000B_n103_payer_id]                     VARCHAR (80)     NULL,
    [L1000B_n301_payer_address1]               VARCHAR (55)     NULL,
    [L1000B_n302_payer_address2]               VARCHAR (55)     NULL,
    [L1000B_n401_payer_city]                   VARCHAR (30)     NULL,
    [L1000B_n402_payer_state]                  CHAR (2)         NULL,
    [L1000B_n403_payer_zip]                    VARCHAR (15)     NULL,
    [L1000B_per01_contact_function_code]       CHAR (2)         NULL,
    [L1000B_per02_contact_name]                VARCHAR (60)     NULL,
    [L1000B_per03_comm_num_qual]               CHAR (2)         NULL,
    [L1000B_per04_comm_num]                    VARCHAR (80)     NULL,
    [L2000A_ent01_assigned_num]                VARCHAR (6)      NULL,
    [L2000A_ent02_entity_id_code]              CHAR (3)         NULL,
    [L2000A_ent03_id_code_qual]                CHAR (2)         NULL,
    [L2000A_ent04_org_id_code]                 VARCHAR (80)     NULL,
    [L2300A_rmr01_ref_id_qual]                 CHAR (3)         NULL,
    [L2300A_rmr02_account_num]                 VARCHAR (30)     NULL,
    [L2300A_rmr03_pmt_action_code]             CHAR (2)         NULL,
    [L2300A_rmr04_prem_payment_amount]         MONEY            NULL,
    [L2300A_rmr05_prem_billed_amount]          MONEY            NULL,
    [L2310A_it101_line_item_control_num]       VARCHAR (20)     NULL,
    [L2315A_sln01_line_item_control_num]       VARCHAR (20)     NULL,
    [L2315A_sln04_head_count]                  VARCHAR (15)     NULL,
    [L2315A_sln05_unit_of_measure]             CHAR (2)         NULL,
    [L2320A_adx01_adj_amount]                  VARCHAR (18)     NULL,
    [L2320A_adx02_adj_reason_code]             CHAR (2)         NULL,
    [L2000B_ent01_assigned_num]                VARCHAR (6)      NULL,
    [L2000B_ent02_entity_id_code]              CHAR (3)         NULL,
    [L2000B_ent03_id_code_qual]                CHAR (2)         NULL,
    [L2000B_ent04_org_id_code]                 VARCHAR (80)     NULL,
    [L2000B_ent04_org_id_code_omap_rate_group] VARCHAR (10)     NULL,
    [L2000B_ent04_org_id_code_omap_perc]       VARCHAR (10)     NULL,
    [L2000B_ent04_org_id_code_omap_php]        VARCHAR (10)     NULL,
    [L2000B_ent04_org_id_code_omap_fips]       VARCHAR (10)     NULL,
    [L2100B_nm101_entity_id_code]              CHAR (3)         NULL,
    [L2100B_nm102_entity_type_qual]            CHAR (1)         NULL,
    [L2100B_nm103_individual_last_nm]          VARCHAR (35)     NULL,
    [L2100B_nm104_individual_first_nm]         VARCHAR (25)     NULL,
    [L2100B_nm105_individual_middle_nm]        VARCHAR (25)     NULL,
    [L2100B_nm106_individual_prefix]           VARCHAR (10)     NULL,
    [L2100B_nm107_individual_suffix]           VARCHAR (10)     NULL,
    [L2100B_nm108_individual_id_code_qual]     CHAR (2)         NULL,
    [L2100B_nm109_individual_id]               VARCHAR (80)     NULL,
    [L2300B_rmr01_ref_id_qual]                 CHAR (3)         NULL,
    [L2300B_rmr02_reference_num]               VARCHAR (30)     NULL,
    [L2300B_rmr03_pmt_action_code]             CHAR (2)         NULL,
    [L2300B_rmr04_prem_payment_amount]         MONEY            NULL,
    [L2300B_rmr05_prem_billed_amount]          MONEY            NULL,
    [L2300B_dtm06_coverage_period_begin]       DATETIME         NULL,
    [L2300B_dtm06_coverage_period_end]         DATETIME         NULL,
    [L2320B_adx01_adj_amount]                  MONEY            NULL,
    [L2320B_adx02_adj_reason_code]             CHAR (2)         NULL,
    [error]                                    BIT              NULL,
    [processed]                                BIT              NULL,
    [active]                                   BIT              NULL,
    [modified_by]                              UNIQUEIDENTIFIER NULL,
    [modified_date]                            DATETIME         NULL,
    [created_by]                               UNIQUEIDENTIFIER NULL,
    [created_date]                             DATETIME         NULL,
    [timestamp]                                ROWVERSION       NULL,
    CONSTRAINT [PK_x12_820_remittance_advice] PRIMARY KEY CLUSTERED ([x12_820_remittance_advice_id] ASC),
    CONSTRAINT [FK_x12_820_remittance_advice_x12_transaction] FOREIGN KEY ([x12_transaction_id]) REFERENCES [dbo].[x12_transaction] ([x12_transaction_id])
);


GO
CREATE NONCLUSTERED INDEX [idx_x12_820_remittance_advice]
    ON [dbo].[x12_820_remittance_advice]([x12_transaction_id] ASC, [trn02_trace_number] ASC, [L2100B_nm109_individual_id] ASC, [L2300A_rmr04_prem_payment_amount] DESC, [bpr02_total_prov_pmt_amt] ASC, [bpr16_check_eff_date] ASC, [L1000A_n102_receiver_org_nm] ASC, [L1000A_n104_receiver_id] ASC, [L1000B_n102_payer_nm] ASC, [L1000B_n103_payer_id] ASC, [L2000B_ent04_org_id_code_omap_rate_group] ASC, [L2000B_ent04_org_id_code_omap_perc] ASC, [L2000B_ent04_org_id_code_omap_php] ASC, [L2000B_ent04_org_id_code_omap_fips] ASC, [L2300B_dtm06_coverage_period_begin] ASC, [L2300B_dtm06_coverage_period_end] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_L2000B_ent04_org_id_code_omap_rate_group]
    ON [dbo].[x12_820_remittance_advice]([L2000B_ent04_org_id_code_omap_rate_group] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_L2000B_ent04_org_id_code_omap_php]
    ON [dbo].[x12_820_remittance_advice]([L2000B_ent04_org_id_code_omap_php] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_coverage_dates]
    ON [dbo].[x12_820_remittance_advice]([L2300B_dtm06_coverage_period_begin] ASC, [L2300B_dtm06_coverage_period_end] ASC);

