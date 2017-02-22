CREATE PROCEDURE [dbo].[up_x12_directory_pickup] (@PickupFolder VARCHAR(2000), @ErrorDirectory VARCHAR(2000), @ArchiveDirectory VARCHAR(2000) = null)
AS
	/***
	Author:			Chad Casady
	Date:			12/29/2010
	Description:	This script loops over files in a specified folder, picks up each file, parses it and loads it into x12_parse_temp,
					and then executes the interchange parsing procedure.
					If a TA1 and 997 are generated from loading the file, this script will drop them to disk.
					
					@PickupFolder	[REQUIRED]	-- the folder containing files to parse
					@ErrorDirectory	[REQUIRED]	-- the folder to move files to if they cannot be parsed

	Note:			This script requires "xp_cmdshell" functionality activated, otherwise it simply will not work.
	***/

	DECLARE @myfiles TABLE (MyID INT IDENTITY(1,1) PRIMARY KEY, FullPath VARCHAR(2000))
	DECLARE @CommandLine VARCHAR(4000)

	DECLARE @fullfilename VARCHAR(1000)
	DECLARE @filename VARCHAR(1000)
	DECLARE @count INT

	DECLARE	@x12_parse_temp_uid UNIQUEIDENTIFIER,
			@TA1_x12_interchange_id INT,
			@TA1_x12_interchange_uid UNIQUEIDENTIFIER,
			@x997_x12_interchange_uid UNIQUEIDENTIFIER

	SET @count = 0

	-- This is the command to get the file list for that directory
	SET @CommandLine = LEFT('dir "' + @PickupFolder + '" /A-D /B /S ',4000)

	-- Load the filenames into a table variable
	INSERT INTO @MyFiles (FullPath)
		   EXECUTE xp_cmdshell @CommandLine

	-- Loop over each file
	WHILE (@count < (SELECT COUNT(*) FROM @MyFiles WHERE fullpath IS NOT NULL))
	BEGIN
		-- reset variables, increment @count
		SELECT	@count = @count + 1,
				@x12_parse_temp_uid = NULL,
				@TA1_x12_interchange_id = NULL,
				@TA1_x12_interchange_uid = NULL,
				@x997_x12_interchange_uid = NULL

		-- Specify the X12 file to load (SQL Server service(s) must have access to it!!)
		SELECT	@Filename = dbo.fn_FileFromPath(fullpath),
				@fullfilename = CASE WHEN RIGHT(@PickupFolder, 1) = '\' THEN @PickupFolder + dbo.fn_FileFromPath(fullpath) ELSE @PickupFolder + '\' + dbo.fn_FileFromPath(fullpath) END
		FROM @myfiles WHERE MyID = @count

		-- Print the file name for debugging if needed.
		PRINT @fullfilename
		
		-- Parse the file and load it into the x12_parse_temp table (this procedure uses BULK LOAD):
		EXEC up_x12_file_parse	@Path = @PickupFolder,
								@Filename = @Filename,
								@x12_parse_temp_uid = @x12_parse_temp_uid output

		-- if the @x12_parse_temp_uid returned is NULL, that means the file was NOT loaded.
		IF (@x12_parse_temp_uid IS NULL)
		BEGIN
			SET @CommandLine = 'move "' + @fullfilename + '" "' + @ErrorDirectory + '\"'
			
			PRINT 'An error was encountered when , moving file to the error directory.'
			PRINT @CommandLine
			EXECUTE xp_cmdshell @CommandLine
		END
		ELSE
		BEGIN
			-- Parse the interchange:
			EXEC up_x12_interchange_parse	@x12_parse_temp_uid = @x12_parse_temp_uid,
											@TA1_x12_interchange_id = @TA1_x12_interchange_id output
			DELETE FROM x12_parse_temp WHERE x12_parse_temp_uid = @x12_parse_temp_uid

			-- If a TA1 was created, DROP IT:
			SELECT @TA1_x12_interchange_uid = x12_interchange_uid FROM x12_interchange WHERE x12_interchange_id = @TA1_x12_interchange_id
			IF (@TA1_x12_interchange_uid IS NOT NULL)
			BEGIN
				EXEC up_x12_file_export	@x12_interchange_uid = @TA1_x12_interchange_uid 
				DELETE FROM x12_parse_temp WHERE x12_parse_temp_uid = @TA1_x12_interchange_uid
			END

			-- If a 997 was created, FIND IT and DROP IT to a file:
			select TOP 1 @x997_x12_interchange_uid = x12997Hdr.x12_interchange_uid
			from x12_997_functional_ack
			INNER JOIN vw_x12_transaction x12997Hdr
				on x12_997_functional_ack.x12_transaction_id = x12997Hdr.x12_transaction_id
			INNER JOIN vw_x12_transaction src_hdr
				ON x12_997_functional_ack.src_x12_functional_group_id = src_hdr.x12_functional_group_id
			where src_hdr.x12_interchange_uid = @x12_parse_temp_uid

			IF (@x997_x12_interchange_uid IS NOT NULL)
			BEGIN
				-- Drop the 997
				EXEC up_x12_file_export	@x12_interchange_uid = @x997_x12_interchange_uid
				DELETE FROM x12_parse_temp WHERE x12_parse_temp_uid = @x997_x12_interchange_uid -- clean up the x12_parse_temp table
			END

			-- Archive 997:
			EXEC up_x12_interchange_archive @x12_interchange_uid = @x997_x12_interchange_uid
		
			IF (@ArchiveDirectory IS NULL)
				SET @ArchiveDirectory = dbo.fn_x12_archive_location_address(@x12_parse_temp_uid)
			
			-- Move file to archive folder or delete if no archive folder specified
			IF (@ArchiveDirectory IS NULL)
				BEGIN
					-- Archive folder not specified, delete file.
					SET @CommandLine = 'del "' + @fullfilename + '"'
				END
				ELSE
				BEGIN
					-- Archive folder IS specified, move file.
					SET @CommandLine = 'move "' + @fullfilename + '" "' + @ArchiveDirectory + '"'
				END
		END
		
		PRINT @CommandLine
		EXECUTE xp_cmdshell @CommandLine
	END

