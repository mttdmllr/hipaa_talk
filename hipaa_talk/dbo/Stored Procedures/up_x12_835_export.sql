



CREATE Procedure [dbo].[up_x12_835_export] (@x12_transaction_id int = null, @segment_count int output)
AS

	-- Set the x12_interchange_uid value of the 835 transaction that's being exported.
	declare @x12_interchange_uid UNIQUEIDENTIFIER, @x12_interchange_uid_vchar VARCHAR(36), @isa16_component_element_seperator char(1)

	select	@x12_interchange_uid = x12_interchange_uid,
			@x12_interchange_uid_vchar = CAST(x12_interchange_uid AS VARCHAR(36)),
			@isa16_component_element_seperator = isa16_component_element_seperator
	from vw_x12_transaction
	where x12_transaction_id = @x12_transaction_id
	-- END: Initialize transaction variables.
	if (@isa16_component_element_seperator IS NULL OR @isa16_component_element_seperator = ' ')
	begin
		set @isa16_component_element_seperator = ':'
	END


	-- Make the temp table
	DECLARE @claims_to_export TABLE(
		ClaimIndex int IDENTITY(1,1) NOT NULL,
		x12_835_claim_payment_advice_id INT NOT null)
		
	INSERT INTO @claims_to_export
	SELECT x12_835_claim_payment_advice_id
	from x12_835_claim_payment_advice
	where	x12_transaction_id = @x12_transaction_id
	order by L2100_clp07_payer_claim_control_no, x12_835_claim_payment_advice_id
	
	SELECT i.ClaimIndex, data.*
	INTO #claim_data
	FROM @claims_to_export i JOIN dbo.x12_835_claim_payment_advice data ON i.x12_835_claim_payment_advice_id = data.x12_835_claim_payment_advice_id
	
	CREATE UNIQUE CLUSTERED INDEX idx_ClaimIndex ON #claim_data(ClaimIndex)
	
	DECLARE @export_lines table(
		ClaimIndex INT,
		ExportRecordIndex INT,
		[x12_parse_temp_uid] [uniqueidentifier] NULL,
		[Col001] [varchar](264) NULL,
		[Col002] [varchar](264) NULL,
		[Col003] [varchar](264) NULL,
		[Col004] [varchar](264) NULL,
		[Col005] [varchar](264) NULL,
		[Col006] [varchar](264) NULL,
		[Col007] [varchar](264) NULL,
		[Col008] [varchar](264) NULL,
		[Col009] [varchar](264) NULL,
		[Col010] [varchar](264) NULL,
		[Col011] [varchar](264) NULL,
		[Col012] [varchar](264) NULL,
		[Col013] [varchar](264) NULL,
		[Col014] [varchar](264) NULL,
		[Col015] [varchar](264) NULL,
		[Col016] [varchar](264) NULL,
		[Col017] [varchar](264) NULL,
		[Col018] [varchar](264) NULL,
		[Col019] [varchar](264) NULL,
		[Col020] [varchar](264) NULL,
		[Col021] [varchar](264) NULL,
		[Col022] [varchar](264) NULL,
		[Col023] [varchar](264) NULL,
		[Col024] [varchar](264) NULL,
		[Col025] [varchar](264) NULL,
		[filename] [varchar](512) NULL)



	-- ======================
	-- BEGIN Being worked on by the first pair
	-- ======================
		-- =========================
		-- BEGIN 2100 AMT AU Segment
		-- =========================			
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 28,
		@x12_interchange_uid_vchar,  'AMT',
		'DY',
		CASE when data.L2100_amt02_AU_claim_supp_info_amt = 0 then '0' else dbo.fn_trim_leading_zero(LTRIM(RTRIM(cast(data.L2100_amt02_AU_claim_supp_info_amt as varchar(255))))) end
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	where (data.L2100_amt02_AU_claim_supp_info_amt IS NOT NULL)
    AND ( data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR prev.L2100_clp07_payer_claim_control_no IS NULL)	
		-- =========================
		-- END 2100 AMT AU Segment
		-- =========================
		
		-- =========================
		-- BEGIN 2100 AMT D8 Segment
		-- =========================			
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 29,
		@x12_interchange_uid_vchar,  'AMT',
		'D8',
		CASE when data.L2100_amt02_D8_claim_supp_info_amt = 0 then '0' else dbo.fn_trim_leading_zero(LTRIM(RTRIM(cast(data.L2100_amt02_D8_claim_supp_info_amt as varchar(255))))) end
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	where (data.L2100_amt02_D8_claim_supp_info_amt IS NOT NULL)
    AND ( data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR prev.L2100_clp07_payer_claim_control_no IS NULL)	
		-- =========================
		-- END 2100 AMT D8 Segment
		-- =========================

		-- =========================
		-- BEGIN 2100 AMT DY Segment
		-- =========================			
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 30,
		@x12_interchange_uid_vchar,  'AMT',
		'DY',
		CASE when data.L2100_amt02_DY_claim_supp_info_amt = 0 then '0' else dbo.fn_trim_leading_zero(LTRIM(RTRIM(cast(data.L2100_amt02_DY_claim_supp_info_amt as varchar(255))))) end
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	where (data.L2100_amt02_DY_claim_supp_info_amt IS NOT NULL)
    AND ( data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR prev.L2100_clp07_payer_claim_control_no IS NULL)	
		-- =========================
		-- END 2100 AMT DY Segment
		-- =========================

		-- =========================
		-- BEGIN 2100 AMT F5 Segment
		-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT  data.ClaimIndex, 31,
		@x12_interchange_uid_vchar,  'AMT',
		'F5',
		CASE when data.L2100_amt02_F5_claim_supp_info_amt = 0 then '0' else dbo.fn_trim_leading_zero(LTRIM(RTRIM(cast(data.L2100_amt02_F5_claim_supp_info_amt as varchar(255))))) end
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	where (data.L2100_amt02_F5_claim_supp_info_amt IS NOT NULL)
    AND ( data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR prev.L2100_clp07_payer_claim_control_no IS NULL)	
		-- =========================
		-- END 2100 AMT F5 Segment
		-- =========================

		-- =========================
		-- BEGIN 2100 AMT I Segment
		-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 32,
		@x12_interchange_uid_vchar,  'AMT',
		'I',
		CASE when data.L2100_amt02_I_claim_supp_info_amt = 0 then '0' else dbo.fn_trim_leading_zero(LTRIM(RTRIM(cast(data.L2100_amt02_I_claim_supp_info_amt as varchar(255))))) end
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	where (data.L2100_amt02_I_claim_supp_info_amt IS NOT NULL)
    AND ( data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR prev.L2100_clp07_payer_claim_control_no IS NULL)	
		-- =========================
		-- END 2100 AMT I Segment
		-- =========================

		-- =========================
		-- BEGIN 2100 AMT NL Segment
		-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 33,
		@x12_interchange_uid_vchar,  'AMT',
		'NL',
		CASE when data.L2100_amt02_NL_claim_supp_info_amt = 0 then '0' else dbo.fn_trim_leading_zero(LTRIM(RTRIM(cast(data.L2100_amt02_NL_claim_supp_info_amt as varchar(255))))) end
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	where (data.L2100_amt02_NL_claim_supp_info_amt IS NOT NULL)
    AND ( data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR prev.L2100_clp07_payer_claim_control_no IS NULL)	
		-- =========================
		-- END 2100 AMT NL Segment
		-- =========================

		-- =========================
		-- BEGIN 2100 AMT T Segment
		-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 34,
		@x12_interchange_uid_vchar,  'AMT',
		'T',
		CASE when data.L2100_amt02_T_claim_supp_info_amt = 0 then '0' else dbo.fn_trim_leading_zero(LTRIM(RTRIM(cast(data.L2100_amt02_T_claim_supp_info_amt as varchar(255))))) end
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	where (data.L2100_amt02_T_claim_supp_info_amt IS NOT NULL)
    AND ( data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR prev.L2100_clp07_payer_claim_control_no IS NULL)	
		-- =========================
		-- END 2100 AMT T Segment
		-- =========================

		-- =========================
		-- BEGIN 2100 AMT T2 Segment
		-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 35,
		@x12_interchange_uid_vchar,  'AMT',
		'T2',
		CASE when data.L2100_amt02_T2_claim_supp_info_amt = 0 then '0' else dbo.fn_trim_leading_zero(LTRIM(RTRIM(cast(data.L2100_amt02_T2_claim_supp_info_amt as varchar(255))))) end
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	where (data.L2100_amt02_T2_claim_supp_info_amt IS NOT NULL)
    AND ( data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR prev.L2100_clp07_payer_claim_control_no IS NULL)	
		-- =========================
		-- END 2100 AMT T2 Segment
		-- =========================

		-- =========================
		-- BEGIN 2100 AMT ZK Segment
		-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 36,
		@x12_interchange_uid_vchar,  'AMT',
		'ZK',
		CASE when data.L2100_amt02_ZK_claim_supp_info_amt = 0 then '0' else dbo.fn_trim_leading_zero(LTRIM(RTRIM(cast(data.L2100_amt02_ZK_claim_supp_info_amt as varchar(255))))) end
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	where (data.L2100_amt02_ZK_claim_supp_info_amt IS NOT NULL)
    AND ( data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR prev.L2100_clp07_payer_claim_control_no IS NULL)	
		-- =========================
		-- END 2100 AMT ZK Segment
		-- =========================
		
		-- =========================
		-- BEGIN 2100 AMT ZL Segment
		-- =========================		
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 37,
		@x12_interchange_uid_vchar,  'AMT',
		'ZL',
		CASE when data.L2100_amt02_ZL_claim_supp_info_amt = 0 then '0' else dbo.fn_trim_leading_zero(LTRIM(RTRIM(cast(data.L2100_amt02_ZL_claim_supp_info_amt as varchar(255))))) end
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	where (data.L2100_amt02_ZL_claim_supp_info_amt IS NOT NULL)
    AND ( data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR prev.L2100_clp07_payer_claim_control_no IS NULL)	
		-- =========================
		-- END 2100 AMT ZL Segment
		-- =========================
		
		-- =========================
		-- BEGIN 2100 AMT ZM Segment
		-- =========================		
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 38,
		@x12_interchange_uid_vchar,  'AMT',
		'ZM',
		CASE when data.L2100_amt02_ZM_claim_supp_info_amt = 0 then '0' else dbo.fn_trim_leading_zero(LTRIM(RTRIM(cast(data.L2100_amt02_ZM_claim_supp_info_amt as varchar(255))))) end
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	where (data.L2100_amt02_ZM_claim_supp_info_amt IS NOT NULL)
    AND ( data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR prev.L2100_clp07_payer_claim_control_no IS NULL)	
		-- =========================
		-- END 2100 AMT ZM Segment
		-- =========================
		
		-- =========================
		-- BEGIN 2100 AMT ZN Segment
		-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 39,
		@x12_interchange_uid_vchar,  'AMT',
		'ZN',
		CASE when data.L2100_amt02_ZN_claim_supp_info_amt = 0 then '0' else dbo.fn_trim_leading_zero(LTRIM(RTRIM(cast(data.L2100_amt02_ZN_claim_supp_info_amt as varchar(255))))) end
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	where (data.L2100_amt02_ZN_claim_supp_info_amt IS NOT NULL)
    AND ( data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR prev.L2100_clp07_payer_claim_control_no IS NULL)	
		-- =========================
		-- END 2100 AMT ZN Segment
		-- =========================
		
		-- =========================
		-- BEGIN 2100 AMT ZO Segment
		-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 40,
		@x12_interchange_uid_vchar,  'AMT',
		'Z0',
		CASE when data.L2100_amt02_ZO_claim_supp_info_amt = 0 then '0' else dbo.fn_trim_leading_zero(LTRIM(RTRIM(cast(data.L2100_amt02_ZO_claim_supp_info_amt as varchar(255))))) end
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	where (data.L2100_amt02_ZO_claim_supp_info_amt IS NOT NULL)
    AND ( data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR prev.L2100_clp07_payer_claim_control_no IS NULL)	
		-- =========================
		-- END 2100 AMT ZO Segment
		-- =========================
		
		-- =========================
		-- BEGIN 2100 AMT ZZ Segment
		-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 41,
		@x12_interchange_uid_vchar,  'AMT',
		'ZZ',
		CASE when data.L2100_amt02_ZZ_claim_supp_info_amt = 0 then '0' else dbo.fn_trim_leading_zero(LTRIM(RTRIM(cast(data.L2100_amt02_ZZ_claim_supp_info_amt as varchar(255))))) END
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	where (data.L2100_amt02_ZZ_claim_supp_info_amt IS NOT NULL)
    AND ( data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR prev.L2100_clp07_payer_claim_control_no IS NULL)	
		-- =========================
		-- END 2100 AMT ZZ Segment
		-- =========================

		-- =========================
		-- BEGIN 2110 SVC Segment
		-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col008)
	SELECT data.ClaimIndex, 42,
		@x12_interchange_uid_vchar,  'SVC',
		UPPER(LTrim(RTrim(dbo.fn_ListAppend(
		                    dbo.fn_ListAppend(
		                      dbo.fn_ListAppend(
		                        dbo.fn_ListAppend(
		                          dbo.fn_ListAppend(
		                            dbo.fn_ListPrepend(null, LTrim(RTrim(
										 CASE WHEN Len(IsNull(data.L2110_svc01_proc_code, '')) = 0 AND data.L2110_svc04_ub_rev_code IS NOT NULL THEN 'NU' ELSE 'HC' end
		                             )), @isa16_component_element_seperator),
		                                 CASE	WHEN Len(IsNull(data.L2110_svc01_proc_code, '')) = 0 AND data.L2110_svc04_ub_rev_code IS NOT NULL 
												THEN CASE	WHEN Len(LTrim(RTrim(IsNull(data.L2110_svc01_proc_code, data.L2110_svc04_ub_rev_code)))) = 3 
															THEN '0'+IsNull(data.L2110_svc01_proc_code, data.L2110_svc04_ub_rev_code) 
															ELSE IsNull(data.L2110_svc01_proc_code, data.L2110_svc04_ub_rev_code)END 
												ELSE data.L2110_svc01_proc_code END,
										@isa16_component_element_seperator),
										LTrim(RTrim(data.L2110_svc01_proc_mod1)), @isa16_component_element_seperator),
										LTrim(RTrim(data.L2110_svc01_proc_mod2)), @isa16_component_element_seperator),
										LTrim(RTrim(data.L2110_svc01_proc_mod3)), @isa16_component_element_seperator),
										LTrim(RTrim(data.L2110_svc01_proc_mod4)), @isa16_component_element_seperator)))),
		CASE when IsNull(data.L2110_svc02_charge_amt, 0) = 0 then '0' else dbo.fn_trim_leading_zero(cast (data.L2110_svc02_charge_amt as varchar(255))) end, 
		CASE when IsNull(data.L2110_svc03_provider_pmt_amt, 0) = 0 then '0' else dbo.fn_trim_leading_zero(cast (data.L2110_svc03_provider_pmt_amt as varchar(255))) end, 
		CASE when Len(IsNull(data.L2110_svc01_proc_code, '')) = 0 AND data.L2110_svc04_ub_rev_code IS NOT NULL THEN NULL ELSE CASE	WHEN Len(LTrim(RTrim(data.L2110_svc04_ub_rev_code))) = 3 
															THEN '0'+UPPER(LTrim(RTrim(data.L2110_svc04_ub_rev_code))) ELSE UPPER(LTrim(RTrim(data.L2110_svc04_ub_rev_code))) END END,
		UPPER(LTrim(RTrim(data.L2110_svc05_units_paid))),
		null,
		null
    FROM #claim_data AS data
	where data.L2110_svc01_proc_code IS NOT NULL OR data.L2110_svc04_ub_rev_code IS NOT NULL
		-- =========================
		-- END 2110 SVC Segment
		-- =========================



	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010, col011, col012, col013, col014, col015, col016, col017, col018, col019, col020)
	SELECT data.ClaimIndex, 46,
		@x12_interchange_uid_vchar,  'CAS',
		UPPER(LTRIM(RTRIM(data.L2110_1_cas01_adj_group_code))),
		UPPER(LTRIM(RTRIM(data.L2110_1_cas02_adj_reason_code))),
		CASE when data.L2110_1_cas03_adj_amt = 0 then '0' else dbo.fn_trim_leading_zero(cast (data.L2110_1_cas03_adj_amt as varchar(255))) end, 
		data.L2110_1_cas04_adj_qty, 
		UPPER(LTRIM(RTRIM(data.L2110_1_cas05_adj_reason_code))),
		CASE when data.L2110_1_cas06_adj_amt = 0 then '0' else dbo.fn_trim_leading_zero(cast (data.L2110_1_cas06_adj_amt as varchar(255))) end, 
		data.L2110_1_cas07_adj_qty, 
		UPPER(LTRIM(RTRIM(data.L2110_1_cas08_adj_reason_code))),
		CASE when data.L2110_1_cas09_adj_amt = 0 then '0' else dbo.fn_trim_leading_zero(cast (data.L2110_1_cas09_adj_amt as varchar(255))) end,
		data.L2110_1_cas10_adj_qty,
		UPPER(LTRIM(RTRIM(data.L2110_1_cas11_adj_reason_code))),
		CASE when data.L2110_1_cas12_adj_amt = 0 then '0' else dbo.fn_trim_leading_zero(cast (data.L2110_1_cas12_adj_amt as varchar(255))) end,
		data.L2110_1_cas13_adj_qty,
		UPPER(LTRIM(RTRIM(data.L2110_1_cas14_adj_reason_code))),
		CASE when data.L2110_1_cas15_adj_amt = 0 then '0' else dbo.fn_trim_leading_zero(cast (data.L2110_1_cas15_adj_amt as varchar(255))) end,
		data.L2110_1_cas16_adj_qty,
		UPPER(LTRIM(RTRIM(data.L2110_1_cas17_adj_reason_code))),
		CASE when data.L2110_1_cas18_adj_amt = 0 then '0' else dbo.fn_trim_leading_zero(cast (data.L2110_1_cas18_adj_amt as varchar(255))) end,
		data.L2110_1_cas19_adj_qty
    FROM #claim_data AS data
	where data.L2110_1_cas01_adj_group_code  IS NOT NULL
	AND ( IsNull(data.L2110_svc02_charge_amt, 0) <> IsNull(data.L2110_svc03_provider_pmt_amt, 0) )

	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010, col011, col012, col013, col014, col015, col016, col017, col018, col019, col020)
	SELECT data.ClaimIndex, 47,
		@x12_interchange_uid_vchar,  'CAS',
		UPPER(LTRIM(RTRIM(data.L2110_2_cas01_adj_group_code))),
		UPPER(LTRIM(RTRIM(data.L2110_2_cas02_adj_reason_code))),
		CASE when data.L2110_2_cas03_adj_amt = 0 then '0' else dbo.fn_trim_leading_zero(cast (data.L2110_2_cas03_adj_amt as varchar(255))) end, 
		data.L2110_2_cas04_adj_qty, 
		UPPER(LTRIM(RTRIM(data.L2110_2_cas05_adj_reason_code))),
		CASE when data.L2110_2_cas06_adj_amt = 0 then '0' else dbo.fn_trim_leading_zero(cast (data.L2110_2_cas06_adj_amt as varchar(255))) end, 
		data.L2110_2_cas07_adj_qty, 
		UPPER(LTRIM(RTRIM(data.L2110_2_cas08_adj_reason_code))),
		CASE when data.L2110_2_cas09_adj_amt = 0 then '0' else dbo.fn_trim_leading_zero(cast (data.L2110_2_cas09_adj_amt as varchar(255))) end,
		data.L2110_2_cas10_adj_qty,
		null,
		cast (null as varchar(255)),
		null,
		null,
		cast (null as varchar(255)),
		null,
		null,
		cast (null as varchar(255)),
		null
    FROM #claim_data AS data
	where data.L2110_2_cas01_adj_group_code  IS NOT NULL
	AND ( IsNull(data.L2110_svc02_charge_amt, 0) <> IsNull(data.L2110_svc03_provider_pmt_amt, 0) )
	

	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010, col011, col012, col013, col014, col015, col016, col017, col018, col019, col020)
	SELECT data.ClaimIndex, 48,
		@x12_interchange_uid_vchar,  'CAS',
		UPPER(LTRIM(RTRIM(data.L2110_3_cas01_adj_group_code))),
		UPPER(LTRIM(RTRIM(data.L2110_3_cas02_adj_reason_code))),
		CASE when data.L2110_3_cas03_adj_amt = 0 then '0' else dbo.fn_trim_leading_zero(cast (data.L2110_3_cas03_adj_amt as varchar(255))) end, 
		data.L2110_3_cas04_adj_qty, 
		UPPER(LTRIM(RTRIM(data.L2110_3_cas05_adj_reason_code))),
		CASE when data.L2110_3_cas06_adj_amt = 0 then '0' else dbo.fn_trim_leading_zero(cast (data.L2110_3_cas06_adj_amt as varchar(255))) end, 
		data.L2110_3_cas07_adj_qty, 
		UPPER(LTRIM(RTRIM(data.L2110_3_cas08_adj_reason_code))),
		CASE when data.L2110_3_cas09_adj_amt = 0 then '0' else dbo.fn_trim_leading_zero(cast (data.L2110_3_cas09_adj_amt as varchar(255))) end,
		data.L2110_3_cas10_adj_qty,
		UPPER(LTRIM(RTRIM(data.L2110_3_cas11_adj_reason_code))),
		CASE when data.L2110_3_cas12_adj_amt = 0 then '0' else dbo.fn_trim_leading_zero(cast (data.L2110_3_cas12_adj_amt as varchar(255))) end,
		data.L2110_3_cas13_adj_qty,
		UPPER(LTRIM(RTRIM(data.L2110_3_cas14_adj_reason_code))),
		CASE when data.L2110_3_cas15_adj_amt = 0 then '0' else dbo.fn_trim_leading_zero(cast (data.L2110_3_cas15_adj_amt as varchar(255))) end,
		data.L2110_3_cas16_adj_qty,
		UPPER(LTRIM(RTRIM(data.L2110_3_cas17_adj_reason_code))),
		CASE when data.L2110_3_cas18_adj_amt = 0 then '0' else dbo.fn_trim_leading_zero(cast (data.L2110_3_cas18_adj_amt as varchar(255))) end,
		data.L2110_3_cas19_adj_qty
    FROM #claim_data AS data
	where data.L2110_3_cas01_adj_group_code  IS NOT NULL
	AND ( IsNull(data.L2110_svc02_charge_amt, 0) <> IsNull(data.L2110_svc03_provider_pmt_amt, 0) )
	
	
	
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010, col011, col012, col013, col014, col015, col016, col017, col018, col019, col020)
	SELECT data.ClaimIndex, 49,
		@x12_interchange_uid_vchar,  'CAS',
		UPPER(LTRIM(RTRIM(data.L2110_4_cas01_adj_group_code))),
		UPPER(LTRIM(RTRIM(data.L2110_4_cas02_adj_reason_code))),
		CASE when data.L2110_4_cas03_adj_amt = 0 then '0' else dbo.fn_trim_leading_zero(cast (data.L2110_4_cas03_adj_amt as varchar(255))) end, 
		data.L2110_4_cas04_adj_qty, 
		UPPER(LTRIM(RTRIM(data.L2110_4_cas05_adj_reason_code))),
		CASE when data.L2110_4_cas06_adj_amt = 0 then '0' else dbo.fn_trim_leading_zero(cast (data.L2110_4_cas06_adj_amt as varchar(255))) end, 
		data.L2110_4_cas07_adj_qty, 
		UPPER(LTRIM(RTRIM(data.L2110_4_cas08_adj_reason_code))),
		CASE when data.L2110_4_cas09_adj_amt = 0 then '0' else dbo.fn_trim_leading_zero(cast (data.L2110_4_cas09_adj_amt as varchar(255))) end,
		data.L2110_4_cas10_adj_qty,
		UPPER(LTRIM(RTRIM(null))),
		cast (null as varchar(255)),
		null,
		UPPER(LTRIM(RTRIM(null))),
		cast (null as varchar(255)),
		null,
		UPPER(LTRIM(RTRIM(null))),
		cast (null as varchar(255)),
		null
    FROM #claim_data AS data
	where data.L2110_4_cas01_adj_group_code IS NOT NULL
	AND ( IsNull(data.L2110_svc02_charge_amt, 0) <> IsNull(data.L2110_svc03_provider_pmt_amt, 0) )
	
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010, col011, col012, col013, col014, col015, col016, col017, col018, col019, col020)
	SELECT data.ClaimIndex, 50,
		@x12_interchange_uid_vchar,  'CAS',
		UPPER(LTRIM(RTRIM(data.L2110_5_cas01_adj_group_code))),
		UPPER(LTRIM(RTRIM(data.L2110_5_cas02_adj_reason_code))),
		CASE when data.L2110_5_cas03_adj_amt = 0 then '0' else dbo.fn_trim_leading_zero(cast (data.L2110_5_cas03_adj_amt as varchar(255))) end, 
		data.L2110_5_cas04_adj_qty, 
		UPPER(LTRIM(RTRIM(data.L2110_5_cas05_adj_reason_code))),
		CASE when data.L2110_5_cas06_adj_amt = 0 then '0' else dbo.fn_trim_leading_zero(cast (data.L2110_5_cas06_adj_amt as varchar(255))) end, 
		data.L2110_5_cas07_adj_qty, 
		UPPER(LTRIM(RTRIM(data.L2110_5_cas08_adj_reason_code))),
		CASE when data.L2110_5_cas09_adj_amt = 0 then '0' else dbo.fn_trim_leading_zero(cast (data.L2110_5_cas09_adj_amt as varchar(255))) end,
		data.L2110_5_cas10_adj_qty,
		null,
		cast (null as varchar(255)),
		null,
		null,
		cast (null as varchar(255)),
		null,
		null,
		cast (null as varchar(255)),
 		null
    FROM #claim_data AS data
	where data.L2110_5_cas01_adj_group_code  IS NOT NULL
	AND ( IsNull(data.L2110_svc02_charge_amt, 0) <> IsNull(data.L2110_svc03_provider_pmt_amt, 0) )

	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 51,
		@x12_interchange_uid_vchar,  'REF',
		UPPER(LTRIM(RTRIM(data.L2110_ref01_service_ref_id_qual))),
		UPPER(LTRIM(RTRIM(data.L2110_ref02_service_ref_id)))
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	where Len(LTrim(RTrim(IsNull(data.L2110_ref02_service_ref_id, '')))) > 0 AND data.L2110_ref01_service_ref_id_qual IS NOT NULL
	AND (	data.L2110_ref01_service_ref_id_qual <> prev.L2110_ref01_service_ref_id_qual OR
		data.L2110_ref02_service_ref_id <> prev.L2110_ref02_service_ref_id OR
		data.L2110_ref01_rend_prov_ref_id_qual <> prev.L2110_ref01_rend_prov_ref_id_qual OR
		data.L2110_ref02_rend_prov_ref_id <> prev.L2110_ref02_rend_prov_ref_id OR
			prev.L2110_ref01_service_ref_id_qual IS NULL)
			
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 52,
		@x12_interchange_uid_vchar,  'REF',
		UPPER(LTRIM(RTRIM(data.L2110_ref01_rend_prov_ref_id_qual))),
		UPPER(LTRIM(RTRIM(data.L2110_ref02_rend_prov_ref_id)))
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	where Len(LTrim(RTrim(IsNull(data.L2110_ref02_rend_prov_ref_id, '')))) > 0 AND data.L2110_ref01_rend_prov_ref_id_qual IS NOT NULL
	AND (	data.L2110_ref01_service_ref_id_qual <> prev.L2110_ref01_service_ref_id_qual OR
		data.L2110_ref02_service_ref_id <> prev.L2110_ref02_service_ref_id OR
		data.L2110_ref01_rend_prov_ref_id_qual <> prev.L2110_ref01_rend_prov_ref_id_qual OR
		data.L2110_ref02_rend_prov_ref_id <> prev.L2110_ref02_rend_prov_ref_id OR
			prev.L2110_ref01_service_ref_id_qual IS NULL)
	
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 53,
		@x12_interchange_uid_vchar,  'LQ',
		'HE',
		UPPER(LTRIM(RTRIM(L2110_lq02_remark_code_01)))
    FROM #claim_data AS data
	where Len(LTrim(RTrim(IsNull(L2110_lq02_remark_code_01, '')))) > 0
	
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 54,
		@x12_interchange_uid_vchar,  'LQ',
		'HE',
		UPPER(LTRIM(RTRIM(L2110_lq02_remark_code_02)))
    FROM #claim_data AS data
	where Len(LTrim(RTrim(IsNull(L2110_lq02_remark_code_02, '')))) > 0
	
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 55,
		@x12_interchange_uid_vchar,  'LQ',
		'HE',
		UPPER(LTRIM(RTRIM(L2110_lq02_remark_code_03)))
    FROM #claim_data AS data
	where Len(LTrim(RTrim(IsNull(L2110_lq02_remark_code_03, '')))) > 0
	
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 56,
		@x12_interchange_uid_vchar,  'LQ',
		'HE',
		UPPER(LTRIM(RTRIM(L2110_lq02_remark_code_04)))
    FROM #claim_data AS data
	where Len(LTrim(RTrim(IsNull(L2110_lq02_remark_code_04, '')))) > 0
	
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 57,
		@x12_interchange_uid_vchar,  'LQ',
		'HE',
		UPPER(LTRIM(RTRIM(L2110_lq02_remark_code_05)))
    FROM #claim_data AS data
	where Len(LTrim(RTrim(IsNull(L2110_lq02_remark_code_05, '')))) > 0
	
	
	-- ======================
	-- END worked on by the first pair
	-- ======================





	-- ======================
	-- BEGIN Being worked on by the second pair
	-- ======================

	-- ======================
	-- 1000A N3
	-- ======================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex, x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 6,
		@x12_interchange_uid_vchar,  'N3',
		UPPER(LTRIM(RTRIM(data.L1000A_n301_payer_address1))),
		UPPER(LTRIM(RTRIM(data.L1000A_n302_payer_address2)))
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	WHERE (data.L1000A_n101_entity_id_code <> prev.L1000A_n101_entity_id_code OR 
		data.L1000A_n102_payer_nm <> prev.L1000A_n102_payer_nm OR
		data.L1000A_n103_payer_id_qual <> prev.L1000A_n103_payer_id_qual OR
		data.L1000A_n104_payer_id <> prev.L1000A_n104_payer_id OR
		prev.L1000A_n101_entity_id_code IS NULL)
		AND data.L1000A_n301_payer_address1 IS NOT NULL


	-- ======================
	-- 1000A N1
	-- ======================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex, x12_parse_temp_uid, col001, col002, col003, col004, col005)
	SELECT data.ClaimIndex, 5,
		@x12_interchange_uid_vchar, 'N1',
		'PR',
		UPPER(LTRIM(RTRIM(REPLACE(data.L1000A_n102_payer_nm, @isa16_component_element_seperator, '')))),
		UPPER(LTRIM(RTRIM(data.L1000A_n103_payer_id_qual))),
		UPPER(LTRIM(RTRIM(data.L1000A_n104_payer_id)))
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	WHERE (data.L1000A_n101_entity_id_code <> prev.L1000A_n101_entity_id_code OR 
		data.L1000A_n102_payer_nm <> prev.L1000A_n102_payer_nm OR
		data.L1000A_n103_payer_id_qual <> prev.L1000A_n103_payer_id_qual OR
		data.L1000A_n104_payer_id <> prev.L1000A_n104_payer_id OR
		prev.L1000A_n101_entity_id_code IS NULL)
		AND REPLACE(data.L1000A_n102_payer_nm, @isa16_component_element_seperator, '') IS NOT NULL


	-- ======================
	-- 1000A N4
	-- ======================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex, x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007)
	SELECT data.ClaimIndex, 7,
		@x12_interchange_uid_vchar,  'N4',
		UPPER(LTRIM(RTRIM(data.L1000A_n401_payer_city))),
		UPPER(LTRIM(RTRIM(data.L1000A_n402_payer_state))),
		REPLACE(UPPER(LTRIM(RTRIM(data.L1000A_n403_payer_zip))), '-', ''),
		null,
		null,
		null
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	WHERE (data.L1000A_n101_entity_id_code <> prev.L1000A_n101_entity_id_code OR 
		data.L1000A_n102_payer_nm <> prev.L1000A_n102_payer_nm OR
		data.L1000A_n103_payer_id_qual <> prev.L1000A_n103_payer_id_qual OR
		data.L1000A_n104_payer_id <> prev.L1000A_n104_payer_id OR
		prev.L1000A_n101_entity_id_code IS NULL)
		AND data.L1000A_n401_payer_city IS NOT NULL


	-- ======================
	-- 1000A REF
	-- ======================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 8,
		@x12_interchange_uid_vchar,  'REF',
		UPPER(LTRIM(RTRIM(IsNull(data.L1000A_ref01_ref_id_qual, 'EO')))),
		UPPER(LTRIM(RTRIM(data.L1000A_ref02_add_payer_id)))
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	WHERE (data.L1000A_n101_entity_id_code <> prev.L1000A_n101_entity_id_code OR 
		data.L1000A_n102_payer_nm <> prev.L1000A_n102_payer_nm OR
		data.L1000A_n103_payer_id_qual <> prev.L1000A_n103_payer_id_qual OR
		data.L1000A_n104_payer_id <> prev.L1000A_n104_payer_id OR
		prev.L1000A_n101_entity_id_code IS NULL)
		AND data.L1000A_ref02_add_payer_id IS NOT NULL
		AND Len(LTrim(RTrim(IsNull(data.L1000A_ref02_add_payer_id, '')))) > 0


	-- ======================
	-- 1000B N3
	-- ======================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 10,
		@x12_interchange_uid_vchar,  'N3',
		UPPER(LTRIM(RTRIM(data.L1000B_n301_payee_address1))),
		UPPER(LTRIM(RTRIM(data.L1000B_n302_payee_address2)))
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	WHERE (data.L1000B_n102_payee_nm <> prev.L1000B_n102_payee_nm OR
		data.L1000B_n103_payee_id_qual <> prev.L1000B_n103_payee_id_qual OR
		data.L1000B_n104_payee_id <> prev.L1000B_n104_payee_id OR
		prev.L1000B_n101_entity_id_code IS NULL)
		AND data.L1000B_n301_payee_address1 IS NOT NULL

	-- =========================
	-- 1000B N1
	-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003, col004, col005)	
	SELECT data.ClaimIndex, 9,
		@x12_interchange_uid_vchar, 'N1',
		'PE',
		UPPER(LTRIM(RTRIM(REPLACE(data.L1000B_n102_payee_nm, @isa16_component_element_seperator, '')))),
		UPPER(LTRIM(RTRIM(data.L1000B_n103_payee_id_qual))),
		UPPER(LTRIM(RTRIM(data.L1000B_n104_payee_id)))
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	WHERE (REPLACE(data.L1000B_n102_payee_nm, @isa16_component_element_seperator, '') <> REPLACE(prev.L1000B_n102_payee_nm, @isa16_component_element_seperator, '') OR
		data.L1000B_n103_payee_id_qual <> prev.L1000B_n103_payee_id_qual OR
		data.L1000B_n104_payee_id <> prev.L1000B_n104_payee_id OR
		prev.L1000B_n101_entity_id_code IS NULL)
		AND REPLACE(data.L1000B_n102_payee_nm, @isa16_component_element_seperator, '') IS NOT NULL

	-- =========================
	-- 1000B N4
	-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007)
	SELECT data.ClaimIndex, 11,
		@x12_interchange_uid_vchar,  'N4',
		UPPER(LTRIM(RTRIM(data.L1000B_n401_payee_city))),
		UPPER(LTRIM(RTRIM(data.L1000B_n402_payee_state))),
		REPLACE(UPPER(LTRIM(RTRIM(data.L1000B_n403_payee_zip))), '-', ''),
		NULL,
		NULL,
		NULL
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	WHERE (data.L1000B_n102_payee_nm <> prev.L1000B_n102_payee_nm OR
		data.L1000B_n103_payee_id_qual <> prev.L1000B_n103_payee_id_qual OR
		data.L1000B_n104_payee_id <> prev.L1000B_n104_payee_id OR
		prev.L1000B_n101_entity_id_code IS NULL)
		AND data.L1000B_n401_payee_city IS NOT NULL


	-- =========================
	-- 1000B REF
	-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 12,
		@x12_interchange_uid_vchar,  'REF',
		'TJ',
		UPPER(LTRIM(RTRIM(data.L1000B_ref02_add_payee_id)))
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	WHERE (data.L1000B_n102_payee_nm <> prev.L1000B_n102_payee_nm OR
		data.L1000B_n103_payee_id_qual <> prev.L1000B_n103_payee_id_qual OR
		data.L1000B_n104_payee_id <> prev.L1000B_n104_payee_id OR
		prev.L1000B_n101_entity_id_code IS NULL)
		AND data.L1000B_ref02_add_payee_id IS NOT NULL


	-- =========================
	-- 2110 DTM for Service Period Start, when 150 date is different from 151 date
	-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)	
	SELECT data.ClaimIndex, 43,
		@x12_interchange_uid_vchar, 'DTM', '150',
		data.L2110_dtm02_150_service_date
    FROM #claim_data AS data
	WHERE (data.L2110_svc01_proc_code IS NOT NULL OR data.L2110_svc04_ub_rev_code IS NOT NULL)
		AND data.L2110_dtm02_150_service_date <> data.L2110_dtm02_151_service_date
		AND data.L2110_dtm02_150_service_date IS NOT NULL


	-- =========================
	-- 2110 DTM for Service Period End, when 150 date is different from 151 date
	-- =========================
	
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)	
	SELECT data.ClaimIndex, 44,
		@x12_interchange_uid_vchar, 'DTM', '151',
		data.L2110_dtm02_151_service_date
    FROM #claim_data AS data
	WHERE (data.L2110_svc01_proc_code IS NOT NULL OR data.L2110_svc04_ub_rev_code IS NOT NULL)
		AND data.L2110_dtm02_150_service_date <> data.L2110_dtm02_151_service_date
		AND data.L2110_dtm02_151_service_date IS NOT NULL
	

	-- =========================
	-- 2110 DTM for Service Day (150 date = 151 date)
	-- =========================
	
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)	
	SELECT data.ClaimIndex, 45,
		@x12_interchange_uid_vchar, 'DTM', '472',
		CASE WHEN data.L2110_dtm02_150_service_date = data.L2110_dtm02_151_service_date AND data.L2110_dtm02_472_service_date IS NULL
			THEN data.L2110_dtm02_150_service_date 
			ELSE data.L2110_dtm02_472_service_date 
		END
    FROM #claim_data AS data
	WHERE (data.L2110_svc01_proc_code IS NOT NULL OR data.L2110_svc04_ub_rev_code IS NOT NULL)
		AND ISNULL(data.L2110_dtm02_150_service_date, 3) = ISNULL(data.L2110_dtm02_151_service_date, 3)
	
	
	-- =========================
	-- 2000 TS3 Segment
	-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003, col004, col005, col007)	
	SELECT data.ClaimIndex, 14,
		@x12_interchange_uid_vchar, 'TS3',
		data.L2000_ts301_provider_identifier,							
		data.L2000_ts302_facility_type_code,
		data.L2000_ts303_fiscal_period_date,
		data.L2000_ts304_total_claim_count,
		Cast(data.L2000_ts306_total_covered_charge_amount as Varchar(255) )
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	WHERE (data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR
		prev.L2100_clp07_payer_claim_control_no IS NULL)
		AND (data.L2000_ts301_provider_identifier <> prev.L2000_ts301_provider_identifier OR
			data.L2000_ts302_facility_type_code <> prev.L2000_ts302_facility_type_code OR
			data.L2000_ts303_fiscal_period_date <> prev.L2000_ts303_fiscal_period_date OR
			data.L2000_ts304_total_claim_count <> prev.L2000_ts304_total_claim_count OR
			data.L2000_ts306_total_covered_charge_amount <> prev.L2000_ts306_total_covered_charge_amount OR
			prev.L2000_ts301_provider_identifier IS NULL)
		AND data.L2000_ts301_provider_identifier IS NOT NULL

	-- =========================
	-- 2100 CLP Segment
	-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex, x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010, col012, col013, col014)	
	SELECT data.ClaimIndex, 15,
		@x12_interchange_uid_vchar,  'CLP',
		 data.L2100_clp01_pt_control_no,
		 rtrim(data.L2100_clp02_claim_status_code), 
		 case when data.L2100_clp03_total_claim_chg_amt = 0 then '0'
			else dbo.fn_trim_leading_zero(cast(data.L2100_clp03_total_claim_chg_amt as varchar(255))) end, 
		 case when data.L2100_clp04_claim_pmt_amt = 0 then '0'
			else dbo.fn_trim_leading_zero(cast (data.L2100_clp04_claim_pmt_amt as varchar(255))) end, 
		 case when data.L2100_clp05_pt_resp_amt = 0 then null
			else dbo.fn_trim_leading_zero(cast(data.L2100_clp05_pt_resp_amt as varchar(255))) end, 
		 data.L2100_clp06_claim_filing_ind_code, 
		 data.L2100_clp07_payer_claim_control_no, 
		 data.L2100_clp08_facility_type_code, 
		 data.L2100_clp09_claim_freq_code, 
		 data.L2100_clp11_drg_code, 
		 case when data.L2100_clp12_drg_weight = '0' then null
			else dbo.fn_trim_leading_zero(cast (data.L2100_clp12_drg_weight as varchar(255))) end, 
		 data.L2100_clp13_discharge_fraction
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	WHERE data.L2100_clp01_pt_control_no IS NOT NULL
	AND (data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR
		prev.L2100_clp07_payer_claim_control_no IS NULL)

	-- =========================
	-- 2100 NM1-QC Segment
	-- =========================
	INSERT INTO @export_lines (ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010)
	SELECT data.ClaimIndex, 16,
		CAST(@x12_interchange_uid as varchar(36)),
		'NM1',
		'QC',
		CASE WHEN data.L2100_nm104_QC_patient_first_nm IS NOT NULL AND data.L2100_nm103_QC_patient_last_nm IS NOT NULL THEN '1'
			WHEN data.L2100_nm104_QC_patient_first_nm IS NULL AND data.L2100_nm103_QC_patient_last_nm IS NOT NULL THEN '2'
			ELSE UPPER(LTRIM(RTRIM(data.L2100_nm102_entity_type_qual))) END,
		UPPER(LTRIM(RTRIM(data.L2100_nm103_QC_patient_last_nm))), 
		UPPER(LTRIM(RTRIM(data.L2100_nm104_QC_patient_first_nm))),
		NULL,
		NULL,
		NULL,
		UPPER(LTRIM(RTRIM(data.L2100_nm108_QC_patient_id_qual))),
		UPPER(LTRIM(RTRIM(data.L2100_nm109_QC_patient_id)))
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	WHERE (data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR
		prev.L2100_clp07_payer_claim_control_no IS NULL)

	-- =========================
	-- 2100 NM1-IL Segment
	-- =========================
	INSERT INTO @export_lines (ClaimIndex, ExportRecordIndex, x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010)
	SELECT data.ClaimIndex, 17,
		@x12_interchange_uid_vchar,
		'NM1',
		'IL',
		CASE WHEN data.L2100_nm104_IL_subscriber_first_nm IS NOT NULL AND data.L2100_nm103_IL_subscriber_last_nm IS NOT NULL THEN '1'
			WHEN data.L2100_nm104_IL_subscriber_first_nm IS NULL AND data.L2100_nm105_IL_subscriber_middle_nm IS NULL AND data.L2100_nm103_IL_subscriber_last_nm IS NOT NULL THEN '2'
			ELSE UPPER(LTRIM(RTRIM(data.L2100_nm102_entity_type_qual))) END,
		UPPER(LTRIM(RTRIM(data.L2100_nm103_IL_subscriber_last_nm))), 
		UPPER(LTRIM(RTRIM(data.L2100_nm104_IL_subscriber_first_nm))),
		UPPER(LTRIM(RTRIM(data.L2100_nm105_IL_subscriber_middle_nm))),
		NULL,
		NULL,
		UPPER(LTRIM(RTRIM(data.L2100_nm108_IL_subscriber_id_qual))),
		UPPER(LTRIM(RTRIM(data.L2100_nm109_IL_subscriber_id)))
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	WHERE (data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR
		prev.L2100_clp07_payer_claim_control_no IS NULL)
	AND data.L2100_nm109_IL_subscriber_id <> data.L2100_nm109_QC_patient_id

	-- =========================
	-- 2100 MIA Segment
	-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,
						x12_parse_temp_uid,
						col001,	col002,	col003,	col004,	col005,
						col006,	col007,	col008,	col009,	col010,
						col011,	col012,	col013,	col014,	col015,
						col016,	col017,	col018,	col019,	col020,
						col021,	col022,	col023,	col024,col025)
	SELECT data.ClaimIndex, 18,
		@x12_interchange_uid_vchar,
		'MIA',
		CAST(data.L2100_mia01_covered_days_or_visits_count as varchar(255)),
		case	when data.L2100_mia02_pps_operating_outlier_amt = 0 then '0'
				else dbo.fn_trim_leading_zero(data.L2100_mia02_pps_operating_outlier_amt)
		end, 
		CAST(data.L2100_mia03_lifetime_psy_days_count as varchar(255)),
		case	when data.L2100_mia04_claim_drg_amt = 0 then '0'
				else dbo.fn_trim_leading_zero(data.L2100_mia04_claim_drg_amt)
		end, 
		CAST(data.L2100_mia05_remark_code as varchar(255)),
		case	when data.L2100_mia06_disp_share_amt = 0 then '0'
				else dbo.fn_trim_leading_zero(data.L2100_mia06_disp_share_amt)
		end, 
		case	when data.L2100_mia07_claim_MSP_pass_through_amt = 0 then '0'
				else dbo.fn_trim_leading_zero(data.L2100_mia07_claim_MSP_pass_through_amt)
		end, 
		case	when data.L2100_mia08_claim_PPS_capital_amt = 0 then '0'
				else dbo.fn_trim_leading_zero(data.L2100_mia08_claim_PPS_capital_amt)
		end, 
		case	when data.L2100_mia09_PPS_capital_FSP_drg_amt = 0 then '0'
				else dbo.fn_trim_leading_zero(data.L2100_mia09_PPS_capital_FSP_drg_amt)
		end, 
		case	when data.L2100_mia10_PPS_capital_HSP_drg_amt = 0 then '0'
				else dbo.fn_trim_leading_zero(data.L2100_mia10_PPS_capital_HSP_drg_amt)
		end, 
		case	when data.L2100_mia11_PPS_capital_DSH_drg_amt = 0 then '0'
				else dbo.fn_trim_leading_zero(data.L2100_mia11_PPS_capital_DSH_drg_amt)
		end, 
		case	when data.L2100_mia12_old_capital_amt = 0 then '0'
				else dbo.fn_trim_leading_zero(data.L2100_mia12_old_capital_amt)
		end, 
		case	when data.L2100_mia13_PPS_capital_IME_amt = 0 then '0'
				else dbo.fn_trim_leading_zero(data.L2100_mia13_PPS_capital_IME_amt)
		end, 
		case	when data.L2100_mia14_PPS_operating_hosp_spec_DRG_amt = 0 then '0'
				else dbo.fn_trim_leading_zero(data.L2100_mia14_PPS_operating_hosp_spec_DRG_amt)
		end, 
		CAST(data.L2100_mia15_cost_rpt_day_count as varchar(255)),
		case	when data.L2100_mia16_PPS_operating_fed_spec_DRG_amt = 0 then '0'
				else dbo.fn_trim_leading_zero(data.L2100_mia16_PPS_operating_fed_spec_DRG_amt)
		end, 
		case	when data.L2100_mia17_claim_PPS_capital_outlier_amt = 0 then '0'
				else dbo.fn_trim_leading_zero(data.L2100_mia17_claim_PPS_capital_outlier_amt)
		end, 
		case	when data.L2100_mia18_claim_indirect_teaching_amt = 0 then '0'
				else dbo.fn_trim_leading_zero(data.L2100_mia18_claim_indirect_teaching_amt)
		end, 
		case	when data.L2100_mia19_nonpayable_prof_component_amt = 0 then '0'
				else dbo.fn_trim_leading_zero(data.L2100_mia19_nonpayable_prof_component_amt)
		end, 
		CAST(data.L2100_mia20_remark_code as varchar(255)),
		CAST(data.L2100_mia21_remark_code as varchar(255)),
		CAST(data.L2100_mia22_remark_code as varchar(255)),
		CAST(data.L2100_mia23_remark_code as varchar(255)),
		case	when data.L2100_mia24_PPS_capital_exception_amt = 0 then '0'
				else dbo.fn_trim_leading_zero(data.L2100_mia24_PPS_capital_exception_amt)
		end
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	WHERE data.L2100_mia01_covered_days_or_visits_count is not NULL
	AND (data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR
		prev.L2100_clp07_payer_claim_control_no IS NULL)

	-- =========================
	-- 2100 DTM 036
	-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex, x12_parse_temp_uid, col001, col002, col003)	
	SELECT data.ClaimIndex, 24,
		@x12_interchange_uid, 'DTM', '036',
		data.L2100_dtm02_036_expiration_date
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	WHERE data.L2100_dtm02_036_expiration_date IS NOT NULL
	AND (data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR
		prev.L2100_clp07_payer_claim_control_no IS NULL)

	-- =========================
	-- 2100 DTM 050
	-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex, x12_parse_temp_uid, col001, col002, col003)	
	SELECT data.ClaimIndex, 25,
		@x12_interchange_uid_vchar, 'DTM', '050',
		data.L2100_dtm02_050_received_date
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	WHERE data.L2100_dtm02_050_received_date IS NOT NULL
	AND (data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR
		prev.L2100_clp07_payer_claim_control_no IS NULL)

	-- =========================
	-- 2100 DTM 232
	-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex, x12_parse_temp_uid, col001, col002, col003)	
	SELECT data.ClaimIndex, 26,
		@x12_interchange_uid, 'DTM', '232',
		data.L2100_dtm02_232_stmt_start_date
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	WHERE data.L2100_dtm02_232_stmt_start_date IS NOT NULL
	AND (data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR
		prev.L2100_clp07_payer_claim_control_no IS NULL)

	-- =========================
	-- 2100 DTM 233
	-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex, x12_parse_temp_uid, col001, col002, col003)	
	SELECT data.ClaimIndex, 27,
		@x12_interchange_uid, 'DTM', '233',
		data.L2100_dtm02_233_stmt_end_date
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	WHERE data.L2100_dtm02_233_stmt_end_date IS NOT NULL
	AND (data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR
		prev.L2100_clp07_payer_claim_control_no IS NULL)

	-- =========================
	-- Header BPR
	-- =========================
	INSERT INTO @export_lines (ClaimIndex, ExportRecordIndex, x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010, col011, col012, col013, col014, col015, col016,  col017 )
	SELECT data.ClaimIndex, 1,
			@x12_interchange_uid_vchar, 'BPR',
			 rtrim(data.bpr01_trans_handling_code), 
			 case when data.bpr02_total_prov_pmt_amt = 0 then '0' 
				else cast(data.bpr02_total_prov_pmt_amt as varchar(255)) end,
			 data.bpr03_credit_debit_flag_code,
			 data.bpr04_payment_method_code,
			 data.bpr05_payment_format_code,
			 data.bpr06_sender_dfi_id_qual,
			 data.bpr07_sender_dfi_id,
			 data.bpr08_sender_account_num_qual,
			 data.bpr09_sender_account_num,
			 data.bpr10_payer_id,
			 data.bpr11_orig_co_supp_code,
			 data.bpr12_receiver_dfi_id_qual,
			 data.bpr13_receiver_dfi_id,
			 data.bpr14_receiver_account_num_qual,
			 data.bpr15_receiver_account_num,
			 data.bpr16_check_date
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	WHERE prev.bpr01_trans_handling_code IS NULL AND data.bpr01_trans_handling_code IS NOT NULL

	-- =========================
	-- Header TRN
	-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex, x12_parse_temp_uid, col001, col002, col003, col004)	
	SELECT data.ClaimIndex, 2,
		@x12_interchange_uid_vchar, 'TRN', '1',
		data.trn02_trace_number,
 		data.trn03_payer_id
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	WHERE prev.bpr01_trans_handling_code IS NULL AND data.bpr01_trans_handling_code IS NOT NULL

	-- =========================
	-- Header REF
	-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex, x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 3,
		@x12_interchange_uid_vchar,  'REF',
		UPPER(LTRIM(RTRIM(IsNull(data.ref01_receiver_ref_id_qual, 'EV')))),
		UPPER(LTRIM(RTRIM(data.ref02_receiver_ref_id)))
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	WHERE prev.bpr01_trans_handling_code IS NULL AND data.bpr01_trans_handling_code IS NOT NULL
	AND Len(LTrim(RTrim(IsNull(data.ref02_receiver_ref_id, '')))) > 0 AND data.ref01_receiver_ref_id_qual IS NOT NULL

	-- =========================
	-- Header DTM
	-- =========================
	INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex, x12_parse_temp_uid, col001, col002, col003)
	SELECT data.ClaimIndex, 4,
		@x12_interchange_uid_vchar, 'DTM', '405',
		data.dtm02_production_date
    FROM #claim_data AS data
		LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
	WHERE prev.bpr01_trans_handling_code IS NULL AND data.bpr01_trans_handling_code IS NOT NULL
	AND data.dtm02_production_date IS NOT NULL


	-- ======================
	-- END worked on by the second pair
	-- ======================





	-- ======================
	-- BEGIN Being worked on by the third pair
	-- ======================


		-- =========================
		-- BEGIN 2000 LX Segment
		-- =========================
			INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex, x12_parse_temp_uid, col001, col002)	
			SELECT 	data.ClaimIndex, 13, @x12_interchange_uid_vchar, 'LX', ROW_NUMBER() OVER(ORDER BY data.ClaimIndex)
			FROM #claim_data AS data
				LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
			WHERE data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no
				OR	prev.L2100_clp07_payer_claim_control_no IS NULL
			
		-- =========================
		-- END 2000 LX Segment
		-- =========================
		
		
		
		-- =========================
		-- END 2100 REF Segment
		-- =========================
		-- 2100 Loop REF 9A segment
		
		INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
		SELECT data.ClaimIndex, 19,
		@x12_interchange_uid_vchar,  'REF',
		'9A',
		UPPER(LTRIM(RTRIM(data.L2100_ref02_9A_other_claim_ref_id)))
		FROM #claim_data AS data
			LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
		WHERE Len(LTrim(RTrim(IsNull(data.L2100_ref02_9A_other_claim_ref_id, '')))) > 0 AND (
		data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR
		prev.L2100_clp07_payer_claim_control_no IS NULL
		)
	
		INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
		SELECT data.ClaimIndex, 20,
		@x12_interchange_uid_vchar,  'REF',
		'BB',
		UPPER(LTRIM(RTRIM(data.L2100_ref02_BB_other_claim_ref_id)))
		FROM #claim_data AS data
			LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
		WHERE Len(LTrim(RTrim(IsNull(data.L2100_ref02_BB_other_claim_ref_id, '')))) > 0 AND (
		data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR
		prev.L2100_clp07_payer_claim_control_no IS NULL
		)
	
		INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
		SELECT data.ClaimIndex, 21,
		@x12_interchange_uid_vchar,  'REF',
		'G1',
		UPPER(LTRIM(RTRIM(data.L2100_ref02_G1_other_claim_ref_id)))
		FROM #claim_data AS data
			LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
		WHERE Len(LTrim(RTrim(IsNull(data.L2100_ref02_G1_other_claim_ref_id, '')))) > 0 AND (
		data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR
		prev.L2100_clp07_payer_claim_control_no IS NULL
		)
	
		INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
		SELECT data.ClaimIndex, 22,
		@x12_interchange_uid_vchar,  'REF',
		'EA',
		UPPER(LTRIM(RTRIM(data.L2100_ref02_EA_other_claim_ref_id)))
		FROM #claim_data AS data
			LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
		WHERE Len(LTrim(RTrim(IsNull(data.L2100_ref02_EA_other_claim_ref_id, '')))) > 0 AND (
		data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR
		prev.L2100_clp07_payer_claim_control_no IS NULL
		)
	
	
		INSERT INTO @export_lines(ClaimIndex, ExportRecordIndex,x12_parse_temp_uid, col001, col002, col003)
		SELECT data.ClaimIndex, 22,
		@x12_interchange_uid_vchar,  'REF',
		'F8',
		UPPER(LTRIM(RTRIM(data.L2100_ref02_F8_other_claim_ref_id)))
		FROM #claim_data AS data
			LEFT JOIN #claim_data prev ON data.ClaimIndex = prev.ClaimIndex + 1
		WHERE Len(LTrim(RTrim(IsNull(data.L2100_ref02_F8_other_claim_ref_id, '')))) > 0 AND (
		data.L2100_clp07_payer_claim_control_no <> prev.L2100_clp07_payer_claim_control_no OR
		prev.L2100_clp07_payer_claim_control_no IS NULL
		)

	
	
	
		-- =========================
		-- END 2100 REF Segment
		-- =========================
		
		
	-- ======================
	-- END worked on by the third pair
	-- ======================
	



