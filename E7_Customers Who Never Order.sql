/*
Suppose that a website contains two tables, the Customers table and the Orders table. 
Write a SQL query to find all customers who never order anything.

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

CREATE TABLE CUSTOMERS (ID INT, NAME VARCHAR(255));
CREATE TABLE ORDERS (ID INT, CUSTOMERID INT);
TRUNCATE TABLE CUSTOMERS;
INSERT ALL
INTO CUSTOMERS (ID, NAME) VALUES ('1', 'JOE')
INTO CUSTOMERS (ID, NAME) VALUES ('2', 'HENRY')
INTO CUSTOMERS (ID, NAME) VALUES ('3', 'SAM')
INTO CUSTOMERS (ID, NAME) VALUES ('4', 'MAX')
SELECT * FROM DUAL;

TRUNCATE TABLE ORDERS;
INSERT ALL
INTO ORDERS (ID, CUSTOMERID) VALUES ('1', '3')
INTO ORDERS (ID, CUSTOMERID) VALUES ('2', '1')
SELECT * FROM DUAL;




--USE "NOT IN"
SELECT C.NAME AS CUSTOMERS
FROM CUSTOMERS C
WHERE 1=1
AND C.ID NOT IN (SELECT E.CUSTOMERID 
                 FROM ORDERS E );
