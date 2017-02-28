CREATE TABLE [dbo].[x12_document] (
    [x12_document_id]  INT              IDENTITY (1, 1) NOT NULL,
    [x12_document_uid] UNIQUEIDENTIFIER NOT NULL,
    [filename]         VARCHAR (512)    NULL,
    [filedata]         TEXT             NULL,
    [error]            BIT              NOT NULL,
    [processed]        BIT              NOT NULL,
    [active]           BIT              NOT NULL,
    [modified_by]      UNIQUEIDENTIFIER NOT NULL,
    [modified_date]    DATETIME         NOT NULL,
    [created_by]       UNIQUEIDENTIFIER NOT NULL,
    [created_date]     DATETIME         NOT NULL,
    [timestamp]        ROWVERSION       NOT NULL,
    CONSTRAINT [PK_x12_document] PRIMARY KEY CLUSTERED ([x12_document_id] ASC)
);

