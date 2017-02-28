CREATE TABLE [dbo].[x12_parse_temp] (
    [x12_parse_temp_id]  INT              IDENTITY (1, 1) NOT NULL,
    [x12_parse_temp_uid] UNIQUEIDENTIFIER NULL,
    [Col001]             VARCHAR (264)    NULL,
    [Col002]             VARCHAR (264)    NULL,
    [Col003]             VARCHAR (264)    NULL,
    [Col004]             VARCHAR (264)    NULL,
    [Col005]             VARCHAR (264)    NULL,
    [Col006]             VARCHAR (264)    NULL,
    [Col007]             VARCHAR (264)    NULL,
    [Col008]             VARCHAR (264)    NULL,
    [Col009]             VARCHAR (264)    NULL,
    [Col010]             VARCHAR (264)    NULL,
    [Col011]             VARCHAR (264)    NULL,
    [Col012]             VARCHAR (264)    NULL,
    [Col013]             VARCHAR (264)    NULL,
    [Col014]             VARCHAR (264)    NULL,
    [Col015]             VARCHAR (264)    NULL,
    [Col016]             VARCHAR (264)    NULL,
    [Col017]             VARCHAR (264)    NULL,
    [Col018]             VARCHAR (264)    NULL,
    [Col019]             VARCHAR (264)    NULL,
    [Col020]             VARCHAR (264)    NULL,
    [Col021]             VARCHAR (264)    NULL,
    [Col022]             VARCHAR (264)    NULL,
    [Col023]             VARCHAR (264)    NULL,
    [Col024]             VARCHAR (264)    NULL,
    [Col025]             VARCHAR (264)    NULL,
    [filename]           VARCHAR (512)    NULL,
    CONSTRAINT [PK_x12_parse_temp] PRIMARY KEY CLUSTERED ([x12_parse_temp_id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_x12_parse_temp_uid]
    ON [dbo].[x12_parse_temp]([x12_parse_temp_uid] ASC);

