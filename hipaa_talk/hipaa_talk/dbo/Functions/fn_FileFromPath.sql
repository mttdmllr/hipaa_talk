

CREATE FUNCTION [dbo].[fn_FileFromPath] (@FullPathName varchar(4000))
RETURNS varchar(4000) AS  
/*********************
-- START DOC --
FUNCTION: fn_FileFromPath
	Parameter:	[IN] @FullPathName varchar(4000)
			[RETURN] varchar(4000)
	Type:		varchar
	
	Characteristic:	DETERMINISTIC
	Description:	Returns the filename of a file from a full path string
	
	Example:	select dbo.fn_FileFromPath('c:\boot.ini'); returns 'boot.ini'
-- END DOC --
*********************/
BEGIN 
	declare @FileName varchar(4000)
	declare @FileNameLength int
	set @FileName = @FullPathName

	set @FileNameLength = CHARINDEX('\', REVERSE(@FileName))-1

	if (@FileNameLength <= 0)
	begin
		set @FileNameLength = LEN(@FileName)
	end

	set @FileName = RIGHT(@FileName, @FileNameLength)

	return @FileName
END
