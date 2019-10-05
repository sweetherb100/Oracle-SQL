/*Table: Delivery
+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the primary key of this table.
The table holds information about food delivery to customers that make orders at some date 
and specify a preferred delivery date (on the same order date or after it).

If the preferred delivery date of the customer is the same as the order date then the order is called immediate otherwise it called scheduled.

Write an SQL query to find the percentage of "immediate" orders in the table, rounded to 2 decimal places.

The query result format is in the following example:

Delivery table:

+-------------+-------------+------------+-----------------------------+
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
+-------------+-------------+------------+-----------------------------+
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 5           | 2019-08-02 | 2019-08-02                  |
| 3           | 1           | 2019-08-11 | 2019-08-11                  |
| 4           | 3           | 2019-08-24 | 2019-08-26                  |
| 5           | 4           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
+-------------+-------------+------------+-----------------------------+
Result table:

+----------------------+
| immediate_percentage |
+----------------------+
| 33.33                |
+----------------------+
The orders with delivery id 2 and 3 are immediate while the others are scheduled.*/

DROP TABLE DELIVERY;
CREATE TABLE DELIVERY (DELIVERY_ID INT, CUSTOMER_ID INT, ORDER_DATE DATE, CUSTOMER_PREF_DELIVERY_DATE DATE);
TRUNCATE TABLE DELIVERY;
INSERT ALL
INTO DELIVERY (DELIVERY_ID, CUSTOMER_ID, ORDER_DATE, CUSTOMER_PREF_DELIVERY_DATE) VALUES ('1', '1', TO_DATE('2019-08-01', 'YYYY-MM-DD'), TO_DATE('2019-08-02','YYYY-MM-DD'))
INTO DELIVERY (DELIVERY_ID, CUSTOMER_ID, ORDER_DATE, CUSTOMER_PREF_DELIVERY_DATE) VALUES ('2', '5', TO_DATE('2019-08-02','YYYY-MM-DD'), TO_DATE('2019-08-02','YYYY-MM-DD'))
INTO DELIVERY (DELIVERY_ID, CUSTOMER_ID, ORDER_DATE, CUSTOMER_PREF_DELIVERY_DATE) VALUES ('3', '1', TO_DATE('2019-08-11','YYYY-MM-DD'), TO_DATE('2019-08-11','YYYY-MM-DD'))
INTO DELIVERY (DELIVERY_ID, CUSTOMER_ID, ORDER_DATE, CUSTOMER_PREF_DELIVERY_DATE) VALUES ('4', '3', TO_DATE('2019-08-24','YYYY-MM-DD'), TO_DATE('2019-08-26','YYYY-MM-DD'))
INTO DELIVERY (DELIVERY_ID, CUSTOMER_ID, ORDER_DATE, CUSTOMER_PREF_DELIVERY_DATE) VALUES ('5', '4', TO_DATE('2019-08-21','YYYY-MM-DD'), TO_DATE('2019-08-22','YYYY-MM-DD'))
INTO DELIVERY (DELIVERY_ID, CUSTOMER_ID, ORDER_DATE, CUSTOMER_PREF_DELIVERY_DATE) VALUES ('6', '2', TO_DATE('2019-08-11','YYYY-MM-DD'), TO_DATE('2019-08-13','YYYY-MM-DD'))
SELECT * FROM DUAL;
SELECT * FROM DELIVERY;


--[method 1] 
SELECT COUNT(1) FROM DELIVERY; --total row

SELECT ROUND(
				(SUM(CASE WHEN D.ORDER_DATE = D.CUSTOMER_PREF_DELIVERY_DATE
                  THEN 1
                  ELSE 0 END)/ COUNT(1))
          	, 2)
FROM DELIVERY D;

 --[method 2]
SELECT ROUND((IMM.CNT/TOT.CNT)*100,2) AS IMMEDIATE_PERCENTAGE
FROM (
	SELECT COUNT(ORDER_DATE) CNT
	FROM DELIVERY
	WHERE ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE
	) IMM,
	(
	SELECT COUNT(ORDER_DATE) CNT
	FROM DELIVERY
	) TOT;