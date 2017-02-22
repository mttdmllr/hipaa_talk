CREATE DEFAULT [dbo].[df_SYS_UID]
    AS NEWID();


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_organization_default].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_organization].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_organization_pickup_location].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_organization_drop_location].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_organization].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_organization_default].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_codeset].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_organization_drop_location].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_organization_pickup_location].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_identifier].[x12_identifier_uid]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_document].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_identifier].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_location].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_location].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_identifier].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_document].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_837_claim_dental].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_837_claim_professional].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_835_claim_payment_advice].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_820_remittance_advice].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_834_benefit_enrollment].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_837_claim_institutional].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_functional_group].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_ta1_interchange_ack].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_ta1_interchange_ack].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_841_code_list].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_codeset].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_organization_default].[x12_organization_default_uid]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_organization].[x12_organization_uid]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_837_claim_institutional].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_document].[x12_document_uid]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_837_claim_professional].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_834_benefit_enrollment].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_835_claim_payment_advice].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_820_remittance_advice].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_837_claim_dental].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_organization_archive_location].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_interchange_status].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_transaction_schema].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_organization_archive_location].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_270_eligibility_request].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_277_claim_ack].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_interchange_status].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_functional_group].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_transaction_schema].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_interchange].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_interchange].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_841_code_list].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_270_eligibility_request].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_277_claim_ack].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_997_functional_ack].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_interchange_message].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_997_functional_ack].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_interchange_message].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_transaction].[modified_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_270_eligibility_response].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_transaction].[created_by]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_SYS_UID]', @objname = N'[dbo].[x12_270_eligibility_response].[modified_by]';

