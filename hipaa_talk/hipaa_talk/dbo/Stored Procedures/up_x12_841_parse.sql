CREATE Procedure [dbo].[up_x12_841_parse] (@x12_transaction_id int, @se01_num_transaction_segments int = null output)
As

declare @Col001 varchar(264)
declare @Col002 varchar(264)
declare @Col003 varchar(264)
declare @Col004 varchar(264)
declare @Col005 varchar(264)
declare @Col006 varchar(264)
declare @Col007 varchar(264)
declare @Col008 varchar(264)
declare @Col009 varchar(264)
declare @Col010 varchar(264)
declare @Col011 varchar(264)
declare @Col012 varchar(264)
declare @Col013 varchar(264)
declare @Col014 varchar(264)
declare @Col015 varchar(264)
declare @Col016 varchar(264)
declare @Col017 varchar(264)
declare @Col018 varchar(264)
declare @Col019 varchar(264)
declare @Col020 varchar(264)
declare @Col021 varchar(264)


declare @L1000_spi01_security_level_code char(2)
declare @L1000_spi04_entity_title varchar(132)
declare @L1000_spi05_entity_purpose varchar(80)
declare @L1000_rdt04_171_revision_date char(8)
declare @L1000_rdt04_007_revision_date char(8)
declare @L1100_n101_entity_id_code char(3)
declare @L1100_n102_source_nm varchar(60)
declare @L2000_hl01_hierarchical_id_num varchar(12)
declare @L2000_hl03_hierarchical_child_code char(1)
declare @L2100_spi01_security_level_code char(2)
declare @L2100_spi02_ref_id_qual char(3)
declare @L2100_spi03_code_value varchar(30)
declare @L2100_spi04_entity_title varchar(132)
declare @L2100_msg01_message_text1 varchar(264)
declare @L2100_msg01_message_text2 varchar(264)
declare @L2100_msg01_message_text3 varchar(264)
declare @L2100_msg01_message_text4 varchar(264)
declare @L2100_msg01_message_text5 varchar(264)
declare @L2100_msg01_message_text6 varchar(264)
declare @L2100_msg01_message_text7 varchar(264)
declare @L2100_msg01_message_text8 varchar(264)
declare @L2100_msg01_message_text9 varchar(264)
declare @L2100_msg01_message_text10 varchar(264)

declare @isa16_component_element_seperator char(1)
declare @x12_interchange_uid uniqueidentifier

select	@isa16_component_element_seperator = isa16_component_element_seperator,
	@x12_interchange_uid = x12_interchange_uid
from vw_x12_transaction
where x12_transaction_id = @x12_transaction_id

if (@isa16_component_element_seperator IS NULL OR @isa16_component_element_seperator = ' ')
begin
	set @isa16_component_element_seperator = ':'
end

declare @x12_parse_temp_id_start int
declare @x12_parse_temp_id_end int
declare @curLoop varchar(8)
declare @prevLoop varchar(8)

set @se01_num_transaction_segments = 0

select	@x12_parse_temp_id_start = x12_parse_temp_id_start,
	@x12_parse_temp_id_end = x12_parse_temp_id_end
from x12_transaction where x12_transaction_id = @x12_transaction_id


DECLARE curt841 SCROLL CURSOR FOR
	select Col001, Col002, Col003, Col004, Col005, Col006, Col007, Col008, Col009, Col010, Col011, Col012, Col013, Col014, Col015, Col016, Col017
	from x12_parse_temp
	where	x12_parse_temp_id BETWEEN @x12_parse_temp_id_start AND @x12_parse_temp_id_end
			AND x12_parse_temp_uid = @x12_interchange_uid
	order by x12_parse_temp_id

