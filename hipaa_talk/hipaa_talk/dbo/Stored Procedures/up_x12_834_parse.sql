
CREATE PROCEDURE [dbo].[up_x12_834_parse] (@x12_transaction_id int = null, @se01_num_transaction_segments int = null output) AS

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

-- declare @x12_transaction_id int
declare @L2000_ins01_insured_indicator char(1)
declare @L2000_ins02_ind_relationship_code char(2)
declare @L2000_ins03_maint_type_code char(3)
declare @L2000_ins04_maint_reason_code char(3)
declare @L2000_ins05_benefit_status_code char(1)
declare @L2000_ins06_medicare_plan_code char(1)
declare @L2000_ins07_cobra_code char(2)
declare @L2000_ins08_employment_status_code char(2)
declare @L2000_ins09_student_status_code char(1)
declare @L2000_ins10_handicap_indicator char(1)
declare @L2000_ins12_insured_death_date varchar(35)
declare @L2000_ins13_birth_seq_num varchar(9)
declare @L2000_ref02_subscriber_id varchar(30)
declare @L2000_ref02_insured_grp_policy_num varchar(30)
declare @L2000_ref02_3H_subscriber_sup_id varchar(30)
declare @L2000_ref02_DX_subscriber_sup_id varchar(30)
declare @L2000_ref02_17_subscriber_sup_id varchar(30)
declare @L2000_ref02_23_subscriber_sup_id varchar(30)
declare @L2000_ref02_F6_subscriber_sup_id varchar(30)
declare @L2000_dtp03_356_status_info_eff_date varchar(35)
declare @L2000_dtp03_357_status_info_eff_date varchar(35)
declare @L1000A_n101_entity_id_code char (3)
declare @L1000A_n102_plan_sponsor_nm varchar (60)
declare @L1000A_n103_sponsor_id_qual char (2)
declare @L1000A_n104_sponsor_id varchar (80)
declare @L1000B_n101_entity_id_code char (3)
declare @L1000B_n102_insurer_nm varchar (60)
declare @L1000B_n103_insurer_id_qual char (2)
declare @L1000B_n104_insurer_id varchar (80)
declare @L1000C_n101_entity_id_code char (3)
declare @L2100A_nm103_subscriber_last_nm varchar (35)
declare @L2100A_nm104_subscriber_first_nm varchar (25)
declare @L2100A_nm105_subscriber_middle_nm varchar (25)
declare @L2100A_nm106_subscriber_name_prefix varchar (10)
declare @L2100A_nm107_subscriber_name_suffix varchar (10)
declare @L2100A_nm108_subscriber_id_code_qual char (2)
declare @L2100A_nm109_subscriber_id varchar (80)
declare @L2100A_per101_member_comm_func_code char (2)
declare @L2100A_per103_member_comm_num_qual char (2)
declare @L2100A_per104_member_comm varchar (80)
declare @L2100A_n301_subscriber_address1 varchar (55)
declare @L2100A_n302_subscriber_address2 varchar (55)
declare @L2100A_n401_subscriber_city varchar (30)
declare @L2100A_n402_subscriber_state char (2)
declare @L2100A_n403_subscriber_zip varchar (15)
declare @L2100A_n404_subscriber_country varchar (3)
declare @L2100A_n406_subscriber_location_code varchar (30)
declare @L2100A_dmg02_member_dob varchar (35)
declare @L2100A_dmg03_member_gender char (1)
declare @L2100A_dmg04_member_marital_status char (1)
declare @L2100A_dmg05_member_ethnicity char (1)
declare @L2100A_dmg06_member_citizenship char (2)
declare @L2100A_hlh01_health_related_code char (1)
declare @L2100A_hlh02_member_height varchar (8)
declare @L2100A_hlh03_member_weight varchar (10)
declare @L2100A_lui01_language_code_qual char (2)
declare @L2100A_lui02_language_code varchar (80)
declare @L2100A_lui03_language_desc varchar (80)
declare @L2100A_lui04_language_use_indicator char (2)
declare @L2100A_amt02_B9_contract_amt money
declare @L2100A_amt02_C1_contract_amt money
declare @L2100A_amt02_D2_contract_amt money
declare @L2100A_amt02_P3_contract_amt money
declare @L2100G_nm103_resp_party_last_nm varchar (35)
declare @L2100G_nm104_resp_party_first_nm varchar (25)
declare @L2100G_nm105_resp_party_middle_nm varchar (25)
declare @L2100G_nm106_resp_party_name_prefix varchar (10)
declare @L2100G_nm107_resp_party_name_suffix varchar (10)
declare @L2100G_nm108_resp_party_id_code_qual char (2)
declare @L2100G_nm109_resp_party_id varchar (80)
declare @L2100G_per101_member_comm_func_code char (2)
declare @L2100G_per103_member_comm_num_qual char (2)
declare @L2100G_per104_member_comm varchar (80)
declare @L2100G_n301_resp_party_address1 varchar (55)
declare @L2100G_n302_resp_party_address2 varchar (55)
declare @L2100G_n401_resp_party_city varchar (30)
declare @L2100G_n402_resp_party_state char (2)
declare @L2100G_n403_resp_party_zip varchar (15)
declare @L2100G_n404_resp_party_country varchar (3)
declare @L2300_hd01_maint_type_code char (3)
declare @L2300_hd03_ins_line_code char (3)
declare @L2300_hd04_plan_cvg_desc varchar (50)
declare @L2300_hd05_cvg_level_code varchar (3)
declare @L2300_dtp03_303_cvg_period varchar (35)
declare @L2300_dtp03_348_cvg_period varchar (35)
declare @L2300_dtp03_349_cvg_period varchar (35)
declare @L2300_dtp03_543_cvg_period varchar (35)
declare @L2300_amt02_B9_contract_amt money
declare @L2300_amt02_C1_contract_amt money
declare @L2300_amt02_D2_contract_amt money
declare @L2300_amt02_P3_contract_amt money
declare @L2300_ref02_17_insured_grp_policy_num varchar (30)
declare @L2300_ref02_1l_insured_grp_policy_num varchar (30)
declare @L2300_ref02_ZZ_insured_grp_policy_num varchar (30)
declare @L2320_1_cob01_payer_resp_seq_code char (1)
declare @L2320_1_cob02_insured_grp_policy_num varchar (30)
declare @L2320_1_cob03_cob_code char (1)
declare @L2320_2_cob01_payer_resp_seq_code char (1)
declare @L2320_2_cob02_insured_grp_policy_num varchar (30)
declare @L2320_2_cob03_cob_code char (1)
declare @L2320_3_cob01_payer_resp_seq_code char (1)
declare @L2320_3_cob02_insured_grp_policy_num varchar (30)
declare @L2320_3_cob03_cob_code char (1)
declare @L2320_4_cob01_payer_resp_seq_code char (1)
declare @L2320_4_cob02_insured_grp_policy_num varchar (30)
declare @L2320_4_cob03_cob_code char (1)
declare @L2320_5_cob01_payer_resp_seq_code char (1)
declare @L2320_5_cob02_insured_grp_policy_num varchar (30)
declare @L2320_5_cob03_cob_code char (1)
declare @curLoop varchar(10)
declare @errmsg varchar(250)
declare @errcode int
declare @x12_parse_temp_id_start int
declare @x12_parse_temp_id_end int
declare @isa16_component_element_seperator char(1)
declare @x12_interchange_uid uniqueidentifier

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
DECLARE curt834 SCROLL CURSOR FOR
	select Col001, Col002, Col003, Col004, Col005, Col006, Col007, Col008, Col009, Col010, Col011, Col012, Col013, Col014, Col015, Col016, Col017
	from x12_parse_temp
	where	x12_parse_temp_id BETWEEN @x12_parse_temp_id_start AND @x12_parse_temp_id_end
		AND x12_parse_temp_uid = @x12_interchange_uid
	order by x12_parse_temp_id
