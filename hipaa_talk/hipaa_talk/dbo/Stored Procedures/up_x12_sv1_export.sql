

CREATE Procedure [dbo].[up_x12_sv1_export] (	@x12_interchange_uid uniqueidentifier,
					@sv101_proc_code_qual char(2),
					@sv101_proc_code varchar(48),
					@sv101_proc_mod1 char(2),
					@sv101_proc_mod2 char(2),
					@sv101_proc_mod3 char(2),
					@sv101_proc_mod4 char(2),
					@sv102_line_charge money,
					@sv103_measurement_code char(2),
					@sv104_service_unit_count varchar(15),
					@sv105_place_of_service char(2),
					@sv107_dx_pointer1 char(2),
					@sv107_dx_pointer2 char(2),
					@sv107_dx_pointer3 char(2),
					@sv107_dx_pointer4 char(2),
					@sv109_emergency_indicator char(1),
					@sv111_epsdt_indicator char(1),
					@sv112_family_plan_indicator char(1),
					@sv115_copay_status_code char(1)
				   )
As
	declare @dxpointer nvarchar(15)

	declare @isa16_component_element_seperator char(1)

	select @isa16_component_element_seperator = isa16_component_element_seperator
	from x12_interchange
	where x12_interchange_uid = @x12_interchange_uid

	if (@isa16_component_element_seperator IS NULL OR @isa16_component_element_seperator = ' ')
	begin
		set @isa16_component_element_seperator = ':'
	end

	-- If the procedure qualifier (HC or NU) was not specified, use HC as a default
	if (@sv101_proc_code_qual IS NULL)
	begin
		set @sv101_proc_code_qual = 'HC'
	end

	-- Prepend the procedure code with the procedure qualifier (HC or NU)
	set @sv101_proc_code = dbo.fn_ListPrepend(@sv101_proc_code, LTrim(RTrim(@sv101_proc_code_qual)), @isa16_component_element_seperator)

	-- For each modifier, append it to the procedure code string with a colon seperator
	set @sv101_proc_code = dbo.fn_ListAppend(@sv101_proc_code, LTrim(RTrim(@sv101_proc_mod1)), @isa16_component_element_seperator)
	set @sv101_proc_code = dbo.fn_ListAppend(@sv101_proc_code, LTrim(RTrim(@sv101_proc_mod2)), @isa16_component_element_seperator)
	set @sv101_proc_code = dbo.fn_ListAppend(@sv101_proc_code, LTrim(RTrim(@sv101_proc_mod3)), @isa16_component_element_seperator)
	set @sv101_proc_code = dbo.fn_ListAppend(@sv101_proc_code, LTrim(RTrim(@sv101_proc_mod4)), @isa16_component_element_seperator)

	-- For each diagnosis code pointer, append it to the pointer string with a colon seperator
	set @dxpointer = dbo.fn_listAppend(@dxpointer, LTrim(RTrim(@sv107_dx_pointer1)), @isa16_component_element_seperator)
	set @dxpointer = dbo.fn_listAppend(@dxpointer, LTrim(RTrim(@sv107_dx_pointer2)), @isa16_component_element_seperator)  
	set @dxpointer = dbo.fn_listAppend(@dxpointer, LTrim(RTrim(@sv107_dx_pointer3)), @isa16_component_element_seperator) 
	set @dxpointer = dbo.fn_listAppend(@dxpointer, LTrim(RTrim(@sv107_dx_pointer4)), @isa16_component_element_seperator) 

-- The "HC" is only for professional claims, NU will be required for UB92 codes

	INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col008, col010, col012, col013, col016)
		Values	(	@x12_interchange_uid,
				'SV1',
				UPPER(LTrim(RTrim(@sv101_proc_code))),
				case	when @sv102_line_charge = 0 then '0'
					else dbo.fn_LTrimPat(cast (@sv102_line_charge as varchar(255)), '0')
				end, 
				UPPER(LTrim(RTrim(@sv103_measurement_code))),
				UPPER(LTrim(RTrim(@sv104_service_unit_count))),
				UPPER(LTrim(RTrim(@sv105_place_of_service))),
				UPPER(LTrim(RTrim(@dxpointer))),
				UPPER(LTrim(RTrim(@sv109_emergency_indicator))),
				UPPER(LTrim(RTrim(@sv111_epsdt_indicator))),
				UPPER(LTrim(RTrim(@sv112_family_plan_indicator))),
				UPPER(LTrim(RTrim(@sv115_copay_status_code)))
			)
