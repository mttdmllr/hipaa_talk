CREATE Procedure [dbo].[up_x12_clm_export] (
					@x12_interchange_uid uniqueidentifier,
					@clm01_pt_acct_num varchar(38) = null,
					@clm02_total_claim_chg_amt money = null,
					@clm05_facility_type_code char(2) = null,
					@clm05_claim_freq_code_qual char(2) = null,
					@clm05_claim_freq_code char(1) = null,
					@clm06_provider_signature_ind char(1) = null,
					@clm07_medicare_assign_code char(1) = null,
					@clm08_benefit_assign_ind char(1) = null,
					@clm09_release_of_info_code char(1) = null,
					@clm10_patient_signature_code char(1) = null,
					@clm11_related_causes_code1 char(3) = null,
					@clm11_related_causes_code2 char(3) = null,
					@clm11_related_causes_code3 char(3) = null,
					@clm11_auto_accident_state_code char(2) = null,
					@clm11_country_code char(3) = null,
					@clm12_special_prog_ind char(3) = null,
					@clm16_participation_agreement char(1) = null,
					@clm18_eob_indicator char(1) = null,
					@clm19_claim_submission_reason_code char(2) = null,
					@clm20_delay_reason_code char(2) = null
				   )
As

	declare @clm05_string varchar(10)
	declare @clm11_string varchar(80)
	declare @isa16_component_element_seperator char(1)

	select @isa16_component_element_seperator = isa16_component_element_seperator
	from x12_interchange
	where x12_interchange_uid = @x12_interchange_uid

	if (@isa16_component_element_seperator IS NULL OR @isa16_component_element_seperator = ' ')
	begin
		set @isa16_component_element_seperator = ':'
	end

	set @clm05_string = LTrim(RTrim(dbo.fn_ListAppend(@clm05_string, @clm05_facility_type_code, @isa16_component_element_seperator)))
	set @clm05_string = LTrim(RTrim(dbo.fn_ListAppend(@clm05_string, IsNull(@clm05_claim_freq_code_qual, ''), @isa16_component_element_seperator)))
	set @clm05_string = LTrim(RTrim(dbo.fn_ListAppend(@clm05_string, @clm05_claim_freq_code , @isa16_component_element_seperator)))

	set @clm11_string  = dbo.fn_ListAppend(@clm11_string, @clm11_related_causes_code1 , @isa16_component_element_seperator)
	set @clm11_string  = dbo.fn_ListAppend(@clm11_string, @clm11_related_causes_code2 , @isa16_component_element_seperator)
	set @clm11_string  = dbo.fn_ListAppend(@clm11_string, @clm11_related_causes_code3 , @isa16_component_element_seperator)
	set @clm11_string  = dbo.fn_ListAppend(@clm11_string, @clm11_auto_accident_state_code , @isa16_component_element_seperator)
	set @clm11_string  = dbo.fn_ListAppend(@clm11_string, @clm11_country_code , @isa16_component_element_seperator)

	INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col006, col007, col008, col009, col010, col011, col012, col013, col017, col019, col020, col021)
		Values (	CAST(@x12_interchange_uid as varchar(36)),  'CLM',
				UPPER(LTRIM(RTRIM(@clm01_pt_acct_num))),
				case	when @clm02_total_claim_chg_amt = 0 then '0'
					else dbo.fn_LTrimPat(cast (@clm02_total_claim_chg_amt as varchar(255)), '0')
				end,
				UPPER(LTRIM(RTRIM(@clm05_string))),
				UPPER(LTRIM(RTRIM(@clm06_provider_signature_ind))),
				UPPER(LTRIM(RTRIM(@clm07_medicare_assign_code))),
				UPPER(LTRIM(RTRIM(@clm08_benefit_assign_ind))),
				UPPER(LTRIM(RTRIM(@clm09_release_of_info_code))),
				UPPER(LTRIM(RTRIM(@clm10_patient_signature_code))),
				UPPER(LTRIM(RTRIM(@clm11_string))),
				UPPER(LTRIM(RTRIM(@clm12_special_prog_ind))),
				UPPER(LTRIM(RTRIM(@clm16_participation_agreement))),
				UPPER(LTRIM(RTRIM(@clm18_eob_indicator))),
				UPPER(LTRIM(RTRIM(@clm19_claim_submission_reason_code))),
				UPPER(LTRIM(RTRIM(@clm20_delay_reason_code)))
			)


