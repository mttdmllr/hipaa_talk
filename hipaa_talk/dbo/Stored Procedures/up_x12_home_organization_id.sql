CREATE PROCEDURE [dbo].[up_x12_home_organization_id] (@x12_organization_id int output)
AS

/*********************
-- START DOC --
PROCEDURE: up_x12_home_organization_id
	Parameter:	[RETURN] @x12_organization_id int 
	Type:		int
	
	Description:	Returns the @x12_organization_id for the HOME ORGANIZATION.
			This is the organization with the "is_home_org" bit set in the x12_organization table.
	
	Example:	select dbo.fn_x12_home_organization_id() -- Returns an integer of the home x12_organization.
-- END DOC --
*********************/

	select @x12_organization_id = max(x12_organization_id)
		from x12_organization where is_home_org = 1

