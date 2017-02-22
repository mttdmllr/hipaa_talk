CREATE PROCEDURE [dbo].[up_x12_835_complete]
    (
      @x12_interchange_id INT,
      @x12_functional_group_id INT = NULL,
      @x12_transaction_id INT = NULL
						
    )
AS /*********************
-- START DOC --
PROCEDURE: up_x12_835_complete
	Parameter:		[IN] @x12_interchange_id	INT - REQUIRED
				[IN] @x12_functional_group_id	INT - OPTIONAL
				[IN] @x12_transaction_id	INT - OPTIONAL
	Type:			VALIDATION
	Description:		This stored procedure checks the 835 data for errors and adds claim/voucher totals where they're missing.
	Example:		EXEC up_x12_835_complete	@x12_interchange_id = 1,
								@x12_functional_group_id = 1,
								@x12_transaction_id = 1
	Usage:			Run this stored procedure after you've inserted a bunch or one 835 transaction to check your work.
	Functions Used:		NONE.
				
-- END DOC --
*********************/
    DECLARE @cur_x12_functional_group_id INT
    DECLARE @cur_x12_transaction_id INT
    DECLARE @cur_L2100_clp07_payer_claim_control_no VARCHAR(80)
    DECLARE @message_text VARCHAR(512)
    DECLARE @error BIT
    DECLARE @x12_interchange_uid UNIQUEIDENTIFIER
    DECLARE @isa13_control_no VARCHAR(9)
    DECLARE @gs06_group_control_no VARCHAR(9)
    DECLARE @st02_transaction_control_no VARCHAR(9)
    SET @error = 0
-- SET UP ALL THE DEFAULTS ON THIS INTERCHANGE
    EXEC up_x12_interchange_set_defaults @x12_interchange_id
