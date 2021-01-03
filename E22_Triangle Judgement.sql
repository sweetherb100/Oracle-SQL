/*A student Tim gets homework to identify whether three line segments could possibly form a triangle.
However, this assignment is very heavy because there are hundreds of records to calculate.
Could you help Tim by writing a query to judge whether these three sides can form a triangle, assuming table triangle holds the length of the three sides x, y and z.

| x  | y  | z  |
|----|----|----|
| 13 | 15 | 30 |
| 10 | 20 | 15 |

For the sample data above, your query should return the follow result:
| x  | y  | z  | triangle |
|----|----|----|----------|
| 13 | 15 | 30 | No       |
| 10 | 20 | 15 | Yes      |*/

DROP TABLE TRIANGLE;
CREATE TABLE TRIANGLE (X INT, Y INT, Z INT);
TRUNCATE TABLE TRIANGLE;
INSERT ALL
INTO TRIANGLE (X, Y, Z) VALUES ('13', '15', '30')
INTO TRIANGLE (X, Y, Z) VALUES ('10', '20', '15')
SELECT * FROM DUAL;
SELECT * FROM TRIANGLE;

SELECT X, Y, Z,
CASE
	WHEN X+Y+Z-GREATEST(X,Y,Z) > GREATEST(X,Y,Z)
	THEN 'YES'
	ELSE 'NO'
END TRIANGLE
FROM TRIANGLE;

