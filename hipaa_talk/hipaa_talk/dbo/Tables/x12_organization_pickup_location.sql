CREATE TABLE [dbo].[x12_organization_pickup_location] (
    [x12_organization_pickup_location_id] INT              IDENTITY (1, 1) NOT NULL,
    [src_x12_organization_id]             INT              NULL,
    [dest_x12_organization_id]            INT              NULL,
    [x12_location_id]                     INT              NULL,
    [x12_transaction_schema_id]           INT              NULL,
    [active]                              BIT              NOT NULL,
    [modified_by]                         UNIQUEIDENTIFIER NOT NULL,
    [modified_date]                       DATETIME         NOT NULL,
    [created_by]                          UNIQUEIDENTIFIER NOT NULL,
    [created_date]                        DATETIME         NOT NULL,
    [timestamp]                           ROWVERSION       NOT NULL,
    CONSTRAINT [PK_x12_organization_location] PRIMARY KEY CLUSTERED ([x12_organization_pickup_location_id] ASC),
    CONSTRAINT [FK_x12_organization_pickup_location_dest_x12_organization] FOREIGN KEY ([dest_x12_organization_id]) REFERENCES [dbo].[x12_organization] ([x12_organization_id]),
    CONSTRAINT [FK_x12_organization_pickup_location_src_x12_organization] FOREIGN KEY ([src_x12_organization_id]) REFERENCES [dbo].[x12_organization] ([x12_organization_id]),
    CONSTRAINT [FK_x12_organization_pickup_location_x12_location] FOREIGN KEY ([x12_location_id]) REFERENCES [dbo].[x12_location] ([x12_location_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_x12_organization_pickup_location_x12_transaction_schema] FOREIGN KEY ([x12_transaction_schema_id]) REFERENCES [dbo].[x12_transaction_schema] ([x12_transaction_schema_id])
);