OPEN curt834
FETCH NEXT FROM curt834 INTO @Col001, @Col002, @Col003, @Col004, @Col005, @Col006, @Col007, @Col008, @Col009, @Col010, @Col011, @Col012, @Col013, @Col014, @Col015, @Col016, @Col017
WHILE (@@fetch_status <> -1)
BEGIN
	set @se01_num_transaction_segments = @se01_num_transaction_segments + 1
	if ( RTrim(@col001) = 'HD')
	begin
		set @curLoop = '2300'
		if (@L2300_hd01_maint_type_code IS NOT NULL)
		begin
			insert into x12_834_benefit_enrollment
				(	x12_transaction_id,
					L1000A_n101_entity_id_code,
					L1000A_n102_plan_sponsor_nm,
					L1000A_n103_sponsor_id_qual,
					L1000A_n104_sponsor_id,
					L1000B_n101_entity_id_code,
					L1000B_n102_insurer_nm,
					L1000B_n103_insurer_id_qual,
					L1000B_n104_insurer_id,
					L1000C_n101_entity_id_code,
					L2000_ins01_insured_indicator,
					L2000_ins02_ind_relationship_code,
					L2000_ins03_maint_type_code,
					L2000_ins04_maint_reason_code,
					L2000_ins05_benefit_status_code,
					L2000_ins06_medicare_plan_code,
					L2000_ins07_cobra_code,
					L2000_ins08_employment_status_code,
					L2000_ins09_student_status_code,
					L2000_ins10_handicap_indicator,
					L2000_ins12_insured_death_date,
					L2000_ins13_birth_seq_num,
					L2000_ref02_subscriber_id,
					L2000_ref02_insured_grp_policy_num,
					L2000_ref02_3H_subscriber_sup_id,
					L2000_ref02_DX_subscriber_sup_id,
					L2000_ref02_17_subscriber_sup_id,
					L2000_ref02_23_subscriber_sup_id,
					L2000_ref02_F6_subscriber_sup_id,
					L2000_dtp03_356_status_info_eff_date,
					L2000_dtp03_357_status_info_eff_date,
					L2100A_nm103_subscriber_last_nm,
					L2100A_nm104_subscriber_first_nm,
					L2100A_nm105_subscriber_middle_nm,
					L2100A_nm106_subscriber_name_prefix,
					L2100A_nm107_subscriber_name_suffix,
					L2100A_nm108_subscriber_id_code_qual,
					L2100A_nm109_subscriber_id,
					L2100A_per101_member_comm_func_code,
					L2100A_per103_member_comm_num_qual,
					L2100A_per104_member_comm,
					L2100A_n301_subscriber_address1,
					L2100A_n302_subscriber_address2,
					L2100A_n401_subscriber_city,
					L2100A_n402_subscriber_state,
					L2100A_n403_subscriber_zip,
					L2100A_n404_subscriber_country,
					L2100A_n406_subscriber_location_code,
					L2100A_dmg02_member_dob,
					L2100A_dmg03_member_gender,
					L2100A_dmg04_member_marital_status,
					L2100A_dmg05_member_ethnicity,
					L2100A_dmg06_member_citizenship,
					L2100A_amt02_B9_contract_amt,
					L2100A_amt02_C1_contract_amt,
					L2100A_amt02_D2_contract_amt,
					L2100A_amt02_P3_contract_amt,
					L2100A_hlh01_health_related_code,
					L2100A_hlh02_member_height,
					L2100A_hlh03_member_weight,
					L2100A_lui01_language_code_qual,
					L2100A_lui02_language_code,
					L2100A_lui03_language_desc,
					L2100A_lui04_language_use_indicator,
					L2100G_nm103_resp_party_last_nm,
					L2100G_nm104_resp_party_first_nm,
					L2100G_nm105_resp_party_middle_nm,
					L2100G_nm106_resp_party_name_prefix,
					L2100G_nm107_resp_party_name_suffix,
					L2100G_nm108_resp_party_id_code_qual,
					L2100G_nm109_resp_party_id,
					L2100G_per101_member_comm_func_code,
					L2100G_per103_member_comm_num_qual,
					L2100G_per104_member_comm,
					L2100G_n301_resp_party_address1,
					L2100G_n302_resp_party_address2,
					L2100G_n401_resp_party_city,
					L2100G_n402_resp_party_state,
					L2100G_n403_resp_party_zip,
					L2100G_n404_resp_party_country,
					L2300_hd01_maint_type_code,
					L2300_hd03_ins_line_code,
					L2300_hd04_plan_cvg_desc,
					L2300_hd05_cvg_level_code,
					L2300_dtp03_303_cvg_period,
					L2300_dtp03_348_cvg_period,
					L2300_dtp03_349_cvg_period,
					L2300_dtp03_543_cvg_period,
					L2300_amt02_B9_contract_amt,
					L2300_amt02_C1_contract_amt,
					L2300_amt02_D2_contract_amt,
					L2300_amt02_P3_contract_amt,
					L2300_ref02_17_insured_grp_policy_num,
					L2300_ref02_1l_insured_grp_policy_num,
					L2300_ref02_ZZ_insured_grp_policy_num,
					L2320_1_cob01_payer_resp_seq_code,
					L2320_1_cob02_insured_grp_policy_num,
					L2320_1_cob03_cob_code,
					L2320_2_cob01_payer_resp_seq_code,
					L2320_2_cob02_insured_grp_policy_num,
					L2320_2_cob03_cob_code,
					L2320_3_cob01_payer_resp_seq_code,
					L2320_3_cob02_insured_grp_policy_num,
					L2320_3_cob03_cob_code,
					L2320_4_cob01_payer_resp_seq_code,
					L2320_4_cob02_insured_grp_policy_num,
					L2320_4_cob03_cob_code,
					L2320_5_cob01_payer_resp_seq_code,
					L2320_5_cob02_insured_grp_policy_num,
					L2320_5_cob03_cob_code
				)
			VALUES
				(		@x12_transaction_id,
						@L1000A_n101_entity_id_code,
						@L1000A_n102_plan_sponsor_nm,
						@L1000A_n103_sponsor_id_qual,
						@L1000A_n104_sponsor_id,
						@L1000B_n101_entity_id_code,
						@L1000B_n102_insurer_nm,
						@L1000B_n103_insurer_id_qual,
						@L1000B_n104_insurer_id,
						@L1000C_n101_entity_id_code,
						@L2000_ins01_insured_indicator,
						@L2000_ins02_ind_relationship_code,
						@L2000_ins03_maint_type_code,
						@L2000_ins04_maint_reason_code,
						@L2000_ins05_benefit_status_code,
						@L2000_ins06_medicare_plan_code,
						@L2000_ins07_cobra_code,
						@L2000_ins08_employment_status_code,
						@L2000_ins09_student_status_code,
						@L2000_ins10_handicap_indicator,
						@L2000_ins12_insured_death_date,
						@L2000_ins13_birth_seq_num,
						@L2000_ref02_subscriber_id,
						@L2000_ref02_insured_grp_policy_num,
						@L2000_ref02_3H_subscriber_sup_id,
						@L2000_ref02_DX_subscriber_sup_id,
						@L2000_ref02_17_subscriber_sup_id,
						@L2000_ref02_23_subscriber_sup_id,
						@L2000_ref02_F6_subscriber_sup_id,
						@L2000_dtp03_356_status_info_eff_date,
						@L2000_dtp03_357_status_info_eff_date,
						@L2100A_nm103_subscriber_last_nm,
						@L2100A_nm104_subscriber_first_nm,
						@L2100A_nm105_subscriber_middle_nm,
						@L2100A_nm106_subscriber_name_prefix,
						@L2100A_nm107_subscriber_name_suffix,
						@L2100A_nm108_subscriber_id_code_qual,
						@L2100A_nm109_subscriber_id,
						@L2100A_per101_member_comm_func_code,
						@L2100A_per103_member_comm_num_qual,
						@L2100A_per104_member_comm,
						@L2100A_n301_subscriber_address1,
						@L2100A_n302_subscriber_address2,
						@L2100A_n401_subscriber_city,
						@L2100A_n402_subscriber_state,
						@L2100A_n403_subscriber_zip,
						@L2100A_n404_subscriber_country,
						@L2100A_n406_subscriber_location_code,
						@L2100A_dmg02_member_dob,
						@L2100A_dmg03_member_gender,
						@L2100A_dmg04_member_marital_status,
						@L2100A_dmg05_member_ethnicity,
						@L2100A_dmg06_member_citizenship,
						@L2100A_amt02_B9_contract_amt,
						@L2100A_amt02_C1_contract_amt,
						@L2100A_amt02_D2_contract_amt,
						@L2100A_amt02_P3_contract_amt,
						@L2100A_hlh01_health_related_code,
						@L2100A_hlh02_member_height,
						@L2100A_hlh03_member_weight,
						@L2100A_lui01_language_code_qual,
						@L2100A_lui02_language_code,
						@L2100A_lui03_language_desc,
						@L2100A_lui04_language_use_indicator,
						@L2100G_nm103_resp_party_last_nm,
						@L2100G_nm104_resp_party_first_nm,
						@L2100G_nm105_resp_party_middle_nm,
						@L2100G_nm106_resp_party_name_prefix,
						@L2100G_nm107_resp_party_name_suffix,
						@L2100G_nm108_resp_party_id_code_qual,
						@L2100G_nm109_resp_party_id,
						@L2100G_per101_member_comm_func_code,
						@L2100G_per103_member_comm_num_qual,
						@L2100G_per104_member_comm,
						@L2100G_n301_resp_party_address1,
						@L2100G_n302_resp_party_address2,
						@L2100G_n401_resp_party_city,
						@L2100G_n402_resp_party_state,
						@L2100G_n403_resp_party_zip,
						@L2100G_n404_resp_party_country,
						@L2300_hd01_maint_type_code,
						@L2300_hd03_ins_line_code,
						@L2300_hd04_plan_cvg_desc,
						@L2300_hd05_cvg_level_code,
						@L2300_dtp03_303_cvg_period,
						@L2300_dtp03_348_cvg_period,
						@L2300_dtp03_349_cvg_period,
						@L2300_dtp03_543_cvg_period,
						@L2300_amt02_B9_contract_amt,
						@L2300_amt02_C1_contract_amt,
						@L2300_amt02_D2_contract_amt,
						@L2300_amt02_P3_contract_amt,
						@L2300_ref02_17_insured_grp_policy_num,
						@L2300_ref02_1l_insured_grp_policy_num,
						@L2300_ref02_ZZ_insured_grp_policy_num,
						@L2320_1_cob01_payer_resp_seq_code,
						@L2320_1_cob02_insured_grp_policy_num,
						@L2320_1_cob03_cob_code,
						@L2320_2_cob01_payer_resp_seq_code,
						@L2320_2_cob02_insured_grp_policy_num,
						@L2320_2_cob03_cob_code,
						@L2320_3_cob01_payer_resp_seq_code,
						@L2320_3_cob02_insured_grp_policy_num,
						@L2320_3_cob03_cob_code,
						@L2320_4_cob01_payer_resp_seq_code,
						@L2320_4_cob02_insured_grp_policy_num,
						@L2320_4_cob03_cob_code,
						@L2320_5_cob01_payer_resp_seq_code,
						@L2320_5_cob02_insured_grp_policy_num,
						@L2320_5_cob03_cob_code
				)
		end
		set @L2300_hd01_maint_type_code = Left(RTrim(LTrim(@col002)), 3)
		set @L2300_hd03_ins_line_code = Left(RTrim(LTrim(@col004)), 3)
		set @L2300_hd04_plan_cvg_desc = Left(RTrim(LTrim(@col005)), 50)
		set @L2300_hd05_cvg_level_code = Left(RTrim(LTrim(@col006)), 3)
		-- Reset the COB fields because each HD segment means a new 2300 loop
		set @L2320_1_cob01_payer_resp_seq_code = null
		set @L2320_1_cob02_insured_grp_policy_num = null
		set @L2320_1_cob03_cob_code = null
		set @L2320_2_cob01_payer_resp_seq_code = null
		set @L2320_2_cob02_insured_grp_policy_num = null
		set @L2320_2_cob03_cob_code = null
		set @L2320_3_cob01_payer_resp_seq_code = null
		set @L2320_3_cob02_insured_grp_policy_num = null
		set @L2320_3_cob03_cob_code = null
		set @L2320_4_cob01_payer_resp_seq_code = null
		set @L2320_4_cob02_insured_grp_policy_num = null
		set @L2320_4_cob03_cob_code = null
		set @L2320_5_cob01_payer_resp_seq_code = null
		set @L2320_5_cob02_insured_grp_policy_num = null
		set @L2320_5_cob03_cob_code = null
	end

	if ( RTrim(@col001) = 'COB' )
	begin
		if (@L2320_1_cob01_payer_resp_seq_code IS NULL)
		begin
			set @L2320_1_cob01_payer_resp_seq_code = Left(RTrim(LTrim(@col002)), 1)
			set @L2320_1_cob02_insured_grp_policy_num = Left(RTrim(LTrim(@col003)), 30)
			set @L2320_1_cob03_cob_code = Left(RTrim(LTrim(@col004)), 1)
		end
		else if (@L2320_2_cob01_payer_resp_seq_code IS NULL)
		begin
			set @L2320_2_cob01_payer_resp_seq_code = Left(RTrim(LTrim(@col002)), 1)
			set @L2320_2_cob02_insured_grp_policy_num = Left(RTrim(LTrim(@col003)), 30)
			set @L2320_2_cob03_cob_code = Left(RTrim(LTrim(@col004)), 1)
		end
		else if (@L2320_3_cob01_payer_resp_seq_code IS NULL)
		begin
			set @L2320_3_cob01_payer_resp_seq_code = Left(RTrim(LTrim(@col002)), 1)
			set @L2320_3_cob02_insured_grp_policy_num = Left(RTrim(LTrim(@col003)), 30)
			set @L2320_3_cob03_cob_code = Left(RTrim(LTrim(@col004)), 1)
		end
		else if (@L2320_4_cob01_payer_resp_seq_code IS NULL)
		begin
			set @L2320_4_cob01_payer_resp_seq_code = Left(RTrim(LTrim(@col002)), 1)
			set @L2320_4_cob02_insured_grp_policy_num = Left(RTrim(LTrim(@col003)), 30)
			set @L2320_4_cob03_cob_code = Left(RTrim(LTrim(@col004)), 1)
		end
		else if (@L2320_5_cob01_payer_resp_seq_code IS NULL)
		begin
			set @L2320_5_cob01_payer_resp_seq_code = Left(RTrim(LTrim(@col002)), 1)
			set @L2320_5_cob02_insured_grp_policy_num = Left(RTrim(LTrim(@col003)), 30)
			set @L2320_5_cob03_cob_code = Left(RTrim(LTrim(@col004)), 1)
		end
	end

	if ( RTrim(@col001) = 'INS' )
	begin
		if ( (@L2300_hd01_maint_type_code IS NOT NULL) OR (@L2000_ins03_maint_type_code = '024') )
		begin
			insert into x12_834_benefit_enrollment
				(	x12_transaction_id,
					L1000A_n101_entity_id_code,
					L1000A_n102_plan_sponsor_nm,
					L1000A_n103_sponsor_id_qual,
					L1000A_n104_sponsor_id,
					L1000B_n101_entity_id_code,
					L1000B_n102_insurer_nm,
					L1000B_n103_insurer_id_qual,
					L1000B_n104_insurer_id,
					L1000C_n101_entity_id_code,
					L2000_ins01_insured_indicator,
					L2000_ins02_ind_relationship_code,
					L2000_ins03_maint_type_code,
					L2000_ins04_maint_reason_code,
					L2000_ins05_benefit_status_code,
					L2000_ins06_medicare_plan_code,
					L2000_ins07_cobra_code,
					L2000_ins08_employment_status_code,
					L2000_ins09_student_status_code,
					L2000_ins10_handicap_indicator,
					L2000_ins12_insured_death_date,
					L2000_ins13_birth_seq_num,
					L2000_ref02_subscriber_id,
					L2000_ref02_insured_grp_policy_num,
					L2000_ref02_3H_subscriber_sup_id,
					L2000_ref02_DX_subscriber_sup_id,
					L2000_ref02_17_subscriber_sup_id,
					L2000_ref02_23_subscriber_sup_id,
					L2000_ref02_F6_subscriber_sup_id,
					L2000_dtp03_356_status_info_eff_date,
					L2000_dtp03_357_status_info_eff_date,
					L2100A_nm103_subscriber_last_nm,
					L2100A_nm104_subscriber_first_nm,
					L2100A_nm105_subscriber_middle_nm,
					L2100A_nm106_subscriber_name_prefix,
					L2100A_nm107_subscriber_name_suffix,
					L2100A_nm108_subscriber_id_code_qual,
					L2100A_nm109_subscriber_id,
					L2100A_per101_member_comm_func_code,
					L2100A_per103_member_comm_num_qual,
					L2100A_per104_member_comm,
					L2100A_n301_subscriber_address1,
					L2100A_n302_subscriber_address2,
					L2100A_n401_subscriber_city,
					L2100A_n402_subscriber_state,
					L2100A_n403_subscriber_zip,
					L2100A_n404_subscriber_country,
					L2100A_n406_subscriber_location_code,
					L2100A_dmg02_member_dob,
					L2100A_dmg03_member_gender,
					L2100A_dmg04_member_marital_status,
					L2100A_dmg05_member_ethnicity,
					L2100A_dmg06_member_citizenship,
					L2100A_amt02_B9_contract_amt,
					L2100A_amt02_C1_contract_amt,
					L2100A_amt02_D2_contract_amt,
					L2100A_amt02_P3_contract_amt,
					L2100A_hlh01_health_related_code,
					L2100A_hlh02_member_height,
					L2100A_hlh03_member_weight,
					L2100A_lui01_language_code_qual,
					L2100A_lui02_language_code,
					L2100A_lui03_language_desc,
					L2100A_lui04_language_use_indicator,
					L2100G_nm103_resp_party_last_nm,
					L2100G_nm104_resp_party_first_nm,
					L2100G_nm105_resp_party_middle_nm,
					L2100G_nm106_resp_party_name_prefix,
					L2100G_nm107_resp_party_name_suffix,
					L2100G_nm108_resp_party_id_code_qual,
					L2100G_nm109_resp_party_id,
					L2100G_per101_member_comm_func_code,
					L2100G_per103_member_comm_num_qual,
					L2100G_per104_member_comm,
					L2100G_n301_resp_party_address1,
					L2100G_n302_resp_party_address2,
					L2100G_n401_resp_party_city,
					L2100G_n402_resp_party_state,
					L2100G_n403_resp_party_zip,
					L2100G_n404_resp_party_country,
					L2300_hd01_maint_type_code,
					L2300_hd03_ins_line_code,
					L2300_hd04_plan_cvg_desc,
					L2300_hd05_cvg_level_code,
					L2300_dtp03_303_cvg_period,
					L2300_dtp03_348_cvg_period,
					L2300_dtp03_349_cvg_period,
					L2300_dtp03_543_cvg_period,
					L2300_amt02_B9_contract_amt,
					L2300_amt02_C1_contract_amt,
					L2300_amt02_D2_contract_amt,
					L2300_amt02_P3_contract_amt,
					L2300_ref02_17_insured_grp_policy_num,
					L2300_ref02_1l_insured_grp_policy_num,
					L2300_ref02_ZZ_insured_grp_policy_num,
					L2320_1_cob01_payer_resp_seq_code,
					L2320_1_cob02_insured_grp_policy_num,
					L2320_1_cob03_cob_code,
					L2320_2_cob01_payer_resp_seq_code,
					L2320_2_cob02_insured_grp_policy_num,
					L2320_2_cob03_cob_code,
					L2320_3_cob01_payer_resp_seq_code,
					L2320_3_cob02_insured_grp_policy_num,
					L2320_3_cob03_cob_code,
					L2320_4_cob01_payer_resp_seq_code,
					L2320_4_cob02_insured_grp_policy_num,
					L2320_4_cob03_cob_code,
					L2320_5_cob01_payer_resp_seq_code,
					L2320_5_cob02_insured_grp_policy_num,
					L2320_5_cob03_cob_code
				)
				VALUES
				(		@x12_transaction_id,
						@L1000A_n101_entity_id_code,
						@L1000A_n102_plan_sponsor_nm,
						@L1000A_n103_sponsor_id_qual,
						@L1000A_n104_sponsor_id,
						@L1000B_n101_entity_id_code,
						@L1000B_n102_insurer_nm,
						@L1000B_n103_insurer_id_qual,
						@L1000B_n104_insurer_id,
						@L1000C_n101_entity_id_code,
						@L2000_ins01_insured_indicator,
						@L2000_ins02_ind_relationship_code,
						@L2000_ins03_maint_type_code,
						@L2000_ins04_maint_reason_code,
						@L2000_ins05_benefit_status_code,
						@L2000_ins06_medicare_plan_code,
						@L2000_ins07_cobra_code,
						@L2000_ins08_employment_status_code,
						@L2000_ins09_student_status_code,
						@L2000_ins10_handicap_indicator,
						@L2000_ins12_insured_death_date,
						@L2000_ins13_birth_seq_num,
						@L2000_ref02_subscriber_id,
						@L2000_ref02_insured_grp_policy_num,
						@L2000_ref02_3H_subscriber_sup_id,
						@L2000_ref02_DX_subscriber_sup_id,
						@L2000_ref02_17_subscriber_sup_id,
						@L2000_ref02_23_subscriber_sup_id,
						@L2000_ref02_F6_subscriber_sup_id,
						@L2000_dtp03_356_status_info_eff_date,
						@L2000_dtp03_357_status_info_eff_date,
						@L2100A_nm103_subscriber_last_nm,
						@L2100A_nm104_subscriber_first_nm,
						@L2100A_nm105_subscriber_middle_nm,
						@L2100A_nm106_subscriber_name_prefix,
						@L2100A_nm107_subscriber_name_suffix,
						@L2100A_nm108_subscriber_id_code_qual,
						@L2100A_nm109_subscriber_id,
						@L2100A_per101_member_comm_func_code,
						@L2100A_per103_member_comm_num_qual,
						@L2100A_per104_member_comm,
						@L2100A_n301_subscriber_address1,
						@L2100A_n302_subscriber_address2,
						@L2100A_n401_subscriber_city,
						@L2100A_n402_subscriber_state,
						@L2100A_n403_subscriber_zip,
						@L2100A_n404_subscriber_country,
						@L2100A_n406_subscriber_location_code,
						@L2100A_dmg02_member_dob,
						@L2100A_dmg03_member_gender,
						@L2100A_dmg04_member_marital_status,
						@L2100A_dmg05_member_ethnicity,
						@L2100A_dmg06_member_citizenship,
						@L2100A_amt02_B9_contract_amt,
						@L2100A_amt02_C1_contract_amt,
						@L2100A_amt02_D2_contract_amt,
						@L2100A_amt02_P3_contract_amt,
						@L2100A_hlh01_health_related_code,
						@L2100A_hlh02_member_height,
						@L2100A_hlh03_member_weight,
						@L2100A_lui01_language_code_qual,
						@L2100A_lui02_language_code,
						@L2100A_lui03_language_desc,
						@L2100A_lui04_language_use_indicator,
						@L2100G_nm103_resp_party_last_nm,
						@L2100G_nm104_resp_party_first_nm,
						@L2100G_nm105_resp_party_middle_nm,
						@L2100G_nm106_resp_party_name_prefix,
						@L2100G_nm107_resp_party_name_suffix,
						@L2100G_nm108_resp_party_id_code_qual,
						@L2100G_nm109_resp_party_id,
						@L2100G_per101_member_comm_func_code,
						@L2100G_per103_member_comm_num_qual,
						@L2100G_per104_member_comm,
						@L2100G_n301_resp_party_address1,
						@L2100G_n302_resp_party_address2,
						@L2100G_n401_resp_party_city,
						@L2100G_n402_resp_party_state,
						@L2100G_n403_resp_party_zip,
						@L2100G_n404_resp_party_country,
						@L2300_hd01_maint_type_code,
						@L2300_hd03_ins_line_code,
						@L2300_hd04_plan_cvg_desc,
						@L2300_hd05_cvg_level_code,
						@L2300_dtp03_303_cvg_period,
						@L2300_dtp03_348_cvg_period,
						@L2300_dtp03_349_cvg_period,
						@L2300_dtp03_543_cvg_period,
						@L2300_amt02_B9_contract_amt,
						@L2300_amt02_C1_contract_amt,
						@L2300_amt02_D2_contract_amt,
						@L2300_amt02_P3_contract_amt,
						@L2300_ref02_17_insured_grp_policy_num,
						@L2300_ref02_1l_insured_grp_policy_num,
						@L2300_ref02_ZZ_insured_grp_policy_num,
						@L2320_1_cob01_payer_resp_seq_code,
						@L2320_1_cob02_insured_grp_policy_num,
						@L2320_1_cob03_cob_code,
						@L2320_2_cob01_payer_resp_seq_code,
						@L2320_2_cob02_insured_grp_policy_num,
						@L2320_2_cob03_cob_code,
						@L2320_3_cob01_payer_resp_seq_code,
						@L2320_3_cob02_insured_grp_policy_num,
						@L2320_3_cob03_cob_code,
						@L2320_4_cob01_payer_resp_seq_code,
						@L2320_4_cob02_insured_grp_policy_num,
						@L2320_4_cob03_cob_code,
						@L2320_5_cob01_payer_resp_seq_code,
						@L2320_5_cob02_insured_grp_policy_num,
						@L2320_5_cob03_cob_code
				)	
			-- New member record starting, reset variables
			set @L2000_ref02_subscriber_id = null
			set @L2000_ref02_insured_grp_policy_num = null
			set @L2000_ref02_3H_subscriber_sup_id = null
			set @L2000_ref02_DX_subscriber_sup_id = null
			set @L2000_ref02_17_subscriber_sup_id = null
			set @L2000_ref02_23_subscriber_sup_id = null
			set @L2000_ref02_F6_subscriber_sup_id = null
			set @L2000_dtp03_356_status_info_eff_date = null
			set @L2000_dtp03_357_status_info_eff_date = null
			set @L2300_dtp03_303_cvg_period = null
			set @L2300_dtp03_348_cvg_period = null
			set @L2300_dtp03_349_cvg_period = null
			set @L2100A_per103_member_comm_num_qual = null
			set @L2100A_per104_member_comm = null
			set @L2100A_n301_subscriber_address1 = null
			set @L2100A_n302_subscriber_address2 = null
			set @L2100A_n401_subscriber_city = null
			set @L2100A_n402_subscriber_state = null
			set @L2100A_n403_subscriber_zip = null
			set @L2100A_n404_subscriber_country = null
			set @L2100A_n406_subscriber_location_code = null
			set @L2100A_dmg02_member_dob = null
			set @L2100A_dmg03_member_gender = null
			set @L2100A_dmg04_member_marital_status = null
			set @L2100A_dmg05_member_ethnicity = null
			set @L2100A_dmg06_member_citizenship = null
			set @L2100A_amt02_B9_contract_amt = null
			set @L2100A_amt02_C1_contract_amt = null
			set @L2100A_amt02_D2_contract_amt = null
			set @L2100A_amt02_P3_contract_amt = null
			set @L2100A_hlh01_health_related_code = null
			set @L2100A_hlh02_member_height = null
			set @L2100A_hlh03_member_weight = null
			set @L2100A_lui01_language_code_qual = null
			set @L2100A_lui02_language_code = null
			set @L2100A_lui03_language_desc = null
			set @L2100A_lui04_language_use_indicator = null
			set @L2100G_nm103_resp_party_last_nm = null
			set @L2100G_nm104_resp_party_first_nm = null
			set @L2100G_nm105_resp_party_middle_nm = null
			set @L2100G_nm106_resp_party_name_prefix = null
			set @L2100G_nm107_resp_party_name_suffix = null
			set @L2100G_nm108_resp_party_id_code_qual = null
			set @L2100G_nm109_resp_party_id = null
			set @L2100G_per101_member_comm_func_code = null
			set @L2100G_per103_member_comm_num_qual = null
			set @L2100G_per104_member_comm = null
			set @L2100G_n301_resp_party_address1 = null
			set @L2100G_n302_resp_party_address2 = null
			set @L2100G_n401_resp_party_city = null
			set @L2100G_n402_resp_party_state = null
			set @L2100G_n403_resp_party_zip = null
			set @L2100G_n404_resp_party_country = null
			set @L2300_hd01_maint_type_code = null
			set @L2300_hd03_ins_line_code = null
			set @L2300_hd04_plan_cvg_desc = null
			set @L2300_hd05_cvg_level_code = null
			set @L2320_1_cob01_payer_resp_seq_code = null
			set @L2320_1_cob02_insured_grp_policy_num = null
			set @L2320_1_cob03_cob_code = null
			set @L2320_2_cob01_payer_resp_seq_code = null
			set @L2320_2_cob02_insured_grp_policy_num = null
			set @L2320_2_cob03_cob_code = null
			set @L2320_3_cob01_payer_resp_seq_code = null
			set @L2320_3_cob02_insured_grp_policy_num = null
			set @L2320_3_cob03_cob_code = null
			set @L2320_4_cob01_payer_resp_seq_code = null
			set @L2320_4_cob02_insured_grp_policy_num = null
			set @L2320_4_cob03_cob_code = null
			set @L2320_5_cob01_payer_resp_seq_code = null
			set @L2320_5_cob02_insured_grp_policy_num = null
			set @L2320_5_cob03_cob_code = null
		end
		set @curLoop = '2000'
		set @L2000_ins01_insured_indicator = RTrim(Left(@col002, 1))
		set @L2000_ins02_ind_relationship_code = RTrim(Left(@col003, 2))
		set @L2000_ins03_maint_type_code = RTrim(Left(@col004, 3))
		set @L2000_ins04_maint_reason_code = RTrim(Left(@col005, 3))
		set @L2000_ins05_benefit_status_code = RTrim(Left(@col006, 1))
		set @L2000_ins06_medicare_plan_code = RTrim(Left(@col007, 1))
		set @L2000_ins07_cobra_code = RTrim(Left(@col008, 2))
		set @L2000_ins08_employment_status_code = RTrim(Left(@col009, 2))
		set @L2000_ins09_student_status_code = RTrim(Left(@col010, 1))
		set @L2000_ins10_handicap_indicator = RTrim(Left(@col011, 1))
		set @L2000_ins12_insured_death_date = RTrim(Left(@col013, 32))
		set @L2000_ins13_birth_seq_num = RTrim(Left(@col014, 9))
	end
	if ( RTrim(@col001) = 'NM1' ) and ( RTrim(@col002) = 'IL' OR RTrim(@col002) = '74' )
	begin
		set @curLoop = '2100A'
		set @L2100A_nm103_subscriber_last_nm = Left(RTrim(LTrim(@col004)), 35)
		set @L2100A_nm104_subscriber_first_nm = Left(RTrim(LTrim(@col005)), 25)
		set @L2100A_nm105_subscriber_middle_nm = Left(RTrim(LTrim(@col006)), 25)
		set @L2100A_nm106_subscriber_name_prefix = Left(RTrim(LTrim(@col007)), 10)
		set @L2100A_nm107_subscriber_name_suffix = Left(RTrim(LTrim(@col008)), 10)
		set @L2100A_nm108_subscriber_id_code_qual = Left(RTrim(LTrim(@col009)), 2)
		set @L2100A_nm109_subscriber_id = RTrim(LTrim(@col010))
	end
	if ( RTrim(@col001) = 'PER' ) and ( RTrim(@col002) = 'IP' )
	begin
		set @L2100A_per103_member_comm_num_qual = RTrim(LTrim(@col004))
		set @L2100A_per104_member_comm = RTrim(LTrim(@col005))
	end
	if ( RTrim(@col001) = 'N3' ) and ( RTrim(@curLoop) = '2100A' )
	begin
		set @L2100A_n301_subscriber_address1 = Left(RTrim(LTrim(@col002)), 55)
		set @L2100A_n302_subscriber_address2 = Left(RTrim(LTrim(@col003)), 55)
	end
	if ( RTrim(@col001) = 'N4' ) and ( RTrim(@curLoop) = '2100A' )
	begin
		set @L2100A_n401_subscriber_city = Left(RTrim(LTrim(@col002)), 55)
		set @L2100A_n402_subscriber_state = Left(RTrim(LTrim(@col003)), 2)
		set @L2100A_n403_subscriber_zip = Left(RTrim(LTrim(@col004)), 15)
		set @L2100A_n404_subscriber_country = Left(RTrim(LTrim(@col005)), 3)
		set @L2100A_n406_subscriber_location_code = Left(RTrim(LTrim(@col007)), 30)
	end
	if ( RTrim(@col001) = 'NM1' ) and ( RTrim(@col002) = 'QD' )
	begin
		set @curLoop = '2100G'
		set @L2100G_nm103_resp_party_last_nm = Left(RTrim(LTrim(@col004)), 35)
		set @L2100G_nm104_resp_party_first_nm = Left(RTrim(LTrim(@col005)), 25)
		set @L2100G_nm105_resp_party_middle_nm = Left(RTrim(LTrim(@col006)), 25)
		set @L2100G_nm106_resp_party_name_prefix = Left(RTrim(LTrim(@col007)), 10)
		set @L2100G_nm107_resp_party_name_suffix = Left(RTrim(LTrim(@col008)), 10)
		set @L2100G_nm108_resp_party_id_code_qual = Left(RTrim(LTrim(@col009)), 2)
		set @L2100G_nm109_resp_party_id = RTrim(LTrim(@col010))
	end
	if ( RTrim(@col001) = 'PER' ) and ( RTrim(@col002) = 'RP' )
	begin
		set @L2100G_per103_member_comm_num_qual = RTrim(LTrim(@col004))
		set @L2100G_per104_member_comm = RTrim(LTrim(@col005))
	end
	if ( RTrim(@col001) = 'N3' ) and ( RTrim(@curLoop) = '2100G' )
	begin
		set @L2100G_n301_resp_party_address1 = Left(RTrim(LTrim(@col002)), 55)
		set @L2100G_n302_resp_party_address2 = Left(RTrim(LTrim(@col003)), 55)
	end
	if ( RTrim(@col001) = 'N4' ) and ( RTrim(@curLoop) = '2100G' )
	begin
		set @L2100G_n401_resp_party_city = Left(RTrim(LTrim(@col002)), 55)
		set @L2100G_n402_resp_party_state = Left(RTrim(LTrim(@col003)), 2)
		set @L2100G_n403_resp_party_zip = Left(RTrim(LTrim(@col004)), 15)
		set @L2100G_n404_resp_party_country = Left(RTrim(LTrim(@col005)), 3)
	end
	if ( RTrim(@col001) = 'DMG' ) and ( RTrim(@curLoop) = '2100A' )
	begin
		set @L2100A_dmg02_member_dob = Left(RTrim(LTrim(@col003)), 35)
		set @L2100A_dmg03_member_gender = Left(RTrim(LTrim(@col004)), 1)
		set @L2100A_dmg04_member_marital_status = Left(RTrim(LTrim(@col005)), 1)
		set @L2100A_dmg05_member_ethnicity = Left(RTrim(LTrim(@col006)), 1)
		set @L2100A_dmg06_member_citizenship = Left(RTrim(LTrim(@col007)), 1)
	end
	if ( RTrim(@col001) = 'AMT' ) and ( RTrim(@curLoop) = '2100A' )
	begin
		if ( RTrim(@col002) = 'B9' ) set @L2100A_amt02_B9_contract_amt = cast(@col003 as money)
		if ( RTrim(@col002) = 'C1' ) set @L2100A_amt02_C1_contract_amt = cast(@col003 as money)
		if ( RTrim(@col002) = 'D2' ) set @L2100A_amt02_D2_contract_amt = cast(@col003 as money)
		if ( RTrim(@col002) = 'P3' ) set @L2100A_amt02_P3_contract_amt = cast(@col003 as money)
	end
	if ( RTrim(@col001) = 'HLH' ) and ( RTrim(@curLoop) = '2100A' )
	begin
		set @L2100A_hlh01_health_related_code = Left(RTrim(LTrim(@col002)), 1)
		set @L2100A_hlh02_member_height = Left(RTrim(LTrim(@col003)), 8)
		set @L2100A_hlh03_member_weight = Left(RTrim(LTrim(@col004)), 10)
	end
	if ( RTrim(@col001) = 'LUI' ) and ( RTrim(@curLoop) = '2100A' )
	begin
		set @L2100A_lui01_language_code_qual = Left(RTrim(LTrim(@col002)), 2)
		set @L2100A_lui02_language_code = Left(RTrim(LTrim(@col003)), 80)
		set @L2100A_lui03_language_desc = Left(RTrim(LTrim(@col004)), 80)
		set @L2100A_lui04_language_use_indicator = Left(RTrim(LTrim(@col005)), 2)
	end
	-- REF segments ------------------------------------------
	if ( RTrim(@col001) = 'REF' and RTrim(@col002) = '0F' AND RTrim(@curLoop) = '2000' )
		set @L2000_ref02_subscriber_id = RTrim(Left(@col003, 30))
	if ( RTrim(@col001) = 'REF' and RTrim(@col002) = '1L' AND RTrim(@curLoop) = '2000' )
		set @L2000_ref02_insured_grp_policy_num = RTrim(Left(@col003, 30))
	if ( RTrim(@col001) = 'REF' and RTrim(@col002) = '3H' AND RTrim(@curLoop) = '2000' )
		set @L2000_ref02_3H_subscriber_sup_id = RTrim(Left(@col003, 30))
	
	if ( RTrim(@col001) = 'REF' and RTrim(@col002) = 'DX' AND RTrim(@curLoop) = '2000' )
		set @L2000_ref02_DX_subscriber_sup_id = RTrim(Left(@col003, 30))
	if ( RTrim(@col001) = 'REF' and RTrim(@col002) = '17' AND RTrim(@curLoop) = '2000' )
		set @L2000_ref02_17_subscriber_sup_id = RTrim(Left(@col003, 30))
	if ( RTrim(@col001) = 'REF' and RTrim(@col002) = '23' AND RTrim(@curLoop) = '2000' )
		set @L2000_ref02_23_subscriber_sup_id = RTrim(Left(@col003, 30))
	if ( RTrim(@col001) = 'REF' and RTrim(@col002) = 'F6' AND RTrim(@curLoop) = '2000' )
		set @L2000_ref02_F6_subscriber_sup_id = RTrim(Left(@col003, 30))
	if ( RTrim(@col001) = 'DTP' and RTrim(@col002) = '356' AND RTrim(@curLoop) = '2000' )
		set @L2000_dtp03_356_status_info_eff_date = RTrim(Left(@col004, 8))
	if ( RTrim(@col001) = 'DTP' and RTrim(@col002) = '357' AND RTrim(@curLoop) = '2000' )
		set @L2000_dtp03_357_status_info_eff_date = RTrim(Left(@col004, 8))
	if ( RTrim(@col001) = 'REF' and RTrim(@col002) = '17' AND RTrim(@curLoop) = '2300' )
		set @L2300_ref02_17_insured_grp_policy_num = RTrim(Left(@col003, 30))
	if ( RTrim(@col001) = 'DTP' and RTrim(@col002) = '303' AND RTrim(@curLoop) = '2300' )
	begin
		set @curLoop = '2300'
		set @L2300_dtp03_303_cvg_period = RTrim(Left(@col004, 8))
	end
	if ( RTrim(@col001) = 'DTP' and RTrim(@col002) = '348' AND RTrim(@curLoop) = '2300' )
	begin
		set @curLoop = '2300'
		set @L2300_dtp03_348_cvg_period = RTrim(Left(@col004, 8))
	end
	if ( RTrim(@col001) = 'DTP' and RTrim(@col002) = '349' AND RTrim(@curLoop) = '2300' )
	begin
		set @curLoop = '2300'
		set @L2300_dtp03_349_cvg_period = RTrim(Left(@col004, 8))
	end
	FETCH NEXT FROM curt834 INTO @Col001, @Col002, @Col003, @Col004, @Col005, @Col006, @Col007, @Col008, @Col009, @Col010, @Col011, @Col012, @Col013, @Col014, @Col015, @Col016, @Col017
