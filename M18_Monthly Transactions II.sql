/*
Table: Transactions
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| id             | int     |
| country        | varchar |
| state          | enum    |
| amount         | int     |
| trans_date     | date    |
+----------------+---------+
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type ["approved", "declined"].

Table: Chargebacks
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| trans_id       | int     |
| charge_date    | date    |
+----------------+---------+
Chargebacks contains basic information regarding incoming chargebacks from some transactions placed in Transactions table.
trans_id is a foreign key to the id column of Transactions table.
Each chargeback corresponds to a transaction made previously even if they were not approved.

Write an SQL query to find for each month and country, the number of approved transactions and their total amount, 
the number of chargebacks and their total amount.

Note: In your query, given the month and country, ignore rows with all zeros.

The query result format is in the following example:

Transactions table:
+------+---------+----------+--------+------------+
| id   | country | state    | amount | trans_date |
+------+---------+----------+--------+------------+
| 101  | US      | approved | 1000   | 2019-05-18 |
| 102  | US      | declined | 2000   | 2019-05-19 |
| 103  | US      | approved | 3000   | 2019-06-10 |
| 104  | US      | approved | 4000   | 2019-06-13 |
| 105  | US      | approved | 5000   | 2019-06-15 |
+------+---------+----------+--------+------------+

Chargebacks table:
+------------+------------+
| trans_id   | trans_date |
+------------+------------+
| 102        | 2019-05-29 |
| 101        | 2019-06-30 |
| 105        | 2019-09-18 |
+------------+------------+

Result table:
+----------+---------+----------------+-----------------+-------------------+--------------------+
| month    | country | approved_count | approved_amount | chargeback_count  | chargeback_amount  |
+----------+---------+----------------+-----------------+-------------------+--------------------+
| 2019-05  | US      | 1              | 1000            | 1                 | 2000               |
| 2019-06  | US      | 3              | 12000           | 1                 | 1000               |
| 2019-09  | US      | 0              | 0               | 1                 | 5000               |
+----------+---------+----------------+-----------------+-------------------+--------------------+
*/

DROP TABLE TRANSACTIONS;
CREATE TABLE TRANSACTIONS (ID INT, COUNTRY VARCHAR(255), STATE VARCHAR(255), AMOUNT INT, TRANS_DATE DATE);
TRUNCATE TABLE TRANSACTIONS;
INSERT ALL
INTO TRANSACTIONS (ID, COUNTRY, STATE, AMOUNT, TRANS_DATE) VALUES ('101', 'US', 'APPROVED', '1000', TO_DATE('2019-05-18','YYYY-MM-DD')) --2019-05-18
INTO TRANSACTIONS (ID, COUNTRY, STATE, AMOUNT, TRANS_DATE) VALUES ('102', 'US', 'DECLINED', '2000', TO_DATE('2019-05-19','YYYY-MM-DD'))
INTO TRANSACTIONS (ID, COUNTRY, STATE, AMOUNT, TRANS_DATE) VALUES ('103', 'US', 'APPROVED', '3000', TO_DATE('2019-06-10','YYYY-MM-DD'))
INTO TRANSACTIONS (ID, COUNTRY, STATE, AMOUNT, TRANS_DATE) VALUES ('104', 'US', 'APPROVED', '4000', TO_DATE('2019-06-13','YYYY-MM-DD'))
INTO TRANSACTIONS (ID, COUNTRY, STATE, AMOUNT, TRANS_DATE) VALUES ('105', 'US', 'APPROVED', '5000', TO_DATE('2019-06-15','YYYY-MM-DD'))
SELECT * FROM DUAL;
SELECT * FROM TRANSACTIONS;

