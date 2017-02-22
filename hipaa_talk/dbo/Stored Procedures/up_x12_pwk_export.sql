CREATE Procedure [dbo].[up_x12_pwk_export] (	@x12_interchange_uid uniqueidentifier,
						@pwk01_attach_rpt_type_code char(2) = null,
						@pwk02_attach_trans_code char(2) = null,
						@pwk05_id_code_qual char(2) = null,
						@pwk06_attach_control_no varchar(80) = null,
						@pwk07_attach_desc varchar(80) = null
					   )
As

if (@pwk02_attach_trans_code IN ('BM', 'EL', 'EM', 'FX') )
begin
	set @pwk05_id_code_qual = 'AC'
end

	INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col006, col007, col008)
		Values (	CAST(@x12_interchange_uid as varchar(36)),  'PWK',
				UPPER(LTRIM(RTRIM(@pwk01_attach_rpt_type_code))),
				UPPER(LTRIM(RTRIM(@pwk02_attach_trans_code))),
				UPPER(LTRIM(RTRIM(@pwk05_id_code_qual))),
				UPPER(LTRIM(RTRIM(@pwk06_attach_control_no))),
				UPPER(LTRIM(RTRIM(@pwk07_attach_desc)))
			)

