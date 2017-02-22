CREATE Procedure [dbo].[up_x12_lx_export] (	@x12_interchange_uid uniqueidentifier,
					@lx01_assigned_num varchar(6) = null
				         )
As

	INSERT INTO x12_parse_temp (x12_parse_temp_uid, col001, col002 )
		Values (	CAST(@x12_interchange_uid as varchar(36)),  'LX', @lx01_assigned_num )

