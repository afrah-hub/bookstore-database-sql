USE BookStoreDB;
GO


-- Drop Function
IF OBJECT_ID('dbo.fn_BookCountByAuthor', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_BookCountByAuthor;
GO

IF OBJECT_ID('dbo.GetBooksByAuthor', 'P') IS NOT NULL
    DROP PROCEDURE dbo.GetBooksByAuthor;
GO

IF OBJECT_ID('dbo.GetAllBookTitles', 'P') IS NOT NULL
    DROP PROCEDURE dbo.GetAllBookTitles;
GO

IF OBJECT_ID('dbo.Sales', 'U') IS NOT NULL
    DROP TABLE dbo.Sales;
GO

IF OBJECT_ID('dbo.Books', 'U') IS NOT NULL
    DROP TABLE dbo.Books;
GO


CREATE TABLE Books (
    BookID INT IDENTITY(1,1) PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Author VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2)
);
GO

CREATE TABLE Sales (
    SaleID INT IDENTITY(1,1) PRIMARY KEY,
    BookID INT,
    SaleDate DATE,
    SaleAmount DECIMAL(10,2),
    CONSTRAINT FK_Sales_Books
        FOREIGN KEY (BookID) REFERENCES Books(BookID)
);
GO


INSERT INTO Books (Title, Author, Price)
VALUES
('Harry Potter', 'J K Rowling', 499),
('Fantastic Beasts', 'J K Rowling', 399),
('The Alchemist', 'Paulo Coelho', 299),
('Wings of Fire', 'A P J Abdul Kalam', 199);
GO


CREATE PROCEDURE GetAllBookTitles
AS
BEGIN
    SELECT Title FROM Books;
END;
GO

CREATE PROCEDURE GetBooksByAuthor
    @AuthorName VARCHAR(100)
AS
BEGIN
    SELECT BookID, Title, Author, Price
    FROM Books
    WHERE Author = @AuthorName;
END;
GO


CREATE FUNCTION fn_BookCountByAuthor
(
    @AuthorName VARCHAR(100)
)
RETURNS INT
AS
BEGIN
    DECLARE @Total INT;

    SELECT @Total = COUNT(*)
    FROM Books
    WHERE Author = @AuthorName;

    RETURN @Total;
END;
GO


EXEC GetAllBookTitles;
GO

EXEC GetBooksByAuthor 'J K Rowling';
GO

SELECT dbo.fn_BookCountByAuthor('Paulo Coelho') AS TotalBooks;
GO
