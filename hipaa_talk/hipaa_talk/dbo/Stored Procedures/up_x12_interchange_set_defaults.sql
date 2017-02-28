CREATE PROCEDURE [dbo].[up_x12_interchange_set_defaults] (	@x12_interchange_id int,
								@x12_functional_group_id int = null,
								@x12_transaction_id int = null)
AS
/*********************
-- START DOC --
PROCEDURE: up_x12_interchange_set_defaults 
	Parameter:		[IN] @x12_interchange_id INT - REQUIRED
				[IN] @x12_functional_group_id INT
				[IN] @x12_transaction_id INT
	Type:			UPDATE
	Description:		This stored procedure retrieves the default values per organization, per transaction, per table/column and updates
				the associated record(s) with it.  Developer passes at least the x12_interchange_id and optionally the
				x12_functional_group_id and x12_transaction_id and the procedure will upate the table with the default values
				specified in the x12_organization_default table.
	Example:		EXEC up_x12_interchange_set_defaults 5  -- sets the defaults for all transactions where the x12_interchange_id = 5
	Usage:			EXEC up_x12_interchange_set_defaults 5  -- sets the defaults for all transactions where the x12_interchange_id = 5
				EXEC up_x12_interchange_set_defaults 5, 6  -- sets the defaults for all transactions where the x12_interchange_id = 5,
										and the x12_functional_group_id = 6
				EXEC up_x12_interchange_set_defaults 5, 6, 7  -- sets the defaults for a single transaction where the x12_interchange_id = 5
										the x12_functional_group_id = 6
										and the x12_transaction_id = 7
	Functions Used:		NONE
				
-- END DOC --
*********************/
declare @debug bit
set @debug = 0
if (@debug = 1) select 'DEBUG TURNED ON!  NO ACTUAL PROCESSING WILL BE DONE!'
declare @dest_x12_organization_id int
declare @src_x12_organization_id int
declare @default_value varchar(80)
declare @table_nm varchar(64)
declare @column_nm varchar(64)
declare @use_if_source bit
declare @use_if_dest bit
declare @use_if_null bit
declare @override_value bit
declare @SQLString nvarchar(4000) 
-- Uses the max function just in case there are multiple transaction records in the view
select	@dest_x12_organization_id = MAX(IsNull(dest_x12_organization_id, 0)),
	@src_x12_organization_id = MAX(IsNull(src_x12_organization_id, 0))
from vw_x12_transaction
WHERE	(x12_interchange_id = @x12_interchange_id) AND
		(x12_functional_group_id = @x12_functional_group_id OR @x12_functional_group_id IS NULL) AND
		(x12_transaction_id = @x12_transaction_id OR @x12_transaction_id IS NULL)
/*
select	@dest_x12_organization_id as 'dest_x12_organization_id',
	@src_x12_organization_id as 'src_x12_organization_id',
	@x12_interchange_id as 'x12_interchange_id',
	@x12_functional_group_id as 'x12_functional_group_id',
	@x12_transaction_id as 'x12_transaction_id'
*/
DECLARE curX12Defaults SCROLL CURSOR FOR
			select	default_value,
				table_nm,
				column_nm,
				use_if_source,
				use_if_dest,
				use_if_null,
				override_value
			from x12_organization_default
			where	(x12_organization_id = @dest_x12_organization_id AND use_if_dest = 1) OR
				(x12_organization_id = @src_x12_organization_id AND use_if_source = 1)
OPEN curX12Defaults
FETCH NEXT FROM curX12Defaults INTO	@default_value,
					@table_nm,
					@column_nm,
					@use_if_source,
					@use_if_dest,
					@use_if_null,
					@override_value
WHILE (@@fetch_status <> -1)
BEGIN
	if (@use_if_null = 1)
	begin
		if (@use_if_dest = 1)
		begin
			set @SQLString = 'update ' + @table_nm + ' set ' + @column_nm + ' = @default_value
					WHERE	x12_transaction_id IN (SELECT x12_transaction_id FROM vw_x12_transaction
									WHERE	(x12_interchange_id = @x12_interchange_id) AND
										(x12_functional_group_id = @x12_functional_group_id OR @x12_functional_group_id IS NULL) AND
										(x12_transaction_id = @x12_transaction_id OR @x12_transaction_id IS NULL) AND
										(dest_x12_organization_id = @dest_x12_organization_id)
									) AND
						(' + @column_nm + ' IS NULL OR Len(LTrim(RTrim(' + @column_nm + '))) = 0)'
-- print @SQLString
			if (@debug = 1) print 'updating defaults for destination organization'
			exec sp_executesql	@SQLString, 
						N'@default_value varchar(80), @src_x12_organization_id int, @dest_x12_organization_id int, @x12_interchange_id int, @x12_functional_group_id int, @x12_transaction_id int', 
						@default_value,
						@src_x12_organization_id, 
						@dest_x12_organization_id, 
						@x12_interchange_id, 
						@x12_functional_group_id, 
						@x12_transaction_id
		end
		if (@use_if_source = 1)
		begin
			set @SQLString = 'update ' + @table_nm + ' set ' + @column_nm + ' = @default_value
					WHERE	x12_transaction_id IN (SELECT x12_transaction_id FROM vw_x12_transaction
									WHERE	(x12_interchange_id = @x12_interchange_id) AND
										(x12_functional_group_id = @x12_functional_group_id OR @x12_functional_group_id IS NULL) AND
										(x12_transaction_id = @x12_transaction_id OR @x12_transaction_id IS NULL) AND
										(src_x12_organization_id = @src_x12_organization_id)
									) AND
						(' + @column_nm + ' IS NULL OR Len(LTrim(RTrim(' + @column_nm + '))) = 0)'
-- print @SQLString
			if (@debug = 1) print 'updating defaults for source organization'
			exec sp_executesql	@SQLString, 
						N'@default_value varchar(80), @src_x12_organization_id int, @dest_x12_organization_id int, @x12_interchange_id int, @x12_functional_group_id int, @x12_transaction_id int', 
						@default_value,
						@src_x12_organization_id, 
						@dest_x12_organization_id, 
						@x12_interchange_id, 
						@x12_functional_group_id, 
						@x12_transaction_id
		end
	end
	FETCH NEXT FROM curX12Defaults INTO	@default_value,
						@table_nm,
						@column_nm,
						@use_if_source,
						@use_if_dest,
						@use_if_null,
						@override_value
END
CLOSE curX12Defaults
DEALLOCATE curX12Defaults
