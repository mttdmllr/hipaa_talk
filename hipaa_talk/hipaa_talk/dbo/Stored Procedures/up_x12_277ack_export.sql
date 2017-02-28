CREATE Procedure [dbo].[up_x12_277ack_export] (@x12_transaction_id int = null, @segment_count int output)
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

declare @bht01_hierarchical_structure_code char(4)
declare @bht02_trans_set_purpose_code char(2)
declare @bht03_trans_batch_id varchar(50)
declare @bht04_trans_set_creation_date varchar(8)
declare @bht05_trans_set_creation_time varchar(8)
declare @bht06_trans_type_code char(2)
declare @L2000A_hl01_hierarchical_id_num varchar(12)
declare @L2000A_hl03_hierarchical_level_code char(2)
declare @L2000A_hl04_hierarchical_child_code char(1)
declare @L2100A_nm101_entity_id_code char(3)
declare @L2100A_nm102_entity_type_qual char(1)
declare @L2100A_nm103_info_source_last_nm varchar(60)
declare @L2100A_nm108_info_source_id_qual char(2)
declare @L2100A_nm109_info_source_id varchar(80)
declare @L2200A_trn01_trace_type_code char(2)
declare @L2200A_trn02_app_trace_id varchar(50)
declare @L2200A_dtp03_050_receipt_date varchar(35)
declare @L2200A_dtp03_009_process_date varchar(35)
declare @L2000B_hl01_hierarchical_id_num varchar(12)
declare @L2000B_hl02_hierarchical_parent_id_num varchar(12)
declare @L2000B_hl03_hierarchical_level_code char(2)
declare @L2000B_hl04_hierarchical_child_code char(1)
declare @L2100B_nm102_entity_type_qual char(1)
declare @L2100B_nm103_info_receiver_last_nm varchar(60)
declare @L2100B_nm104_info_receiver_first_nm varchar(35)
declare @L2100B_nm105_info_receiver_middle_nm varchar(25)
declare @L2100B_nm108_info_receiver_id_qual char(2)
declare @L2100B_nm109_info_receiver_id varchar(80)
declare @L2200B_trn01_trace_type_code char(2)
declare @L2200B_trn02_trace_id varchar(50)
declare @L2200B_stc01_claim_status_cat_code varchar(30)
declare @L2200B_stc01_claim_status_code varchar(30)
declare @L2200B_stc01_entity_id_code char(3)
declare @L2200B_stc02_eff_date char(8)
declare @L2200B_stc03_action_code char(2)
declare @L2200B_stc04_total_submitted_charges money 
declare @L2200B_stc10_claim_status_cat_code varchar(30)
declare @L2200B_stc10_claim_status_code varchar(30)
declare @L2200B_stc10_entity_code char(3)
declare @L2200B_stc11_claim_status_cat_code varchar(30)
declare @L2200B_stc11_claim_status_code varchar(30)
declare @L2200B_stc11_entity_code char(3)
declare @L2200B_qty02_accepted_quantity varchar(15)
declare @L2200B_qty02_rejected_quantity char(10)
declare @L2200B_amt02_total_accepted_charges money 
declare @L2200B_amt02_total_rejected_charges money 
declare @L2000C_hl01_hierarchical_id_num varchar(12)
declare @L2000C_hl02_hierarchical_parent_id_num varchar(12)
declare @L2000C_hl03_hierarchical_level_code char(2)
declare @L2000C_hl04_hierarchical_child_code char(1)
declare @L2100C_nm102_entity_type_qual char(1)
declare @L2100C_nm103_billing_prov_last_nm varchar(60)
declare @L2100C_nm104_billing_prov_first_nm varchar(35)
declare @L2100C_nm105_billing_prov_middle_nm varchar(25)
declare @L2100C_nm107_billing_prov_suffix varchar(10)
declare @L2100C_nm108_id_code_qual char(2)
declare @L2100C_nm109_billing_prov_id varchar(80)
declare @L2200C_trn01_trace_type_code char(2)
declare @L2200C_trn02_trace_id varchar(50)
declare @L2200C_stc01_claim_status_cat_code varchar(30)
declare @L2200C_stc01_claim_status_code varchar(30)
declare @L2200C_stc01_entity_id_code char(3)
declare @L2200C_stc03_action_code char(2)
declare @L2200C_stc04_total_submitted_charges money 
declare @L2200C_stc10_claim_status_cat_code varchar(30)
declare @L2200C_stc10_claim_status_code varchar(30)
declare @L2200C_stc10_entity_code char(3)
declare @L2200C_stc11_claim_status_cat_code varchar(30)
declare @L2200C_stc11_claim_status_code varchar(30)
declare @L2200C_stc11_entity_code char(3)
declare @L2200C_ref02_0B_billing_prov_id varchar(50)
declare @L2200C_ref02_G2_billing_prov_id varchar(50)
declare @L2200C_ref02_1G_billing_prov_id varchar(50)
declare @L2200C_ref02_EI_billing_prov_id varchar(50)
declare @L2200C_ref02_SY_billing_prov_id varchar(50)
declare @L2200C_ref02_LU_billing_prov_id varchar(50)
declare @L2200C_qty02_accepted_quantity varchar(15)
declare @L2200C_qty02_rejected_quantity char(10)
declare @L2200C_amt02_total_accepted_charges money 
declare @L2200C_amt02_total_rejected_charges money 
declare @L2000D_hl01_hierarchical_id_num varchar(12)
declare @L2000D_hl02_hierarchical_parent_id_num varchar(12)
declare @L2000D_hl03_hierarchical_level_code char(2)
declare @L2000D_hl04_hierarchical_child_code char(1)
declare @L2000D_dmg02_subscriber_dob varchar(35)
declare @L2000D_dmg03_subscriber_gender char(1)
declare @L2000D_nm102_entity_type_qual char(1)
declare @L2000D_nm103_patient_last_nm varchar(60)
declare @L2000D_nm104_patient_first_nm varchar(35)
declare @L2000D_nm105_patient_middle_nm varchar(25)
declare @L2000D_nm107_patient_suffix varchar(10)
declare @L2000D_nm108_id_code_qual char(2)
declare @L2000D_nm109_patient_id varchar(80)
declare @L2200D_trn01_trace_type_code char(2)
declare @L2200D_trn02_pt_accnt_num varchar(50)
declare @L2200D_stc01_claim_status_cat_code varchar(30)
declare @L2200D_stc01_claim_status_code varchar(30)
declare @L2200D_stc01_entity_id_code char(3)
declare @L2200D_stc02_eff_date char(8)
declare @L2200D_stc03_action_code char(2)
declare @L2200D_stc04_total_submitted_charges money 
declare @L2200D_stc05_claim_payment_amt money
declare @L2200D_stc06_payment_date char(8)
declare @L2200D_stc07_payment_method char(3)
declare @L2200D_stc08_check_date char(8)
declare @L2200D_stc09_check_number varchar(16)
declare @L2200D_stc10_claim_status_cat_code varchar(30)
declare @L2200D_stc10_claim_status_code varchar(30)
declare @L2200D_stc10_entity_code char(3)
declare @L2200D_stc11_claim_status_cat_code varchar(30)
declare @L2200D_stc11_claim_status_code varchar(30)
declare @L2200D_stc11_entity_code char(3)
declare @L2200D_ref02_1K_payer_claim_control_num varchar(50)
declare @L2200D_ref02_D9_clearinghouse_trace_num varchar(50)
declare @L2200D_ref02_BLT_bill_type varchar(50)
declare @L2200D_ref02_EA_medical_record_num varchar(50)
declare @L2200D_dtp03_232_from_service_date varchar(35)
declare @L2200D_dtp03_232_to_service_date varchar(35)
declare @L2220D_svc01_proc_code_qual char(2)
declare @L2220D_svc01_proc_code varchar(48)
declare @L2220D_svc01_proc_mod1 char(2)
declare @L2220D_svc01_proc_mod2 char(2)
declare @L2220D_svc01_proc_mod3 char(2)
declare @L2220D_svc01_proc_mod4 char(2)
declare @L2220D_svc02_charge_amt money 
declare @L2220D_svc03_line_item_prov_pmt_amt money
declare @L2220D_svc04_revenue_code varchar(48)
declare @L2220D_svc07_service_unit_count varchar(15)

