
create FUNCTION [dbo].[fn_trim_leading_zero] (@varIn money)
RETURNS varchar(max) AS
BEGIN
	return dbo.fn_LTrimPat(replace(@varIn, '-0.', '-.'), '0')
END
