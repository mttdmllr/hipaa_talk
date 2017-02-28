CREATE FUNCTION [dbo].[fn_x12_organization_uid](@x12_organization_nm varchar(128))
RETURNS uniqueidentifier AS  
/*********************
-- START DOC --
FUNCTION: fn_x12_organization_uid
	Parameter:	[IN] @x12_organization_nm varchar(25)
			[RETURN] @x12_organization_uid uniqueidentifier 
	Type:		uniqueidentifier
	
	Characteristic:	NOT DETERMINISTIC
	Description:	Returns the @x12_organization_uid that matches the x12_organization_nm or x12_organization_ud
	
	Example:	select dbo.fn_x12_organization_uid('MY HEALTH PLAN') -- Returns a uniqueidentifier of the x12_organization matching the name 'MY HEALTH PLAN'
-- END DOC --
*********************/
BEGIN
	declare @x12_organization_uid uniqueidentifier 
	select @x12_organization_uid = x12_organization_uid
		from x12_organization where other_organization_nm = @x12_organization_nm
	if (@x12_organization_uid IS NULL)
		select @x12_organization_uid = x12_organization_uid
			from x12_organization where x12_organization_ud = @x12_organization_nm
	if (@x12_organization_uid IS NULL)
		select @x12_organization_uid = x12_organization_uid
			from x12_organization where x12_organization_nm = @x12_organization_nm
RETURN @x12_organization_uid 
END

