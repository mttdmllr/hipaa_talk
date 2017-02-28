CREATE Procedure [dbo].[up_x12_cr1_export] (	@x12_interchange_uid uniqueidentifier,
					@cr101_measurement_code char(2) = null,
					@cr102_patient_weight varchar(10) = null,
					@cr103_amb_transport_code char(1) = null,
					@cr104_amb_transport_reason_code char(1) = null,
					@cr105_measurement_code char(2) = null,
					@cr106_transport_distance varchar(15) = null,
					@cr107_amb_origin_address varchar(55) = null,
					@cr108_amb_dest_address varchar(55) = null,
					@cr109_purpose_desc varchar(80) = null
				         )
As

	INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col010)
		Values (	CAST(@x12_interchange_uid as varchar(36)),
			'CR1',
			@cr101_measurement_code,
			@cr102_patient_weight,
			@cr103_amb_transport_code,
			@cr104_amb_transport_reason_code,
			@cr105_measurement_code,
			@cr106_transport_distance,
			@cr109_purpose_desc
			)

