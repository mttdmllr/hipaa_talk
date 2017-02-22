

CREATE Procedure [dbo].[up_x12_svc_export] (	@x12_interchange_uid uniqueidentifier,
					@svc01_proc_code_qual char(2) = null,
					@svc01_proc_code varchar(48) = null,
					@svc01_proc_mod1 char(2) = null,
					@svc01_proc_mod2 char(2) = null,
					@svc01_proc_mod3 char(2) = null,
					@svc01_proc_mod4 char(2) = null,
					@svc01_proc_desc varchar(80) = null,
					@svc02_line_charge money = null,
					@svc03_line_item_prov_pmt_amt money = null,
					@svc04_revenue_code varchar(48) = null,
					@svc05_units_paid varchar(15) = null,
					@svc06_proc_code_qual char(2) = null,
					@svc06_proc_code varchar(48) = null,
					@svc06_proc_mod1 char(2) = null,
					@svc06_proc_mod2 char(2) = null,
					@svc06_proc_mod3 char(2) = null,
					@svc06_proc_mod4 char(2) = null,
					@svc06_proc_desc varchar(80) = null,
					@svc07_units varchar(15) = null
				   )
As
declare @svc01 varchar(80)
declare @svc06 varchar(80)

	declare @isa16_component_element_seperator char(1)

	select @isa16_component_element_seperator = isa16_component_element_seperator
	from x12_interchange
	where x12_interchange_uid = @x12_interchange_uid

	if (@isa16_component_element_seperator IS NULL OR @isa16_component_element_seperator = ' ')
	begin
		set @isa16_component_element_seperator = ':'
	end

	-- If the revenue code is 3-digits, prepend a 0.
	if ( Len(LTrim(RTrim(@svc04_revenue_code))) = 3 )
	begin
		set @svc04_revenue_code = '0' + @svc04_revenue_code
	end

	-- If the procedure qualifier (HC or NU) was not specified, use HC as a default
	if (@svc01_proc_code_qual IS NULL)
	begin
		set @svc01_proc_code_qual = 'HC'
	end
	-- When the qualifier is NU, the revenue code is used in SVC01-Procedure Code, and not used in the SVC04 field.
	if (	@svc01_proc_code_qual = 'NU' OR
		(Len(IsNull(@svc01_proc_code, '')) = 0 AND @svc04_revenue_code IS NOT NULL)
	   )
	begin
		set @svc01_proc_code_qual = 'NU'
		set @svc01_proc_code = IsNull(@svc01_proc_code, @svc04_revenue_code)
		set @svc04_revenue_code = null

		if ( Len(LTrim(RTrim(@svc01_proc_code))) = 3 )
		begin
			set @svc01_proc_code = '0' + @svc01_proc_code
		end
	end

	-- Prepend the procedure code string with the procedure qualifier (HC or NU)
	set @svc01 = dbo.fn_ListPrepend(@svc01, LTrim(RTrim(@svc01_proc_code_qual)), @isa16_component_element_seperator)

	-- Append the procedure code string with the procedure code
	set @svc01 = dbo.fn_ListAppend(@svc01, LTrim(RTrim(@svc01_proc_code)), @isa16_component_element_seperator)

	-- For each modifier, append it to the procedure code string with a colon seperator
	set @svc01 = dbo.fn_ListAppend(@svc01, LTrim(RTrim(@svc01_proc_mod1)), @isa16_component_element_seperator)
	set @svc01 = dbo.fn_ListAppend(@svc01, LTrim(RTrim(@svc01_proc_mod2)), @isa16_component_element_seperator)
	set @svc01 = dbo.fn_ListAppend(@svc01, LTrim(RTrim(@svc01_proc_mod3)), @isa16_component_element_seperator)
	set @svc01 = dbo.fn_ListAppend(@svc01, LTrim(RTrim(@svc01_proc_mod4)), @isa16_component_element_seperator)


	if ( Len(IsNull(@svc06_proc_code, '')) > 0 )
	begin
	
		-- When the qualifier is NU, the revenue code is used in SVC01-Procedure Code, and not used in the SVC04 field.
		if ( Len(@svc06_proc_code) = 3 )
		begin
			set @svc06_proc_code_qual = 'NU'
			set @svc06_proc_code = '0' + @svc06_proc_code
		end
		else if ( Len(@svc06_proc_code) = 4 )
		begin
			set @svc06_proc_code_qual = 'NU'
		end

		-- If the procedure qualifier (HC or NU) was not specified, use HC as a default
		if (@svc06_proc_code_qual IS NULL)
		begin
			set @svc06_proc_code_qual = 'HC'
		end
	
		-- Prepend the procedure code string with the procedure qualifier (HC or NU)
		set @svc06 = dbo.fn_ListPrepend(@svc01, LTrim(RTrim(@svc06_proc_code_qual)), @isa16_component_element_seperator)
	
		-- Append the procedure code string with the procedure code
		set @svc06 = dbo.fn_ListAppend(@svc01, LTrim(RTrim(@svc06_proc_code)), @isa16_component_element_seperator)
	
		-- For each modifier, append it to the procedure code string with a colon seperator
		set @svc06 = dbo.fn_ListAppend(@svc01, LTrim(RTrim(@svc06_proc_mod1)), @isa16_component_element_seperator)
		set @svc06 = dbo.fn_ListAppend(@svc01, LTrim(RTrim(@svc06_proc_mod2)), @isa16_component_element_seperator)
		set @svc06 = dbo.fn_ListAppend(@svc01, LTrim(RTrim(@svc06_proc_mod3)), @isa16_component_element_seperator)
		set @svc06 = dbo.fn_ListAppend(@svc01, LTrim(RTrim(@svc06_proc_mod4)), @isa16_component_element_seperator)
	end

	INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col008)
		Values	(	@x12_interchange_uid,
				'SVC',
				UPPER(LTrim(RTrim(@svc01))),
				case	when IsNull(@svc02_line_charge, 0) = 0 then '0'
					else dbo.fn_trim_leading_zero(cast (@svc02_line_charge as varchar(255)))
				end, 
				case	when IsNull(@svc03_line_item_prov_pmt_amt, 0) = 0 then '0'
					else dbo.fn_trim_leading_zero(cast (@svc03_line_item_prov_pmt_amt as varchar(255)))
				end, 
				UPPER(LTrim(RTrim(@svc04_revenue_code))),
				UPPER(LTrim(RTrim(@svc05_units_paid))),
				UPPER(LTrim(RTrim(@svc06))),
				UPPER(LTrim(RTrim(@svc07_units)))
			)
