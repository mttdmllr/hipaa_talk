CREATE Procedure [dbo].[up_x12_hi_export] (
					@x12_interchange_uid uniqueidentifier,
					@hi01_code_list_qual_code varchar(3) = null,
					@hi01_code varchar(30) = null,
					@hi01_code_date_qual varchar(3) = null,
					@hi01_code_date varchar(35) = null,
					@hi01_code_amount money = null,
					@hi02_code_list_qual_code varchar(3) = null,
					@hi02_code varchar(30) = null,
					@hi02_code_date_qual varchar(3) = null,
					@hi02_code_date varchar(35) = null,
					@hi02_code_amount money = null,
					@hi03_code_list_qual_code varchar(3) = null,
					@hi03_code varchar(30) = null,
					@hi03_code_date_qual varchar(3) = null,
					@hi03_code_date varchar(35) = null,
					@hi03_code_amount money = null,
					@hi04_code_list_qual_code varchar(3) = null,
					@hi04_code varchar(30) = null,
					@hi04_code_date_qual varchar(3) = null,
					@hi04_code_date varchar(35) = null,
					@hi04_code_amount money = null,
					@hi05_code_list_qual_code varchar(3) = null,
					@hi05_code varchar(30) = null,
					@hi05_code_date_qual varchar(3) = null,
					@hi05_code_date varchar(35) = null,
					@hi05_code_amount money = null,
					@hi06_code_list_qual_code varchar(3) = null,
					@hi06_code varchar(30) = null,
					@hi06_code_date_qual varchar(3) = null,
					@hi06_code_date varchar(35) = null,
					@hi06_code_amount money = null,
					@hi07_code_list_qual_code varchar(3) = null,
					@hi07_code varchar(30) = null,
					@hi07_code_date_qual varchar(3) = null,
					@hi07_code_date varchar(35) = null,
					@hi07_code_amount money = null,
					@hi08_code_list_qual_code varchar(3) = null,
					@hi08_code varchar(30) = null,
					@hi08_code_date_qual varchar(3) = null,
					@hi08_code_date varchar(35) = null,
					@hi08_code_amount money = null,
					@hi09_code_list_qual_code varchar(3) = null,
					@hi09_code varchar(30) = null,
					@hi09_code_date_qual varchar(3) = null,
					@hi09_code_date varchar(35) = null,
					@hi09_code_amount money = null,
					@hi10_code_list_qual_code varchar(3) = null,
					@hi10_code varchar(30) = null,
					@hi10_code_date_qual varchar(3) = null,
					@hi10_code_date varchar(35) = null,
					@hi10_code_amount money = null,
					@hi11_code_list_qual_code varchar(3) = null,
					@hi11_code varchar(30) = null,
					@hi11_code_date_qual varchar(3) = null,
					@hi11_code_date varchar(35) = null,
					@hi11_code_amount money = null,
					@hi12_code_list_qual_code varchar(3) = null,
					@hi12_code varchar(30) = null,
					@hi12_code_date_qual varchar(3) = null,
					@hi12_code_date varchar(35) = null,
					@hi12_code_amount money = null
				   )
