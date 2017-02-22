
CREATE procedure [dbo].[api_x12_organization_drop_location_insert] (@x12_organization_drop_location_id INT output,
				@src_org_id INT,
				@dest_org_id INT,
				@x12_location_id INT,
				@x12_transaction_schema_id INT = null,
				@outbound_filename VARCHAR(128) = 't#tranidcode#_#senderid#_#receiverid#_#datetime#.txt',
				@active BIT = 1)
as

/*********************
-- START DOC --
PROCEDURE: api_x12_organization_drop_location_insert
	Parameter:	[RETURN] @x12_organization_drop_location_id
	Type:		int
	
	Description:	Creates a new drop location for an organization.
			Returns the @x12_organization_drop_location_id for the NEW drop location.
	
	Example:	
-- END DOC --
*********************/
	if not exists(select x12_organization_drop_location_id from x12_organization_drop_location 
				where src_x12_organization_id = @src_org_id 
					and dest_x12_organization_id = @dest_org_id 
					and x12_transaction_schema_id = @x12_transaction_schema_id)
	begin
		INSERT INTO [HIPAATalk].[dbo].[x12_organization_drop_location]
           (src_x12_organization_id
           ,dest_x12_organization_id
           ,x12_location_id
           ,x12_transaction_schema_id
           ,outbound_filename
           ,active)
		VALUES
           (@src_org_id,
			@dest_org_id,
			@x12_location_id,
			@x12_transaction_schema_id,
			@outbound_filename,
			@active)
			
		select @x12_organization_drop_location_id = @@IDENTITY
	end
	else
	begin
		select x12_organization_drop_location_id 
		from x12_organization_drop_location 
		where src_x12_organization_id = @src_org_id 
				and dest_x12_organization_id = @dest_org_id 
				and x12_transaction_schema_id = @x12_transaction_schema_id
	end
