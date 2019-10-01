/*Table: Books
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| book_id        | int     |
| name           | varchar |
| available_from | date    |
+----------------+---------+
book_id is the primary key of this table.

Table: Orders
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| order_id       | int     |
| book_id        | int     |
| quantity       | int     |
| dispatch_date  | date    |
+----------------+---------+
order_id is the primary key of this table.
book_id is a foreign key to the Books table.

Write an SQL query that reports the books that have sold less than 10 copies in the last year, 
excluding books that have been available for less than 1 month from today. Assume today is 2019-06-23.

The query result format is in the following example:

Books table:
+---------+--------------------+----------------+
| book_id | name               | available_from |
+---------+--------------------+----------------+
| 1       | "Kalila And Demna" | 2010-01-01     |
| 2       | "28 Letters"       | 2012-05-12     |
| 3       | "The Hobbit"       | 2019-06-10     |
| 4       | "13 Reasons Why"   | 2019-06-01     |
| 5       | "The Hunger Games" | 2008-09-21     |
+---------+--------------------+----------------+

Orders table:
+----------+---------+----------+---------------+
| order_id | book_id | quantity | dispatch_date |
+----------+---------+----------+---------------+
| 1        | 1       | 2        | 2018-07-26    |
| 2        | 1       | 1        | 2018-11-05    |
| 3        | 3       | 8        | 2019-06-11    |
| 4        | 4       | 6        | 2019-06-05    |
| 5        | 4       | 5        | 2019-06-20    |
| 6        | 5       | 9        | 2009-02-02    |
| 7        | 5       | 8        | 2010-04-13    |
+----------+---------+----------+---------------+

Result table:
+-----------+--------------------+
| book_id   | name               |
+-----------+--------------------+
| 1         | "Kalila And Demna" |
| 2         | "28 Letters"       |
| 5         | "The Hunger Games" |
+-----------+--------------------+*/

DROP TABLE Books;
CREATE TABLE Books (book_id int, name varchar(255), available_from date);
TRUNCATE TABLE Books;
INSERT ALL
INTO Books (book_id, name, available_from) VALUES ('1', 'Kalila And Demna', TO_DATE('2010-01-01','YYYY-MM-DD'))
INTO Books (book_id, name, available_from) VALUES ('2', '28 Letters', TO_DATE('2012-05-12','YYYY-MM-DD'))
INTO Books (book_id, name, available_from) VALUES ('3', 'The Hobbit', TO_DATE('2019-06-10','YYYY-MM-DD'))
INTO Books (book_id, name, available_from) VALUES ('4', '13 Reasons Why', TO_DATE('2019-06-01','YYYY-MM-DD'))
INTO Books (book_id, name, available_from) VALUES ('5', 'The Hunger Games', TO_DATE('2008-09-21','YYYY-MM-DD'))
SELECT * FROM DUAL;
SELECT * FROM Books;

DROP TABLE Orders;
CREATE TABLE Orders (order_id int, book_id int, quantity int, dispatch_date date);
TRUNCATE TABLE Orders;
INSERT ALL
INTO Orders (order_id, book_id, quantity, dispatch_date) VALUES ('1', '1', '2', TO_DATE('2018-07-26','YYYY-MM-DD'))
INTO Orders (order_id, book_id, quantity, dispatch_date) VALUES ('2', '1', '1', TO_DATE('2018-11-05','YYYY-MM-DD'))
INTO Orders (order_id, book_id, quantity, dispatch_date) VALUES ('3', '3', '8', TO_DATE('2019-06-11','YYYY-MM-DD'))
INTO Orders (order_id, book_id, quantity, dispatch_date) VALUES ('4', '4', '6', TO_DATE('2019-06-05','YYYY-MM-DD'))
INTO Orders (order_id, book_id, quantity, dispatch_date) VALUES ('5', '4', '5', TO_DATE('2019-06-20','YYYY-MM-DD'))
INTO Orders (order_id, book_id, quantity, dispatch_date) VALUES ('6', '5', '9', TO_DATE('2009-02-02','YYYY-MM-DD'))
INTO Orders (order_id, book_id, quantity, dispatch_date) VALUES ('7', '5', '8', TO_DATE('2010-04-13','YYYY-MM-DD'))
SELECT * FROM DUAL;
SELECT * FROM Orders;

SELECT TO_DATE('2019-06-23','YYYY-MM-DD') - 30
FROM dual;

SELECT *
FROM ORDERS
WHERE dispatch_date >= TO_DATE('2018-01-01','YYYY-MM-DD');

--first condition (the books that have sold less than 10 copies in the last year)
SELECT book_id,
sum(quantity)
FROM ORDERS
WHERE dispatch_date >= TO_DATE('2018-01-01','YYYY-MM-DD')
GROUP BY book_id
HAVING sum(quantity) < 10;

--second condition (excluding books that have been available for less than 1 month from today. i.e. exclude the books that are too recent)
SELECT *
FROM BOOKS
WHERE available_from < TO_DATE('2019-06-23','YYYY-MM-DD') - 30;


--Final
SELECT B.book_id,
B.name
FROM 
(
SELECT book_id,
name
FROM BOOKS
WHERE available_from < TO_DATE('2019-06-23','YYYY-MM-DD') - 30
) B,
(
SELECT book_id,
sum(quantity)
FROM ORDERS
WHERE dispatch_date >= TO_DATE('2018-01-01','YYYY-MM-DD')
GROUP BY book_id
HAVING sum(quantity) < 10
) O
WHERE B.book_id = O.book_id (+)