declare @L2220D_stc01_status_cat_code varchar(50)
declare @L2220D_stc01_status_code varchar(50)
declare @L2220D_stc01_entity_id_code char(3)
declare @L2220D_stc02_eff_date char(8)
declare @L2220D_stc03_action_code char(2)
declare @L2220D_stc04_total_submitted_charges money 
declare @L2220D_stc05_line_item_prov_pmt_amt money 
declare @L2220D_stc10_claim_status_cat_code varchar(30)
declare @L2220D_stc10_claim_status_code varchar(30)
declare @L2220D_stc10_entity_code char(3)
declare @L2220D_stc11_claim_status_cat_code varchar(30)
declare @L2220D_stc11_claim_status_code varchar(30)
declare @L2220D_stc11_entity_code char(3)
declare @L2220D_ref02_FJ_line_item_control_num varchar(50)
declare @L2220D_dtp03_472_from_service_date varchar(35)
declare @L2220D_dtp03_472_to_service_date varchar(35)

declare @prev_bht01_hierarchical_structure_code char(4)
declare @prev_bht02_trans_set_purpose_code char(2)
declare @prev_bht03_trans_batch_id varchar(50)
declare @prev_bht04_trans_set_creation_date varchar(8)
declare @prev_bht05_trans_set_creation_time varchar(8)
declare @prev_bht06_trans_type_code char(2)
declare @prev_L2000A_hl01_hierarchical_id_num varchar(12)
declare @prev_L2000A_hl03_hierarchical_level_code char(2)
declare @prev_L2000A_hl04_hierarchical_child_code char(1)
declare @prev_L2100A_nm101_entity_id_code char(3)
declare @prev_L2100A_nm102_entity_type_qual char(1)
declare @prev_L2100A_nm103_info_source_last_nm varchar(60)
declare @prev_L2100A_nm108_info_source_id_qual char(2)
declare @prev_L2100A_nm109_info_source_id varchar(80)
declare @prev_L2200A_trn01_trace_type_code char(2)
declare @prev_L2200A_trn02_app_trace_id varchar(50)
declare @prev_L2200A_dtp03_050_receipt_date varchar(35)
declare @prev_L2200A_dtp03_009_process_date varchar(35)
declare @prev_L2000B_hl01_hierarchical_id_num varchar(12)
declare @prev_L2000B_hl02_hierarchical_parent_id_num varchar(12)
declare @prev_L2000B_hl03_hierarchical_level_code char(2)
declare @prev_L2000B_hl04_hierarchical_child_code char(1)
declare @prev_L2100B_nm102_entity_type_qual char(1)
declare @prev_L2100B_nm103_info_receiver_last_nm varchar(60)
declare @prev_L2100B_nm104_info_receiver_first_nm varchar(35)
declare @prev_L2100B_nm105_info_receiver_middle_nm varchar(25)
declare @prev_L2100B_nm108_info_receiver_id_qual char(2)
declare @prev_L2100B_nm109_info_receiver_id varchar(80)
declare @prev_L2200B_trn01_trace_type_code char(2)
declare @prev_L2200B_trn02_trace_id varchar(50)
declare @prev_L2200B_stc01_claim_status_cat_code varchar(30)
declare @prev_L2200B_stc01_claim_status_code varchar(30)
declare @prev_L2200B_stc01_entity_id_code char(3)
declare @prev_L2200B_stc02_eff_date char(8)
declare @prev_L2200B_stc03_action_code char(2)
declare @prev_L2200B_stc04_total_submitted_charges money 
declare @prev_L2200B_stc10_claim_status_cat_code varchar(30)
declare @prev_L2200B_stc10_claim_status_code varchar(30)
declare @prev_L2200B_stc10_entity_code char(3)
declare @prev_L2200B_stc11_claim_status_cat_code varchar(30)
declare @prev_L2200B_stc11_claim_status_code varchar(30)
declare @prev_L2200B_stc11_entity_code char(3)
declare @prev_L2200B_qty02_accepted_quantity varchar(15)
declare @prev_L2200B_qty02_rejected_quantity char(10)
declare @prev_L2200B_amt02_total_accepted_charges money 
declare @prev_L2200B_amt02_total_rejected_charges money 
declare @prev_L2000C_hl01_hierarchical_id_num varchar(12)
declare @prev_L2000C_hl02_hierarchical_parent_id_num varchar(12)
declare @prev_L2000C_hl03_hierarchical_level_code char(2)
declare @prev_L2000C_hl04_hierarchical_child_code char(1)
declare @prev_L2100C_nm102_entity_type_qual char(1)
declare @prev_L2100C_nm103_billing_prov_last_nm varchar(60)
declare @prev_L2100C_nm104_billing_prov_first_nm varchar(35)
declare @prev_L2100C_nm105_billing_prov_middle_nm varchar(25)
declare @prev_L2100C_nm107_billing_prov_suffix varchar(10)
declare @prev_L2100C_nm108_id_code_qual char(2)
declare @prev_L2100C_nm109_billing_prov_id varchar(80)
declare @prev_L2200C_trn01_trace_type_code char(2)
declare @prev_L2200C_trn02_trace_id varchar(50)
declare @prev_L2200C_stc01_claim_status_cat_code varchar(30)
declare @prev_L2200C_stc01_claim_status_code varchar(30)
declare @prev_L2200C_stc01_entity_id_code char(3)
declare @prev_L2200C_stc03_action_code char(2)
declare @prev_L2200C_stc04_total_submitted_charges money 
declare @prev_L2200C_stc10_claim_status_cat_code varchar(30)
declare @prev_L2200C_stc10_claim_status_code varchar(30)
declare @prev_L2200C_stc10_entity_code char(3)
declare @prev_L2200C_stc11_claim_status_cat_code varchar(30)
declare @prev_L2200C_stc11_claim_status_code varchar(30)
declare @prev_L2200C_stc11_entity_code char(3)
declare @prev_L2200C_ref02_0B_billing_prov_id varchar(50)
declare @prev_L2200C_ref02_G2_billing_prov_id varchar(50)
declare @prev_L2200C_ref02_1G_billing_prov_id varchar(50)
declare @prev_L2200C_ref02_EI_billing_prov_id varchar(50)
declare @prev_L2200C_ref02_SY_billing_prov_id varchar(50)
declare @prev_L2200C_ref02_LU_billing_prov_id varchar(50)
declare @prev_L2200C_qty02_accepted_quantity varchar(15)
declare @prev_L2200C_qty02_rejected_quantity char(10)
declare @prev_L2200C_amt02_total_accepted_charges money 
declare @prev_L2200C_amt02_total_rejected_charges money 
declare @prev_L2000D_hl01_hierarchical_id_num varchar(12)
declare @prev_L2000D_hl02_hierarchical_parent_id_num varchar(12)
declare @prev_L2000D_hl03_hierarchical_level_code char(2)
declare @prev_L2000D_nm102_entity_type_qual char(1)
declare @prev_L2000D_nm103_patient_last_nm varchar(60)
declare @prev_L2000D_nm104_patient_first_nm varchar(35)
declare @prev_L2000D_nm105_patient_middle_nm varchar(25)
declare @prev_L2000D_nm107_patient_suffix varchar(10)
declare @prev_L2000D_nm108_id_code_qual char(2)
declare @prev_L2000D_nm109_patient_id varchar(80)
declare @prev_L2200D_trn01_trace_type_code char(2)
declare @prev_L2200D_trn02_pt_accnt_num varchar(50)
declare @prev_L2200D_stc01_claim_status_cat_code varchar(30)
declare @prev_L2200D_stc01_claim_status_code varchar(30)
declare @prev_L2200D_stc01_entity_id_code char(3)
declare @prev_L2200D_stc02_eff_date char(8)
declare @prev_L2200D_stc03_action_code char(2)
declare @prev_L2200D_stc04_total_submitted_charges money 
declare @prev_L2200D_stc10_claim_status_cat_code varchar(30)
declare @prev_L2200D_stc10_claim_status_code varchar(30)
declare @prev_L2200D_stc10_entity_code char(3)
declare @prev_L2200D_stc11_claim_status_cat_code varchar(30)
declare @prev_L2200D_stc11_claim_status_code varchar(30)
declare @prev_L2200D_stc11_entity_code char(3)
declare @prev_L2200D_ref02_1K_payer_claim_control_num varchar(50)
declare @prev_L2200D_ref02_D9_clearinghouse_trace_num varchar(50)
declare @prev_L2200D_ref02_BLT_bill_type varchar(50)
declare @prev_L2200D_dtp03_232_from_service_date varchar(35)
declare @prev_L2200D_dtp03_232_to_service_date varchar(35)
declare @prev_L2220D_svc01_proc_code_qual char(2)
declare @prev_L2220D_svc01_proc_code varchar(48)
declare @prev_L2220D_svc01_proc_mod1 char(2)
declare @prev_L2220D_svc01_proc_mod2 char(2)
declare @prev_L2220D_svc01_proc_mod3 char(2)
declare @prev_L2220D_svc01_proc_mod4 char(2)
declare @prev_L2220D_svc02_charge_amt money 
declare @prev_L2220D_svc04_revenue_code varchar(48)
declare @prev_L2220D_svc07_service_unit_count varchar(15)
declare @prev_L2220D_stc01_entity_id_code char(3)
declare @prev_L2220D_stc02_eff_date char(8)
declare @prev_L2220D_stc03_action_code char(2)
declare @prev_L2220D_stc04_total_submitted_charges money 
declare @prev_L2220D_stc10_claim_status_cat_code varchar(30)
declare @prev_L2220D_stc10_claim_status_code varchar(30)
declare @prev_L2220D_stc10_entity_code char(3)
declare @prev_L2220D_stc11_claim_status_cat_code varchar(30)
declare @prev_L2220D_stc11_claim_status_code varchar(30)
declare @prev_L2220D_stc11_entity_code char(3)
declare @prev_L2220D_ref02_FJ_line_item_control_num varchar(50)
declare @prev_L2220D_dtp03_472_from_service_date varchar(35)
declare @prev_L2220D_dtp03_472_to_service_date varchar(35)

