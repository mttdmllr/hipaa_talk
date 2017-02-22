CREATE FUNCTION [dbo].[ufsReadfileAsString]
    (
      @Path VARCHAR(255) ,
      @Filename VARCHAR(100)
    )
RETURNS VARCHAR(MAX)
AS 
    BEGIN

        DECLARE @objFileSystem INT ,
            @objTextStream INT ,
            @objErrorObject INT ,
            @strErrorMessage VARCHAR(1000) ,
            @Command VARCHAR(1000) ,
            @Chunk VARCHAR(8000) ,
            @String VARCHAR(MAX) ,
            @hr INT ,
            @YesOrNo INT

        SELECT  @String = ''
        SELECT  @strErrorMessage = 'opening the File System Object'
        EXECUTE @hr = sp_OACreate 'Scripting.FileSystemObject',
				@objFileSystem OUT


        IF @HR = 0 
            SELECT  @objErrorObject = @objFileSystem ,
                    @strErrorMessage = 'Opening file "' + @path + '\'
                    + @filename + '"' ,
                    @command = @path + '\' + @filename

        IF @HR = 0 
            EXECUTE @hr = sp_OAMethod @objFileSystem, 'OpenTextFile',
					@objTextStream OUT, @command, 1, false, 0--for reading, FormatASCII

--        WHILE @hr = 0 
--            BEGIN
                IF @HR = 0 
                    SELECT  @objErrorObject = @objTextStream ,
                            @strErrorMessage = 'finding out if there is more to read in "'
                            + @filename + '"'
                IF @HR = 0 
                    EXECUTE @hr = sp_OAGetProperty @objTextStream,
                        'AtEndOfStream', @YesOrNo OUTPUT

--				IF @YesOrNo <> 0 
--					BREAK
                IF @HR = 0 
                    SELECT  @objErrorObject = @objTextStream ,
                            @strErrorMessage = 'reading from the output file "'
                            + @filename + '"'
                IF @HR = 0 
                    EXECUTE	@hr = sp_OAMethod @objTextStream, 'Read',
							@chunk OUTPUT, 4000
                SELECT  @String = @string + @chunk
--            END
        IF @HR = 0 
            SELECT  @objErrorObject = @objTextStream ,
                    @strErrorMessage = 'closing the output file "' + @filename
                    + '"'
        IF @HR = 0 
            EXECUTE @hr = sp_OAMethod @objTextStream, 'Close'


        IF @hr <> 0 
            BEGIN
                DECLARE @Source VARCHAR(255) ,
                    @Description VARCHAR(255) ,
                    @Helpfile VARCHAR(255) ,
                    @HelpID INT
	
                EXECUTE sp_OAGetErrorInfo @objErrorObject, @source OUTPUT,
                    @Description OUTPUT, @Helpfile OUTPUT, @HelpID OUTPUT
                SELECT  @strErrorMessage = 'Error whilst '
                        + COALESCE(@strErrorMessage, 'doing something') + ', '
                        + COALESCE(@Description, '')
                SELECT  @String = @strErrorMessage
            END
        EXECUTE sp_OADestroy @objTextStream
	-- Fill the table variable with the rows for your result set
	
        RETURN @string
    END
