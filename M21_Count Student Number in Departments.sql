/*A university uses 2 data tables, student and department, to store data about its students and the departments associated with each major.

Write a query to print the respective department name and number of students majoring in each department for all departments in the department table 
(even ones with no current students).

Sort your results by descending number of students; 
if two or more departments have the same number of students, then sort those departments alphabetically by department name.

The student is described as follow:
| Column Name  | Type      |
|--------------|-----------|
| student_id   | Integer   |
| student_name | String    |
| gender       | Character |
| dept_id      | Integer   |
where student_id is the student ID number, 
student_name is the student name, 
gender is their gender, 
and dept_id is the department ID associated with their declared major.

And the department table is described as below:
| Column Name | Type    |
|-------------|---------|
| dept_id     | Integer |
| dept_name   | String  |
where dept_id is the department ID number 
and dept_name is the department name.

Here is an example input:
student table:
| student_id | student_name | gender | dept_id |
|------------|--------------|--------|---------|
| 1          | Jack         | M      | 1       |
| 2          | Jane         | F      | 1       |
| 3          | Mark         | M      | 2       |

department table:
| dept_id | dept_name   |
|---------|-------------|
| 1       | Engineering |
| 2       | Science     |
| 3       | Law         |

The Output should be:
| dept_name   | student_number |
|-------------|----------------|
| Engineering | 2              |
| Science     | 1              |
| Law         | 0              |*/

DROP TABLE STUDENT;
CREATE TABLE STUDENT (STUDENT_ID INT, STUDENT_NAME VARCHAR(255), GENDER VARCHAR(255), DEPT_ID INT);
TRUNCATE TABLE STUDENT;
INSERT ALL
INTO STUDENT (STUDENT_ID, STUDENT_NAME, GENDER, DEPT_ID) VALUES ('1', 'JACK', 'M', '1')
INTO STUDENT (STUDENT_ID, STUDENT_NAME, GENDER, DEPT_ID) VALUES ('2', 'JANE', 'F', '1')
INTO STUDENT (STUDENT_ID, STUDENT_NAME, GENDER, DEPT_ID) VALUES ('3', 'MARK', 'M', '2')
SELECT * FROM DUAL;
SELECT * FROM STUDENT;

DROP TABLE DEPARTMENT;
CREATE TABLE DEPARTMENT (DEPT_ID INT, DEPT_NAME VARCHAR(255));
TRUNCATE TABLE DEPARTMENT;
INSERT ALL
INTO DEPARTMENT (DEPT_ID, DEPT_NAME) VALUES ('1', 'ENGINEERING')
INTO DEPARTMENT (DEPT_ID, DEPT_NAME) VALUES ('2', 'SCIENCE')
INTO DEPARTMENT (DEPT_ID, DEPT_NAME) VALUES ('3', 'LAW')
SELECT * FROM DUAL;
SELECT * FROM DEPARTMENT;


SELECT D.DEPT_NAME,
NVL(S.CNT_STD, 0) STUDENT_NUMBER
FROM DEPARTMENT D,
(
	SELECT COUNT(STUDENT_ID) CNT_STD,
	DEPT_ID
	FROM STUDENT
	GROUP BY DEPT_ID
) S
WHERE D.DEPT_ID = S.DEPT_ID (+); --OUTER JOIN