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

Write an SQL query that reports all the projects that have the most employees.

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
| 3           | John   | 1                |
| 4           | Doe    | 2                |
+-------------+--------+------------------+

Result table:
+-------------+
| project_id  |
+-------------+
| 1           |
+-------------+
The first project has 3 employees while the second one has 2.*/

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

/*DROP TABLE Employee;
CREATE TABLE Employee (employee_id int, name varchar(255), experience_years int);
TRUNCATE TABLE Employee;
INSERT ALL
INTO Employee (employee_id, name, experience_years) VALUES ('1', 'Khaled', '3')
INTO Employee (employee_id, name, experience_years) VALUES ('2', 'Ali', '2')
INTO Employee (employee_id, name, experience_years) VALUES ('3', 'John', '1')
INTO Employee (employee_id, name, experience_years) VALUES ('4', 'Doe', '2')
SELECT * FROM DUAL;
SELECT * FROM Employee;*/

--WANTED TO DO WITH PARTITION BY BUT IT DOESNT WORK
SELECT PROJECT_ID,
EMPLOYEE_ID,
RANK() OVER (PARTITION BY PROJECT_ID ORDER BY EMPLOYEE_ID) EMP_RANK
FROM PROJECT;

--CONSIDER THAT THERE MIGHT BE MULTIPLE MAX
--FINAL
SELECT PROJECT_ID
FROM
(
	SELECT PROJECT_ID,
	ORDER_CNT,
	RANK() OVER (ORDER BY ORDER_CNT DESC) RNK
	FROM
	(
		SELECT PROJECT_ID,
		COUNT(EMPLOYEE_ID) ORDER_CNT
		FROM PROJECT
		GROUP BY PROJECT_ID
	)
)
WHERE RNK = 1;
