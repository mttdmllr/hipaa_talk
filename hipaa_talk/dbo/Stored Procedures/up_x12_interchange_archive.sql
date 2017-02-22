CREATE PROCEDURE [dbo].[up_x12_interchange_archive] (@x12_interchange_uid uniqueidentifier = null, @x12_interchange_id int = null) AS
declare @x12_interchange_status_id int
select @x12_interchange_status_id = x12_interchange_status_id
from x12_interchange_status where x12_interchange_status_ud = 'ARCHIVED'
update x12_interchange set	processed = 1,
				x12_interchange_status_id = @x12_interchange_status_id
where (	x12_interchange_uid = @x12_interchange_uid OR
	x12_interchange_id = @x12_interchange_id )
