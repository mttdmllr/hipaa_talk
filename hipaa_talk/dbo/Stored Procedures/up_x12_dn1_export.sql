

CREATE Procedure [dbo].[up_x12_dn1_export] (	@x12_interchange_uid uniqueidentifier,
					@dn101_orthodontic_treatment_months_count varchar(15),
					@dn102_orthodontic_treatment_months_remaining_count varchar(15),
					@dn103_question_response char(1)
				   )
As

	INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004)
		Values	(	@x12_interchange_uid,
				'DN1',
				UPPER(LTrim(RTrim(@dn101_orthodontic_treatment_months_count))),
				UPPER(LTrim(RTrim(@dn102_orthodontic_treatment_months_remaining_count))),
				UPPER(LTrim(RTrim(@dn103_question_response)))
			)
