--Testing incremental load
INSERT INTO dbo.orders
(order_id, customer_id, store_id, promotion_id, order_date, created_at, updated_at)
VALUES
(300005,1,1,1,CAST(GETDATE() AS DATE), SYSUTCDATETIME(), SYSUTCDATETIME());

SELECT * FROM dbo.orders WHERE order_id = 300005;

SELECT * FROM dbo.promotions

UPDATE dbo.orders
SET 
    promotion_id = 1,
    updated_at = SYSUTCDATETIME()
WHERE order_id = 300005

EXEC dbo.usp_GetOldWatermark
    @TableName = 'orders';

EXEC dbo.usp_GetNewWatermark
    @TableName = 'orders',
    @WatermarkColumn ='updated_at';

EXEC dbo.usp_GetIncrementalData
    @TableName = 'orders',
    @OldWatermark = '2026-10-01T11:34:52.1166667',
    @NewWatermark ='2026-10-01T11:34:52.1173510'

SELECT * FROM dbo.etl_watermark


