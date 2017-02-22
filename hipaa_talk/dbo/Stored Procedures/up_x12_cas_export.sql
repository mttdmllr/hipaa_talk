



CREATE Procedure [dbo].[up_x12_cas_export] (
					@x12_interchange_uid uniqueidentifier,
					@cas01_adjustment_group_code char(2) = null,
					@cas02_adjustment_reason_code varchar(5) = null,
					@cas03_adjustment_amt money = null,
					@cas04_adjustment_qty varchar(15) = null,
					@cas05_adjustment_reason_code varchar(5) = null,
					@cas06_adjustment_amt money = null,
					@cas07_adjustment_qty varchar(15) = null,
					@cas08_adjustment_reason_code varchar(5) = null,
					@cas09_adjustment_amt money = null,
					@cas10_adjustment_qty varchar(15) = null,
					@cas11_adjustment_reason_code varchar(5) = null,
					@cas12_adjustment_amt money = null,
					@cas13_adjustment_qty varchar(15) = null,
					@cas14_adjustment_reason_code varchar(5) = null,
					@cas15_adjustment_amt money = null,
					@cas16_adjustment_qty varchar(15) = null,
					@cas17_adjustment_reason_code varchar(5) = null,
					@cas18_adjustment_amt money = null,
					@cas19_adjustment_qty varchar(15) = null
				   )
As

	INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010, col011, col012, col013, col014, col015, col016, col017, col018, col019, col020)
		Values (	CAST(@x12_interchange_uid as varchar(36)),  'CAS',
				UPPER(LTRIM(RTRIM(@cas01_adjustment_group_code))),
				UPPER(LTRIM(RTRIM(@cas02_adjustment_reason_code))),
				case	when @cas03_adjustment_amt = 0 then '0'
						else dbo.fn_trim_leading_zero(cast (@cas03_adjustment_amt as varchar(255)))
					end, 
				@cas04_adjustment_qty, 
				UPPER(LTRIM(RTRIM(@cas05_adjustment_reason_code))),
				case	when @cas06_adjustment_amt = 0 then '0'
						else dbo.fn_trim_leading_zero(cast (@cas06_adjustment_amt as varchar(255)))
					end, 
				@cas07_adjustment_qty, 
				UPPER(LTRIM(RTRIM(@cas08_adjustment_reason_code))),
				case	when @cas09_adjustment_amt = 0 then '0'
						else dbo.fn_trim_leading_zero(cast (@cas09_adjustment_amt as varchar(255)))
					end,
				@cas10_adjustment_qty,
				UPPER(LTRIM(RTRIM(@cas11_adjustment_reason_code))),
				case	when @cas12_adjustment_amt = 0 then '0'
						else dbo.fn_trim_leading_zero(cast (@cas12_adjustment_amt as varchar(255)))
					end,
				@cas13_adjustment_qty,
				UPPER(LTRIM(RTRIM(@cas14_adjustment_reason_code))),
				case	when @cas15_adjustment_amt = 0 then '0'
						else dbo.fn_trim_leading_zero(cast (@cas15_adjustment_amt as varchar(255)))
					end,
				@cas16_adjustment_qty,
				UPPER(LTRIM(RTRIM(@cas17_adjustment_reason_code))),
				case	when @cas18_adjustment_amt = 0 then '0'
						else dbo.fn_trim_leading_zero(cast (@cas18_adjustment_amt as varchar(255)))
					end,
				@cas19_adjustment_qty
			)

