/*Description
Given three tables: salesperson, company, orders.

Output all the names in the table salesperson, who didnt have sales to company RED.

Table: salesperson
+----------+------+--------+-----------------+-----------+
| sales_id | name | salary | commission_rate | hire_date |
+----------+------+--------+-----------------+-----------+
|   1      | John | 100000 |     6           | 4/1/2006  |
|   2      | Amy  | 120000 |     5           | 5/1/2010  |
|   3      | Mark | 65000  |     12          | 12/25/2008|
|   4      | Pam  | 25000  |     25          | 1/1/2005  |
|   5      | Alex | 50000  |     10          | 2/3/2007  |
+----------+------+--------+-----------------+-----------+
The table salesperson holds the salesperson information. Every salesperson has a sales_id and a name.

Table: company
+---------+--------+------------+
| com_id  |  name  |    city    |
+---------+--------+------------+
|   1     |  RED   |   Boston   |
|   2     | ORANGE |   New York |
|   3     | YELLOW |   Boston   |
|   4     | GREEN  |   Austin   |
+---------+--------+------------+
The table company holds the company information. Every company has a com_id and a name.

Table: orders
+----------+----------+---------+----------+--------+
| order_id |  date    | com_id  | sales_id | amount |
+----------+----------+---------+----------+--------+
| 1        | 1/1/2014 |    3    |    4     | 100000 |
| 2        | 2/1/2014 |    4    |    5     | 5000   |
| 3        | 3/1/2014 |    1    |    1     | 50000  |
| 4        | 4/1/2014 |    1    |    4     | 25000  |
+----------+----------+---------+----------+--------+
The table orders holds the sales record information, salesperson and customer company are represented by sales_id and com_id.

output
+------+
| name | 
+------+
| Amy  | 
| Mark | 
| Alex |
+------+

Explanation
According to order 3 and 4 in table orders, it is easy to tell only salesperson John and Alex have sales to company RED,
so we need to output all the other names in table salesperson.*/

DROP TABLE SALESPERSON;
CREATE TABLE SALESPERSON (SALES_ID INT, NAME VARCHAR(255), SALARY INT, COMMISSION_RATE INT, HIRE_DATE DATE);
TRUNCATE TABLE SALESPERSON;
INSERT ALL
INTO SALESPERSON (SALES_ID, NAME, SALARY, COMMISSION_RATE, HIRE_DATE) VALUES ('1', 'JOHN', '100000', '6', TO_DATE('2006-04-01','YYYY-MM-DD'))
INTO SALESPERSON (SALES_ID, NAME, SALARY, COMMISSION_RATE, HIRE_DATE) VALUES ('2', 'AMY', '120000', '5', TO_DATE('2010-05-01','YYYY-MM-DD'))
INTO SALESPERSON (SALES_ID, NAME, SALARY, COMMISSION_RATE, HIRE_DATE) VALUES ('3', 'MARK', '65000', '12', TO_DATE('2008-12-24','YYYY-MM-DD'))
INTO SALESPERSON (SALES_ID, NAME, SALARY, COMMISSION_RATE, HIRE_DATE) VALUES ('4', 'PAM', '25000', '25', TO_DATE('2005-01-01','YYYY-MM-DD'))
INTO SALESPERSON (SALES_ID, NAME, SALARY, COMMISSION_RATE, HIRE_DATE) VALUES ('5', 'ALEX', '50000', '10', TO_DATE('2007-02-03','YYYY-MM-DD')) 
SELECT * FROM DUAL;
SELECT * FROM SALESPERSON;

DROP TABLE COMPANY;
CREATE TABLE COMPANY (COM_ID INT, NAME VARCHAR(255), CITY VARCHAR(255));
TRUNCATE TABLE COMPANY;
INSERT ALL
INTO COMPANY (COM_ID, NAME, CITY) VALUES ('1', 'RED', 'BOSTON')
INTO COMPANY (COM_ID, NAME, CITY) VALUES ('2', 'ORANGE', 'NEW YORK')
INTO COMPANY (COM_ID, NAME, CITY) VALUES ('3', 'YELLOW', 'BOSTON')
INTO COMPANY (COM_ID, NAME, CITY) VALUES ('4', 'GREEN', 'AUSTIN') 
SELECT * FROM DUAL;
SELECT * FROM COMPANY;


DROP TABLE ORDERS;
CREATE TABLE ORDERS (ORDER_ID INT, DATES DATE, COM_ID INT, SALES_ID INT, AMOUNT INT);
TRUNCATE TABLE ORDERS;
INSERT ALL
INTO ORDERS (ORDER_ID, DATES, COM_ID, SALES_ID, AMOUNT) VALUES ('1', TO_DATE('2014-01-01','YYYY-MM-DD'), '3', '4', '100000')
INTO ORDERS (ORDER_ID, DATES, COM_ID, SALES_ID, AMOUNT) VALUES ('2', TO_DATE('2014-02-01','YYYY-MM-DD'), '4', '5', '5000')
INTO ORDERS (ORDER_ID, DATES, COM_ID, SALES_ID, AMOUNT) VALUES ('3', TO_DATE('2014-03-01','YYYY-MM-DD'), '1', '1', '50000')
INTO ORDERS (ORDER_ID, DATES, COM_ID, SALES_ID, AMOUNT) VALUES ('4', TO_DATE('2014-04-01','YYYY-MM-DD'), '1', '4', '25000')
SELECT * FROM DUAL;
SELECT * FROM ORDERS;


--Exceptional case is Mark who didn't have any sale yet!
-- I will exclude these salespersons from the final query
SELECT SALES_ID
FROM ORDERS
WHERE COM_ID IN (SELECT COM_ID FROM COMPANY WHERE NAME = 'RED');

--FINAL
SELECT S.NAME
FROM SALESPERSON S
WHERE S.SALES_ID NOT IN (SELECT SALES_ID
						FROM ORDERS
						WHERE COM_ID IN (SELECT COM_ID FROM COMPANY WHERE NAME = 'RED'));		
