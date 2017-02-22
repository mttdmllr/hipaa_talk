CREATE FUNCTION dbo.fn_ListGetAt (@ValueList nvarchar(4000), @Pos int, @Delim char(1)= ',' )
RETURNS nvarchar(4000)
AS
/*********************
-- START DOC --
FUNCTION: fn_ListGetAt
	Parameter:	[IN] @ValueList nvarchar(4000)
			[IN] @Pos int
			[IN] @Delim char(1), default delimiter is ","
			[RETURN] @Value nvarchar(4000)
	Type:		nvarchar
	
	Characteristic:	DETERMINISTIC
	Description:	Returns the n-th item in a delimited list where the delimiter is specified as a parameter.  Always expects an nvarchar list, and always returns an nvarchar value.
	
	Example:	declare @mylist nvarchar(100)
			set @mylist = 'A,B, C, D , 1, 2,345, EFG, H,'
			select dbo.fn_ListGetAt(@mylist, 8, ',')  -- Returns the 8th value in the comma-delimited list specified above -- "EFG"
-- END DOC --
*********************/

BEGIN
	declare @Value nvarchar(4000)
	declare @loopcount int
	declare @DelimPos int
	declare @EndPiecePos int

	set @loopcount = 0

	-- loop over the string and scoop out the values between delimiters
	while (Len(@ValueList) > 0)
	begin
		set @DelimPos = CHARINDEX(@Delim, @ValueList)		-- find the first delimiter position

		if (@DelimPos > 0)
			set @EndPiecePos = @DelimPos-1			-- set the end position for the first value
		else if (@DelimPos = 0)
			set @EndPiecePos = Len(@ValueList)			-- if no delimiter in the string, the value is the string

		set @Value = LTrim(RTrim(Left(@ValueList, @EndPiecePos)))	-- set the value equal to the current item in the list

		set @loopcount = @loopcount + 1				-- increment the loopcount

		if (@loopcount = @Pos) RETURN @Value			-- if this loopcount is the same as the position in the list we're looking for, RETURN the value.

		if (@DelimPos > 0)
			set @ValueList = Right(@ValueList, Len(@ValueList)-@DelimPos)	-- set the list to the remainder of the list, less the current item
		else
			set @ValueList = null

	end

	if (@loopcount <> @Pos) set @value = null
	RETURN @Value
END

