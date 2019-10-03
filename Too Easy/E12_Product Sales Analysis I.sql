/*
 * Reports all product names of the products in the Sales table along with their selling year and price
 * 
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

DROP TABLE SALES;
CREATE TABLE SALES (SALE_ID INT, PRODUCT_ID INT, YEAR INT, QUANTITY INT, PRICE INT);
TRUNCATE TABLE SALES;
INSERT ALL 
INTO SALES (SALE_ID, PRODUCT_ID, YEAR, QUANTITY, PRICE) VALUES ('1', '100', '2008', '10', '5000')
INTO SALES (SALE_ID, PRODUCT_ID, YEAR, QUANTITY, PRICE) VALUES ('2', '100', '2009', '12', '5000')
INTO SALES (SALE_ID, PRODUCT_ID, YEAR, QUANTITY, PRICE) VALUES ('7', '200', '2011', '15', '9000')
SELECT * FROM DUAL;
SELECT * FROM SALES;

DROP TABLE PRODUCT;
CREATE TABLE PRODUCT (PRODUCT_ID INT, PRODUCT_NAME VARCHAR(255));
TRUNCATE TABLE PRODUCT;
INSERT ALL 
INTO PRODUCT (PRODUCT_ID, PRODUCT_NAME) VALUES ('100', 'NOKIA')
INTO PRODUCT (PRODUCT_ID, PRODUCT_NAME) VALUES ('200', 'APPLE')
INTO PRODUCT (PRODUCT_ID, PRODUCT_NAME) VALUES ('300', 'SAMSUNG')
SELECT * FROM DUAL;
SELECT * FROM PRODUCT;



SELECT P.PRODUCT_NAME,
S.YEAR,
S.PRICE
FROM SALES S, PRODUCT P
WHERE S.PRODUCT_ID = P.PRODUCT_ID;