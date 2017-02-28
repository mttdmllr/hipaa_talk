CREATE DEFAULT [dbo].[df_BIT_AS_0]
    AS 0;


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_organization_default].[use_if_source]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_organization_default].[use_if_dest]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_organization_default].[override_value]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_organization].[is_home_org]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_identifier].[outgoing_default]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_identifier].[incoming_default]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_document].[error]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_document].[processed]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_837_claim_institutional].[processed]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_837_claim_institutional].[error]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_837_claim_professional].[processed]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_837_claim_professional].[error]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_834_benefit_enrollment].[error]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_834_benefit_enrollment].[processed]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_835_claim_payment_advice].[processed]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_835_claim_payment_advice].[error]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_820_remittance_advice].[error]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_820_remittance_advice].[processed]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_functional_group].[error]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_functional_group].[processed]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_interchange].[incoming]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_interchange].[outgoing]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_interchange].[error]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_interchange].[processed]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_841_code_list].[error]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_841_code_list].[processed]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_270_eligibility_request].[error]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_270_eligibility_request].[processed]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_277_claim_ack].[error]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_277_claim_ack].[processed]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_997_functional_ack].[error]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_997_functional_ack].[processed]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_ta1_interchange_ack].[error]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_ta1_interchange_ack].[processed]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_transaction].[error]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_transaction].[processed]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_270_eligibility_response].[error]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_BIT_AS_0]', @objname = N'[dbo].[x12_270_eligibility_response].[processed]';

