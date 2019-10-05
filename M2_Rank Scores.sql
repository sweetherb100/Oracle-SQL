/*
Write a SQL query to rank scores. 

If there is a tie between two scores, both should have the same ranking. 
Note that after a tie, the next ranking number should be the next consecutive integer value. 
In other words, there should be no "holes" between ranks.

+----+-------+
| Id | Score |
+----+-------+
| 1  | 3.50  |
| 2  | 3.65  |
| 3  | 4.00  |
| 4  | 3.85  |
| 5  | 4.00  |
| 6  | 3.65  |
+----+-------+
For example, given the above Scores table, your query should generate the following report (order by highest score):

+-------+------+
| Score | Rank |
+-------+------+
| 4.00  | 1    |
| 4.00  | 1    |
| 3.85  | 2    |
| 3.65  | 3    |
| 3.65  | 3    |
| 3.50  | 4    |
+-------+------+
*/

CREATE TABLE SCORES (ID INT, SCORE DECIMAL(3,2));
TRUNCATE TABLE SCORES;
INSERT ALL
INTO SCORES (ID, SCORE) VALUES ('1', '3.5')
INTO SCORES (ID, SCORE) VALUES ('2', '3.65')
INTO SCORES (ID, SCORE) VALUES ('3', '4.0')
INTO SCORES (ID, SCORE) VALUES ('4', '3.85')
INTO SCORES (ID, SCORE) VALUES ('5', '4.0')
INTO SCORES (ID, SCORE) VALUES ('6', '3.65')
SELECT * FROM DUAL;
SELECT * FROM SCORES;

--[METHOD 1]
SELECT ROUND(SCORE,2) AS SCORE, --I NEEED TO WRITE ROUND TO GET SUCCESS BUT DONT KNOW WHY
DENSE_RANK() OVER(ORDER BY SCORE DESC) AS RANK
FROM SCORES
ORDER BY SCORE DESC;


--COMPARE WITH DENSE_RANK()
SELECT ROUND(SCORE,2) AS SCORE,
RANK() OVER(ORDER BY SCORE DESC) AS RANK
FROM SCORES
ORDER BY SCORE DESC;
