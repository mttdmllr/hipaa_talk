

CREATE Procedure [dbo].[up_x12_transaction_parse]( @x12_functional_group_id int = null )
As
-- This procedure is called by up_x12_functional_group_parse
	
declare @x12_transaction_id int
declare @x12_parse_temp_id_start int
declare @x12_parse_temp_id_end int
declare @st01_transaction_id_code char(3)
declare @se01_num_transaction_segments int
declare @gs08_version_id_code varchar(12)
declare @cur_parse_procedure_nm varchar(128)
declare @errcode int
declare @errmsg varchar(250)

-- Get the Functional Group Version code and the Transaction Schema parsing procedure
select	@gs08_version_id_code = x12_functional_group.gs08_version_id_code,
	@cur_parse_procedure_nm = x12_transaction_schema.parse_procedure_nm
FROM x12_functional_group
INNER JOIN x12_transaction_schema
	ON x12_functional_group.x12_transaction_schema_id = x12_transaction_schema.x12_transaction_schema_id 
where x12_functional_group.x12_functional_group_id = @x12_functional_group_id

-- Get all the transactions for this functional group
DECLARE curX12Transaction SCROLL CURSOR FOR	select x12_transaction_id, st01_transaction_id_code
							from x12_transaction
							where	x12_functional_group_id = @x12_functional_group_id

OPEN curX12Transaction
FETCH NEXT FROM curX12Transaction INTO @x12_transaction_id, @st01_transaction_id_code
WHILE (@@fetch_status <> -1)
BEGIN
	if (@cur_parse_procedure_nm IS NOT NULL)
	begin
		exec @cur_parse_procedure_nm @x12_transaction_id = @x12_transaction_id, @se01_num_transaction_segments = @se01_num_transaction_segments output
	end

	if (@cur_parse_procedure_nm IS NULL)
	begin
		select	'Transaction Version Code' = @gs08_version_id_code,
			'Error Message' = 'Parsing procedure not defined for this transaction version code.'
	end
	-- Update the x12_transaction record with the number of segments we just processed.
	-- Set the "processed" bit to TRUE
	UPDATE x12_transaction SET	se01_num_transaction_segments = @se01_num_transaction_segments,
					processed = 1
		where x12_transaction_id = @x12_transaction_id
	FETCH NEXT FROM curX12Transaction INTO @x12_transaction_id, @st01_transaction_id_code
END
CLOSE curX12Transaction
DEALLOCATE curX12Transaction
return (0)
