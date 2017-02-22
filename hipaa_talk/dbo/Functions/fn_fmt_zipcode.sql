CREATE FUNCTION [dbo].[fn_fmt_zipcode] (@zipcode varchar(25))  
RETURNS varchar(15)
AS  
BEGIN 
	declare @zipcode_suffix varchar(10)

	set @zipcode = LTrim(RTrim(@zipcode))
	
	set @zipcode = REPLACE(@zipcode, ' ', '')
	set @zipcode = REPLACE(@zipcode, '-', '')
	set @zipcode = REPLACE(@zipcode, '(', '')
	set @zipcode = REPLACE(@zipcode, ')', '')
	set @zipcode = REPLACE(@zipcode, '.', '')
	set @zipcode = REPLACE(@zipcode, '/', '')
	set @zipcode = REPLACE(@zipcode, '\', '')
	
	if(len(@zipcode) > 5)
	begin
		-- if the length of the incoming zipcode is greater than 5, it has a suffix
		set @zipcode_suffix = Right(@zipcode, Len(@zipcode)-5)

		-- if the suffix is all 0's, drop them
		if ( @zipcode_suffix = REPLICATE('0', Len(@zipcode_suffix)) )
		begin
			set @zipcode_suffix = ''
		end

		-- set the zipcode equal to the first 5 characters plus the suffix if any exists
		set @zipcode = Left(@zipcode, 5) + @zipcode_suffix
	end
	
	set @zipcode = LTRIM(RTRIM(@zipcode))

	return @zipcode
END

