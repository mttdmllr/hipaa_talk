CREATE PROCEDURE [dbo].[up_x12_file_export] (@x12_interchange_uid UNIQUEIDENTIFIER, @dropoff_address varchar(1000) = null)
AS

DECLARE @bulk_cmd varchar(1000)
DECLARE @segment_separator VARCHAR(3)

IF (@dropoff_address IS NULL)
BEGIN
	select	@dropoff_address = dbo.fn_x12_dropoff_location_address(x12_interchange_uid),
			@segment_separator = ISNULL(segment_separator, '~')
	from x12_interchange
	where x12_interchange_uid = @x12_interchange_uid
END
ELSE
BEGIN
	select	@segment_separator = ISNULL(segment_separator, '~')
	from x12_interchange
	where x12_interchange_uid = @x12_interchange_uid
END

SET @bulk_cmd = 'bcp "select segment from ' + DB_NAME() + '.dbo.vw_x12_parse_temp_segment where x12_parse_temp_uid = ''' + CAST(@x12_interchange_uid AS VARCHAR(40)) + '''" queryout "' + @dropoff_address + '" -c -T -r' + @segment_separator + ' -S ' + @@SERVERNAME

PRINT 'File Drop to: "' + ISNULL(@dropoff_address, '/') + '"'
EXEC xp_cmdshell @bulk_cmd, NO_OUTPUT

