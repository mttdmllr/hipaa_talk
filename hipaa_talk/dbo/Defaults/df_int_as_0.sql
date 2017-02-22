CREATE DEFAULT [dbo].[df_int_as_0]
    AS 0;


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_int_as_0]', @objname = N'[dbo].[x12_functional_group].[ge01_num_transaction_sets]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_int_as_0]', @objname = N'[dbo].[x12_interchange].[iea01_num_functional_groups]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[df_int_as_0]', @objname = N'[dbo].[x12_transaction].[se01_num_transaction_segments]';

