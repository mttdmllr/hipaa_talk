

CREATE Procedure [dbo].[up_x12_sv3_export] (	@x12_interchange_uid uniqueidentifier,
					@sv301_proc_code_qual char(2),
					@sv301_proc_code varchar(48),
					@sv301_proc_mod1 char(2),
					@sv301_proc_mod2 char(2),
					@sv301_proc_mod3 char(2),
					@sv301_proc_mod4 char(2),
					@sv302_line_charge money,
					@sv303_facility_type_code varchar(3),
					@sv304_oral_cavity_designation_code_1 char(3),
					@sv304_oral_cavity_designation_code_2 char(3),
					@sv304_oral_cavity_designation_code_3 char(3),
					@sv304_oral_cavity_designation_code_4 char(3),
					@sv304_oral_cavity_designation_code_5 char(3),
					@sv305_prosthesis_crown_inlay_code char(1),
					@sv306_procedure_count varchar(15)
				   )
As
	declare @oral_cavity_pointer nvarchar(15)

	declare @isa16_component_element_seperator char(1)

	select @isa16_component_element_seperator = isa16_component_element_seperator
	from x12_interchange
	where x12_interchange_uid = @x12_interchange_uid

	if (@isa16_component_element_seperator IS NULL OR @isa16_component_element_seperator = ' ')
	begin
		set @isa16_component_element_seperator = ':'
	end

	-- If the procedure qualifier (AD) was not specified, use AD as a default
	if (@sv301_proc_code_qual IS NULL)
	begin
		set @sv301_proc_code_qual = 'AD'
	end

	-- Prepend the procedure code with the procedure qualifier (AD)
	set @sv301_proc_code = dbo.fn_ListPrepend(@sv301_proc_code, LTrim(RTrim(@sv301_proc_code_qual)), @isa16_component_element_seperator)

	-- For each modifier, append it to the procedure code string with a colon seperator
	set @sv301_proc_code = dbo.fn_ListAppend(@sv301_proc_code, LTrim(RTrim(@sv301_proc_mod1)), @isa16_component_element_seperator)
	set @sv301_proc_code = dbo.fn_ListAppend(@sv301_proc_code, LTrim(RTrim(@sv301_proc_mod2)), @isa16_component_element_seperator)
	set @sv301_proc_code = dbo.fn_ListAppend(@sv301_proc_code, LTrim(RTrim(@sv301_proc_mod3)), @isa16_component_element_seperator)
	set @sv301_proc_code = dbo.fn_ListAppend(@sv301_proc_code, LTrim(RTrim(@sv301_proc_mod4)), @isa16_component_element_seperator)

	-- For each oral_cavity_designation_code pointer, append it to the pointer string with a colon seperator
	set @oral_cavity_pointer = dbo.fn_listAppend(@oral_cavity_pointer, LTrim(RTrim(@sv304_oral_cavity_designation_code_1)), @isa16_component_element_seperator)
	set @oral_cavity_pointer = dbo.fn_listAppend(@oral_cavity_pointer, LTrim(RTrim(@sv304_oral_cavity_designation_code_2)), @isa16_component_element_seperator)  
	set @oral_cavity_pointer = dbo.fn_listAppend(@oral_cavity_pointer, LTrim(RTrim(@sv304_oral_cavity_designation_code_3)), @isa16_component_element_seperator) 
	set @oral_cavity_pointer = dbo.fn_listAppend(@oral_cavity_pointer, LTrim(RTrim(@sv304_oral_cavity_designation_code_4)), @isa16_component_element_seperator) 
	set @oral_cavity_pointer = dbo.fn_listAppend(@oral_cavity_pointer, LTrim(RTrim(@sv304_oral_cavity_designation_code_5)), @isa16_component_element_seperator) 

-- The "AD" is only for dental claims.

	INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007)
		Values	(	@x12_interchange_uid,
				'SV3',
				UPPER(LTrim(RTrim(@sv301_proc_code))),
				case	when @sv302_line_charge = 0 then '0'
					else dbo.fn_LTrimPat(cast (@sv302_line_charge as varchar(255)), '0')
				end, 
				UPPER(LTrim(RTrim(@sv303_facility_type_code))),
				UPPER(LTrim(RTrim(@oral_cavity_pointer))),
				UPPER(LTrim(RTrim(@sv305_prosthesis_crown_inlay_code))),
				UPPER(LTrim(RTrim(@sv306_procedure_count)))
			)
