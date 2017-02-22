CREATE FUNCTION [dbo].[fn_x12_organization_id](@x12_organization_nm varchar(128))
RETURNS int AS  
/*********************
-- START DOC --
FUNCTION: fn_x12_organization_id
	Parameter:	[IN] @x12_organization_nm varchar(25)
			[RETURN] @x12_organization_id int 
	Type:		int
	
	Characteristic:	NOT DETERMINISTIC
	Description:	Returns the @x12_organization_id that matches the x12_organization_nm or x12_organization_ud
	
	Example:	select dbo.fn_x12_organization_id('MY HEALTH PLAN') -- Returns an integer of the x12_organization matching the name 'MY HEALTH PLAN'
-- END DOC --
*********************/
BEGIN
	declare @x12_organization_id int
	select @x12_organization_id = max(x12_organization_id)
		from x12_organization where other_organization_nm = @x12_organization_nm
	if (@x12_organization_id IS NULL)
		select @x12_organization_id = max(x12_organization_id)
			from x12_organization where x12_organization_ud = @x12_organization_nm
	if (@x12_organization_id IS NULL)
		select @x12_organization_id = max(x12_organization_id)
			from x12_organization where x12_organization_nm = @x12_organization_nm
RETURN @x12_organization_id 
END
