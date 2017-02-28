CREATE FUNCTION dbo.fn_ListToTable (@ValueList nvarchar(4000), @Delim char(1)= ',' )
RETURNS @Values TABLE ( item nvarchar(4000) )
AS
/*********************
-- START DOC --
FUNCTION: fn_ListToTable
	Parameter:	[IN] @ValueList nvarchar(4000)
			[IN] @Delim char(1), default delimiter is ","
			[RETURN] TABLE @Values COLUMN ( item nvarchar(4000) )
	Type:		TABLE
	
	Characteristic:	DETERMINISTIC
	Description:	Returns a single-column table of values created from the delimited list argument.
	
	Example:	declare @mylist nvarchar(100)
			set @mylist = 'A,B, 2,345, EFG, H,'
			select * from dbo.fn_ListToTable(@mylist, ',')  -- Returns a table with rows in the following format:
				[item]
				A
				B
				2
				345
				EFG
				H
-- END DOC --
*********************/

BEGIN
	DECLARE @chrind INT
	DECLARE @Piece nvarchar(4000)

	SELECT @chrind = 1 
	WHILE @chrind > 0
	BEGIN
		SELECT @chrind = CHARINDEX(@Delim, @ValueList)

		IF @chrind  > 0
			SELECT @Piece = LEFT(@ValueList,@chrind - 1)
		ELSE
			SELECT @Piece = @ValueList

		INSERT  @Values(item) VALUES(LTrim(RTrim(@Piece)))

		SELECT @ValueList = RIGHT(@ValueList,LEN(@ValueList) - @chrind)

		IF LEN(@ValueList) = 0 BREAK
	END
	RETURN

END






