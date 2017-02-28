



CREATE PROCEDURE [dbo].[up_x12_document_parse]
    (
		@x12_document_id int = null,
		@x12_content text = null,
		@x12_parse_temp_uid uniqueidentifier output,
		@errcode int = null output,
		@x12_interchange_id int = null output,
		@TA1_x12_interchange_id int = null output
    )
AS 
/*********************
-- START DOC --
PROCEDURE: up_x12_document_parse

	Parameter:	[IN] @x12_document_id int = NULL,					-- if used, this is the primary key of a record in the x12_document table.
				[IN] @x12_content text = NULL						-- if used, this should be a valid X12 string.
				[OUT] @x12_parse_temp_uid uniqueidentifier			-- a GUID is generated for each transaction (and attempt).
				[OUT] @errcode int = null output,					-- if any error-codes were generated, this is populated.
				[OUT] @x12_interchange_id int = null output,		-- if the interchanged was parsed successfully, this is returned.
				[OUT] @TA1_x12_interchange_id int = null output		-- if the interchange sender requested a TA1, this is returned.

	Type:		Parsing

	Description:	This stored procedure parses an X12 string that was retrieved from the x12_document
					table or passed to this procedure as a parameter.  The parsed data is then loaded into
					the x12_parse_temp table in preparation for loading into HIPAATalk transaction table(s).

	Note:			If both the @x12_content and @x12_document_id variables are passed, the 
					@x12_document_id parameter is ignored.
	 
	Example 1:	-- this example retrieves the data content from the x12_document table and parses it via the x12_parse_temp table.
				exec up_x12_document_parse	@x12_document_id = 2,
											@x12_parse_temp_uid = @x12_parse_temp_uid output,
											@errcode = @errcode output,
											@x12_interchange_id = @x12_interchange_id output,
											@TA1_x12_interchange_id = @TA1_x12_interchange_id output

	Example 2:	-- this example parses an X12 string via the x12_parse_temp table.
				exec up_x12_document_parse	@x12_content = 'ISA*....',
											@x12_parse_temp_uid = @x12_parse_temp_uid output,
											@errcode = @errcode output,
											@x12_interchange_id = @x12_interchange_id output,
											@TA1_x12_interchange_id = @TA1_x12_interchange_id output

	Functions Used:		dbo.fn_ListCount 

-- END DOC -- 
*********************/

    SET NOCOUNT ON		    -- we do not need to track the number of rows returned (saves time).
    SET XACT_ABORT OFF		-- we want subsequent procedures to be called in the event of an error.


	if (@x12_document_id IS NULL AND @x12_content IS NULL)
	begin
		PRINT 'A valid [x12_document_id] or [x12_content] must be specified.'
		set @errcode = 9999
		return(0)
	end

	-- For debugging and time-tracking of specific sections of code
	declare @debug bit
	declare @timeticker1 datetime
	declare @timeticker2 datetime
	set @debug = 0   -- If you want to display debug output, set this to 1.

	declare @x12_content_chunk varchar(1000)
	declare @contentLen int

    declare @segmentDelimiter varchar(5)
    declare @elementDelimiter varchar(5)

    declare @curSegment varchar(500)
    declare @curElement varchar(500)
    declare @segmentStart int
    declare @segmentLen int
    declare @segmentListLen int
	declare @curSegCount int
	declare @curSegmentLen int
	declare @NextDelimiterPOS int
	declare @Count int

	declare	@col001 varchar(264),
		@col002 varchar(264),
		@col003 varchar(264),
		@col004 varchar(264),
		@col005 varchar(264),
		@col006 varchar(264),
		@col007 varchar(264),
		@col008 varchar(264),
		@col009 varchar(264),
		@col010 varchar(264),
		@col011 varchar(264),
		@col012 varchar(264),
		@col013 varchar(264),
		@col014 varchar(264),
		@col015 varchar(264),
		@col016 varchar(264),
		@col017 varchar(264),
		@col018 varchar(264),
		@col019 varchar(264),
		@col020 varchar(264),
		@col021 varchar(264),
		@col022 varchar(264),
		@col023 varchar(264),
		@col024 varchar(264),
		@col025 varchar(264)

	set @segmentStart = 1
	set @segmentLen = 107

	-- if a text datatype has been passed in (is not null), parse it.
	if (@x12_content IS NOT NULL)
	begin
		set @x12_parse_temp_uid = NEWID()
		set @curSegment = SUBSTRING(@x12_content, @segmentStart, @segmentStart + @segmentLen)
		set @contentLen = DATALENGTH(@x12_content)
		insert into x12_document (x12_document_uid, filedata) values (@x12_parse_temp_uid, @x12_content)
	end
	else
	begin
		-- Read the first 107 characters of the file/content to determine interchange information
		select  @x12_parse_temp_uid = x12_document_uid,
			@curSegment = SUBSTRING(filedata, @segmentStart, @segmentStart + @segmentLen),
			@contentLen = DATALENGTH(filedata)
		from    x12_document
		where   x12_document_id = @x12_document_id
	end

	-- If there already exists an interchange with this GUID, don't parse it again.
	if exists (select x12_interchange_uid from x12_interchange where x12_interchange_uid = @x12_parse_temp_uid)
	begin
		update x12_document set error = 1 where x12_document_uid = @x12_parse_temp_uid
		set @errcode = 1000
		PRINT 'This interchange has already been parsed.  To parse again, delete the first interchange by using "exec up_x12_interchange_delete @x12_interchange_uid = @x12_interchange_uid"'
		return
	end
	-- If there already exists an interchange with this GUID, don't parse it again.
	if (LEFT(@curSegment, 3) <> 'ISA')
	begin
		update x12_document set error = 1 where x12_document_uid = @x12_parse_temp_uid
		set @errcode = 9990
		PRINT 'This is not a valid interchange.  First segment "' + @curSegment + '" is not a valid ISA segment.'
		return
	end

    declare @destColumnName varchar(50)
    declare @destColumnList varchar(250)

	-- Get the 106th character which is the segment delimiter
	set @segmentDelimiter = SUBSTRING(@curSegment, 106, 1)

 -- Get the 106th character to see if a line feed is used instead of a standard character
	if (SUBSTRING(@curSegment, 106, 1) = CHAR(10))
	begin
		set @segmentDelimiter = @segmentDelimiter + CHAR(13)
	end
 -- Get the 107th character to see if a carriage return is used after the standard delimiter
	else if (SUBSTRING(@curSegment, 107, 1) = CHAR(13))
	begin
		set @segmentDelimiter = @segmentDelimiter + CHAR(13) + CHAR(10)
	end
 -- Get the 107th character to see if a line feed is used after the standard delimiter
	else if (SUBSTRING(@curSegment, 107, 1) = CHAR(10))
	begin
		set @segmentDelimiter = @segmentDelimiter + CHAR(10)
	end

    -- retrieve the element delimiter from the ISA segment
	set @elementDelimiter = SUBSTRING(@curSegment, 4, 1)

	-- until we're at the end of the contents, keep on reading out the segments
	while (@segmentStart < @contentLen)
	begin
		-- Reset column values
		select	@col001 = null,
			@col002 = null,
			@col003 = null,
			@col004 = null,
			@col005 = null,
			@col006 = null,
			@col007 = null,
			@col008 = null,
			@col009 = null,
			@col010 = null,
			@col011 = null,
			@col012 = null,
			@col013 = null,
			@col014 = null,
			@col015 = null,
			@col016 = null,
			@col017 = null,
			@col018 = null,
			@col019 = null,
			@col020 = null,
			@col021 = null,
			@col022 = null,
			@col023 = null,
			@col024 = null,
			@col025 = null

		/*	Read a portion of the content (essentially just up to 1000 characters).
			If the x12_content variable is populated, use that -- otherwise use the database.
		*/
		set @timeticker1 = getdate()
		if (@x12_content IS NOT NULL)
		begin
			set @x12_content_chunk = SUBSTRING(@x12_content, @segmentStart, @contentLen)
		end
		else
		begin
			select  @x12_content_chunk = SUBSTRING(filedata, @segmentStart, @contentLen)
			from    x12_document
			where   x12_document_id = @x12_document_id
		end
		set @timeticker2 = getdate()

		if (@debug = 1) PRINT 'RETRIEVE CHUNK TIME: ' + STR(DATEDIFF(ms, @timeticker1, @timeticker2))+ 'ms.'

		-- Check to see what's left in the x12_content.
		if	(
				Len(LTrim(RTrim(@x12_content_chunk))) = 0 OR
				LTrim(RTrim(@x12_content_chunk)) = CHAR(10) OR
				LTrim(RTrim(@x12_content_chunk)) = CHAR(13) OR
				LTrim(RTrim(@x12_content_chunk)) = CHAR(13) + CHAR(10)
			)
		begin
			-- If what's left in the content is just delimiters or spaces, set length variables to 0.
			set @x12_content_chunk = ''
			set @segmentLen = 0
			set @curSegment = ''
			set @segmentListLen = 0
		end
		else
		begin
			-- If the content is valid, keep on truckin'.

			-- Get the length of this segment by finding the next instance of the delimiter
			set @segmentLen = PATINDEX('%' + @segmentDelimiter + '%', @x12_content_chunk)
			if (IsNull(@segmentLen, 0) = 0)
			begin
				set @segmentLen = 1
			end
			-- Now we can scoop out the actual segment string
			set @curSegment = SUBSTRING(@x12_content_chunk, 1, @segmentLen-1)

			set @segmentListLen = dbo.fn_ListCount(@curSegment, @elementDelimiter)
		end

		set @curSegCount = @segmentListLen
		set @Count = 0

		set @timeticker1 = getdate()
		-- This WHILE LOOP parses the segment--this is faster than calling another stored procedure to do this.
		while (@curSegCount > 0)
		begin
			set @Count = @Count + 1

			-- get the current segment length
			set @curSegmentLen = LEN(@curSegment)

			-- get the position of the next delimiter, use the segment length if none found
			set @NextDelimiterPOS = CHARINDEX(@elementDelimiter, @curSegment)
			if (@NextDelimiterPOS <= 0) set @NextDelimiterPOS = @curSegmentLen
			else set @NextDelimiterPOS = @NextDelimiterPOS - 1

			-- get the current element value
			set @curElement = LEFT(@curSegment, @NextDelimiterPOS)

			-- set the rest of the segment:
			set @curSegment = SUBSTRING(@curSegment, DATALENGTH(@curElement)+2, @curSegmentLen)
			set @curSegCount = @curSegCount - 1

			if (Len(@curElement) = 0)
			begin
				set @curElement = null
			end

			-- For performance, we do this in somewhat of a hard-coded fashion
			if (@Count = 1) set @col001 = @curElement
			if (@Count = 2) set @col002 = @curElement
			if (@Count = 3) set @col003 = @curElement
			if (@Count = 4) set @col004 = @curElement
			if (@Count = 5) set @col005 = @curElement
			if (@Count = 6) set @col006 = @curElement
			if (@Count = 7) set @col007 = @curElement
			if (@Count = 8) set @col008 = @curElement
			if (@Count = 9) set @col009 = @curElement
			if (@Count = 10) set @col010 = @curElement
			if (@Count = 11) set @col011 = @curElement
			if (@Count = 12) set @col012 = @curElement
			if (@Count = 13) set @col013 = @curElement
			if (@Count = 14) set @col014 = @curElement
			if (@Count = 15) set @col015 = @curElement
			if (@Count = 16) set @col016 = @curElement
			if (@Count = 17) set @col017 = @curElement
			if (@Count = 18) set @col018 = @curElement
			if (@Count = 19) set @col019 = @curElement
			if (@Count = 20) set @col020 = @curElement
			if (@Count = 21) set @col021 = @curElement
			if (@Count = 22) set @col022 = @curElement
			if (@Count = 23) set @col023 = @curElement
			if (@Count = 24) set @col024 = @curElement
			if (@Count = 25) set @col025 = @curElement
		end
		set @timeticker2 = getdate()
		if (@debug = 1) PRINT 'PARSING SEGMENT TIME: ' + STR(DATEDIFF(ms, @timeticker1, @timeticker2))+ 'ms.'

		if (@segmentLen > 0)
		begin
			set @timeticker1 = getdate()
			insert x12_parse_temp(	x12_parse_temp_uid, 
									col001, col002, col003, col004, col005,
									col006, col007, col008, col009, col010,
									col011, col012, col013, col014, col015,
									col016, col017, col018, col019, col020,
									col021, col022, col023, col024, col025
								)
				values	(	@x12_parse_temp_uid,
							@col001, @col002, @col003, @col004, @col005,
							@col006, @col007, @col008, @col009, @col010,
							@col011, @col012, @col013, @col014, @col015,
							@col016, @col017, @col018, @col019, @col020,
							@col021, @col022, @col023, @col024, @col025
						)
			set @timeticker2 = getdate()
			if (@debug = 1) PRINT 'INSERT RECORD TIME: ' + STR(DATEDIFF(ms, @timeticker1, @timeticker2))+ 'ms.'
	
			-- set the next segment-start position to the current start pos, plus the segment length, plus the delimiter length
			set @segmentStart = @segmentStart + @segmentLen - 1 + LEN(@segmentDelimiter)
		end
		else
		begin
			set @segmentStart = @contentLen
		end
	end

	-- if the document was parsed successfully, parse the interchange into the transaction tables.
	exec up_x12_interchange_parse	@x12_parse_temp_uid = @x12_parse_temp_uid,
					@element_separator = @elementDelimiter,
					@segment_separator = @segmentDelimiter,
					@errcode = @errcode output,
					@x12_interchange_id = @x12_interchange_id output,
					@TA1_x12_interchange_id = @TA1_x12_interchange_id output

	update x12_document set processed = 1 where x12_document_uid = @x12_parse_temp_uid
