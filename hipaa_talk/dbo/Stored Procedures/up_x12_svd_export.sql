


CREATE Procedure [dbo].[up_x12_svd_export] (	@x12_interchange_uid uniqueidentifier,
					@svd01_other_payer_id varchar(80) = null,
					@svd02_service_line_paid money = null,
					@svd03_proc_code_qual char(2) = null,
					@svd103_proc_code varchar(48) = null,
					@svd103_proc_mod1 char(2) = null,
					@svd103_proc_mod2 char(2) = null,
					@svd103_proc_mod3 char(2) = null,
					@svd103_proc_mod4 char(2) = null,
					@svd103_proc_code_desc varchar(80) = null,
					@svd104_rev_code varchar(48) = null,
					@svd105_paid_service_count varchar(15) = null,
					@svd106_bundled_line_num varchar(6) = null
				   )
As
	declare @isa16_component_element_seperator char(1)

	select @isa16_component_element_seperator = isa16_component_element_seperator
	from x12_interchange
	where x12_interchange_uid = @x12_interchange_uid

	if (@isa16_component_element_seperator IS NULL OR @isa16_component_element_seperator = ' ')
	begin
		set @isa16_component_element_seperator = ':'
	end

	-- If the procedure qualifier (HC or NU) was not specified, use HC as a default
	if (@svd03_proc_code_qual IS NULL)
	begin
		-- The "HC" is only for professional claims, NU is required for UB92 codes
		set @svd03_proc_code_qual = 'HC'
	end

	if (@svd103_proc_code IS NULL)
	begin
		set @svd103_proc_code = null
	end
	else
	begin
		-- Prepend the procedure code with the procedure qualifier (HC or NU)
		set @svd103_proc_code = dbo.fn_ListPrepend(@svd103_proc_code, LTrim(RTrim(@svd03_proc_code_qual)), @isa16_component_element_seperator)
	
		-- For each modifier, append it to the procedure code string with a colon seperator
		set @svd103_proc_code = dbo.fn_ListAppend(@svd103_proc_code, LTrim(RTrim(@svd103_proc_mod1)), @isa16_component_element_seperator)
		set @svd103_proc_code = dbo.fn_ListAppend(@svd103_proc_code, LTrim(RTrim(@svd103_proc_mod2)), @isa16_component_element_seperator)
		set @svd103_proc_code = dbo.fn_ListAppend(@svd103_proc_code, LTrim(RTrim(@svd103_proc_mod3)), @isa16_component_element_seperator)
		set @svd103_proc_code = dbo.fn_ListAppend(@svd103_proc_code, LTrim(RTrim(@svd103_proc_mod4)), @isa16_component_element_seperator)
		set @svd103_proc_code = dbo.fn_ListAppend(@svd103_proc_code, LTrim(RTrim(@svd103_proc_code_desc)), @isa16_component_element_seperator)
	end

	-- Prefix the revenue code with a '0' if it's only 3 digits and doesn't have a 0 to start
	if (	Len(LTrim(RTrim(@svd104_rev_code))) = 3 AND
		Left(LTrim(RTrim(@svd104_rev_code)), 1) <> '0' )
	begin
		set @svd104_rev_code = '0' + LTrim(RTrim(@svd104_rev_code))
	end

	INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007)
		Values	(	@x12_interchange_uid,
				'SVD',
				UPPER(LTrim(RTrim(@svd01_other_payer_id))),
				case	when @svd02_service_line_paid = 0 then '0'
					else dbo.fn_LTrimPat(cast (@svd02_service_line_paid as varchar(255)), '0')
				end, 
				UPPER(LTrim(RTrim(@svd103_proc_code))),
				UPPER(LTrim(RTrim(@svd104_rev_code))),
				UPPER(LTrim(RTrim(@svd105_paid_service_count))),
				UPPER(LTrim(RTrim(@svd106_bundled_line_num)))
			)
