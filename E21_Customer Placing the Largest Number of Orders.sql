/*Query the customer_number from the orders table for the customer who has placed the largest number of orders.

It is "guaranteed" that exactly one customer will have placed more orders than any other customer.

The orders table is defined as follows:
| Column            | Type      |
|-------------------|-----------|
| order_number (PK) | int       |
| customer_number   | int       |
| order_date        | date      |
| required_date     | date      |
| shipped_date      | date      |
| status            | char(15)  |
| comment           | char(200) |

Sample Input:
| order_number | customer_number | order_date | required_date | shipped_date | status | comment |
|--------------|-----------------|------------|---------------|--------------|--------|---------|
| 1            | 1               | 2017-04-09 | 2017-04-13    | 2017-04-12   | Closed |         |
| 2            | 2               | 2017-04-15 | 2017-04-20    | 2017-04-18   | Closed |         |
| 3            | 3               | 2017-04-16 | 2017-04-25    | 2017-04-20   | Closed |         |
| 4            | 3               | 2017-04-18 | 2017-04-28    | 2017-04-25   | Closed |         |

Sample Output
| customer_number |
|-----------------|
| 3               |

Explanation
The customer with number '3' has two orders, which is greater than either customer '1' or '2' because each of them  only has one order. 
So the result is customer_number '3'.*/

DROP TABLE customer;
CREATE TABLE customer (order_number int, customer_number int, order_date date, required_date date, shipped_date date, status varchar(255), comments varchar(255));
TRUNCATE TABLE customer;
INSERT ALL
INTO customer (order_number, customer_number, order_date, required_date, shipped_date, status, comments) VALUES ('1', '1', TO_DATE('2017-04-09','YYYY-MM-DD'), TO_DATE('2017-04-13','YYYY-MM-DD'), TO_DATE('2017-04-12','YYYY-MM-DD'), 'Closed', NULL)
INTO customer (order_number, customer_number, order_date, required_date, shipped_date, status, comments) VALUES ('2', '2', TO_DATE('2017-04-15','YYYY-MM-DD'), TO_DATE('2017-04-20','YYYY-MM-DD'), TO_DATE('2017-04-18','YYYY-MM-DD'), 'Closed', NULL)
INTO customer (order_number, customer_number, order_date, required_date, shipped_date, status, comments) VALUES ('3', '3', TO_DATE('2017-04-16','YYYY-MM-DD'), TO_DATE('2017-04-25','YYYY-MM-DD'), TO_DATE('2017-04-20','YYYY-MM-DD'), 'Closed', NULL)
INTO customer (order_number, customer_number, order_date, required_date, shipped_date, status, comments) VALUES ('4', '3', TO_DATE('2017-04-18','YYYY-MM-DD'), TO_DATE('2017-04-28','YYYY-MM-DD'), TO_DATE('2017-04-25','YYYY-MM-DD'), 'Closed', NULL)
SELECT * FROM DUAL;
SELECT * FROM customer;


SELECT customer_number
FROM customer
GROUP BY customer_number
ORDER BY count(customer_number) DESC;

--When guranteed to have only 1 max
SELECT *
FROM (
SELECT customer_number
FROM customer
GROUP BY customer_number
ORDER BY count(customer_number) DESC
) T
WHERE rownum =1;

-- WHEN NOT guranteed TO have 1 max
SELECT customer_number,
count(CUSTOMER_NUMBER)
FROM customer
GROUP BY customer_number;

SELECT max(count(customer_number)) max_num
FROM CUSTOMER
GROUP BY CUSTOMER_NUMBER;

--[method1] my style
SELECT C.CUSTOMER_NUMBER
FROM 
(
	SELECT CUSTOMER_NUMBER,
	COUNT(CUSTOMER_NUMBER) CNT_NUM
	FROM CUSTOMER
	GROUP BY CUSTOMER_NUMBER
) C,
(
	SELECT MAX(COUNT(CUSTOMER_NUMBER)) MAX_NUM
	FROM CUSTOMER
	GROUP BY CUSTOMER_NUMBER
) C1
WHERE C.CNT_NUM = C1.MAX_NUM;


--[method2] yulkyu style
SELECT CUSTOMER_NUMBER
  FROM (
        SELECT CUSTOMER_NUMBER, 
        		RANK() OVER(ORDER BY ORDER_COUNTS DESC) AS RNK, 
        		ROW_NUMBER() OVER(ORDER BY ORDER_COUNTS DESC) AS RNUM
          FROM (
                SELECT CUSTOMER_NUMBER, 
                		COUNT(CUSTOMER_NUMBER) AS ORDER_COUNTS
                  FROM CUSTOMER
                 GROUP BY CUSTOMER_NUMBER
                 ORDER BY ORDER_COUNTS DESC
               )
       )
 WHERE RNK  = 1 -- 중복 1위를 다 보고 싶을때
 WHERE RNUM = 1; -- 중복이어도 1위는 하나만 보고 싶을때


