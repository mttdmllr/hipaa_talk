CREATE TABLE [dbo].[x12_transaction_schema] (
    [x12_transaction_schema_id]  INT              IDENTITY (1, 1) NOT NULL,
    [x12_transaction_schema_ud]  VARCHAR (32)     NULL,
    [x12_transaction_schema_nm]  VARCHAR (64)     NULL,
    [schema_namespace]           VARCHAR (64)     NULL,
    [standards_version]          VARCHAR (32)     NULL,
    [transaction_id_code]        VARCHAR (32)     NULL,
    [functional_group_id_code]   CHAR (5)         NULL,
    [functional_version_id_code] VARCHAR (12)     NULL,
    [table_nm]                   VARCHAR (64)     NULL,
    [active]                     BIT              NOT NULL,
    [modified_by]                UNIQUEIDENTIFIER NOT NULL,
    [modified_date]              DATETIME         NOT NULL,
    [created_by]                 UNIQUEIDENTIFIER NOT NULL,
    [created_date]               DATETIME         NOT NULL,
    [timestamp]                  ROWVERSION       NOT NULL,
    [parse_procedure_nm]         VARCHAR (128)    NULL,
    [export_procedure_nm]        VARCHAR (128)    NULL,
    CONSTRAINT [PK_x12_transaction_schema] PRIMARY KEY CLUSTERED ([x12_transaction_schema_id] ASC)
);

