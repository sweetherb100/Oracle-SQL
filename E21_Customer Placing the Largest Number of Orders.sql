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

DROP TABLE CUSTOMER;
CREATE TABLE CUSTOMER (ORDER_NUMBER INT, CUSTOMER_NUMBER INT, ORDER_DATE DATE, REQUIRED_DATE DATE, SHIPPED_DATE DATE, STATUS VARCHAR(255), COMMENTS VARCHAR(255));
TRUNCATE TABLE CUSTOMER;
INSERT ALL
INTO CUSTOMER (ORDER_NUMBER, CUSTOMER_NUMBER, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, STATUS, COMMENTS) VALUES ('1', '1', TO_DATE('2017-04-09','YYYY-MM-DD'), TO_DATE('2017-04-13','YYYY-MM-DD'), TO_DATE('2017-04-12','YYYY-MM-DD'), 'CLOSED', NULL)
INTO CUSTOMER (ORDER_NUMBER, CUSTOMER_NUMBER, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, STATUS, COMMENTS) VALUES ('2', '2', TO_DATE('2017-04-15','YYYY-MM-DD'), TO_DATE('2017-04-20','YYYY-MM-DD'), TO_DATE('2017-04-18','YYYY-MM-DD'), 'CLOSED', NULL)
INTO CUSTOMER (ORDER_NUMBER, CUSTOMER_NUMBER, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, STATUS, COMMENTS) VALUES ('3', '3', TO_DATE('2017-04-16','YYYY-MM-DD'), TO_DATE('2017-04-25','YYYY-MM-DD'), TO_DATE('2017-04-20','YYYY-MM-DD'), 'CLOSED', NULL)
INTO CUSTOMER (ORDER_NUMBER, CUSTOMER_NUMBER, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, STATUS, COMMENTS) VALUES ('4', '3', TO_DATE('2017-04-18','YYYY-MM-DD'), TO_DATE('2017-04-28','YYYY-MM-DD'), TO_DATE('2017-04-25','YYYY-MM-DD'), 'CLOSED', NULL)
SELECT * FROM DUAL;
SELECT * FROM CUSTOMER;


SELECT CUSTOMER_NUMBER
FROM CUSTOMER
GROUP BY CUSTOMER_NUMBER
ORDER BY COUNT(CUSTOMER_NUMBER) DESC;

--[CASE 1] WHEN GURANTEED TO HAVE ONLY 1 MAX
SELECT *
FROM (
	SELECT CUSTOMER_NUMBER
	FROM CUSTOMER
	GROUP BY CUSTOMER_NUMBER
	ORDER BY COUNT(CUSTOMER_NUMBER) DESC
) T
WHERE ROWNUM =1;

-- [CASE 2] WHEN NOT GURANTEED TO HAVE 1 MAX
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
 WHERE RNK  = 1;
-- WHERE RNUM = 1;