declare @x12_interchange_uid uniqueidentifier

declare @global_hl01_hierarchical_id_num int

--BEGIN: Initialize transaction variables here.
set @global_hl01_hierarchical_id_num = 0
set @prev_L2000A_hl01_hierarchical_id_num = 0
set @prev_L2000B_hl01_hierarchical_id_num = 0
set @prev_L2000C_hl01_hierarchical_id_num = 0
set @prev_L2000D_hl01_hierarchical_id_num = 0
set @segment_count = 0

-- Set the x12_interchange_uid value of the transaction that's being exported.
select @x12_interchange_uid = x12_interchange_uid
from vw_x12_transaction
where x12_transaction_id = @x12_transaction_id
-- END: Initialize transaction variables.

declare @errmsg varchar(250)
declare @errcode int
 --delcare the cursor

DECLARE curtx12doc SCROLL CURSOR FOR
			SELECT	x12_transaction_id,
				bht01_hierarchical_structure_code,
				bht02_trans_set_purpose_code,
				bht03_trans_batch_id,
				bht04_trans_set_creation_date,
				bht05_trans_set_creation_time,
				bht06_trans_type_code,
				L2000A_hl01_hierarchical_id_num,
				L2000A_hl03_hierarchical_level_code,
				L2000A_hl04_hierarchical_child_code,
				L2100A_nm101_entity_id_code,
				L2100A_nm102_entity_type_qual,
				L2100A_nm103_info_source_last_nm,
				L2100A_nm108_info_source_id_qual,
				L2100A_nm109_info_source_id,
				L2200A_trn01_trace_type_code,
				L2200A_trn02_app_trace_id,
				L2200A_dtp03_050_receipt_date,
				L2200A_dtp03_009_process_date,
				L2000B_hl01_hierarchical_id_num,
				L2000B_hl02_hierarchical_parent_id_num,
				L2000B_hl03_hierarchical_level_code,
				L2000B_hl04_hierarchical_child_code,
				L2100B_nm102_entity_type_qual,
				L2100B_nm103_info_receiver_last_nm,
				L2100B_nm104_info_receiver_first_nm,
				L2100B_nm105_info_receiver_middle_nm,
				L2100B_nm108_info_receiver_id_qual,
				L2100B_nm109_info_receiver_id,
				L2200B_trn01_trace_type_code,
				L2200B_trn02_trace_id,
				L2200B_stc01_claim_status_cat_code,
				L2200B_stc01_claim_status_code,
				L2200B_stc01_entity_id_code,
				L2200B_stc02_eff_date,
				L2200B_stc03_action_code,
				L2200B_stc04_total_submitted_charges, 
				L2200B_stc10_claim_status_cat_code,
				L2200B_stc10_claim_status_code,
				L2200B_stc10_entity_code,
				L2200B_stc11_claim_status_cat_code,
				L2200B_stc11_claim_status_code,
				L2200B_stc11_entity_code,
				L2200B_qty02_accepted_quantity,
				L2200B_qty02_rejected_quantity,
				L2200B_amt02_total_accepted_charges, 
				L2200B_amt02_total_rejected_charges, 
				L2000C_hl01_hierarchical_id_num,
				L2000C_hl02_hierarchical_parent_id_num,
				L2000C_hl03_hierarchical_level_code,
				L2000C_hl04_hierarchical_child_code,
				L2100C_nm102_entity_type_qual,
				L2100C_nm103_billing_prov_last_nm,
				L2100C_nm104_billing_prov_first_nm,
				L2100C_nm105_billing_prov_middle_nm,
				L2100C_nm107_billing_prov_suffix,
				L2100C_nm108_id_code_qual,
				L2100C_nm109_billing_prov_id,
				L2200C_trn01_trace_type_code,
				L2200C_trn02_trace_id,
				L2200C_stc01_claim_status_cat_code,
				L2200C_stc01_claim_status_code,
				L2200C_stc01_entity_id_code,
				L2200C_stc03_action_code,
				L2200C_stc04_total_submitted_charges, 
				L2200C_stc10_claim_status_cat_code,
				L2200C_stc10_claim_status_code,
				L2200C_stc10_entity_code,
				L2200C_stc11_claim_status_cat_code,
				L2200C_stc11_claim_status_code,
				L2200C_stc11_entity_code,
				L2200C_ref02_0B_billing_prov_id,
				L2200C_ref02_G2_billing_prov_id,
				L2200C_ref02_1G_billing_prov_id,
				L2200C_ref02_EI_billing_prov_id,
				L2200C_ref02_SY_billing_prov_id,
				L2200C_ref02_LU_billing_prov_id,
				L2200C_qty02_accepted_quantity,
				L2200C_qty02_rejected_quantity,
				L2200C_amt02_total_accepted_charges, 
				L2200C_amt02_total_rejected_charges, 
				L2000D_hl01_hierarchical_id_num,
				L2000D_hl02_hierarchical_parent_id_num,
				L2000D_hl03_hierarchical_level_code,
				L2000D_hl04_hierarchical_child_code,
				L2000D_dmg02_subscriber_dob,
				L2000D_dmg03_subscriber_gender,
				L2000D_nm102_entity_type_qual,
				L2000D_nm103_patient_last_nm,
				L2000D_nm104_patient_first_nm,
				L2000D_nm105_patient_middle_nm,
				L2000D_nm107_patient_suffix,
				L2000D_nm108_id_code_qual,
				L2000D_nm109_patient_id,
				L2200D_trn01_trace_type_code,
				L2200D_trn02_pt_accnt_num,
				L2200D_stc01_claim_status_cat_code,
				L2200D_stc01_claim_status_code,
				L2200D_stc01_entity_id_code,
				L2200D_stc02_eff_date,
				L2200D_stc03_action_code,
				L2200D_stc04_total_submitted_charges, 
				L2200D_stc05_claim_payment_amt,
				L2200D_stc06_payment_date,
				L2200D_stc07_payment_method,
				L2200D_stc08_check_date,
				L2200D_stc09_check_number,
				L2200D_stc10_claim_status_cat_code,
				L2200D_stc10_claim_status_code,
				L2200D_stc10_entity_code,
				L2200D_stc11_claim_status_cat_code,
				L2200D_stc11_claim_status_code,
				L2200D_stc11_entity_code,
				L2200D_ref02_1K_payer_claim_control_num,
				L2200D_ref02_D9_clearinghouse_trace_num,
				L2200D_ref02_BLT_bill_type,
				L2200D_ref02_EA_medical_record_num,
				L2200D_dtp03_232_from_service_date,
				L2200D_dtp03_232_to_service_date,
				L2220D_svc01_proc_code_qual,
				L2220D_svc01_proc_code,
				L2220D_svc01_proc_mod1,
				L2220D_svc01_proc_mod2,
				L2220D_svc01_proc_mod3,
				L2220D_svc01_proc_mod4,
				L2220D_svc02_charge_amt,
				L2220D_svc03_line_item_prov_pmt_amt,
				L2220D_svc04_revenue_code,
				L2220D_svc07_service_unit_count,
				L2220D_stc01_status_cat_code,
				L2220D_stc01_status_code,
				L2220D_stc01_entity_id_code,
				L2220D_stc02_eff_date,
				L2220D_stc03_action_code,
				L2220D_stc04_total_submitted_charges,
				L2220D_stc05_line_item_prov_pmt_amt,
				L2220D_stc10_claim_status_cat_code,
				L2220D_stc10_claim_status_code,
				L2220D_stc10_entity_code,
				L2220D_stc11_claim_status_cat_code,
				L2220D_stc11_claim_status_code,
				L2220D_stc11_entity_code,
				L2220D_ref02_FJ_line_item_control_num,
				L2220D_dtp03_472_from_service_date,
				L2220D_dtp03_472_to_service_date
			from x12_277_claim_ack
			where	x12_transaction_id = @x12_transaction_id
			order by x12_277_claim_ack_id

