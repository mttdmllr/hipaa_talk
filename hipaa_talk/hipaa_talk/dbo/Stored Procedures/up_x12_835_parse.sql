CREATE Procedure [dbo].[up_x12_835_parse] (@x12_transaction_id int, @se01_num_transaction_segments int = null output)
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

declare @bpr01_trans_handling_code char(2)
declare @bpr02_total_prov_pmt_amt money
declare @bpr03_credit_debit_flag_code char(1)
declare @bpr04_payment_method_code char(3)
declare @bpr05_payment_format_code varchar(10)
declare @bpr06_sender_dfi_id_qual char(2)
declare @bpr07_sender_dfi_id varchar(12)
declare @bpr08_sender_account_num_qual char(3)
declare @bpr09_sender_account_num varchar(35)
declare @bpr10_payer_id char(10)
declare @bpr11_orig_co_supp_code char(9)
declare @bpr12_receiver_dfi_id_qual char(2)
declare @bpr13_receiver_dfi_id varchar(12)
declare @bpr14_receiver_account_num_qual char(3)
declare @bpr15_receiver_account_num varchar(35)
declare @bpr16_check_date char(8)
declare @trn01_trace_type_code char(1)
declare @trn02_trace_number varchar(30)
declare @trn03_payer_id char(10)
declare @ref01_receiver_ref_id_qual char(3)
declare @ref02_receiver_ref_id varchar(30)
declare @dtm02_production_date char(8)
declare @L1000A_n101_entity_id_code char(3)
declare @L1000A_n102_payer_nm varchar(60)
declare @L1000A_n103_payer_id_qual char(2)
declare @L1000A_n104_payer_id varchar(80)
declare @L1000A_n301_payer_address1 varchar(55)
declare @L1000A_n302_payer_address2 varchar(55)
declare @L1000A_n401_payer_city varchar(30)
declare @L1000A_n402_payer_state char(2)
declare @L1000A_n403_payer_zip varchar(15)
declare @L1000A_ref01_ref_id_qual char(3)
declare @L1000A_ref02_add_payer_id varchar(30)
declare @L1000A_per01_contact_function_code char(2)
declare @L1000A_per02_contact_nm varchar(60)
declare @L1000A_per03_comm_num_qual char(2)
declare @L1000A_per04_comm_number varchar(80)
declare @L1000B_n101_entity_id_code char(3)
declare @L1000B_n102_payee_nm varchar(60)
declare @L1000B_n103_payee_id_qual char(2)
declare @L1000B_n104_payee_id varchar(80)
declare @L1000B_n301_payee_address1 varchar(55)
declare @L1000B_n302_payee_address2 varchar(55)
declare @L1000B_n401_payee_city varchar(30)
declare @L1000B_n402_payee_state char(2)
declare @L1000B_n403_payee_zip varchar(15)
declare @L1000B_ref01_ref_id_qual char(3)
declare @L1000B_ref02_add_payee_id varchar(30)
declare @L2000_lx01_assigned_number varchar(6)
declare @L2000_ts301_provider_identifier varchar(30)
declare @L2000_ts302_facility_type_code char(2)
declare @L2000_ts303_fiscal_period_date char(8)
declare @L2000_ts304_total_claim_count int
declare @L2000_ts306_total_covered_charge_amount money
declare @L2100_clp01_pt_control_no varchar(38)
declare @L2100_clp02_claim_status_code char(2)
declare @L2100_clp03_total_claim_chg_amt money
declare @L2100_clp04_claim_pmt_amt money
declare @L2100_clp05_pt_resp_amt money
declare @L2100_clp06_claim_filing_ind_code char(2)
declare @L2100_clp07_payer_claim_control_no varchar(30)
declare @L2100_clp08_facility_type_code char(2)
declare @L2100_clp09_claim_freq_code char(1)
declare @L2100_clp11_drg_code varchar(4)
declare @L2100_clp12_drg_weight varchar(15)
declare @L2100_clp13_discharge_fraction varchar(10)
declare @L2100_1_cas01_adj_group_code char(2)
declare @L2100_1_cas02_adj_reason_code varchar(5)
declare @L2100_1_cas03_adj_amt money
declare @L2100_1_cas04_adj_qty varchar(15)
declare @L2100_1_cas05_adj_reason_code varchar(5)
declare @L2100_1_cas06_adj_amt money
declare @L2100_1_cas07_adj_qty varchar(15)
declare @L2100_1_cas08_adj_reason_code varchar(5)
declare @L2100_1_cas09_adj_amt money
declare @L2100_1_cas10_adj_qty varchar(15)
declare @L2100_1_cas11_adj_reason_code varchar(5)
declare @L2100_1_cas12_adj_amt money
declare @L2100_1_cas13_adj_qty varchar(15)
declare @L2100_1_cas14_adj_reason_code varchar(5)
declare @L2100_1_cas15_adj_amt money
declare @L2100_1_cas16_adj_qty varchar(15)
declare @L2100_1_cas17_adj_reason_code varchar(5)
declare @L2100_1_cas18_adj_amt money
declare @L2100_1_cas19_adj_qty varchar(15)
declare @L2100_2_cas01_adj_group_code char(2)
declare @L2100_2_cas02_adj_reason_code varchar(5)
declare @L2100_2_cas03_adj_amt money
declare @L2100_2_cas04_adj_qty varchar(15)
declare @L2100_2_cas05_adj_reason_code varchar(5)
declare @L2100_2_cas06_adj_amt money
declare @L2100_2_cas07_adj_qty varchar(15)
declare @L2100_2_cas08_adj_reason_code varchar(5)
declare @L2100_2_cas09_adj_amt money
declare @L2100_2_cas10_adj_qty varchar(15)
declare @L2100_2_cas11_adj_reason_code varchar(5)
declare @L2100_2_cas12_adj_amt money
declare @L2100_2_cas13_adj_qty varchar(15)
declare @L2100_2_cas14_adj_reason_code varchar(5)
declare @L2100_2_cas15_adj_amt money
declare @L2100_2_cas16_adj_qty varchar(15)
declare @L2100_2_cas17_adj_reason_code varchar(5)
declare @L2100_2_cas18_adj_amt money
declare @L2100_2_cas19_adj_qty varchar(15)
declare @L2100_3_cas01_adj_group_code char(2)
declare @L2100_3_cas02_adj_reason_code varchar(5)
declare @L2100_3_cas03_adj_amt money
declare @L2100_3_cas04_adj_qty varchar(15)
declare @L2100_3_cas05_adj_reason_code varchar(5)
declare @L2100_3_cas06_adj_amt money
declare @L2100_3_cas07_adj_qty varchar(15)
declare @L2100_3_cas08_adj_reason_code varchar(5)
declare @L2100_3_cas09_adj_amt money
declare @L2100_3_cas10_adj_qty varchar(15)
declare @L2100_3_cas11_adj_reason_code varchar(5)
declare @L2100_3_cas12_adj_amt money
declare @L2100_3_cas13_adj_qty varchar(15)
declare @L2100_3_cas14_adj_reason_code varchar(5)
declare @L2100_3_cas15_adj_amt money
declare @L2100_3_cas16_adj_qty varchar(15)
declare @L2100_3_cas17_adj_reason_code varchar(5)
declare @L2100_3_cas18_adj_amt money
declare @L2100_3_cas19_adj_qty varchar(15)
declare @L2100_4_cas01_adj_group_code char(2)
declare @L2100_4_cas02_adj_reason_code varchar(5)
declare @L2100_4_cas03_adj_amt money
declare @L2100_4_cas04_adj_qty varchar(15)
declare @L2100_4_cas05_adj_reason_code varchar(5)
declare @L2100_4_cas06_adj_amt money
declare @L2100_4_cas07_adj_qty varchar(15)
declare @L2100_4_cas08_adj_reason_code varchar(5)
declare @L2100_4_cas09_adj_amt money
declare @L2100_4_cas10_adj_qty varchar(15)
declare @L2100_4_cas11_adj_reason_code varchar(5)
declare @L2100_4_cas12_adj_amt money
declare @L2100_4_cas13_adj_qty varchar(15)
declare @L2100_4_cas14_adj_reason_code varchar(5)
declare @L2100_4_cas15_adj_amt money
declare @L2100_4_cas16_adj_qty varchar(15)
declare @L2100_4_cas17_adj_reason_code varchar(5)
declare @L2100_4_cas18_adj_amt money
declare @L2100_4_cas19_adj_qty varchar(15)
declare @L2100_5_cas01_adj_group_code char(2)
declare @L2100_5_cas02_adj_reason_code varchar(5)
declare @L2100_5_cas03_adj_amt money
declare @L2100_5_cas04_adj_qty varchar(15)
declare @L2100_5_cas05_adj_reason_code varchar(5)
declare @L2100_5_cas06_adj_amt money
declare @L2100_5_cas07_adj_qty varchar(15)
declare @L2100_5_cas08_adj_reason_code varchar(5)
declare @L2100_5_cas09_adj_amt money
declare @L2100_5_cas10_adj_qty varchar(15)
declare @L2100_5_cas11_adj_reason_code varchar(5)
declare @L2100_5_cas12_adj_amt money
declare @L2100_5_cas13_adj_qty varchar(15)
declare @L2100_5_cas14_adj_reason_code varchar(5)
declare @L2100_5_cas15_adj_amt money
declare @L2100_5_cas16_adj_qty varchar(15)
declare @L2100_5_cas17_adj_reason_code varchar(5)
declare @L2100_5_cas18_adj_amt money
declare @L2100_5_cas19_adj_qty varchar(15)
declare @L2110_2_cas11_adj_reason_code varchar(5)
declare @L2110_2_cas12_adj_amt money
declare @L2110_2_cas13_adj_qty varchar(15)
declare @L2110_2_cas14_adj_reason_code varchar(5)
declare @L2110_2_cas15_adj_amt money
declare @L2110_2_cas16_adj_qty varchar(15)
declare @L2110_2_cas17_adj_reason_code varchar(5)
declare @L2110_2_cas18_adj_amt money
declare @L2110_2_cas19_adj_qty varchar(15)
declare @L2110_4_cas11_adj_reason_code varchar(5)
declare @L2110_4_cas12_adj_amt money
declare @L2110_4_cas13_adj_qty varchar(15)
declare @L2110_4_cas14_adj_reason_code varchar(5)
declare @L2110_4_cas15_adj_amt money
declare @L2110_4_cas16_adj_qty varchar(15)
declare @L2110_4_cas17_adj_reason_code varchar(5)
declare @L2110_4_cas18_adj_amt money
declare @L2110_4_cas19_adj_qty varchar(15)
declare @L2110_5_cas11_adj_reason_code varchar(5)
declare @L2110_5_cas12_adj_amt money
declare @L2110_5_cas13_adj_qty varchar(15)
declare @L2110_5_cas14_adj_reason_code varchar(5)
declare @L2110_5_cas15_adj_amt money
declare @L2110_5_cas16_adj_qty varchar(15)
declare @L2110_5_cas17_adj_reason_code varchar(5)
declare @L2110_5_cas18_adj_amt money
declare @L2110_5_cas19_adj_qty varchar(15)
declare @L2100_nm103_TT_cob_carrier_nm varchar(35)
declare @L2100_nm108_TT_cob_id_qual char(2)
declare @L2100_nm109_TT_cob_id varchar(80)
declare @L2100_nm103_PR_corrected_prty_payer_nm varchar(35)
declare @L2100_nm108_PR_corrected_prty_payer_nm_id_qual char(2)
declare @L2100_nm109_PR_corrected_prty_payer_nm_id varchar(80)
declare @L2100_nm103_QC_patient_last_nm varchar(35)
declare @L2100_nm104_QC_patient_first_nm varchar(25)
declare @L2100_nm105_QC_patient_middle_nm varchar(25)
declare @L2100_nm108_QC_patient_id_qual char(2)
declare @L2100_nm109_QC_patient_id varchar(80)
declare @L2100_nm103_IL_subscriber_last_nm varchar(35)
declare @L2100_nm104_IL_subscriber_first_nm varchar(25)
declare @L2100_nm105_IL_subscriber_middle_nm varchar(25)
declare @L2100_nm108_IL_subscriber_id_qual char(2)
declare @L2100_nm109_IL_subscriber_id varchar(80)
declare @L2100_ref02_9A_other_claim_ref_id varchar(30)
declare @L2100_ref02_BB_other_claim_ref_id varchar(30)
declare @L2100_ref02_G1_other_claim_ref_id varchar(30)
declare @L2100_ref02_EA_other_claim_ref_id varchar(30)
declare @L2100_ref02_F8_other_claim_ref_id varchar(30)
declare @L2100_ref01_rend_prov_sec_ref_id_qual char(3)
declare @L2100_ref02_rend_prov_sec_ref_id varchar(30)
declare @L2100_dtm02_036_expiration_date char(8)
declare @L2100_dtm02_050_received_date char(8)
declare @L2100_dtm02_232_stmt_start_date char(8)
declare @L2100_dtm02_233_stmt_end_date char(8)
declare @L2100_amt01_amount_qualifier_code char(3)
declare @L2100_amt02_claim_supp_info_amt money
declare @L2110_svc01_proc_code_qual char(2)
declare @L2110_svc01_proc_code varchar(48)
declare @L2110_svc01_proc_mod1 char(2)
declare @L2110_svc01_proc_mod2 char(2)
declare @L2110_svc01_proc_mod3 char(2)
declare @L2110_svc01_proc_mod4 char(2)
declare @L2110_svc02_charge_amt money
declare @L2110_svc03_provider_pmt_amt money
declare @L2110_svc04_ub_rev_code varchar(48)
declare @L2110_svc05_units_paid varchar(15)
declare @L2110_dtm02_150_service_date char(8)
declare @L2110_dtm02_151_service_date char(8)
declare @L2110_dtm02_472_service_date char(8)
declare @L2110_1_cas01_adj_group_code char(2)
declare @L2110_1_cas02_adj_reason_code varchar(5)
declare @L2110_1_cas03_adj_amt money
declare @L2110_1_cas04_adj_qty varchar(15)
declare @L2110_1_cas05_adj_reason_code varchar(5)
declare @L2110_1_cas06_adj_amt money
declare @L2110_1_cas07_adj_qty varchar(15)
declare @L2110_1_cas08_adj_reason_code varchar(5)
declare @L2110_1_cas09_adj_amt money
declare @L2110_1_cas10_adj_qty varchar(15)
declare @L2110_1_cas11_adj_reason_code varchar(5)
declare @L2110_1_cas12_adj_amt money
declare @L2110_1_cas13_adj_qty varchar(15)
declare @L2110_1_cas14_adj_reason_code varchar(5)
declare @L2110_1_cas15_adj_amt money
declare @L2110_1_cas16_adj_qty varchar(15)
declare @L2110_1_cas17_adj_reason_code varchar(5)
declare @L2110_1_cas18_adj_amt money
declare @L2110_1_cas19_adj_qty varchar(15)

declare @L2110_2_cas01_adj_group_code char(2)
declare @L2110_2_cas02_adj_reason_code varchar(5)
declare @L2110_2_cas03_adj_amt money
declare @L2110_2_cas04_adj_qty varchar(15)
declare @L2110_2_cas05_adj_reason_code varchar(5)
declare @L2110_2_cas06_adj_amt money
declare @L2110_2_cas07_adj_qty varchar(15)
declare @L2110_2_cas08_adj_reason_code varchar(5)
declare @L2110_2_cas09_adj_amt money
declare @L2110_2_cas10_adj_qty varchar(15)

declare @L2110_3_cas01_adj_group_code char(2)
declare @L2110_3_cas02_adj_reason_code varchar(5)
declare @L2110_3_cas03_adj_amt money
declare @L2110_3_cas04_adj_qty varchar(15)
declare @L2110_3_cas05_adj_reason_code varchar(5)
declare @L2110_3_cas06_adj_amt money
declare @L2110_3_cas07_adj_qty varchar(15)
declare @L2110_3_cas08_adj_reason_code varchar(5)
declare @L2110_3_cas09_adj_amt money
declare @L2110_3_cas10_adj_qty varchar(15)
declare @L2110_3_cas11_adj_reason_code varchar(5)
declare @L2110_3_cas12_adj_amt money
declare @L2110_3_cas13_adj_qty varchar(15)
declare @L2110_3_cas14_adj_reason_code varchar(5)
declare @L2110_3_cas15_adj_amt money
declare @L2110_3_cas16_adj_qty varchar(15)
declare @L2110_3_cas17_adj_reason_code varchar(5)
declare @L2110_3_cas18_adj_amt money
declare @L2110_3_cas19_adj_qty varchar(15)

declare @L2110_4_cas01_adj_group_code char(2)
declare @L2110_4_cas02_adj_reason_code varchar(5)
declare @L2110_4_cas03_adj_amt money
declare @L2110_4_cas04_adj_qty varchar(15)
declare @L2110_4_cas05_adj_reason_code varchar(5)
declare @L2110_4_cas06_adj_amt money
declare @L2110_4_cas07_adj_qty varchar(15)
declare @L2110_4_cas08_adj_reason_code varchar(5)
declare @L2110_4_cas09_adj_amt money
declare @L2110_4_cas10_adj_qty varchar(15)

declare @L2110_5_cas01_adj_group_code char(2)
declare @L2110_5_cas02_adj_reason_code varchar(5)
declare @L2110_5_cas03_adj_amt money
declare @L2110_5_cas04_adj_qty varchar(15)
declare @L2110_5_cas05_adj_reason_code varchar(5)
declare @L2110_5_cas06_adj_amt money
declare @L2110_5_cas07_adj_qty varchar(15)
declare @L2110_5_cas08_adj_reason_code varchar(5)
declare @L2110_5_cas09_adj_amt money
declare @L2110_5_cas10_adj_qty varchar(15)

declare @L2110_ref01_service_ref_id_qual char(3)
declare @L2110_ref02_service_ref_id varchar(30)
declare @L2110_ref01_rend_prov_ref_id_qual char(3)
declare @L2110_ref02_rend_prov_ref_id varchar(30)
declare @L2110_lq02_remark_code_01 varchar(30)
declare @L2110_lq02_remark_code_02 varchar(30)
declare @L2110_lq02_remark_code_03 varchar(30)
declare @L2110_lq02_remark_code_04 varchar(30)
declare @L2110_lq02_remark_code_05 varchar(30)
-- These are temporary variables
declare @loopcount int
declare @ProcString varchar(25)
declare @ColonPOS int
declare @EndStringPos INT
DECLARE @clp_count INT 
SET @clp_count = 0
 -- This variable is used to determine what type the previous N1 segment was, so the address is gathered correctly.
