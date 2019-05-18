/*
Create table If Not Exists Logs (Id int, Num int)
Truncate table Logs
insert into Logs (Id, Num) values ('1', '1')
insert into Logs (Id, Num) values ('2', '1')
insert into Logs (Id, Num) values ('3', '1')
insert into Logs (Id, Num) values ('4', '2')
insert into Logs (Id, Num) values ('5', '1')
insert into Logs (Id, Num) values ('6', '2')
insert into Logs (Id, Num) values ('7', '2')

Write a SQL query to find all numbers that appear at least three times consecutively.

+----+-----+
| Id | Num |
+----+-----+
| 1  |  1  |
| 2  |  1  |
| 3  |  1  |
| 4  |  2  |
| 5  |  1  |
| 6  |  2  |
| 7  |  2  |
+----+-----+
For example, given the above Logs table, 1 is the only number that appears consecutively for at least three times.

+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
*/


--[METHOD 1]
SELECT DISTINCT(L.NUM1) AS CONSECUTIVENUMS
FROM (
    SELECT ID, NUM AS NUM1, 
               LAG(NUM,1) OVER (ORDER BY ID) AS NUM2, 
               LAG(NUM,2) OVER (ORDER BY ID) AS NUM3
    FROM LOGS
    ) L
WHERE 1=1
AND L.NUM1=L.NUM2
AND L.NUM2=L.NUM3 --in the end, start from the first one

--[BE CAREFUL!]
-- INPUT: {"headers": {"Logs": ["Id", "Num"]}, "rows": {"Logs": [[1, 3], [2, 3], [3, 3], [4, 3]]}}
-- EXPECTED:{"headers":["ConsecutiveNums"],"values":[[3]]}
-- => IF JUST WRITE L.NUM1, RESULT IS:{"headers":["CONSECUTIVENUMS"],"values":[[3],[3]]}



--[METHOD 2]
SELECT DISTINCT(L.NUM1) AS CONSECUTIVENUMS
FROM (
    SELECT ID
         , NUM AS NUM1
         , LAG(NUM)  OVER (ORDER BY ID) AS NUM2
         , LEAD(NUM) OVER (ORDER BY ID) AS NUM3
    FROM LOGS
    ) L
WHERE 1=1
AND L.NUM1=L.NUM2
AND L.NUM2=L.NUM3 --in the end, start from the middle one
