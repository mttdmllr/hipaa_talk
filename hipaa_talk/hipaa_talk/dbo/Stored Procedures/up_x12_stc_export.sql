

CREATE Procedure [dbo].[up_x12_stc_export] (	@x12_interchange_uid uniqueidentifier,
					@stc01_claim_status_cat_code varchar(30) = null,
					@stc01_claim_status_code varchar(30) = null,
					@stc01_entity_id_code char(3) = null,
					@stc02_eff_date char(8) = null,
					@stc03_action_code char(2) = null,
					@stc04_total_submitted_charges money  = null,
					@stc05_claim_payment_amt money = null,
					@stc06_payment_date char(8) = null,
					@stc07_payment_method char(3) = null,
					@stc08_check_date char(8) = null,
					@stc09_check_number varchar(16) = null,
					@stc10_claim_status_cat_code varchar(30) = null,
					@stc10_claim_status_code varchar(30) = null,
					@stc10_entity_code char(3) = null,
					@stc11_claim_status_cat_code varchar(30) = null,
					@stc11_claim_status_code varchar(30) = null,
					@stc11_entity_code char(3) = null
				   )
As

declare @stc01 varchar(80)
declare @stc10 varchar(80)
declare @stc11 varchar(80)

declare @isa16_component_element_seperator char(1)

select @isa16_component_element_seperator = isa16_component_element_seperator
from x12_interchange
where x12_interchange_uid = @x12_interchange_uid

if (@isa16_component_element_seperator IS NULL OR @isa16_component_element_seperator = ' ')
begin
	set @isa16_component_element_seperator = ':'
end

set @stc01  = dbo.fn_ListAppend(@stc01, @stc01_claim_status_cat_code, @isa16_component_element_seperator)
set @stc01  = dbo.fn_ListAppend(@stc01, @stc01_claim_status_code, @isa16_component_element_seperator)
set @stc01  = dbo.fn_ListAppend(@stc01, @stc01_entity_id_code, @isa16_component_element_seperator)

set @stc10 = dbo.fn_ListAppend(@stc10, @stc10_claim_status_cat_code, @isa16_component_element_seperator)
set @stc10 = dbo.fn_ListAppend(@stc10, @stc10_claim_status_code, @isa16_component_element_seperator)
set @stc10 = dbo.fn_ListAppend(@stc10, @stc10_entity_code, @isa16_component_element_seperator)

set @stc11 = dbo.fn_ListAppend(@stc11, @stc11_claim_status_cat_code, @isa16_component_element_seperator)
set @stc11 = dbo.fn_ListAppend(@stc11, @stc11_claim_status_code, @isa16_component_element_seperator)
set @stc11 = dbo.fn_ListAppend(@stc11, @stc11_entity_code, @isa16_component_element_seperator)

	INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010, col011, col012)
		Values	(	CAST(@x12_interchange_uid as varchar(36)), 
				'STC',
				UPPER(LTRIM(RTRIM(@stc01))),
				UPPER(LTRIM(RTRIM(@stc02_eff_date))),
				UPPER(LTRIM(RTRIM(@stc03_action_code))),
				case	when @stc04_total_submitted_charges = 0 then '0'
						else dbo.fn_LTrimPat(cast (@stc04_total_submitted_charges as varchar(255)), '0')
					end, 
				case	when @stc05_claim_payment_amt = 0 then '0'
						else dbo.fn_LTrimPat(cast (@stc05_claim_payment_amt as varchar(255)), '0')
					end, 
				@stc06_payment_date,
				UPPER(LTRIM(RTRIM(@stc07_payment_method))),
				@stc08_check_date,
				UPPER(LTRIM(RTRIM(@stc09_check_number))),
				UPPER(LTRIM(RTRIM(@stc10))),
				UPPER(LTRIM(RTRIM(@stc11)))
			)