OPEN curt841
FETCH NEXT FROM curt841 INTO @Col001, @Col002, @Col003, @Col004, @Col005, @Col006, @Col007, @Col008, @Col009, @Col010, @Col011, @Col012, @Col013, @Col014, @Col015, @Col016, @Col017
WHILE (@@fetch_status <> -1)
BEGIN
	set @prevLoop = @curLoop
	set @se01_num_transaction_segments = @se01_num_transaction_segments + 1

	-- 1000 LOOP: Specification Identifier Segment
	if ( RTrim(@col001) = 'SPI' AND LTRIM(RTRIM(@curLoop)) IS NULL)
	begin
		set @curLoop = '1000'
		set @L1000_spi01_security_level_code = LTRIM(RTRIM(@Col002))
		set @L1000_spi04_entity_title = LTRIM(RTRIM(@Col005))
		set @L1000_spi05_entity_purpose = LTRIM(RTRIM(@Col006))
	end

	-- 1000 LOOP: Revision-Release Date Segment
	if ( RTrim(@col001) = 'RDT' AND LTRIM(RTRIM(@curLoop)) = '1000' AND LTRIM(RTRIM(@Col004)) = '171')
	begin
		set @curLoop = '1000'
		set @L1000_rdt04_171_revision_date = LTRIM(RTRIM(@Col005))
	end

	-- 1000 LOOP: Revision-Effective Date Segment
	if ( RTrim(@col001) = 'RDT' AND LTRIM(RTRIM(@curLoop)) = '1000' AND LTRIM(RTRIM(@Col004)) = '007')
	begin
		set @curLoop = '1000'
		set @L1000_rdt04_007_revision_date = LTRIM(RTRIM(@Col005))
	end

	-- 1100 LOOP: Source Name Segment
	if ( RTrim(@col001) = 'N1' )
	begin
		set @curLoop = '1100'
		set @L1100_n101_entity_id_code = LTRIM(RTRIM(@Col002))
		set @L1100_n102_source_nm = LTRIM(RTRIM(@Col003))
	end

	-- 2000 LOOP: Hierarchical Level Segment
	if ( RTrim(@col001) = 'HL' )
	begin
		set @curLoop = '2000'
		set @L2000_hl01_hierarchical_id_num = LTRIM(RTRIM(@Col002))
		set @L2000_hl03_hierarchical_child_code = LTRIM(RTRIM(@Col004))
	end

	-- 2100 LOOP: Specification Identifier Segment
	if ( RTrim(@col001) = 'SPI' AND (LTRIM(RTRIM(@curLoop)) = '2000' OR LTRIM(RTRIM(@curLoop)) = '2100') )
	begin
		if ( @prevLoop = '2100' )
		begin
			exec up_x12_841_insert	@x12_transaction_id = @x12_transaction_id,
						@L1000_spi01_security_level_code = @L1000_spi01_security_level_code,
						@L1000_spi04_entity_title = @L1000_spi04_entity_title,
						@L1000_spi05_entity_purpose = @L1000_spi05_entity_purpose,
						@L1000_rdt04_171_revision_date = @L1000_rdt04_171_revision_date,
						@L1000_rdt04_007_revision_date = @L1000_rdt04_007_revision_date,
						@L1100_n101_entity_id_code = @L1100_n101_entity_id_code,
						@L1100_n102_source_nm = @L1100_n102_source_nm,
						@L2000_hl01_hierarchical_id_num = @L2000_hl01_hierarchical_id_num,
						@L2000_hl03_hierarchical_child_code = @L2000_hl03_hierarchical_child_code,
						@L2100_spi01_security_level_code = @L2100_spi01_security_level_code,
						@L2100_spi02_ref_id_qual = @L2100_spi02_ref_id_qual,
						@L2100_spi03_code_value = @L2100_spi03_code_value,
						@L2100_spi04_entity_title = @L2100_spi04_entity_title,
						@L2100_msg01_message_text1 = @L2100_msg01_message_text1,
						@L2100_msg01_message_text2 = @L2100_msg01_message_text2,
						@L2100_msg01_message_text3 = @L2100_msg01_message_text3,
						@L2100_msg01_message_text4 = @L2100_msg01_message_text4,
						@L2100_msg01_message_text5 = @L2100_msg01_message_text5,
						@L2100_msg01_message_text6 = @L2100_msg01_message_text6,
						@L2100_msg01_message_text7 = @L2100_msg01_message_text7,
						@L2100_msg01_message_text8 = @L2100_msg01_message_text8,
						@L2100_msg01_message_text9 = @L2100_msg01_message_text9,
						@L2100_msg01_message_text10 = @L2100_msg01_message_text10
		end

		set @L2100_msg01_message_text1 = null
		set @L2100_msg01_message_text2 = null
		set @L2100_msg01_message_text3 = null
		set @L2100_msg01_message_text4 = null
		set @L2100_msg01_message_text5 = null
		set @L2100_msg01_message_text6 = null
		set @L2100_msg01_message_text7 = null
		set @L2100_msg01_message_text8 = null
		set @L2100_msg01_message_text9 = null
		set @L2100_msg01_message_text10 = null

		set @curLoop = '2100'
		set @L2100_spi01_security_level_code = LTRIM(RTRIM(@Col002))
		set @L2100_spi02_ref_id_qual = LTRIM(RTRIM(@Col003))
		set @L2100_spi03_code_value = LTRIM(RTRIM(@Col004))
		set @L2100_spi04_entity_title = LTRIM(RTRIM(@Col005))
	end

	-- 2100 LOOP: Additional Text Segment (continuation of the spi05 value in the 2100 loop)
	if ( RTrim(@col001) = 'MSG' AND LTRIM(RTRIM(@curLoop)) = '2100')
	begin
		if ( @L2100_msg01_message_text1 IS NULL )
			set @L2100_msg01_message_text1 = LTRIM(RTRIM(@Col002))
		else if ( @L2100_msg01_message_text2 IS NULL )
			set @L2100_msg01_message_text2 = LTRIM(RTRIM(@Col002))
		else if ( @L2100_msg01_message_text3 IS NULL )
			set @L2100_msg01_message_text3 = LTRIM(RTRIM(@Col002))
		else if ( @L2100_msg01_message_text4 IS NULL )
			set @L2100_msg01_message_text4 = LTRIM(RTRIM(@Col002))
		else if ( @L2100_msg01_message_text5 IS NULL )
			set @L2100_msg01_message_text5 = LTRIM(RTRIM(@Col002))
		else if ( @L2100_msg01_message_text6 IS NULL )
			set @L2100_msg01_message_text6 = LTRIM(RTRIM(@Col002))
		else if ( @L2100_msg01_message_text7 IS NULL )
			set @L2100_msg01_message_text7 = LTRIM(RTRIM(@Col002))
		else if ( @L2100_msg01_message_text8 IS NULL )
			set @L2100_msg01_message_text8 = LTRIM(RTRIM(@Col002))
		else if ( @L2100_msg01_message_text9 IS NULL )
			set @L2100_msg01_message_text9 = LTRIM(RTRIM(@Col002))
		else if ( @L2100_msg01_message_text10 IS NULL )
			set @L2100_msg01_message_text10 = LTRIM(RTRIM(@Col002))

	end


	FETCH NEXT FROM curt841 INTO @Col001, @Col002, @Col003, @Col004, @Col005, @Col006, @Col007, @Col008, @Col009, @Col010, @Col011, @Col012, @Col013, @Col014, @Col015, @Col016, @Col017
