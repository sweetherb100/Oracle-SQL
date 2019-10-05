/*Table: Project
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| project_id  | int     |
| employee_id | int     |
+-------------+---------+
(project_id, employee_id) is the primary key of this table.
employee_id is a foreign key to Employee table.

Table: Employee
+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+
employee_id is the primary key of this table.

Write an SQL query that reports the most experienced employees in each project. 
!!! In case of a tie, report all employees with the maximum number of experience years. !!!

The query result format is in the following example:

Project table:
+-------------+-------------+
| project_id  | employee_id |
+-------------+-------------+
| 1           | 1           |
| 1           | 2           |
| 1           | 3           |
| 2           | 1           |
| 2           | 4           |
+-------------+-------------+

Employee table:
+-------------+--------+------------------+
| employee_id | name   | experience_years |
+-------------+--------+------------------+
| 1           | Khaled | 3                |
| 2           | Ali    | 2                |
| 3           | John   | 3                |
| 4           | Doe    | 2                |
+-------------+--------+------------------+

Result table:
+-------------+---------------+
| project_id  | employee_id   |
+-------------+---------------+
| 1           | 1             |
| 1           | 3             |
| 2           | 1             |
+-------------+---------------+
Both employees with id 1 and 3 have the most experience among the employees of the first project. 
For the second project, the employee with id 1 has the most experience.*/

DROP TABLE PROJECT;
CREATE TABLE PROJECT (PROJECT_ID INT, EMPLOYEE_ID INT);
TRUNCATE TABLE PROJECT;
INSERT ALL
INTO PROJECT (PROJECT_ID, EMPLOYEE_ID) VALUES ('1', '1')
INTO PROJECT (PROJECT_ID, EMPLOYEE_ID) VALUES ('1', '2')
INTO PROJECT (PROJECT_ID, EMPLOYEE_ID) VALUES ('1', '3')
INTO PROJECT (PROJECT_ID, EMPLOYEE_ID) VALUES ('2', '1')
INTO PROJECT (PROJECT_ID, EMPLOYEE_ID) VALUES ('2', '4')
SELECT * FROM DUAL;
SELECT * FROM PROJECT;

DROP TABLE EMPLOYEE;
CREATE TABLE EMPLOYEE (EMPLOYEE_ID INT, NAME VARCHAR(255), EXPERIENCE_YEARS INT);
TRUNCATE TABLE EMPLOYEE;
INSERT ALL
INTO EMPLOYEE (EMPLOYEE_ID, NAME, EXPERIENCE_YEARS) VALUES ('1', 'KHALED', '3')
INTO EMPLOYEE (EMPLOYEE_ID, NAME, EXPERIENCE_YEARS) VALUES ('2', 'ALI', '2')
INTO EMPLOYEE (EMPLOYEE_ID, NAME, EXPERIENCE_YEARS) VALUES ('3', 'JOHN', '3')
INTO EMPLOYEE (EMPLOYEE_ID, NAME, EXPERIENCE_YEARS) VALUES ('4', 'DOE', '2')
SELECT * FROM DUAL;
SELECT * FROM EMPLOYEE;


SELECT PROJECT_ID,
EMPLOYEE_ID
FROM 
(
	SELECT P.PROJECT_ID,
	P.EMPLOYEE_ID,
	E.EXPERIENCE_YEARS,
	RANK() OVER (PARTITION BY P.PROJECT_ID ORDER BY E.EXPERIENCE_YEARS DESC) RNK_YEARS
	FROM PROJECT P,
	EMPLOYEE E
	WHERE P.EMPLOYEE_ID = E.EMPLOYEE_ID
)
WHERE RNK_YEARS = 1;
