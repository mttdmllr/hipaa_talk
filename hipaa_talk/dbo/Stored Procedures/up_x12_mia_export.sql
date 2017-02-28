
CREATE Procedure [dbo].[up_x12_mia_export] (
					@x12_interchange_uid uniqueidentifier,					
					@mia01_covered_days_or_visits_count int = null,
					@mia02_pps_operating_outlier_amt money = null,
					@mia03_lifetime_psy_days_count int = null,
					@mia04_claim_drg_amt money = null,
					@mia05_remark_code varchar(30) = null,
					@mia06_disp_share_amt money = null,
					@mia07_claim_MSP_pass_through_amt money = null,
					@mia08_claim_PPS_capital_amt money = null,
					@mia09_PPS_capital_FSP_drg_amt money = null,
					@mia10_PPS_capital_HSP_drg_amt money = null,
					@mia11_PPS_capital_DSH_drg_amt money = null,
					@mia12_old_capital_amt money = null,
					@mia13_PPS_capital_IME_amt money = null,
					@mia14_PPS_operating_hosp_spec_DRG_amt money = null,
					@mia15_cost_rpt_day_count int = null,
					@mia16_PPS_operating_fed_spec_DRG_amt money = null,
					@mia17_claim_PPS_capital_outlier_amt money = null,
					@mia18_claim_indirect_teaching_amt money = null,
					@mia19_nonpayable_prof_component_amt money = null,
					@mia20_remark_code varchar(30) = null,
					@mia21_remark_code varchar(30) = null,
					@mia22_remark_code varchar(30) = null,
					@mia23_remark_code varchar(30) = null,
					@mia24_PPS_capital_exception_amt money = null)
As
 
declare @success int
set @success = 0

	if (@mia01_covered_days_or_visits_count IS NOT NULL)
	begin
		INSERT INTO x12_parse_temp(
					x12_parse_temp_uid,
					col001,	col002,	col003,	col004,	col005,
					col006,	col007,	col008,	col009,	col010,
					col011,	col012,	col013,	col014,	col015,
					col016,	col017,	col018,	col019,	col020,
					col021,	col022,	col023,	col024,col025)
		values(		CAST(@x12_interchange_uid as varchar(36)),
					'MIA',
					CAST(@mia01_covered_days_or_visits_count as varchar(255)),
					case	when @mia02_pps_operating_outlier_amt = 0 then '0'
							else dbo.fn_trim_leading_zero(cast (@mia02_pps_operating_outlier_amt as varchar(255)))
					end, 
					CAST(@mia03_lifetime_psy_days_count as varchar(255)),
					case	when @mia04_claim_drg_amt = 0 then '0'
							else dbo.fn_trim_leading_zero(cast (@mia04_claim_drg_amt as varchar(255)))
					end, 
					CAST(@mia05_remark_code as varchar(255)),
					case	when @mia06_disp_share_amt = 0 then '0'
							else dbo.fn_trim_leading_zero(cast (@mia06_disp_share_amt as varchar(255)))
					end, 
					case	when @mia07_claim_MSP_pass_through_amt = 0 then '0'
							else dbo.fn_trim_leading_zero(cast (@mia07_claim_MSP_pass_through_amt as varchar(255)))
					end, 
					case	when @mia08_claim_PPS_capital_amt = 0 then '0'
							else dbo.fn_trim_leading_zero(cast (@mia08_claim_PPS_capital_amt as varchar(255)))
					end, 
					case	when @mia09_PPS_capital_FSP_drg_amt = 0 then '0'
							else dbo.fn_trim_leading_zero(cast (@mia09_PPS_capital_FSP_drg_amt as varchar(255)))
					end, 
					case	when @mia10_PPS_capital_HSP_drg_amt = 0 then '0'
							else dbo.fn_trim_leading_zero(cast (@mia10_PPS_capital_HSP_drg_amt as varchar(255)))
					end, 
					case	when @mia11_PPS_capital_DSH_drg_amt = 0 then '0'
							else dbo.fn_trim_leading_zero(cast (@mia11_PPS_capital_DSH_drg_amt as varchar(255)))
					end, 
					case	when @mia12_old_capital_amt = 0 then '0'
							else dbo.fn_trim_leading_zero(cast (@mia12_old_capital_amt as varchar(255)))
					end, 
					case	when @mia13_PPS_capital_IME_amt = 0 then '0'
							else dbo.fn_trim_leading_zero(cast (@mia13_PPS_capital_IME_amt as varchar(255)))
					end, 
					case	when @mia14_PPS_operating_hosp_spec_DRG_amt = 0 then '0'
							else dbo.fn_trim_leading_zero(cast (@mia14_PPS_operating_hosp_spec_DRG_amt as varchar(255)))
					end, 
					CAST(@mia15_cost_rpt_day_count as varchar(255)),
					case	when @mia16_PPS_operating_fed_spec_DRG_amt = 0 then '0'
							else dbo.fn_trim_leading_zero(cast (@mia16_PPS_operating_fed_spec_DRG_amt as varchar(255)))
					end, 
					case	when @mia17_claim_PPS_capital_outlier_amt = 0 then '0'
							else dbo.fn_trim_leading_zero(cast (@mia17_claim_PPS_capital_outlier_amt as varchar(255)))
					end, 
					case	when @mia18_claim_indirect_teaching_amt = 0 then '0'
							else dbo.fn_trim_leading_zero(cast (@mia18_claim_indirect_teaching_amt as varchar(255)))
					end, 
					case	when @mia19_nonpayable_prof_component_amt = 0 then '0'
							else dbo.fn_trim_leading_zero(cast (@mia19_nonpayable_prof_component_amt as varchar(255)))
					end, 
					CAST(@mia20_remark_code as varchar(255)),
					CAST(@mia21_remark_code as varchar(255)),
					CAST(@mia22_remark_code as varchar(255)),
					CAST(@mia23_remark_code as varchar(255)),
					case	when @mia24_PPS_capital_exception_amt = 0 then '0'
							else dbo.fn_trim_leading_zero(cast (@mia24_PPS_capital_exception_amt as varchar(255)))
					end
				)
		set @success = 1
	end

return @success
