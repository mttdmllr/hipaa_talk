



CREATE Procedure [dbo].[up_x12_qty_export] (
					@x12_interchange_uid uniqueidentifier,
					@qty01_quantity_qual_code char(2) = null,
					@qty02_quantity varchar(15) = null,
					@qty03_quantity_unit varchar(2) = null
				   )
As

declare @success int
set @success = 0

	-- The QTY Unit of Measurement is not always required, but if it is supplied, trim and convert it to upper-case.
	if (@qty03_quantity_unit IS NOT NULL)
	begin
		set @qty03_quantity_unit = UPPER(LTRIM(RTRIM(@qty03_quantity_unit)))
	end

	if (@qty01_quantity_qual_code IS NOT NULL AND @qty02_quantity IS NOT NULL)
	begin
		INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004)
			Values (	CAST(@x12_interchange_uid as varchar(36)),  'QTY',
					UPPER(LTRIM(RTRIM(@qty01_quantity_qual_code))),
					UPPER(LTRIM(RTRIM(@qty02_quantity))),
					@qty03_quantity_unit
				) 
		set @success = 1
	end

return @success
