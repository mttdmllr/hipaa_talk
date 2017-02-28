CREATE FUNCTION [dbo].[fn_x12_dropoff_location_id] (@x12_interchange_uid uniqueidentifier)
RETURNS int AS  
/*********************
-- START DOC --
FUNCTION: fn_x12_dropoff_location_id
	Parameter:	[IN] @x12_interchange_uid uniqueidentifier
			[RETURN] @dropoff_x12_location_id int 
	Type:		int
	
	Characteristic:	NOT DETERMINISTIC
	Description:	Returns the x12_location_id for the destination of the specified transaction
			If a location destination is not specified for the associated TA1 and 997 transactions, then the dropoff location of the incoming document is used.
	
	Example:	select dbo.fn_x12_dropoff_location_id('EB28062C-866B-474B-ABD5-6AACF3E442B9') -- Returns an integer of the x12_location_id for this transaction
-- END DOC --
*********************/
BEGIN
	declare @dest_x12_organization_id int
	declare @src_x12_organization_id int
	declare @dropoff_x12_location_id int
	declare @x12_transaction_schema_id int
	
	select	@dest_x12_organization_id = x12_interchange.dest_x12_organization_id,
		@src_x12_organization_id = x12_interchange.src_x12_organization_id,
		@x12_transaction_schema_id = x12_functional_group.x12_transaction_schema_id
	from x12_interchange
	left join x12_functional_group
		ON x12_interchange.x12_interchange_id = x12_functional_group.x12_interchange_id
	where x12_interchange_uid = @x12_interchange_uid
	
	-- get the DROPOFF location for delivery of outgoing documents of this type
	select TOP 1 @dropoff_x12_location_id = x12_location_id
	from x12_organization_drop_location
	where	src_x12_organization_id = @src_x12_organization_id AND
		dest_x12_organization_id = @dest_x12_organization_id AND
		(
			x12_transaction_schema_id = @x12_transaction_schema_id OR
			x12_transaction_schema_id IS NULL
		)
	ORDER by x12_transaction_schema_id desc
	
	-- if the DROPOFF location was NOT found, try again where the SOURCE is NULL
	if (@dropoff_x12_location_id IS NULL)
	begin
		select TOP 1 @dropoff_x12_location_id = x12_location_id
		from x12_organization_drop_location
		where	dest_x12_organization_id = @dest_x12_organization_id AND
			src_x12_organization_id IS NULL AND
			(
				x12_transaction_schema_id = @x12_transaction_schema_id OR
				x12_transaction_schema_id IS NULL
			)
		ORDER by x12_transaction_schema_id desc
	end
	
	-- if the DROPOFF location was NOT found, try again where the DESTINATION is NULL
	if (@dropoff_x12_location_id IS NULL)
	begin
		select TOP 1 @dropoff_x12_location_id = x12_location_id
		from x12_organization_drop_location
		where	src_x12_organization_id = @src_x12_organization_id AND
			dest_x12_organization_id IS NULL AND
			(
				x12_transaction_schema_id = @x12_transaction_schema_id OR
				x12_transaction_schema_id IS NULL
			)
		ORDER by x12_transaction_schema_id desc
	end
	
	-- if the DROPOFF location was NOT found, try again where BOTH the SOURCE and DESTINATION are NULL
	if (@dropoff_x12_location_id IS NULL)
	begin
		select TOP 1 @dropoff_x12_location_id = x12_location_id
		from x12_organization_drop_location
		where	dest_x12_organization_id IS NULL AND
			src_x12_organization_id IS NULL AND
			(
				x12_transaction_schema_id = @x12_transaction_schema_id OR
				x12_transaction_schema_id IS NULL
			)
		ORDER by x12_transaction_schema_id desc
	end
RETURN @dropoff_x12_location_id
END

