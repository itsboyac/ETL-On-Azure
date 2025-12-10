--locate myself at this database
USE GoldDB;
GO
--define external source
CREATE EXTERNAL DATA SOURCE source_silver
WITH(
    LOCATION = 'https://datalakeboya.dfs.core.windows.net/silver',
    CREDENTIAL = AppCred
);

GO

CREATE EXTERNAL DATA SOURCE source_gold
WITH(
    LOCATION = 'https://datalakeboya.dfs.core.windows.net/gold',
    CREDENTIAL = AppCred
);
GO
--create external file parquet
CREATE EXTERNAL FILE FORMAT format_parquet
WITH(
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
);
GO
--create gold schema
CREATE SCHEMA gold;
GO