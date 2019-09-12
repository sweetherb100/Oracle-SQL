/*
Suppose that a website contains two tables, the Customers table and the Orders table. Write a SQL query to find all customers who never order anything.

Table: Customers.

+----+-------+
| Id | Name  |
+----+-------+
| 1  | Joe   |
| 2  | Henry |
| 3  | Sam   |
| 4  | Max   |
+----+-------+
Table: Orders.

+----+------------+
| Id | CustomerId |
+----+------------+
| 1  | 3          |
| 2  | 1          |
+----+------------+
Using the above tables as example, return the following:

+-----------+
| Customers |
+-----------+
| Henry     |
| Max       |
+-----------+
*/

CREATE TABLE Customers (Id int, Name varchar(255));
CREATE TABLE Orders (Id int, CustomerId int);
TRUNCATE TABLE Customers;
INSERT ALL
INTO Customers (Id, Name) VALUES ('1', 'Joe')
INTO Customers (Id, Name) VALUES ('2', 'Henry')
INTO Customers (Id, Name) VALUES ('3', 'Sam')
INTO Customers (Id, Name) VALUES ('4', 'Max')
SELECT * FROM DUAL;

Truncate table Orders;
INSERT ALL
INTO Orders (Id, CustomerId) VALUES ('1', '3')
INTO Orders (Id, CustomerId) VALUES ('2', '1')
SELECT * FROM DUAL;



--[METHOD 1]
SELECT C.Name AS Customers
FROM Customers C, Orders O
WHERE 1=1
AND C.Id = O.CustomerId  (+)
AND O.CustomerId IS NULL -- WRONG SYNTAX: = NULL


--[METHOD 2] USE "NOT IN" (or "NOT EXISTS")
SELECT C.Name AS Customers
FROM Customers C
WHERE 1=1
AND C.Id NOT IN (SELECT E.customerid 
                 FROM Orders E )
