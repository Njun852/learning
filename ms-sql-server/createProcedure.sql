CREATE PROCEDURE names @id INT
    AS
    BEGIN
    -- print statement is returned
    PRINT 'Product with id greater than ' + CAST(@id AS VARCHAR(10));
    SELECT * FROM IdOfProduct
        WHERE ProductId > @id;
    END
GO