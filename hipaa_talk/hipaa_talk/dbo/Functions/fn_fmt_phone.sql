CREATE FUNCTION [dbo].[fn_fmt_phone] (@phone_number varchar(25))  
RETURNS varchar(15)
AS  
BEGIN 
	declare @code char(1)
	declare @area char(3)
	declare @prefix char(3)
	declare @number char(4)
	
	set @phone_number = LTrim(RTrim(@phone_number))
	
	set @phone_number = REPLACE(@phone_number, ' ', '')
	set @phone_number = REPLACE(@phone_number, '-', '')
	set @phone_number = REPLACE(@phone_number, '(', '')
	set @phone_number = REPLACE(@phone_number, ')', '')
	set @phone_number = REPLACE(@phone_number, '.', '')
	set @phone_number = REPLACE(@phone_number, '/', '')
	set @phone_number = REPLACE(@phone_number, '\', '')
	
	if(len(@phone_number) = 7)
	begin
		/* only 7 digits exist, ...format the phone number using 000 as area code */
	
		set @area = '000'
		set @prefix = substring(@phone_number, 1, 3)
		set @number = substring(@phone_number, 4, 4)
		set @phone_number = @area + '-' + @prefix + '-' + @number
	end
	
	if(len(@phone_number) = 10)
	begin
		/* all digits exist, ...format the phone number... */
	
		set @area = substring(@phone_number, 1, 3)
		set @prefix = substring(@phone_number, 4, 3)
		set @number = substring(@phone_number, 7, 4)
		set @phone_number = @area + '-' + @prefix + '-' + @number
	end
	
	if(len(@phone_number) = 11)
	begin
		/* country code + all digits exist, ...format the phone number... */
	
		set @code = substring(@phone_number, 1, 1)
		set @area = substring(@phone_number, 2, 3)
		set @prefix = substring(@phone_number, 5, 3)
		set @number = substring(@phone_number, 8, 4)
		set @phone_number = @code + @area + '-' + @prefix + '-' + @number
	end
	
	-- Returns phone number in the "nnn-nnn-nnnn" format.
	set @phone_number = LTRIM(RTRIM(@phone_number))
	RETURN @phone_number
END