declare @curLoop varchar(6)
declare @prev_L2100_clp01_pt_control_no varchar(30)
declare @errmsg varchar(250)
declare @errcode int
declare @x12_parse_temp_id_start int
declare @x12_parse_temp_id_end int
declare @isa16_component_element_seperator char(1)
declare @x12_interchange_uid uniqueidentifier

DECLARE @casLevel int
set @se01_num_transaction_segments = 0
SET @casLevel = 1
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

DECLARE curt835 SCROLL CURSOR FOR
	select Col001, Col002, Col003, Col004, Col005, Col006, Col007, Col008, Col009, Col010, Col011, Col012, Col013, Col014, Col015, Col016, Col017, Col018, Col019, Col020
	from x12_parse_temp
	where	x12_parse_temp_id BETWEEN @x12_parse_temp_id_start AND @x12_parse_temp_id_end
				AND x12_parse_temp_uid = @x12_interchange_uid
	order by x12_parse_temp_id
OPEN curt835
FETCH NEXT FROM curt835 INTO @Col001, @Col002, @Col003, @Col004, @Col005, @Col006, @Col007, @Col008, @Col009, @Col010, @Col011, @Col012, @Col013, @Col014, @Col015, @Col016, @Col017, @Col018, @Col019, @Col020
WHILE (@@fetch_status <> -1)
BEGIN
	set @se01_num_transaction_segments = @se01_num_transaction_segments + 1
	if ( RTrim(@Col001) = 'BPR')
	begin
		SELECT @bpr01_trans_handling_code = LTRIM(RTRIM(@Col002))
		,@bpr02_total_prov_pmt_amt = CAST(LTRIM(RTRIM(@Col003)) as money)
		,@bpr03_credit_debit_flag_code = LTRIM(RTRIM(@Col004))
		,@bpr04_payment_method_code = LTRIM(RTRIM(@Col005))
		,@bpr05_payment_format_code = LTRIM(RTRIM(@Col006))
		,@bpr06_sender_dfi_id_qual = LTRIM(RTRIM(@Col007))
		,@bpr07_sender_dfi_id = LTRIM(RTRIM(@Col008))
		,@bpr08_sender_account_num_qual = LTRIM(RTRIM(@Col009))
		,@bpr09_sender_account_num = LTRIM(RTRIM(@Col010))
		,@bpr10_payer_id = LTRIM(RTRIM(@Col011))
		,@bpr11_orig_co_supp_code = LTRIM(RTRIM(@Col012))
		,@bpr12_receiver_dfi_id_qual = LTRIM(RTRIM(@Col013))
		,@bpr13_receiver_dfi_id = LTRIM(RTRIM(@Col014))
		,@bpr14_receiver_account_num_qual = LTRIM(RTRIM(@Col015))
		,@bpr15_receiver_account_num = LTRIM(RTRIM(@Col016))
		,@bpr16_check_date = LTRIM(RTRIM(@Col017))
	end
	if ( RTrim(@Col001) = 'TRN')
	begin
		SELECT @trn01_trace_type_code = LTRIM(RTRIM(@Col002))
		,@trn02_trace_number = LTRIM(RTRIM(@Col003))
		,@trn03_payer_id = LTRIM(RTRIM(@Col004))
	end
	if ( RTrim(@Col001) = 'REF' AND LTRIM(RTRIM(@Col002)) = 'EV')
	begin
		set @ref01_receiver_ref_id_qual = LTRIM(RTRIM(@Col002))
		set @ref02_receiver_ref_id = LTRIM(RTRIM(@Col003))
	end
	if ( RTrim(@Col001) = 'DTM' AND LTRIM(RTRIM(@Col002)) = '405')
	begin
		set @dtm02_production_date = LTRIM(RTRIM(@Col003))
	end
	if ( RTrim(@Col001) = 'REF' AND @Col002 = 'PQ')
	begin
		SELECT 
		 @curLoop = '1000B'
		,@L1000B_ref01_ref_id_qual = @Col002
		,@L1000B_ref02_add_payee_id = @Col003
	end
	if ( RTrim(@Col001) = 'REF' AND @Col002 = '2U')
	begin
		SELECT
		 @curLoop = '1000A'
		,@L1000A_ref01_ref_id_qual = @Col002
		,@L1000A_ref02_add_payer_id = @Col003
	end
	if ( RTrim(@col001) = 'LX' )
	begin
		set @curLoop = '2000'
		set @L2000_LX01_assigned_number = LTRIM(RTRIM(@Col002))
	end
	-- Get service line information (this segment is essentially the "header" of the detail section)
	if ( RTrim(@col001) = 'SVC' )
	begin
		set @curLoop = '2110'
		-- insert a record when we start a new service line (meaning we're done with the previous service line)
		-- Only insert a record when we've already picked the procedure code out of the SVC segment (skips this the first time through only)
		if (@L2110_svc01_proc_code IS NOT NULL)
		begin
			exec up_x12_835_insert
				@x12_transaction_id = @x12_transaction_id,
				@bpr01_trans_handling_code = @bpr01_trans_handling_code,
				@bpr02_total_prov_pmt_amt = @bpr02_total_prov_pmt_amt,
				@bpr03_credit_debit_flag_code = @bpr03_credit_debit_flag_code,
				@bpr04_payment_method_code = @bpr04_payment_method_code,
				@bpr05_payment_format_code = @bpr05_payment_format_code,
				@bpr06_sender_dfi_id_qual = @bpr06_sender_dfi_id_qual,
				@bpr07_sender_dfi_id = @bpr07_sender_dfi_id,
				@bpr08_sender_account_num_qual = @bpr08_sender_account_num_qual,
				@bpr09_sender_account_num = @bpr09_sender_account_num,
				@bpr10_payer_id = @bpr10_payer_id,
				@bpr11_orig_co_supp_code = @bpr11_orig_co_supp_code,
				@bpr12_receiver_dfi_id_qual = @bpr12_receiver_dfi_id_qual,
				@bpr13_receiver_dfi_id = @bpr13_receiver_dfi_id,
				@bpr14_receiver_account_num_qual = @bpr14_receiver_account_num_qual,
				@bpr15_receiver_account_num = @bpr15_receiver_account_num,
				@bpr16_check_date = @bpr16_check_date,
				@trn01_trace_type_code = @trn01_trace_type_code,
				@trn02_trace_number = @trn02_trace_number,
				@trn03_payer_id = @trn03_payer_id,
				@ref01_receiver_ref_id_qual = @ref01_receiver_ref_id_qual,
				@ref02_receiver_ref_id = @ref02_receiver_ref_id,
				@dtm02_production_date = @dtm02_production_date,
				@L1000A_n101_entity_id_code = @L1000A_n101_entity_id_code,
				@L1000A_n102_payer_nm = @L1000A_n102_payer_nm,
				@L1000A_n103_payer_id_qual = @L1000A_n103_payer_id_qual,
				@L1000A_n104_payer_id = @L1000A_n104_payer_id,
				@L1000A_n301_payer_address1 = @L1000A_n301_payer_address1,
				@L1000A_n302_payer_address2 = @L1000A_n302_payer_address2,
				@L1000A_n401_payer_city = @L1000A_n401_payer_city,
				@L1000A_n402_payer_state = @L1000A_n402_payer_state,
				@L1000A_n403_payer_zip = @L1000A_n403_payer_zip,
				@L1000A_ref01_ref_id_qual = @L1000A_ref01_ref_id_qual,
				@L1000A_ref02_add_payer_id = @L1000A_ref02_add_payer_id,
				@L1000A_per01_contact_function_code = @L1000A_per01_contact_function_code,
				@L1000A_per02_contact_nm = @L1000A_per02_contact_nm,
				@L1000A_per03_comm_num_qual = @L1000A_per03_comm_num_qual,
				@L1000A_per04_comm_number = @L1000A_per04_comm_number,
				@L1000B_n101_entity_id_code = @L1000B_n101_entity_id_code,
				@L1000B_n102_payee_nm = @L1000B_n102_payee_nm,
				@L1000B_n103_payee_id_qual = @L1000B_n103_payee_id_qual,
				@L1000B_n104_payee_id = @L1000B_n104_payee_id,
				@L1000B_n301_payee_address1 = @L1000B_n301_payee_address1,
				@L1000B_n302_payee_address2 = @L1000B_n302_payee_address2,
				@L1000B_n401_payee_city = @L1000B_n401_payee_city,
				@L1000B_n402_payee_state = @L1000B_n402_payee_state,
				@L1000B_n403_payee_zip = @L1000B_n403_payee_zip,
				@L1000B_ref01_ref_id_qual = @L1000B_ref01_ref_id_qual,
				@L1000B_ref02_add_payee_id = @L1000B_ref02_add_payee_id,
				@L2000_lx01_assigned_number = @L2000_lx01_assigned_number,
				@L2100_clp01_pt_control_no = @L2100_clp01_pt_control_no,
				@L2100_clp02_claim_status_code = @L2100_clp02_claim_status_code,
				@L2100_clp03_total_claim_chg_amt = @L2100_clp03_total_claim_chg_amt,
				@L2100_clp04_claim_pmt_amt = @L2100_clp04_claim_pmt_amt,
				@L2100_clp05_pt_resp_amt = @L2100_clp05_pt_resp_amt,
				@L2100_clp06_claim_filing_ind_code = @L2100_clp06_claim_filing_ind_code,
				@L2100_clp07_payer_claim_control_no = @L2100_clp07_payer_claim_control_no,
				@L2100_clp08_facility_type_code = @L2100_clp08_facility_type_code,
				@L2100_clp09_claim_freq_code = @L2100_clp09_claim_freq_code,
				@L2100_clp11_drg_code = @L2100_clp11_drg_code,
				@L2100_clp12_drg_weight = @L2100_clp12_drg_weight,
				@L2100_clp13_discharge_fraction = @L2100_clp13_discharge_fraction,
				@L2100_nm103_TT_cob_carrier_nm = @L2100_nm103_TT_cob_carrier_nm,
				@L2100_nm108_TT_cob_id_qual = @L2100_nm108_TT_cob_id_qual,
				@L2100_nm109_TT_cob_id = @L2100_nm109_TT_cob_id,
				@L2100_nm103_PR_corrected_prty_payer_nm = @L2100_nm103_PR_corrected_prty_payer_nm,
				@L2100_nm108_PR_corrected_prty_payer_nm_id_qual = @L2100_nm108_PR_corrected_prty_payer_nm_id_qual,
				@L2100_nm109_PR_corrected_prty_payer_nm_id = @L2100_nm109_PR_corrected_prty_payer_nm_id,
				@L2100_nm103_QC_patient_last_nm = @L2100_nm103_QC_patient_last_nm,
				@L2100_nm104_QC_patient_first_nm = @L2100_nm104_QC_patient_first_nm,
				@L2100_nm105_QC_patient_middle_nm = @L2100_nm105_QC_patient_middle_nm,
				@L2100_nm108_QC_patient_id_qual = @L2100_nm108_QC_patient_id_qual,
				@L2100_nm109_QC_patient_id = @L2100_nm109_QC_patient_id,
				@L2100_nm103_IL_subscriber_last_nm = @L2100_nm103_IL_subscriber_last_nm,
				@L2100_nm104_IL_subscriber_first_nm = @L2100_nm104_IL_subscriber_first_nm,
				@L2100_nm105_IL_subscriber_middle_nm = @L2100_nm105_IL_subscriber_middle_nm,
				@L2100_nm108_IL_subscriber_id_qual = @L2100_nm108_IL_subscriber_id_qual,
				@L2100_nm109_IL_subscriber_id = @L2100_nm109_IL_subscriber_id,
				@L2100_ref02_9A_other_claim_ref_id = @L2100_ref02_9A_other_claim_ref_id,
				@L2100_ref02_BB_other_claim_ref_id = @L2100_ref02_BB_other_claim_ref_id,
				@L2100_ref02_G1_other_claim_ref_id = @L2100_ref02_G1_other_claim_ref_id,
				@L2100_ref02_EA_other_claim_ref_id = @L2100_ref02_EA_other_claim_ref_id,
				@L2100_ref02_F8_other_claim_ref_id = @L2100_ref02_F8_other_claim_ref_id,
				@L2100_ref01_rend_prov_sec_ref_id_qual = @L2100_ref01_rend_prov_sec_ref_id_qual,
				@L2100_ref02_rend_prov_sec_ref_id = @L2100_ref02_rend_prov_sec_ref_id,
				@L2100_dtm02_036_expiration_date = @L2100_dtm02_036_expiration_date,
				@L2100_dtm02_050_received_date = @L2100_dtm02_050_received_date,
				@L2100_dtm02_232_stmt_start_date = @L2100_dtm02_232_stmt_start_date,
				@L2100_dtm02_233_stmt_end_date = @L2100_dtm02_233_stmt_end_date,
				@L2110_svc01_proc_code = @L2110_svc01_proc_code,
				@L2110_svc01_proc_mod1 = @L2110_svc01_proc_mod1,
				@L2110_svc01_proc_mod2 = @L2110_svc01_proc_mod2,
				@L2110_svc01_proc_mod3 = @L2110_svc01_proc_mod3,
				@L2110_svc01_proc_mod4 = @L2110_svc01_proc_mod4,
				@L2110_svc02_charge_amt = @L2110_svc02_charge_amt,
				@L2110_svc03_provider_pmt_amt = @L2110_svc03_provider_pmt_amt,
				@L2110_svc04_ub_rev_code = @L2110_svc04_ub_rev_code,
				@L2110_svc05_units_paid = @L2110_svc05_units_paid,
				@L2110_dtm02_150_service_date = @L2110_dtm02_150_service_date,
				@L2110_dtm02_151_service_date = @L2110_dtm02_151_service_date,
				@L2110_dtm02_472_service_date = @L2110_dtm02_472_service_date,
				
				@L2110_1_cas01_adj_group_code = @L2110_1_cas01_adj_group_code,
				@L2110_1_cas02_adj_reason_code = @L2110_1_cas02_adj_reason_code,
				@L2110_1_cas03_adj_amt = @L2110_1_cas03_adj_amt,
				@L2110_1_cas04_adj_qty = @L2110_1_cas04_adj_qty,
				@L2110_1_cas05_adj_reason_code = @L2110_1_cas05_adj_reason_code,
				@L2110_1_cas06_adj_amt = @L2110_1_cas06_adj_amt,
				@L2110_1_cas07_adj_qty = @L2110_1_cas07_adj_qty,
				@L2110_1_cas08_adj_reason_code = @L2110_1_cas08_adj_reason_code,
				@L2110_1_cas09_adj_amt = @L2110_1_cas09_adj_amt,
				@L2110_1_cas10_adj_qty = @L2110_1_cas10_adj_qty,
				@L2110_1_cas11_adj_reason_code = @L2110_1_cas11_adj_reason_code,
				@L2110_1_cas12_adj_amt = @L2110_1_cas12_adj_amt,
				@L2110_1_cas13_adj_qty = @L2110_1_cas13_adj_qty,
				@L2110_1_cas14_adj_reason_code = @L2110_1_cas14_adj_reason_code,
				@L2110_1_cas15_adj_amt = @L2110_1_cas15_adj_amt,
				@L2110_1_cas16_adj_qty = @L2110_1_cas16_adj_qty,
				@L2110_1_cas17_adj_reason_code = @L2110_1_cas17_adj_reason_code,
				@L2110_1_cas18_adj_amt = @L2110_1_cas18_adj_amt,
				@L2110_1_cas19_adj_qty = @L2110_1_cas19_adj_qty,
				
				@L2110_2_cas01_adj_group_code = @L2110_2_cas01_adj_group_code,
				@L2110_2_cas02_adj_reason_code = @L2110_2_cas02_adj_reason_code,
				@L2110_2_cas03_adj_amt = @L2110_2_cas03_adj_amt,
				@L2110_2_cas04_adj_qty = @L2110_2_cas04_adj_qty,
				@L2110_2_cas05_adj_reason_code = @L2110_2_cas05_adj_reason_code,
				@L2110_2_cas06_adj_amt = @L2110_2_cas06_adj_amt,
				@L2110_2_cas07_adj_qty = @L2110_2_cas07_adj_qty,
				@L2110_2_cas08_adj_reason_code = @L2110_2_cas08_adj_reason_code,
				@L2110_2_cas09_adj_amt = @L2110_2_cas09_adj_amt,
				@L2110_2_cas10_adj_qty = @L2110_2_cas10_adj_qty,
				@L2110_3_cas01_adj_group_code = @L2110_3_cas01_adj_group_code,
				@L2110_3_cas02_adj_reason_code = @L2110_3_cas02_adj_reason_code,
				@L2110_3_cas03_adj_amt = @L2110_3_cas03_adj_amt,
				@L2110_3_cas04_adj_qty = @L2110_3_cas04_adj_qty,
				@L2110_3_cas05_adj_reason_code = @L2110_3_cas05_adj_reason_code,
				@L2110_3_cas06_adj_amt = @L2110_3_cas06_adj_amt,
				@L2110_3_cas07_adj_qty = @L2110_3_cas07_adj_qty,
				@L2110_3_cas08_adj_reason_code = @L2110_3_cas08_adj_reason_code,
				@L2110_3_cas09_adj_amt = @L2110_3_cas09_adj_amt,
				@L2110_3_cas10_adj_qty = @L2110_3_cas10_adj_qty,
				@L2110_3_cas11_adj_reason_code = @L2110_3_cas11_adj_reason_code,
				@L2110_3_cas12_adj_amt = @L2110_3_cas12_adj_amt,
				@L2110_3_cas13_adj_qty = @L2110_3_cas13_adj_qty,
				@L2110_3_cas14_adj_reason_code = @L2110_3_cas14_adj_reason_code,
				@L2110_3_cas15_adj_amt = @L2110_3_cas15_adj_amt,
				@L2110_3_cas16_adj_qty = @L2110_3_cas16_adj_qty,
				@L2110_3_cas17_adj_reason_code = @L2110_3_cas17_adj_reason_code,
				@L2110_3_cas18_adj_amt = @L2110_3_cas18_adj_amt,
				@L2110_3_cas19_adj_qty = @L2110_3_cas19_adj_qty,
				@L2110_4_cas01_adj_group_code = @L2110_4_cas01_adj_group_code,
				@L2110_4_cas02_adj_reason_code = @L2110_4_cas02_adj_reason_code,
				@L2110_4_cas03_adj_amt = @L2110_4_cas03_adj_amt,
				@L2110_4_cas04_adj_qty = @L2110_4_cas04_adj_qty,
				@L2110_4_cas05_adj_reason_code = @L2110_4_cas05_adj_reason_code,
				@L2110_4_cas06_adj_amt = @L2110_4_cas06_adj_amt,
				@L2110_4_cas07_adj_qty = @L2110_4_cas07_adj_qty,
				@L2110_4_cas08_adj_reason_code = @L2110_4_cas08_adj_reason_code,
				@L2110_4_cas09_adj_amt = @L2110_4_cas09_adj_amt,
				@L2110_4_cas10_adj_qty = @L2110_4_cas10_adj_qty,
				@L2110_5_cas01_adj_group_code = @L2110_5_cas01_adj_group_code,
				@L2110_5_cas02_adj_reason_code = @L2110_5_cas02_adj_reason_code,
				@L2110_5_cas03_adj_amt = @L2110_5_cas03_adj_amt,
				@L2110_5_cas04_adj_qty = @L2110_5_cas04_adj_qty,
				@L2110_5_cas05_adj_reason_code = @L2110_5_cas05_adj_reason_code,
				@L2110_5_cas06_adj_amt = @L2110_5_cas06_adj_amt,
				@L2110_5_cas07_adj_qty = @L2110_5_cas07_adj_qty,
				@L2110_5_cas08_adj_reason_code = @L2110_5_cas08_adj_reason_code,
				@L2110_5_cas09_adj_amt = @L2110_5_cas09_adj_amt,
				@L2110_5_cas10_adj_qty = @L2110_5_cas10_adj_qty,

				@L2110_lq02_remark_code_01 = @L2110_lq02_remark_code_01,
				@L2110_lq02_remark_code_02 = @L2110_lq02_remark_code_02,
				@L2110_lq02_remark_code_03 = @L2110_lq02_remark_code_03,
				@L2110_lq02_remark_code_04 = @L2110_lq02_remark_code_04,
				@L2110_lq02_remark_code_05 = @L2110_lq02_remark_code_05,
				
				@L2100_1_cas01_adj_group_code =@L2100_1_cas01_adj_group_code ,
				@L2100_1_cas02_adj_reason_code =@L2100_1_cas02_adj_reason_code ,
				@L2100_1_cas03_adj_amt =@L2100_1_cas03_adj_amt ,
				@L2100_1_cas04_adj_qty =@L2100_1_cas04_adj_qty ,
				@L2100_1_cas05_adj_reason_code =@L2100_1_cas05_adj_reason_code ,
				@L2100_1_cas06_adj_amt =@L2100_1_cas06_adj_amt ,
				@L2100_1_cas07_adj_qty =@L2100_1_cas07_adj_qty ,
				@L2100_1_cas08_adj_reason_code =@L2100_1_cas08_adj_reason_code ,
				@L2100_1_cas09_adj_amt =@L2100_1_cas09_adj_amt ,
				@L2100_1_cas10_adj_qty =@L2100_1_cas10_adj_qty ,
				@L2100_1_cas11_adj_reason_code =@L2100_1_cas11_adj_reason_code ,
				@L2100_1_cas12_adj_amt =@L2100_1_cas12_adj_amt ,
				@L2100_1_cas13_adj_qty =@L2100_1_cas13_adj_qty ,
				@L2100_1_cas14_adj_reason_code =@L2100_1_cas14_adj_reason_code ,
				@L2100_1_cas15_adj_amt =@L2100_1_cas15_adj_amt ,
				@L2100_1_cas16_adj_qty =@L2100_1_cas16_adj_qty ,
				@L2100_1_cas17_adj_reason_code =@L2100_1_cas17_adj_reason_code ,
				@L2100_1_cas18_adj_amt =@L2100_1_cas18_adj_amt ,
				@L2100_1_cas19_adj_qty =@L2100_1_cas19_adj_qty ,
				@L2100_2_cas01_adj_group_code =@L2100_2_cas01_adj_group_code ,
				@L2100_2_cas02_adj_reason_code =@L2100_2_cas02_adj_reason_code ,
				@L2100_2_cas03_adj_amt =@L2100_2_cas03_adj_amt ,
				@L2100_2_cas04_adj_qty =@L2100_2_cas04_adj_qty ,
				@L2100_2_cas05_adj_reason_code =@L2100_2_cas05_adj_reason_code ,
				@L2100_2_cas06_adj_amt =@L2100_2_cas06_adj_amt ,
				@L2100_2_cas07_adj_qty =@L2100_2_cas07_adj_qty ,
				@L2100_2_cas08_adj_reason_code =@L2100_2_cas08_adj_reason_code ,
				@L2100_2_cas09_adj_amt =@L2100_2_cas09_adj_amt ,
				@L2100_2_cas10_adj_qty =@L2100_2_cas10_adj_qty ,
				@L2100_2_cas11_adj_reason_code =@L2100_2_cas11_adj_reason_code ,
				@L2100_2_cas12_adj_amt =@L2100_2_cas12_adj_amt ,
				@L2100_2_cas13_adj_qty =@L2100_2_cas13_adj_qty ,
				@L2100_2_cas14_adj_reason_code =@L2100_2_cas14_adj_reason_code ,
				@L2100_2_cas15_adj_amt =@L2100_2_cas15_adj_amt ,
				@L2100_2_cas16_adj_qty =@L2100_2_cas16_adj_qty ,
				@L2100_2_cas17_adj_reason_code =@L2100_2_cas17_adj_reason_code ,
				@L2100_2_cas18_adj_amt =@L2100_2_cas18_adj_amt ,
				@L2100_2_cas19_adj_qty =@L2100_2_cas19_adj_qty ,
				@L2100_3_cas01_adj_group_code =@L2100_3_cas01_adj_group_code ,
				@L2100_3_cas02_adj_reason_code =@L2100_3_cas02_adj_reason_code ,
				@L2100_3_cas03_adj_amt =@L2100_3_cas03_adj_amt ,
				@L2100_3_cas04_adj_qty =@L2100_3_cas04_adj_qty ,
				@L2100_3_cas05_adj_reason_code =@L2100_3_cas05_adj_reason_code ,
				@L2100_3_cas06_adj_amt =@L2100_3_cas06_adj_amt ,
				@L2100_3_cas07_adj_qty =@L2100_3_cas07_adj_qty ,
				@L2100_3_cas08_adj_reason_code =@L2100_3_cas08_adj_reason_code ,
				@L2100_3_cas09_adj_amt =@L2100_3_cas09_adj_amt ,
				@L2100_3_cas10_adj_qty =@L2100_3_cas10_adj_qty ,
				@L2100_3_cas11_adj_reason_code =@L2100_3_cas11_adj_reason_code ,
				@L2100_3_cas12_adj_amt =@L2100_3_cas12_adj_amt ,
				@L2100_3_cas13_adj_qty =@L2100_3_cas13_adj_qty ,
				@L2100_3_cas14_adj_reason_code =@L2100_3_cas14_adj_reason_code ,
				@L2100_3_cas15_adj_amt =@L2100_3_cas15_adj_amt ,
				@L2100_3_cas16_adj_qty =@L2100_3_cas16_adj_qty ,
				@L2100_3_cas17_adj_reason_code =@L2100_3_cas17_adj_reason_code ,
				@L2100_3_cas18_adj_amt =@L2100_3_cas18_adj_amt ,
				@L2100_3_cas19_adj_qty =@L2100_3_cas19_adj_qty ,
				@L2100_4_cas01_adj_group_code =@L2100_4_cas01_adj_group_code ,
				@L2100_4_cas02_adj_reason_code =@L2100_4_cas02_adj_reason_code ,
				@L2100_4_cas03_adj_amt =@L2100_4_cas03_adj_amt ,
				@L2100_4_cas04_adj_qty =@L2100_4_cas04_adj_qty ,
				@L2100_4_cas05_adj_reason_code =@L2100_4_cas05_adj_reason_code ,
				@L2100_4_cas06_adj_amt =@L2100_4_cas06_adj_amt ,
				@L2100_4_cas07_adj_qty =@L2100_4_cas07_adj_qty ,
				@L2100_4_cas08_adj_reason_code =@L2100_4_cas08_adj_reason_code ,
				@L2100_4_cas09_adj_amt =@L2100_4_cas09_adj_amt ,
				@L2100_4_cas10_adj_qty =@L2100_4_cas10_adj_qty ,
				@L2100_4_cas11_adj_reason_code =@L2100_4_cas11_adj_reason_code ,
				@L2100_4_cas12_adj_amt =@L2100_4_cas12_adj_amt ,
				@L2100_4_cas13_adj_qty =@L2100_4_cas13_adj_qty ,
				@L2100_4_cas14_adj_reason_code =@L2100_4_cas14_adj_reason_code ,
				@L2100_4_cas15_adj_amt =@L2100_4_cas15_adj_amt ,
				@L2100_4_cas16_adj_qty =@L2100_4_cas16_adj_qty ,
				@L2100_4_cas17_adj_reason_code =@L2100_4_cas17_adj_reason_code ,
				@L2100_4_cas18_adj_amt =@L2100_4_cas18_adj_amt ,
				@L2100_4_cas19_adj_qty =@L2100_4_cas19_adj_qty ,
				@L2100_5_cas01_adj_group_code =@L2100_5_cas01_adj_group_code ,
				@L2100_5_cas02_adj_reason_code =@L2100_5_cas02_adj_reason_code ,
				@L2100_5_cas03_adj_amt =@L2100_5_cas03_adj_amt ,
				@L2100_5_cas04_adj_qty =@L2100_5_cas04_adj_qty ,
				@L2100_5_cas05_adj_reason_code =@L2100_5_cas05_adj_reason_code ,
				@L2100_5_cas06_adj_amt =@L2100_5_cas06_adj_amt ,
				@L2100_5_cas07_adj_qty =@L2100_5_cas07_adj_qty ,
				@L2100_5_cas08_adj_reason_code =@L2100_5_cas08_adj_reason_code ,
				@L2100_5_cas09_adj_amt =@L2100_5_cas09_adj_amt ,
				@L2100_5_cas10_adj_qty =@L2100_5_cas10_adj_qty ,
				@L2100_5_cas11_adj_reason_code =@L2100_5_cas11_adj_reason_code ,
				@L2100_5_cas12_adj_amt =@L2100_5_cas12_adj_amt ,
				@L2100_5_cas13_adj_qty =@L2100_5_cas13_adj_qty ,
				@L2100_5_cas14_adj_reason_code =@L2100_5_cas14_adj_reason_code ,
				@L2100_5_cas15_adj_amt =@L2100_5_cas15_adj_amt ,
				@L2100_5_cas16_adj_qty =@L2100_5_cas16_adj_qty ,
				@L2100_5_cas17_adj_reason_code =@L2100_5_cas17_adj_reason_code ,
				@L2100_5_cas18_adj_amt =@L2100_5_cas18_adj_amt ,
				@L2100_5_cas19_adj_qty =@L2100_5_cas19_adj_qty ,
				@L2110_2_cas11_adj_reason_code =@L2110_2_cas11_adj_reason_code ,
				@L2110_2_cas12_adj_amt =@L2110_2_cas12_adj_amt ,
				@L2110_2_cas13_adj_qty =@L2110_2_cas13_adj_qty ,
				@L2110_2_cas14_adj_reason_code =@L2110_2_cas14_adj_reason_code ,
				@L2110_2_cas15_adj_amt =@L2110_2_cas15_adj_amt ,
				@L2110_2_cas16_adj_qty =@L2110_2_cas16_adj_qty ,
				@L2110_2_cas17_adj_reason_code =@L2110_2_cas17_adj_reason_code ,
				@L2110_2_cas18_adj_amt =@L2110_2_cas18_adj_amt ,
				@L2110_2_cas19_adj_qty =@L2110_2_cas19_adj_qty ,
				@L2110_4_cas11_adj_reason_code =@L2110_4_cas11_adj_reason_code ,
				@L2110_4_cas12_adj_amt =@L2110_4_cas12_adj_amt ,
				@L2110_4_cas13_adj_qty =@L2110_4_cas13_adj_qty ,
				@L2110_4_cas14_adj_reason_code =@L2110_4_cas14_adj_reason_code ,
				@L2110_4_cas15_adj_amt =@L2110_4_cas15_adj_amt ,
				@L2110_4_cas16_adj_qty =@L2110_4_cas16_adj_qty ,
				@L2110_4_cas17_adj_reason_code =@L2110_4_cas17_adj_reason_code ,
				@L2110_4_cas18_adj_amt =@L2110_4_cas18_adj_amt ,
				@L2110_4_cas19_adj_qty =@L2110_4_cas19_adj_qty ,
				@L2110_5_cas11_adj_reason_code =@L2110_5_cas11_adj_reason_code ,
				@L2110_5_cas12_adj_amt =@L2110_5_cas12_adj_amt ,
				@L2110_5_cas13_adj_qty =@L2110_5_cas13_adj_qty ,
				@L2110_5_cas14_adj_reason_code =@L2110_5_cas14_adj_reason_code ,
				@L2110_5_cas15_adj_amt =@L2110_5_cas15_adj_amt ,
				@L2110_5_cas16_adj_qty =@L2110_5_cas16_adj_qty ,
				@L2110_5_cas17_adj_reason_code =@L2110_5_cas17_adj_reason_code ,
				@L2110_5_cas18_adj_amt =@L2110_5_cas18_adj_amt ,
				@L2110_5_cas19_adj_qty =@L2110_5_cas19_adj_qty 

				
		END
		SELECT 
		 @casLevel = 1,
		 
				@L2110_2_cas11_adj_reason_code  = NULL,
				@L2110_2_cas12_adj_amt  = NULL,
				@L2110_2_cas13_adj_qty  = NULL,
				@L2110_2_cas14_adj_reason_code  = NULL,
				@L2110_2_cas15_adj_amt  = NULL,
				@L2110_2_cas16_adj_qty  = NULL,
				@L2110_2_cas17_adj_reason_code  = NULL,
				@L2110_2_cas18_adj_amt  = NULL,
				@L2110_2_cas19_adj_qty  = NULL,
				@L2110_4_cas11_adj_reason_code  = NULL,
				@L2110_4_cas12_adj_amt  = NULL,
				@L2110_4_cas13_adj_qty  = NULL,
				@L2110_4_cas14_adj_reason_code  = NULL,
				@L2110_4_cas15_adj_amt  = NULL,
				@L2110_4_cas16_adj_qty  = NULL,
				@L2110_4_cas17_adj_reason_code  = NULL,
				@L2110_4_cas18_adj_amt  = NULL,
				@L2110_4_cas19_adj_qty  = NULL,
				@L2110_5_cas11_adj_reason_code  = NULL,
				@L2110_5_cas12_adj_amt  = NULL,
				@L2110_5_cas13_adj_qty  = NULL,
				@L2110_5_cas14_adj_reason_code  = NULL,
				@L2110_5_cas15_adj_amt  = NULL,
				@L2110_5_cas16_adj_qty  = NULL,
				@L2110_5_cas17_adj_reason_code  = NULL,
				@L2110_5_cas18_adj_amt  = NULL,
				@L2110_5_cas19_adj_qty  = NULL

		,@L2110_1_cas01_adj_group_code = null
		,@L2110_1_cas02_adj_reason_code = null
		,@L2110_1_cas03_adj_amt = null
		,@L2110_1_cas04_adj_qty = null
		,@L2110_1_cas05_adj_reason_code = null
		,@L2110_1_cas06_adj_amt = null
		,@L2110_1_cas07_adj_qty = null
		,@L2110_1_cas08_adj_reason_code = null
		,@L2110_1_cas09_adj_amt = null
		,@L2110_1_cas10_adj_qty = null
		,@L2110_1_cas11_adj_reason_code = null
		,@L2110_1_cas12_adj_amt = null
		,@L2110_1_cas13_adj_qty = null
		,@L2110_1_cas14_adj_reason_code = null
		,@L2110_1_cas15_adj_amt = null
		,@L2110_1_cas16_adj_qty = null
		,@L2110_1_cas17_adj_reason_code = null
		,@L2110_1_cas18_adj_amt = null
		,@L2110_1_cas19_adj_qty = null

		,@L2110_2_cas01_adj_group_code = null
		,@L2110_2_cas02_adj_reason_code = null
		,@L2110_2_cas03_adj_amt = null
		,@L2110_2_cas04_adj_qty = null
		,@L2110_2_cas05_adj_reason_code = null
		,@L2110_2_cas06_adj_amt = null
		,@L2110_2_cas07_adj_qty = null
		,@L2110_2_cas08_adj_reason_code = null
		,@L2110_2_cas09_adj_amt = null
		,@L2110_2_cas10_adj_qty = null

		,@L2110_3_cas01_adj_group_code = null
		,@L2110_3_cas02_adj_reason_code = null
		,@L2110_3_cas03_adj_amt = null
		,@L2110_3_cas04_adj_qty = null
		,@L2110_3_cas05_adj_reason_code = null
		,@L2110_3_cas06_adj_amt = null
		,@L2110_3_cas07_adj_qty = null
		,@L2110_3_cas08_adj_reason_code = null
		,@L2110_3_cas09_adj_amt = null
		,@L2110_3_cas10_adj_qty = null
		,@L2110_3_cas11_adj_reason_code = null
		,@L2110_3_cas12_adj_amt = null
		,@L2110_3_cas13_adj_qty = null
		,@L2110_3_cas14_adj_reason_code = null
		,@L2110_3_cas15_adj_amt = null
		,@L2110_3_cas16_adj_qty = null
		,@L2110_3_cas17_adj_reason_code = null
		,@L2110_3_cas18_adj_amt = null
		,@L2110_3_cas19_adj_qty = null

		,@L2110_4_cas01_adj_group_code = null
		,@L2110_4_cas02_adj_reason_code = null
		,@L2110_4_cas03_adj_amt = null
		,@L2110_4_cas04_adj_qty = null
		,@L2110_4_cas05_adj_reason_code = null
		,@L2110_4_cas06_adj_amt = null
		,@L2110_4_cas07_adj_qty = null
		,@L2110_4_cas08_adj_reason_code = null
		,@L2110_4_cas09_adj_amt = null
		,@L2110_4_cas10_adj_qty = null

		,@L2110_5_cas01_adj_group_code = null
		,@L2110_5_cas02_adj_reason_code = null
		,@L2110_5_cas03_adj_amt = null
		,@L2110_5_cas04_adj_qty = null
		,@L2110_5_cas05_adj_reason_code = null
		,@L2110_5_cas06_adj_amt = null
		,@L2110_5_cas07_adj_qty = null
		,@L2110_5_cas08_adj_reason_code = null
		,@L2110_5_cas09_adj_amt = null
		,@L2110_5_cas10_adj_qty = null

		-- re,the procedure code values
		,@L2110_svc01_proc_code_qual = null
		,@L2110_svc01_proc_code = null
		,@L2110_svc01_proc_mod1 = null
		,@L2110_svc01_proc_mod2 = null
		,@L2110_svc01_proc_mod3 = null
		,@L2110_svc01_proc_mod4 = null
		-- col002 will be a string like "HC:T1016:HN" where HC signifies the code type, T1016 is the code, and HN is the modifier
		,@ProcString = LTRIM(RTRIM(@col002))
		,@loopcount = 0
		-- loop over the procedure string and scoop out the values between colons
		while (Len(@ProcString) > 0)
		begin
			set @ColonPos = CHARINDEX(@isa16_component_element_seperator, @ProcString)	-- find the first colon position
			if (@ColonPos > 0)
				set @EndStringPos = @ColonPos-1		-- set the end position for the first value
			else if (@ColonPos = 0)
				set @EndStringPos = Len(@ProcString)	-- if no colon in the string, the value is the string
			set @loopcount = @loopcount + 1
			if (@loopcount = 1) set @L2110_svc01_proc_code_qual = Left(@ProcString, @EndStringPos)
			if (@loopcount = 2) set @L2110_svc01_proc_code = Left(@ProcString, @EndStringPos)
			if (@loopcount = 3) set @L2110_svc01_proc_mod1 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 4) set @L2110_svc01_proc_mod2 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 5) set @L2110_svc01_proc_mod3 = Left(@ProcString, @EndStringPos)
			if (@loopcount = 6) set @L2110_svc01_proc_mod4 = Left(@ProcString, @EndStringPos)
			if (@ColonPos > 0)
				set @ProcString = Right(@ProcString, Len(@ProcString)-@ColonPos)
			else
				set @ProcString = null
		end
		-- UB92 codes (revenue codes) will look like this, "NU:0217"
		SELECT 
			 @L2110_svc01_proc_code = CASE WHEN @L2110_svc01_proc_code_qual = 'NU'  -- NU means UB92 Code
			 THEN Right(RTrim(@L2110_svc01_proc_code), 3) ELSE @L2110_svc01_proc_code end -- the first digit is a 0, leave that off.
			,@L2110_svc02_charge_amt = CAST(LTrim(RTrim(@Col003)) as money)
			,@L2110_svc03_provider_pmt_amt = CAST(LTrim(RTrim(@Col004)) as money)
			,@L2110_svc04_ub_rev_code = LTrim(RTrim(@Col005))
			,@L2110_svc05_units_paid = LTrim(RTrim(@Col006))
	end
	if ( RTrim(@col001) = 'DTM' AND @Col002 = '150' AND @curLoop = '2110' )
	begin
		set @L2110_dtm02_150_service_date = LTrim(RTrim(@Col003))
	end
	if ( RTrim(@col001) = 'DTM' AND @Col002 = '151' AND @curLoop = '2110' )
	begin
		set @L2110_dtm02_151_service_date = LTrim(RTrim(@Col003))
	end
	if ( RTrim(@col001) = 'DTM' AND @Col002 = '472' AND @curLoop = '2110' )
	begin
		set @L2110_dtm02_472_service_date = LTrim(RTrim(@Col003))
	end
	
	-- 1000A Loop
	if ( RTrim(@col001) = 'N1' AND @Col002 = 'PR' )
	begin
		SELECT
		 @curLoop = '1000A'
		,@L1000A_n101_entity_id_code = LTrim(RTrim(@Col002))
		,@L1000A_n102_payer_nm = LTrim(RTrim(@col003))
		,@L1000A_n103_payer_id_qual = LTrim(RTrim(@col004))
		,@L1000A_n104_payer_id = LTrim(RTrim(@col005))
	end
	if ( RTrim(@col001) = 'N3' AND @curLoop = '1000A')
	begin
		set @L1000A_n301_payer_address1 = LTrim(RTrim(@col002))
		set @L1000A_n302_payer_address2 = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'N4' AND @curLoop = '1000A')
	begin
		SELECT
		 @L1000A_n401_payer_city = LTrim(RTrim(@col002))
		,@L1000A_n402_payer_state = LTrim(RTrim(@col003))
		,@L1000A_n403_payer_zip = LTrim(RTrim(@col004))
	end
	if ( RTrim(@col001) = 'PER' AND @curLoop = '1000A')
	begin
		SELECT
		 @L1000A_per01_contact_function_code = LTrim(RTrim(@col002))
		,@L1000A_per02_contact_nm = LTrim(RTrim(@col003))
		,@L1000A_per03_comm_num_qual = LTrim(RTrim(@col004))
		,@L1000A_per04_comm_number = LTrim(RTrim(@col005))
	end

	if ( RTrim(@col001) = 'N1' AND @Col002 = 'PE' )
	begin
		SELECT
		 @curLoop = '1000B'
		,@L1000B_n101_entity_id_code = LTrim(RTrim(@Col002))
		,@L1000B_n102_payee_nm = LTrim(RTrim(@col003))
		,@L1000B_n103_payee_id_qual = LTrim(RTrim(@col004))
		,@L1000B_n104_payee_id = LTrim(RTrim(@col005))
	end
	if ( RTrim(@col001) = 'N3' AND @curLoop = '1000B')
	begin
		set @L1000B_n301_payee_address1 = LTrim(RTrim(@col002))
		set @L1000B_n302_payee_address2 = LTrim(RTrim(@col003))
	end
	if ( RTrim(@col001) = 'N4' AND @curLoop = '1000B')
	begin
		SELECT 
		 @L1000B_n401_payee_city = LTrim(RTrim(@col002))
		,@L1000B_n402_payee_state = LTrim(RTrim(@col003))
		,@L1000B_n403_payee_zip = LTrim(RTrim(@col004))
	end

	if ( RTrim(@col001) = 'CLP')
	begin
		set @curLoop = '2100'
		SET @clp_count = @clp_count + 1
		if (@clp_count > 1)
		begin
			-- insert a record when we start a new claim (meaning we're done with the last service line on the previous claim)
			exec up_x12_835_insert
				@x12_transaction_id = @x12_transaction_id,
				@bpr01_trans_handling_code = @bpr01_trans_handling_code,
				@bpr02_total_prov_pmt_amt = @bpr02_total_prov_pmt_amt,
				@bpr03_credit_debit_flag_code = @bpr03_credit_debit_flag_code,
				@bpr04_payment_method_code = @bpr04_payment_method_code,
				@bpr05_payment_format_code = @bpr05_payment_format_code,
				@bpr06_sender_dfi_id_qual = @bpr06_sender_dfi_id_qual,
				@bpr07_sender_dfi_id = @bpr07_sender_dfi_id,
				@bpr08_sender_account_num_qual = @bpr08_sender_account_num_qual,
				@bpr09_sender_account_num = @bpr09_sender_account_num,
				@bpr10_payer_id = @bpr10_payer_id,
				@bpr11_orig_co_supp_code = @bpr11_orig_co_supp_code,
				@bpr12_receiver_dfi_id_qual = @bpr12_receiver_dfi_id_qual,
				@bpr13_receiver_dfi_id = @bpr13_receiver_dfi_id,
				@bpr14_receiver_account_num_qual = @bpr14_receiver_account_num_qual,
				@bpr15_receiver_account_num = @bpr15_receiver_account_num,
				@bpr16_check_date = @bpr16_check_date,
				@trn01_trace_type_code = @trn01_trace_type_code,
				@trn02_trace_number = @trn02_trace_number,
				@trn03_payer_id = @trn03_payer_id,
				@ref01_receiver_ref_id_qual = @ref01_receiver_ref_id_qual,
				@ref02_receiver_ref_id = @ref02_receiver_ref_id,
				@dtm02_production_date = @dtm02_production_date,
				@L1000A_n101_entity_id_code = @L1000A_n101_entity_id_code,
				@L1000A_n102_payer_nm = @L1000A_n102_payer_nm,
				@L1000A_n103_payer_id_qual = @L1000A_n103_payer_id_qual,
				@L1000A_n104_payer_id = @L1000A_n104_payer_id,
				@L1000A_n301_payer_address1 = @L1000A_n301_payer_address1,
				@L1000A_n302_payer_address2 = @L1000A_n302_payer_address2,
				@L1000A_n401_payer_city = @L1000A_n401_payer_city,
				@L1000A_n402_payer_state = @L1000A_n402_payer_state,
				@L1000A_n403_payer_zip = @L1000A_n403_payer_zip,
				@L1000A_ref01_ref_id_qual = @L1000A_ref01_ref_id_qual,
				@L1000A_ref02_add_payer_id = @L1000A_ref02_add_payer_id,
				@L1000A_per01_contact_function_code = @L1000A_per01_contact_function_code,
				@L1000A_per02_contact_nm = @L1000A_per02_contact_nm,
				@L1000A_per03_comm_num_qual = @L1000A_per03_comm_num_qual,
				@L1000A_per04_comm_number = @L1000A_per04_comm_number,
				@L1000B_n101_entity_id_code = @L1000B_n101_entity_id_code,
				@L1000B_n102_payee_nm = @L1000B_n102_payee_nm,
				@L1000B_n103_payee_id_qual = @L1000B_n103_payee_id_qual,
				@L1000B_n104_payee_id = @L1000B_n104_payee_id,
				@L1000B_n301_payee_address1 = @L1000B_n301_payee_address1,
				@L1000B_n302_payee_address2 = @L1000B_n302_payee_address2,
				@L1000B_n401_payee_city = @L1000B_n401_payee_city,
				@L1000B_n402_payee_state = @L1000B_n402_payee_state,
				@L1000B_n403_payee_zip = @L1000B_n403_payee_zip,
				@L1000B_ref01_ref_id_qual = @L1000B_ref01_ref_id_qual,
				@L1000B_ref02_add_payee_id = @L1000B_ref02_add_payee_id,
				@L2000_lx01_assigned_number = @L2000_lx01_assigned_number,
				@L2100_clp01_pt_control_no = @L2100_clp01_pt_control_no,
				@L2100_clp02_claim_status_code = @L2100_clp02_claim_status_code,
				@L2100_clp03_total_claim_chg_amt = @L2100_clp03_total_claim_chg_amt,
				@L2100_clp04_claim_pmt_amt = @L2100_clp04_claim_pmt_amt,
				@L2100_clp05_pt_resp_amt = @L2100_clp05_pt_resp_amt,
				@L2100_clp06_claim_filing_ind_code = @L2100_clp06_claim_filing_ind_code,
				@L2100_clp07_payer_claim_control_no = @L2100_clp07_payer_claim_control_no,
				@L2100_clp08_facility_type_code = @L2100_clp08_facility_type_code,
				@L2100_clp09_claim_freq_code = @L2100_clp09_claim_freq_code,
				@L2100_clp11_drg_code = @L2100_clp11_drg_code,
				@L2100_clp12_drg_weight = @L2100_clp12_drg_weight,
				@L2100_clp13_discharge_fraction = @L2100_clp13_discharge_fraction,
				
				@L2100_nm103_TT_cob_carrier_nm = @L2100_nm103_TT_cob_carrier_nm,
				@L2100_nm108_TT_cob_id_qual = @L2100_nm108_TT_cob_id_qual,
				@L2100_nm109_TT_cob_id = @L2100_nm109_TT_cob_id,
				@L2100_nm103_PR_corrected_prty_payer_nm = @L2100_nm103_PR_corrected_prty_payer_nm,
				@L2100_nm108_PR_corrected_prty_payer_nm_id_qual = @L2100_nm108_PR_corrected_prty_payer_nm_id_qual,
				@L2100_nm109_PR_corrected_prty_payer_nm_id = @L2100_nm109_PR_corrected_prty_payer_nm_id,
				@L2100_nm103_QC_patient_last_nm = @L2100_nm103_QC_patient_last_nm,
				@L2100_nm104_QC_patient_first_nm = @L2100_nm104_QC_patient_first_nm,
				@L2100_nm105_QC_patient_middle_nm = @L2100_nm105_QC_patient_middle_nm,
				@L2100_nm108_QC_patient_id_qual = @L2100_nm108_QC_patient_id_qual,
				@L2100_nm109_QC_patient_id = @L2100_nm109_QC_patient_id,
				@L2100_nm103_IL_subscriber_last_nm = @L2100_nm103_IL_subscriber_last_nm,
				@L2100_nm104_IL_subscriber_first_nm = @L2100_nm104_IL_subscriber_first_nm,
				@L2100_nm105_IL_subscriber_middle_nm = @L2100_nm105_IL_subscriber_middle_nm,
				@L2100_nm108_IL_subscriber_id_qual = @L2100_nm108_IL_subscriber_id_qual,
				@L2100_nm109_IL_subscriber_id = @L2100_nm109_IL_subscriber_id,
				@L2100_ref02_9A_other_claim_ref_id = @L2100_ref02_9A_other_claim_ref_id,
				@L2100_ref02_BB_other_claim_ref_id = @L2100_ref02_BB_other_claim_ref_id,
				@L2100_ref02_G1_other_claim_ref_id = @L2100_ref02_G1_other_claim_ref_id,
				@L2100_ref02_EA_other_claim_ref_id = @L2100_ref02_EA_other_claim_ref_id,
				@L2100_ref02_F8_other_claim_ref_id = @L2100_ref02_F8_other_claim_ref_id,
				@L2100_ref01_rend_prov_sec_ref_id_qual = @L2100_ref01_rend_prov_sec_ref_id_qual,
				@L2100_ref02_rend_prov_sec_ref_id = @L2100_ref02_rend_prov_sec_ref_id,
				@L2100_dtm02_036_expiration_date = @L2100_dtm02_036_expiration_date,
				@L2100_dtm02_050_received_date = @L2100_dtm02_050_received_date,
				@L2100_dtm02_232_stmt_start_date = @L2100_dtm02_232_stmt_start_date,
				@L2100_dtm02_233_stmt_end_date = @L2100_dtm02_233_stmt_end_date,
				@L2110_svc01_proc_code = @L2110_svc01_proc_code,
				@L2110_svc01_proc_mod1 = @L2110_svc01_proc_mod1,
				@L2110_svc01_proc_mod2 = @L2110_svc01_proc_mod2,
				@L2110_svc01_proc_mod3 = @L2110_svc01_proc_mod3,
				@L2110_svc01_proc_mod4 = @L2110_svc01_proc_mod4,
				@L2110_svc02_charge_amt = @L2110_svc02_charge_amt,
				@L2110_svc03_provider_pmt_amt = @L2110_svc03_provider_pmt_amt,
				@L2110_svc04_ub_rev_code = @L2110_svc04_ub_rev_code,
				@L2110_svc05_units_paid = @L2110_svc05_units_paid,
				@L2110_dtm02_150_service_date = @L2110_dtm02_150_service_date,
				@L2110_dtm02_151_service_date = @L2110_dtm02_151_service_date,
				@L2110_dtm02_472_service_date = @L2110_dtm02_472_service_date,
				@L2110_1_cas01_adj_group_code = @L2110_1_cas01_adj_group_code,
				@L2110_1_cas02_adj_reason_code = @L2110_1_cas02_adj_reason_code,
				@L2110_1_cas03_adj_amt = @L2110_1_cas03_adj_amt,
				@L2110_1_cas04_adj_qty = @L2110_1_cas04_adj_qty,
				@L2110_1_cas05_adj_reason_code = @L2110_1_cas05_adj_reason_code,
				@L2110_1_cas06_adj_amt = @L2110_1_cas06_adj_amt,
				@L2110_1_cas07_adj_qty = @L2110_1_cas07_adj_qty,
				@L2110_1_cas08_adj_reason_code = @L2110_1_cas08_adj_reason_code,
				@L2110_1_cas09_adj_amt = @L2110_1_cas09_adj_amt,
				@L2110_1_cas10_adj_qty = @L2110_1_cas10_adj_qty,
				@L2110_1_cas11_adj_reason_code = @L2110_1_cas11_adj_reason_code,
				@L2110_1_cas12_adj_amt = @L2110_1_cas12_adj_amt,
				@L2110_1_cas13_adj_qty = @L2110_1_cas13_adj_qty,
				@L2110_1_cas14_adj_reason_code = @L2110_1_cas14_adj_reason_code,
				@L2110_1_cas15_adj_amt = @L2110_1_cas15_adj_amt,
				@L2110_1_cas16_adj_qty = @L2110_1_cas16_adj_qty,
				@L2110_1_cas17_adj_reason_code = @L2110_1_cas17_adj_reason_code,
				@L2110_1_cas18_adj_amt = @L2110_1_cas18_adj_amt,
				@L2110_1_cas19_adj_qty = @L2110_1_cas19_adj_qty,
				
				@L2110_2_cas01_adj_group_code = @L2110_2_cas01_adj_group_code,
				@L2110_2_cas02_adj_reason_code = @L2110_2_cas02_adj_reason_code,
				@L2110_2_cas03_adj_amt = @L2110_2_cas03_adj_amt,
				@L2110_2_cas04_adj_qty = @L2110_2_cas04_adj_qty,
				@L2110_2_cas05_adj_reason_code = @L2110_2_cas05_adj_reason_code,
				@L2110_2_cas06_adj_amt = @L2110_2_cas06_adj_amt,
				@L2110_2_cas07_adj_qty = @L2110_2_cas07_adj_qty,
				@L2110_2_cas08_adj_reason_code = @L2110_2_cas08_adj_reason_code,
				@L2110_2_cas09_adj_amt = @L2110_2_cas09_adj_amt,
				@L2110_2_cas10_adj_qty = @L2110_2_cas10_adj_qty,
				@L2110_3_cas01_adj_group_code = @L2110_3_cas01_adj_group_code,
				@L2110_3_cas02_adj_reason_code = @L2110_3_cas02_adj_reason_code,
				@L2110_3_cas03_adj_amt = @L2110_3_cas03_adj_amt,
				@L2110_3_cas04_adj_qty = @L2110_3_cas04_adj_qty,
				@L2110_3_cas05_adj_reason_code = @L2110_3_cas05_adj_reason_code,
				@L2110_3_cas06_adj_amt = @L2110_3_cas06_adj_amt,
				@L2110_3_cas07_adj_qty = @L2110_3_cas07_adj_qty,
				@L2110_3_cas08_adj_reason_code = @L2110_3_cas08_adj_reason_code,
				@L2110_3_cas09_adj_amt = @L2110_3_cas09_adj_amt,
				@L2110_3_cas10_adj_qty = @L2110_3_cas10_adj_qty,
				@L2110_3_cas11_adj_reason_code = @L2110_3_cas11_adj_reason_code,
				@L2110_3_cas12_adj_amt = @L2110_3_cas12_adj_amt,
				@L2110_3_cas13_adj_qty = @L2110_3_cas13_adj_qty,
				@L2110_3_cas14_adj_reason_code = @L2110_3_cas14_adj_reason_code,
				@L2110_3_cas15_adj_amt = @L2110_3_cas15_adj_amt,
				@L2110_3_cas16_adj_qty = @L2110_3_cas16_adj_qty,
				@L2110_3_cas17_adj_reason_code = @L2110_3_cas17_adj_reason_code,
				@L2110_3_cas18_adj_amt = @L2110_3_cas18_adj_amt,
				@L2110_3_cas19_adj_qty = @L2110_3_cas19_adj_qty,
				@L2110_4_cas01_adj_group_code = @L2110_4_cas01_adj_group_code,
				@L2110_4_cas02_adj_reason_code = @L2110_4_cas02_adj_reason_code,
				@L2110_4_cas03_adj_amt = @L2110_4_cas03_adj_amt,
				@L2110_4_cas04_adj_qty = @L2110_4_cas04_adj_qty,
				@L2110_4_cas05_adj_reason_code = @L2110_4_cas05_adj_reason_code,
				@L2110_4_cas06_adj_amt = @L2110_4_cas06_adj_amt,
				@L2110_4_cas07_adj_qty = @L2110_4_cas07_adj_qty,
				@L2110_4_cas08_adj_reason_code = @L2110_4_cas08_adj_reason_code,
				@L2110_4_cas09_adj_amt = @L2110_4_cas09_adj_amt,
				@L2110_4_cas10_adj_qty = @L2110_4_cas10_adj_qty,
				@L2110_5_cas01_adj_group_code = @L2110_5_cas01_adj_group_code,
				@L2110_5_cas02_adj_reason_code = @L2110_5_cas02_adj_reason_code,
				@L2110_5_cas03_adj_amt = @L2110_5_cas03_adj_amt,
				@L2110_5_cas04_adj_qty = @L2110_5_cas04_adj_qty,
				@L2110_5_cas05_adj_reason_code = @L2110_5_cas05_adj_reason_code,
				@L2110_5_cas06_adj_amt = @L2110_5_cas06_adj_amt,
				@L2110_5_cas07_adj_qty = @L2110_5_cas07_adj_qty,
				@L2110_5_cas08_adj_reason_code = @L2110_5_cas08_adj_reason_code,
				@L2110_5_cas09_adj_amt = @L2110_5_cas09_adj_amt,
				@L2110_5_cas10_adj_qty = @L2110_5_cas10_adj_qty,

				@L2110_lq02_remark_code_01 = @L2110_lq02_remark_code_01,
				@L2110_lq02_remark_code_02 = @L2110_lq02_remark_code_02,
				@L2110_lq02_remark_code_03 = @L2110_lq02_remark_code_03,
				@L2110_lq02_remark_code_04 = @L2110_lq02_remark_code_04,
				@L2110_lq02_remark_code_05 = @L2110_lq02_remark_code_05,
				
				@L2100_1_cas01_adj_group_code =@L2100_1_cas01_adj_group_code ,
				@L2100_1_cas02_adj_reason_code =@L2100_1_cas02_adj_reason_code ,
				@L2100_1_cas03_adj_amt =@L2100_1_cas03_adj_amt ,
				@L2100_1_cas04_adj_qty =@L2100_1_cas04_adj_qty ,
				@L2100_1_cas05_adj_reason_code =@L2100_1_cas05_adj_reason_code ,
				@L2100_1_cas06_adj_amt =@L2100_1_cas06_adj_amt ,
				@L2100_1_cas07_adj_qty =@L2100_1_cas07_adj_qty ,
				@L2100_1_cas08_adj_reason_code =@L2100_1_cas08_adj_reason_code ,
				@L2100_1_cas09_adj_amt =@L2100_1_cas09_adj_amt ,
				@L2100_1_cas10_adj_qty =@L2100_1_cas10_adj_qty ,
				@L2100_1_cas11_adj_reason_code =@L2100_1_cas11_adj_reason_code ,
				@L2100_1_cas12_adj_amt =@L2100_1_cas12_adj_amt ,
				@L2100_1_cas13_adj_qty =@L2100_1_cas13_adj_qty ,
				@L2100_1_cas14_adj_reason_code =@L2100_1_cas14_adj_reason_code ,
				@L2100_1_cas15_adj_amt =@L2100_1_cas15_adj_amt ,
				@L2100_1_cas16_adj_qty =@L2100_1_cas16_adj_qty ,
				@L2100_1_cas17_adj_reason_code =@L2100_1_cas17_adj_reason_code ,
				@L2100_1_cas18_adj_amt =@L2100_1_cas18_adj_amt ,
				@L2100_1_cas19_adj_qty =@L2100_1_cas19_adj_qty ,
				@L2100_2_cas01_adj_group_code =@L2100_2_cas01_adj_group_code ,
				@L2100_2_cas02_adj_reason_code =@L2100_2_cas02_adj_reason_code ,
				@L2100_2_cas03_adj_amt =@L2100_2_cas03_adj_amt ,
				@L2100_2_cas04_adj_qty =@L2100_2_cas04_adj_qty ,
				@L2100_2_cas05_adj_reason_code =@L2100_2_cas05_adj_reason_code ,
				@L2100_2_cas06_adj_amt =@L2100_2_cas06_adj_amt ,
				@L2100_2_cas07_adj_qty =@L2100_2_cas07_adj_qty ,
				@L2100_2_cas08_adj_reason_code =@L2100_2_cas08_adj_reason_code ,
				@L2100_2_cas09_adj_amt =@L2100_2_cas09_adj_amt ,
				@L2100_2_cas10_adj_qty =@L2100_2_cas10_adj_qty ,
				@L2100_2_cas11_adj_reason_code =@L2100_2_cas11_adj_reason_code ,
				@L2100_2_cas12_adj_amt =@L2100_2_cas12_adj_amt ,
				@L2100_2_cas13_adj_qty =@L2100_2_cas13_adj_qty ,
				@L2100_2_cas14_adj_reason_code =@L2100_2_cas14_adj_reason_code ,
				@L2100_2_cas15_adj_amt =@L2100_2_cas15_adj_amt ,
				@L2100_2_cas16_adj_qty =@L2100_2_cas16_adj_qty ,
				@L2100_2_cas17_adj_reason_code =@L2100_2_cas17_adj_reason_code ,
				@L2100_2_cas18_adj_amt =@L2100_2_cas18_adj_amt ,
				@L2100_2_cas19_adj_qty =@L2100_2_cas19_adj_qty ,
				@L2100_3_cas01_adj_group_code =@L2100_3_cas01_adj_group_code ,
				@L2100_3_cas02_adj_reason_code =@L2100_3_cas02_adj_reason_code ,
				@L2100_3_cas03_adj_amt =@L2100_3_cas03_adj_amt ,
				@L2100_3_cas04_adj_qty =@L2100_3_cas04_adj_qty ,
				@L2100_3_cas05_adj_reason_code =@L2100_3_cas05_adj_reason_code ,
				@L2100_3_cas06_adj_amt =@L2100_3_cas06_adj_amt ,
				@L2100_3_cas07_adj_qty =@L2100_3_cas07_adj_qty ,
				@L2100_3_cas08_adj_reason_code =@L2100_3_cas08_adj_reason_code ,
				@L2100_3_cas09_adj_amt =@L2100_3_cas09_adj_amt ,
				@L2100_3_cas10_adj_qty =@L2100_3_cas10_adj_qty ,
				@L2100_3_cas11_adj_reason_code =@L2100_3_cas11_adj_reason_code ,
				@L2100_3_cas12_adj_amt =@L2100_3_cas12_adj_amt ,
				@L2100_3_cas13_adj_qty =@L2100_3_cas13_adj_qty ,
				@L2100_3_cas14_adj_reason_code =@L2100_3_cas14_adj_reason_code ,
				@L2100_3_cas15_adj_amt =@L2100_3_cas15_adj_amt ,
				@L2100_3_cas16_adj_qty =@L2100_3_cas16_adj_qty ,
				@L2100_3_cas17_adj_reason_code =@L2100_3_cas17_adj_reason_code ,
				@L2100_3_cas18_adj_amt =@L2100_3_cas18_adj_amt ,
				@L2100_3_cas19_adj_qty =@L2100_3_cas19_adj_qty ,
				@L2100_4_cas01_adj_group_code =@L2100_4_cas01_adj_group_code ,
				@L2100_4_cas02_adj_reason_code =@L2100_4_cas02_adj_reason_code ,
				@L2100_4_cas03_adj_amt =@L2100_4_cas03_adj_amt ,
				@L2100_4_cas04_adj_qty =@L2100_4_cas04_adj_qty ,
				@L2100_4_cas05_adj_reason_code =@L2100_4_cas05_adj_reason_code ,
				@L2100_4_cas06_adj_amt =@L2100_4_cas06_adj_amt ,
				@L2100_4_cas07_adj_qty =@L2100_4_cas07_adj_qty ,
				@L2100_4_cas08_adj_reason_code =@L2100_4_cas08_adj_reason_code ,
				@L2100_4_cas09_adj_amt =@L2100_4_cas09_adj_amt ,
				@L2100_4_cas10_adj_qty =@L2100_4_cas10_adj_qty ,
				@L2100_4_cas11_adj_reason_code =@L2100_4_cas11_adj_reason_code ,
				@L2100_4_cas12_adj_amt =@L2100_4_cas12_adj_amt ,
				@L2100_4_cas13_adj_qty =@L2100_4_cas13_adj_qty ,
				@L2100_4_cas14_adj_reason_code =@L2100_4_cas14_adj_reason_code ,
				@L2100_4_cas15_adj_amt =@L2100_4_cas15_adj_amt ,
				@L2100_4_cas16_adj_qty =@L2100_4_cas16_adj_qty ,
				@L2100_4_cas17_adj_reason_code =@L2100_4_cas17_adj_reason_code ,
				@L2100_4_cas18_adj_amt =@L2100_4_cas18_adj_amt ,
				@L2100_4_cas19_adj_qty =@L2100_4_cas19_adj_qty ,
				@L2100_5_cas01_adj_group_code =@L2100_5_cas01_adj_group_code ,
				@L2100_5_cas02_adj_reason_code =@L2100_5_cas02_adj_reason_code ,
				@L2100_5_cas03_adj_amt =@L2100_5_cas03_adj_amt ,
				@L2100_5_cas04_adj_qty =@L2100_5_cas04_adj_qty ,
				@L2100_5_cas05_adj_reason_code =@L2100_5_cas05_adj_reason_code ,
				@L2100_5_cas06_adj_amt =@L2100_5_cas06_adj_amt ,
				@L2100_5_cas07_adj_qty =@L2100_5_cas07_adj_qty ,
				@L2100_5_cas08_adj_reason_code =@L2100_5_cas08_adj_reason_code ,
				@L2100_5_cas09_adj_amt =@L2100_5_cas09_adj_amt ,
				@L2100_5_cas10_adj_qty =@L2100_5_cas10_adj_qty ,
				@L2100_5_cas11_adj_reason_code =@L2100_5_cas11_adj_reason_code ,
				@L2100_5_cas12_adj_amt =@L2100_5_cas12_adj_amt ,
				@L2100_5_cas13_adj_qty =@L2100_5_cas13_adj_qty ,
				@L2100_5_cas14_adj_reason_code =@L2100_5_cas14_adj_reason_code ,
				@L2100_5_cas15_adj_amt =@L2100_5_cas15_adj_amt ,
				@L2100_5_cas16_adj_qty =@L2100_5_cas16_adj_qty ,
				@L2100_5_cas17_adj_reason_code =@L2100_5_cas17_adj_reason_code ,
				@L2100_5_cas18_adj_amt =@L2100_5_cas18_adj_amt ,
				@L2100_5_cas19_adj_qty =@L2100_5_cas19_adj_qty ,
				@L2110_2_cas11_adj_reason_code =@L2110_2_cas11_adj_reason_code ,
				@L2110_2_cas12_adj_amt =@L2110_2_cas12_adj_amt ,
				@L2110_2_cas13_adj_qty =@L2110_2_cas13_adj_qty ,
				@L2110_2_cas14_adj_reason_code =@L2110_2_cas14_adj_reason_code ,
				@L2110_2_cas15_adj_amt =@L2110_2_cas15_adj_amt ,
				@L2110_2_cas16_adj_qty =@L2110_2_cas16_adj_qty ,
				@L2110_2_cas17_adj_reason_code =@L2110_2_cas17_adj_reason_code ,
				@L2110_2_cas18_adj_amt =@L2110_2_cas18_adj_amt ,
				@L2110_2_cas19_adj_qty =@L2110_2_cas19_adj_qty ,
				@L2110_4_cas11_adj_reason_code =@L2110_4_cas11_adj_reason_code ,
				@L2110_4_cas12_adj_amt =@L2110_4_cas12_adj_amt ,
				@L2110_4_cas13_adj_qty =@L2110_4_cas13_adj_qty ,
				@L2110_4_cas14_adj_reason_code =@L2110_4_cas14_adj_reason_code ,
				@L2110_4_cas15_adj_amt =@L2110_4_cas15_adj_amt ,
				@L2110_4_cas16_adj_qty =@L2110_4_cas16_adj_qty ,
				@L2110_4_cas17_adj_reason_code =@L2110_4_cas17_adj_reason_code ,
				@L2110_4_cas18_adj_amt =@L2110_4_cas18_adj_amt ,
				@L2110_4_cas19_adj_qty =@L2110_4_cas19_adj_qty ,
				@L2110_5_cas11_adj_reason_code =@L2110_5_cas11_adj_reason_code ,
				@L2110_5_cas12_adj_amt =@L2110_5_cas12_adj_amt ,
				@L2110_5_cas13_adj_qty =@L2110_5_cas13_adj_qty ,
				@L2110_5_cas14_adj_reason_code =@L2110_5_cas14_adj_reason_code ,
				@L2110_5_cas15_adj_amt =@L2110_5_cas15_adj_amt ,
				@L2110_5_cas16_adj_qty =@L2110_5_cas16_adj_qty ,
				@L2110_5_cas17_adj_reason_code =@L2110_5_cas17_adj_reason_code ,
				@L2110_5_cas18_adj_amt =@L2110_5_cas18_adj_amt ,
				@L2110_5_cas19_adj_qty =@L2110_5_cas19_adj_qty 
			-- reset claim-level values to NULL
			SELECT
				@L2100_1_cas01_adj_group_code  = NULL,
				@L2100_1_cas02_adj_reason_code  = NULL,
				@L2100_1_cas03_adj_amt  = NULL,
				@L2100_1_cas04_adj_qty  = NULL,
				@L2100_1_cas05_adj_reason_code  = NULL,
				@L2100_1_cas06_adj_amt  = NULL,
				@L2100_1_cas07_adj_qty  = NULL,
				@L2100_1_cas08_adj_reason_code  = NULL,
				@L2100_1_cas09_adj_amt  = NULL,
				@L2100_1_cas10_adj_qty  = NULL,
				@L2100_1_cas11_adj_reason_code  = NULL,
				@L2100_1_cas12_adj_amt  = NULL,
				@L2100_1_cas13_adj_qty  = NULL,
				@L2100_1_cas14_adj_reason_code  = NULL,
				@L2100_1_cas15_adj_amt  = NULL,
				@L2100_1_cas16_adj_qty  = NULL,
				@L2100_1_cas17_adj_reason_code  = NULL,
				@L2100_1_cas18_adj_amt  = NULL,
				@L2100_1_cas19_adj_qty  = NULL,
				@L2100_2_cas01_adj_group_code  = NULL,
				@L2100_2_cas02_adj_reason_code  = NULL,
				@L2100_2_cas03_adj_amt  = NULL,
				@L2100_2_cas04_adj_qty  = NULL,
				@L2100_2_cas05_adj_reason_code  = NULL,
				@L2100_2_cas06_adj_amt  = NULL,
				@L2100_2_cas07_adj_qty  = NULL,
				@L2100_2_cas08_adj_reason_code  = NULL,
				@L2100_2_cas09_adj_amt  = NULL,
				@L2100_2_cas10_adj_qty  = NULL,
				@L2100_2_cas11_adj_reason_code  = NULL,
				@L2100_2_cas12_adj_amt  = NULL,
				@L2100_2_cas13_adj_qty  = NULL,
				@L2100_2_cas14_adj_reason_code  = NULL,
				@L2100_2_cas15_adj_amt  = NULL,
				@L2100_2_cas16_adj_qty  = NULL,
				@L2100_2_cas17_adj_reason_code  = NULL,
				@L2100_2_cas18_adj_amt  = NULL,
				@L2100_2_cas19_adj_qty  = NULL,
				@L2100_3_cas01_adj_group_code  = NULL,
				@L2100_3_cas02_adj_reason_code  = NULL,
				@L2100_3_cas03_adj_amt  = NULL,
				@L2100_3_cas04_adj_qty  = NULL,
				@L2100_3_cas05_adj_reason_code  = NULL,
				@L2100_3_cas06_adj_amt  = NULL,
				@L2100_3_cas07_adj_qty  = NULL,
				@L2100_3_cas08_adj_reason_code  = NULL,
				@L2100_3_cas09_adj_amt  = NULL,
				@L2100_3_cas10_adj_qty  = NULL,
				@L2100_3_cas11_adj_reason_code  = NULL,
				@L2100_3_cas12_adj_amt  = NULL,
				@L2100_3_cas13_adj_qty  = NULL,
				@L2100_3_cas14_adj_reason_code  = NULL,
				@L2100_3_cas15_adj_amt  = NULL,
				@L2100_3_cas16_adj_qty  = NULL,
				@L2100_3_cas17_adj_reason_code  = NULL,
				@L2100_3_cas18_adj_amt  = NULL,
				@L2100_3_cas19_adj_qty  = NULL,
				@L2100_4_cas01_adj_group_code  = NULL,
				@L2100_4_cas02_adj_reason_code  = NULL,
				@L2100_4_cas03_adj_amt  = NULL,
				@L2100_4_cas04_adj_qty  = NULL,
				@L2100_4_cas05_adj_reason_code  = NULL,
				@L2100_4_cas06_adj_amt  = NULL,
				@L2100_4_cas07_adj_qty  = NULL,
				@L2100_4_cas08_adj_reason_code  = NULL,
				@L2100_4_cas09_adj_amt  = NULL,
				@L2100_4_cas10_adj_qty  = NULL,
				@L2100_4_cas11_adj_reason_code  = NULL,
				@L2100_4_cas12_adj_amt  = NULL,
				@L2100_4_cas13_adj_qty  = NULL,
				@L2100_4_cas14_adj_reason_code  = NULL,
				@L2100_4_cas15_adj_amt  = NULL,
				@L2100_4_cas16_adj_qty  = NULL,
				@L2100_4_cas17_adj_reason_code  = NULL,
				@L2100_4_cas18_adj_amt  = NULL,
				@L2100_4_cas19_adj_qty  = NULL,
				@L2100_5_cas01_adj_group_code  = NULL,
				@L2100_5_cas02_adj_reason_code  = NULL,
				@L2100_5_cas03_adj_amt  = NULL,
				@L2100_5_cas04_adj_qty  = NULL,
				@L2100_5_cas05_adj_reason_code  = NULL,
				@L2100_5_cas06_adj_amt  = NULL,
				@L2100_5_cas07_adj_qty  = NULL,
				@L2100_5_cas08_adj_reason_code  = NULL,
				@L2100_5_cas09_adj_amt  = NULL,
				@L2100_5_cas10_adj_qty  = NULL,
				@L2100_5_cas11_adj_reason_code  = NULL,
				@L2100_5_cas12_adj_amt  = NULL,
				@L2100_5_cas13_adj_qty  = NULL,
				@L2100_5_cas14_adj_reason_code  = NULL,
				@L2100_5_cas15_adj_amt  = NULL,
				@L2100_5_cas16_adj_qty  = NULL,
				@L2100_5_cas17_adj_reason_code  = NULL,
				@L2100_5_cas18_adj_amt  = NULL,
				@L2100_5_cas19_adj_qty  = NULL


			,@L2100_ref02_EA_other_claim_ref_id = null
			,@L2100_ref02_F8_other_claim_ref_id = null
			,@L2100_ref02_BB_other_claim_ref_id = null
			,@L2100_ref02_9A_other_claim_ref_id = null
			,@L2100_ref02_G1_other_claim_ref_id = null
			,@L2100_dtm02_050_received_date = null
			,@L2100_nm103_TT_cob_carrier_nm = null
			,@L2100_nm108_TT_cob_id_qual = null
			,@L2100_nm109_TT_cob_id = null
			,@L2100_nm103_PR_corrected_prty_payer_nm = null
			,@L2100_nm108_PR_corrected_prty_payer_nm_id_qual = null
			,@L2100_nm109_PR_corrected_prty_payer_nm_id = null
			,@L2100_nm103_QC_patient_last_nm = null
			,@L2100_nm104_QC_patient_first_nm = null
			,@L2100_nm105_QC_patient_middle_nm = null
			,@L2100_nm108_QC_patient_id_qual = null
			,@L2100_nm109_QC_patient_id = null
			,@L2100_nm103_IL_subscriber_last_nm = null
			,@L2100_nm104_IL_subscriber_first_nm = null
			,@L2100_nm105_IL_subscriber_middle_nm = null
			,@L2100_nm108_IL_subscriber_id_qual = null
			,@L2100_nm109_IL_subscriber_id = NULL
			,@casLevel = 1
		end
		-- reset the procedure-line level value2
		SELECT
		 @L2110_1_cas01_adj_group_code = null
		,@L2110_1_cas02_adj_reason_code = null
		,@L2110_1_cas03_adj_amt = null
		,@L2110_1_cas04_adj_qty = null
		,@L2110_1_cas05_adj_reason_code = null
		,@L2110_1_cas06_adj_amt = null
		,@L2110_1_cas07_adj_qty = null
		,@L2110_1_cas08_adj_reason_code = null
		,@L2110_1_cas09_adj_amt = null
		,@L2110_1_cas10_adj_qty = null
		,@L2110_1_cas11_adj_reason_code = null
		,@L2110_1_cas12_adj_amt = null
		,@L2110_1_cas13_adj_qty = null
		,@L2110_1_cas14_adj_reason_code = null
		,@L2110_1_cas15_adj_amt = null
		,@L2110_1_cas16_adj_qty = null
		,@L2110_1_cas17_adj_reason_code = null
		,@L2110_1_cas18_adj_amt = null
		,@L2110_1_cas19_adj_qty = null

		,@L2110_2_cas01_adj_group_code = null
		,@L2110_2_cas02_adj_reason_code = null
		,@L2110_2_cas03_adj_amt = null
		,@L2110_2_cas04_adj_qty = null
		,@L2110_2_cas05_adj_reason_code = null
		,@L2110_2_cas06_adj_amt = null
		,@L2110_2_cas07_adj_qty = null
		,@L2110_2_cas08_adj_reason_code = null
		,@L2110_2_cas09_adj_amt = null
		,@L2110_2_cas10_adj_qty = null

		,@L2110_3_cas01_adj_group_code = null
		,@L2110_3_cas02_adj_reason_code = null
		,@L2110_3_cas03_adj_amt = null
		,@L2110_3_cas04_adj_qty = null
		,@L2110_3_cas05_adj_reason_code = null
		,@L2110_3_cas06_adj_amt = null
		,@L2110_3_cas07_adj_qty = null
		,@L2110_3_cas08_adj_reason_code = null
		,@L2110_3_cas09_adj_amt = null
		,@L2110_3_cas10_adj_qty = null
		,@L2110_3_cas11_adj_reason_code = null
		,@L2110_3_cas12_adj_amt = null
		,@L2110_3_cas13_adj_qty = null
		,@L2110_3_cas14_adj_reason_code = null
		,@L2110_3_cas15_adj_amt = null
		,@L2110_3_cas16_adj_qty = null
		,@L2110_3_cas17_adj_reason_code = null
		,@L2110_3_cas18_adj_amt = null
		,@L2110_3_cas19_adj_qty = null

		,@L2110_4_cas01_adj_group_code = null
		,@L2110_4_cas02_adj_reason_code = null
		,@L2110_4_cas03_adj_amt = null
		,@L2110_4_cas04_adj_qty = null
		,@L2110_4_cas05_adj_reason_code = null
		,@L2110_4_cas06_adj_amt = null
		,@L2110_4_cas07_adj_qty = null
		,@L2110_4_cas08_adj_reason_code = null
		,@L2110_4_cas09_adj_amt = null
		,@L2110_4_cas10_adj_qty = null

		,@L2110_5_cas01_adj_group_code = null
		,@L2110_5_cas02_adj_reason_code = null
		,@L2110_5_cas03_adj_amt = null
		,@L2110_5_cas04_adj_qty = null
		,@L2110_5_cas05_adj_reason_code = null
		,@L2110_5_cas06_adj_amt = null
		,@L2110_5_cas07_adj_qty = null
		,@L2110_5_cas08_adj_reason_code = null
		,@L2110_5_cas09_adj_amt = null
		,@L2110_5_cas10_adj_qty = null
		,@L2110_2_cas11_adj_reason_code  = NULL
		,@L2110_2_cas12_adj_amt  = NULL
		,@L2110_2_cas13_adj_qty  = NULL
		,@L2110_2_cas14_adj_reason_code  = NULL
		,@L2110_2_cas15_adj_amt  = NULL
		,@L2110_2_cas16_adj_qty  = NULL
		,@L2110_2_cas17_adj_reason_code  = NULL
		,@L2110_2_cas18_adj_amt  = NULL
		,@L2110_2_cas19_adj_qty  = NULL
		,@L2110_4_cas11_adj_reason_code  = NULL
		,@L2110_4_cas12_adj_amt  = NULL
		,@L2110_4_cas13_adj_qty  = NULL
		,@L2110_4_cas14_adj_reason_code  = NULL
		,@L2110_4_cas15_adj_amt  = NULL
		,@L2110_4_cas16_adj_qty  = NULL
		,@L2110_4_cas17_adj_reason_code  = NULL
		,@L2110_4_cas18_adj_amt  = NULL
		,@L2110_4_cas19_adj_qty  = NULL
		,@L2110_5_cas11_adj_reason_code  = NULL
		,@L2110_5_cas12_adj_amt  = NULL
		,@L2110_5_cas13_adj_qty  = NULL
		,@L2110_5_cas14_adj_reason_code  = NULL
		,@L2110_5_cas15_adj_amt  = NULL
		,@L2110_5_cas16_adj_qty  = NULL
		,@L2110_5_cas17_adj_reason_code  = NULL
		,@L2110_5_cas18_adj_amt  = NULL
		,@L2110_5_cas19_adj_qty  = NULL
		,@L2110_lq02_remark_code_01 = null
		,@L2110_lq02_remark_code_02 = null
		,@L2110_lq02_remark_code_03 = null
		,@L2110_lq02_remark_code_04 = null
		,@L2110_lq02_remark_code_05 = null
		-- ,the new claim and ICN values
		,@prev_L2100_clp01_pt_control_no = @L2100_clp01_pt_control_no
		,@L2100_clp01_pt_control_no = LTrim(RTrim(@col002))
		,@L2100_clp02_claim_status_code = LTrim(RTrim(@col003))
		,@L2100_clp03_total_claim_chg_amt = CAST(LTrim(RTrim(@col004)) as money)
		,@L2100_clp04_claim_pmt_amt = CAST(LTrim(RTrim(@col005)) as money)
		,@L2100_clp05_pt_resp_amt = CAST(LTrim(RTrim(@col006)) as money)
		,@L2100_clp06_claim_filing_ind_code = LTrim(RTrim(@col007))
		,@L2100_clp07_payer_claim_control_no = LTrim(RTrim(@col008))
		,@L2100_clp08_facility_type_code = LTrim(RTrim(@col009))
		,@L2100_clp09_claim_freq_code = LTrim(RTrim(@col010))
		,@L2100_clp11_drg_code = LTrim(RTrim(@col012))
		,@L2100_clp12_drg_weight = LTrim(RTrim(@col013))
		,@L2100_clp13_discharge_fraction = LTrim(RTrim(@col014))
		,@casLevel = 1
	END
	
	
	-- this is the first CAS segment for this procedure line
	if ( RTrim(@col001) = 'CAS' AND @curLoop = '2100' )
	BEGIN 
		if ( @casLevel = 1 )
		begin
			SELECT
			 @L2100_1_cas01_adj_group_code = @Col002
			,@L2100_1_cas02_adj_reason_code = @Col003
			,@L2100_1_cas03_adj_amt = Cast(RTrim(@col004) as money)
			,@L2100_1_cas04_adj_qty = @col005
			,@L2100_1_cas05_adj_reason_code = @Col006
			,@L2100_1_cas06_adj_amt = Cast(RTrim(@col007) as money)
			,@L2100_1_cas07_adj_qty = @col008
			,@L2100_1_cas08_adj_reason_code = @Col009
			,@L2100_1_cas09_adj_amt = Cast(RTrim(@col010) as money)
			,@L2100_1_cas10_adj_qty = @col011
			,@L2100_1_cas11_adj_reason_code = @Col012
			,@L2100_1_cas12_adj_amt = Cast(RTrim(@col013) as money)
			,@L2100_1_cas13_adj_qty = @col014
			,@L2100_1_cas14_adj_reason_code = @Col015
			,@L2100_1_cas15_adj_amt = Cast(RTrim(@col016) as money)
			,@L2100_1_cas16_adj_qty = @col017
			,@L2100_1_cas17_adj_reason_code = @Col018
			,@L2100_1_cas18_adj_amt = Cast(RTrim(@col019) as money)
			,@L2100_1_cas19_adj_qty = @col020
		end
	-- this is the second CAS segment for this procedure line
		if (	@casLevel = 2 )
		begin
			SELECT
			 @L2100_2_cas01_adj_group_code = @Col002
			,@L2100_2_cas02_adj_reason_code = @Col003
			,@L2100_2_cas03_adj_amt = Cast(RTrim(@col004) as money)
			,@L2100_2_cas04_adj_qty = @col005
			,@L2100_2_cas05_adj_reason_code = @Col006
			,@L2100_2_cas06_adj_amt = Cast(RTrim(@col007) as money)
			,@L2100_2_cas07_adj_qty = @col008
			,@L2100_2_cas08_adj_reason_code = @Col009
			,@L2100_2_cas09_adj_amt = Cast(RTrim(@col010) as money)
			,@L2100_2_cas10_adj_qty = @col011
			,@L2100_2_cas11_adj_reason_code = @Col012
			,@L2100_2_cas12_adj_amt = Cast(RTrim(@col013) as money)
			,@L2100_2_cas13_adj_qty = @col014
			,@L2100_2_cas14_adj_reason_code = @Col015
			,@L2100_2_cas15_adj_amt = Cast(RTrim(@col016) as money)
			,@L2100_2_cas16_adj_qty = @col017
			,@L2100_2_cas17_adj_reason_code = @Col018
			,@L2100_2_cas18_adj_amt = Cast(RTrim(@col019) as money)
			,@L2100_2_cas19_adj_qty = @col020
		end

	-- this is the third CAS segment for this procedure line
		if (	@casLevel = 3 )
		begin
			SELECT
			 @L2100_3_cas01_adj_group_code = @Col002
			,@L2100_3_cas02_adj_reason_code = @Col003
			,@L2100_3_cas03_adj_amt = Cast(RTrim(@col004) as money)
			,@L2100_3_cas04_adj_qty = @col005
			,@L2100_3_cas05_adj_reason_code = @Col006
			,@L2100_3_cas06_adj_amt = Cast(RTrim(@col007) as money)
			,@L2100_3_cas07_adj_qty = @col008
			,@L2100_3_cas08_adj_reason_code = @Col009
			,@L2100_3_cas09_adj_amt = Cast(RTrim(@col010) as money)
			,@L2100_3_cas10_adj_qty = @col011
			,@L2100_3_cas11_adj_reason_code = @Col012
			,@L2100_3_cas12_adj_amt = Cast(RTrim(@col013) as money)
			,@L2100_3_cas13_adj_qty = @col014
			,@L2100_3_cas14_adj_reason_code = @Col015
			,@L2100_3_cas15_adj_amt = Cast(RTrim(@col016) as money)
			,@L2100_3_cas16_adj_qty = @col017
			,@L2100_3_cas17_adj_reason_code = @Col018
			,@L2100_3_cas18_adj_amt = Cast(RTrim(@col019) as money)
			,@L2100_3_cas19_adj_qty = @col020
		end

	-- this is the 4th CAS segment for this procedure line
		if (	@casLevel = 4 )
		begin
			select 
			 @L2100_4_cas01_adj_group_code = @Col002
			,@L2100_4_cas02_adj_reason_code = @Col003
			,@L2100_4_cas03_adj_amt = Cast(RTrim(@col004) as money)
			,@L2100_4_cas04_adj_qty = @col005
			,@L2100_4_cas05_adj_reason_code = @Col006
			,@L2100_4_cas06_adj_amt = Cast(RTrim(@col007) as money)
			,@L2100_4_cas07_adj_qty = @col008
			,@L2100_4_cas08_adj_reason_code = @Col009
			,@L2100_4_cas09_adj_amt = Cast(RTrim(@col010) as money)
			,@L2100_4_cas10_adj_qty = @col011
			,@L2100_4_cas11_adj_reason_code = @Col012
			,@L2100_4_cas12_adj_amt = Cast(RTrim(@col013) as money)
			,@L2100_4_cas13_adj_qty = @col014
			,@L2100_4_cas14_adj_reason_code = @Col015
			,@L2100_4_cas15_adj_amt = Cast(RTrim(@col016) as money)
			,@L2100_4_cas16_adj_qty = @col017
			,@L2100_4_cas17_adj_reason_code = @Col018
			,@L2100_4_cas18_adj_amt = Cast(RTrim(@col019) as money)
			,@L2100_4_cas19_adj_qty = @col020
		end

	-- this is the 5th CAS segment for this procedure line
		if (	@casLevel = 5 )
		begin
			SELECT
			 @L2100_5_cas01_adj_group_code = @Col002
			,@L2100_5_cas02_adj_reason_code = @Col003
			,@L2100_5_cas03_adj_amt = Cast(RTrim(@col004) as money)
			,@L2100_5_cas04_adj_qty = @col005
			,@L2100_5_cas05_adj_reason_code = @Col006
			,@L2100_5_cas06_adj_amt = Cast(RTrim(@col007) as money)
			,@L2100_5_cas07_adj_qty = @col008
			,@L2100_5_cas08_adj_reason_code = @Col009
			,@L2100_5_cas09_adj_amt = Cast(RTrim(@col010) as money)
			,@L2100_5_cas10_adj_qty = @col011
			,@L2100_5_cas11_adj_reason_code = @Col012
			,@L2100_5_cas12_adj_amt = Cast(RTrim(@col013) as money)
			,@L2100_5_cas13_adj_qty = @col014
			,@L2100_5_cas14_adj_reason_code = @Col015
			,@L2100_5_cas15_adj_amt = Cast(RTrim(@col016) as money)
			,@L2100_5_cas16_adj_qty = @col017
			,@L2100_5_cas17_adj_reason_code = @Col018
			,@L2100_5_cas18_adj_amt = Cast(RTrim(@col019) as money)
			,@L2100_5_cas19_adj_qty = @col020
		end
	
		SET @casLevel = @casLevel + 1
	end

	if ( RTrim(@col001) = 'NM1' AND @Col002 = 'TT' AND @curLoop = '2100' )
	begin
		SELECT
		 @L2100_nm103_TT_cob_carrier_nm = LTrim(RTrim(@col004))
		,@L2100_nm108_TT_cob_id_qual = LTrim(RTrim(@col009))
		,@L2100_nm109_TT_cob_id = LTrim(RTrim(@col010))
	end
	if ( RTrim(@col001) = 'NM1' AND @Col002 = 'PR' AND @curLoop = '2100' )
	begin
		SELECT
		 @L2100_nm103_PR_corrected_prty_payer_nm = LTrim(RTrim(@col004))
		,@L2100_nm108_PR_corrected_prty_payer_nm_id_qual = LTrim(RTrim(@col009))
		,@L2100_nm109_PR_corrected_prty_payer_nm_id = LTrim(RTrim(@col010))
	end
	if ( RTrim(@col001) = 'NM1' AND @Col002 = 'QC' AND @curLoop = '2100' )
	begin
		SELECT
		 @L2100_nm103_QC_patient_last_nm = LTrim(RTrim(@col004))
		,@L2100_nm104_QC_patient_first_nm = LTrim(RTrim(@col005))
		,@L2100_nm105_QC_patient_middle_nm = LTrim(RTrim(@col006))
		,@L2100_nm108_QC_patient_id_qual = LTrim(RTrim(@col009))
		,@L2100_nm109_QC_patient_id = LTrim(RTrim(@col010))
	end
	if ( RTrim(@col001) = 'NM1' AND @Col002 = 'IL' AND @curLoop = '2100' )
	begin
		SELECT
		 @L2100_nm103_IL_subscriber_last_nm = LTrim(RTrim(@col004))
		,@L2100_nm104_IL_subscriber_first_nm = LTrim(RTrim(@col005))
		,@L2100_nm105_IL_subscriber_middle_nm = LTrim(RTrim(@col006))
		,@L2100_nm108_IL_subscriber_id_qual = LTrim(RTrim(@col009))
		,@L2100_nm109_IL_subscriber_id = LTrim(RTrim(@col010))
	end
	if ( RTrim(@col001) = 'REF' AND @Col002 = 'EA' AND @curLoop = '2100' )
	begin
		set @L2100_ref02_EA_other_claim_ref_id = RTrim(@col003)
	end
	if ( RTrim(@col001) = 'REF' AND @Col002 = 'F8' AND @curLoop = '2100' )
	begin
		set @L2100_ref02_F8_other_claim_ref_id = RTrim(@col003)
	end
	if ( RTrim(@col001) = 'REF' AND @Col002 = 'BB' AND @curLoop = '2100' )
	begin
		set @L2100_ref02_BB_other_claim_ref_id = RTrim(@col003)
	end
	if ( RTrim(@col001) = 'REF' AND @Col002 = '9A' AND @curLoop = '2100' )
	begin
		set @L2100_ref02_9A_other_claim_ref_id = RTrim(@col003)
	end
	if ( RTrim(@col001) = 'REF' AND @Col002 = 'G1' AND @curLoop = '2100' )
	begin
		set @L2100_ref02_G1_other_claim_ref_id = RTrim(@col003)
	end
	if ( RTrim(@Col001) = 'DTM' AND LTRIM(RTRIM(@Col002)) = '050' AND @curLoop = '2100' )
	begin
		set @L2100_dtm02_050_received_date = LTRIM(RTRIM(@Col003))
	END
	-- this is the first CAS segment for this procedure line
	if ( RTrim(@col001) = 'CAS' AND @curLoop = '2110' )
	BEGIN 
		if ( @casLevel = 1 )
		begin
			SELECT
			 @L2110_1_cas01_adj_group_code = @Col002
			,@L2110_1_cas02_adj_reason_code = @Col003
			,@L2110_1_cas03_adj_amt = Cast(RTrim(@col004) as money)
			,@L2110_1_cas04_adj_qty = @col005
			,@L2110_1_cas05_adj_reason_code = @Col006
			,@L2110_1_cas06_adj_amt = Cast(RTrim(@col007) as money)
			,@L2110_1_cas07_adj_qty = @col008
			,@L2110_1_cas08_adj_reason_code = @Col009
			,@L2110_1_cas09_adj_amt = Cast(RTrim(@col010) as money)
			,@L2110_1_cas10_adj_qty = @col011
			,@L2110_1_cas11_adj_reason_code = @Col012
			,@L2110_1_cas12_adj_amt = Cast(RTrim(@col013) as money)
			,@L2110_1_cas13_adj_qty = @col014
			,@L2110_1_cas14_adj_reason_code = @Col015
			,@L2110_1_cas15_adj_amt = Cast(RTrim(@col016) as money)
			,@L2110_1_cas16_adj_qty = @col017
			,@L2110_1_cas17_adj_reason_code = @Col018
			,@L2110_1_cas18_adj_amt = Cast(RTrim(@col019) as money)
			,@L2110_1_cas19_adj_qty = @col020
		end
	-- this is the second CAS segment for this procedure line
		if (	@casLevel = 2 )
		begin
			SELECT
			 @L2110_2_cas01_adj_group_code = @Col002
			,@L2110_2_cas02_adj_reason_code = @Col003
			,@L2110_2_cas03_adj_amt = Cast(RTrim(@col004) as money)
			,@L2110_2_cas04_adj_qty = @col005
			,@L2110_2_cas05_adj_reason_code = @Col006
			,@L2110_2_cas06_adj_amt = Cast(RTrim(@col007) as money)
			,@L2110_2_cas07_adj_qty = @col008
			,@L2110_2_cas08_adj_reason_code = @Col009
			,@L2110_2_cas09_adj_amt = Cast(RTrim(@col010) as money)
			,@L2110_2_cas10_adj_qty = @col011
			,@L2110_2_cas11_adj_reason_code = @Col012
			,@L2110_2_cas12_adj_amt = Cast(RTrim(@col013) as money)
			,@L2110_2_cas13_adj_qty = @col014
			,@L2110_2_cas14_adj_reason_code = @Col015
			,@L2110_2_cas15_adj_amt = Cast(RTrim(@col016) as money)
			,@L2110_2_cas16_adj_qty = @col017
			,@L2110_2_cas17_adj_reason_code = @Col018
			,@L2110_2_cas18_adj_amt = Cast(RTrim(@col019) as money)
			,@L2110_2_cas19_adj_qty = @col020
		end

	-- this is the third CAS segment for this procedure line
		if (	@casLevel = 3 )
		begin
			SELECT
			 @L2110_3_cas01_adj_group_code = @Col002
			,@L2110_3_cas02_adj_reason_code = @Col003
			,@L2110_3_cas03_adj_amt = Cast(RTrim(@col004) as money)
			,@L2110_3_cas04_adj_qty = @col005
			,@L2110_3_cas05_adj_reason_code = @Col006
			,@L2110_3_cas06_adj_amt = Cast(RTrim(@col007) as money)
			,@L2110_3_cas07_adj_qty = @col008
			,@L2110_3_cas08_adj_reason_code = @Col009
			,@L2110_3_cas09_adj_amt = Cast(RTrim(@col010) as money)
			,@L2110_3_cas10_adj_qty = @col011
			,@L2110_3_cas11_adj_reason_code = @Col012
			,@L2110_3_cas12_adj_amt = Cast(RTrim(@col013) as money)
			,@L2110_3_cas13_adj_qty = @col014
			,@L2110_3_cas14_adj_reason_code = @Col015
			,@L2110_3_cas15_adj_amt = Cast(RTrim(@col016) as money)
			,@L2110_3_cas16_adj_qty = @col017
			,@L2110_3_cas17_adj_reason_code = @Col018
			,@L2110_3_cas18_adj_amt = Cast(RTrim(@col019) as money)
			,@L2110_3_cas19_adj_qty = @col020
		end

	-- this is the 4th CAS segment for this procedure line
		if (	@casLevel = 4 )
		begin
			select 
			 @L2110_4_cas01_adj_group_code = @Col002
			,@L2110_4_cas02_adj_reason_code = @Col003
			,@L2110_4_cas03_adj_amt = Cast(RTrim(@col004) as money)
			,@L2110_4_cas04_adj_qty = @col005
			,@L2110_4_cas05_adj_reason_code = @Col006
			,@L2110_4_cas06_adj_amt = Cast(RTrim(@col007) as money)
			,@L2110_4_cas07_adj_qty = @col008
			,@L2110_4_cas08_adj_reason_code = @Col009
			,@L2110_4_cas09_adj_amt = Cast(RTrim(@col010) as money)
			,@L2110_4_cas10_adj_qty = @col011
			,@L2110_4_cas11_adj_reason_code = @Col012
			,@L2110_4_cas12_adj_amt = Cast(RTrim(@col013) as money)
			,@L2110_4_cas13_adj_qty = @col014
			,@L2110_4_cas14_adj_reason_code = @Col015
			,@L2110_4_cas15_adj_amt = Cast(RTrim(@col016) as money)
			,@L2110_4_cas16_adj_qty = @col017
			,@L2110_4_cas17_adj_reason_code = @Col018
			,@L2110_4_cas18_adj_amt = Cast(RTrim(@col019) as money)
			,@L2110_4_cas19_adj_qty = @col020
		end

	-- this is the 5th CAS segment for this procedure line
		if (	@casLevel = 5 )
		begin
			SELECT
			 @L2110_5_cas01_adj_group_code = @Col002
			,@L2110_5_cas02_adj_reason_code = @Col003
			,@L2110_5_cas03_adj_amt = Cast(RTrim(@col004) as money)
			,@L2110_5_cas04_adj_qty = @col005
			,@L2110_5_cas05_adj_reason_code = @Col006
			,@L2110_5_cas06_adj_amt = Cast(RTrim(@col007) as money)
			,@L2110_5_cas07_adj_qty = @col008
			,@L2110_5_cas08_adj_reason_code = @Col009
			,@L2110_5_cas09_adj_amt = Cast(RTrim(@col010) as money)
			,@L2110_5_cas10_adj_qty = @col011
			,@L2110_5_cas11_adj_reason_code = @Col012
			,@L2110_5_cas12_adj_amt = Cast(RTrim(@col013) as money)
			,@L2110_5_cas13_adj_qty = @col014
			,@L2110_5_cas14_adj_reason_code = @Col015
			,@L2110_5_cas15_adj_amt = Cast(RTrim(@col016) as money)
			,@L2110_5_cas16_adj_qty = @col017
			,@L2110_5_cas17_adj_reason_code = @Col018
			,@L2110_5_cas18_adj_amt = Cast(RTrim(@col019) as money)
			,@L2110_5_cas19_adj_qty = @col020
		end
	
		SET @casLevel = @casLevel + 1
	END
	
	if ( RTrim(@col001) = 'LQ' AND @CurLoop = '2110')
	begin
		if ( @L2110_lq02_remark_code_04 IS NOT NULL)
			set @L2110_lq02_remark_code_05 = @Col003
		else if ( @L2110_lq02_remark_code_03 IS NOT NULL)
			set @L2110_lq02_remark_code_04 = @Col003
		else if ( @L2110_lq02_remark_code_02 IS NOT NULL)
			set @L2110_lq02_remark_code_03 = @Col003
		else if ( @L2110_lq02_remark_code_01 IS NOT NULL)
			set @L2110_lq02_remark_code_02 = @Col003
		else
			set @L2110_lq02_remark_code_01 = @Col003
	end
	FETCH NEXT FROM curt835 INTO @Col001, @Col002, @Col003, @Col004, @Col005, @Col006, @Col007, @Col008, @Col009, @Col010, @Col011, @Col012, @Col013, @Col014, @Col015, @Col016, @Col017, @Col018, @Col019, @Col020
END
CLOSE curt835
DEALLOCATE curt835
-- after going through the recordset, the last record must be inserted because we're done with the last service line in the file
			exec up_x12_835_insert
				@x12_transaction_id = @x12_transaction_id,
				@bpr01_trans_handling_code = @bpr01_trans_handling_code,
				@bpr02_total_prov_pmt_amt = @bpr02_total_prov_pmt_amt,
				@bpr03_credit_debit_flag_code = @bpr03_credit_debit_flag_code,
				@bpr04_payment_method_code = @bpr04_payment_method_code,
				@bpr05_payment_format_code = @bpr05_payment_format_code,
				@bpr06_sender_dfi_id_qual = @bpr06_sender_dfi_id_qual,
				@bpr07_sender_dfi_id = @bpr07_sender_dfi_id,
				@bpr08_sender_account_num_qual = @bpr08_sender_account_num_qual,
				@bpr09_sender_account_num = @bpr09_sender_account_num,
				@bpr10_payer_id = @bpr10_payer_id,
				@bpr11_orig_co_supp_code = @bpr11_orig_co_supp_code,
				@bpr12_receiver_dfi_id_qual = @bpr12_receiver_dfi_id_qual,
				@bpr13_receiver_dfi_id = @bpr13_receiver_dfi_id,
				@bpr14_receiver_account_num_qual = @bpr14_receiver_account_num_qual,
				@bpr15_receiver_account_num = @bpr15_receiver_account_num,
				@bpr16_check_date = @bpr16_check_date,
				@trn01_trace_type_code = @trn01_trace_type_code,
				@trn02_trace_number = @trn02_trace_number,
				@trn03_payer_id = @trn03_payer_id,
				@ref01_receiver_ref_id_qual = @ref01_receiver_ref_id_qual,
				@ref02_receiver_ref_id = @ref02_receiver_ref_id,
				@dtm02_production_date = @dtm02_production_date,
				@L1000A_n101_entity_id_code = @L1000A_n101_entity_id_code,
				@L1000A_n102_payer_nm = @L1000A_n102_payer_nm,
				@L1000A_n103_payer_id_qual = @L1000A_n103_payer_id_qual,
				@L1000A_n104_payer_id = @L1000A_n104_payer_id,
				@L1000A_n301_payer_address1 = @L1000A_n301_payer_address1,
				@L1000A_n302_payer_address2 = @L1000A_n302_payer_address2,
				@L1000A_n401_payer_city = @L1000A_n401_payer_city,
				@L1000A_n402_payer_state = @L1000A_n402_payer_state,
				@L1000A_n403_payer_zip = @L1000A_n403_payer_zip,
				@L1000A_ref01_ref_id_qual = @L1000A_ref01_ref_id_qual,
				@L1000A_ref02_add_payer_id = @L1000A_ref02_add_payer_id,
				@L1000A_per01_contact_function_code = @L1000A_per01_contact_function_code,
				@L1000A_per02_contact_nm = @L1000A_per02_contact_nm,
				@L1000A_per03_comm_num_qual = @L1000A_per03_comm_num_qual,
				@L1000A_per04_comm_number = @L1000A_per04_comm_number,
				@L1000B_n101_entity_id_code = @L1000B_n101_entity_id_code,
				@L1000B_n102_payee_nm = @L1000B_n102_payee_nm,
				@L1000B_n103_payee_id_qual = @L1000B_n103_payee_id_qual,
				@L1000B_n104_payee_id = @L1000B_n104_payee_id,
				@L1000B_n301_payee_address1 = @L1000B_n301_payee_address1,
				@L1000B_n302_payee_address2 = @L1000B_n302_payee_address2,
				@L1000B_n401_payee_city = @L1000B_n401_payee_city,
				@L1000B_n402_payee_state = @L1000B_n402_payee_state,
				@L1000B_n403_payee_zip = @L1000B_n403_payee_zip,
				@L1000B_ref01_ref_id_qual = @L1000B_ref01_ref_id_qual,
				@L1000B_ref02_add_payee_id = @L1000B_ref02_add_payee_id,
				@L2000_lx01_assigned_number = @L2000_lx01_assigned_number,
				@L2100_clp01_pt_control_no = @L2100_clp01_pt_control_no,
				@L2100_clp02_claim_status_code = @L2100_clp02_claim_status_code,
				@L2100_clp03_total_claim_chg_amt = @L2100_clp03_total_claim_chg_amt,
				@L2100_clp04_claim_pmt_amt = @L2100_clp04_claim_pmt_amt,
				@L2100_clp05_pt_resp_amt = @L2100_clp05_pt_resp_amt,
				@L2100_clp06_claim_filing_ind_code = @L2100_clp06_claim_filing_ind_code,
				@L2100_clp07_payer_claim_control_no = @L2100_clp07_payer_claim_control_no,
				@L2100_clp08_facility_type_code = @L2100_clp08_facility_type_code,
				@L2100_clp09_claim_freq_code = @L2100_clp09_claim_freq_code,
				@L2100_clp11_drg_code = @L2100_clp11_drg_code,
				@L2100_clp12_drg_weight = @L2100_clp12_drg_weight,
				@L2100_clp13_discharge_fraction = @L2100_clp13_discharge_fraction,
				
				@L2100_nm103_TT_cob_carrier_nm = @L2100_nm103_TT_cob_carrier_nm,
				@L2100_nm108_TT_cob_id_qual = @L2100_nm108_TT_cob_id_qual,
				@L2100_nm109_TT_cob_id = @L2100_nm109_TT_cob_id,
				@L2100_nm103_PR_corrected_prty_payer_nm = @L2100_nm103_PR_corrected_prty_payer_nm,
				@L2100_nm108_PR_corrected_prty_payer_nm_id_qual = @L2100_nm108_PR_corrected_prty_payer_nm_id_qual,
				@L2100_nm109_PR_corrected_prty_payer_nm_id = @L2100_nm109_PR_corrected_prty_payer_nm_id,
				@L2100_nm103_QC_patient_last_nm = @L2100_nm103_QC_patient_last_nm,
				@L2100_nm104_QC_patient_first_nm = @L2100_nm104_QC_patient_first_nm,
				@L2100_nm105_QC_patient_middle_nm = @L2100_nm105_QC_patient_middle_nm,
				@L2100_nm108_QC_patient_id_qual = @L2100_nm108_QC_patient_id_qual,
				@L2100_nm109_QC_patient_id = @L2100_nm109_QC_patient_id,
				@L2100_nm103_IL_subscriber_last_nm = @L2100_nm103_IL_subscriber_last_nm,
				@L2100_nm104_IL_subscriber_first_nm = @L2100_nm104_IL_subscriber_first_nm,
				@L2100_nm105_IL_subscriber_middle_nm = @L2100_nm105_IL_subscriber_middle_nm,
				@L2100_nm108_IL_subscriber_id_qual = @L2100_nm108_IL_subscriber_id_qual,
				@L2100_nm109_IL_subscriber_id = @L2100_nm109_IL_subscriber_id,
				@L2100_ref02_9A_other_claim_ref_id = @L2100_ref02_9A_other_claim_ref_id,
				@L2100_ref02_BB_other_claim_ref_id = @L2100_ref02_BB_other_claim_ref_id,
				@L2100_ref02_G1_other_claim_ref_id = @L2100_ref02_G1_other_claim_ref_id,
				@L2100_ref02_EA_other_claim_ref_id = @L2100_ref02_EA_other_claim_ref_id,
				@L2100_ref02_F8_other_claim_ref_id = @L2100_ref02_F8_other_claim_ref_id,
				@L2100_ref01_rend_prov_sec_ref_id_qual = @L2100_ref01_rend_prov_sec_ref_id_qual,
				@L2100_ref02_rend_prov_sec_ref_id = @L2100_ref02_rend_prov_sec_ref_id,
				@L2100_dtm02_036_expiration_date = @L2100_dtm02_036_expiration_date,
				@L2100_dtm02_050_received_date = @L2100_dtm02_050_received_date,
				@L2100_dtm02_232_stmt_start_date = @L2100_dtm02_232_stmt_start_date,
				@L2100_dtm02_233_stmt_end_date = @L2100_dtm02_233_stmt_end_date,
				@L2110_svc01_proc_code = @L2110_svc01_proc_code,
				@L2110_svc01_proc_mod1 = @L2110_svc01_proc_mod1,
				@L2110_svc01_proc_mod2 = @L2110_svc01_proc_mod2,
				@L2110_svc01_proc_mod3 = @L2110_svc01_proc_mod3,
				@L2110_svc01_proc_mod4 = @L2110_svc01_proc_mod4,
				@L2110_svc02_charge_amt = @L2110_svc02_charge_amt,
				@L2110_svc03_provider_pmt_amt = @L2110_svc03_provider_pmt_amt,
				@L2110_svc04_ub_rev_code = @L2110_svc04_ub_rev_code,
				@L2110_svc05_units_paid = @L2110_svc05_units_paid,
				@L2110_dtm02_150_service_date = @L2110_dtm02_150_service_date,
				@L2110_dtm02_151_service_date = @L2110_dtm02_151_service_date,
				@L2110_dtm02_472_service_date = @L2110_dtm02_472_service_date,
				@L2110_1_cas01_adj_group_code = @L2110_1_cas01_adj_group_code,
				@L2110_1_cas02_adj_reason_code = @L2110_1_cas02_adj_reason_code,
				@L2110_1_cas03_adj_amt = @L2110_1_cas03_adj_amt,
				@L2110_1_cas04_adj_qty = @L2110_1_cas04_adj_qty,
				@L2110_1_cas05_adj_reason_code = @L2110_1_cas05_adj_reason_code,
				@L2110_1_cas06_adj_amt = @L2110_1_cas06_adj_amt,
				@L2110_1_cas07_adj_qty = @L2110_1_cas07_adj_qty,
				@L2110_1_cas08_adj_reason_code = @L2110_1_cas08_adj_reason_code,
				@L2110_1_cas09_adj_amt = @L2110_1_cas09_adj_amt,
				@L2110_1_cas10_adj_qty = @L2110_1_cas10_adj_qty,
				@L2110_1_cas11_adj_reason_code = @L2110_1_cas11_adj_reason_code,
				@L2110_1_cas12_adj_amt = @L2110_1_cas12_adj_amt,
				@L2110_1_cas13_adj_qty = @L2110_1_cas13_adj_qty,
				@L2110_1_cas14_adj_reason_code = @L2110_1_cas14_adj_reason_code,
				@L2110_1_cas15_adj_amt = @L2110_1_cas15_adj_amt,
				@L2110_1_cas16_adj_qty = @L2110_1_cas16_adj_qty,
				@L2110_1_cas17_adj_reason_code = @L2110_1_cas17_adj_reason_code,
				@L2110_1_cas18_adj_amt = @L2110_1_cas18_adj_amt,
				@L2110_1_cas19_adj_qty = @L2110_1_cas19_adj_qty,
				@L2110_2_cas01_adj_group_code = @L2110_2_cas01_adj_group_code,
				@L2110_2_cas02_adj_reason_code = @L2110_2_cas02_adj_reason_code,
				@L2110_2_cas03_adj_amt = @L2110_2_cas03_adj_amt,
				@L2110_2_cas04_adj_qty = @L2110_2_cas04_adj_qty,
				@L2110_2_cas05_adj_reason_code = @L2110_2_cas05_adj_reason_code,
				@L2110_2_cas06_adj_amt = @L2110_2_cas06_adj_amt,
				@L2110_2_cas07_adj_qty = @L2110_2_cas07_adj_qty,
				@L2110_2_cas08_adj_reason_code = @L2110_2_cas08_adj_reason_code,
				@L2110_2_cas09_adj_amt = @L2110_2_cas09_adj_amt,
				@L2110_2_cas10_adj_qty = @L2110_2_cas10_adj_qty,
				@L2110_3_cas01_adj_group_code = @L2110_3_cas01_adj_group_code,
				@L2110_3_cas02_adj_reason_code = @L2110_3_cas02_adj_reason_code,
				@L2110_3_cas03_adj_amt = @L2110_3_cas03_adj_amt,
				@L2110_3_cas04_adj_qty = @L2110_3_cas04_adj_qty,
				@L2110_3_cas05_adj_reason_code = @L2110_3_cas05_adj_reason_code,
				@L2110_3_cas06_adj_amt = @L2110_3_cas06_adj_amt,
				@L2110_3_cas07_adj_qty = @L2110_3_cas07_adj_qty,
				@L2110_3_cas08_adj_reason_code = @L2110_3_cas08_adj_reason_code,
				@L2110_3_cas09_adj_amt = @L2110_3_cas09_adj_amt,
				@L2110_3_cas10_adj_qty = @L2110_3_cas10_adj_qty,
				@L2110_3_cas11_adj_reason_code = @L2110_3_cas11_adj_reason_code,
				@L2110_3_cas12_adj_amt = @L2110_3_cas12_adj_amt,
				@L2110_3_cas13_adj_qty = @L2110_3_cas13_adj_qty,
				@L2110_3_cas14_adj_reason_code = @L2110_3_cas14_adj_reason_code,
				@L2110_3_cas15_adj_amt = @L2110_3_cas15_adj_amt,
				@L2110_3_cas16_adj_qty = @L2110_3_cas16_adj_qty,
				@L2110_3_cas17_adj_reason_code = @L2110_3_cas17_adj_reason_code,
				@L2110_3_cas18_adj_amt = @L2110_3_cas18_adj_amt,
				@L2110_3_cas19_adj_qty = @L2110_3_cas19_adj_qty,
				@L2110_4_cas01_adj_group_code = @L2110_4_cas01_adj_group_code,
				@L2110_4_cas02_adj_reason_code = @L2110_4_cas02_adj_reason_code,
				@L2110_4_cas03_adj_amt = @L2110_4_cas03_adj_amt,
				@L2110_4_cas04_adj_qty = @L2110_4_cas04_adj_qty,
				@L2110_4_cas05_adj_reason_code = @L2110_4_cas05_adj_reason_code,
				@L2110_4_cas06_adj_amt = @L2110_4_cas06_adj_amt,
				@L2110_4_cas07_adj_qty = @L2110_4_cas07_adj_qty,
				@L2110_4_cas08_adj_reason_code = @L2110_4_cas08_adj_reason_code,
				@L2110_4_cas09_adj_amt = @L2110_4_cas09_adj_amt,
				@L2110_4_cas10_adj_qty = @L2110_4_cas10_adj_qty,
				@L2110_5_cas01_adj_group_code = @L2110_5_cas01_adj_group_code,
				@L2110_5_cas02_adj_reason_code = @L2110_5_cas02_adj_reason_code,
				@L2110_5_cas03_adj_amt = @L2110_5_cas03_adj_amt,
				@L2110_5_cas04_adj_qty = @L2110_5_cas04_adj_qty,
				@L2110_5_cas05_adj_reason_code = @L2110_5_cas05_adj_reason_code,
				@L2110_5_cas06_adj_amt = @L2110_5_cas06_adj_amt,
				@L2110_5_cas07_adj_qty = @L2110_5_cas07_adj_qty,
				@L2110_5_cas08_adj_reason_code = @L2110_5_cas08_adj_reason_code,
				@L2110_5_cas09_adj_amt = @L2110_5_cas09_adj_amt,
				@L2110_5_cas10_adj_qty = @L2110_5_cas10_adj_qty,
				@L2110_lq02_remark_code_01 = @L2110_lq02_remark_code_01,
				@L2110_lq02_remark_code_02 = @L2110_lq02_remark_code_02,
				@L2110_lq02_remark_code_03 = @L2110_lq02_remark_code_03,
				@L2110_lq02_remark_code_04 = @L2110_lq02_remark_code_04,
				@L2110_lq02_remark_code_05 = @L2110_lq02_remark_code_05,
				
				@L2100_1_cas01_adj_group_code =@L2100_1_cas01_adj_group_code ,
				@L2100_1_cas02_adj_reason_code =@L2100_1_cas02_adj_reason_code ,
				@L2100_1_cas03_adj_amt =@L2100_1_cas03_adj_amt ,
				@L2100_1_cas04_adj_qty =@L2100_1_cas04_adj_qty ,
				@L2100_1_cas05_adj_reason_code =@L2100_1_cas05_adj_reason_code ,
				@L2100_1_cas06_adj_amt =@L2100_1_cas06_adj_amt ,
				@L2100_1_cas07_adj_qty =@L2100_1_cas07_adj_qty ,
				@L2100_1_cas08_adj_reason_code =@L2100_1_cas08_adj_reason_code ,
				@L2100_1_cas09_adj_amt =@L2100_1_cas09_adj_amt ,
				@L2100_1_cas10_adj_qty =@L2100_1_cas10_adj_qty ,
				@L2100_1_cas11_adj_reason_code =@L2100_1_cas11_adj_reason_code ,
				@L2100_1_cas12_adj_amt =@L2100_1_cas12_adj_amt ,
				@L2100_1_cas13_adj_qty =@L2100_1_cas13_adj_qty ,
				@L2100_1_cas14_adj_reason_code =@L2100_1_cas14_adj_reason_code ,
				@L2100_1_cas15_adj_amt =@L2100_1_cas15_adj_amt ,
				@L2100_1_cas16_adj_qty =@L2100_1_cas16_adj_qty ,
				@L2100_1_cas17_adj_reason_code =@L2100_1_cas17_adj_reason_code ,
				@L2100_1_cas18_adj_amt =@L2100_1_cas18_adj_amt ,
				@L2100_1_cas19_adj_qty =@L2100_1_cas19_adj_qty ,
				@L2100_2_cas01_adj_group_code =@L2100_2_cas01_adj_group_code ,
				@L2100_2_cas02_adj_reason_code =@L2100_2_cas02_adj_reason_code ,
				@L2100_2_cas03_adj_amt =@L2100_2_cas03_adj_amt ,
				@L2100_2_cas04_adj_qty =@L2100_2_cas04_adj_qty ,
				@L2100_2_cas05_adj_reason_code =@L2100_2_cas05_adj_reason_code ,
				@L2100_2_cas06_adj_amt =@L2100_2_cas06_adj_amt ,
				@L2100_2_cas07_adj_qty =@L2100_2_cas07_adj_qty ,
				@L2100_2_cas08_adj_reason_code =@L2100_2_cas08_adj_reason_code ,
				@L2100_2_cas09_adj_amt =@L2100_2_cas09_adj_amt ,
				@L2100_2_cas10_adj_qty =@L2100_2_cas10_adj_qty ,
				@L2100_2_cas11_adj_reason_code =@L2100_2_cas11_adj_reason_code ,
				@L2100_2_cas12_adj_amt =@L2100_2_cas12_adj_amt ,
				@L2100_2_cas13_adj_qty =@L2100_2_cas13_adj_qty ,
				@L2100_2_cas14_adj_reason_code =@L2100_2_cas14_adj_reason_code ,
				@L2100_2_cas15_adj_amt =@L2100_2_cas15_adj_amt ,
				@L2100_2_cas16_adj_qty =@L2100_2_cas16_adj_qty ,
				@L2100_2_cas17_adj_reason_code =@L2100_2_cas17_adj_reason_code ,
				@L2100_2_cas18_adj_amt =@L2100_2_cas18_adj_amt ,
				@L2100_2_cas19_adj_qty =@L2100_2_cas19_adj_qty ,
				@L2100_3_cas01_adj_group_code =@L2100_3_cas01_adj_group_code ,
				@L2100_3_cas02_adj_reason_code =@L2100_3_cas02_adj_reason_code ,
				@L2100_3_cas03_adj_amt =@L2100_3_cas03_adj_amt ,
				@L2100_3_cas04_adj_qty =@L2100_3_cas04_adj_qty ,
				@L2100_3_cas05_adj_reason_code =@L2100_3_cas05_adj_reason_code ,
				@L2100_3_cas06_adj_amt =@L2100_3_cas06_adj_amt ,
				@L2100_3_cas07_adj_qty =@L2100_3_cas07_adj_qty ,
				@L2100_3_cas08_adj_reason_code =@L2100_3_cas08_adj_reason_code ,
				@L2100_3_cas09_adj_amt =@L2100_3_cas09_adj_amt ,
				@L2100_3_cas10_adj_qty =@L2100_3_cas10_adj_qty ,
				@L2100_3_cas11_adj_reason_code =@L2100_3_cas11_adj_reason_code ,
				@L2100_3_cas12_adj_amt =@L2100_3_cas12_adj_amt ,
				@L2100_3_cas13_adj_qty =@L2100_3_cas13_adj_qty ,
				@L2100_3_cas14_adj_reason_code =@L2100_3_cas14_adj_reason_code ,
				@L2100_3_cas15_adj_amt =@L2100_3_cas15_adj_amt ,
				@L2100_3_cas16_adj_qty =@L2100_3_cas16_adj_qty ,
				@L2100_3_cas17_adj_reason_code =@L2100_3_cas17_adj_reason_code ,
				@L2100_3_cas18_adj_amt =@L2100_3_cas18_adj_amt ,
				@L2100_3_cas19_adj_qty =@L2100_3_cas19_adj_qty ,
				@L2100_4_cas01_adj_group_code =@L2100_4_cas01_adj_group_code ,
				@L2100_4_cas02_adj_reason_code =@L2100_4_cas02_adj_reason_code ,
				@L2100_4_cas03_adj_amt =@L2100_4_cas03_adj_amt ,
				@L2100_4_cas04_adj_qty =@L2100_4_cas04_adj_qty ,
				@L2100_4_cas05_adj_reason_code =@L2100_4_cas05_adj_reason_code ,
				@L2100_4_cas06_adj_amt =@L2100_4_cas06_adj_amt ,
				@L2100_4_cas07_adj_qty =@L2100_4_cas07_adj_qty ,
				@L2100_4_cas08_adj_reason_code =@L2100_4_cas08_adj_reason_code ,
				@L2100_4_cas09_adj_amt =@L2100_4_cas09_adj_amt ,
				@L2100_4_cas10_adj_qty =@L2100_4_cas10_adj_qty ,
				@L2100_4_cas11_adj_reason_code =@L2100_4_cas11_adj_reason_code ,
				@L2100_4_cas12_adj_amt =@L2100_4_cas12_adj_amt ,
				@L2100_4_cas13_adj_qty =@L2100_4_cas13_adj_qty ,
				@L2100_4_cas14_adj_reason_code =@L2100_4_cas14_adj_reason_code ,
				@L2100_4_cas15_adj_amt =@L2100_4_cas15_adj_amt ,
				@L2100_4_cas16_adj_qty =@L2100_4_cas16_adj_qty ,
				@L2100_4_cas17_adj_reason_code =@L2100_4_cas17_adj_reason_code ,
				@L2100_4_cas18_adj_amt =@L2100_4_cas18_adj_amt ,
				@L2100_4_cas19_adj_qty =@L2100_4_cas19_adj_qty ,
				@L2100_5_cas01_adj_group_code =@L2100_5_cas01_adj_group_code ,
				@L2100_5_cas02_adj_reason_code =@L2100_5_cas02_adj_reason_code ,
				@L2100_5_cas03_adj_amt =@L2100_5_cas03_adj_amt ,
				@L2100_5_cas04_adj_qty =@L2100_5_cas04_adj_qty ,
				@L2100_5_cas05_adj_reason_code =@L2100_5_cas05_adj_reason_code ,
				@L2100_5_cas06_adj_amt =@L2100_5_cas06_adj_amt ,
				@L2100_5_cas07_adj_qty =@L2100_5_cas07_adj_qty ,
				@L2100_5_cas08_adj_reason_code =@L2100_5_cas08_adj_reason_code ,
				@L2100_5_cas09_adj_amt =@L2100_5_cas09_adj_amt ,
				@L2100_5_cas10_adj_qty =@L2100_5_cas10_adj_qty ,
				@L2100_5_cas11_adj_reason_code =@L2100_5_cas11_adj_reason_code ,
				@L2100_5_cas12_adj_amt =@L2100_5_cas12_adj_amt ,
				@L2100_5_cas13_adj_qty =@L2100_5_cas13_adj_qty ,
				@L2100_5_cas14_adj_reason_code =@L2100_5_cas14_adj_reason_code ,
				@L2100_5_cas15_adj_amt =@L2100_5_cas15_adj_amt ,
				@L2100_5_cas16_adj_qty =@L2100_5_cas16_adj_qty ,
				@L2100_5_cas17_adj_reason_code =@L2100_5_cas17_adj_reason_code ,
				@L2100_5_cas18_adj_amt =@L2100_5_cas18_adj_amt ,
				@L2100_5_cas19_adj_qty =@L2100_5_cas19_adj_qty ,
				@L2110_2_cas11_adj_reason_code =@L2110_2_cas11_adj_reason_code ,
				@L2110_2_cas12_adj_amt =@L2110_2_cas12_adj_amt ,
				@L2110_2_cas13_adj_qty =@L2110_2_cas13_adj_qty ,
				@L2110_2_cas14_adj_reason_code =@L2110_2_cas14_adj_reason_code ,
				@L2110_2_cas15_adj_amt =@L2110_2_cas15_adj_amt ,
				@L2110_2_cas16_adj_qty =@L2110_2_cas16_adj_qty ,
				@L2110_2_cas17_adj_reason_code =@L2110_2_cas17_adj_reason_code ,
				@L2110_2_cas18_adj_amt =@L2110_2_cas18_adj_amt ,
				@L2110_2_cas19_adj_qty =@L2110_2_cas19_adj_qty ,
				@L2110_4_cas11_adj_reason_code =@L2110_4_cas11_adj_reason_code ,
				@L2110_4_cas12_adj_amt =@L2110_4_cas12_adj_amt ,
				@L2110_4_cas13_adj_qty =@L2110_4_cas13_adj_qty ,
				@L2110_4_cas14_adj_reason_code =@L2110_4_cas14_adj_reason_code ,
				@L2110_4_cas15_adj_amt =@L2110_4_cas15_adj_amt ,
				@L2110_4_cas16_adj_qty =@L2110_4_cas16_adj_qty ,
				@L2110_4_cas17_adj_reason_code =@L2110_4_cas17_adj_reason_code ,
				@L2110_4_cas18_adj_amt =@L2110_4_cas18_adj_amt ,
				@L2110_4_cas19_adj_qty =@L2110_4_cas19_adj_qty ,
				@L2110_5_cas11_adj_reason_code =@L2110_5_cas11_adj_reason_code ,
				@L2110_5_cas12_adj_amt =@L2110_5_cas12_adj_amt ,
				@L2110_5_cas13_adj_qty =@L2110_5_cas13_adj_qty ,
				@L2110_5_cas14_adj_reason_code =@L2110_5_cas14_adj_reason_code ,
				@L2110_5_cas15_adj_amt =@L2110_5_cas15_adj_amt ,
				@L2110_5_cas16_adj_qty =@L2110_5_cas16_adj_qty ,
				@L2110_5_cas17_adj_reason_code =@L2110_5_cas17_adj_reason_code ,
				@L2110_5_cas18_adj_amt =@L2110_5_cas18_adj_amt ,
				@L2110_5_cas19_adj_qty =@L2110_5_cas19_adj_qty 
return (0)



