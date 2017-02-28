CREATE FUNCTION dbo.fn_ListCount (@ValueList nvarchar(4000), @Delim char(1)= ',' )
RETURNS int
AS
/*********************
-- START DOC --
FUNCTION: fn_ListCount
	Parameter:	[IN] @ValueList nvarchar(4000)
			[IN] @Delim char(1), default delimiter is ","
			[RETURN] @Count nvarchar(4000)
	Type:		int
	
	Characteristic:	DETERMINISTIC
	Description:	Returns the count of the items in a delimited list where the delimiter is specified as a parameter.  Always expects an nvarchar list, and always returns an int value.
	
	Example:	declare @mylist nvarchar(100)
			set @mylist = 'A,B, C, D , 1, 2,345, EFG, H,'
			select dbo.fn_ListCount(@mylist, ',')  -- Returns the total number of items in the list -- 9.
-- END DOC --
*********************/

BEGIN
	declare @Count int
	declare @loopcount int
	declare @DelimPos int
	declare @EndPiecePos int

	set @loopcount = 0
	if ( Len(LTrim(RTrim(@ValueList))) = 0) RETURN 0

	-- loop over the string and scoop out the values between delimiters
	while (Len(@ValueList) > 0)
	begin
		set @DelimPos = CHARINDEX(@Delim, @ValueList)		-- find the first delimiter position

		if (@DelimPos > 0)
			set @EndPiecePos = @DelimPos-1			-- set the end position for the first value
		else if (@DelimPos = 0)
			set @EndPiecePos = Len(@ValueList)			-- if no delimiter in the string, the value is the string

		set @loopcount = @loopcount + 1				-- increment the loopcount

		if (@DelimPos > 0)
			set @ValueList = Right(@ValueList, Len(@ValueList)-@DelimPos)	-- set the list to the remainder of the list, less the current item
		else
			set @ValueList = null

	end

	set @Count = @loopcount

	RETURN @Count
END





