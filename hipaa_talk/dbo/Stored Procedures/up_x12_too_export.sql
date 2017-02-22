

CREATE Procedure [dbo].[up_x12_too_export] (	@x12_interchange_uid uniqueidentifier,
					@too02_JP_tooth_code varchar(30),
					@too03_tooth_surface_code_1 char(2),
					@too03_tooth_surface_code_2 char(2),
					@too03_tooth_surface_code_3 char(2),
					@too03_tooth_surface_code_4 char(2),
					@too03_tooth_surface_code_5 char(2)
				   )
As
	declare @tooth_surface_pointer nvarchar(15)

	declare @isa16_component_element_seperator char(1)

	select @isa16_component_element_seperator = isa16_component_element_seperator
	from x12_interchange
	where x12_interchange_uid = @x12_interchange_uid

	if (@isa16_component_element_seperator IS NULL OR @isa16_component_element_seperator = ' ')
	begin
		set @isa16_component_element_seperator = ':'
	end

	-- For each tooth_surface_code pointer, append it to the pointer string with a colon seperator
	set @tooth_surface_pointer = dbo.fn_listAppend(@tooth_surface_pointer, LTrim(RTrim(@too03_tooth_surface_code_1)), @isa16_component_element_seperator)
	set @tooth_surface_pointer = dbo.fn_listAppend(@tooth_surface_pointer, LTrim(RTrim(@too03_tooth_surface_code_2)), @isa16_component_element_seperator)  
	set @tooth_surface_pointer = dbo.fn_listAppend(@tooth_surface_pointer, LTrim(RTrim(@too03_tooth_surface_code_3)), @isa16_component_element_seperator) 
	set @tooth_surface_pointer = dbo.fn_listAppend(@tooth_surface_pointer, LTrim(RTrim(@too03_tooth_surface_code_4)), @isa16_component_element_seperator) 
	set @tooth_surface_pointer = dbo.fn_listAppend(@tooth_surface_pointer, LTrim(RTrim(@too03_tooth_surface_code_5)), @isa16_component_element_seperator) 

	INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004)
		Values	(	@x12_interchange_uid,
				'TOO',
				'JP',
				UPPER(LTrim(RTrim(@too02_JP_tooth_code))),
				UPPER(LTrim(RTrim(@tooth_surface_pointer)))
			)
