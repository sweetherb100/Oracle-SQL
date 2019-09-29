/*Description

Given three tables: salesperson, company, orders.
Output all the names in the table salesperson, who didnt have sales to company TED.

Example
Input
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
According to order 3 and 4 in table orders, it is easy to tell only salesperson John and Alex have sales to company TED,
so we need to output all the other names in table salesperson.*/

DROP TABLE salesperson;
CREATE TABLE salesperson (sales_id int, name varchar(255), salary int, commission_rate int, hire_date date);
TRUNCATE TABLE salesperson;
INSERT ALL
INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES ('1', 'John', '100000', '6', TO_DATE('2006-04-01','YYYY-MM-DD'))
INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES ('2', 'Amy', '120000', '5', TO_DATE('2010-05-01','YYYY-MM-DD'))
INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES ('3', 'Mark', '65000', '12', TO_DATE('2008-12-24','YYYY-MM-DD'))
INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES ('4', 'Pam', '25000', '25', TO_DATE('2005-01-01','YYYY-MM-DD'))
INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES ('5', 'Alex', '50000', '10', TO_DATE('2007-02-03','YYYY-MM-DD')) 
SELECT * FROM DUAL;
SELECT * FROM salesperson;

DROP TABLE company;
CREATE TABLE company (com_id int, name varchar(255), city varchar(255));
TRUNCATE TABLE company;
INSERT ALL
INTO company (com_id, name, city) VALUES ('1', 'RED', 'Boston')
INTO company (com_id, name, city) VALUES ('2', 'ORANGE', 'New York')
INTO company (com_id, name, city) VALUES ('3', 'YELLOW', 'Boston')
INTO company (com_id, name, city) VALUES ('4', 'GREEN', 'Austin') 
SELECT * FROM DUAL;
SELECT * FROM company;


DROP TABLE orders;
CREATE TABLE orders (order_id int, date date, com_id int, sales_id int, amount int);
TRUNCATE TABLE orders;
INSERT ALL
INTO orders (order_id, date, com_id, sales_id, amount) VALUES ('1', TO_DATE('2014-01-01','YYYY-MM-DD'), '3', '4', '100000')
INTO orders (order_id, date, com_id, sales_id, amount) VALUES ('2', TO_DATE('2014-02-01','YYYY-MM-DD'), '4', '5', '5000')
INTO orders (order_id, date, com_id, sales_id, amount) VALUES ('3', TO_DATE('2014-03-01','YYYY-MM-DD'), '1', '1', '50000')
INTO orders (order_id, date, com_id, sales_id, amount) VALUES ('4', TO_DATE('2014-04-01','YYYY-MM-DD'), '1', '4', '25000')
SELECT * FROM DUAL;
SELECT * FROM orders;

