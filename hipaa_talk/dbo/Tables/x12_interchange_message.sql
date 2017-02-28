CREATE TABLE [dbo].[x12_interchange_message] (
    [x12_interchange_message_id]  INT              IDENTITY (1, 1) NOT NULL,
    [x12_interchange_uid]         UNIQUEIDENTIFIER NULL,
    [isa13_control_no]            VARCHAR (9)      NULL,
    [gs06_group_control_no]       VARCHAR (9)      NULL,
    [st02_transaction_control_no] VARCHAR (9)      NULL,
    [loop_id]                     VARCHAR (10)     NULL,
    [segment_id]                  CHAR (5)         NULL,
    [segment_pos_in_tran]         INT              NULL,
    [element_pos_in_segment]      INT              NULL,
    [element_no]                  INT              NULL,
    [element_value]               VARCHAR (128)    NULL,
    [message_code]                CHAR (10)        NULL,
    [message_text]                NVARCHAR (500)   NULL,
    [active]                      BIT              NOT NULL,
    [modified_by]                 UNIQUEIDENTIFIER NOT NULL,
    [modified_date]               DATETIME         NOT NULL,
    [created_by]                  UNIQUEIDENTIFIER NOT NULL,
    [created_date]                DATETIME         NOT NULL,
    [timestamp]                   ROWVERSION       NOT NULL,
    CONSTRAINT [PK_x12_parse_temp_message] PRIMARY KEY CLUSTERED ([x12_interchange_message_id] ASC)
);

