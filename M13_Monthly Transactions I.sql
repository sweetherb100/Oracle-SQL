/*Table: Transactions
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id    		| int     |
| country     	| varchar |
| state    		| enum    |
| amount        | int     |
| trans_date    | date    |
+---------------+---------+   
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type [approved, reclined].

Write an SQL query to find for each month and country, 
the number of transactions and their total amount, the number of approved transactions and their total amount.

The query result format is in the following example:

Transactions table:
+------+---------+----------+--------+------------+
| id   | country | state    | amount | trans_date |
+------+---------+----------+--------+------------+
| 121  | US      | approved | 1000   | 2018-12-18 |
| 122  | US      | declined | 2000   | 2018-12-19 |
| 123  | US      | approved | 2000   | 2019-01-01 |
| 124  | DE      | approved | 2000   | 2019-01-07 |
+------+---------+----------+--------+------------+

Result table:
+----------+---------+-------------+----------------+--------------------+-----------------------+
| month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
+----------+---------+-------------+----------------+--------------------+-----------------------+
| 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |
+----------+---------+-------------+----------------+--------------------+-----------------------+*/

CREATE TABLE TRANSACTIONS (ID INT, COUNTRY VARCHAR(255), STATE VARCHAR(255), AMOUNT INT, TRANS_DATE DATE);
TRUNCATE TABLE TRANSACTIONS;
INSERT ALL
INTO TRANSACTIONS (ID, COUNTRY, STATE, AMOUNT, TRANS_DATE) VALUES ('121', 'US', 'APPROVED', '1000', TO_DATE('2018-12-18','YYYY-MM-DD'))
INTO TRANSACTIONS (ID, COUNTRY, STATE, AMOUNT, TRANS_DATE) VALUES ('122', 'US', 'DECLINED', '2000', TO_DATE('2018-12-19','YYYY-MM-DD'))
INTO TRANSACTIONS (ID, COUNTRY, STATE, AMOUNT, TRANS_DATE) VALUES ('123', 'US', 'APPROVED', '2000', TO_DATE('2019-01-01','YYYY-MM-DD'))
INTO TRANSACTIONS (ID, COUNTRY, STATE, AMOUNT, TRANS_DATE) VALUES ('124', 'DE', 'APPROVED', '2000', TO_DATE('2019-01-07','YYYY-MM-DD'))
SELECT * FROM DUAL;
SELECT * FROM TRANSACTIONS;


--[METHOD 1] much shorter version
SELECT TO_CHAR(TRANS_DATE, 'YYYY-MM') AS MONTH,
COUNTRY, 
COUNT(ID) AS TRANS_COUNT,
COUNT(CASE WHEN STATE = 'APPROVED' THEN 1 END) APPROVED_COUNT,
SUM(AMOUNT) AS TRANS_TOTAL_AMOUNT,
SUM(CASE WHEN STATE = 'APPROVED' THEN AMOUNT END) AS APPROVED_TOTAL_AMOUNT
FROM TRANSACTIONS
GROUP BY COUNTRY, TO_CHAR(TRANS_DATE, 'YYYY-MM')
ORDER BY MONTH;


--[METHOD 2] longer version (not recommended)
SELECT TOT.MONTH,
TOT.COUNTRY,
TOT.TRANS_COUNT,
PART.APPROVED_COUNT,
TOT.TRANS_TOTAL_AMOUNT,
PART.APPROVED_TOTAL_AMOUNT
FROM 
(
	SELECT TO_CHAR(TRANS_DATE, 'YYYY-MM') AS MONTH,
	COUNTRY, 
	COUNT(ID) AS TRANS_COUNT,
	SUM(AMOUNT) AS TRANS_TOTAL_AMOUNT
	FROM TRANSACTIONS
	GROUP BY COUNTRY, TO_CHAR(TRANS_DATE, 'YYYY-MM')
	ORDER BY MONTH
) TOT,
(
	SELECT TO_CHAR(TRANS_DATE, 'YYYY-MM') AS MONTH,
	COUNTRY, 
	COUNT(ID) AS APPROVED_COUNT,
	SUM(AMOUNT) AS APPROVED_TOTAL_AMOUNT
	FROM TRANSACTIONS
	WHERE STATE = 'APPROVED'
	GROUP BY COUNTRY, TO_CHAR(TRANS_DATE, 'YYYY-MM')
	ORDER BY MONTH
) 
PART
WHERE TOT.MONTH = PART.MONTH
AND TOT.COUNTRY = PART.COUNTRY; --PRIMARY KEYS (MONTH, COUNTRY) OF 2 TEMP TABLES SHOULD BE SAME, SO NO NEED FOR OUTER JOIN
