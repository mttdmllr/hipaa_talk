
CREATE PROCEDURE [dbo].[up_x12_file_parse]
    (
      @Path VARCHAR(255) ,
      @Filename VARCHAR(255),
      @x12_parse_temp_uid UNIQUEIDENTIFIER output
    )
AS
/***********
This procedure does the basic parsing of an X12 file from the file system and loads it into the x12_parse_temp table.
***********/
	SET NOCOUNT ON

	DECLARE @bulk_cmd varchar(1000),
			@segmentDelimiter varchar(5),
			@elementDelimiter varchar(5),
			@docChunk varchar(250),
			@msg VARCHAR(500)

	-- Add a directory slash if one doesn't exist
	IF (RIGHT(@Path, 1) <> '\') SET @Path = @Path + '\'
	
	-- The file location of the X12 file to parse (must be accessible by SQL Service)

	/* BEGIN [IDENTIFY DELIMITERS]: This section of code reads the first 110 characters of the X12 document to determine whether it's valid and how to parse it */
	Select @docChunk = LEFT(dbo.ufsReadfileAsString (@Path, @Filename), 110)

		--Look at the first 3 characters of @docChunk to see if this is a valid X12 file.
		IF (LEFT(@docChunk, 3) <> 'ISA')
		BEGIN
			SET @msg = 'HIPAATALK FILE PICKUP ERROR: "' + @Path + @Filename + '" IS NOT A VALID X12 FILE!'
	-- TO-DO: Stop and add maybe a wee bit more error handling here.
			PRINT @msg
		END
		ELSE
		BEGIN
			-- retrieve the element delimiter from the ISA segment
			set @elementDelimiter = SUBSTRING(@docChunk, 4, 1)

			-- Get the 106th character which is the segment delimiter
			set @segmentDelimiter = SUBSTRING(@docChunk, 106, 1)

			-- Get the 106th character to see if a line feed is used instead of a standard character
			if (SUBSTRING(@docChunk, 106, 1) = CHAR(10))
			begin
				set @segmentDelimiter = @segmentDelimiter + CHAR(13)
			end
			-- Get the 107th character to see if a carriage return is used after the standard delimiter
			else if (SUBSTRING(@docChunk, 107, 1) = CHAR(13))
			begin
				set @segmentDelimiter = @segmentDelimiter + CHAR(13) + CHAR(10)
			end
			-- Get the 107th character to see if a line feed is used after the standard delimiter
			else if (SUBSTRING(@docChunk, 107, 1) = CHAR(10))
			begin
				set @segmentDelimiter = @segmentDelimiter + CHAR(10)
			end
	/* END [IDENTIFY DELIMITERS] */

			SET @bulk_cmd = 'BULK INSERT #tmpX12 FROM ''' + @Path + @Filename + ''' WITH (ROWTERMINATOR = '''+ @segmentDelimiter +''')'

			-- Bulk load the X12 file into the temp table.
			CREATE TABLE #tmpX12 (rowtext VARCHAR(500))
			EXEC(@bulk_cmd)

			IF (@@ERROR = 0)
			BEGIN
				SET @x12_parse_temp_uid = NEWID()

				INSERT INTO x12_parse_temp
						( x12_parse_temp_uid ,
						  Col001 ,
						  Col002 ,
						  Col003 ,
						  Col004 ,
						  Col005 ,
						  Col006 ,
						  Col007 ,
						  Col008 ,
						  Col009 ,
						  Col010 ,
						  Col011 ,
						  Col012 ,
						  Col013 ,
						  Col014 ,
						  Col015 ,
						  Col016 ,
						  Col017 ,
						  Col018 ,
						  Col019 ,
						  Col020 ,
						  Col021 ,
						  Col022 ,
						  Col023 ,
						  Col024 ,
						  Col025 ,
						  [filename]
						)
				SELECT	x12_parse_temp_uid = @x12_parse_temp_uid,
						col001 = dbo.fn_ListGetAt(rowtext, 1,  @elementDelimiter),
						col002 = dbo.fn_ListGetAt(rowtext, 2,  @elementDelimiter),
						col003 = dbo.fn_ListGetAt(rowtext, 3,  @elementDelimiter),
						col004 = dbo.fn_ListGetAt(rowtext, 4,  @elementDelimiter),
						col005 = dbo.fn_ListGetAt(rowtext, 5,  @elementDelimiter),
						col006 = dbo.fn_ListGetAt(rowtext, 6,  @elementDelimiter),
						col007 = dbo.fn_ListGetAt(rowtext, 7,  @elementDelimiter),
						col008 = dbo.fn_ListGetAt(rowtext, 8,  @elementDelimiter),
						col009 = dbo.fn_ListGetAt(rowtext, 9,  @elementDelimiter),
						col010 = dbo.fn_ListGetAt(rowtext, 10,  @elementDelimiter),
						col011 = dbo.fn_ListGetAt(rowtext, 11,  @elementDelimiter),
						col012 = dbo.fn_ListGetAt(rowtext, 12,  @elementDelimiter),
						col013 = dbo.fn_ListGetAt(rowtext, 13,  @elementDelimiter),
						col014 = dbo.fn_ListGetAt(rowtext, 14,  @elementDelimiter),
						col015 = dbo.fn_ListGetAt(rowtext, 15,  @elementDelimiter),
						col016 = dbo.fn_ListGetAt(rowtext, 16,  @elementDelimiter),
						col017 = dbo.fn_ListGetAt(rowtext, 17,  @elementDelimiter),
						col018 = dbo.fn_ListGetAt(rowtext, 18,  @elementDelimiter),
						col019 = dbo.fn_ListGetAt(rowtext, 19,  @elementDelimiter),
						col020 = dbo.fn_ListGetAt(rowtext, 20,  @elementDelimiter),
						col021 = dbo.fn_ListGetAt(rowtext, 21,  @elementDelimiter),
						col022 = dbo.fn_ListGetAt(rowtext, 22,  @elementDelimiter),
						col023 = dbo.fn_ListGetAt(rowtext, 23,  @elementDelimiter),
						col024 = dbo.fn_ListGetAt(rowtext, 24,  @elementDelimiter),
						col025 = dbo.fn_ListGetAt(rowtext, 25,  @elementDelimiter),
						[filename] = @Path + @Filename
				FROM #tmpX12
				WHERE LEFT(rowtext, 1) <> CHAR(10) AND LEFT(rowtext, 1) <> CHAR(13)
			END
			
			DROP TABLE #tmpX12
		END
