/*Table: Enrollments
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| student_id    | int     |
| course_id     | int     |
| grade         | int     |
+---------------+---------+
(student_id, course_id) is the primary key of this table.

Write a SQL query to find the highest grade with its corresponding course for each student. 
!!! In case of a tie, you should find the course with the smallest course_id.  !!!!
The output must be sorted by increasing student_id.

The query result format is in the following example:
Enrollments table:
+------------+-------------------+
| student_id | course_id | grade |
+------------+-----------+-------+
| 2          | 2         | 95    |
| 2          | 3         | 95    |
| 1          | 1         | 90    |
| 1          | 2         | 99    |
| 3          | 1         | 80    |
| 3          | 2         | 75    |
| 3          | 3         | 82    |
+------------+-----------+-------+

Result table:
+------------+-------------------+
| student_id | course_id | grade |
+------------+-----------+-------+
| 1          | 2         | 99    |
| 2          | 2         | 95    |
| 3          | 3         | 82    |
+------------+-----------+-------+*/

CREATE TABLE ENROLLMENTS (STUDENT_ID INT, COURSE_ID INT, GRADE INT);
TRUNCATE TABLE ENROLLMENTS;
INSERT ALL
INTO ENROLLMENTS (STUDENT_ID, COURSE_ID, GRADE) VALUES ('2','2','95')
INTO ENROLLMENTS (STUDENT_ID, COURSE_ID, GRADE) VALUES ('2','3','95')
INTO ENROLLMENTS (STUDENT_ID, COURSE_ID, GRADE) VALUES ('1','1','90')
INTO ENROLLMENTS (STUDENT_ID, COURSE_ID, GRADE) VALUES ('1','2','99')
INTO ENROLLMENTS (STUDENT_ID, COURSE_ID, GRADE) VALUES ('3','1','80')
INTO ENROLLMENTS (STUDENT_ID, COURSE_ID, GRADE) VALUES ('3','2','75')
INTO ENROLLMENTS (STUDENT_ID, COURSE_ID, GRADE) VALUES ('3','3','82')
SELECT * FROM DUAL;
SELECT * FROM ENROLLMENTS;


--[METHOD 1]
SELECT STUDENT_ID,
COURSE_ID,
GRADE
FROM
(
	SELECT STUDENT_ID,
	COURSE_ID,
	GRADE,
	RANK() OVER (PARTITION BY STUDENT_ID ORDER BY GRADE DESC, COURSE_ID) RNK_GRADE
	FROM ENROLLMENTS
) E
WHERE RNK_GRADE =1;


--[METHOD 2]
SELECT E.STUDENT_ID,
MIN(E.COURSE_ID) AS COURSE_ID,
E.GRADE
FROM ENROLLMENTS E,
	(
	SELECT STUDENT_ID,
	MAX(GRADE) MAX_GRADE
	FROM ENROLLMENTS
	GROUP BY STUDENT_ID
	) T
WHERE E.STUDENT_ID = T.STUDENT_ID
AND E.GRADE = T.MAX_GRADE
GROUP BY E.STUDENT_ID, E.GRADE
ORDER BY E.STUDENT_ID;

