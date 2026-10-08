
-- get old watermark from etl_watermark table  
CREATE OR ALTER PROCEDURE dbo.usp_GetOldWatermark
    @TableName VARCHAR(100)
AS
BEGIN  
    SET NOCOUNT ON;

    SELECT 
        last_watermark
    FROM dbo.etl_watermark
    WHERE table_name = @TableName;
END;
GO

-- get new watermark from respective tables 
CREATE OR ALTER PROCEDURE dbo.usp_GetNewWatermark
    @TableName VARCHAR(100),
    @WatermarkColumn VARCHAR(100)
AS
BEGIN   
    SET NOCOUNT ON;

    DECLARE @SQL NVARCHAR(MAX);

    SET @SQL = N'
    SELECT 
        MAX('+ QUOTENAME(@WatermarkColumn) + N') AS new_watermark
    FROM dbo.'+QUOTENAME(@TableName) + N';';

    EXEC sp_executesql @SQL;

END;
GO


-- get new values only
CREATE OR ALTER PROCEDURE dbo.usp_GetIncrementalData
    @TableName VARCHAR(100),
    @OldWatermark DATETIME2,
    @NewWatermark DATETIME2
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SQL NVARCHAR(MAX);

    SET @SQL=N'
    SELECT 
        *
    FROM dbo.' +QUOTENAME(@TableName) + N'
    WHERE updated_at > @OldWM
    AND updated_at <= @NewWM;';

    EXEC sp_executesql 
        @SQL,
        N'@OldWM DATETIME2, @NewWM DATETIME2',
        @OldWM = @OldWatermark,
        @NewWM = @NewWatermark;
END;
GO


-- update the watermark in etl_watermark table after incremental load
CREATE OR ALTER PROCEDURE dbo.usp_UpdateWatermark
    @TableName VARCHAR(100),
    @NewWatermark DATETIME2
AS 
BEGIN   
    SET NOCOUNT ON;

    UPDATE dbo.etl_watermark
    SET last_watermark = @NewWatermark
    WHERE table_name = @TableName;

    IF @@ROWCOUNT = 0
    BEGIN
        THROW 50001, 'Watermark record not found', 1;
    END
END;
GO