-- ===================
-- BEGIN copy the results from our variable to the destination
-- ===================

INSERT INTO x12_parse_temp([x12_parse_temp_uid] ,[Col001] ,[Col002] ,[Col003] ,[Col004] ,[Col005] ,[Col006] ,[Col007] ,[Col008] ,[Col009] ,[Col010] ,[Col011] ,[Col012] ,[Col013] ,[Col014] ,[Col015] ,[Col016] ,[Col017] ,[Col018] ,[Col019] ,[Col020] ,[Col021] ,[Col022] ,[Col023] ,[Col024] ,[Col025] ,[filename])
SELECT                     [x12_parse_temp_uid] ,[Col001] ,[Col002] ,[Col003] ,[Col004] ,[Col005] ,[Col006] ,[Col007] ,[Col008] ,[Col009] ,[Col010] ,[Col011] ,[Col012] ,[Col013] ,[Col014] ,[Col015] ,[Col016] ,[Col017] ,[Col018] ,[Col019] ,[Col020] ,[Col021] ,[Col022] ,[Col023] ,[Col024] ,[Col025] ,[filename]
FROM @export_lines
ORDER BY ClaimIndex, ExportRecordIndex

-- ===================
-- BEGIN copy the results from our variable to the destination
-- ===================

DROP TABLE #claim_data


-- Count up all the segments we just inserted, exclude the transaction header segments
select @segment_count = count(x12_parse_temp_id)
from x12_parse_temp
where	col001 NOT IN ('ISA', 'GS', 'ST', 'IEA', 'GE', 'SE') AND
	x12_parse_temp_uid = @x12_interchange_uid

return (0)

