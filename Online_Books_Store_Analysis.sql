-- Create Database

CREATE DATABASE ONLINE_BOOKS_STORE;

USE ONLINE_BOOKS_STORE;

SELECT * FROM BOOKS;

SELECT * FROM CUSTOMERS;

SELECT * FROM ORDERS;

-- 1) Retrieve all books in the "Fiction" genre:

SELECT * FROM Books 
WHERE Genre='Fiction';

-- 2) Find books published after the year 1950:

SELECT * FROM BOOKS 
WHERE PUBLISHED_YEAR > 1950;

-- 3) List all customers from the Canada:

SELECT * FROM Customers 
WHERE COUNTRY = "Canada";

-- 4) Show orders placed in November 2023:

SELECT * FROM ORDERS
WHERE ORDER_DATE BETWEEN "2023-11-01" AND "2023-11-30";

-- 5) Retrieve the total stock of books available:

SELECT SUM(STOCK) AS TOTAL_STOCK
From BOOKS;

-- 6) Find the details of the most expensive book:

SELECT * FROM Books 
ORDER BY Price DESC 
LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:

SELECT * FROM Orders 
WHERE quantity > 1;

-- 8) Retrieve all orders where the total amount exceeds $20:

SELECT * FROM Orders 
WHERE total_amount > 20;


-- 9) List all genres available in the Books table:

SELECT DISTINCT genre 
FROM Books;

-- 10) Find the book with the lowest stock:

SELECT * FROM Books 
ORDER BY stock 
LIMIT 1;

-- 11) Calculate the total revenue generated from all orders:

SELECT round(SUM(total_amount),2) As Revenue 
FROM Orders;

-- 12) Retrieve the total number of books sold for each genre:

SELECT B.Genre, SUM(O.Quantity) AS Total_Books_sold
FROM Orders as O INNER JOIN Books as B ON O.book_id = B.book_id
GROUP BY B.Genre;

-- 13) Find the average price of books in the "Fantasy" genre:

SELECT GENRE,ROUND(AVG(PRICE),2) AS AVG_PRICE_OF_FANTASY 
FROM BOOKS
WHERE GENRE="FANTASY";

-- 14) List customers who have placed at least 2 orders:

SELECT C.CUSTOMER_ID,C.NAME,COUNT(O.CUSTOMER_ID) AS MORE_THAN_2_ORDERS
FROM ORDERS AS O INNER JOIN CUSTOMERS C
ON O.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY O.CUSTOMER_ID,C.NAME
HAVING  MORE_THAN_2_ORDERS >= 2 ;

-- 15) Find the most frequently ordered book:

SELECT B.BOOK_ID,B.TITLE,COUNT(O.BOOK_ID) AS MOST_FREQ_ORD_BOOK
FROM ORDERS AS O INNER JOIN BOOKS AS B
ON O.BOOK_ID = B.BOOK_ID
GROUP BY O.BOOK_ID, B.TITLE
ORDER BY  MOST_FREQ_ORD_BOOK DESC
LIMIT 1;

-- 16) Show the top 3 most expensive books of 'Fantasy' Genre :

SELECT *
FROM  BOOKS 
WHERE GENRE = "FANTASY"
ORDER BY PRICE DESC
LIMIT 3;

-- 17) Retrieve the total quantity of books sold by each author:

SELECT B.AUTHOR,SUM(O.QUANTITY) AS TOTAL_BOOKS_SOLD
FROM ORDERS AS O INNER JOIN BOOKS AS B
ON O.BOOK_ID = B.BOOK_ID
GROUP BY B.AUTHOR;

-- 18) List the cities where customers who spent over $30 are located:

SELECT DISTINCT C.CITY , O.TOTAL_AMOUNT
FROM ORDERS AS O INNER JOIN CUSTOMERS AS C
ON O.CUSTOMER_ID = C.CUSTOMER_ID
WHERE O.TOTAL_AMOUNT > 30;

-- 19) Find the customer who spent the most on orders:

SELECT C.CUSTOMER_ID,C.NAME,ROUND(SUM(O.TOTAL_AMOUNT),2) AS TOTAL_SPENT
FROM ORDERS AS O INNER JOIN CUSTOMERS AS C
ON O.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY O.CUSTOMER_ID, C.NAME
ORDER BY TOTAL_SPENT DESC
LIMIT 1;

-- 20) Calculate the stock remaining after fulfilling all orders:

SELECT B.BOOK_ID, B.TITLE, B.STOCK, 
    COALESCE(SUM(O.QUANTITY), 0) AS QUANTITY_SOLD, 
    (B.STOCK - COALESCE(SUM(O.QUANTITY), 0)) AS REMAINING_STOCK
FROM BOOKS AS B
LEFT JOIN ORDERS AS O 
ON B.BOOK_ID = O.BOOK_ID
GROUP BY B.BOOK_ID, B.TITLE, B.STOCK
ORDER BY B.BOOK_ID;
