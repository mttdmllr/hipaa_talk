
CREATE Procedure [dbo].[up_x12_lq_export] (
					@x12_interchange_uid uniqueidentifier,
					@lq01_id_qual char(3) = null,
					@lq02_remark_code varchar(30) = null
				   )
As

/*
If no value was passed for LQ01, use HE as the default.

Current options are:
	"HE"
	Claim Payment Remark Codes
	Code Source: 411-Remittance Remark Codes 
	"RX"
	National Council for Prescription Drug Programs Reject/Payment Codes
	Code Source: 530-National Council for Prescription Drug Programs Reject/Payment Codes 
*/

if (@lq01_id_qual IS NULL)
begin
	set @lq01_id_qual = 'HE'
end

	if (Len(LTrim(RTrim(IsNull(@lq02_remark_code, '')))) > 0 AND @lq01_id_qual IS NOT NULL)
	begin
		INSERT INTO x12_parse_temp(x12_parse_temp_uid, col001, col002, col003)
			Values (	CAST(@x12_interchange_uid as varchar(36)),  'LQ',
						UPPER(LTRIM(RTRIM(@lq01_id_qual))),
						UPPER(LTRIM(RTRIM(@lq02_remark_code)))
					)
	end

