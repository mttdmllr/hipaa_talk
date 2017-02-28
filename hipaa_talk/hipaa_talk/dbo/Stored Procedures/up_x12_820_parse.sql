

CREATE Procedure [dbo].[up_x12_820_parse] ( @x12_transaction_id int = null, @se01_num_transaction_segments int = null output)
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

declare @CheckDate datetime
declare @CheckNo varchar(30)
declare @ReceiverNM varchar(60)
declare @ReceiverID varchar(80)
declare @PayerNM varchar(60)
declare @PayerID varchar(80)
declare @TotalPmt money
--declare @curmem varchar(15)
declare @curpmt money
declare @curRateGroup char(1)
declare @curPERC char(2)
declare @curPHP char(4)
declare @curFIPS char(3)
declare @cureffdate datetime
declare @curtermdate datetime
declare @errmsg varchar(250)
declare @errcode int
declare @x12_parse_temp_id_start int
declare @x12_parse_temp_id_end int
declare @isa16_component_element_seperator char(1)
declare @x12_interchange_uid uniqueidentifier

declare @curLoop varchar(10)
declare @L2100B_nm101_entity_id_code char(3)
declare @L2100B_nm102_entity_type_qual char(1)
declare @L2100B_nm103_individual_last_nm varchar(35)
declare @L2100B_nm104_individual_first_nm varchar(25)
declare @L2100B_nm105_individual_middle_nm varchar(25)
declare @L2100B_nm106_individual_prefix varchar(10)
declare @L2100B_nm107_individual_suffix varchar(10)
declare @L2100B_nm108_individual_id_code_qual char(2)
declare @L2100B_nm109_individual_id varchar(80)

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

DECLARE curt820 SCROLL CURSOR FOR
	select Col001, Col002, Col003, Col004, Col005, Col006, Col007, Col008, Col009, Col010, Col011, Col012, Col013, Col014, Col015, Col016, Col017
	from x12_parse_temp
	where	x12_parse_temp_id BETWEEN @x12_parse_temp_id_start AND @x12_parse_temp_id_end
		AND x12_parse_temp_uid = @x12_interchange_uid
	order by x12_parse_temp_id

OPEN curt820

