CREATE TABLE [dbo].[x12_interchange] (
    [x12_interchange_id]                INT              IDENTITY (1, 1) NOT NULL,
    [x12_interchange_uid]               UNIQUEIDENTIFIER NULL,
    [src_x12_organization_id]           INT              NULL,
    [dest_x12_organization_id]          INT              NULL,
    [isa01_auth_info_qual]              CHAR (2)         NULL,
    [isa02_auth_info]                   CHAR (10)        NULL,
    [isa03_security_info_qual]          CHAR (2)         NULL,
    [isa04_security_info]               CHAR (10)        NULL,
    [isa05_sender_id_qual]              CHAR (2)         NULL,
    [isa06_sender_id]                   CHAR (15)        NULL,
    [isa07_receiver_id_qual]            CHAR (2)         NULL,
    [isa08_receiver_id]                 CHAR (15)        NULL,
    [isa09_interchange_date]            CHAR (6)         NULL,
    [isa10_interchange_time]            CHAR (4)         NULL,
    [isa11_control_standards_id]        CHAR (1)         NULL,
    [isa12_control_version_no]          CHAR (5)         NULL,
    [isa13_control_no]                  CHAR (9)         NULL,
    [isa14_ack_requested]               CHAR (1)         NULL,
    [isa15_usage_indicator]             CHAR (1)         NULL,
    [iea01_num_functional_groups]       INT              NULL,
    [x12_parse_temp_id_start]           INT              NULL,
    [x12_parse_temp_id_end]             INT              NULL,
    [filename]                          VARCHAR (512)    NULL,
    [archive_filename]                  VARCHAR (512)    NULL,
    [incoming]                          BIT              NOT NULL,
    [outgoing]                          BIT              NOT NULL,
    [error]                             BIT              NOT NULL,
    [processed]                         BIT              NOT NULL,
    [active]                            BIT              NOT NULL,
    [modified_by]                       UNIQUEIDENTIFIER NOT NULL,
    [modified_date]                     DATETIME         NOT NULL,
    [created_by]                        UNIQUEIDENTIFIER NOT NULL,
    [created_date]                      DATETIME         NOT NULL,
    [timestamp]                         ROWVERSION       NOT NULL,
    [x12_interchange_status_id]         INT              NULL,
    [isa16_component_element_seperator] CHAR (1)         NULL,
    [element_separator]                 CHAR (1)         NULL,
    [segment_separator]                 VARCHAR (3)      NULL,
    CONSTRAINT [PK_x12_interchange] PRIMARY KEY CLUSTERED ([x12_interchange_id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idx_src_x12_organization_id]
    ON [dbo].[x12_interchange]([src_x12_organization_id] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_dest_x12_organization_id]
    ON [dbo].[x12_interchange]([dest_x12_organization_id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_x12_isa09_interchange_date]
    ON [dbo].[x12_interchange]([isa09_interchange_date] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_created_date]
    ON [dbo].[x12_interchange]([created_date] ASC);

