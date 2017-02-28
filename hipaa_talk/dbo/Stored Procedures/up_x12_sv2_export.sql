

CREATE Procedure [dbo].[up_x12_sv2_export] (	@x12_interchange_uid uniqueidentifier,
					@sv201_rev_code varchar(48) = null,
					@sv202_proc_code_qual char(2) = null,
					@sv202_proc_code varchar(48) = null,
					@sv202_proc_mod1 char(2) = null,
					@sv202_proc_mod2 char(2) = null,
					@sv202_proc_mod3 char(2) = null,
					@sv202_proc_mod4 char(2) = null,
					@sv203_line_charge money = null,
					@sv204_measurement_code char(2) = null,
					@sv205_service_unit_count varchar(15) = null,
					@sv206_service_line_rate varchar(10) = null,
					@sv207_denied_amt money = null
				   )
As
	declare @svc02 varchar(80)
	declare @isa16_component_element_seperator char(1)

	select @isa16_component_element_seperator = isa16_component_element_seperator
	from x12_interchange
	where x12_interchange_uid = @x12_interchange_uid

	if (@isa16_component_element_seperator IS NULL OR @isa16_component_element_seperator = ' ')
	begin
		set @isa16_component_element_seperator = ':'
	end

	-- Prefix the revenue code with a '0' if it's only 3 digits and doesn't have a 0 to start
	if (	Len(LTrim(RTrim(@sv201_rev_code))) = 3 AND
		Left(LTrim(RTrim(@sv201_rev_code)), 1) <> '0' )
	begin
		set @sv201_rev_code = '0' + LTrim(RTrim(@sv201_rev_code))
	end

	-- The "HC" is only for professional claims, NU will be required for UB92 codes
	if	(	@sv202_proc_code_qual IS NULL OR 
			(	@sv202_proc_code_qual <> 'HC' AND
				@sv202_proc_code_qual <> 'IV' AND
				@sv202_proc_code_qual <> 'ZZ'
			) AND
			@sv202_proc_code IS NOT NULL
		)
	begin
		-- If the procedure qualifier (HC, IV, ZZ) was not specified, use HC as a default
		set @sv202_proc_code_qual = 'HC'
	end

	if (@sv202_proc_code IS NULL)
	begin
		set @svc02 = null
	end
	else
	begin
		-- Prepend the procedure code with the procedure qualifier (HC or NU)
		set @svc02 = dbo.fn_ListPrepend(@svc02, LTrim(RTrim(@sv202_proc_code_qual)), @isa16_component_element_seperator)
		-- Append the procedure code
		set @svc02 = dbo.fn_ListAppend(@svc02, LTrim(RTrim(@sv202_proc_code)), @isa16_component_element_seperator)
	
		-- For each modifier, append it to the procedure code string with a colon seperator
		set @svc02 = dbo.fn_ListAppend(@svc02, LTrim(RTrim(@sv202_proc_mod1)), @isa16_component_element_seperator)
		set @svc02 = dbo.fn_ListAppend(@svc02, LTrim(RTrim(@sv202_proc_mod2)), @isa16_component_element_seperator)
		set @svc02 = dbo.fn_ListAppend(@svc02, LTrim(RTrim(@sv202_proc_mod3)), @isa16_component_element_seperator)
		set @svc02 = dbo.fn_ListAppend(@svc02, LTrim(RTrim(@sv202_proc_mod4)), @isa16_component_element_seperator)
	end

	INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col008)
		Values	(	@x12_interchange_uid,
				'SV2',
				@sv201_rev_code,
				UPPER(LTrim(RTrim(@svc02))),
				case	when @sv203_line_charge = 0 then '0'
					else dbo.fn_LTrimPat(cast (@sv203_line_charge as varchar(255)), '0')
				end, 
				UPPER(LTrim(RTrim(@sv204_measurement_code))),
				UPPER(LTrim(RTrim(@sv205_service_unit_count))),
				UPPER(LTrim(RTrim(@sv206_service_line_rate))),
				case	when @sv207_denied_amt = 0 then '0'
					else dbo.fn_LTrimPat(cast (@sv207_denied_amt as varchar(255)), '0')
				end
			)
