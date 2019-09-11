/*
Mary is a teacher in a middle school and she has a table seat storing students' names and their corresponding seat ids.
The column id is continuous increment.
Mary wants to change seats for the adjacent students.
 
Can you write a SQL query to output the result for Mary?
 

+---------+---------+
|    id   | student |
+---------+---------+
|    1    | Abbot   |
|    2    | Doris   |
|    3    | Emerson |
|    4    | Green   |
|    5    | Jeames  |
+---------+---------+
For the sample input, the output is:
 

+---------+---------+
|    id   | student |
+---------+---------+
|    1    | Doris   |
|    2    | Abbot   |
|    3    | Green   |
|    4    | Emerson |
|    5    | Jeames  |
+---------+---------+
Note:
If the number of students is odd, there is no need to change the last one's seat.
*/

CREATE TABLE seat(id int, student varchar(255));
TRUNCATE TABLE seat;
INSERT ALL
INTO seat (id, student) VALUES ('1', 'Abbot')
INTO seat (id, student) VALUES ('2', 'Doris')
INTO seat (id, student) VALUES ('3', 'Emerson')
INTO seat (id, student) VALUES ('4', 'Green')
INTO seat (id, student) VALUES ('5', 'Jeames')
SELECT * FROM DUAL;
SELECT * FROM SEAT;



--[METHOD 1]
SELECT --SHOULD CONSIDER THE CASE ODD/EVEN NUM OF ROWS 
(CASE WHEN MOD(ID,2)=0 THEN ID-1
      WHEN MOD(ID,2)=1 AND ID=C.CNT THEN ID
      WHEN MOD(ID,2)=1 AND ID != C.CNT THEN ID+1
END) AS ID,
        STUDENT
FROM SEAT S,
     (SELECT COUNT(ID) AS CNT
      FROM SEAT) C
ORDER BY ID


--[METHOD 2]
SELECT ID
     , DECODE(M, 0, PRE_S, NVL(PST_S, STUDENT)) STUDENT
  FROM (
        SELECT ID
             , MOD(ID, 2) M
             , STUDENT
             , LAG (STUDENT) OVER (ORDER BY ID) PRE_S
             , LEAD(STUDENT) OVER (ORDER BY ID) PST_S
          FROM SEAT
       )
