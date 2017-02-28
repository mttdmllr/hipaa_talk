CREATE PROCEDURE [dbo].[up_x12_interchange_delete] (@x12_interchange_uid uniqueidentifier = null, @x12_interchange_id int = null)  
AS 

if (@x12_interchange_id IS NULL AND @x12_interchange_uid IS NOT NULL)
begin
	select @x12_interchange_id = x12_interchange_id
	from x12_interchange
	where (	x12_interchange_uid = @x12_interchange_uid OR
		x12_interchange_id = @x12_interchange_id )
end

delete from x12_parse_temp where x12_parse_temp_uid = (select x12_interchange_uid from x12_interchange where x12_interchange_id = @x12_interchange_id)

delete from x12_837_claim_professional where x12_transaction_id IN
		(select x12_transaction_id FROM x12_transaction
			where x12_functional_group_id IN (select x12_functional_group_id FROM x12_functional_group
								where x12_interchange_id = @x12_interchange_id
							)
		)
		
delete from x12_837_claim_dental where x12_transaction_id IN
		(select x12_transaction_id FROM x12_transaction
			where x12_functional_group_id IN (select x12_functional_group_id FROM x12_functional_group
								where x12_interchange_id = @x12_interchange_id
							)
		)

delete from x12_837_claim_institutional where x12_transaction_id IN
		(select x12_transaction_id FROM x12_transaction
			where x12_functional_group_id IN (select x12_functional_group_id FROM x12_functional_group
								where x12_interchange_id = @x12_interchange_id
							)
		)

delete from x12_834_benefit_enrollment where x12_transaction_id IN
		(select x12_transaction_id FROM x12_transaction
			where x12_functional_group_id IN (select x12_functional_group_id FROM x12_functional_group
								where x12_interchange_id = @x12_interchange_id
							)
		)

delete from x12_820_remittance_advice where x12_transaction_id IN
		(select x12_transaction_id FROM x12_transaction
			where x12_functional_group_id IN (select x12_functional_group_id FROM x12_functional_group
								where x12_interchange_id = @x12_interchange_id
							)
		)

delete from x12_835_claim_payment_advice where x12_transaction_id IN
		(select x12_transaction_id FROM x12_transaction
			where x12_functional_group_id IN (select x12_functional_group_id FROM x12_functional_group
								where x12_interchange_id = @x12_interchange_id
							)
		)

delete from x12_997_functional_ack where x12_transaction_id IN
		(select x12_transaction_id FROM x12_transaction
			where x12_functional_group_id IN (select x12_functional_group_id FROM x12_functional_group
								where x12_interchange_id = @x12_interchange_id
							)
		)

delete from x12_841_code_list where x12_transaction_id IN
		(select x12_transaction_id FROM x12_transaction
			where x12_functional_group_id IN (select x12_functional_group_id FROM x12_functional_group
								where x12_interchange_id = @x12_interchange_id
							)
		)

delete from x12_277_claim_ack where x12_transaction_id IN
		(select x12_transaction_id FROM x12_transaction
			where x12_functional_group_id IN (select x12_functional_group_id FROM x12_functional_group
								where x12_interchange_id = @x12_interchange_id
							)
		)

delete from x12_ta1_interchange_ack where x12_interchange_id = @x12_interchange_id

delete from x12_interchange_message where x12_interchange_uid = (select x12_interchange_uid FROM x12_interchange where x12_interchange_id = @x12_interchange_id)
delete from x12_transaction where x12_functional_group_id IN (select x12_functional_group_id FROM x12_functional_group where x12_interchange_id = @x12_interchange_id)
delete from x12_functional_group where x12_interchange_id = @x12_interchange_id
delete from x12_interchange where x12_interchange_id = @x12_interchange_id


