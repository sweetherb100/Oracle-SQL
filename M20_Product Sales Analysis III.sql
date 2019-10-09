/*
Table: Sales
+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+
sale_id is the primary key of this table.
product_id is a foreign key to Product table.
Note that the price is per unit.

Table: Product
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
+--------------+---------+
product_id is the primary key of this table.

Write an SQL query that selects the product id, year, quantity, and price for the first year of every product sold.

The query result format is in the following example:

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
+------------+------------+----------+-------+
| product_id | first_year | quantity | price |
+------------+------------+----------+-------+ 
| 100        | 2008       | 10       | 5000  |
| 200        | 2011       | 15       | 9000  |
+------------+------------+----------+-------+

Result table: [recommendation]
+------------+------------+----------+-------+
| product_id | first_year | quantity | price |
+------------+------------+----------+-------+ 
| 100        | 2008       | 10       | 5000  |
| 200        | 2011       | 15       | 9000  |
| 300        |            |          |       |
+------------+------------+----------+-------+
*/

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


SELECT *
FROM
(
	SELECT PRODUCT_ID,
	YEAR, 
	QUANTITY,
	PRICE,
	RANK() OVER (PARTITION BY PRODUCT_ID ORDER BY YEAR) RNK_YEAR
	FROM SALES
)
WHERE RNK_YEAR = 1;

--[METHOD 1]
SELECT P.PRODUCT_ID,
S.YEAR,
S.QUANTITY,
S.PRICE
FROM
PRODUCT P,
(
	SELECT *
	FROM
	(
		SELECT PRODUCT_ID,
		YEAR, 
		QUANTITY,
		PRICE,
		RANK() OVER (PARTITION BY PRODUCT_ID ORDER BY YEAR) RNK_YEAR
		FROM SALES
	)
	WHERE RNK_YEAR = 1
) S
WHERE P.PRODUCT_ID = S.PRODUCT_ID (+); --OUTER JOIN


--[METHOD 2]
-- recommendation result
SELECT P.PRODUCT_ID, --THIS SHOULD BE P NOT PP (CAREFUL!)
PP.YEAR,
PP.QUANTITY,
PP.PRICE
FROM PRODUCT P,
(
	SELECT S.PRODUCT_ID, 
	S.YEAR, 
	S.QUANTITY, 
	S.PRICE
	FROM SALES S,
	(
		SELECT PRODUCT_ID,
		MIN(YEAR) YEAR
		FROM SALES
		GROUP BY PRODUCT_ID
	) SS
	WHERE S.PRODUCT_ID = SS.PRODUCT_ID
	AND S.YEAR = SS.YEAR
) PP
WHERE P.PRODUCT_ID = PP.PRODUCT_ID (+); --OUTER JOIN