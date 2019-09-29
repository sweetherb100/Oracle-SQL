/*Table: Products
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
(product_id, change_date) is the primary key of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.

Write an SQL query to find the prices of all products on 2019-08-16. 
Assume the price of all products before any change is 10.

The query result format is in the following example:

Products table:
+------------+-----------+-------------+
| product_id | new_price | change_date |
+------------+-----------+-------------+
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |
+------------+-----------+-------------+

Result table:
+------------+-------+
| product_id | price |
+------------+-------+
| 2          | 50    |
| 1          | 35    |
| 3          | 10    |
+------------+-------+*/

CREATE TABLE Products (product_id int, new_price int, change_date date);
TRUNCATE TABLE Products;
INSERT ALL
INTO Products (product_id, new_price, change_date) VALUES ('1', '20', TO_DATE('2019-08-14','YYYY-MM-DD'))
INTO Products (product_id, new_price, change_date) VALUES ('2', '50', TO_DATE('2019-08-14','YYYY-MM-DD'))
INTO Products (product_id, new_price, change_date) VALUES ('1', '30', TO_DATE('2019-08-15','YYYY-MM-DD'))
INTO Products (product_id, new_price, change_date) VALUES ('1', '35', TO_DATE('2019-08-16','YYYY-MM-DD'))
INTO Products (product_id, new_price, change_date) VALUES ('2', '65', TO_DATE('2019-08-17','YYYY-MM-DD'))
INTO Products (product_id, new_price, change_date) VALUES ('3', '20', TO_DATE('2019-08-18','YYYY-MM-DD'))
SELECT * FROM DUAL;
SELECT * FROM Products;

SELECT product_id
FROM Products
GROUP BY product_id;

--strategy: get the last date and if it is <= 16 (i.e. changed) => select that new_price
-- if the last date is > 16, default 10 NOOOOOOOOOOOOO
-- it could be that there is some date <= 16
-- then lets check that the first one is <= 16, if not its default is 10


SELECT *
FROM Products
WHERE change_date <= TO_DATE('2019-08-16','YYYY-MM-DD')
--GROUP BY PRODUCT_ID
ORDER BY PRODUCT_ID, change_date; 

--I JUST WANT TO GET new_price of that changed_date but do I have to make temp table every time I want to do like this???
SELECT P.PRODUCT_ID,
P.NEW_PRICE,
T.MAX_DATE
FROM PRODUCTS P,
	(
	SELECT PRODUCT_ID,
	MAX(CHANGE_DATE) MAX_DATE
	FROM PRODUCTS
	WHERE CHANGE_DATE <= TO_DATE('2019-08-16','YYYY-MM-DD')
	GROUP BY PRODUCT_ID
	) T
WHERE P.PRODUCT_ID = T.PRODUCT_ID
AND P.CHANGE_DATE = T.MAX_DATE;


--FINAL BUT I DON'T LIKE IT
SELECT P1.PRODUCT_ID, 
NVL(P2.NEW_PRICE, '10') PRICE
FROM 
	(
	SELECT product_id
	FROM Products
	GROUP BY product_id
	) P1,
	
	(
	SELECT P.PRODUCT_ID,
	P.NEW_PRICE,
	T.MAX_DATE
	FROM PRODUCTS P,
		(
		SELECT PRODUCT_ID,
		MAX(CHANGE_DATE) MAX_DATE
		FROM PRODUCTS
		WHERE CHANGE_DATE <= TO_DATE('2019-08-16','YYYY-MM-DD')
		GROUP BY PRODUCT_ID
		) T
	WHERE P.PRODUCT_ID = T.PRODUCT_ID
	AND P.CHANGE_DATE = T.MAX_DATE
	) P2
	
WHERE P1.PRODUCT_ID = P2.PRODUCT_ID (+)
ORDER BY PRICE DESC;


---YULKYU
--ROW_NUMBER() USED ALOT! RECOMMENDED!!!
SELECT P1.PRODUCT_ID
        , NVL(P2.NEW_PRICE, '10') AS PRICE
 FROM
        (
         SELECT PRODUCT_ID
          FROM PRODUCTS
         GROUP BY PRODUCT_ID
        ) P1,
        (
         SELECT P.PRODUCT_ID
                 , P.NEW_PRICE
         FROM
                (
                 SELECT P.PRODUCT_ID
                         , P.NEW_PRICE
                         , ROW_NUMBER() OVER (PARTITION BY P.PRODUCT_ID ORDER BY P.CHANGE_DATE DESC) RN
                  FROM PRODUCTS P 
                 WHERE P.CHANGE_DATE <= TO_DATE('20190816', 'YYYYMMDD')
                ) P
         WHERE P.RN = 1
        ) P2
WHERE P1.PRODUCT_ID = P2.PRODUCT_ID (+)
ORDER BY PRICE DESC;