-- BEGIN: OUTER CURSOR OF ALL THE FUNCTIONAL GROUPS
    DECLARE cur835GS SCROLL CURSOR
        FOR SELECT  x12_functional_group_id
            FROM    x12_functional_group
            WHERE   x12_interchange_id = @x12_interchange_id
                    AND ( x12_functional_group_id = @x12_functional_group_id
                          OR @x12_functional_group_id IS NULL
                        )
    OPEN cur835GS
    FETCH NEXT FROM cur835GS INTO @cur_x12_functional_group_id
    WHILE ( @@fetch_status <> -1 )
        BEGIN
	-- BEGIN: INNER CURSOR OF ALL THE TRANSACTIONS
            DECLARE cur835ST SCROLL CURSOR
                FOR SELECT  x12_transaction_id
                    FROM    x12_transaction
                    WHERE   x12_functional_group_id = @cur_x12_functional_group_id
                            AND ( x12_transaction_id = @x12_transaction_id
                                  OR @x12_transaction_id IS NULL
                                )
	
            OPEN cur835ST
	
            FETCH NEXT FROM cur835ST INTO @cur_x12_transaction_id
	
            WHILE ( @@fetch_status <> -1 )
                BEGIN
		-- Get the UID for this interchange
                    SELECT  @x12_interchange_uid = x12_interchange_uid,
                            @isa13_control_no = isa13_control_no,
                            @gs06_group_control_no = gs06_group_control_no,
                            @st02_transaction_control_no = st02_transaction_control_no
                    FROM    vw_x12_transaction
                    WHERE   x12_transaction_id = @cur_x12_transaction_id
		-- SUM the provider payment amount for this transaction and update the bpr02_total_prov_pmt_amt field with the value.
                    UPDATE  x12_835_claim_payment_advice
                    SET     bpr02_total_prov_pmt_amt = ( SELECT SUM(L2110_svc03_provider_pmt_amt)
                                                         FROM   x12_835_claim_payment_advice
                                                         WHERE  x12_transaction_id = @cur_x12_transaction_id
                                                                AND L2110_svc03_provider_pmt_amt IS NOT NULL
                                                       )
                    WHERE   x12_transaction_id = @cur_x12_transaction_id
                            AND ( bpr02_total_prov_pmt_amt = 0
                                  OR bpr02_total_prov_pmt_amt IS NULL
                                )
		-- BEGIN: INNER-INNER CURSOR OF ALL THE CLAIMS
                    DECLARE cur835CLP SCROLL CURSOR
                        FOR SELECT DISTINCT
                                    L2100_clp07_payer_claim_control_no
                            FROM    x12_835_claim_payment_advice
                            WHERE   x12_transaction_id = @cur_x12_transaction_id
		
                    OPEN cur835CLP
		
                    FETCH NEXT FROM cur835CLP INTO @cur_L2100_clp07_payer_claim_control_no
		
                    WHILE ( @@fetch_status <> -1 )
                        BEGIN
                            SET @error = 0
			-- SUM the TOTAL CLAIM CHARGE AMOUNT for this transaction and update the L2100_clp03_total_claim_chg_amt field with the value.
                            UPDATE  x12_835_claim_payment_advice
                            SET     L2100_clp03_total_claim_chg_amt = ( SELECT  SUM(L2110_svc02_charge_amt)
                                                                        FROM    x12_835_claim_payment_advice
                                                                        WHERE   x12_transaction_id = @cur_x12_transaction_id
                                                                                AND L2110_svc02_charge_amt IS NOT NULL
                                                                                AND L2100_clp07_payer_claim_control_no = @cur_L2100_clp07_payer_claim_control_no
                                                                      )
                            WHERE   L2100_clp07_payer_claim_control_no = @cur_L2100_clp07_payer_claim_control_no
                                    AND x12_transaction_id = @cur_x12_transaction_id
                                    AND ( L2100_clp03_total_claim_chg_amt = 0
                                          OR L2100_clp03_total_claim_chg_amt IS NULL
                                        )
			-- SUM the TOTAL CLAIM PAID amount for this transaction and update the L2100_clp04_claim_pmt_amt field with the value.
                            UPDATE  x12_835_claim_payment_advice
                            SET     L2100_clp04_claim_pmt_amt = ISNULL(( SELECT SUM(L2110_svc03_provider_pmt_amt)
                                                                         FROM   x12_835_claim_payment_advice
                                                                         WHERE  x12_transaction_id = @cur_x12_transaction_id
                                                                                AND L2110_svc03_provider_pmt_amt IS NOT NULL
                                                                                AND L2100_clp07_payer_claim_control_no = @cur_L2100_clp07_payer_claim_control_no
                                                                       ), 0)
                            WHERE   L2100_clp07_payer_claim_control_no = @cur_L2100_clp07_payer_claim_control_no
                                    AND x12_transaction_id = @cur_x12_transaction_id
                                    AND ( L2100_clp04_claim_pmt_amt IS NULL )
			-- SUM the TOTAL CLAIM PATIENT RESPONSIBILITY AMOUNT for this transaction and update L2100_clp05_pt_resp_amt
                            UPDATE  x12_835_claim_payment_advice
                            SET     L2100_clp05_pt_resp_amt = ISNULL(( SELECT   SUM(ISNULL(L2110_3_cas03_adj_amt, 0)) + SUM(ISNULL(L2110_3_cas06_adj_amt, 0)) + SUM(ISNULL(L2110_3_cas09_adj_amt, 0)) + SUM(ISNULL(L2110_3_cas12_adj_amt, 0)) + SUM(ISNULL(L2110_3_cas15_adj_amt, 0)) + SUM(ISNULL(L2110_3_cas18_adj_amt, 0))
                                                                       FROM     x12_835_claim_payment_advice
                                                                       WHERE    x12_transaction_id = @cur_x12_transaction_id
																--AND L2110_svc03_provider_pmt_amt IS NOT NULL
                                                                                AND L2100_clp07_payer_claim_control_no = @cur_L2100_clp07_payer_claim_control_no
                                                                     ), 0)
                            WHERE   L2100_clp07_payer_claim_control_no = @cur_L2100_clp07_payer_claim_control_no
                                    AND x12_transaction_id = @cur_x12_transaction_id
                                    AND ( L2100_clp05_pt_resp_amt IS NULL )
			
			
			-- ERROR CHECK: Check to see if any procedure lines exist on THE CURRENT CLAIM where the charges don't equal the service paid amount + adjustments
                            IF EXISTS ( SELECT  x12_835_claim_payment_advice_id
                                        FROM    x12_835_claim_payment_advice
                                        WHERE   x12_transaction_id = @cur_x12_transaction_id
                                                AND L2110_svc02_charge_amt <> ( L2110_svc03_provider_pmt_amt + ISNULL(L2110_1_cas03_adj_amt, 0) + ISNULL(L2110_1_cas06_adj_amt, 0) + ISNULL(L2110_1_cas09_adj_amt, 0) + ISNULL(L2110_1_cas12_adj_amt, 0) + ISNULL(L2110_1_cas15_adj_amt, 0) + ISNULL(L2110_1_cas18_adj_amt, 0) + ISNULL(L2110_2_cas03_adj_amt, 0) + ISNULL(L2110_2_cas06_adj_amt, 0) + ISNULL(L2110_2_cas09_adj_amt, 0) + ISNULL(L2110_3_cas03_adj_amt, 0) + ISNULL(L2110_3_cas06_adj_amt, 0) + ISNULL(L2110_3_cas09_adj_amt, 0) + ISNULL(L2110_3_cas12_adj_amt, 0) + ISNULL(L2110_3_cas15_adj_amt, 0) + ISNULL(L2110_3_cas18_adj_amt, 0) )
                                                AND L2100_clp07_payer_claim_control_no = @cur_L2100_clp07_payer_claim_control_no ) 
                                BEGIN
                                    SET @error = 1
                                    SET @message_text = 'Payer Claim ID ['
                                        + LTRIM(RTRIM(CAST(@cur_L2100_clp07_payer_claim_control_no AS VARCHAR(80))))
                                        + '] contains line charges that do not equal the sum of the provider payment plus adjustments.'
                                    EXEC up_x12_interchange_message @x12_interchange_uid = @x12_interchange_uid,
                                        @isa13_control_no = @isa13_control_no,
                                        @gs06_group_control_no = @gs06_group_control_no,
                                        @st02_transaction_control_no = @st02_transaction_control_no,
                                        @loop_id = '2110', @segment_id = 'SVC',
                                        @element_no = 2, @element_value = NULL,
                                        @message_code = NULL,
                                        @message_text = @message_text
                                END
			-- ERROR CHECK: Check to see if any procedure lines exist on THE CURRENT CLAIM where adjustments exist with no reason code.
                            IF EXISTS ( SELECT  x12_835_claim_payment_advice_id
                                        FROM    x12_835_claim_payment_advice
                                        WHERE   x12_transaction_id = @cur_x12_transaction_id
                                                AND L2100_clp07_payer_claim_control_no = @cur_L2100_clp07_payer_claim_control_no
                                                AND ( ( L2110_1_cas02_adj_reason_code IS NULL
                                                        AND L2110_1_cas03_adj_amt IS NOT NULL
                                                      )
                                                      OR ( L2110_1_cas05_adj_reason_code IS NULL
                                                           AND L2110_1_cas06_adj_amt IS NOT NULL
                                                         )
                                                      OR ( L2110_1_cas08_adj_reason_code IS NULL
                                                           AND L2110_1_cas09_adj_amt IS NOT NULL
                                                         )
                                                      OR ( L2110_1_cas11_adj_reason_code IS NULL
                                                           AND L2110_1_cas12_adj_amt IS NOT NULL
                                                         )
                                                      OR ( L2110_1_cas14_adj_reason_code IS NULL
                                                           AND L2110_1_cas15_adj_amt IS NOT NULL
                                                         )
                                                      OR ( L2110_1_cas17_adj_reason_code IS NULL
                                                           AND L2110_1_cas18_adj_amt IS NOT NULL
                                                         )
                                                      OR ( L2110_2_cas02_adj_reason_code IS NULL
                                                           AND L2110_2_cas03_adj_amt IS NOT NULL
                                                         )
                                                      OR ( L2110_2_cas05_adj_reason_code IS NULL
                                                           AND L2110_2_cas06_adj_amt IS NOT NULL
                                                         )
                                                      OR ( L2110_2_cas08_adj_reason_code IS NULL
                                                           AND L2110_2_cas09_adj_amt IS NOT NULL
                                                         )
                                                      OR ( L2110_3_cas02_adj_reason_code IS NULL
                                                           AND L2110_3_cas03_adj_amt IS NOT NULL
                                                         )
                                                      OR ( L2110_3_cas05_adj_reason_code IS NULL
                                                           AND L2110_3_cas06_adj_amt IS NOT NULL
                                                         )
                                                      OR ( L2110_3_cas08_adj_reason_code IS NULL
                                                           AND L2110_3_cas09_adj_amt IS NOT NULL
                                                         )
                                                      OR ( L2110_3_cas11_adj_reason_code IS NULL
                                                           AND L2110_3_cas12_adj_amt IS NOT NULL
                                                         )
                                                      OR ( L2110_3_cas14_adj_reason_code IS NULL
                                                           AND L2110_3_cas15_adj_amt IS NOT NULL
                                                         )
                                                      OR ( L2110_3_cas17_adj_reason_code IS NULL
                                                           AND L2110_3_cas18_adj_amt IS NOT NULL
                                                         )
                                                    ) ) 
                                BEGIN
                                    SET @error = 1
                                    SET @message_text = 'Payer Claim ID ['
                                        + LTRIM(RTRIM(CAST(@cur_L2100_clp07_payer_claim_control_no AS VARCHAR(80))))
                                        + '] contains an adjustment with no adjustment reason code.'
                                    EXEC up_x12_interchange_message @x12_interchange_uid = @x12_interchange_uid,
                                        @isa13_control_no = @isa13_control_no,
                                        @gs06_group_control_no = @gs06_group_control_no,
                                        @st02_transaction_control_no = @st02_transaction_control_no,
                                        @loop_id = '2110', @segment_id = 'CAS',
                                        @element_no = 3, @element_value = NULL,
                                        @message_code = NULL,
                                        @message_text = @message_text
                                END
                            IF ( @error = 1 ) 
                                BEGIN
					-- Flag the claims with totals that don't match up with the error bit
                                    UPDATE  x12_835_claim_payment_advice
                                    SET     error = 1
                                    WHERE   x12_transaction_id = @cur_x12_transaction_id
                                            AND L2100_clp07_payer_claim_control_no = @cur_L2100_clp07_payer_claim_control_no
                                END
                            FETCH NEXT FROM cur835CLP INTO @cur_L2100_clp07_payer_claim_control_no
                        END
                    CLOSE cur835CLP
                    DEALLOCATE cur835CLP
		-- END: INNER-INNER CURSOR OF ALL THE CLAIMS
		-- If any error exists on any record in the transaction, flag the transaction, functional_group and interchange with an error
                    IF EXISTS ( SELECT  x12_835_claim_payment_advice_id
                                FROM    x12_835_claim_payment_advice
                                WHERE   x12_transaction_id = @cur_x12_transaction_id
                                        AND error = 1 ) 
                        BEGIN
			-- Flag the transaction
                            UPDATE  x12_transaction
                            SET     error = 1
                            WHERE   x12_transaction_id = @cur_x12_transaction_id
			-- Flag the functional group
                            UPDATE  x12_functional_group
                            SET     error = 1
                            WHERE   x12_functional_group_id = @cur_x12_functional_group_id
			-- Flag the interchange
                            UPDATE  x12_interchange
                            SET     error = 1
                            WHERE   x12_interchange_id = @x12_interchange_id
                        END
                    FETCH NEXT FROM cur835ST INTO @cur_x12_transaction_id
                END
            CLOSE cur835ST
            DEALLOCATE cur835ST
	-- END: INNER CURSOR OF ALL THE TRANSACTIONS
            FETCH NEXT FROM cur835GS INTO @cur_x12_functional_group_id
        END
    CLOSE cur835GS
    DEALLOCATE cur835GS

-- We've generated the interchange, set the status to "export-ready".
    EXEC up_x12_interchange_set_status @x12_interchange_id = @x12_interchange_id,
        @x12_interchange_status_ud = 'EXPORT-READY'

-- END: OUTER CURSOR OF ALL THE FUNCTIONAL GROUPS


