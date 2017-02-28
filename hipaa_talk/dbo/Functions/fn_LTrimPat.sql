
CREATE FUNCTION [dbo].[fn_LTrimPat] (@StringToTrim varchar(4000), @PatternToTrim varchar(500))
RETURNS varchar(4000) AS  
/*********************
-- START DOC --
FUNCTION: fn_LTrimPat
	Parameter:	[IN] @StringToTrim varchar(4000)
			[IN] @PatternToTrim varchar(500)
			[RETURN] varchar(4000)
	Type:		varchar
	
	Characteristic:	DETERMINISTIC
	Description:	Returns the string @StringToTrim trimmed of the leading string @PatternToTrim.
	
	Example:	select dbo.fn_LTrimPat('000001234', '0'); returns '1234'
-- END DOC --
*********************/
BEGIN 
	declare @TrimmedString varchar(4000)

	set @TrimmedString = @StringToTrim

	while	(
			LEFT(@TrimmedString, Len(@PatternToTrim)) = @PatternToTrim AND
			Len(@PatternToTrim) > 0
		)
	begin
		set @TrimmedString = STUFF(@TrimmedString, 1, Len(@PatternToTrim), '')
	end

	return @TrimmedString
END

