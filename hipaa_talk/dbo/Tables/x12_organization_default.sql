CREATE TABLE [dbo].[x12_organization_default] (
    [x12_organization_default_id]  INT              IDENTITY (1, 1) NOT NULL,
    [x12_organization_default_uid] UNIQUEIDENTIFIER NOT NULL,
    [x12_organization_id]          INT              NOT NULL,
    [default_value]                VARCHAR (80)     NULL,
    [table_nm]                     VARCHAR (64)     NULL,
    [column_nm]                    VARCHAR (64)     NULL,
    [use_if_source]                BIT              NOT NULL,
    [use_if_dest]                  BIT              NOT NULL,
    [use_if_null]                  BIT              NOT NULL,
    [override_value]               BIT              NOT NULL,
    [active]                       BIT              NOT NULL,
    [modified_by]                  UNIQUEIDENTIFIER NOT NULL,
    [modified_date]                DATETIME         NOT NULL,
    [created_by]                   UNIQUEIDENTIFIER NOT NULL,
    [created_date]                 DATETIME         NOT NULL,
    [timestamp]                    ROWVERSION       NOT NULL,
    CONSTRAINT [PK_x12_organization_default] PRIMARY KEY CLUSTERED ([x12_organization_default_id] ASC),
    CONSTRAINT [FK_x12_organization_default_x12_organization] FOREIGN KEY ([x12_organization_id]) REFERENCES [dbo].[x12_organization] ([x12_organization_id])
);

