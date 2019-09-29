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

DROP TABLE student;
CREATE TABLE student (student_id int, student_name varchar(255), gender varchar(255), dept_id int);
TRUNCATE TABLE student;
INSERT ALL
INTO student (student_id, student_name, gender, dept_id) VALUES ('1', 'Jack', 'M', '1')
INTO student (student_id, student_name, gender, dept_id) VALUES ('2', 'Jane', 'F', '1')
INTO student (student_id, student_name, gender, dept_id) VALUES ('3', 'Mark', 'M', '2')
SELECT * FROM DUAL;
SELECT * FROM student;


DROP TABLE department;
CREATE TABLE department (dept_id int, dept_name varchar(255));
TRUNCATE TABLE department;
INSERT ALL
INTO department (dept_id, dept_name) VALUES ('1', 'Engineering')
INTO department (dept_id, dept_name) VALUES ('2', 'Science')
INTO department (dept_id, dept_name) VALUES ('3', 'Law')
SELECT * FROM DUAL;
SELECT * FROM department;

SELECT count(student_id) cnt_std,
dept_id
FROM STUDENT
GROUP BY dept_id;


SELECT D.dept_name,
NVL(S.cnt_std, 0) student_number
FROM department D,
(
SELECT count(student_id) cnt_std,
dept_id
FROM STUDENT
GROUP BY dept_id
) S
WHERE D.dept_id = S.dept_id (+);