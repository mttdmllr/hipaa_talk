CREATE Procedure [dbo].[up_x12_dtp_export] (
					@x12_interchange_uid uniqueidentifier,
					@dtp01_date_time_qual char(3) = null,
					@dtp02_date_time_format_qual char(3) = null,
					@dtp03_begin_date varchar(35) = null,
					@dtp03_end_date varchar(35) = null
				   )
As

declare @dtp03_date_time varchar(35)
set @dtp03_date_time = @dtp03_begin_date

	-- If a begin date exists and the date-time qualifier exists
	if (@dtp03_begin_date IS NOT NULL AND @dtp01_date_time_qual IS NOT NULL)
	begin

		-- If the begin date is a valid date, the end date is NULL, and the format qualifier is NULL, set it to a D8
		if ( IsDate(@dtp03_begin_date) = 1 AND @dtp02_date_time_format_qual IS NULL AND @dtp03_end_date IS NULL )
		begin
			set @dtp02_date_time_format_qual = 'D8'
		end
		-- else if the begin date is a valid date and the end date is a valid date
		else if ( IsDate(@dtp03_begin_date) = 1 AND IsDate(@dtp03_end_date) = 1)
		begin
			-- create the date range
			set @dtp03_date_time = dbo.fn_ListAppend(@dtp03_date_time, LTrim(RTrim(@dtp03_end_date)), '-')
			-- set the appropriate format qualifier for a date range
			set @dtp02_date_time_format_qual = 'RD8'
		end

		INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004)
			Values (	CAST(@x12_interchange_uid as varchar(36)),  'DTP',
					UPPER(LTRIM(RTRIM(@dtp01_date_time_qual))),
					UPPER(LTRIM(RTRIM(@dtp02_date_time_format_qual))),
					UPPER(LTRIM(RTRIM(@dtp03_date_time)))
				) 
	end

