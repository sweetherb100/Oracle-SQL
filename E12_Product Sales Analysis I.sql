/*
 * Reports all product names of the products in the Sales table along with their selling year and price
Sales table:
+---------+------------+------+----------+-------+
| sale_id | product_id | year | quantity | price |
+---------+------------+------+----------+-------+ 
| 1       | 100        | 2008 | 10       | 5000  |
| 2       | 100        | 2009 | 12       | 5000  |
| 7       | 200        | 2011 | 15       | 9000  |
+---------+------------+------+----------+-------+

Product table:
+------------+--------------+
| product_id | product_name |
+------------+--------------+
| 100        | Nokia        |
| 200        | Apple        |
| 300        | Samsung      |
+------------+--------------+

Result table:
+--------------+-------+-------+
| product_name | year  | price |
+--------------+-------+-------+
| Nokia        | 2008  | 5000  |
| Nokia        | 2009  | 5000  |
| Apple        | 2011  | 9000  |
+--------------+-------+-------+*/

DROP TABLE Sales;
CREATE TABLE Sales (sale_id int, product_id int, year int, quantity int, price int);
TRUNCATE TABLE Sales;
INSERT ALL 
INTO Sales (sale_id, product_id, year, quantity, price) VALUES ('1', '100', '2008', '10', '5000')
INTO Sales (sale_id, product_id, year, quantity, price) VALUES ('2', '100', '2009', '12', '5000')
INTO Sales (sale_id, product_id, year, quantity, price) VALUES ('7', '200', '2011', '15', '9000')
SELECT * FROM DUAL;
SELECT * FROM Sales;

DROP TABLE Product;
CREATE TABLE Product (product_id int, product_name varchar(255));
TRUNCATE TABLE Product;
INSERT ALL 
INTO Product (product_id, product_name) VALUES ('100', 'Nokia')
INTO Product (product_id, product_name) VALUES ('200', 'Apple')
INTO Product (product_id, product_name) VALUES ('300', 'Samsung')
SELECT * FROM DUAL;
SELECT * FROM Product;



SELECT P.product_name,
S.YEAR,
S.price
FROM Sales S, Product P
WHERE S.product_id = P.product_id; --DONT NEED LEFT OUTER JOIN