OPEN curtX12Doc
-- fetch all the columns into the variables
FETCH NEXT FROM curtX12Doc INTO	@x12_transaction_id,
				@bht01_hierarchical_structure_code,
				@bht02_trans_set_purpose_code,
				@bht03_trans_batch_id,
				@bht04_trans_set_creation_date,
				@bht05_trans_set_creation_time,
				@bht06_trans_type_code,
				@L2000A_hl01_hierarchical_id_num,
				@L2000A_hl03_hierarchical_level_code,
				@L2000A_hl04_hierarchical_child_code,
				@L2100A_nm101_entity_id_code,
				@L2100A_nm102_entity_type_qual,
				@L2100A_nm103_info_source_last_nm,
				@L2100A_nm108_info_source_id_qual,
				@L2100A_nm109_info_source_id,
				@L2200A_trn01_trace_type_code,
				@L2200A_trn02_app_trace_id,
				@L2200A_dtp03_050_receipt_date,
				@L2200A_dtp03_009_process_date,
				@L2000B_hl01_hierarchical_id_num,
				@L2000B_hl02_hierarchical_parent_id_num,
				@L2000B_hl03_hierarchical_level_code,
				@L2000B_hl04_hierarchical_child_code,
				@L2100B_nm102_entity_type_qual,
				@L2100B_nm103_info_receiver_last_nm,
				@L2100B_nm104_info_receiver_first_nm,
				@L2100B_nm105_info_receiver_middle_nm,
				@L2100B_nm108_info_receiver_id_qual,
				@L2100B_nm109_info_receiver_id,
				@L2200B_trn01_trace_type_code,
				@L2200B_trn02_trace_id,
				@L2200B_stc01_claim_status_cat_code,
				@L2200B_stc01_claim_status_code,
				@L2200B_stc01_entity_id_code,
				@L2200B_stc02_eff_date,
				@L2200B_stc03_action_code,
				@L2200B_stc04_total_submitted_charges, 
				@L2200B_stc10_claim_status_cat_code,
				@L2200B_stc10_claim_status_code,
				@L2200B_stc10_entity_code,
				@L2200B_stc11_claim_status_cat_code,
				@L2200B_stc11_claim_status_code,
				@L2200B_stc11_entity_code,
				@L2200B_qty02_accepted_quantity,
				@L2200B_qty02_rejected_quantity,
				@L2200B_amt02_total_accepted_charges, 
				@L2200B_amt02_total_rejected_charges, 
				@L2000C_hl01_hierarchical_id_num,
				@L2000C_hl02_hierarchical_parent_id_num,
				@L2000C_hl03_hierarchical_level_code,
				@L2000C_hl04_hierarchical_child_code,
				@L2100C_nm102_entity_type_qual,
				@L2100C_nm103_billing_prov_last_nm,
				@L2100C_nm104_billing_prov_first_nm,
				@L2100C_nm105_billing_prov_middle_nm,
				@L2100C_nm107_billing_prov_suffix,
				@L2100C_nm108_id_code_qual,
				@L2100C_nm109_billing_prov_id,
				@L2200C_trn01_trace_type_code,
				@L2200C_trn02_trace_id,
				@L2200C_stc01_claim_status_cat_code,
				@L2200C_stc01_claim_status_code,
				@L2200C_stc01_entity_id_code,
				@L2200C_stc03_action_code,
				@L2200C_stc04_total_submitted_charges, 
				@L2200C_stc10_claim_status_cat_code,
				@L2200C_stc10_claim_status_code,
				@L2200C_stc10_entity_code,
				@L2200C_stc11_claim_status_cat_code,
				@L2200C_stc11_claim_status_code,
				@L2200C_stc11_entity_code,
				@L2200C_ref02_0B_billing_prov_id,
				@L2200C_ref02_G2_billing_prov_id,
				@L2200C_ref02_1G_billing_prov_id,
				@L2200C_ref02_EI_billing_prov_id,
				@L2200C_ref02_SY_billing_prov_id,
				@L2200C_ref02_LU_billing_prov_id,
				@L2200C_qty02_accepted_quantity,
				@L2200C_qty02_rejected_quantity,
				@L2200C_amt02_total_accepted_charges, 
				@L2200C_amt02_total_rejected_charges, 
				@L2000D_hl01_hierarchical_id_num,
				@L2000D_hl02_hierarchical_parent_id_num,
				@L2000D_hl03_hierarchical_level_code,
				@L2000D_hl04_hierarchical_child_code,
				@L2000D_dmg02_subscriber_dob,
				@L2000D_dmg03_subscriber_gender,
				@L2000D_nm102_entity_type_qual,
				@L2000D_nm103_patient_last_nm,
				@L2000D_nm104_patient_first_nm,
				@L2000D_nm105_patient_middle_nm,
				@L2000D_nm107_patient_suffix,
				@L2000D_nm108_id_code_qual,
				@L2000D_nm109_patient_id,
				@L2200D_trn01_trace_type_code,
				@L2200D_trn02_pt_accnt_num,
				@L2200D_stc01_claim_status_cat_code,
				@L2200D_stc01_claim_status_code,
				@L2200D_stc01_entity_id_code,
				@L2200D_stc02_eff_date,
				@L2200D_stc03_action_code,
				@L2200D_stc04_total_submitted_charges, 
				@L2200D_stc05_claim_payment_amt,
				@L2200D_stc06_payment_date,
				@L2200D_stc07_payment_method,
				@L2200D_stc08_check_date,
				@L2200D_stc09_check_number,
				@L2200D_stc10_claim_status_cat_code,
				@L2200D_stc10_claim_status_code,
				@L2200D_stc10_entity_code,
				@L2200D_stc11_claim_status_cat_code,
				@L2200D_stc11_claim_status_code,
				@L2200D_stc11_entity_code,
				@L2200D_ref02_1K_payer_claim_control_num,
				@L2200D_ref02_D9_clearinghouse_trace_num,
				@L2200D_ref02_BLT_bill_type,
				@L2200D_ref02_EA_medical_record_num,
				@L2200D_dtp03_232_from_service_date,
				@L2200D_dtp03_232_to_service_date,
				@L2220D_svc01_proc_code_qual,
				@L2220D_svc01_proc_code,
				@L2220D_svc01_proc_mod1,
				@L2220D_svc01_proc_mod2,
				@L2220D_svc01_proc_mod3,
				@L2220D_svc01_proc_mod4,
				@L2220D_svc02_charge_amt,
				@L2220D_svc03_line_item_prov_pmt_amt,
				@L2220D_svc04_revenue_code,
				@L2220D_svc07_service_unit_count,
				@L2220D_stc01_status_cat_code,
				@L2220D_stc01_status_code,
				@L2220D_stc01_entity_id_code,
				@L2220D_stc02_eff_date,
				@L2220D_stc03_action_code,
				@L2220D_stc04_total_submitted_charges,
				@L2220D_stc05_line_item_prov_pmt_amt,
				@L2220D_stc10_claim_status_cat_code,
				@L2220D_stc10_claim_status_code,
				@L2220D_stc10_entity_code,
				@L2220D_stc11_claim_status_cat_code,
				@L2220D_stc11_claim_status_code,
				@L2220D_stc11_entity_code,
				@L2220D_ref02_FJ_line_item_control_num,
				@L2220D_dtp03_472_from_service_date,
				@L2220D_dtp03_472_to_service_date

