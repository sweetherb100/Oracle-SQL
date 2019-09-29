/*Query the customer_number from the orders table for the customer who has placed the largest number of orders.

It is guaranteed that exactly one customer will have placed more orders than any other customer.

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

Sample Input
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
CREATE TABLE customer (order_number int, customer_number int, order_date date, required_date date, shipped_date date, status varchar(255), comment varchar(255));
TRUNCATE TABLE customer;
INSERT ALL
INTO customer (order_number, customer_number, order_date, required_date, shipped_date, status, comment varchar) VALUES ('1', '1', TO_DATE('2017-04-09','YYYY-MM-DD'), TO_DATE('2017-04-13','YYYY-MM-DD'), TO_DATE('2017-04-12','YYYY-MM-DD'), 'Closed', NULL)
INTO customer (order_number, customer_number, order_date, required_date, shipped_date, status, comment varchar) VALUES ('2', '2', TO_DATE('2017-04-15','YYYY-MM-DD'), TO_DATE('2017-04-20','YYYY-MM-DD'), TO_DATE('2017-04-18','YYYY-MM-DD'), 'Closed', NULL)
INTO customer (order_number, customer_number, order_date, required_date, shipped_date, status, comment varchar) VALUES ('3', '3', TO_DATE('2017-04-16','YYYY-MM-DD'), TO_DATE('2017-04-25','YYYY-MM-DD'), TO_DATE('2017-04-20','YYYY-MM-DD'), 'Closed', NULL)
INTO customer (order_number, customer_number, order_date, required_date, shipped_date, status, comment varchar) VALUES ('4', '3', TO_DATE('2017-04-18','YYYY-MM-DD'), TO_DATE('2017-04-28','YYYY-MM-DD'), TO_DATE('2017-04-25','YYYY-MM-DD'), 'Closed', NULL)
SELECT * FROM DUAL;
SELECT * FROM customer;