As

	declare @hi01 varchar(80)
	declare @hi02 varchar(80)
	declare @hi03 varchar(80)
	declare @hi04 varchar(80)
	declare @hi05 varchar(80)
	declare @hi06 varchar(80)
	declare @hi07 varchar(80)
	declare @hi08 varchar(80)
	declare @hi09 varchar(80)
	declare @hi10 varchar(80)
	declare @hi11 varchar(80)
	declare @hi12 varchar(80)

	declare @isa16_component_element_seperator char(1)

	select @isa16_component_element_seperator = isa16_component_element_seperator
	from x12_interchange
	where x12_interchange_uid = @x12_interchange_uid

	if (@isa16_component_element_seperator IS NULL OR @isa16_component_element_seperator = ' ')
	begin
		set @isa16_component_element_seperator = ':'
	end

	-- These variables are used to convert the money fields to
	declare	@hi01_code_amount_str varchar(30),
		@hi02_code_amount_str varchar(30),
		@hi03_code_amount_str varchar(30),
		@hi04_code_amount_str varchar(30),
		@hi05_code_amount_str varchar(30),
		@hi06_code_amount_str varchar(30),
		@hi07_code_amount_str varchar(30),
		@hi08_code_amount_str varchar(30),
		@hi09_code_amount_str varchar(30),
		@hi10_code_amount_str varchar(30),
		@hi11_code_amount_str varchar(30),
		@hi12_code_amount_str varchar(30)

	-- Convert the money fields to string
	select	@hi01_code_amount_str = case	when @hi01_code_amount = 0 then '0'
						else dbo.fn_LTrimPat(cast(@hi01_code_amount as varchar(255)), '0')
					end,
		@hi02_code_amount_str = case	when @hi02_code_amount = 0 then '0'
						else dbo.fn_LTrimPat(cast(@hi02_code_amount as varchar(255)), '0')
					end,
		@hi03_code_amount_str = case	when @hi03_code_amount = 0 then '0'
						else dbo.fn_LTrimPat(cast(@hi03_code_amount as varchar(255)), '0')
					end,
		@hi04_code_amount_str = case	when @hi04_code_amount = 0 then '0'
						else dbo.fn_LTrimPat(cast(@hi04_code_amount as varchar(255)), '0')
					end,
		@hi05_code_amount_str = case	when @hi05_code_amount = 0 then '0'
						else dbo.fn_LTrimPat(cast(@hi05_code_amount as varchar(255)), '0')
					end,
		@hi06_code_amount_str = case	when @hi06_code_amount = 0 then '0'
						else dbo.fn_LTrimPat(cast(@hi06_code_amount as varchar(255)), '0')
					end,
		@hi07_code_amount_str = case	when @hi07_code_amount = 0 then '0'
						else dbo.fn_LTrimPat(cast(@hi07_code_amount as varchar(255)), '0')
					end,
		@hi08_code_amount_str = case	when @hi08_code_amount = 0 then '0'
						else dbo.fn_LTrimPat(cast(@hi08_code_amount as varchar(255)), '0')
					end,
		@hi09_code_amount_str = case	when @hi09_code_amount = 0 then '0'
						else dbo.fn_LTrimPat(cast(@hi09_code_amount as varchar(255)), '0')
					end,
		@hi10_code_amount_str = case	when @hi10_code_amount = 0 then '0'
						else dbo.fn_LTrimPat(cast(@hi10_code_amount as varchar(255)), '0')
					end,
		@hi11_code_amount_str = case	when @hi11_code_amount = 0 then '0'
						else dbo.fn_LTrimPat(cast(@hi11_code_amount as varchar(255)), '0')
					end,
		@hi12_code_amount_str = case	when @hi12_code_amount = 0 then '0'
						else dbo.fn_LTrimPat(cast(@hi12_code_amount as varchar(255)), '0')
					end


	-- Append the list items
	set @hi01 = @hi01_code_list_qual_code + @isa16_component_element_seperator + @hi01_code
	-- if the code date is specified, add it
	if (@hi01_code_date IS NOT NULL AND @hi01_code IS NOT NULL)
	begin
		if ( @hi01_code_date_qual IS NULL AND CHARINDEX('-', @hi01_code_date) > 0 )
		begin
			set @hi01_code_date_qual = 'RD8'
		end
		else
		begin
			set @hi01_code_date_qual = 'D8'
		end

		set @hi01 = dbo.fn_ListAppend(@hi01, @hi01_code_date_qual, @isa16_component_element_seperator)
		set @hi01 = dbo.fn_ListAppend(@hi01, @hi01_code_date, @isa16_component_element_seperator)
	end
	-- if the code amount is specified, add it with two delimiters because there should be two blanks before it.
	else if ( @hi01_code_amount IS NOT NULL AND @hi01_code IS NOT NULL)
	begin
		set @hi01 = dbo.fn_ListAppend(@hi01, @isa16_component_element_seperator + @isa16_component_element_seperator + @hi01_code_amount_str, @isa16_component_element_seperator)
	end

	-- RINSE AND REPEAT
	set @hi02 = @hi02_code_list_qual_code + @isa16_component_element_seperator + @hi02_code
	if (@hi02_code_date IS NOT NULL AND @hi02_code IS NOT NULL)
	begin
		if ( @hi02_code_date_qual IS NULL AND CHARINDEX('-', @hi02_code_date) > 0 )
		begin
			set @hi02_code_date_qual = 'RD8'
		end
		else
		begin
			set @hi02_code_date_qual = 'D8'
		end

		set @hi02 = dbo.fn_ListAppend(@hi02, @hi02_code_date_qual, @isa16_component_element_seperator)
		set @hi02 = dbo.fn_ListAppend(@hi02, @hi02_code_date, @isa16_component_element_seperator)
	end
	else if ( @hi02_code_amount IS NOT NULL AND @hi02_code IS NOT NULL)
	begin
		set @hi02 = dbo.fn_ListAppend(@hi02, @isa16_component_element_seperator + @isa16_component_element_seperator + @hi02_code_amount_str, @isa16_component_element_seperator)
	end

	set @hi03 = @hi03_code_list_qual_code + @isa16_component_element_seperator + @hi03_code
	if (@hi03_code_date IS NOT NULL AND @hi03_code IS NOT NULL)
	begin
		if ( @hi03_code_date_qual IS NULL AND CHARINDEX('-', @hi03_code_date) > 0 )
		begin
			set @hi03_code_date_qual = 'RD8'
		end
		else
		begin
			set @hi03_code_date_qual = 'D8'
		end

		set @hi03 = dbo.fn_ListAppend(@hi03, @hi03_code_date_qual, @isa16_component_element_seperator)
		set @hi03 = dbo.fn_ListAppend(@hi03, @hi03_code_date, @isa16_component_element_seperator)
	end
	else if ( @hi03_code_amount IS NOT NULL AND @hi03_code IS NOT NULL)
	begin
		set @hi03 = dbo.fn_ListAppend(@hi03, @isa16_component_element_seperator + @isa16_component_element_seperator + @hi03_code_amount_str, @isa16_component_element_seperator)
	end

	set @hi04 = @hi04_code_list_qual_code + @isa16_component_element_seperator + @hi04_code
	if (@hi04_code_date IS NOT NULL AND @hi04_code IS NOT NULL)
	begin
		if ( @hi04_code_date_qual IS NULL AND CHARINDEX('-', @hi04_code_date) > 0 )
		begin
			set @hi04_code_date_qual = 'RD8'
		end
		else
		begin
			set @hi04_code_date_qual = 'D8'
		end

		set @hi04 = dbo.fn_ListAppend(@hi04, @hi04_code_date_qual, @isa16_component_element_seperator)
		set @hi04 = dbo.fn_ListAppend(@hi04, @hi04_code_date, @isa16_component_element_seperator)
	end
	else if ( @hi04_code_amount IS NOT NULL AND @hi04_code IS NOT NULL)
	begin
		set @hi04 = dbo.fn_ListAppend(@hi04, @isa16_component_element_seperator + @isa16_component_element_seperator + @hi04_code_amount_str, @isa16_component_element_seperator)
	end

	set @hi05 = @hi05_code_list_qual_code + @isa16_component_element_seperator + @hi05_code
	if (@hi05_code_date IS NOT NULL AND @hi05_code IS NOT NULL)
	begin
		if ( @hi05_code_date_qual IS NULL AND CHARINDEX('-', @hi05_code_date) > 0 )
		begin
			set @hi05_code_date_qual = 'RD8'
		end
		else
		begin
			set @hi05_code_date_qual = 'D8'
		end

		set @hi05 = dbo.fn_ListAppend(@hi05, @hi05_code_date_qual, @isa16_component_element_seperator)
		set @hi05 = dbo.fn_ListAppend(@hi05, @hi05_code_date, @isa16_component_element_seperator)
	end
	else if ( @hi05_code_amount IS NOT NULL AND @hi05_code IS NOT NULL)
	begin
		set @hi05 = dbo.fn_ListAppend(@hi05, @isa16_component_element_seperator + @isa16_component_element_seperator + @hi05_code_amount_str, @isa16_component_element_seperator)
	end

	set @hi06 = @hi06_code_list_qual_code + @isa16_component_element_seperator + @hi06_code
	if (@hi06_code_date IS NOT NULL AND @hi06_code IS NOT NULL)
	begin
		if ( @hi06_code_date_qual IS NULL AND CHARINDEX('-', @hi06_code_date) > 0 )
		begin
			set @hi06_code_date_qual = 'RD8'
		end
		else
		begin
			set @hi06_code_date_qual = 'D8'
		end

		set @hi06 = dbo.fn_ListAppend(@hi06, @hi06_code_date_qual, @isa16_component_element_seperator)
		set @hi06 = dbo.fn_ListAppend(@hi06, @hi06_code_date, @isa16_component_element_seperator)
	end
	else if ( @hi06_code_amount IS NOT NULL AND @hi06_code IS NOT NULL)
	begin
		set @hi06 = dbo.fn_ListAppend(@hi06, @isa16_component_element_seperator + @isa16_component_element_seperator + @hi06_code_amount_str, @isa16_component_element_seperator)
	end

	set @hi07 = @hi07_code_list_qual_code + @isa16_component_element_seperator + @hi07_code
	if (@hi07_code_date IS NOT NULL AND @hi07_code IS NOT NULL)
	begin
		if ( @hi07_code_date_qual IS NULL AND CHARINDEX('-', @hi07_code_date) > 0 )
		begin
			set @hi07_code_date_qual = 'RD8'
		end
		else
		begin
			set @hi07_code_date_qual = 'D8'
		end

		set @hi07 = dbo.fn_ListAppend(@hi07, @hi07_code_date_qual, @isa16_component_element_seperator)
		set @hi07 = dbo.fn_ListAppend(@hi07, @hi07_code_date, @isa16_component_element_seperator)
	end
	else if ( @hi07_code_amount IS NOT NULL AND @hi07_code IS NOT NULL)
	begin
		set @hi07 = dbo.fn_ListAppend(@hi07, @isa16_component_element_seperator + @isa16_component_element_seperator + @hi07_code_amount_str, @isa16_component_element_seperator)
	end

	set @hi08 = @hi08_code_list_qual_code + @isa16_component_element_seperator + @hi08_code
	if (@hi08_code_date IS NOT NULL AND @hi08_code IS NOT NULL)
	begin
		if ( @hi08_code_date_qual IS NULL AND CHARINDEX('-', @hi08_code_date) > 0 )
		begin
			set @hi08_code_date_qual = 'RD8'
		end
		else
		begin
			set @hi08_code_date_qual = 'D8'
		end

		set @hi08 = dbo.fn_ListAppend(@hi08, @hi08_code_date_qual, @isa16_component_element_seperator)
		set @hi08 = dbo.fn_ListAppend(@hi08, @hi08_code_date, @isa16_component_element_seperator)
	end
	else if ( @hi08_code_amount IS NOT NULL AND @hi08_code IS NOT NULL)
	begin
		set @hi08 = dbo.fn_ListAppend(@hi08, @isa16_component_element_seperator + @isa16_component_element_seperator + @hi08_code_amount_str, @isa16_component_element_seperator)
	end

	set @hi09 = @hi09_code_list_qual_code + @isa16_component_element_seperator + @hi09_code
	if (@hi09_code_date IS NOT NULL AND @hi09_code IS NOT NULL)
	begin
		if ( @hi09_code_date_qual IS NULL AND CHARINDEX('-', @hi09_code_date) > 0 )
		begin
			set @hi09_code_date_qual = 'RD8'
		end
		else
		begin
			set @hi09_code_date_qual = 'D8'
		end

		set @hi09 = dbo.fn_ListAppend(@hi09, @hi09_code_date_qual, @isa16_component_element_seperator)
		set @hi09 = dbo.fn_ListAppend(@hi09, @hi09_code_date, @isa16_component_element_seperator)
	end
	else if ( @hi09_code_amount IS NOT NULL AND @hi09_code IS NOT NULL)
	begin
		set @hi09 = dbo.fn_ListAppend(@hi09, @isa16_component_element_seperator + @isa16_component_element_seperator + @hi09_code_amount_str, @isa16_component_element_seperator)
	end

	set @hi10 = @hi10_code_list_qual_code + @isa16_component_element_seperator + @hi10_code
	if (@hi10_code_date IS NOT NULL AND @hi10_code IS NOT NULL)
	begin
		if ( @hi10_code_date_qual IS NULL AND CHARINDEX('-', @hi10_code_date) > 0 )
		begin
			set @hi10_code_date_qual = 'RD8'
		end
		else
		begin
			set @hi10_code_date_qual = 'D8'
		end

		set @hi10 = dbo.fn_ListAppend(@hi10, @hi10_code_date_qual, @isa16_component_element_seperator)
		set @hi10 = dbo.fn_ListAppend(@hi10, @hi10_code_date, @isa16_component_element_seperator)
	end
	else if ( @hi10_code_amount IS NOT NULL AND @hi10_code IS NOT NULL)
	begin
		set @hi10 = dbo.fn_ListAppend(@hi10, @isa16_component_element_seperator + @isa16_component_element_seperator + @hi10_code_amount_str, @isa16_component_element_seperator)
	end

	set @hi11 = @hi11_code_list_qual_code + @isa16_component_element_seperator + @hi11_code
	if (@hi11_code_date IS NOT NULL AND @hi11_code IS NOT NULL)
	begin
		if ( @hi11_code_date_qual IS NULL AND CHARINDEX('-', @hi11_code_date) > 0 )
		begin
			set @hi11_code_date_qual = 'RD8'
		end
		else
		begin
			set @hi11_code_date_qual = 'D8'
		end

		set @hi11 = dbo.fn_ListAppend(@hi11, @hi11_code_date_qual, @isa16_component_element_seperator)
		set @hi11 = dbo.fn_ListAppend(@hi11, @hi11_code_date, @isa16_component_element_seperator)
	end
	else if ( @hi11_code_amount IS NOT NULL AND @hi11_code IS NOT NULL)
	begin
		set @hi11 = dbo.fn_ListAppend(@hi11, @isa16_component_element_seperator + @isa16_component_element_seperator + @hi11_code_amount_str, @isa16_component_element_seperator)
	end

	set @hi12 = @hi12_code_list_qual_code + @isa16_component_element_seperator + @hi12_code
	if (@hi12_code_date IS NOT NULL AND @hi12_code IS NOT NULL)
	begin
		if ( @hi12_code_date_qual IS NULL AND CHARINDEX('-', @hi12_code_date) > 0 )
		begin
			set @hi12_code_date_qual = 'RD8'
		end
		else
		begin
			set @hi12_code_date_qual = 'D8'
		end

		set @hi12 = dbo.fn_ListAppend(@hi12, @hi12_code_date_qual, @isa16_component_element_seperator)
		set @hi12 = dbo.fn_ListAppend(@hi12, @hi12_code_date, @isa16_component_element_seperator)
	end
	else if ( @hi12_code_amount IS NOT NULL AND @hi12_code IS NOT NULL)
	begin
		-- Double up the seperator
		set @hi12 = dbo.fn_ListAppend(@hi12, @isa16_component_element_seperator + @isa16_component_element_seperator + @hi12_code_amount_str, @isa16_component_element_seperator)
	end

	if (@hi01 IS NOT NULL)
	begin
		INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010, col011, col012, col013)
			Values (	CAST(@x12_interchange_uid as varchar(36)),  'HI',
					UPPER(LTRIM(RTRIM(@hi01))),
					UPPER(LTRIM(RTRIM(@hi02))),
					UPPER(LTRIM(RTRIM(@hi03))),
					UPPER(LTRIM(RTRIM(@hi04))),
					UPPER(LTRIM(RTRIM(@hi05))),
					UPPER(LTRIM(RTRIM(@hi06))),
					UPPER(LTRIM(RTRIM(@hi07))),
					UPPER(LTRIM(RTRIM(@hi08))),
					UPPER(LTRIM(RTRIM(@hi09))),
					UPPER(LTRIM(RTRIM(@hi10))),
					UPPER(LTRIM(RTRIM(@hi11))),
					UPPER(LTRIM(RTRIM(@hi12)))
				) 
	end


