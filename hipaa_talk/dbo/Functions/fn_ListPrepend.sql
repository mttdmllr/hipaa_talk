CREATE FUNCTION dbo.fn_ListPrepend (@ValueList nvarchar(4000), @Item nvarchar(4000), @Delim varchar(50)= ',' )
RETURNS nvarchar(4000)
AS
/*********************
-- START DOC --
FUNCTION: fn_ListAppend
	Parameter:	[IN] @ValueList nvarchar(4000)
			[IN] @Item nvarchar(2000)
			[IN] @Delim varchar(50)
			[RETURN] @Value nvarchar(4000)
	Type:		nvarchar
	
	Characteristic:	DETERMINISTIC
	Description:	Returns the "@ValueList" with the "@Item" prepended to it.
	
	Example:	declare @mylist nvarchar(100)
			set @mylist = 'A,B, C, D , 1, 2,345, EFG, H'
			select dbo.fn_ListPrepend(@mylist, 8, ',')  -- Returns "8,A,B, C, D , 1, 2,345, EFG, H"
-- END DOC --
*********************/

BEGIN
	-- If the delimiter passed was null, use an empty string.
	set @Delim = IsNull(@Delim, '')

	-- If the list is empty, set it equal to the value that was passed in.
	if (@ValueList IS NULL)
	begin
		set @ValueList = @Item
	end
	-- If the item passed in was not null, append it to the list.
	else if (@Item IS NOT NULL)
	begin
		set @ValueList = @Item + @Delim + @ValueList
	end

	RETURN @ValueList
END

