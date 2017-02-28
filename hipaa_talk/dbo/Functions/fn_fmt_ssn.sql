CREATE FUNCTION [dbo].[fn_fmt_ssn] (@ssn varchar(25))  
RETURNS varchar(11)
AS  
/*********************
-- START DOC --
FUNCTION: fn_fmt_ssn 

	Parameter:	[IN] @ssn varchar(25)
			[RETURN] varchar(11)

	Type:		varchar(11)
	
	Characteristic:	DETERMINISTIC

	Description:	This function formats a specified string (@ssn) into a standard SSN formatted string = nnn-nn-nnnn.
			It will strip out all the junk and return a clean, SSN-formatted string.
				
	Example:	select dbo.fn_fmt_ssn(123456789) -- Returns 123-45-6789;
			select dbo.fn_fmt_ssn(123 45 6789-) -- Returns 123-45-6789;

-- END DOC --
*********************/
BEGIN 
	declare @ssn1 char(3)
	declare @ssn2 char(2)
	declare @ssn3 char(4)
	
	set @ssn = LTrim(RTrim(@ssn))
	
	set @ssn = REPLACE(@ssn, ' ', '')
	set @ssn = REPLACE(@ssn, '-', '')
	set @ssn = REPLACE(@ssn, '(', '')
	set @ssn = REPLACE(@ssn, ')', '')
	set @ssn = REPLACE(@ssn, '.', '')
	set @ssn = REPLACE(@ssn, '/', '')
	set @ssn = REPLACE(@ssn, '\', '')
	
	if(len(@ssn) = 9)
	begin
		/* all digits exist, ...format the ssn... */
	
		set @ssn1 = substring(@ssn, 1, 3)
		set @ssn2 = substring(@ssn, 4, 2)
		set @ssn3 = substring(@ssn, 6, 4)
		set @ssn = @ssn1 + '-' + @ssn2 + '-' + @ssn3
	end
	
	set @ssn = LTRIM(RTRIM(@ssn))
	RETURN @ssn
END

