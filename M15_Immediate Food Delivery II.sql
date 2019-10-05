/*table: delivery
+-----------------------------+---------+
| column name                 | type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the primary key of this table.
the table holds information about food delivery to customers that make orders at some date 
and specify a preferred delivery date (on the same order date or after it).

If the preferred delivery date of the customer is the same as the order date 
then the order is called 'immediate' otherwise it's called 'scheduled'.

The first order of a customer is the order with the earliest order date that customer made.

Write an sql query to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.

The query result format is in the following example:

delivery table:
+-------------+-------------+------------+-----------------------------+
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
+-------------+-------------+------------+-----------------------------+
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 2           | 2019-08-02 | 2019-08-02                  |
| 3           | 1           | 2019-08-11 | 2019-08-12                  |
| 4           | 3           | 2019-08-24 | 2019-08-24                  |
| 5           | 3           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
| 7           | 4           | 2019-08-09 | 2019-08-09                  |
+-------------+-------------+------------+-----------------------------+

result table:
+----------------------+
| immediate_percentage |
+----------------------+
| 50.00                |
+----------------------+
the customer id 1 has a first order with delivery id 1 and it is scheduled.
the customer id 2 has a first order with delivery id 2 and it is immediate.
the customer id 3 has a first order with delivery id 5 and it is scheduled.
the customer id 4 has a first order with delivery id 7 and it is immediate.
hence, half the customers have immediate first orders.*/

DROP TABLE DELIVERY;
CREATE TABLE DELIVERY (DELIVERY_ID INT, CUSTOMER_ID INT, ORDER_DATE DATE, CUSTOMER_PREF_DELIVERY_DATE DATE);
TRUNCATE TABLE DELIVERY;
INSERT ALL
INTO DELIVERY (DELIVERY_ID, CUSTOMER_ID, ORDER_DATE, CUSTOMER_PREF_DELIVERY_DATE) VALUES ('1', '1', TO_DATE('2019-08-01','YYYY-MM-DD'), TO_DATE('2019-08-02','YYYY-MM-DD'))
INTO DELIVERY (DELIVERY_ID, CUSTOMER_ID, ORDER_DATE, CUSTOMER_PREF_DELIVERY_DATE) VALUES ('2', '2', TO_DATE('2019-08-02','YYYY-MM-DD'), TO_DATE('2019-08-02','YYYY-MM-DD'))
INTO DELIVERY (DELIVERY_ID, CUSTOMER_ID, ORDER_DATE, CUSTOMER_PREF_DELIVERY_DATE) VALUES ('3', '1', TO_DATE('2019-08-11','YYYY-MM-DD'), TO_DATE('2019-08-12','YYYY-MM-DD'))
INTO DELIVERY (DELIVERY_ID, CUSTOMER_ID, ORDER_DATE, CUSTOMER_PREF_DELIVERY_DATE) VALUES ('4', '3', TO_DATE('2019-08-24','YYYY-MM-DD'), TO_DATE('2019-08-24','YYYY-MM-DD'))
INTO DELIVERY (DELIVERY_ID, CUSTOMER_ID, ORDER_DATE, CUSTOMER_PREF_DELIVERY_DATE) VALUES ('5', '3', TO_DATE('2019-08-21','YYYY-MM-DD'), TO_DATE('2019-08-22','YYYY-MM-DD'))
INTO DELIVERY (DELIVERY_ID, CUSTOMER_ID, ORDER_DATE, CUSTOMER_PREF_DELIVERY_DATE) VALUES ('6', '2', TO_DATE('2019-08-11','YYYY-MM-DD'), TO_DATE('2019-08-13','YYYY-MM-DD'))
INTO DELIVERY (DELIVERY_ID, CUSTOMER_ID, ORDER_DATE, CUSTOMER_PREF_DELIVERY_DATE) VALUES ('7', '4', TO_DATE('2019-08-09','YYYY-MM-DD'), TO_DATE('2019-08-09','YYYY-MM-DD'))
SELECT * FROM DUAL;
SELECT * FROM DELIVERY;


--first, get the rows of first order for each customer
SELECT *
FROM
(
	SELECT CUSTOMER_ID,
	ORDER_DATE,
	CUSTOMER_PREF_DELIVERY_DATE,
	RANK() OVER (PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATE) RNK_DATE
	FROM DELIVERY
)
WHERE RNK_DATE=1;

--[METHOD 1]
SELECT COUNT(CASE WHEN ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE THEN 1 END) /COUNT(1) *100 IMMEDIATE_PERCENTAGE
FROM
(
	SELECT *
	FROM
	(
		SELECT CUSTOMER_ID,
		ORDER_DATE,
		CUSTOMER_PREF_DELIVERY_DATE,
		RANK() OVER (PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATE) RNK_DATE
		FROM DELIVERY
	)
	WHERE RNK_DATE=1
);


--WRONG(1): because i cut rows by where clause
SELECT COUNT(D.CUSTOMER_ID)/COUNT(T.CUSTOMER_ID)
FROM DELIVERY D,
(
	SELECT CUSTOMER_ID,
	MIN(ORDER_DATE) MIN_DATE
	FROM DELIVERY
	GROUP BY CUSTOMER_ID
) T,
(
	SELECT COUNT(DISTINCT CUSTOMER_ID) TOT_CNT
	FROM DELIVERY
)
TT
WHERE D.CUSTOMER_ID = T.CUSTOMER_ID
AND T.MIN_DATE = D.CUSTOMER_PREF_DELIVERY_DATE;

--WRONG(2): grammatically, this is not possible
-- I know TOT_CNT is only 1 row but it might not, so oracle is not allowing this! 
-- Have to use with group function
SELECT COUNT(D.CUSTOMER_ID)/TT.TOT_CNT
FROM DELIVERY D,
(
	SELECT CUSTOMER_ID,
	MIN(ORDER_DATE) MIN_DATE
	FROM DELIVERY
	GROUP BY CUSTOMER_ID
) T,
(
	SELECT COUNT(DISTINCT CUSTOMER_ID) TOT_CNT
	FROM DELIVERY
)
TT
WHERE D.CUSTOMER_ID = T.CUSTOMER_ID
AND T.MIN_DATE = D.CUSTOMER_PREF_DELIVERY_DATE;

-- [METHOD 2] alternative is to use MAX or MIN in select clause to use group function
SELECT COUNT(D.CUSTOMER_ID)/MAX(TT.TOT_CNT)
FROM DELIVERY D,
(
	SELECT CUSTOMER_ID,
	MIN(ORDER_DATE) MIN_DATE
	FROM DELIVERY
	GROUP BY CUSTOMER_ID
) T,
(
	SELECT COUNT(DISTINCT CUSTOMER_ID) TOT_CNT
	FROM DELIVERY
)
TT
WHERE D.CUSTOMER_ID = T.CUSTOMER_ID
AND T.MIN_DATE = D.CUSTOMER_PREF_DELIVERY_DATE;