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

DROP TABLE Candidate;
CREATE TABLE Candidate (id int, name varchar(255));
TRUNCATE TABLE Candidate;
INSERT ALL
INTO Candidate (id, name) VALUES ('1', 'A')
INTO Candidate (id, name) VALUES ('2', 'B')
INTO Candidate (id, name) VALUES ('3', 'C')
INTO Candidate (id, name) VALUES ('4', 'D')
INTO Candidate (id, name) VALUES ('5', 'E')
SELECT * FROM DUAL;
SELECT * FROM Candidate;

DROP TABLE Vote;
CREATE TABLE Vote (id int, CandidateId int);
TRUNCATE TABLE Vote;
INSERT ALL
INTO Vote (id, CandidateId) VALUES ('1', '2')
INTO Vote (id, CandidateId) VALUES ('2', '4')
INTO Vote (id, CandidateId) VALUES ('3', '3')
INTO Vote (id, CandidateId) VALUES ('4', '2')
INTO Vote (id, CandidateId) VALUES ('5', '5')
SELECT * FROM DUAL;
SELECT * FROM Vote;

SELECT CandidateId,
count(CandidateId) cnt_can_id
FROM vote
GROUP BY CandidateId
HAVING count(candidateId) = (SELECT max(count(CandidateId)) -- this cannot be used with CandidateId 
							FROM vote 
							GROUP BY CandidateId);

SELECT C.name
FROM Candidate C,
(
SELECT CandidateId,
count(CandidateId) cnt_can_id
FROM vote
GROUP BY CandidateId
HAVING count(candidateId) = (SELECT max(count(CandidateId)) -- this cannot be used with CandidateId 
							FROM vote 
							GROUP BY CandidateId)
) V
WHERE C.id = V.CandidateId