CREATE TABLE [dbo].[x12_ta1_interchange_ack] (
    [x12_ta1_interchange_ack_id]  INT              IDENTITY (1, 1) NOT NULL,
    [x12_interchange_id]          INT              NOT NULL,
    [src_x12_interchange_id]      INT              NULL,
    [ta101_isa13_control_no]      CHAR (9)         NULL,
    [ta102_interchange_date]      CHAR (6)         NULL,
    [ta103_interchange_time]      CHAR (4)         NULL,
    [ta104_interchange_ack_code]  CHAR (1)         NULL,
    [ta105_interchange_note_code] CHAR (3)         NULL,
    [error]                       BIT              NOT NULL,
    [processed]                   BIT              NOT NULL,
    [active]                      BIT              NOT NULL,
    [modified_by]                 UNIQUEIDENTIFIER NOT NULL,
    [modified_date]               DATETIME         NOT NULL,
    [created_by]                  UNIQUEIDENTIFIER NOT NULL,
    [created_date]                DATETIME         NOT NULL,
    [timestamp]                   ROWVERSION       NOT NULL,
    CONSTRAINT [PK_x12_ta1] PRIMARY KEY CLUSTERED ([x12_ta1_interchange_ack_id] ASC),
    CONSTRAINT [FK_x12_ta1_interchange_ack_x12_interchange] FOREIGN KEY ([x12_interchange_id]) REFERENCES [dbo].[x12_interchange] ([x12_interchange_id])
);


GO
CREATE NONCLUSTERED INDEX [idx_x12_transaction_header_id]
    ON [dbo].[x12_ta1_interchange_ack]([x12_interchange_id] ASC);