DROP TABLE CHARGEBACKS;
CREATE TABLE CHARGEBACKS (TRANS_ID INT, CHARGE_DATE DATE);
TRUNCATE TABLE CHARGEBACKS;
INSERT ALL
INTO CHARGEBACKS (TRANS_ID, CHARGE_DATE) VALUES ('102', TO_DATE('2019-05-29','YYYY-MM-DD'))
INTO CHARGEBACKS (TRANS_ID, CHARGE_DATE) VALUES ('101', TO_DATE('2019-06-30','YYYY-MM-DD'))
INTO CHARGEBACKS (TRANS_ID, CHARGE_DATE) VALUES ('105', TO_DATE('2019-09-18','YYYY-MM-DD'))
SELECT * FROM DUAL;
SELECT * FROM CHARGEBACKS;

--[METHOD 1]
--JOIN1
SELECT TO_CHAR(TRANS_DATE, 'YYYY-MM') MONTH,
COUNTRY,
COUNT(CASE WHEN STATE='APPROVED' THEN 1 END) APPROVED_COUNT,
SUM(CASE WHEN STATE='APPROVED' THEN AMOUNT END) APPROVED_AMOUNT
FROM TRANSACTIONS
GROUP BY COUNTRY, TO_CHAR(TRANS_DATE, 'YYYY-MM');

SELECT T.COUNTRY,
C.CHARGE_DATE,
T.AMOUNT
FROM TRANSACTIONS T,
CHARGEBACKS C
WHERE T.ID = C.TRANS_ID;


--JOIN2
SELECT TO_CHAR(C.CHARGE_DATE, 'YYYY-MM') MONTH,
T.COUNTRY,
COUNT(1) CHARGEBACK_COUNT,
SUM(T.AMOUNT) CHARGEBACK_AMOUNT
FROM TRANSACTIONS T,
CHARGEBACKS C
WHERE T.ID = C.TRANS_ID
GROUP BY T.COUNTRY, TO_CHAR(C.CHARGE_DATE, 'YYYY-MM');

--FINAL
SELECT NVL(T1.MONTH, T2.MONTH) MONTH,
NVL(T1.COUNTRY, T2.COUNTRY) COUNTRY,
NVL(T1.APPROVED_COUNT, 0) APPROVED_COUNT,
NVL(T1.APPROVED_AMOUNT, 0) APPROVED_AMOUNT,
NVL(T2.CHARGEBACK_COUNT, 0) CHARGEBACK_COUNT,
NVL(T2.CHARGEBACK_AMOUNT, 0) CHARGEBACK_AMOUNT
FROM
(
	SELECT TO_CHAR(TRANS_DATE, 'YYYY-MM') MONTH,
	COUNTRY,
	COUNT(CASE WHEN STATE='APPROVED' THEN 1 END) APPROVED_COUNT,
	SUM(CASE WHEN STATE='APPROVED' THEN AMOUNT END) APPROVED_AMOUNT
	FROM TRANSACTIONS
	GROUP BY COUNTRY, TO_CHAR(TRANS_DATE, 'YYYY-MM')
) T1 FULL OUTER JOIN
(
	SELECT TO_CHAR(C.CHARGE_DATE, 'YYYY-MM') MONTH,
	T.COUNTRY,
	COUNT(1) CHARGEBACK_COUNT,
	SUM(T.AMOUNT) CHARGEBACK_AMOUNT
	FROM TRANSACTIONS T,
	CHARGEBACKS C
	WHERE T.ID = C.TRANS_ID
	GROUP BY T.COUNTRY, TO_CHAR(C.CHARGE_DATE, 'YYYY-MM')
) T2
ON T1.MONTH = T2.MONTH
AND T1.COUNTRY = T2.COUNTRY;


--[METHOD 2]
--JOIN 1
SELECT TO_CHAR(TRANS_DATE, 'YYYY-MM') MONTH,
COUNTRY,
COUNT(AMOUNT) APPROVED_COUNT,
SUM(AMOUNT) APPROVED_AMOUNT
FROM TRANSACTIONS
WHERE STATE = 'APPROVED'
GROUP BY COUNTRY, TO_CHAR(TRANS_DATE, 'YYYY-MM')
ORDER BY TO_CHAR(TRANS_DATE, 'YYYY-MM');


