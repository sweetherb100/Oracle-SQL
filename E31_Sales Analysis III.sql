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

DROP TABLE Sales;
CREATE TABLE Sales (sale_id int, product_id int, year int, quantity int, price int);
TRUNCATE TABLE Sales;
INSERT ALL 
INTO Sales (sale_id, product_id, year, quantity, price) VALUES ('1', '100', '2008', '10', '5000')
INTO Sales (sale_id, product_id, year, quantity, price) VALUES ('2', '100', '2009', '12', '5000')
INTO Sales (sale_id, product_id, year, quantity, price) VALUES ('7', '200', '2011', '15', '9000')
SELECT * FROM DUAL;
SELECT * FROM Sales;

SELECT product_id,
min(year)
FROM sales
GROUP BY product_id;

SELECT S.product_id,
S.YEAR,
S.quantity,
S.price
FROM Sales S,
(
	SELECT product_id,
	min(year) min_year
	FROM sales
	GROUP BY product_id
) SS
WHERE S.product_id = SS.product_id
AND S.YEAR = SS.min_year

/*DROP TABLE Product;
CREATE TABLE Product (product_id int, product_name varchar(255));
TRUNCATE TABLE Product;
INSERT ALL 
INTO Product (product_id, product_name) VALUES ('100', 'Nokia')
INTO Product (product_id, product_name) VALUES ('200', 'Apple')
INTO Product (product_id, product_name) VALUES ('300', 'Samsung')
SELECT * FROM DUAL;
SELECT * FROM Product;*/