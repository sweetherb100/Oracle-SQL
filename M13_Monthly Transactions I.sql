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

CREATE TABLE Transactions (id int, country varchar(255), state varchar(255), amount int, trans_date date);
TRUNCATE TABLE Transactions;
INSERT ALL
INTO Transactions (id, country, state, amount, trans_date) VALUES ('121', 'US', 'approved', '1000', TO_DATE('2018-12-18','YYYY-MM-DD'))
INTO Transactions (id, country, state, amount, trans_date) VALUES ('122', 'US', 'declined', '2000', TO_DATE('2018-12-19','YYYY-MM-DD'))
INTO Transactions (id, country, state, amount, trans_date) VALUES ('123', 'US', 'approved', '2000', TO_DATE('2019-01-01','YYYY-MM-DD'))
INTO Transactions (id, country, state, amount, trans_date) VALUES ('124', 'DE', 'approved', '2000', TO_DATE('2019-01-07','YYYY-MM-DD'))
SELECT * FROM DUAL;
SELECT * FROM Transactions;


--[METHOD 1] much shorter version
SELECT TO_CHAR(TRANS_DATE, 'YYYY-MM') AS MONTH,
country, 
COUNT(id) AS trans_count,
COUNT(CASE WHEN state = 'approved' THEN 1 END) approved_count,
SUM(amount) AS trans_total_amount,
SUM(CASE WHEN state = 'approved' THEN amount END) AS approved_total_amount
FROM TRANSACTIONS
GROUP BY country, TO_CHAR(TRANS_DATE, 'YYYY-MM')
ORDER BY MONTH


--[METHOD 2] longer version
SELECT TOT.MONTH,
TOT.country,
TOT.trans_count,
PART.approved_count,
TOT.trans_total_amount,
PART.approved_total_amount
FROM (
SELECT TO_CHAR(TRANS_DATE, 'YYYY-MM') AS MONTH,
country, 
COUNT(id) AS trans_count,
SUM(amount) AS trans_total_amount
FROM TRANSACTIONS
GROUP BY country, TO_CHAR(TRANS_DATE, 'YYYY-MM')
ORDER BY MONTH
) TOT,
(SELECT TO_CHAR(TRANS_DATE, 'YYYY-MM') AS MONTH,
country, 
COUNT(id) AS approved_count,
SUM(amount) AS approved_total_amount
FROM TRANSACTIONS
WHERE state = 'approved'
GROUP BY country, TO_CHAR(TRANS_DATE, 'YYYY-MM')
ORDER BY MONTH
) PART
WHERE TOT.MONTH = PART.MONTH
AND TOT.COUNTRY = PART.COUNTRY;
