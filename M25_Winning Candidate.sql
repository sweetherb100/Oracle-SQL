/*Table: Candidate
+-----+---------+
| id  | Name    |
+-----+---------+
| 1   | A       |
| 2   | B       |
| 3   | C       |
| 4   | D       |
| 5   | E       |
+-----+---------+  

Table: Vote
+-----+--------------+
| id  | CandidateId  |
+-----+--------------+
| 1   |     2        |
| 2   |     4        |
| 3   |     3        |
| 4   |     2        |
| 5   |     5        |
+-----+--------------+
id is the auto-increment primary key,
CandidateId is the id appeared in Candidate table.

Write a sql to find the name of the winning candidate, the above example will return the winner B.

+------+
| Name |
+------+
| B    |
+------+
Notes:
You may assume there is no tie, in other words there will be at most one winning candidate.*/
DROP TABLE CANDIDATE;
CREATE TABLE CANDIDATE (ID INT, NAME VARCHAR(255));
TRUNCATE TABLE CANDIDATE;
INSERT ALL
INTO CANDIDATE (ID, NAME) VALUES ('1', 'A')
INTO CANDIDATE (ID, NAME) VALUES ('2', 'B')
INTO CANDIDATE (ID, NAME) VALUES ('3', 'C')
INTO CANDIDATE (ID, NAME) VALUES ('4', 'D')
INTO CANDIDATE (ID, NAME) VALUES ('5', 'E')
SELECT * FROM DUAL;
SELECT * FROM CANDIDATE;

DROP TABLE VOTE;
CREATE TABLE VOTE (ID INT, CANDIDATEID INT);
TRUNCATE TABLE VOTE;
INSERT ALL
INTO VOTE (ID, CANDIDATEID) VALUES ('1', '2')
INTO VOTE (ID, CANDIDATEID) VALUES ('2', '4')
INTO VOTE (ID, CANDIDATEID) VALUES ('3', '3')
INTO VOTE (ID, CANDIDATEID) VALUES ('4', '2')
INTO VOTE (ID, CANDIDATEID) VALUES ('5', '5')
SELECT * FROM DUAL;
SELECT * FROM VOTE;

--GUARANTEE TO HAVE ONLY 1 MAXIMUM
SELECT C.NAME
FROM CANDIDATE C,
(
	SELECT CANDIDATEID,
	COUNT(CANDIDATEID) CNT_CAN_ID
	FROM VOTE
	GROUP BY CANDIDATEID
	HAVING COUNT(CANDIDATEID) = (SELECT MAX(COUNT(CANDIDATEID)) -- THIS CANNOT BE USED WITH CANDIDATEID 
								FROM VOTE 
								GROUP BY CANDIDATEID)
) V
WHERE C.ID = V.CANDIDATEID;