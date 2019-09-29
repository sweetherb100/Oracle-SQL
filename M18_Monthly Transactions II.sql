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

DROP TABLE Transactions;
CREATE TABLE Transactions (id int, country varchar(255), state varchar(255), amount int, trans_date date);
TRUNCATE TABLE Transactions;
INSERT ALL
INTO Transactions (id, country, state, amount, trans_date) VALUES ('101', 'US', 'approved', '1000', TO_DATE('2019-05-18','YYYY-MM-DD')) --2019-05-18
INTO Transactions (id, country, state, amount, trans_date) VALUES ('102', 'US', 'declined', '2000', TO_DATE('2019-05-19','YYYY-MM-DD'))
INTO Transactions (id, country, state, amount, trans_date) VALUES ('103', 'US', 'approved', '3000', TO_DATE('2019-06-10','YYYY-MM-DD'))
INTO Transactions (id, country, state, amount, trans_date) VALUES ('104', 'US', 'approved', '4000', TO_DATE('2019-06-13','YYYY-MM-DD'))
INTO Transactions (id, country, state, amount, trans_date) VALUES ('105', 'US', 'approved', '5000', TO_DATE('2019-06-15','YYYY-MM-DD'))
SELECT * FROM DUAL;
SELECT * FROM Transactions;

DROP TABLE Chargebacks;
CREATE TABLE Chargebacks (trans_id int, charge_date date);
TRUNCATE TABLE Chargebacks;
INSERT ALL
INTO Chargebacks (trans_id, charge_date) VALUES ('102', TO_DATE('2019-05-29','YYYY-MM-DD'))
INTO Chargebacks (trans_id, charge_date) VALUES ('101', TO_DATE('2019-06-30','YYYY-MM-DD'))
INTO Chargebacks (trans_id, charge_date) VALUES ('105', TO_DATE('2019-09-18','YYYY-MM-DD'))
SELECT * FROM DUAL;
SELECT * FROM Chargebacks;

--join 1
SELECT TO_CHAR(TRANS_DATE, 'YYYY-MM') month,
country,
count(amount) approved_count,
sum(amount) approved_amount
FROM TRANSACTIONS
WHERE state = 'approved'
GROUP BY country, TO_CHAR(TRANS_DATE, 'YYYY-MM')
ORDER BY TO_CHAR(TRANS_DATE, 'YYYY-MM');


SELECT C.trans_id,
TO_CHAR(C.charge_date, 'YYYY-MM') CHARGE_DATE,
T.country,
T.amount
FROM Chargebacks C,
TRANSACTIONS T
WHERE T.id = C.trans_id;


--join 2
SELECT TO_CHAR(C.charge_date, 'YYYY-MM') CHARGE_DATE,
T.country,
count(T.amount) chargeback_count,
sum(T.amount) chargeback_amount
FROM Chargebacks C,
TRANSACTIONS T
WHERE T.id = C.trans_id
GROUP BY T.country, TO_CHAR(C.charge_date, 'YYYY-MM')
ORDER BY TO_CHAR(C.charge_date, 'YYYY-MM');


--full outer join
SELECT *
FROM 
(
SELECT TO_CHAR(TRANS_DATE, 'YYYY-MM') month,
country,
count(amount) approved_count,
sum(amount) approved_amount
FROM TRANSACTIONS
WHERE state = 'approved'
GROUP BY country, TO_CHAR(TRANS_DATE, 'YYYY-MM')
ORDER BY TO_CHAR(TRANS_DATE, 'YYYY-MM')
) L
FULL OUTER join
(
SELECT TO_CHAR(C.charge_date, 'YYYY-MM') month,
T.country,
count(T.amount) chargeback_count,
sum(T.amount) chargeback_amount
FROM Chargebacks C,
TRANSACTIONS T
WHERE T.id = C.trans_id
GROUP BY T.country, TO_CHAR(C.charge_date, 'YYYY-MM')
ORDER BY TO_CHAR(C.charge_date, 'YYYY-MM')
) R
ON (L.MONTH = R.MONTH
AND L.country = R.country);


--FINAL: with NVL
SELECT NVL(L.MONTH, R.month) MONTH,
nvl(L.country, R.country) country,
nvl(L.approved_count, 0) approved_count,
nvl(L.approved_amount, 0) approved_amount,
nvl(R.chargeback_count, 0) chargeback_count,
nvl(R.chargeback_amount, 0) chargeback_amount
FROM 
(
SELECT TO_CHAR(TRANS_DATE, 'YYYY-MM') month,
country,
count(amount) approved_count,
sum(amount) approved_amount
FROM TRANSACTIONS
WHERE state = 'approved'
GROUP BY country, TO_CHAR(TRANS_DATE, 'YYYY-MM')
ORDER BY TO_CHAR(TRANS_DATE, 'YYYY-MM')
) L
FULL OUTER join
(
SELECT TO_CHAR(C.charge_date, 'YYYY-MM') month,
T.country,
count(T.amount) chargeback_count,
sum(T.amount) chargeback_amount
FROM Chargebacks C,
TRANSACTIONS T
WHERE T.id = C.trans_id
GROUP BY T.country, TO_CHAR(C.charge_date, 'YYYY-MM')
ORDER BY TO_CHAR(C.charge_date, 'YYYY-MM')
) R
ON (L.MONTH = R.MONTH AND L.country = R.country);
