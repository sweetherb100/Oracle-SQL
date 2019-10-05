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

CREATE TABLE PRODUCTS (PRODUCT_ID INT, NEW_PRICE INT, CHANGE_DATE DATE);
TRUNCATE TABLE PRODUCTS;
INSERT ALL
INTO PRODUCTS (PRODUCT_ID, NEW_PRICE, CHANGE_DATE) VALUES ('1', '20', TO_DATE('2019-08-14','YYYY-MM-DD'))
INTO PRODUCTS (PRODUCT_ID, NEW_PRICE, CHANGE_DATE) VALUES ('2', '50', TO_DATE('2019-08-14','YYYY-MM-DD'))
INTO PRODUCTS (PRODUCT_ID, NEW_PRICE, CHANGE_DATE) VALUES ('1', '30', TO_DATE('2019-08-15','YYYY-MM-DD'))
INTO PRODUCTS (PRODUCT_ID, NEW_PRICE, CHANGE_DATE) VALUES ('1', '35', TO_DATE('2019-08-16','YYYY-MM-DD'))
INTO PRODUCTS (PRODUCT_ID, NEW_PRICE, CHANGE_DATE) VALUES ('2', '65', TO_DATE('2019-08-17','YYYY-MM-DD'))
INTO PRODUCTS (PRODUCT_ID, NEW_PRICE, CHANGE_DATE) VALUES ('3', '20', TO_DATE('2019-08-18','YYYY-MM-DD'))
SELECT * FROM DUAL;
SELECT * FROM PRODUCTS;


SELECT PRODUCT_ID,
NEW_PRICE,
CHANGE_DATE,
RANK() OVER (PARTITION BY PRODUCT_ID ORDER BY CHANGE_DATE DESC) RECENT_DATE
FROM PRODUCTS
WHERE CHANGE_DATE <= TO_DATE('2019-08-16','YYYY-MM-DD');


--[METHOD 1]
SELECT P.PRODUCT_ID,
NVL(PP.NEW_PRICE, 10) price
FROM 
(
	SELECT DISTINCT PRODUCT_ID
	FROM PRODUCTS
) P, -- ONLY TO SELECT DISTINCT PRODUCT_ID
(
	SELECT *
	FROM
	(
		SELECT PRODUCT_ID,
		NEW_PRICE,
		CHANGE_DATE,
		RANK() OVER (PARTITION BY PRODUCT_ID ORDER BY CHANGE_DATE DESC) RECENT_DATE
		FROM PRODUCTS
		WHERE CHANGE_DATE <= TO_DATE('2019-08-16','YYYY-MM-DD')
	)
	WHERE RECENT_DATE =1
) PP
WHERE P.PRODUCT_ID = PP.PRODUCT_ID (+); --OUTER JOIN


---[METHOD 2] YULKYU: ROW_NUMBER() USED ALOT
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
