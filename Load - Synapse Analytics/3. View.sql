USE GoldDB;
GO

--create views, to virtualize silver folder dataset
--1. top_products
CREATE VIEW gold.top_products
AS
SELECT *
from OPENROWSET(
    BULK 'top_products',
    DATA_SOURCE = 'source_silver',
    FORMAT = 'PARQUET'
) AS rows;
GO

-- 2. dim_products
CREATE VIEW gold.dim_products
AS
SELECT *
FROM OPENROWSET(
  BULK 'dim_products', 
  DATA_SOURCE = 'source_silver',
  FORMAT = 'PARQUET'
) AS rows;
GO

-- 3. dim_customers
CREATE VIEW gold.dim_customers
AS
SELECT *
FROM OPENROWSET(
  BULK 'dim_customers', 
  DATA_SOURCE = 'source_silver',
  FORMAT = 'PARQUET'
) AS rows;
GO

-- 4. dim_categories
CREATE VIEW gold.dim_categories
AS
SELECT *
FROM OPENROWSET(
  BULK 'dim_categories', 
  DATA_SOURCE = 'source_silver',
  FORMAT = 'PARQUET'
) AS rows;
GO

-- sales_by_category
CREATE VIEW gold.sales_by_category
AS
SELECT *
FROM OPENROWSET(
  BULK 'sales_by_category', 
  DATA_SOURCE = 'source_silver',
  FORMAT = 'PARQUET'
) AS rows;
GO

-- sales_by_customer_segment
CREATE VIEW gold.sales_by_customer_segment
AS
SELECT *
FROM OPENROWSET(
  BULK 'sales_by_customer_segment', 
  DATA_SOURCE = 'source_silver',
  FORMAT = 'PARQUET'
) AS rows;
GO

-- sales_by_date
CREATE VIEW gold.sales_by_date
AS
SELECT *
FROM OPENROWSET(
  BULK 'sales_by_date', 
  DATA_SOURCE = 'source_silver',
  FORMAT = 'PARQUET'
) AS rows;
GO

-- sales_by_month
CREATE VIEW gold.sales_by_month
AS
SELECT *
FROM OPENROWSET(
  BULK 'sales_by_month', 
  DATA_SOURCE = 'source_silver',
  FORMAT = 'PARQUET'
) AS rows;
GO

-- sales_by_territory
CREATE VIEW gold.sales_by_territory
AS
SELECT *
FROM OPENROWSET(
  BULK 'sales_by_territory', 
  DATA_SOURCE = 'source_silver',
  FORMAT = 'PARQUET'
) AS rows;
GO

-- sales_fact
CREATE VIEW gold.sales_fact
AS
SELECT *
FROM OPENROWSET(
  BULK 'sales_fact', 
  DATA_SOURCE = 'source_silver',
  FORMAT = 'PARQUET'
) AS rows;
GO

--create gold layer tables
-- 1. top_products
CREATE EXTERNAL TABLE gold.ext_top_products
WITH(
    LOCATION = 'top_products',
    DATA_SOURCE = source_gold, --寫入gold容器
    FILE_FORMAT = format_parquet
)
as SELECT * FROM gold.top_products --從view中讀取
GO

-- 2. dim_products
CREATE EXTERNAL TABLE gold.ext_dim_products
WITH (
    LOCATION = 'dim_products',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS
SELECT * FROM gold.dim_products;
GO

-- 3. dim_customers
CREATE EXTERNAL TABLE gold.ext_dim_customers
WITH (
    LOCATION = 'dim_customers',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS
SELECT * FROM gold.dim_customers;
GO

-- 4. dim_categories
CREATE EXTERNAL TABLE gold.ext_dim_categories
WITH (
    LOCATION = 'dim_categories',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS
SELECT * FROM gold.dim_categories;
GO

-- sales_by_category
CREATE EXTERNAL TABLE gold.ext_sales_by_category
WITH (
    LOCATION = 'sales_by_category',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS
SELECT * FROM gold.sales_by_category;
GO

-- sales_by_customer_segment
CREATE EXTERNAL TABLE gold.ext_sales_by_customer_segment
WITH (
    LOCATION = 'sales_by_customer_segment',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS
SELECT * FROM gold.sales_by_customer_segment;
GO

-- sales_by_date
CREATE EXTERNAL TABLE gold.ext_sales_by_date
WITH (
    LOCATION = 'sales_by_date',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS
SELECT * FROM gold.sales_by_date;
GO

-- sales_by_month
CREATE EXTERNAL TABLE gold.ext_sales_by_month
WITH (
    LOCATION = 'sales_by_month',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS
SELECT * FROM gold.sales_by_month;
GO

-- sales_by_territory
CREATE EXTERNAL TABLE gold.ext_sales_by_territory
WITH (
    LOCATION = 'sales_by_territory',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS
SELECT * FROM gold.sales_by_territory;
GO

-- sales_fact
CREATE EXTERNAL TABLE gold.ext_sales_fact
WITH (
    LOCATION = 'sales_fact',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS
SELECT * FROM gold.sales_fact;
GO

-- 檢查 Gold Layer 數據是否準備就緒
SELECT TOP 10 * FROM gold.ext_top_products;
