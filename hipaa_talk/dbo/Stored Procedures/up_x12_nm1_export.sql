
--if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[up_x12_nm1_export]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
--drop procedure [dbo].[up_x12_nm1_export]
--GO

CREATE Procedure [dbo].[up_x12_nm1_export] (
					@x12_interchange_uid uniqueidentifier,
					@nm101_entity_id_code varchar(3) = null,
					@nm102_entity_type_qual char(1) = null,
					@nm103_last_name varchar(35) = null,
					@nm104_first_name varchar(25) = null,
					@nm105_middle_name varchar(25) = null,
					@nm106_name_prefix varchar(10) = null,
					@nm107_name_suffix varchar(10) = null,
					@nm108_id_code_qual varchar(2) = null,
					@nm109_id_code varchar(80) = null
				   )
As

if (@nm102_entity_type_qual IS NULL)
BEGIN
	-- If the length of both the first and last name are greater than 0, it's a person.
	if (LEN(LTRIM(RTRIM(ISNULL(@nm104_first_name, '')))) > 0 AND LEN(LTRIM(RTRIM(ISNULL(@nm103_last_name, '')))) > 0)
	begin
		set @nm102_entity_type_qual = '1'
	END
	-- If the length of last name is greater than 0, and middle and first are emtpy, this is an organization.
	if (	LEN(LTRIM(RTRIM(ISNULL(@nm105_middle_name, '')))) = 0 AND
			LEN(LTRIM(RTRIM(ISNULL(@nm104_first_name, '')))) = 0 AND
			LEN(LTRIM(RTRIM(ISNULL(@nm103_last_name, '')))) > 0)
	begin
		set @nm102_entity_type_qual = '2'
	end
end

INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002, col003, col004, col005, col006, col007, col008, col009, col010)
	Values (	CAST(@x12_interchange_uid as varchar(36)),
			'NM1',
			UPPER(LTRIM(RTRIM(@nm101_entity_id_code))),
			UPPER(LTRIM(RTRIM(@nm102_entity_type_qual))),
			UPPER(LTRIM(RTRIM(@nm103_last_name))), 
			UPPER(LTRIM(RTRIM(@nm104_first_name))),
			UPPER(LTRIM(RTRIM(@nm105_middle_name))),
			UPPER(LTRIM(RTRIM(@nm106_name_prefix))),
			UPPER(LTRIM(RTRIM(@nm107_name_suffix))),
			UPPER(LTRIM(RTRIM(@nm108_id_code_qual))),
			UPPER(LTRIM(RTRIM(@nm109_id_code)))
		)

