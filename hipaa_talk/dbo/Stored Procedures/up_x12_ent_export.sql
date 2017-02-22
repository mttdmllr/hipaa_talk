CREATE Procedure [dbo].[up_x12_ent_export] (
					@x12_interchange_uid uniqueidentifier,
					@ent01_assigned_num varchar(6) = null,
					@ent02_entity_id_code char(3) = null,
					@ent03_id_code_qual char(2) = null,
					@ent04_org_id_code varchar(80) = null
				   )
As
	-- For the ENT segment, all elements are required.
	if (	@ent01_assigned_num IS NOT NULL AND
			@ent02_entity_id_code IS NOT NULL AND
			@ent03_id_code_qual IS NOT NULL AND
			@ent04_org_id_code IS NOT NULL)
	begin
		INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003, col004, col005)
			Values (	CAST(@x12_interchange_uid as varchar(36)),
						'ENT',
						UPPER(LTRIM(RTRIM(@ent01_assigned_num))),
						UPPER(LTRIM(RTRIM(@ent02_entity_id_code))),
						UPPER(LTRIM(RTRIM(@ent03_id_code_qual))),
						UPPER(LTRIM(RTRIM(@ent04_org_id_code)))
				) 
	end

