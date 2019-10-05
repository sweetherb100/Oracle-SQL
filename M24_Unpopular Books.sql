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

Write an SQL query that reports the books that have sold less than 10 copies in the last year (my B:what I am going to exclude), 
excluding books that have been available for less than 1 month from today (my A: total set). Assume today is 2019-06-23.

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

Orders table: (modified)
+----------+---------+----------+---------------+
| order_id | book_id | quantity | dispatch_date |
+----------+---------+----------+---------------+
| 1        | 1       | 100      | 2018-07-26    |
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
+-----------+--------------------+

Result table: (modified)
+-----------+--------------------+
| book_id   | name               |
+-----------+--------------------+
| 2         | "28 Letters"       |
| 5         | "The Hunger Games" |
+-----------+--------------------+*/

DROP TABLE BOOKS;
CREATE TABLE BOOKS (BOOK_ID INT, NAME VARCHAR(255), AVAILABLE_FROM DATE);
TRUNCATE TABLE BOOKS;
INSERT ALL
INTO BOOKS (BOOK_ID, NAME, AVAILABLE_FROM) VALUES ('1', 'KALILA AND DEMNA', TO_DATE('2010-01-01','YYYY-MM-DD'))
INTO BOOKS (BOOK_ID, NAME, AVAILABLE_FROM) VALUES ('2', '28 LETTERS', TO_DATE('2012-05-12','YYYY-MM-DD'))
INTO BOOKS (BOOK_ID, NAME, AVAILABLE_FROM) VALUES ('3', 'THE HOBBIT', TO_DATE('2019-06-10','YYYY-MM-DD'))
INTO BOOKS (BOOK_ID, NAME, AVAILABLE_FROM) VALUES ('4', '13 REASONS WHY', TO_DATE('2019-06-01','YYYY-MM-DD'))
INTO BOOKS (BOOK_ID, NAME, AVAILABLE_FROM) VALUES ('5', 'THE HUNGER GAMES', TO_DATE('2008-09-21','YYYY-MM-DD'))
SELECT * FROM DUAL;
SELECT * FROM BOOKS;

DROP TABLE ORDERS;
CREATE TABLE ORDERS (ORDER_ID INT, BOOK_ID INT, QUANTITY INT, DISPATCH_DATE DATE);
TRUNCATE TABLE ORDERS;
INSERT ALL
INTO ORDERS (ORDER_ID, BOOK_ID, QUANTITY, DISPATCH_DATE) VALUES ('1', '1', '100', TO_DATE('2018-07-26','YYYY-MM-DD'))
INTO ORDERS (ORDER_ID, BOOK_ID, QUANTITY, DISPATCH_DATE) VALUES ('2', '1', '1', TO_DATE('2018-11-05','YYYY-MM-DD'))
INTO ORDERS (ORDER_ID, BOOK_ID, QUANTITY, DISPATCH_DATE) VALUES ('3', '3', '8', TO_DATE('2019-06-11','YYYY-MM-DD'))
INTO ORDERS (ORDER_ID, BOOK_ID, QUANTITY, DISPATCH_DATE) VALUES ('4', '4', '6', TO_DATE('2019-06-05','YYYY-MM-DD'))
INTO ORDERS (ORDER_ID, BOOK_ID, QUANTITY, DISPATCH_DATE) VALUES ('5', '4', '5', TO_DATE('2019-06-20','YYYY-MM-DD'))
INTO ORDERS (ORDER_ID, BOOK_ID, QUANTITY, DISPATCH_DATE) VALUES ('6', '5', '9', TO_DATE('2009-02-02','YYYY-MM-DD'))
INTO ORDERS (ORDER_ID, BOOK_ID, QUANTITY, DISPATCH_DATE) VALUES ('7', '5', '8', TO_DATE('2010-04-13','YYYY-MM-DD'))
SELECT * FROM DUAL;
SELECT * FROM ORDERS;

--IF DOESN'T HAVE ANY ORDER RECORDS IN ORDER TABLE, IT WASN'T SOLD SO IT SHOULD BE INCLUDED IN THE RESULT
-- A-B = A intersection B complement

--[METHOD 1] I will use NOT IN
SELECT BOOK_ID
FROM ORDERS
WHERE DISPATCH_DATE >= TO_DATE('2018-01-01','YYYY-MM-DD')
AND DISPATCH_DATE <= TO_DATE('2018-12-31','YYYY-MM-DD') --BE CAREFUL! THIS SHOULD BE STILL LAST YEAR
GROUP BY BOOK_ID
HAVING SUM(QUANTITY) > 10
UNION
SELECT BOOK_ID
FROM BOOKS
WHERE AVAILABLE_FROM >= TO_DATE('2019-06-23','YYYY-MM-DD') - 30
AND AVAILABLE_FROM <= TO_DATE('2019-06-23','YYYY-MM-DD');


--FINAL
SELECT BOOK_ID, 
NAME
FROM BOOKS
WHERE BOOK_ID NOT IN (
					SELECT BOOK_ID
					FROM ORDERS
					WHERE DISPATCH_DATE >= TO_DATE('2018-01-01','YYYY-MM-DD')
					AND DISPATCH_DATE <= TO_DATE('2018-12-31','YYYY-MM-DD')
					GROUP BY BOOK_ID
					HAVING SUM(QUANTITY) > 10
					UNION
					SELECT BOOK_ID
					FROM BOOKS
					WHERE AVAILABLE_FROM >= TO_DATE('2019-06-23','YYYY-MM-DD') - 30
					AND AVAILABLE_FROM <= TO_DATE('2019-06-23','YYYY-MM-DD')
					);


--UMM.. SOMETHING IS WRONG
--FIRST CONDITION: THE BOOKS THAT HAVE SOLD LESS THAN 10 COPIES IN THE LAST YEAR
SELECT BOOK_ID,
SUM(QUANTITY)
FROM ORDERS
WHERE DISPATCH_DATE >= TO_DATE('2018-01-01','YYYY-MM-DD')
AND DISPATCH_DATE <= TO_DATE('2018-12-31','YYYY-MM-DD')
GROUP BY BOOK_ID
HAVING SUM(QUANTITY) < 10;

--SECOND CONDITION: EXCLUDING BOOKS THAT HAVE BEEN AVAILABLE FOR LESS THAN 1 MONTH FROM TODAY. (I.E. EXCLUDE THE BOOKS THAT ARE TOO RECENT)
SELECT *
FROM BOOKS
WHERE AVAILABLE_FROM < TO_DATE('2019-06-23','YYYY-MM-DD') - 30;

--FINAL
SELECT B.BOOK_ID,
B.NAME
FROM 
(
	SELECT BOOK_ID,
	NAME
	FROM BOOKS
	WHERE AVAILABLE_FROM < TO_DATE('2019-06-23','YYYY-MM-DD') - 30
) B,
(
	SELECT BOOK_ID,
	SUM(QUANTITY)
	FROM ORDERS
	WHERE DISPATCH_DATE >= TO_DATE('2018-01-01','YYYY-MM-DD') --last year
	AND DISPATCH_DATE <= TO_DATE('2018-12-31','YYYY-MM-DD')
	GROUP BY BOOK_ID
	HAVING SUM(QUANTITY) < 10
) O
WHERE B.BOOK_ID = O.BOOK_ID (+);