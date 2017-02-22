CREATE PROCEDURE [dbo].[up_x12_identifier_value_org_id] (	@x12_organization_id int output,
							@identifier_value varchar(64),
							@identifier_qual varchar(32)	)
AS

/*********************
-- START DOC --
FUNCTION: up_x12_identifier_value_org_id
	Parameter:	[IN] @identifier_value varchar(64)		REQUIRED
			[IN] @identifier_qual varchar(32)		REQUIRED
			[RETURN] @x12_organization_id int

	Description:	Returns the @x12_organization_id for a specified identifier_value and qualifier.  This function makes the assumption that it is used mainly for incoming transactions
			and thus checks for the incoming_default bit first.
	
-- END DOC --
*********************/

	select @x12_organization_id = dbo.fn_x12_identifier_value_org_id (@identifier_value , @identifier_qual)

