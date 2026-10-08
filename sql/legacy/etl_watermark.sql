ALTER TABLE dbo.orders 
ADD created_at DATETIME2,
updated_at DATETIME2;


UPDATE dbo.orders
SET 
    created_at = SYSUTCDATETIME(),
    updated_at = SYSUTCDATETIME()
WHERE created_at IS NULL;

INSERT INTO dbo.etl_watermark(
    table_name, 
    last_watermark
) VALUES (
    'orders',
    '1900-01-01'
);


SELECT * FROM dbo.etl_watermark;