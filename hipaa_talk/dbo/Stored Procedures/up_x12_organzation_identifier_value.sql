CREATE PROCEDURE [dbo].[up_x12_organzation_identifier_value]
						 (	@x12_organization_id int,
							@identifier_qual varchar(32),
							@identifier_value varchar(64) output
						)
AS

/*********************
-- START DOC --
FUNCTION: up_x12_organzation_identifier_value
	Parameter:	[IN] @x12_organization_id int		REQUIRED
			[IN] @identifier_qual varchar(32)		REQUIRED
			[RETURN] @identifier_value varchar(64)

	Description:	Returns the @identifier_value for a specified organization and qualifier.

-- END DOC --
*********************/

	select @identifier_value = dbo.fn_x12_organization_identifier_value (@x12_organization_id, @identifier_qual)


