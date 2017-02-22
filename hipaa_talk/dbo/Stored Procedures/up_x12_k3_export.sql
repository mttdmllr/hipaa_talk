CREATE Procedure [dbo].[up_x12_k3_export] (	@x12_interchange_uid uniqueidentifier,
					@fixed_format_info varchar(80) = null
				         )
As

	if (@fixed_format_info IS NOT NULL)
	begin
		INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002 )
			Values (	CAST(@x12_interchange_uid as varchar(36)),  'K3', @fixed_format_info ) 
	end

