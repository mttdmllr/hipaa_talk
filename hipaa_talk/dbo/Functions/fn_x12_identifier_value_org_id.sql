
CREATE FUNCTION [dbo].[fn_x12_identifier_value_org_id] (@identifier_value varchar(64), @identifier_qual varchar(32))
RETURNS int AS  
/*********************
-- START DOC --
FUNCTION: fn_x12_identifier_value_org_id
	Parameter:	[IN] @identifier_value varchar(64)		REQUIRED
			[IN] @identifier_qual varchar(32)		REQUIRED
			[RETURN] @x12_organization_id int

	Type:		int
	
	Characteristic:	NOT DETERMINISTIC
	Description:	Returns the @x12_organization_id for a specified identifier_value and qualifier.  This function makes the assumption that it is used mainly for incoming transactions
			and thus checks for the incoming_default bit first.
	
	Example:	select dbo.fn_x12_identifier_value_org_id('1234567890', 'ZZ') -- Returns an integer of the x12_organization_id where identifer_value = '1234567890' with a 'ZZ' qualifier
-- END DOC --
*********************/
BEGIN
	declare @x12_organization_id int

	-- First check for the organization where the incoming default is set.
	select	@x12_organization_id = Max(x12_organization_id)
	from x12_identifier
	where	identifier_value = @identifier_value AND
		(@identifier_qual IS NULL OR identifier_qual = @identifier_qual) AND
		incoming_default = 1

	-- if no organization was found, then check regardless of the incoming default.
	if ( @x12_organization_id IS NULL )
	begin
		select	@x12_organization_id = Max(x12_organization_id)
		from x12_identifier
		where	identifier_value = @identifier_value AND
			(@identifier_qual IS NULL OR identifier_qual = @identifier_qual)
	end

	-- if no organization was found, then check regardless of the qualifier.
	if ( @x12_organization_id IS NULL )
	begin
		select	@x12_organization_id = Max(x12_organization_id)
		from x12_identifier
		where	identifier_value = @identifier_value
	end

RETURN @x12_organization_id
END