FETCH NEXT FROM curt820 INTO @Col001, @Col002, @Col003, @Col004, @Col005, @Col006, @Col007, @Col008, @Col009, @Col010, @Col011, @Col012, @Col013, @Col014, @Col015, @Col016, @Col017
WHILE (@@fetch_status <> -1)
BEGIN

	set @se01_num_transaction_segments = @se01_num_transaction_segments + 1

	if ( RTrim(@col001) = 'ENT')
	begin
		-- if a current member exists, insert the 'previous' member record
		if (@L2100B_nm109_individual_id IS NOT NULL)
		begin
			insert into x12_820_remittance_advice
				(	x12_transaction_id,
					bpr02_total_prov_pmt_amt,
					bpr16_check_eff_date,
					trn02_trace_number,
					L1000A_n102_receiver_org_nm,
					L1000A_n104_receiver_id,
					L1000B_n102_payer_nm,
					L1000B_n103_payer_id,
					L2000B_ent04_org_id_code_omap_rate_group,
					L2000B_ent04_org_id_code_omap_perc,
					L2000B_ent04_org_id_code_omap_php,
					L2000B_ent04_org_id_code_omap_fips,
					--L2100B_nm109_individual_id,
					L2300A_rmr04_prem_payment_amount,
					L2300B_dtm06_coverage_period_begin,
					L2300B_dtm06_coverage_period_end,
					L2100B_nm101_entity_id_code,
					L2100B_nm102_entity_type_qual,
					L2100B_nm103_individual_last_nm,
					L2100B_nm104_individual_first_nm,
					L2100B_nm105_individual_middle_nm,
					L2100B_nm106_individual_prefix,
					L2100B_nm107_individual_suffix,
					L2100B_nm108_individual_id_code_qual,
					L2100B_nm109_individual_id
				)
			VALUES (
					@x12_transaction_id,
					@TotalPmt,
					@CheckDate,
					@CheckNo,
					@ReceiverNM,
					@ReceiverID,
					@PayerNM,
					@PayerID,
					@curRateGroup,
					@curPERC,
					@curPHP,
					@curFIPS,
					--@curmem,
					@curpmt,
					@cureffdate,
					@curtermdate,
					@L2100B_nm101_entity_id_code,
					@L2100B_nm102_entity_type_qual,
					@L2100B_nm103_individual_last_nm,
					@L2100B_nm104_individual_first_nm,
					@L2100B_nm105_individual_middle_nm,
					@L2100B_nm106_individual_prefix,
					@L2100B_nm107_individual_suffix,
					@L2100B_nm108_individual_id_code_qual,
					@L2100B_nm109_individual_id
				)
		end
		set @curPERC = SubString(@col005, 9, 2)
		set @curRateGroup = SubString(@col005, 11, 1)
		set @curPHP = SubString(@col005, 12, 4)
		set @curFIPS = SubString(@col005, 16, 3)
	end

	if ( RTrim(@col001) = 'NM1' AND RTrim(@col002) = 'QE')
	begin
		select	@curLoop = '2100B',
			@L2100B_nm101_entity_id_code = LTrim(RTrim(@col002)),
			@L2100B_nm102_entity_type_qual = LTrim(RTrim(@col003)),
			@L2100B_nm103_individual_last_nm = LTrim(RTrim(@col004)),
			@L2100B_nm104_individual_first_nm = LTrim(RTrim(@col005)),
			@L2100B_nm105_individual_middle_nm = LTrim(RTrim(@col006)),
			@L2100B_nm106_individual_prefix = LTrim(RTrim(@col007)),
			@L2100B_nm107_individual_suffix = LTrim(RTrim(@col008)),
			@L2100B_nm108_individual_id_code_qual = LTrim(RTrim(@col009)),
			@L2100B_nm109_individual_id = LTrim(RTrim(@col010))
	end

	-- Get the total payment amount
	if ( RTrim(@col001) = 'BPR' )
	begin
		set @TotalPmt = Cast(RTrim(Left(@col003, 20)) as money)
		set @CheckDate = SubString(@col017, 5, 2) + '/' + SubString(@col017, 7, 2) + '/' + SubString(@col017, 1, 4)
	end

	-- Get the Check Number
	if ( RTrim(@col001) = 'TRN' )
	begin
		set @CheckNo = LTRIM(RTRIM(@col003))
	end

	-- Get the PAYEE information
	if ( RTrim(@col001) = 'N1' AND RTrim(@col002) = 'PE')
	begin
		set @ReceiverID = RTrim(Left(@col005, 80))
		set @ReceiverNM = RTrim(Left(@col003, 60))
	end

	-- Get the PAYER information
	if ( RTrim(@col001) = 'N1' AND RTrim(@col002) = 'PR')
	begin
		set @PayerID = RTrim(Left(@col005, 80))
		set @PayerNM = RTrim(Left(@col003, 60))
	end

	-- Get the MEMBER information
	--if ( RTrim(@col001) = 'NM1' ) set @curmem = RTrim(Left(@col010, 15))

	-- Get the PREMIUM amount
	if ( RTrim(@col001) = 'RMR' ) set @curpmt = Cast(RTrim(Left(@col005, 10)) as money)

	-- Get the EFFECTIVE DATE for this premium amount
	if ( RTrim(@col001) = 'DTM' )
	begin
		set @cureffdate = SubString(@col007, 5, 2) + '/' + SubString(@col007, 7, 2) + '/' + SubString(@col007, 1, 4)
		set @curtermdate = SubString(@col007, 14, 2) + '/' + SubString(@col007, 16, 2) + '/' + SubString(@col007, 10, 4)
	end

	FETCH NEXT FROM curt820 INTO @Col001, @Col002, @Col003, @Col004, @Col005, @Col006, @Col007, @Col008, @Col009, @Col010, @Col011, @Col012, @Col013, @Col014, @Col015, @Col016, @Col017
END

CLOSE curt820

DEALLOCATE curt820
	-- after going through the recordset, the last record must be inserted.
	insert into x12_820_remittance_advice
		(	x12_transaction_id,
			bpr02_total_prov_pmt_amt,
			bpr16_check_eff_date,
			trn02_trace_number,
			L1000A_n102_receiver_org_nm,
			L1000A_n104_receiver_id,
			L1000B_n102_payer_nm,
			L1000B_n103_payer_id,
			L2000B_ent04_org_id_code_omap_rate_group,
			L2000B_ent04_org_id_code_omap_perc,
			L2000B_ent04_org_id_code_omap_php,
			L2000B_ent04_org_id_code_omap_fips,
--			L2100B_nm109_individual_id,
			L2300A_rmr04_prem_payment_amount,
			L2300B_dtm06_coverage_period_begin,
			L2300B_dtm06_coverage_period_end,
			L2100B_nm101_entity_id_code,
			L2100B_nm102_entity_type_qual,
			L2100B_nm103_individual_last_nm,
			L2100B_nm104_individual_first_nm,
			L2100B_nm105_individual_middle_nm,
			L2100B_nm106_individual_prefix,
			L2100B_nm107_individual_suffix,
			L2100B_nm108_individual_id_code_qual,
			L2100B_nm109_individual_id
		)
	VALUES (
			@x12_transaction_id,
			@TotalPmt,
			@CheckDate,
			@CheckNo,
			@ReceiverNM,
			@ReceiverID,
			@PayerNM,
			@PayerID,
			@curRateGroup,
			@curPERC,
			@curPHP,
			@curFIPS,
--			@curmem,
			@curpmt,
			@cureffdate,
			@curtermdate,
			@L2100B_nm101_entity_id_code,
			@L2100B_nm102_entity_type_qual,
			@L2100B_nm103_individual_last_nm,
			@L2100B_nm104_individual_first_nm,
			@L2100B_nm105_individual_middle_nm,
			@L2100B_nm106_individual_prefix,
			@L2100B_nm107_individual_suffix,
			@L2100B_nm108_individual_id_code_qual,
			@L2100B_nm109_individual_id
		)
return (0)

