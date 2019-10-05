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
provides the customer ids from the Customer table that bought !!! all the products !!! in the Product table.

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

DROP TABLE CUSTOMER;
CREATE TABLE CUSTOMER (CUSTOMER_ID INT, PRODUCT_KEY INT);
TRUNCATE TABLE CUSTOMER;
INSERT ALL
INTO CUSTOMER (CUSTOMER_ID, PRODUCT_KEY) VALUES ('1', '5')
INTO CUSTOMER (CUSTOMER_ID, PRODUCT_KEY) VALUES ('2', '6')
INTO CUSTOMER (CUSTOMER_ID, PRODUCT_KEY) VALUES ('3', '5')
INTO CUSTOMER (CUSTOMER_ID, PRODUCT_KEY) VALUES ('3', '6')
INTO CUSTOMER (CUSTOMER_ID, PRODUCT_KEY) VALUES ('1', '6')
SELECT * FROM DUAL;
SELECT * FROM CUSTOMER;

DROP TABLE PRODUCT;
CREATE TABLE PRODUCT (PRODUCT_KEY INT);
TRUNCATE TABLE PRODUCT;
INSERT ALL
INTO PRODUCT (PRODUCT_KEY) VALUES ('5')
INTO PRODUCT (PRODUCT_KEY) VALUES ('6')
SELECT * FROM DUAL;
SELECT * FROM PRODUCT;

--STRATEGY: GET THE NUMBER OF PRODUCT_ID
--GROUP BY CUSTOMER_ID, CHECK WHETHER THE NUMBER OF THE COUNT MATCHES THE PRODUCT ID
SELECT CUSTOMER_ID
FROM CUSTOMER
GROUP BY CUSTOMER_ID
HAVING COUNT(CUSTOMER_ID) = (
							SELECT COUNT(PRODUCT_KEY) PRD_CNT
							FROM PRODUCT
							);