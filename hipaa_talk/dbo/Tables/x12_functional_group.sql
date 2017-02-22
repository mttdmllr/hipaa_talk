CREATE TABLE [dbo].[x12_functional_group] (
    [x12_functional_group_id]   INT              IDENTITY (1, 1) NOT NULL,
    [x12_functional_group_uid]  UNIQUEIDENTIFIER NULL,
    [x12_interchange_id]        INT              NULL,
    [x12_transaction_schema_id] INT              NULL,
    [gs01_functional_id_code]   CHAR (2)         NULL,
    [gs02_app_sender_code]      VARCHAR (15)     NULL,
    [gs03_app_receiver_code]    VARCHAR (15)     NULL,
    [gs04_date]                 CHAR (8)         NULL,
    [gs05_time]                 VARCHAR (8)      NULL,
    [gs06_group_control_no]     VARCHAR (9)      NULL,
    [gs07_resp_agency_code]     VARCHAR (2)      NULL,
    [gs08_version_id_code]      VARCHAR (12)     NULL,
    [ge01_num_transaction_sets] INT              NULL,
    [x12_parse_temp_id_start]   INT              NULL,
    [x12_parse_temp_id_end]     INT              NULL,
    [error]                     BIT              NOT NULL,
    [processed]                 BIT              NOT NULL,
    [active]                    BIT              NOT NULL,
    [modified_by]               UNIQUEIDENTIFIER NOT NULL,
    [modified_date]             DATETIME         NOT NULL,
    [created_by]                UNIQUEIDENTIFIER NOT NULL,
    [created_date]              DATETIME         NOT NULL,
    [timestamp]                 ROWVERSION       NOT NULL,
    CONSTRAINT [PK_x12_functional_group] PRIMARY KEY CLUSTERED ([x12_functional_group_id] ASC),
    CONSTRAINT [FK_x12_functional_group_x12_interchange] FOREIGN KEY ([x12_interchange_id]) REFERENCES [dbo].[x12_interchange] ([x12_interchange_id]),
    CONSTRAINT [FK_x12_functional_group_x12_transaction_schema] FOREIGN KEY ([x12_transaction_schema_id]) REFERENCES [dbo].[x12_transaction_schema] ([x12_transaction_schema_id])
);


GO
CREATE NONCLUSTERED INDEX [idx_schema]
    ON [dbo].[x12_functional_group]([x12_functional_group_id] ASC, [x12_interchange_id] ASC, [x12_transaction_schema_id] ASC);

