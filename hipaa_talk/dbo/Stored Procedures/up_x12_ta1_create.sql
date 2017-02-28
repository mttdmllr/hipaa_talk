
CREATE Procedure [dbo].[up_x12_ta1_create] (	@src_x12_interchange_id int,
					@x12_interchange_id int = null output,
					@ta104_interchange_ack_code char(1) = 'A',
					@ta105_interchange_note_code char(3) = '000')
As
declare @isa01_auth_info_qual char (2)
declare @isa02_auth_info char (10)
declare @isa03_security_info_qual char (2)
declare @isa04_security_info char (10)
declare @isa05_sender_id_qual char (2)
declare @isa06_sender_id char (15)
declare @isa07_receiver_id_qual char (2)
declare @isa08_receiver_id char (15)
declare @isa09_interchange_date char (6)
declare @isa10_interchange_time char (4)
declare @isa11_control_standards_id char (1)
declare @isa12_control_version_no char (5)
declare @isa13_control_no char (9)
declare @isa14_ack_requested char (1)
declare @isa15_usage_indicator char (1)
declare @ta101_isa13_control_no char(9)
declare @ta102_interchange_date char(6)
declare @ta103_interchange_time char(4)
declare @x12_interchange_uid uniqueidentifier
set @x12_interchange_uid = NEWID()
-- BEGIN: Generate the TA1 and ISA information from the original transaction
	select	@isa01_auth_info_qual = '00',
		@isa02_auth_info = SPACE(10),
		@isa03_security_info_qual = '00',
		@isa04_security_info = SPACE(10),
		@isa05_sender_id_qual = isa07_receiver_id_qual,
		@isa06_sender_id = isa08_receiver_id,
		@isa07_receiver_id_qual = isa05_sender_id_qual,
		@isa08_receiver_id = isa06_sender_id,
		@isa09_interchange_date = RIGHT(CONVERT(varchar(4), DATEPART(yy, GetDate())), 2) + CAST(DATEPART(mm, GetDate()) as char(2)) + CAST(DATEPART(dd, GetDate()) as char(2)),
		@isa10_interchange_time = CAST(DATEPART(hh, GetDate()) as char(2)) + CAST(DATEPART(mi, GetDate()) as char(2)),
		@isa11_control_standards_id = 'U',
		@isa12_control_version_no = '00401',
		@isa14_ack_requested = '0',
		@isa15_usage_indicator = isa15_usage_indicator, -- if production was sent, then we send production
		@ta101_isa13_control_no = isa13_control_no,
		@ta102_interchange_date = RIGHT(CONVERT(varchar(4), DATEPART(yy, GetDate())), 2) + CAST(DATEPART(mm, GetDate()) as char(2)) + CAST(DATEPART(dd, GetDate()) as char(2)),
		@ta103_interchange_time = CAST(DATEPART(hh, GetDate()) as char(2)) + CAST(DATEPART(mi, GetDate()) as char(2))
	from x12_interchange
	where x12_interchange_id = @src_x12_interchange_id
-- END: Generate the TA1 and ISA information
	-- Create the TA1 transaction header record
	exec up_x12_interchange_create		@x12_interchange_id = @x12_interchange_id output,
						@x12_interchange_uid = null,				-- don't send x12_interchange_uid, let the system generate it
						@x12_interchange_status_id = null,
						@isa01_auth_info_qual = @isa01_auth_info_qual,
						@isa02_auth_info = @isa02_auth_info,
						@isa03_security_info_qual = @isa03_security_info_qual,
						@isa04_security_info = @isa04_security_info,
						@isa05_sender_id_qual = @isa05_sender_id_qual,
						@isa06_sender_id = @isa06_sender_id,
						@isa07_receiver_id_qual = @isa07_receiver_id_qual,
						@isa08_receiver_id = @isa08_receiver_id,
						@isa09_interchange_date = @isa09_interchange_date,
						@isa10_interchange_time = @isa10_interchange_time,
						@isa11_control_standards_id = @isa11_control_standards_id,
						@isa12_control_version_no = @isa12_control_version_no,
						@isa13_control_no = null, 				-- don't send the ISA control number, it's created automatically
						@isa14_ack_requested = @isa14_ack_requested,
						@isa15_usage_indicator = @isa15_usage_indicator,
						@x12_parse_temp_id_start = NULL,	-- ISA ID value not necessary
						@x12_parse_temp_id_end = NULL,	-- IEA ID value not necessary
						@filename = NULL,			-- filename not known
						@incoming = 0,				-- DO NOT send the "incoming" bit flag
						@outgoing = 1,				-- send the outgoing flag
						@error = 0,				-- error = 0
						@processed = 0,			-- processed = 0
						@active = 1				-- active = 1

	INSERT INTO x12_ta1_interchange_ack (	x12_interchange_id,
							src_x12_interchange_id,
							ta101_isa13_control_no,
							ta102_interchange_date,
							ta103_interchange_time,
							ta104_interchange_ack_code,
							ta105_interchange_note_code )
		VALUES	(	@x12_interchange_id,
					@src_x12_interchange_id,
					LTRIM(RTRIM(@ta101_isa13_control_no)),
					LTRIM(RTRIM(@ta102_interchange_date)),
					LTRIM(RTRIM(@ta103_interchange_time)),
					LTRIM(RTRIM(@ta104_interchange_ack_code)),
					LTRIM(RTRIM(@ta105_interchange_note_code))
				)

	update x12_interchange set filename = dbo.fn_x12_dropoff_location_address(x12_interchange_uid) where x12_interchange_id = @x12_interchange_id

return (0)
