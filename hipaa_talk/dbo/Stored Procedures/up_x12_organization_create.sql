CREATE PROCEDURE [dbo].[up_x12_organization_create] (	@x12_organization_id int output,
						@x12_organization_ud varchar(32) = null,
						@x12_organization_nm varchar(64),
						@other_organization_nm varchar(64) = null,
						@default_identifier_value varchar(64),
						@default_identifier_qual char(5) = 'ZZ',
						@is_home_org bit = 0
					)
AS

/*********************
-- START DOC --
PROCEDURE: up_x12_organization_create
	Parameter:	[RETURN] @x12_organization_id int 
	Type:		int
	
	Description:	Creates a new organization.
			Returns the @x12_organization_id for the NEW ORGANIZATION.
	
	Example:	
-- END DOC --
*********************/

	-- if we're trying to specify a new home-org, check to make sure one doesn't already exist
	if (@is_home_org = 1)
	begin
		if exists (select x12_organization_id from x12_organization where is_home_org = 1)
		begin
			PRINT 'A Home Organization already exists, this organization cannot be the Home Organization.'
			set @is_home_org = 0
		end
	end
	
	-- if the x12_organization_ud is NULL, make one up using the IDENTITY field
	if (@x12_organization_ud IS NULL)
	begin
		set @x12_organization_ud = 'X12ORG' + LTRIM(RTRIM(STR(IDENT_CURRENT('x12_organization') + IDENT_SEED('x12_organization'))))
	end
	
	-- if the organization with that UD doesn't already exist, create one
	if not exists (select x12_organization_id from x12_organization where x12_organization_ud = @x12_organization_ud)
	begin
		insert into x12_organization (x12_organization_ud, x12_organization_nm, other_organization_nm, is_home_org)
			values (@x12_organization_ud, @x12_organization_nm, @other_organization_nm, @is_home_org)
	
		select @x12_organization_id = @@IDENTITY
	end
	else
	begin
		-- An organization with that UD ALREADY EXISTS, return the x12_organization_id
		select @x12_organization_id = x12_organization_id
		from x12_organization
		where x12_organization_ud = @x12_organization_ud
	end

	-- If an identifier for that organization doesn't exist, insert a new one
	if not exists (select x12_identifier_id from x12_identifier
			where	x12_organization_id = @x12_organization_id AND
				identifier_value = @default_identifier_value AND
				IsNull(identifier_qual, '') = IsNull(@default_identifier_qual, ''))
	begin
		insert into x12_identifier (x12_organization_id, identifier_qual, identifier_value, outgoing_default, incoming_default)
			values (@x12_organization_id, @default_identifier_qual, @default_identifier_value, 1, 1)
	end



