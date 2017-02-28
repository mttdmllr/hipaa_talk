CREATE TABLE [dbo].[x12_identifier] (
    [x12_identifier_id]   INT              IDENTITY (1, 1) NOT NULL,
    [x12_identifier_uid]  UNIQUEIDENTIFIER NOT NULL,
    [x12_organization_id] INT              NOT NULL,
    [identifier_qual]     CHAR (5)         NULL,
    [identifier_value]    VARCHAR (64)     NULL,
    [outgoing_default]    BIT              NOT NULL,
    [incoming_default]    BIT              NOT NULL,
    [active]              BIT              NOT NULL,
    [modified_by]         UNIQUEIDENTIFIER NOT NULL,
    [modified_date]       DATETIME         NOT NULL,
    [created_by]          UNIQUEIDENTIFIER NOT NULL,
    [created_date]        DATETIME         NOT NULL,
    [timestamp]           ROWVERSION       NOT NULL,
    CONSTRAINT [PK_x12_identifier] PRIMARY KEY CLUSTERED ([x12_identifier_id] ASC)
);

