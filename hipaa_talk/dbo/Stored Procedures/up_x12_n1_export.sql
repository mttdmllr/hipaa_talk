


CREATE Procedure [dbo].[up_x12_n1_export] (
					@x12_interchange_uid uniqueidentifier,
					@n101_id_code varchar(3) = null,
					@n102_name varchar(60) = null,
					@n103_id_qual char(2) = null,
					@n104_id varchar(80) = null
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

	-- Should any colon's exist, strip them.
	set @n102_name = REPLACE(@n102_name, @isa16_component_element_seperator, '')

	if (@n102_name IS NOT NULL)
	begin
		INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004, col005)	
			Values ( CAST(@x12_interchange_uid as varchar(36)), 'N1',
					UPPER(LTRIM(RTRIM(@n101_id_code))),
					UPPER(LTRIM(RTRIM(@n102_name))),
					UPPER(LTRIM(RTRIM(@n103_id_qual))),
					UPPER(LTRIM(RTRIM(@n104_id)))
				) 
	end
