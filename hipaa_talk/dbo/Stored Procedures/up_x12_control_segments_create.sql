CREATE PROCEDURE [dbo].[up_x12_control_segments_create] (	@x12_transaction_id int output,
								@x12_functional_group_id int output,
								@x12_interchange_id int output,
								@src_x12_organization_id int,
								@dest_x12_organization_id int,
								@x12_transaction_schema_ud varchar(32),
								@x12_interchange_status_ud varchar(32) = null,
								@src_x12_functional_group_id int = null,
								@filename varchar(512) = null,
								@isa15_usage_indicator varchar(1) = 'P'
								) AS

-- NGUYENT tt4541 10.31.2007 - adding @ISA15_UsageIndicator to tell if this is a test or production export

-- The @src_x12_functional_group_id variable is used if these control segments are being created in response to a particular transaction.
declare @gs01_functional_id_code varchar(5)
declare @src_gs02_app_sender_code varchar(15)
declare @src_gs03_app_receiver_code varchar(15)
declare @gs02_app_sender_code varchar(15)
declare @gs03_app_receiver_code varchar(15)
declare @gs08_version_id_code varchar(12)
declare @st01_transaction_id_code varchar(32)
declare @x12_interchange_status_id int

if (@src_x12_functional_group_id IS NOT NULL)
begin
	select	@src_gs02_app_sender_code = gs02_app_sender_code,
		@src_gs03_app_receiver_code = gs03_app_receiver_code
	from vw_x12_transaction
	where x12_functional_group_id = @src_x12_functional_group_id

	set @gs02_app_sender_code = @src_gs03_app_receiver_code
	set @gs03_app_receiver_code = @src_gs02_app_sender_code
end
else
begin
	set @gs02_app_sender_code = null
	set @gs03_app_receiver_code = null
end


select	@gs08_version_id_code = functional_version_id_code,
	@gs01_functional_id_code = functional_group_id_code,
	@st01_transaction_id_code = transaction_id_code
from x12_transaction_schema
where x12_transaction_schema_ud = @x12_transaction_schema_ud

select @x12_interchange_status_id = x12_interchange_status_id
from x12_interchange_status
where x12_interchange_status_ud = @x12_interchange_status_ud

exec up_x12_interchange_create		@x12_interchange_id = @x12_interchange_id output,
					@x12_interchange_status_id = @x12_interchange_status_id,
					@src_x12_organization_id = @src_x12_organization_id,
					@dest_x12_organization_id = @dest_x12_organization_id,
					@outgoing = 1,
					@filename = @filename,
					@isa15_usage_indicator = @isa15_usage_indicator

exec up_x12_functional_group_create	@x12_functional_group_id = @x12_functional_group_id output,
					@x12_interchange_id = @x12_interchange_id,
					@gs01_functional_id_code = @gs01_functional_id_code,
					@gs02_app_sender_code = @gs02_app_sender_code,
					@gs03_app_receiver_code = @gs03_app_receiver_code,
					@gs08_version_id_code = @gs08_version_id_code

exec up_x12_transaction_create		@x12_transaction_id = @x12_transaction_id output,
					@x12_functional_group_id = @x12_functional_group_id,
					@st01_transaction_id_code = @st01_transaction_id_code

