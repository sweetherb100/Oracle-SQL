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
In case of a tie, report all employees with the maximum number of experience years.

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

DROP TABLE Project;
CREATE TABLE Project (project_id int, employee_id int);
TRUNCATE TABLE Project;
INSERT ALL
INTO Project (project_id, employee_id) VALUES ('1', '1')
INTO Project (project_id, employee_id) VALUES ('1', '2')
INTO Project (project_id, employee_id) VALUES ('1', '3')
INTO Project (project_id, employee_id) VALUES ('2', '1')
INTO Project (project_id, employee_id) VALUES ('2', '4')
SELECT * FROM DUAL;
SELECT * FROM Project;

DROP TABLE Employee;
CREATE TABLE Employee (employee_id int, name varchar(255), experience_years int);
TRUNCATE TABLE Employee;
INSERT ALL
INTO Employee (employee_id, name, experience_years) VALUES ('1', 'Khaled', '3')
INTO Employee (employee_id, name, experience_years) VALUES ('2', 'Ali', '2')
INTO Employee (employee_id, name, experience_years) VALUES ('3', 'John', '3')
INTO Employee (employee_id, name, experience_years) VALUES ('4', 'Doe', '2')
SELECT * FROM DUAL;
SELECT * FROM Employee;

--WRONG (1): NOT THE RIGHT WAY TO USE MAX
SELECT EMPLOYEE_ID
FROM EMPLOYEE E
WHERE EXPERIENCE_YEARS = MAX(EXPERIENCE_YEARS);
							
SELECT EMPLOYEE_ID
FROM EMPLOYEE E
WHERE EXPERIENCE_YEARS = (SELECT MAX(EXPERIENCE_YEARS)
								FROM EMPLOYEE);
				
							
							
SELECT DISTINCT P.PROJECT_ID, P.EMPLOYEE_ID -- I CAN USE DISTINCT FOR 2 COLUMNS (distinct for the combination of column)
FROM Project P,
	(
	SELECT EMPLOYEE_ID
	FROM EMPLOYEE E
	WHERE EXPERIENCE_YEARS = (SELECT MAX(EXPERIENCE_YEARS)
									FROM EMPLOYEE)
	) T
WHERE T.EMPLOYEE_ID = P.EMPLOYEE_ID
ORDER BY P.PROJECT_ID, P.EMPLOYEE_ID;