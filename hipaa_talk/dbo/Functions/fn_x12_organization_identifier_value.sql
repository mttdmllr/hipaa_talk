CREATE FUNCTION [dbo].[fn_x12_organization_identifier_value] (@x12_organization_id int, @identifier_qual varchar(32))
RETURNS varchar(64) AS  
/*********************
-- START DOC --
FUNCTION: fn_x12_organization_identifier_value
	Parameter:	[IN] @x12_organization_id int		REQUIRED
			[IN] @identifier_qual varchar(32)		REQUIRED
			[RETURN] @identifier_value varchar(64)
	Type:		int
	
	Characteristic:	NOT DETERMINISTIC
	Description:	Returns the @identifier_value for an organization and qualifier
	
	Example:	select dbo.fn_x12_organization_identifier_value(9, 'ZZ') -- Returns an integer of the identifier_value for x12_organization_id = 9 and the ZZ qualifier
-- END DOC --
*********************/
BEGIN
	declare @identifier_value varchar(64)

	select	TOP 1 @identifier_value = identifier_value
	from x12_identifier
		where	x12_organization_id = @x12_organization_id
			AND (@identifier_qual IS NULL OR identifier_qual = @identifier_qual)
	order by outgoing_default DESC
RETURN @identifier_value
END