SELECT C.TRANS_ID,
TO_CHAR(C.CHARGE_DATE, 'YYYY-MM') CHARGE_DATE,
T.COUNTRY,
T.AMOUNT
FROM CHARGEBACKS C,
TRANSACTIONS T
WHERE T.ID = C.TRANS_ID;


--JOIN 2
SELECT TO_CHAR(C.CHARGE_DATE, 'YYYY-MM') CHARGE_DATE,
T.COUNTRY,
COUNT(T.AMOUNT) CHARGEBACK_COUNT,
SUM(T.AMOUNT) CHARGEBACK_AMOUNT
FROM CHARGEBACKS C,
TRANSACTIONS T
WHERE T.ID = C.TRANS_ID
GROUP BY T.COUNTRY, TO_CHAR(C.CHARGE_DATE, 'YYYY-MM')
ORDER BY TO_CHAR(C.CHARGE_DATE, 'YYYY-MM');


--FULL OUTER JOIN
SELECT *
FROM 
(
	SELECT TO_CHAR(TRANS_DATE, 'YYYY-MM') MONTH,
	COUNTRY,
	COUNT(AMOUNT) APPROVED_COUNT,
	SUM(AMOUNT) APPROVED_AMOUNT
	FROM TRANSACTIONS
	WHERE STATE = 'APPROVED'
	GROUP BY COUNTRY, TO_CHAR(TRANS_DATE, 'YYYY-MM')
	ORDER BY TO_CHAR(TRANS_DATE, 'YYYY-MM')
) L
FULL OUTER JOIN
(
	SELECT TO_CHAR(C.CHARGE_DATE, 'YYYY-MM') MONTH,
	T.COUNTRY,
	COUNT(T.AMOUNT) CHARGEBACK_COUNT,
	SUM(T.AMOUNT) CHARGEBACK_AMOUNT
	FROM CHARGEBACKS C,
	TRANSACTIONS T
	WHERE T.ID = C.TRANS_ID
	GROUP BY T.COUNTRY, TO_CHAR(C.CHARGE_DATE, 'YYYY-MM')
	ORDER BY TO_CHAR(C.CHARGE_DATE, 'YYYY-MM')
) R
ON (L.MONTH = R.MONTH
AND L.COUNTRY = R.COUNTRY);


--FINAL: WITH NVL
SELECT NVL(L.MONTH, R.MONTH) MONTH,
NVL(L.COUNTRY, R.COUNTRY) COUNTRY,
NVL(L.APPROVED_COUNT, 0) APPROVED_COUNT,
NVL(L.APPROVED_AMOUNT, 0) APPROVED_AMOUNT,
NVL(R.CHARGEBACK_COUNT, 0) CHARGEBACK_COUNT,
NVL(R.CHARGEBACK_AMOUNT, 0) CHARGEBACK_AMOUNT
FROM 
(
	SELECT TO_CHAR(TRANS_DATE, 'YYYY-MM') MONTH,
	COUNTRY,
	COUNT(AMOUNT) APPROVED_COUNT,
	SUM(AMOUNT) APPROVED_AMOUNT
	FROM TRANSACTIONS
	WHERE STATE = 'APPROVED'
	GROUP BY COUNTRY, TO_CHAR(TRANS_DATE, 'YYYY-MM')
	ORDER BY TO_CHAR(TRANS_DATE, 'YYYY-MM')
) L
FULL OUTER JOIN
(
	SELECT TO_CHAR(C.CHARGE_DATE, 'YYYY-MM') MONTH,
	T.COUNTRY,
	COUNT(T.AMOUNT) CHARGEBACK_COUNT,
	SUM(T.AMOUNT) CHARGEBACK_AMOUNT
	FROM CHARGEBACKS C,
	TRANSACTIONS T
	WHERE T.ID = C.TRANS_ID
	GROUP BY T.COUNTRY, TO_CHAR(C.CHARGE_DATE, 'YYYY-MM')
	ORDER BY TO_CHAR(C.CHARGE_DATE, 'YYYY-MM')
) R
ON (L.MONTH = R.MONTH AND L.COUNTRY = R.COUNTRY);
