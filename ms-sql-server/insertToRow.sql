-- INSERT INTO dbo.Customers
--     (CustomerId, Name, Location, Email)
-- VALUES
--     (1, N'Orlando', N'Australia', N''),
--     (2, N'Keith', N'India', N'keith0@adventure-works.com'),
--     (3, N'Donna', N'Germany', N'donna@adventure-works.com'),
--     (4, N'Janet', N'United State', N'janet1@adventure-works.com')
-- GO
INSERT INTO dbo.Products
    (ProductID, ProductName, Price, ProductDescription)
VALUES
    (1, N'Clamp', 12.8, N'Workbench clamp'),
    (50, N'Screwdriver', 3.17, N'Flat head'),
    (75, N'Tire Bar', NULL, N'Tool for changing tires'),
    (3000, N'3 mm Bracket', 0.52, NULL)
GO