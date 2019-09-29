/*Table: Customer
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| customer_id | int     |
| product_key | int     |
+-------------+---------+
product_key is a foreign key to Product table.

Table: Product
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_key | int     |
+-------------+---------+
product_key is the primary key column for this table.

Write an SQL query for a report that :
provides the customer ids from the Customer table that bought all the products in the Product table.

For example:

Customer table:
+-------------+-------------+
| customer_id | product_key |
+-------------+-------------+
| 1           | 5           |
| 2           | 6           |
| 3           | 5           |
| 3           | 6           |
| 1           | 6           |
+-------------+-------------+

Product table:
+-------------+
| product_key |
+-------------+
| 5           |
| 6           |
+-------------+

Result table:
+-------------+
| customer_id |
+-------------+
| 1           |
| 3           |
+-------------+
The customers who bought all the products (5 and 6) are customers with id 1 and 3.*/

DROP TABLE Customer;
CREATE TABLE Customer (customer_id int, product_key int);
TRUNCATE TABLE Customer;
INSERT ALL
INTO Customer (customer_id, product_key) VALUES ('1', '5')
INTO Customer (customer_id, product_key) VALUES ('2', '6')
INTO Customer (customer_id, product_key) VALUES ('3', '5')
INTO Customer (customer_id, product_key) VALUES ('3', '6')
INTO Customer (customer_id, product_key) VALUES ('1', '6')
SELECT * FROM DUAL;
SELECT * FROM Customer;

DROP TABLE Product;
CREATE TABLE Product (product_key int);
TRUNCATE TABLE Product;
INSERT ALL
INTO Product (product_key) VALUES ('5')
INTO Product (product_key) VALUES ('6')
SELECT * FROM DUAL;
SELECT * FROM Product;

--my strategy: GET the NUMBER OF product_id
--GROUP BY customer_id, CHECK whether the NUMBER OF the count matches the product id

SELECT COUNT(product_key) PRD_CNT
FROM Product;

SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(customer_id) = (
							SELECT COUNT(product_key) PRD_CNT
							FROM Product
							);