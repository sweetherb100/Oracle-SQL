/*Table: Sales
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
+------------+------------+----------+-------+*/

DROP TABLE SALES;
CREATE TABLE SALES (SALE_ID INT, PRODUCT_ID INT, YEAR INT, QUANTITY INT, PRICE INT);
TRUNCATE TABLE SALES;
INSERT ALL 
INTO SALES (SALE_ID, PRODUCT_ID, YEAR, QUANTITY, PRICE) VALUES ('1', '100', '2008', '10', '5000')
INTO SALES (SALE_ID, PRODUCT_ID, YEAR, QUANTITY, PRICE) VALUES ('2', '100', '2009', '12', '5000')
INTO SALES (SALE_ID, PRODUCT_ID, YEAR, QUANTITY, PRICE) VALUES ('7', '200', '2011', '15', '9000')
SELECT * FROM DUAL;
SELECT * FROM SALES;

/*DROP TABLE Product;
CREATE TABLE Product (product_id int, product_name varchar(255));
TRUNCATE TABLE Product;
INSERT ALL 
INTO Product (product_id, product_name) VALUES ('100', 'Nokia')
INTO Product (product_id, product_name) VALUES ('200', 'Apple')
INTO Product (product_id, product_name) VALUES ('300', 'Samsung')
SELECT * FROM DUAL;
SELECT * FROM Product;*/


--[METHOD 1]
SELECT PRODUCT_ID,
YEAR, 
QUANTITY, 
PRICE
FROM
(
	SELECT PRODUCT_ID,
	YEAR, 
	QUANTITY, 
	PRICE,
	RANK() OVER (PARTITION BY PRODUCT_ID ORDER BY YEAR) RNK_YEAR
	FROM SALES
)
WHERE RNK_YEAR=1;

--[METHOD 2]
SELECT S.PRODUCT_ID,
S.YEAR,
S.QUANTITY,
S.PRICE
FROM SALES S,
(
	SELECT PRODUCT_ID,
	MIN(YEAR) MIN_YEAR
	FROM SALES
	GROUP BY PRODUCT_ID
) SS
WHERE S.PRODUCT_ID = SS.PRODUCT_ID
AND S.YEAR = SS.MIN_YEAR;
