CREATE TABLE [dbo].[x12_interchange_status] (
    [x12_interchange_status_id] INT              IDENTITY (1, 1) NOT NULL,
    [x12_interchange_status_ud] VARCHAR (32)     NOT NULL,
    [x12_interchange_status_nm] VARCHAR (64)     NOT NULL,
    [active]                    BIT              NOT NULL,
    [modified_by]               UNIQUEIDENTIFIER NOT NULL,
    [modified_date]             DATETIME         NOT NULL,
    [created_by]                UNIQUEIDENTIFIER NOT NULL,
    [created_date]              DATETIME         NOT NULL,
    [timestamp]                 ROWVERSION       NOT NULL,
    CONSTRAINT [PK_x12_interchange_status] PRIMARY KEY CLUSTERED ([x12_interchange_status_id] ASC)
);

