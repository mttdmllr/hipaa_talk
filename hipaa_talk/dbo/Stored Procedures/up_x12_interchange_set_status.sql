CREATE PROCEDURE [dbo].[up_x12_interchange_set_status] (	@x12_interchange_id int = null,
							@x12_interchange_uid uniqueidentifier = null,
							@x12_interchange_status_id int = null,
							@x12_interchange_status_ud varchar(32) = null
						)
AS


if (@x12_interchange_status_ud IS NULL AND @x12_interchange_status_id IS NULL)
	return(0)

if (@x12_interchange_id IS NULL AND @x12_interchange_uid IS NULL)
	return(0)


if (@x12_interchange_status_ud IS NOT NULL AND @x12_interchange_status_id IS NULL)
begin
	select @x12_interchange_status_id = x12_interchange_status_id FROM x12_interchange_status WHERE x12_interchange_status_ud = @x12_interchange_status_ud
end

if (@x12_interchange_status_id IS NOT NULL)
begin
	update x12_interchange set x12_interchange_status_id = @x12_interchange_status_id
		where	x12_interchange_id = @x12_interchange_id OR
			x12_interchange_uid = @x12_interchange_uid
end
