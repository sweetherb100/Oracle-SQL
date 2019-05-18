/*
Create table If Not Exists Weather (Id int, RecordDate date, Temperature int)
Truncate table Weather
insert into Weather (Id, RecordDate, Temperature) values ('1', '2015-01-01', '10')
insert into Weather (Id, RecordDate, Temperature) values ('2', '2015-01-02', '25')
insert into Weather (Id, RecordDate, Temperature) values ('3', '2015-01-03', '20')
insert into Weather (Id, RecordDate, Temperature) values ('4', '2015-01-04', '30')


Given a Weather table, write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.

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

--[METHOD 1]
SELECT B.Id
FROM Weather A, Weather B
WHERE A.RecordDate+1=B.RecordDate -- +1 indicate +one day
                                  -- think of it as self join (I want to put it aside)
AND B.Temperature > A.Temperature


--[METHOD 2]
SELECT ID
  FROM (
        SELECT ID,
        RECORDDATE RD,
        TEMPERATURE T,
        LAG (RECORDDATE ) OVER (ORDER BY RECORDDATE) PRE_RD, --ONE ROW BEFORE
        LAG (TEMPERATURE) OVER (ORDER BY RECORDDATE) PRE_T --ONE ROW BEFORE
        FROM WEATHER
       )
 WHERE PRE_RD + 1 = RD --NEEDED IN CASE THE DATA IS:
 --{"headers": {"Weather": ["Id", "RecordDate", "Temperature"]}, "rows": {"Weather": [[1, "2000-12-14", 3], [2, "2000-12-16", 5]]}}
 AND PRE_T < T
 


--[REFERENCE]
SELECT ID,
RECORDDATE RD,
TEMPERATURE T,
LAG (RECORDDATE ) OVER (ORDER BY RECORDDATE) PRE_RD,
LAG (TEMPERATURE) OVER (ORDER BY RECORDDATE) PRE_T
FROM WEATHER

/*
{"headers":["ID","RD","T","PRE_RD","PRE_T"],
"values":[[1,"2015-01-01 00:00:00",10,null,null],
          [2,"2015-01-02 00:00:00",25,"2015-01-01 00:00:00",10],
          [3,"2015-01-03 00:00:00",20,"2015-01-02 00:00:00",25],
          [4,"2015-01-04 00:00:00",30,"2015-01-03 00:00:00",20]]}

*/
