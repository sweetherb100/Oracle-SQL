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

DROP TABLE XAXIS;
CREATE TABLE XAXIS (POINT INT);
TRUNCATE TABLE XAXIS;
INSERT ALL
INTO XAXIS (POINT) VALUES ('-1')
INTO XAXIS (POINT) VALUES ('0')
INTO XAXIS (POINT) VALUES ('2')
SELECT * FROM DUAL;
SELECT * FROM XAXIS;

--WRONG
SELECT POINT PT,
LAG(POINT) OVER (ORDER BY POINT) NEXT_PT
--PT-NEXT_PT DIFF --ERROR, CANNOT USE ALIAS ITSELF. THEREFORE, NEED TO MAKE TEMP TABLE
FROM XAXIS
ORDER BY POINT;

--FINAL
SELECT MIN(PT-NEXT_PT) SHORTEST
FROM (
	SELECT POINT PT,
	LAG(POINT) OVER (ORDER BY POINT) NEXT_PT
	FROM XAXIS
	ORDER BY POINT
);
