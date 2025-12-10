CREATE DATABASE GoldDB;
GO
USE GoldDB;
GO

-- !!! 請替換為您自己的強密碼 !!!
CREATE MASTER KEY ENCRYPTION BY PASSWORD='synapseboya@zxcvbnm!!qaz2edc4';
GO

-- 創建一個使用 Synapse Workspace Managed Identity 的認證
CREATE DATABASE SCOPED CREDENTIAL AppCred 
WITH IDENTITY = 'Managed Identity'; -- 這要求 Synapse MI 在 ADLS Gen2 上擁有 Storage Blob Data Reader 角色
GO