

CREATE Procedure [dbo].[up_x12_ta1_parse] (@x12_interchange_uid uniqueidentifier = null)
As

declare @Col001 varchar(80)
declare @Col002 varchar(80)
declare @Col003 varchar(80)
declare @Col004 varchar(80)
declare @Col005 varchar(80)
declare @Col006 varchar(80)
declare @Col007 varchar(80)
declare @Col008 varchar(80)
declare @Col009 varchar(80)
declare @Col010 varchar(80)
declare @Col011 varchar(80)
declare @Col012 varchar(80)
declare @Col013 varchar(80)
declare @Col014 varchar(80)
declare @Col015 varchar(80)
declare @Col016 varchar(80)
declare @Col017 varchar(80)

declare @x12_interchange_id int

declare @ta101_isa13_control_no char(9)
declare @ta102_interchange_date char(6)
declare @ta103_interchange_time char(4)
declare @ta104_interchange_ack_code char(1)
declare @ta105_interchange_note_code char(3)

declare @errmsg varchar(250)
declare @errcode int

select @x12_interchange_id = x12_interchange_id FROM x12_interchange WHERE x12_interchange_uid = @x12_interchange_uid

DECLARE curtX12Doc SCROLL CURSOR FOR
	select Col001, Col002, Col003, Col004, Col005, Col006, Col007, Col008, Col009, Col010, Col011, Col012, Col013, Col014, Col015, Col016, Col017
	from x12_parse_temp
	where	x12_parse_temp_uid = @x12_interchange_uid AND Col001 = 'TA1'
	order by x12_parse_temp_id

OPEN curtX12Doc

FETCH NEXT FROM curtX12Doc INTO @Col001, @Col002, @Col003, @Col004, @Col005, @Col006, @Col007, @Col008, @Col009, @Col010, @Col011, @Col012, @Col013, @Col014, @Col015, @Col016, @Col017
WHILE (@@fetch_status <> -1)
BEGIN
	if ( RTrim(@col001) = 'TA1')
	begin
		set @ta101_isa13_control_no = LTRIM(RTRIM(@col002))
		set @ta102_interchange_date = LTRIM(RTRIM(@col003))
		set @ta103_interchange_time = LTRIM(RTRIM(@col004))
		set @ta104_interchange_ack_code = LTRIM(RTRIM(@col005))
		set @ta105_interchange_note_code = LTRIM(RTRIM(@col006))

		insert into x12_ta1_interchange_ack
			(	x12_interchange_id,
				ta101_isa13_control_no,
				ta102_interchange_date,
				ta103_interchange_time,
				ta104_interchange_ack_code,
				ta105_interchange_note_code )
		VALUES (
				@x12_interchange_id,
				@ta101_isa13_control_no,
				@ta102_interchange_date,
				@ta103_interchange_time,
				@ta104_interchange_ack_code,
				@ta105_interchange_note_code
			)

	end

	FETCH NEXT FROM curtX12Doc INTO @Col001, @Col002, @Col003, @Col004, @Col005, @Col006, @Col007, @Col008, @Col009, @Col010, @Col011, @Col012, @Col013, @Col014, @Col015, @Col016, @Col017
END
CLOSE curtX12Doc
DEALLOCATE curtX12Doc

return (0)
