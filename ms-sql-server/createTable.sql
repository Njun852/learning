-- USE [tutorialDB]
-- -- create a new table called 'Customers' in schema 'dbo'
-- -- drop the table if it already exists
-- IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL
-- DROP TABLE dbo.Customers
-- GO
-- -- create the table in the specified schema
-- CREATE TABLE dbo.Customers 
-- (
--     CustomerId INT            NOT NULL PRIMARY KEY,
--     Name       [NVARCHAR](50) NOT NULL,
--     Location   [NVARCHAR](50) NOT NULL,
--     Email      [NVARCHAR](50) NOT NULL
-- );
-- GO
USE tutorialDB
CREATE TABLE dbo.Products
(
    ProductID           INT          NOT NULL PRIMARY KEY,
    ProductName         NVARCHAR(50) NOT NULL,
    Price               MONEY        NULL,
    ProductDescription  VARCHAR(max) NULL
)
GO