
CREATE PROCEDURE [dbo].[api_x12_location_insert] (	@x12_location_id int output,
						@location_ud varchar(32),
						@location_nm varchar(64) = null,
						@location_address varchar(128),
						@file_mask varchar(32) = null,
						@active bit = 1
					)
as


/*********************
-- START DOC --
PROCEDURE: api_x12_location_insert
	Parameter:	[RETURN] @x12_location_id int 
	Type:		int
	
	Description:	Creates a new location.
			Returns the @x12_location_id for the NEW location.
	
	Example:	
-- END DOC --
*********************/
	if @location_nm is null
		select @location_nm = @location_ud
	
	-- if the location with that UD doesn't already exist, create one
	if not exists (select x12_location_id from x12_location where location_ud = @location_ud)
	begin
		insert into x12_location (location_ud, location_nm, location_address, file_mask, active)
			values (@location_ud, @location_nm, @location_address, @file_mask, @active)
	
		select @x12_location_id = @@IDENTITY
	end
	else
	begin
		-- An location with that UD ALREADY EXISTS, return the x12_location_id
		select @x12_location_id = x12_location_id
		from x12_location
		where location_ud = @location_ud
	end
