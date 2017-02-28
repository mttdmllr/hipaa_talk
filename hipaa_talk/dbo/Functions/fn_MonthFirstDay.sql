
CREATE FUNCTION [dbo].[fn_MonthFirstDay] (@indate datetime)  
RETURNS datetime AS  
/*********************
-- START DOC --
FUNCTION: fn_MonthFirstDay
	Parameter:	[IN] @indate datetime
			[RETURN] datetime
	Type:		datetime
	
	Characteristic:	DETERMINISTIC
	Description:	Returns the first date of the month for the specified date.
	
	Example:	select dbo.fn_MonthFirstDay(getdate()); returns the first date of the current month
			select dbo.fn_MonthFirstDay('12/15/2001'); returns '12/1/2001'
-- END DOC --
*********************/

BEGIN 
	declare @indate_month char(2)
	declare @indate_year char(4)
	declare @outdate datetime

	set @indate_month = LTrim(RTrim(Str(Month(@indate))))
	set @indate_year = LTrim(RTrim(Str(Year(@indate))))

	set @outdate = @indate_month + '/1/' + @indate_year
	return @outdate
END



