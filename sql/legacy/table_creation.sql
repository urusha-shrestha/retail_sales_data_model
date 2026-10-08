IF OBJECT_ID(N'dbo.categories', N'U') IS NULL
BEGIN 
    CREATE TABLE dbo.categories(
        category_id INT NOT NULL PRIMARY KEY,
        category_name VARCHAR(100)
    );
END;

IF OBJECT_ID(N'dbo.suppliers', N'U') IS NULL
BEGIN 
    CREATE TABLE dbo.suppliers(
        supplier_id INT NULL,
        supplier_name VARCHAR(200),
        country VARCHAR(100)
    );
END;

IF OBJECT_ID(N'dbo.customers', N'U') IS NULL
BEGIN 
    CREATE TABLE dbo.customers(
        customer_id INT NOT NULL PRIMARY KEY,
        customer_name VARCHAR(200),
        city VARCHAR(100),
        signup_date DATE
    );
END;

IF OBJECT_ID(N'dbo.stores', N'U') IS NULL
BEGIN 
    CREATE TABLE dbo.stores(
        store_id INT NOT NULL PRIMARY KEY,
        store_name VARCHAR(200),
        city VARCHAR(100)
    );
END;

IF OBJECT_ID(N'dbo.promotions', N'U') IS NULL
BEGIN 
    CREATE TABLE dbo.promotions(
        promotion_id INT NOT NULL PRIMARY KEY,
        discount INT
    );
END;

IF OBJECT_ID(N'dbo.employees', N'U') IS NULL
BEGIN 
    CREATE TABLE dbo.employees(
        employee_id INT NOT NULL PRIMARY KEY,
        store_id INT,
        employee_name VARCHAR(200),
        salary INT
    );
END;

IF OBJECT_ID(N'dbo.products', N'U') IS NULL
BEGIN 
    CREATE TABLE dbo.products(
        product_id INT NOT NULL PRIMARY KEY,
        category_id INT,
        supplier_id INT,
        product_name VARCHAR(200),
        price INT
    );
END;

IF OBJECT_ID(N'dbo.orders', N'U') IS NULL
BEGIN 
    CREATE TABLE dbo.orders(
        order_id INT NOT NULL PRIMARY KEY,
        customer_id INT,
        store_id INT,
        promotion_id INT,
        order_date DATE
    );
END;

IF OBJECT_ID(N'dbo.order_items', N'U') IS NULL
BEGIN 
    CREATE TABLE dbo.order_items(
        order_item_id INT NOT NULL PRIMARY KEY,
        order_id INT,
        product_id INT,
        qty INT,
        price INT
    );
END;

IF OBJECT_ID(N'dbo.payments', N'U') IS NULL
BEGIN 
    CREATE TABLE dbo.payments(
        payment_id INT NOT NULL PRIMARY KEY,
        order_id INT,
        amount INT
    );
END;

IF OBJECT_ID(N'dbo.shipments', N'U') IS NULL
BEGIN 
    CREATE TABLE dbo.shipments(
        shipment_id INT NOT NULL PRIMARY KEY,
        order_id INT,
        status VARCHAR(50)
    );
END;

IF OBJECT_ID(N'dbo.returns', N'U') IS NULL
BEGIN 
    CREATE TABLE dbo.returns(
        return_id INT NOT NULL PRIMARY KEY,
        order_item_id INT,
        refund INT
    );
END;


IF OBJECT_ID(N'dbo.etl_watermark', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.etl_watermark(
        table_name VARCHAR(100) PRIMARY KEY,
        last_watermark DATETIME2 NOT NULL 
    );
END;




















