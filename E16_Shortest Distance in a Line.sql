/*
Table point holds the x coordinate of some points on x-axis in a plane, which are all integers.
Write a query to find the shortest distance between two points in these points.

| x   |
|-----|
| -1  |
| 0   |
| 2   |
The shortest distance is '1' obviously, which is from point '-1' to '0'. So the output is as below:

| shortest|
|---------|
| 1       |
Note: Every point is unique, which means there is no duplicates in table point.

Follow-up: What if all these points have an id and are arranged from the left most to the right most of x axis?
*/

DROP TABLE Xaxis;
CREATE TABLE Xaxis (point int);
TRUNCATE TABLE Xaxis;
INSERT ALL
INTO Xaxis (point) VALUES ('-1')
INTO Xaxis (point) VALUES ('0')
INTO Xaxis (point) VALUES ('2')
SELECT * FROM DUAL;
SELECT * FROM Xaxis;

SELECT POINT PT,
LAG(POINT) OVER (ORDER BY POINT) NEXT_PT
--PT-NEXT_PT DIFF --ERROR, CANNOT USE ALIAS ITSELF. THEREFORE, NEED TO MAKE TEMP TABLE
FROM Xaxis
ORDER BY POINT;


SELECT MIN(PT-NEXT_PT) shortest
FROM (
SELECT POINT PT,
LAG(POINT) OVER (ORDER BY POINT) NEXT_PT
FROM Xaxis
ORDER BY POINT
);
