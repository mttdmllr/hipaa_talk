CREATE TABLE [dbo].[x12_997_functional_ack] (
    [x12_997_functional_ack_id]         INT              IDENTITY (1, 1) NOT NULL,
    [x12_transaction_id]                INT              NOT NULL,
    [src_x12_functional_group_id]       INT              NULL,
    [ak101_gs01_functional_id_code]     CHAR (2)         NULL,
    [ak102_gs06_group_control_no]       VARCHAR (9)      NULL,
    [ak103_gs08_version_id_code]        VARCHAR (12)     NULL,
    [ak201_st01_transaction_id_code]    CHAR (3)         NULL,
    [ak202_st02_transaction_control_no] VARCHAR (9)      NULL,
    [ak301_segment_id_code]             CHAR (3)         NULL,
    [ak302_segment_pos]                 VARCHAR (10)     NULL,
    [ak303_loop_id_code]                VARCHAR (4)      NULL,
    [ak304_segment_syntax_error_code]   VARCHAR (3)      NULL,
    [ak401_element_pos]                 VARCHAR (2)      NULL,
    [ak402_data_element_ref_no]         VARCHAR (4)      NULL,
    [ak403_element_syntax_error_code]   VARCHAR (3)      NULL,
    [ak404_copy_of_bad_element]         VARCHAR (99)     NULL,
    [ak501_tran_ack_code]               CHAR (1)         NULL,
    [ak502_tran_syntax_error_code]      VARCHAR (3)      NULL,
    [ak503_tran_syntax_error_code]      VARCHAR (3)      NULL,
    [ak504_tran_syntax_error_code]      VARCHAR (3)      NULL,
    [ak505_tran_syntax_error_code]      VARCHAR (3)      NULL,
    [ak506_tran_syntax_error_code]      VARCHAR (3)      NULL,
    [ak901_funct_ack_code]              CHAR (1)         NULL,
    [ak902_num_tran_sets]               INT              NULL,
    [ak903_num_rcvd_tran_sets]          INT              NULL,
    [ak904_num_accept_tran_sets]        INT              NULL,
    [ak905_func_syntax_error_code]      VARCHAR (3)      NULL,
    [ak906_func_syntax_error_code]      VARCHAR (3)      NULL,
    [ak907_func_syntax_error_code]      VARCHAR (3)      NULL,
    [ak908_func_syntax_error_code]      VARCHAR (3)      NULL,
    [ak909_func_syntax_error_code]      VARCHAR (3)      NULL,
    [error]                             BIT              NOT NULL,
    [processed]                         BIT              NOT NULL,
    [active]                            BIT              NOT NULL,
    [modified_by]                       UNIQUEIDENTIFIER NOT NULL,
    [modified_date]                     DATETIME         NOT NULL,
    [created_by]                        UNIQUEIDENTIFIER NOT NULL,
    [created_date]                      DATETIME         NOT NULL,
    [timestamp]                         ROWVERSION       NOT NULL,
    CONSTRAINT [PK_x12_997_ack] PRIMARY KEY CLUSTERED ([x12_997_functional_ack_id] ASC),
    CONSTRAINT [FK_x12_997_functional_ack_x12_transaction] FOREIGN KEY ([x12_transaction_id]) REFERENCES [dbo].[x12_transaction] ([x12_transaction_id])
);


GO
CREATE NONCLUSTERED INDEX [idx_x12_transaction_header_id]
    ON [dbo].[x12_997_functional_ack]([x12_transaction_id] ASC);

