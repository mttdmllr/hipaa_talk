




CREATE Procedure [dbo].[up_x12_amt_export] (
					@x12_interchange_uid uniqueidentifier,
					@amt01_amount_qual_code char(3) = null,
					@amt02_amount money = null
				   )
As

declare @success int
set @success = 0

	if (@amt01_amount_qual_code IS NOT NULL AND @amt02_amount IS NOT NULL)
	begin
		INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003)
			Values (	CAST(@x12_interchange_uid as varchar(36)),  'AMT',
					UPPER(LTRIM(RTRIM(@amt01_amount_qual_code))),
					case	when @amt02_amount = 0 then '0'
							else dbo.fn_trim_leading_zero(LTRIM(RTRIM(cast(@amt02_amount as varchar(255)))))
						end
				) 
		set @success = 1
	end

return @success

