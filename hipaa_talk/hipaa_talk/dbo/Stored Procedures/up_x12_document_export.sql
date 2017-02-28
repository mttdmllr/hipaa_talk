

CREATE PROCEDURE [dbo].[up_x12_document_export]
    (
		@x12_interchange_uid uniqueidentifier = null,
		@x12_interchange_id int = null,
		@regenerate_if_exists bit = 0,
		@x12_document_id int = null output
    )
AS 
    SET NOCOUNT ON		    -- we do not need to track the number of rows returned (saves time).
    SET XACT_ABORT OFF		-- we want subsequent procedures to be called in the event of an error.

	declare @ptrval binary(16)
	declare @contentLen int

	declare @hasLastElement bit
	declare @segment_separator varchar(5)
	declare @element_separator varchar(5)
	declare @strFileLine varchar(2000)

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
			@col020 varchar(264)

	if ( @x12_interchange_uid IS NULL)
	begin
		select	@x12_interchange_uid = x12_interchange_uid
		from x12_interchange
		where x12_interchange_id = @x12_interchange_id
	end

	if ( @x12_interchange_uid IS NULL)
	begin
		PRINT 'Interchange does not exist, nothing to export!'
		return(0)
	end

	-- Get the element and segment separators from the interchange table, if they exist.
	if (@x12_interchange_uid IS NOT NULL)
	begin
		select	@element_separator = element_separator,
				@segment_separator = segment_separator
		from x12_interchange
		where x12_interchange_uid = @x12_interchange_uid
	end

	-- If the element and segment separators weren't specified, set them to these defaults.
	if (@segment_separator IS NULL) set @segment_separator = '~'	-- these should be set up as a default somewhere
	if (@element_separator IS NULL) set @element_separator = '*'	-- these should be set up as a default somewhere


	if (@regenerate_if_exists = 1)
	begin
		delete from x12_document where x12_document_uid = @x12_interchange_uid
		delete from x12_parse_temp where x12_parse_temp_uid = @x12_interchange_uid
	end

	if not exists (select x12_document_id from x12_document
					where x12_document_uid = @x12_interchange_uid)
	begin
		insert into x12_document (x12_document_uid, filedata, filename)
		(
			select	x12_interchange_uid,
				filedata = '',
				IsNull(filename, dbo.fn_x12_dropoff_location_address(@x12_interchange_uid))
			from x12_interchange
			where x12_interchange_uid = @x12_interchange_uid
		)
	end

	select	@x12_document_id = x12_document_id,
			@ptrval = TEXTPTR(filedata),
			@contentLen = DATALENGTH(filedata)
	from x12_document
	where x12_document_uid = @x12_interchange_uid

	if (@contentLen > 0 AND TEXTVALID('x12_document.filedata', @ptrVal) = 1 )
	begin
		READTEXT x12_document.filedata @ptrVal 0 @contentLen
		return
	end

	if not exists (select x12_parse_temp_uid from x12_parse_temp
					where x12_parse_temp_uid = @x12_interchange_uid)
	begin
		exec up_x12_interchange_export @x12_interchange_uid = @x12_interchange_uid
	end

	set @contentLen = 0 -- this changes each time a segment is written to help calculate the offset

	DECLARE curX12Defaults SCROLL CURSOR FOR
			select	IsNull(col001, ''),
				IsNull(col002, ''),
				IsNull(col003, ''),
				IsNull(col004, ''),
				IsNull(col005, ''),
				IsNull(col006, ''),
				IsNull(col007, ''),
				IsNull(col008, ''),
				IsNull(col009, ''),
				IsNull(col010, ''),
				IsNull(col011, ''),
				IsNull(col012, ''),
				IsNull(col013, ''),
				IsNull(col014, ''),
				IsNull(col015, ''),
				IsNull(col016, ''),
				IsNull(col017, ''),
				IsNull(col018, ''),
				IsNull(col019, ''),
				IsNull(col020, '')
			from x12_parse_temp
			where x12_parse_temp_uid = @x12_interchange_uid
			order by x12_parse_temp_id

	OPEN curX12Defaults
	FETCH NEXT FROM curX12Defaults INTO	@col001,
						@col002,
						@col003,
						@col004,
						@col005,
						@col006,
						@col007,
						@col008,
						@col009,
						@col010,
						@col011,
						@col012,
						@col013,
						@col014,
						@col015,
						@col016,
						@col017,
						@col018,
						@col019,
						@col020

	WHILE (@@fetch_status <> -1)
	BEGIN
		select	@ptrVal = TEXTPTR(filedata),
				@contentLen = DATALENGTH(filedata)
		from x12_document where x12_document_id = @x12_document_id

		-- hasLastElement is used to specify whether the last element of the X12 line has been found.
		set @hasLastElement = 0
		-- Initialize the strFileLine variable with the segment delimiter
		set @strFileLine = @segment_separator
		
		if (Len(LTrim(RTrim(@col020))) > 0 OR @hasLastElement = 1)
		begin
			set @strFileLine = @element_separator + @col020 + @strFileLine
			set @hasLastElement = 1
		end
		if (Len(LTrim(RTrim(@col019))) > 0 OR @hasLastElement = 1)
		begin
			set @strFileLine = @element_separator + @col019 + @strFileLine
			set @hasLastElement = 1
		end
		if (Len(LTrim(RTrim(@col018))) > 0 OR @hasLastElement = 1)
		begin
			set @strFileLine = @element_separator + @col018 + @strFileLine
			set @hasLastElement = 1
		end
		if (Len(LTrim(RTrim(@col017))) > 0 OR @hasLastElement = 1)
		begin
			set @strFileLine = @element_separator + @col017 + @strFileLine
			set @hasLastElement = 1
		end
		if (Len(LTrim(RTrim(@col016))) > 0 OR @hasLastElement = 1)
		begin
			set @strFileLine = @element_separator + @col016 + @strFileLine
			set @hasLastElement = 1
		end
		if (Len(LTrim(RTrim(@col015))) > 0 OR @hasLastElement = 1)
		begin
			set @strFileLine = @element_separator + @col015 + @strFileLine
			set @hasLastElement = 1
		end
		if (Len(LTrim(RTrim(@col014))) > 0 OR @hasLastElement = 1)
		begin
			set @strFileLine = @element_separator + @col014 + @strFileLine
			set @hasLastElement = 1
		end
		if (Len(LTrim(RTrim(@col013))) > 0 OR @hasLastElement = 1)
		begin
			set @strFileLine = @element_separator + @col013 + @strFileLine
			set @hasLastElement = 1
		end
		if (Len(LTrim(RTrim(@col012))) > 0 OR @hasLastElement = 1)
		begin
			set @strFileLine = @element_separator + @col012 + @strFileLine
			set @hasLastElement = 1
		end
		if (Len(LTrim(RTrim(@col011))) > 0 OR @hasLastElement = 1)
		begin
			set @strFileLine = @element_separator + @col011 + @strFileLine
			set @hasLastElement = 1
		end
		if (Len(LTrim(RTrim(@col010))) > 0 OR @hasLastElement = 1)
		begin
			set @strFileLine = @element_separator + @col010 + @strFileLine
			set @hasLastElement = 1
		end
		if (Len(LTrim(RTrim(@col009))) > 0 OR @hasLastElement = 1)
		begin
			set @strFileLine = @element_separator + @col009 + @strFileLine
			set @hasLastElement = 1
		end
		if (Len(LTrim(RTrim(@col008))) > 0 OR @hasLastElement = 1)
		begin
			set @strFileLine = @element_separator + @col008 + @strFileLine
			set @hasLastElement = 1
		end
		if (Len(LTrim(RTrim(@col007))) > 0 OR @hasLastElement = 1)
		begin
			set @strFileLine = @element_separator + @col007 + @strFileLine
			set @hasLastElement = 1
		end
		if (Len(LTrim(RTrim(@col006))) > 0 OR @hasLastElement = 1)
		begin
			set @strFileLine = @element_separator + @col006 + @strFileLine
			set @hasLastElement = 1
		end
		if (Len(LTrim(RTrim(@col005))) > 0 OR @hasLastElement = 1)
		begin
			set @strFileLine = @element_separator + @col005 + @strFileLine
			set @hasLastElement = 1
		end
		if (Len(LTrim(RTrim(@col004))) > 0 OR @hasLastElement = 1)
		begin
			set @strFileLine = @element_separator + @col004 + @strFileLine
			set @hasLastElement = 1
		end
		if (Len(LTrim(RTrim(@col003))) > 0 OR @hasLastElement = 1)
		begin
			set @strFileLine = @element_separator + @col003 + @strFileLine
			set @hasLastElement = 1
		end
		if (Len(LTrim(RTrim(@col002))) > 0 OR @hasLastElement = 1)
		begin
			set @strFileLine = @element_separator + @col002 + @strFileLine
			set @hasLastElement = 1
		end
		if (Len(LTrim(RTrim(@col001))) > 0 OR @hasLastElement = 1)
		begin
			set @strFileLine = @col001 + @strFileLine
			set @hasLastElement = 1
		end

		UPDATETEXT x12_document.filedata @ptrVal @contentLen 0 @strFileLine

		FETCH NEXT FROM curX12Defaults INTO	@col001,
							@col002,
							@col003,
							@col004,
							@col005,
							@col006,
							@col007,
							@col008,
							@col009,
							@col010,
							@col011,
							@col012,
							@col013,
							@col014,
							@col015,
							@col016,
							@col017,
							@col018,
							@col019,
							@col020
	END
	CLOSE curX12Defaults
	DEALLOCATE curX12Defaults

	update x12_document set processed = 1 where x12_document_id = @x12_document_id

	select	@ptrval = TEXTPTR(filedata),
			@contentLen = DATALENGTH(filedata)
	from x12_document
	where x12_document_id = @x12_document_id

--	READTEXT x12_document.filedata @ptrVal 0 @contentLen
