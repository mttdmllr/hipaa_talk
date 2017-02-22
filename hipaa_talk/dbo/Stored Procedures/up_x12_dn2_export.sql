

CREATE Procedure [dbo].[up_x12_dn2_export] (	@x12_interchange_uid uniqueidentifier,
					@dn201_tooth_number varchar(30),
					@dn202_tooth_status_code varchar(2)
				   )
As

	INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003)
		Values	(	@x12_interchange_uid,
				'DN2',
				UPPER(LTrim(RTrim(@dn201_tooth_number))),
				UPPER(LTrim(RTrim(@dn202_tooth_status_code)))
			)
