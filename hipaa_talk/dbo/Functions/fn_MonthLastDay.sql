
CREATE FUNCTION [dbo].[fn_MonthLastDay] (@indate datetime)  
RETURNS datetime AS  
/*********************
-- START DOC --
FUNCTION: fn_MonthLastDay
	Parameter:	[IN] @indate datetime
			[RETURN] datetime
	Type:		datetime
	
	Characteristic:	DETERMINISTIC
	Description:	Returns the last date of the month for the specified date.  It also 
	
	Example:	select dbo.fn_MonthLastDay(getdate()); returns the last date of the current month
			select dbo.fn_MonthLastDay('12/15/2001'); returns 2001-12-31 23:59:59.997
			select dbo.fn_MonthLastDay('2/15/2000'); returns 2000-02-29 23:59:59.997
-- END DOC --
*********************/
BEGIN 
	declare @indate_month char(2)
	declare @indate_year char(4)
	declare @outdate datetime

	set @indate_month = LTrim(RTrim(Str(Month(@indate))))
	set @indate_year = LTrim(RTrim(Str(Year(@indate))))

	set @outdate = @indate_month + '/1/' + @indate_year
	set @outdate = DateAdd(m, 1, @outdate)
	set @outdate = DateAdd(ms, -2, @outdate)
	return @outdate
END



