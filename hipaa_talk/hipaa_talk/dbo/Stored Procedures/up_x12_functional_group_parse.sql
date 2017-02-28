
CREATE Procedure [dbo].[up_x12_functional_group_parse](	@x12_interchange_id int = null)
AS
	
-- This procedure is called by up_x12_interchange_parse
declare @997_x12_interchange_id int

declare @x12_functional_group_id int
declare @x12_transaction_id int
declare @isa14_ack_requested char(1)
declare @gs08_version_id_code varchar(12)
declare @x12_parse_temp_id_start int
declare @x12_parse_temp_id_end int
declare @st01_transaction_id_code char(3)
declare @st02_transaction_control_no varchar(10)
declare @se01_num_transaction_segments int
declare @errcode int
declare @errmsg varchar(250)
select @isa14_ack_requested = isa14_ack_requested FROM x12_interchange where x12_interchange_id = @x12_interchange_id
-- Get all the functional groups for this interchange
DECLARE curX12FunctionalGroup SCROLL CURSOR FOR	select	x12_functional_group_id
						from x12_functional_group
						where	x12_interchange_id = @x12_interchange_id
OPEN curX12FunctionalGroup
FETCH NEXT FROM curX12FunctionalGroup INTO @x12_functional_group_id
WHILE (@@fetch_status <> -1)
BEGIN
	exec up_x12_transaction_parse @x12_functional_group_id
	-- Set the "processed" bit to TRUE
	update x12_functional_group SET processed = 1 where x12_functional_group_id = @x12_functional_group_id
	if (@isa14_ack_requested = 1)
	begin
		-- Create Functional Group 997 ack
		exec up_x12_997_create	@src_x12_functional_group_id = @x12_functional_group_id,
						@x12_interchange_id = @997_x12_interchange_id output
						-- @997_x12_transaction_id output
		exec up_x12_interchange_export	@x12_interchange_id = @997_x12_interchange_id
		set @997_x12_interchange_id = null
	end
	FETCH NEXT FROM curX12FunctionalGroup INTO @x12_functional_group_id
END
CLOSE curX12FunctionalGroup
DEALLOCATE curX12FunctionalGroup
return (0)
