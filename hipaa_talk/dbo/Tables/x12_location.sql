CREATE TABLE [dbo].[x12_location] (
    [x12_location_id]  INT              IDENTITY (1, 1) NOT NULL,
    [location_ud]      VARCHAR (32)     NULL,
    [location_nm]      VARCHAR (64)     NULL,
    [location_address] VARCHAR (128)    NULL,
    [file_mask]        VARCHAR (32)     NULL,
    [active]           BIT              NOT NULL,
    [modified_by]      UNIQUEIDENTIFIER NOT NULL,
    [modified_date]    DATETIME         NOT NULL,
    [created_by]       UNIQUEIDENTIFIER NOT NULL,
    [created_date]     DATETIME         NOT NULL,
    [timestamp]        ROWVERSION       NOT NULL,
    CONSTRAINT [PK_x12_location] PRIMARY KEY CLUSTERED ([x12_location_id] ASC)
);

