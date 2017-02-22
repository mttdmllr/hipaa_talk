CREATE PROCEDURE [dbo].[up_x12_834_archive] (	@x12_interchange_id int,
						@x12_functional_group_id int = null,
						@x12_transaction_id int = null,
						@x12_834_benefit_enrollment_id int = null  )
AS
-- Set the processed bit to 0 for either the whole transaction or just the individual record
update x12_834_benefit_enrollment set processed = 1
	where	( x12_834_benefit_enrollment_id = @x12_834_benefit_enrollment_id OR @x12_834_benefit_enrollment_id IS NULL ) AND
		( x12_transaction_id IN (SELECT DISTINCT x12_transaction_id FROM vw_x12_transaction
					WHERE	(x12_transaction_id = @x12_transaction_id OR @x12_transaction_id IS NULL) AND
							(x12_functional_group_id = @x12_functional_group_id OR @x12_functional_group_id IS NULL) AND
							(x12_interchange_id = @x12_interchange_id)
					)
		)
-- Set the processed bit to 0 for the transaction(s)
update x12_transaction set processed = 1
	where	x12_transaction_id IN (SELECT DISTINCT x12_transaction_id FROM vw_x12_transaction
					WHERE	(x12_transaction_id = @x12_transaction_id OR @x12_transaction_id IS NULL) AND
							(x12_functional_group_id = @x12_functional_group_id OR @x12_functional_group_id IS NULL) AND
							(x12_interchange_id = @x12_interchange_id)
					)
-- Set the processed bit to 0 for the function group(s)
update x12_functional_group set processed = 1
	where	x12_functional_group_id IN (SELECT DISTINCT x12_functional_group_id FROM vw_x12_transaction
						WHERE	(x12_transaction_id = @x12_transaction_id OR @x12_transaction_id IS NULL) AND
								(x12_functional_group_id = @x12_functional_group_id OR @x12_functional_group_id IS NULL) AND
								(x12_interchange_id = @x12_interchange_id)
					)
-- Set the processed bit to 0 for the interchange
update x12_interchange set processed = 1 where x12_interchange_id = @x12_interchange_id
