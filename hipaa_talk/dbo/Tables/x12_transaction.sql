CREATE TABLE [dbo].[x12_transaction] (
    [x12_transaction_id]            INT              IDENTITY (1, 1) NOT NULL,
    [x12_transaction_uid]           UNIQUEIDENTIFIER NULL,
    [x12_functional_group_id]       INT              NULL,
    [st01_transaction_id_code]      CHAR (3)         NULL,
    [st02_transaction_control_no]   VARCHAR (9)      NULL,
    [se01_num_transaction_segments] INT              NULL,
    [x12_parse_temp_id_start]       INT              NULL,
    [x12_parse_temp_id_end]         INT              NULL,
    [error]                         BIT              NOT NULL,
    [processed]                     BIT              NOT NULL,
    [active]                        BIT              NOT NULL,
    [modified_by]                   UNIQUEIDENTIFIER NOT NULL,
    [modified_date]                 DATETIME         NOT NULL,
    [created_by]                    UNIQUEIDENTIFIER NOT NULL,
    [created_date]                  DATETIME         NOT NULL,
    [timestamp]                     ROWVERSION       NOT NULL,
    CONSTRAINT [PK_x12_isa] PRIMARY KEY CLUSTERED ([x12_transaction_id] ASC),
    CONSTRAINT [FK_x12_transaction_x12_functional_group] FOREIGN KEY ([x12_functional_group_id]) REFERENCES [dbo].[x12_functional_group] ([x12_functional_group_id])
);


GO
CREATE NONCLUSTERED INDEX [idx_functional_group_id]
    ON [dbo].[x12_transaction]([x12_transaction_id] ASC, [x12_functional_group_id] ASC);

