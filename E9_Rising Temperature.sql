/*
Given a Weather table, write a SQL query to find all dates' Ids with higher temperature compared to its !!!previous (yesterday's)!!! dates.

+---------+------------------+------------------+
| Id(INT) | RecordDate(DATE) | Temperature(INT) |
+---------+------------------+------------------+
|       1 |       2015-01-01 |               10 |
|       2 |       2015-01-02 |               25 |
|       3 |       2015-01-03 |               20 |
|       4 |       2015-01-04 |               30 |
+---------+------------------+------------------+
For example, return the following Ids for the above Weather table:

+----+
| Id |
+----+
|  2 |
|  4 |
+----+
*/

CREATE TABLE WEATHER (ID INT, RECORDDATE DATE, TEMPERATURE INT);
TRUNCATE TABLE WEATHER;
INSERT ALL
INTO WEATHER (ID, RECORDDATE, TEMPERATURE) VALUES ('1', TO_DATE('2015-01-01','YYYY-MM-DD'), '10')
INTO WEATHER (ID, RECORDDATE, TEMPERATURE) VALUES ('2', TO_DATE('2015-01-02','YYYY-MM-DD'), '25')
INTO WEATHER (ID, RECORDDATE, TEMPERATURE) VALUES ('3', TO_DATE('2015-01-03','YYYY-MM-DD'), '20')
INTO WEATHER (ID, RECORDDATE, TEMPERATURE) VALUES ('4', TO_DATE('2015-01-04','YYYY-MM-DD'), '30')
INTO WEATHER (ID, RECORDDATE, TEMPERATURE) VALUES ('5', TO_DATE('2015-01-14','YYYY-MM-DD'), '5')
INTO WEATHER (ID, RECORDDATE, TEMPERATURE) VALUES ('6', TO_DATE('2015-01-16','YYYY-MM-DD'), '7') --EXCEPTION CASE 
SELECT * FROM DUAL;
SELECT * FROM WEATHER;


--LAG() OVER(ORDER BY )
SELECT ID,
RECORDDATE RD,
TEMPERATURE T,
LAG (RECORDDATE) OVER (ORDER BY RECORDDATE) PRE_RD, --ONE ROW BEFORE
LAG (TEMPERATURE) OVER (ORDER BY RECORDDATE) PRE_T --ONE ROW BEFORE
FROM WEATHER;
        
--FINAL
SELECT ID
  FROM (
        SELECT ID,
        RECORDDATE RD,
        TEMPERATURE T,
        LAG (RECORDDATE) OVER (ORDER BY RECORDDATE) PRE_RD, --ONE ROW BEFORE
        LAG (TEMPERATURE) OVER (ORDER BY RECORDDATE) PRE_T --ONE ROW BEFORE
        FROM WEATHER
       )
 WHERE PRE_RD + 1 = RD --NEEDED IN CASE THE DATA IS:[1, "2000-12-14", 3], [2, "2000-12-16", 5]
 AND PRE_T < T;

