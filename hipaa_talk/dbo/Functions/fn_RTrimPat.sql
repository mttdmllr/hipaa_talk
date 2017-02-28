
CREATE FUNCTION [dbo].[fn_RTrimPat] (@StringToTrim varchar(4000), @PatternToTrim varchar(500))
RETURNS varchar(4000) AS  
/*********************
-- START DOC --
FUNCTION: fn_RTrimPat
	Parameter:	[IN] @StringToTrim varchar(4000)
			[IN] @PatternToTrim varchar(500)
			[RETURN] varchar(4000)
	Type:		varchar
	
	Characteristic:	DETERMINISTIC
	Description:	Returns the string @StringToTrim trimmed of the leading string @PatternToTrim.
	
	Example:	select dbo.fn_RTrimPat('000001234', '0'); returns '1234'
-- END DOC --
*********************/
BEGIN 
	declare @TrimmedString varchar(4000)

	set @TrimmedString = @StringToTrim

	while	(
			RIGHT(@TrimmedString, Len(@PatternToTrim)) = @PatternToTrim AND
			Len(@PatternToTrim) > 0
		)
	begin
		set @TrimmedString = STUFF(@TrimmedString, Len(@TrimmedString)-Len(@PatternToTrim)+1, Len(@TrimmedString), '')
	end

	return @TrimmedString
END

