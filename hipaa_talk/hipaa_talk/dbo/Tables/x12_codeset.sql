CREATE TABLE [dbo].[x12_codeset] (
    [x12_code_id]   INT              IDENTITY (1, 1) NOT NULL,
    [envr]          VARCHAR (206)    NOT NULL,
    [code]          VARCHAR (254)    NOT NULL,
    [description]   VARCHAR (512)    NULL,
    [eff_date]      DATETIME         NULL,
    [term_date]     DATETIME         NULL,
    [active]        BIT              NOT NULL,
    [modified_by]   UNIQUEIDENTIFIER NOT NULL,
    [modified_date] DATETIME         NOT NULL,
    [created_by]    UNIQUEIDENTIFIER NOT NULL,
    [created_date]  DATETIME         NOT NULL,
    [timestamp]     ROWVERSION       NOT NULL,
    CONSTRAINT [PK_x12_codset] PRIMARY KEY CLUSTERED ([x12_code_id] ASC)
);

