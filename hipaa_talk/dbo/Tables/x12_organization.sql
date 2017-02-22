CREATE TABLE [dbo].[x12_organization] (
    [x12_organization_id]   INT              IDENTITY (1, 1) NOT NULL,
    [x12_organization_uid]  UNIQUEIDENTIFIER NULL,
    [x12_organization_ud]   VARCHAR (32)     NULL,
    [x12_organization_nm]   VARCHAR (64)     NULL,
    [other_organization_nm] VARCHAR (64)     NULL,
    [is_home_org]           BIT              NOT NULL,
    [active]                BIT              NOT NULL,
    [modified_by]           UNIQUEIDENTIFIER NOT NULL,
    [modified_date]         DATETIME         NOT NULL,
    [created_by]            UNIQUEIDENTIFIER NOT NULL,
    [created_date]          DATETIME         NOT NULL,
    [timestamp]             ROWVERSION       NOT NULL,
    CONSTRAINT [PK_x12_organization] PRIMARY KEY CLUSTERED ([x12_organization_id] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used for matching the organization to an entity as it exists in an external system.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'x12_organization', @level2type = N'COLUMN', @level2name = N'other_organization_nm';

