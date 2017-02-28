
CREATE PROCEDURE [dbo].[up_x12_HIPAATalk_export]
AS
	/***
	Author:			Chad Casady
	Date:			1/18/2011
	Description:	This script loops over all of the interchanges scheduled for export and drops them to disk.

	Note:			This script calls "up_x12_file_export" which requires "xp_cmdshell" functionality activated, otherwise it simply will not work.
	***/

	DECLARE @x12_interchange_uid UNIQUEIDENTIFIER
	DECLARE @created_date DATETIME -- this is only used to sort the cursor properly when using the DISTINCT clause

	DECLARE curX12Interchange SCROLL CURSOR FOR
		SELECT DISTINCT x12_interchange_uid, created_date
		FROM vw_x12_transaction
		WHERE x12_interchange_status_ud = 'EXPORT-READY'
		ORDER BY created_date asc

	OPEN curX12Interchange
	FETCH NEXT FROM curX12Interchange INTO @x12_interchange_uid, @created_date
	WHILE (@@fetch_status <> -1)
	BEGIN
			DELETE FROM x12_parse_temp WHERE x12_parse_temp_uid = @x12_interchange_uid	-- clean up the x12_parse_temp table (just in case)
			EXEC up_x12_interchange_export	@x12_interchange_uid = @x12_interchange_uid	-- export the interchange to the x12_parse_temp table
			EXEC up_x12_file_export	@x12_interchange_uid = @x12_interchange_uid			-- drop the interchange from the x12_parse_temp table to disk
			DELETE FROM x12_parse_temp WHERE x12_parse_temp_uid = @x12_interchange_uid -- clean up the x12_parse_temp table (again)

			UPDATE x12_interchange set processed = 1 WHERE x12_interchange_uid = @x12_interchange_uid -- set the processed flag to true

			exec up_x12_interchange_set_status	@x12_interchange_uid = @x12_interchange_uid,
												@x12_interchange_status_ud = 'EXPORTED'					-- set the status to exported

		FETCH NEXT FROM curX12Interchange INTO @x12_interchange_uid, @created_date
	END

	CLOSE curX12Interchange
	DEALLOCATE curX12Interchange

