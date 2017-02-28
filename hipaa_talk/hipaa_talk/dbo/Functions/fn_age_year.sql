
CREATE FUNCTION [dbo].[fn_age_year] (@dob datetime, @comparedate datetime)
RETURNS decimal(7, 3) AS  

/*********************
-- START DOC --
FUNCTION: fn_age_year 

	Parameter:	[IN] @dob datetime
			[IN] @comparedate datetime
			[RETURN] @age_in_years decimal(7, 3)

	Type:		decimal(7, 3)
	
	Characteristic:	DETERMINISTIC

	Description:	This function returns the age in years to answer the question, "How old is someone born on '@dob', on the date '@comparedate'?"
			It returns a decimal value up to one/one thousandths for any remainder amount.  This procedure also takes into consideration the
			leap year and when the DOB is on 2/29 calculates age using 3/1 for the non-leap years.
				
	Example:	select dbo.fn_age_year('1/1/2004', '1/1/2006') -- Returns 2.000; a decimal specifiying the age in years of a person born on @dob on the date @comparedate
			select dbo.fn_age_year('1/2/2004', '1/1/2006') -- Returns 1.997;
-- END DOC --
*********************/
BEGIN
	declare @age_in_years decimal(7, 3)
	declare @curbirthday datetime

	if ( (month(@dob) = 2) AND (day(@dob) = 29) AND ( cast(year(@comparedate) as float)/4.0 <> floor(cast(year(@comparedate) as float)/4.0)) )
		set @curbirthday = '3/1/' + str(year(@comparedate))
	else
		set @curbirthday = str(month(@dob)) + '/' + str(day(@dob)) + '/' + str(year(@comparedate))

	if (datediff(d, @curbirthday, @comparedate) < 0)
	begin
		set @age_in_years = datediff(yyyy, @dob, @comparedate)-1
		set @age_in_years = datediff(d, DateAdd(yyyy, -1, @curbirthday), @comparedate)/365.000 + @age_in_years
	end
	else	
	begin
		set @age_in_years = datediff(yyyy, @dob, @comparedate)
		set @age_in_years = datediff(d, @curbirthday, @comparedate)/365.000 + @age_in_years
	end

RETURN @age_in_years

END