END

CLOSE curt841
DEALLOCATE curt841


exec up_x12_841_insert	@x12_transaction_id = @x12_transaction_id,
			@L1000_spi01_security_level_code = @L1000_spi01_security_level_code,
			@L1000_spi04_entity_title = @L1000_spi04_entity_title,
			@L1000_spi05_entity_purpose = @L1000_spi05_entity_purpose,
			@L1000_rdt04_171_revision_date = @L1000_rdt04_171_revision_date,
			@L1000_rdt04_007_revision_date = @L1000_rdt04_007_revision_date,
			@L1100_n101_entity_id_code = @L1100_n101_entity_id_code,
			@L1100_n102_source_nm = @L1100_n102_source_nm,
			@L2000_hl01_hierarchical_id_num = @L2000_hl01_hierarchical_id_num,
			@L2000_hl03_hierarchical_child_code = @L2000_hl03_hierarchical_child_code,
			@L2100_spi01_security_level_code = @L2100_spi01_security_level_code,
			@L2100_spi02_ref_id_qual = @L2100_spi02_ref_id_qual,
			@L2100_spi03_code_value = @L2100_spi03_code_value,
			@L2100_spi04_entity_title = @L2100_spi04_entity_title,
			@L2100_msg01_message_text1 = @L2100_msg01_message_text1,
			@L2100_msg01_message_text2 = @L2100_msg01_message_text2,
			@L2100_msg01_message_text3 = @L2100_msg01_message_text3,
			@L2100_msg01_message_text4 = @L2100_msg01_message_text4,
			@L2100_msg01_message_text5 = @L2100_msg01_message_text5,
			@L2100_msg01_message_text6 = @L2100_msg01_message_text6,
			@L2100_msg01_message_text7 = @L2100_msg01_message_text7,
			@L2100_msg01_message_text8 = @L2100_msg01_message_text8,
			@L2100_msg01_message_text9 = @L2100_msg01_message_text9,
			@L2100_msg01_message_text10 = @L2100_msg01_message_text10