WHILE (@@fetch_status <> -1)
BEGIN


	-- Insert the BHT segment
	if (	ISNULL(@bht01_hierarchical_structure_code, '') <> ISNULL(@prev_bht01_hierarchical_structure_code, '') OR
		ISNULL(@bht02_trans_set_purpose_code, '') <> ISNULL(@prev_bht02_trans_set_purpose_code, '') OR
		ISNULL(@bht03_trans_batch_id, '') <> ISNULL(@prev_bht03_trans_batch_id, '') OR
		ISNULL(@bht04_trans_set_creation_date, '') <> ISNULL(@prev_bht04_trans_set_creation_date, '') OR
		ISNULL(@bht05_trans_set_creation_time, '') <> ISNULL(@prev_bht05_trans_set_creation_time, '') OR
		ISNULL(@bht06_trans_type_code, '') <> ISNULL(@prev_bht06_trans_type_code, '') OR
		@prev_bht01_hierarchical_structure_code IS NULL)
	Begin
		set @prev_bht01_hierarchical_structure_code = @bht01_hierarchical_structure_code
		set @prev_bht02_trans_set_purpose_code = @bht02_trans_set_purpose_code
		set @prev_bht03_trans_batch_id = @bht03_trans_batch_id
		set @prev_bht04_trans_set_creation_date = @bht04_trans_set_creation_date
		set @prev_bht05_trans_set_creation_time = @bht05_trans_set_creation_time
		set @prev_bht06_trans_type_code = @bht06_trans_type_code

		exec up_x12_bht_export	@x12_interchange_uid = @x12_interchange_uid,
					@bht01_hierarchical_structure_code = @bht01_hierarchical_structure_code,
					@bht02_tran_purpose_code = @bht02_trans_set_purpose_code,
					@bht03_app_tran_id = @bht03_trans_batch_id,
					@bht04_tran_set_create_date = @bht04_trans_set_creation_date,
					@bht05_tran_set_create_time = @bht05_trans_set_creation_time,
					@bht06_tran_type_code = @bht06_trans_type_code
	end


	-- BEGIN 2000A LOOP, INFORMATION SOURCE DETAIL
	if (	ISNULL(@L2000A_hl01_hierarchical_id_num, '') <> ISNULL(@prev_L2000A_hl01_hierarchical_id_num, '') OR
		ISNULL(@L2000A_hl03_hierarchical_level_code, '') <> ISNULL(@prev_L2000A_hl03_hierarchical_level_code, '') OR
		ISNULL(@L2000A_hl04_hierarchical_child_code, '') <> ISNULL(@prev_L2000A_hl04_hierarchical_child_code, '') OR
		@prev_L2000A_hl01_hierarchical_id_num IS NULL)
	begin
		if (@L2000A_hl01_hierarchical_id_num IS NULL)
		begin
			set @global_hl01_hierarchical_id_num = @global_hl01_hierarchical_id_num + 1
			set @L2000A_hl01_hierarchical_id_num = STR(@global_hl01_hierarchical_id_num)
		end

		set @prev_L2000A_hl01_hierarchical_id_num = @L2000A_hl01_hierarchical_id_num

		exec up_x12_hl_export	@x12_interchange_uid = @x12_interchange_uid,
					@hl01_id_num = @L2000A_hl01_hierarchical_id_num,
					@hl03_level_code = @L2000A_hl03_hierarchical_level_code,
					@hl04_child_code = @L2000A_hl04_hierarchical_child_code

		-- The 2100A Loop is always required within the 2000A Loop; the NM1 segment is always required.
		exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
					@nm101_entity_id_code = @L2100A_nm101_entity_id_code,
					@nm102_entity_type_qual = '2', -- the information source is always a non-person entity
					@nm103_last_name = @L2100A_nm103_info_source_last_nm,
					@nm108_id_code_qual = @L2100A_nm108_info_source_id_qual,
					@nm109_id_code = @L2100A_nm109_info_source_id

		-- BEGIN 2200A Loop, always required within the 2000A Loop
		-- The 2200A-TRN segment is always required within the 2200A Loop
		exec up_x12_trn_export	@x12_interchange_uid = @x12_interchange_uid,
					@trn01_trace_type_code = @L2200A_trn01_trace_type_code,
					@trn02_reference_id = @L2200A_trn02_app_trace_id

		-- The 2200A-DTP receipt segment is always required within the 2200A Loop
		exec up_x12_dtp_export	@x12_interchange_uid = @x12_interchange_uid,
					@dtp01_date_time_qual = '050',
					@dtp02_date_time_format_qual = 'D8',
					@dtp03_begin_date = @L2200A_dtp03_050_receipt_date
		-- The 2200A-DTP process segment is always required within the 2200A Loop
		exec up_x12_dtp_export	@x12_interchange_uid = @x12_interchange_uid,
					@dtp01_date_time_qual = '009',
					@dtp02_date_time_format_qual = 'D8',
					@dtp03_begin_date = @L2200A_dtp03_009_process_date
		-- END 2200A Loop
	end
	-- END 2000A LOOP

	-- BEGIN 2000B LOOP, INFORMATION RECEIVER DETAIL
	if (	ISNULL(@L2000B_hl01_hierarchical_id_num, '') <> ISNULL(@prev_L2000B_hl01_hierarchical_id_num, '') OR
		ISNULL(@L2000B_hl02_hierarchical_parent_id_num, '') <> ISNULL(@prev_L2000B_hl02_hierarchical_parent_id_num, '') OR
		ISNULL(@L2000B_hl03_hierarchical_level_code, '') <> ISNULL(@prev_L2000B_hl03_hierarchical_level_code, '') OR
		ISNULL(@L2000B_hl04_hierarchical_child_code, '') <> ISNULL(@prev_L2000B_hl04_hierarchical_child_code, '') OR
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

		set @prev_L2000B_hl01_hierarchical_id_num = @L2000B_hl01_hierarchical_id_num

		exec up_x12_hl_export	@x12_interchange_uid = @x12_interchange_uid,
					@hl01_id_num = @L2000B_hl01_hierarchical_id_num,
					@hl02_parent_id_num = @L2000B_hl02_hierarchical_parent_id_num,
					@hl03_level_code = @L2000B_hl03_hierarchical_level_code,
					@hl04_child_code = @L2000B_hl04_hierarchical_child_code

		-- The 2100B Loop is always required within the 2000B Loop; the NM1 segment is always required.
		exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
					@nm101_entity_id_code = '41',
					@nm102_entity_type_qual = @L2100B_nm102_entity_type_qual,
					@nm103_last_name = @L2100B_nm103_info_receiver_last_nm,
					@nm104_first_name = @L2100B_nm104_info_receiver_first_nm,
					@nm105_middle_name = @L2100B_nm105_info_receiver_middle_nm,
					@nm108_id_code_qual = @L2100B_nm108_info_receiver_id_qual,
					@nm109_id_code = @L2100B_nm109_info_receiver_id


		if (@L2200B_trn02_trace_id IS NOT NULL)
		begin
			-- BEGIN 2200B Loop (For version 5010), always required within the 2000B Loop
			-- The 2200B-TRN segment is always required within the 2200B Loop
			exec up_x12_trn_export	@x12_interchange_uid = @x12_interchange_uid,
						@trn01_trace_type_code = @L2200B_trn01_trace_type_code,
						@trn02_reference_id = @L2200B_trn02_trace_id
			-- The 2200B-STC segment is always required within the 2200B Loop
			exec up_x12_stc_export	@x12_interchange_uid = @x12_interchange_uid,
						@stc01_claim_status_cat_code = @L2200B_stc01_claim_status_cat_code,
						@stc01_claim_status_code = @L2200B_stc01_claim_status_code,
						@stc01_entity_id_code = @L2200B_stc01_entity_id_code,
						@stc02_eff_date = @L2200B_stc02_eff_date,
						@stc03_action_code = @L2200B_stc03_action_code,
						@stc04_total_submitted_charges = @L2200B_stc04_total_submitted_charges,
						@stc10_claim_status_cat_code = @L2200B_stc10_claim_status_cat_code,
						@stc10_claim_status_code = @L2200B_stc10_claim_status_code,
						@stc10_entity_code = @L2200B_stc10_entity_code,
						@stc11_claim_status_cat_code = @L2200B_stc11_claim_status_cat_code,
						@stc11_claim_status_code = @L2200B_stc11_claim_status_code,
						@stc11_entity_code = @L2200B_stc11_entity_code
			-- The 2200B-QTY accepted segment is situational within the 2200B Loop
			exec up_x12_qty_export	@x12_interchange_uid = @x12_interchange_uid,
						@qty01_quantity_qual_code = 'QA',
						@qty02_quantity = @L2200B_qty02_accepted_quantity
			-- The 2200B-QTY rejected segment is situational within the 2200B Loop
			exec up_x12_qty_export	@x12_interchange_uid = @x12_interchange_uid,
						@qty01_quantity_qual_code = 'QC',
						@qty02_quantity = @L2200B_qty02_rejected_quantity
			-- The 2200B-AMT accepted segment is situational within the 2200B Loop
			exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
						@amt01_amount_qual_code = 'YU',
						@amt02_amount = @L2200B_amt02_total_accepted_charges
			-- The 2200B-AMT rejected segment is situational within the 2200B Loop
			exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
						@amt01_amount_qual_code = 'YY',
						@amt02_amount = @L2200B_amt02_total_rejected_charges
			-- END 2200B Loop
		end
	end
	-- END 2000B LOOP


	-- BEGIN 2000C LOOP, BILLING PROVIDER OF SERVICE DETAIL
	if (	ISNULL(@L2000C_hl01_hierarchical_id_num, '') <> ISNULL(@prev_L2000C_hl01_hierarchical_id_num, '') OR
		ISNULL(@L2000C_hl02_hierarchical_parent_id_num, '') <> ISNULL(@prev_L2000C_hl02_hierarchical_parent_id_num, '') OR
		ISNULL(@L2000C_hl03_hierarchical_level_code, '') <> ISNULL(@prev_L2000C_hl03_hierarchical_level_code, '') OR
		ISNULL(@L2000C_hl04_hierarchical_child_code, '') <> ISNULL(@prev_L2000C_hl04_hierarchical_child_code, '') OR
		@prev_L2000C_hl01_hierarchical_id_num IS NULL)
	begin
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


		exec up_x12_hl_export	@x12_interchange_uid = @x12_interchange_uid,
					@hl01_id_num = @L2000C_hl01_hierarchical_id_num,
					@hl02_parent_id_num = @L2000C_hl02_hierarchical_parent_id_num,
					@hl03_level_code = @L2000C_hl03_hierarchical_level_code,
					@hl04_child_code = @L2000C_hl04_hierarchical_child_code

		-- The 2100C Loop is always required within the 2000C Loop; the NM1 segment is always required.
		exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
					@nm101_entity_id_code = '1P',
					@nm102_entity_type_qual = @L2100C_nm102_entity_type_qual,
					@nm103_last_name = @L2100C_nm103_billing_prov_last_nm,
					@nm104_first_name = @L2100C_nm104_billing_prov_first_nm,
					@nm105_middle_name = @L2100C_nm105_billing_prov_middle_nm,
					@nm107_name_suffix = @L2100C_nm107_billing_prov_suffix,
					@nm108_id_code_qual = @L2100C_nm108_id_code_qual,
					@nm109_id_code = @L2100C_nm109_billing_prov_id

		if (@L2200C_trn02_trace_id IS NOT NULL)
		begin
			-- BEGIN 2200C (For version 5010) Loop, situational within the 2000C Loop
			-- The 2200C-TRN segment is situational within the 2200C Loop
			exec up_x12_trn_export	@x12_interchange_uid = @x12_interchange_uid,
						@trn01_trace_type_code = @L2200C_trn01_trace_type_code,
						@trn02_reference_id = @L2200C_trn02_trace_id
			-- The 2200C-STC segment is situational within the 2200C Loop
			exec up_x12_stc_export	@x12_interchange_uid = @x12_interchange_uid,
						@stc01_claim_status_cat_code = @L2200C_stc01_claim_status_cat_code,
						@stc01_claim_status_code = @L2200C_stc01_claim_status_code,
						@stc01_entity_id_code = @L2200C_stc01_entity_id_code,
						@stc03_action_code = @L2200C_stc03_action_code,
						@stc04_total_submitted_charges = @L2200C_stc04_total_submitted_charges,
						@stc10_claim_status_cat_code = @L2200C_stc10_claim_status_cat_code,
						@stc10_claim_status_code = @L2200C_stc10_claim_status_code,
						@stc10_entity_code = @L2200C_stc10_entity_code,
						@stc11_claim_status_cat_code = @L2200C_stc11_claim_status_cat_code,
						@stc11_claim_status_code = @L2200C_stc11_claim_status_code,
						@stc11_entity_code = @L2200C_stc11_entity_code
			-- The 2200C-REF segments are situational within the 2200C Loop
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = '0B',
						@ref02_reference_number = @L2200C_ref02_0B_billing_prov_id
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'G2',
						@ref02_reference_number = @L2200C_ref02_G2_billing_prov_id
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = '1G',
						@ref02_reference_number = @L2200C_ref02_1G_billing_prov_id
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'EI',
						@ref02_reference_number = @L2200C_ref02_EI_billing_prov_id
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'SY',
						@ref02_reference_number = @L2200C_ref02_SY_billing_prov_id
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'LU',
						@ref02_reference_number = @L2200C_ref02_LU_billing_prov_id
	
			-- The 2200C-QTY accepted segment is situational within the 2200C Loop
			exec up_x12_qty_export	@x12_interchange_uid = @x12_interchange_uid,
						@qty01_quantity_qual_code = 'QA',
						@qty02_quantity = @L2200C_qty02_accepted_quantity
			-- The 2200C-QTY rejected segment is situational within the 2200C Loop
			exec up_x12_qty_export	@x12_interchange_uid = @x12_interchange_uid,
						@qty01_quantity_qual_code = 'QC',
						@qty02_quantity = @L2200C_qty02_rejected_quantity
			-- The 2200C-AMT accepted segment is situational within the 2200C Loop
			exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
						@amt01_amount_qual_code = 'YU',
						@amt02_amount = @L2200C_amt02_total_accepted_charges
			-- The 2200C-AMT rejected segment is situational within the 2200C Loop
			exec up_x12_amt_export	@x12_interchange_uid = @x12_interchange_uid,
						@amt01_amount_qual_code = 'YY',
						@amt02_amount = @L2200C_amt02_total_rejected_charges
			-- END 2200C Loop
		end
	end
	-- END 2000C LOOP


	-- BEGIN 2000D LOOP, PATIENT DETAIL
	if (	ISNULL(@L2000D_hl01_hierarchical_id_num, '') <> ISNULL(@prev_L2000D_hl01_hierarchical_id_num, '') OR
		ISNULL(@L2000D_hl02_hierarchical_parent_id_num, '') <> ISNULL(@prev_L2000D_hl02_hierarchical_parent_id_num, '') OR
		ISNULL(@L2000D_hl03_hierarchical_level_code, '') <> ISNULL(@prev_L2000D_hl03_hierarchical_level_code, '') OR
		@prev_L2000D_hl01_hierarchical_id_num IS NULL)
	begin
		if (@L2000D_hl01_hierarchical_id_num IS NULL)
		begin
			set @global_hl01_hierarchical_id_num = @global_hl01_hierarchical_id_num + 1
			set @L2000D_hl01_hierarchical_id_num = STR(@global_hl01_hierarchical_id_num)
		end

		if (@L2000D_hl02_hierarchical_parent_id_num IS NULL)
		begin
			set @L2000D_hl02_hierarchical_parent_id_num = @L2000C_hl01_hierarchical_id_num
		end

		set @prev_L2000D_hl01_hierarchical_id_num = @L2000D_hl01_hierarchical_id_num

		exec up_x12_hl_export	@x12_interchange_uid = @x12_interchange_uid,
					@hl01_id_num = @L2000D_hl01_hierarchical_id_num,
					@hl02_parent_id_num = @L2000D_hl02_hierarchical_parent_id_num,
					@hl03_level_code = @L2000D_hl03_hierarchical_level_code,
					@hl04_child_code = @L2000D_hl04_hierarchical_child_code

		-- The 2100D Loop is always required within the 2000D Loop; the DMG segment is situational.
		exec up_x12_dmg_export	@x12_interchange_uid = @x12_interchange_uid,
					@dmg01_date_time_format_qual= 'D8',
					@dmg02_dob = @L2000D_dmg02_subscriber_dob,
					@dmg03_gender = @L2000D_dmg03_subscriber_gender

		-- The 2100D Loop is always required within the 2000D Loop; the NM1 segment is always required.
		exec up_x12_nm1_export	@x12_interchange_uid = @x12_interchange_uid,
					@nm101_entity_id_code = 'QC',
					@nm102_entity_type_qual = '1',
					@nm103_last_name = @L2000D_nm103_patient_last_nm,
					@nm104_first_name = @L2000D_nm104_patient_first_nm,
					@nm105_middle_name = @L2000D_nm105_patient_middle_nm,
					@nm107_name_suffix = @L2000D_nm107_patient_suffix,
					@nm108_id_code_qual = @L2000D_nm108_id_code_qual,
					@nm109_id_code = @L2000D_nm109_patient_id

		-- BEGIN 2200D Loop, always required within the 2000D Loop
		-- The 2200D-TRN segment is always required within the 2200D Loop
		exec up_x12_trn_export	@x12_interchange_uid = @x12_interchange_uid,
					@trn01_trace_type_code = @L2200D_trn01_trace_type_code,
					@trn02_reference_id = @L2200D_trn02_pt_accnt_num
		-- The 2200D-STC segment is always required within the 2200D Loop
		exec up_x12_stc_export	@x12_interchange_uid = @x12_interchange_uid,
					@stc01_claim_status_cat_code = @L2200D_stc01_claim_status_cat_code,
					@stc01_claim_status_code = @L2200D_stc01_claim_status_code,
					@stc01_entity_id_code = @L2200D_stc01_entity_id_code,
					@stc02_eff_date = @L2200D_stc02_eff_date,
					@stc03_action_code = @L2200D_stc03_action_code,
					@stc04_total_submitted_charges = @L2200D_stc04_total_submitted_charges,
					@stc05_claim_payment_amt = @L2200D_stc05_claim_payment_amt,
					@stc06_payment_date = @L2200D_stc06_payment_date,
					@stc07_payment_method = @L2200D_stc07_payment_method,
					@stc08_check_date = @L2200D_stc08_check_date,
					@stc09_check_number = @L2200D_stc09_check_number,
					@stc10_claim_status_cat_code = @L2200D_stc10_claim_status_cat_code,
					@stc10_claim_status_code = @L2200D_stc10_claim_status_code,
					@stc10_entity_code = @L2200D_stc10_entity_code,
					@stc11_claim_status_cat_code = @L2200D_stc11_claim_status_cat_code,
					@stc11_claim_status_code = @L2200D_stc11_claim_status_code,
					@stc11_entity_code = @L2200D_stc11_entity_code
		-- The 2200D-REF payer claim control number segment is situational within the 2200D Loop
		exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
					@ref01_id_qual = '1K',
					@ref02_reference_number = @L2200D_ref02_1K_payer_claim_control_num
		-- The 2200D-REF clearinghouse claim ID segment is situational within the 2200D Loop
		exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
					@ref01_id_qual = 'D9',
					@ref02_reference_number = @L2200D_ref02_D9_clearinghouse_trace_num
		-- The 2200D-REF institutional bill type segment is situational within the 2200D Loop
		exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
					@ref01_id_qual = 'BLT',
					@ref02_reference_number = @L2200D_ref02_BLT_bill_type
		-- The 2200D-REF medical record number segment is situational within the 2200D Loop
		exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
					@ref01_id_qual = 'EA',
					@ref02_reference_number = @L2200D_ref02_EA_medical_record_num

		-- The 2200D-DTP claim level service date segment is situational within the 2200D Loop
		exec up_x12_dtp_export	@x12_interchange_uid = @x12_interchange_uid,
					@dtp01_date_time_qual = '232',
					@dtp02_date_time_format_qual = 'RD8',
					@dtp03_begin_date = @L2200D_dtp03_232_from_service_date,
					@dtp03_end_date = @L2200D_dtp03_232_to_service_date

		-- BEGIN 2220D Loop, situational within the 2220D Loop (if this is a new Line Item Control Number)
		if (	ISNULL(@L2220D_ref02_FJ_line_item_control_num, '') <> ISNULL(@prev_L2220D_ref02_FJ_line_item_control_num, '') OR
			@prev_L2220D_ref02_FJ_line_item_control_num IS NULL)
		begin
			-- The 2220D-SVC segment is situational within the 2220D Loop
			exec up_x12_svc_export	@x12_interchange_uid = @x12_interchange_uid,
						@svc01_proc_code_qual = @L2220D_svc01_proc_code_qual,
						@svc01_proc_code = @L2220D_svc01_proc_code,
						@svc01_proc_mod1 = @L2220D_svc01_proc_mod1,
						@svc01_proc_mod2 = @L2220D_svc01_proc_mod2,
						@svc01_proc_mod3 = @L2220D_svc01_proc_mod3,
						@svc01_proc_mod4 = @L2220D_svc01_proc_mod4,
						@svc02_line_charge = @L2220D_svc02_charge_amt,
						@svc03_line_item_prov_pmt_amt = @L2220D_svc03_line_item_prov_pmt_amt,
						@svc04_revenue_code = @L2220D_svc04_revenue_code,
						@svc07_units = @L2220D_svc07_service_unit_count

			-- The 2220D-STC segment is always required within the 2220D Loop
			exec up_x12_stc_export	@x12_interchange_uid = @x12_interchange_uid,
						@stc01_claim_status_cat_code = @L2220D_stc01_status_cat_code,
						@stc01_claim_status_code = @L2220D_stc01_status_code,
						@stc01_entity_id_code = @L2220D_stc01_entity_id_code,
						@stc02_eff_date = @L2220D_stc02_eff_date,
						@stc03_action_code = @L2220D_stc03_action_code,
						@stc04_total_submitted_charges = @L2220D_stc04_total_submitted_charges,
						@stc05_claim_payment_amt = @L2220D_stc05_line_item_prov_pmt_amt,
						@stc10_claim_status_cat_code = @L2220D_stc10_claim_status_cat_code,
						@stc10_claim_status_code = @L2220D_stc10_claim_status_code,
						@stc10_entity_code = @L2220D_stc10_entity_code,
						@stc11_claim_status_cat_code = @L2220D_stc11_claim_status_cat_code,
						@stc11_claim_status_code = @L2220D_stc11_claim_status_code,
						@stc11_entity_code = @L2220D_stc11_entity_code
			-- The 2220D-REF line item control number segment is always required within the 2220D Loop
			exec up_x12_ref_export	@x12_interchange_uid = @x12_interchange_uid,
						@ref01_id_qual = 'FJ',
						@ref02_reference_number = @L2220D_ref02_FJ_line_item_control_num
			-- The 2220D-DTP line level service date segment is situational within the 2220D Loop
			exec up_x12_dtp_export	@x12_interchange_uid = @x12_interchange_uid,
						@dtp01_date_time_qual = '472',
						@dtp02_date_time_format_qual = 'RD8',
						@dtp03_begin_date = @L2220D_dtp03_472_from_service_date,
						@dtp03_end_date = @L2220D_dtp03_472_to_service_date
			-- END 2220D Loop
		end
		-- END 2200D Loop
	end
	-- END 2000D LOOP

	FETCH NEXT FROM curtX12Doc INTO	@x12_transaction_id,
					@bht01_hierarchical_structure_code,
					@bht02_trans_set_purpose_code,
					@bht03_trans_batch_id,
					@bht04_trans_set_creation_date,
					@bht05_trans_set_creation_time,
					@bht06_trans_type_code,
					@L2000A_hl01_hierarchical_id_num,
					@L2000A_hl03_hierarchical_level_code,
					@L2000A_hl04_hierarchical_child_code,
					@L2100A_nm101_entity_id_code,
					@L2100A_nm102_entity_type_qual,
					@L2100A_nm103_info_source_last_nm,
					@L2100A_nm108_info_source_id_qual,
					@L2100A_nm109_info_source_id,
					@L2200A_trn01_trace_type_code,
					@L2200A_trn02_app_trace_id,
					@L2200A_dtp03_050_receipt_date,
					@L2200A_dtp03_009_process_date,
					@L2000B_hl01_hierarchical_id_num,
					@L2000B_hl02_hierarchical_parent_id_num,
					@L2000B_hl03_hierarchical_level_code,
					@L2000B_hl04_hierarchical_child_code,
					@L2100B_nm102_entity_type_qual,
					@L2100B_nm103_info_receiver_last_nm,
					@L2100B_nm104_info_receiver_first_nm,
					@L2100B_nm105_info_receiver_middle_nm,
					@L2100B_nm108_info_receiver_id_qual,
					@L2100B_nm109_info_receiver_id,
					@L2200B_trn01_trace_type_code,
					@L2200B_trn02_trace_id,
					@L2200B_stc01_claim_status_cat_code,
					@L2200B_stc01_claim_status_code,
					@L2200B_stc01_entity_id_code,
					@L2200B_stc02_eff_date,
					@L2200B_stc03_action_code,
					@L2200B_stc04_total_submitted_charges, 
					@L2200B_stc10_claim_status_cat_code,
					@L2200B_stc10_claim_status_code,
					@L2200B_stc10_entity_code,
					@L2200B_stc11_claim_status_cat_code,
					@L2200B_stc11_claim_status_code,
					@L2200B_stc11_entity_code,
					@L2200B_qty02_accepted_quantity,
					@L2200B_qty02_rejected_quantity,
					@L2200B_amt02_total_accepted_charges, 
					@L2200B_amt02_total_rejected_charges, 
					@L2000C_hl01_hierarchical_id_num,
					@L2000C_hl02_hierarchical_parent_id_num,
					@L2000C_hl03_hierarchical_level_code,
					@L2000C_hl04_hierarchical_child_code,
					@L2100C_nm102_entity_type_qual,
					@L2100C_nm103_billing_prov_last_nm,
					@L2100C_nm104_billing_prov_first_nm,
					@L2100C_nm105_billing_prov_middle_nm,
					@L2100C_nm107_billing_prov_suffix,
					@L2100C_nm108_id_code_qual,
					@L2100C_nm109_billing_prov_id,
					@L2200C_trn01_trace_type_code,
					@L2200C_trn02_trace_id,
					@L2200C_stc01_claim_status_cat_code,
					@L2200C_stc01_claim_status_code,
					@L2200C_stc01_entity_id_code,
					@L2200C_stc03_action_code,
					@L2200C_stc04_total_submitted_charges, 
					@L2200C_stc10_claim_status_cat_code,
					@L2200C_stc10_claim_status_code,
					@L2200C_stc10_entity_code,
					@L2200C_stc11_claim_status_cat_code,
					@L2200C_stc11_claim_status_code,
					@L2200C_stc11_entity_code,
					@L2200C_ref02_0B_billing_prov_id,
					@L2200C_ref02_G2_billing_prov_id,
					@L2200C_ref02_1G_billing_prov_id,
					@L2200C_ref02_EI_billing_prov_id,
					@L2200C_ref02_SY_billing_prov_id,
					@L2200C_ref02_LU_billing_prov_id,
					@L2200C_qty02_accepted_quantity,
					@L2200C_qty02_rejected_quantity,
					@L2200C_amt02_total_accepted_charges, 
					@L2200C_amt02_total_rejected_charges, 
					@L2000D_hl01_hierarchical_id_num,
					@L2000D_hl02_hierarchical_parent_id_num,
					@L2000D_hl03_hierarchical_level_code,
					@L2000D_hl04_hierarchical_child_code,
					@L2000D_dmg02_subscriber_dob,
					@L2000D_dmg03_subscriber_gender,
					@L2000D_nm102_entity_type_qual,
					@L2000D_nm103_patient_last_nm,
					@L2000D_nm104_patient_first_nm,
					@L2000D_nm105_patient_middle_nm,
					@L2000D_nm107_patient_suffix,
					@L2000D_nm108_id_code_qual,
					@L2000D_nm109_patient_id,
					@L2200D_trn01_trace_type_code,
					@L2200D_trn02_pt_accnt_num,
					@L2200D_stc01_claim_status_cat_code,
					@L2200D_stc01_claim_status_code,
					@L2200D_stc01_entity_id_code,
					@L2200D_stc02_eff_date,
					@L2200D_stc03_action_code,
					@L2200D_stc04_total_submitted_charges, 
					@L2200D_stc05_claim_payment_amt,
					@L2200D_stc06_payment_date,
					@L2200D_stc07_payment_method,
					@L2200D_stc08_check_date,
					@L2200D_stc09_check_number,
					@L2200D_stc10_claim_status_cat_code,
					@L2200D_stc10_claim_status_code,
					@L2200D_stc10_entity_code,
					@L2200D_stc11_claim_status_cat_code,
					@L2200D_stc11_claim_status_code,
					@L2200D_stc11_entity_code,
					@L2200D_ref02_1K_payer_claim_control_num,
					@L2200D_ref02_D9_clearinghouse_trace_num,
					@L2200D_ref02_BLT_bill_type,
					@L2200D_ref02_EA_medical_record_num,
					@L2200D_dtp03_232_from_service_date,
					@L2200D_dtp03_232_to_service_date,
					@L2220D_svc01_proc_code_qual,
					@L2220D_svc01_proc_code,
					@L2220D_svc01_proc_mod1,
					@L2220D_svc01_proc_mod2,
					@L2220D_svc01_proc_mod3,
					@L2220D_svc01_proc_mod4,
					@L2220D_svc02_charge_amt,
					@L2220D_svc03_line_item_prov_pmt_amt,
					@L2220D_svc04_revenue_code,
					@L2220D_svc07_service_unit_count,
					@L2220D_stc01_status_cat_code,
					@L2220D_stc01_status_code,
					@L2220D_stc01_entity_id_code,
					@L2220D_stc02_eff_date,
					@L2220D_stc03_action_code,
					@L2220D_stc04_total_submitted_charges,
					@L2220D_stc05_line_item_prov_pmt_amt,
					@L2220D_stc10_claim_status_cat_code,
					@L2220D_stc10_claim_status_code,
					@L2220D_stc10_entity_code,
					@L2220D_stc11_claim_status_cat_code,
					@L2220D_stc11_claim_status_code,
					@L2220D_stc11_entity_code,
					@L2220D_ref02_FJ_line_item_control_num,
					@L2220D_dtp03_472_from_service_date,
					@L2220D_dtp03_472_to_service_date
END

CLOSE curtX12Doc
DEALLOCATE curtX12Doc

	-- Count up all the segments we just inserted, exclude the transaction header segments
	select @segment_count = count(x12_parse_temp_id)
	from x12_parse_temp
	where	col001 NOT IN ('ISA', 'GS', 'ST', 'IEA', 'GE', 'SE') AND
		x12_parse_temp_uid = @x12_interchange_uid

--update x12_transaction set processed = 1 where x12_transaction_id = @x12_transaction_id
--return (0)