END
CLOSE curt834
DEALLOCATE curt834
-- Insert last member detail record
insert into x12_834_benefit_enrollment
(	x12_transaction_id,
	L1000A_n101_entity_id_code,
	L1000A_n102_plan_sponsor_nm,
	L1000A_n103_sponsor_id_qual,
	L1000A_n104_sponsor_id,
	L1000B_n101_entity_id_code,
	L1000B_n102_insurer_nm,
	L1000B_n103_insurer_id_qual,
	L1000B_n104_insurer_id,
	L1000C_n101_entity_id_code,
	L2000_ins01_insured_indicator,
	L2000_ins02_ind_relationship_code,
	L2000_ins03_maint_type_code,
	L2000_ins04_maint_reason_code,
	L2000_ins05_benefit_status_code,
	L2000_ins06_medicare_plan_code,
	L2000_ins07_cobra_code,
	L2000_ins08_employment_status_code,
	L2000_ins09_student_status_code,
	L2000_ins10_handicap_indicator,
	L2000_ins12_insured_death_date,
	L2000_ins13_birth_seq_num,
	L2000_ref02_subscriber_id,
	L2000_ref02_insured_grp_policy_num,
	L2000_ref02_3H_subscriber_sup_id,
	L2000_ref02_DX_subscriber_sup_id,
	L2000_ref02_17_subscriber_sup_id,
	L2000_ref02_23_subscriber_sup_id,
	L2000_ref02_F6_subscriber_sup_id,
	L2000_dtp03_356_status_info_eff_date,
	L2000_dtp03_357_status_info_eff_date,
	L2100A_nm103_subscriber_last_nm,
	L2100A_nm104_subscriber_first_nm,
	L2100A_nm105_subscriber_middle_nm,
	L2100A_nm106_subscriber_name_prefix,
	L2100A_nm107_subscriber_name_suffix,
	L2100A_nm108_subscriber_id_code_qual,
	L2100A_nm109_subscriber_id,
	L2100A_per101_member_comm_func_code,
	L2100A_per103_member_comm_num_qual,
	L2100A_per104_member_comm,
	L2100A_n301_subscriber_address1,
	L2100A_n302_subscriber_address2,
	L2100A_n401_subscriber_city,
	L2100A_n402_subscriber_state,
	L2100A_n403_subscriber_zip,
	L2100A_n404_subscriber_country,
	L2100A_n406_subscriber_location_code,
	L2100A_dmg02_member_dob,
	L2100A_dmg03_member_gender,
	L2100A_dmg04_member_marital_status,
	L2100A_dmg05_member_ethnicity,
	L2100A_dmg06_member_citizenship,
	L2100A_amt02_B9_contract_amt,
	L2100A_amt02_C1_contract_amt,
	L2100A_amt02_D2_contract_amt,
	L2100A_amt02_P3_contract_amt,
	L2100A_hlh01_health_related_code,
	L2100A_hlh02_member_height,
	L2100A_hlh03_member_weight,
	L2100A_lui01_language_code_qual,
	L2100A_lui02_language_code,
	L2100A_lui03_language_desc,
	L2100A_lui04_language_use_indicator,
	L2100G_nm103_resp_party_last_nm,
	L2100G_nm104_resp_party_first_nm,
	L2100G_nm105_resp_party_middle_nm,
	L2100G_nm106_resp_party_name_prefix,
	L2100G_nm107_resp_party_name_suffix,
	L2100G_nm108_resp_party_id_code_qual,
	L2100G_nm109_resp_party_id,
	L2100G_per101_member_comm_func_code,
	L2100G_per103_member_comm_num_qual,
	L2100G_per104_member_comm,
	L2100G_n301_resp_party_address1,
	L2100G_n302_resp_party_address2,
	L2100G_n401_resp_party_city,
	L2100G_n402_resp_party_state,
	L2100G_n403_resp_party_zip,
	L2100G_n404_resp_party_country,
	L2300_hd01_maint_type_code,
	L2300_hd03_ins_line_code,
	L2300_hd04_plan_cvg_desc,
	L2300_hd05_cvg_level_code,
	L2300_dtp03_303_cvg_period,
	L2300_dtp03_348_cvg_period,
	L2300_dtp03_349_cvg_period,
	L2300_dtp03_543_cvg_period,
	L2300_amt02_B9_contract_amt,
	L2300_amt02_C1_contract_amt,
	L2300_amt02_D2_contract_amt,
	L2300_amt02_P3_contract_amt,
	L2300_ref02_17_insured_grp_policy_num,
	L2300_ref02_1l_insured_grp_policy_num,
	L2300_ref02_ZZ_insured_grp_policy_num,
	L2320_1_cob01_payer_resp_seq_code,
	L2320_1_cob02_insured_grp_policy_num,
	L2320_1_cob03_cob_code,
	L2320_2_cob01_payer_resp_seq_code,
	L2320_2_cob02_insured_grp_policy_num,
	L2320_2_cob03_cob_code,
	L2320_3_cob01_payer_resp_seq_code,
	L2320_3_cob02_insured_grp_policy_num,
	L2320_3_cob03_cob_code,
	L2320_4_cob01_payer_resp_seq_code,
	L2320_4_cob02_insured_grp_policy_num,
	L2320_4_cob03_cob_code,
	L2320_5_cob01_payer_resp_seq_code,
	L2320_5_cob02_insured_grp_policy_num,
	L2320_5_cob03_cob_code
)
VALUES
(		@x12_transaction_id,
		@L1000A_n101_entity_id_code,
		@L1000A_n102_plan_sponsor_nm,
		@L1000A_n103_sponsor_id_qual,
		@L1000A_n104_sponsor_id,
		@L1000B_n101_entity_id_code,
		@L1000B_n102_insurer_nm,
		@L1000B_n103_insurer_id_qual,
		@L1000B_n104_insurer_id,
		@L1000C_n101_entity_id_code,
		@L2000_ins01_insured_indicator,
		@L2000_ins02_ind_relationship_code,
		@L2000_ins03_maint_type_code,
		@L2000_ins04_maint_reason_code,
		@L2000_ins05_benefit_status_code,
		@L2000_ins06_medicare_plan_code,
		@L2000_ins07_cobra_code,
		@L2000_ins08_employment_status_code,
		@L2000_ins09_student_status_code,
		@L2000_ins10_handicap_indicator,
		@L2000_ins12_insured_death_date,
		@L2000_ins13_birth_seq_num,
		@L2000_ref02_subscriber_id,
		@L2000_ref02_insured_grp_policy_num,
		@L2000_ref02_3H_subscriber_sup_id,
		@L2000_ref02_DX_subscriber_sup_id,
		@L2000_ref02_17_subscriber_sup_id,
		@L2000_ref02_23_subscriber_sup_id,
		@L2000_ref02_F6_subscriber_sup_id,
		@L2000_dtp03_356_status_info_eff_date,
		@L2000_dtp03_357_status_info_eff_date,
		@L2100A_nm103_subscriber_last_nm,
		@L2100A_nm104_subscriber_first_nm,
		@L2100A_nm105_subscriber_middle_nm,
		@L2100A_nm106_subscriber_name_prefix,
		@L2100A_nm107_subscriber_name_suffix,
		@L2100A_nm108_subscriber_id_code_qual,
		@L2100A_nm109_subscriber_id,
		@L2100A_per101_member_comm_func_code,
		@L2100A_per103_member_comm_num_qual,
		@L2100A_per104_member_comm,
		@L2100A_n301_subscriber_address1,
		@L2100A_n302_subscriber_address2,
		@L2100A_n401_subscriber_city,
		@L2100A_n402_subscriber_state,
		@L2100A_n403_subscriber_zip,
		@L2100A_n404_subscriber_country,
		@L2100A_n406_subscriber_location_code,
		@L2100A_dmg02_member_dob,
		@L2100A_dmg03_member_gender,
		@L2100A_dmg04_member_marital_status,
		@L2100A_dmg05_member_ethnicity,
		@L2100A_dmg06_member_citizenship,
		@L2100A_amt02_B9_contract_amt,
		@L2100A_amt02_C1_contract_amt,
		@L2100A_amt02_D2_contract_amt,
		@L2100A_amt02_P3_contract_amt,
		@L2100A_hlh01_health_related_code,
		@L2100A_hlh02_member_height,
		@L2100A_hlh03_member_weight,
		@L2100A_lui01_language_code_qual,
		@L2100A_lui02_language_code,
		@L2100A_lui03_language_desc,
		@L2100A_lui04_language_use_indicator,
		@L2100G_nm103_resp_party_last_nm,
		@L2100G_nm104_resp_party_first_nm,
		@L2100G_nm105_resp_party_middle_nm,
		@L2100G_nm106_resp_party_name_prefix,
		@L2100G_nm107_resp_party_name_suffix,
		@L2100G_nm108_resp_party_id_code_qual,
		@L2100G_nm109_resp_party_id,
		@L2100G_per101_member_comm_func_code,
		@L2100G_per103_member_comm_num_qual,
		@L2100G_per104_member_comm,
		@L2100G_n301_resp_party_address1,
		@L2100G_n302_resp_party_address2,
		@L2100G_n401_resp_party_city,
		@L2100G_n402_resp_party_state,
		@L2100G_n403_resp_party_zip,
		@L2100G_n404_resp_party_country,
		@L2300_hd01_maint_type_code,
		@L2300_hd03_ins_line_code,
		@L2300_hd04_plan_cvg_desc,
		@L2300_hd05_cvg_level_code,
		@L2300_dtp03_303_cvg_period,
		@L2300_dtp03_348_cvg_period,
		@L2300_dtp03_349_cvg_period,
		@L2300_dtp03_543_cvg_period,
		@L2300_amt02_B9_contract_amt,
		@L2300_amt02_C1_contract_amt,
		@L2300_amt02_D2_contract_amt,
		@L2300_amt02_P3_contract_amt,
		@L2300_ref02_17_insured_grp_policy_num,
		@L2300_ref02_1l_insured_grp_policy_num,
		@L2300_ref02_ZZ_insured_grp_policy_num,
		@L2320_1_cob01_payer_resp_seq_code,
		@L2320_1_cob02_insured_grp_policy_num,
		@L2320_1_cob03_cob_code,
		@L2320_2_cob01_payer_resp_seq_code,
		@L2320_2_cob02_insured_grp_policy_num,
		@L2320_2_cob03_cob_code,
		@L2320_3_cob01_payer_resp_seq_code,
		@L2320_3_cob02_insured_grp_policy_num,
		@L2320_3_cob03_cob_code,
		@L2320_4_cob01_payer_resp_seq_code,
		@L2320_4_cob02_insured_grp_policy_num,
		@L2320_4_cob03_cob_code,
		@L2320_5_cob01_payer_resp_seq_code,
		@L2320_5_cob02_insured_grp_policy_num,
		@L2320_5_cob03_cob_code
)



