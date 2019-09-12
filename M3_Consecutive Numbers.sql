/*
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

CREATE TABLE Logs (Id int, Num int);
TRUNCATE TABLE Logs;
INSERT ALL
INTO Logs (Id, Num) VALUES ('1', '1')
INTO Logs (Id, Num) VALUES ('2', '1')
INTO Logs (Id, Num) VALUES ('3', '1')
INTO Logs (Id, Num) VALUES ('4', '1')
INTO Logs (Id, Num) VALUES ('5', '2')
INTO Logs (Id, Num) VALUES ('6', '1')
INTO Logs (Id, Num) VALUES ('7', '2')
INTO Logs (Id, Num) VALUES ('8', '2')
SELECT * FROM DUAL;
SELECT * FROM LOGS;


--I have a feeling that I should approach with LAG!!!

SELECT ID,
NUM,
LAG(NUM,1) OVER (ORDER BY ID) PREV_NUM,
LAG(NUM,2) OVER (ORDER BY ID) PREV2_NUM
FROM LOGS;
WHERE NUM = PREV_NUM  --WRONG!!! CANNOT USE ALIAS OF THE SELECT BUT NEED TO MAKE TEMP TABLE!!!
AND PREV_NUM = PREV2_NUM;


SELECT
DISTINCT(P.NUM),
P.ID
--P.PREV_NUM,
--P.PREV2_NUM
FROM
		(
		SELECT ID,
		NUM,
		LAG(NUM,1) OVER (ORDER BY ID) PREV_NUM,
		LAG(NUM,2) OVER (ORDER BY ID) PREV2_NUM
		FROM LOGS
		) P
WHERE P.NUM = P.PREV_NUM
AND P.PREV_NUM = P.PREV2_NUM;


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
AND L.NUM2=L.NUM3 --in the end, start from the "first" one

--[BE CAREFUL!]
-- INPUT: "Logs": [[1, 3], [2, 3], [3, 3], [4, 3]]
-- EXPECTED:"values":[[3]]
-- => IF JUST WRITE L.NUM1, RESULT IS:"values":[[3],[3]]



--[METHOD 2]
SELECT DISTINCT(L.NUM1) AS CONSECUTIVENUMS
FROM (
    SELECT ID
         , NUM AS NUM1
         , LAG(NUM)  OVER (ORDER BY ID) AS NUM2
         , LEAD(NUM) OVER (ORDER BY ID) AS NUM3 --LEAD, INSTEAD OF LAG
    FROM LOGS
    ) L
WHERE 1=1
AND L.NUM1=L.NUM2
AND L.NUM2=L.NUM3 --in the end, start from the "middle" one
