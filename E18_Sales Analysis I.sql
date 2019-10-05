/*Table: Product
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
| unit_price   | int     |
+--------------+---------+
product_id is the primary key of this table.

Table: Sales
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| seller_id   | int     |
| product_id  | int     |
| buyer_id    | int     |
| sale_date   | date    |
| quantity    | int     |
| price       | int     |
+------ ------+---------+
This table has no primary key, it can have repeated rows.
product_id is a foreign key to Product table.

Write an SQL query that reports the best seller by total sales price, If there is a tie, report them all.

The query result format is in the following example:

Product table:
+------------+--------------+------------+
| product_id | product_name | unit_price |
+------------+--------------+------------+
| 1          | S8           | 1000       |
| 2          | G4           | 800        |
| 3          | iPhone       | 1400       |
+------------+--------------+------------+

Sales table:
+-----------+------------+----------+------------+----------+-------+
| seller_id | product_id | buyer_id | sale_date  | quantity | price |
+-----------+------------+----------+------------+----------+-------+
| 1         | 1          | 1        | 2019-01-21 | 2        | 2000  |
| 1         | 2          | 2        | 2019-02-17 | 1        | 800   |
| 2         | 2          | 3        | 2019-06-02 | 1        | 800   |
| 3         | 3          | 4        | 2019-05-13 | 2        | 2800  |
+-----------+------------+----------+------------+----------+-------+

Result table:
+-------------+
| seller_id   |
+-------------+
| 1           |
| 3           |
+-------------+
Both sellers with id 1 and 3 sold products with the most total price of 2800.*/

/*DROP TABLE Product;
CREATE TABLE Product (product_id int, product_name varchar(255), unit_price int);
TRUNCATE TABLE Product;
INSERT ALL
INTO Product (product_id, product_name, unit_price) VALUES ('1', 'S8', '1000')
INTO Product (product_id, product_name, unit_price) VALUES ('2', 'G4', '800')
INTO Product (product_id, product_name, unit_price) VALUES ('3', 'iPhone','1400')
SELECT * FROM DUAL;
SELECT * FROM Product;*/

DROP TABLE Sales;
CREATE TABLE Sales (seller_id int, product_id int, buyer_id int, sale_date date, quantity int, price int);
TRUNCATE TABLE Sales;
INSERT ALL
INTO Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) VALUES ('1', '1', '1', TO_DATE('2019-01-21','YYYY-MM-DD'), '2', '2000')
INTO Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) VALUES ('1', '2', '2', TO_DATE('2019-01-17','YYYY-MM-DD'), '1', '800')
INTO Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) VALUES ('2', '2', '3', TO_DATE('2019-01-02','YYYY-MM-DD'), '1', '800')
INTO Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) VALUES ('3', '3', '4', TO_DATE('2019-01-13','YYYY-MM-DD'), '2', '2800')
SELECT * FROM DUAL;
SELECT * FROM Sales;

 -- Keep in mind that there might be a tie
 --[METHOD 1]
SELECT S.SELLER_ID,
		SUM(S.PRICE) TOT_PRICE
FROM SALES S
GROUP BY S.SELLER_ID
HAVING SUM(S.PRICE)= (SELECT MAX(SUM(PRICE)) MAX_PRICE
					FROM SALES
					GROUP BY SELLER_ID);

--[METHOD 2] RANK()
SELECT SELLER_ID,
TOT_PRICE
FROM
(
	SELECT SELLER_ID,
	TOT_PRICE,
	DENSE_RANK() OVER (ORDER BY TOT_PRICE DESC) DRK,
	RANK() OVER (ORDER BY TOT_PRICE DESC) RK,
	ROW_NUMBER () OVER (ORDER BY TOT_PRICE DESC) AS RNUM
	FROM
	(
		SELECT SELLER_ID,
		SUM(PRICE) TOT_PRICE
		FROM SALES
		GROUP BY SELLER_ID
	)
)
WHERE RK=1;
