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
Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits.

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
+-------------+---------------+
| project_id  | average_years |
+-------------+---------------+
| 1           | 2.00          |
| 2           | 2.50          |
+-------------+---------------+
The average experience years for the first project is (3 + 2 + 1) / 3 = 2.00 and for the second project is (3 + 2) / 2 = 2.50*/


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
INTO EMPLOYEE (EMPLOYEE_ID, NAME, EXPERIENCE_YEARS) VALUES ('3', 'JOHN', '1')
INTO EMPLOYEE (EMPLOYEE_ID, NAME, EXPERIENCE_YEARS) VALUES ('4', 'DOE', '2')
SELECT * FROM DUAL;
SELECT * FROM EMPLOYEE;


SELECT P.PROJECT_ID,
E.EXPERIENCE_YEARS
FROM PROJECT P,
EMPLOYEE E
WHERE P.EMPLOYEE_ID = E.EMPLOYEE_ID;

--FINAL
SELECT PP.PROJECT_ID,
ROUND(AVG(PP.EXPERIENCE_YEARS),2) AVERAGE_YEARS
FROM  
(
	SELECT P.PROJECT_ID,
	E.EXPERIENCE_YEARS
	FROM PROJECT P,
	EMPLOYEE E
	WHERE P.EMPLOYEE_ID = E.EMPLOYEE_ID
) PP
GROUP BY PP.PROJECT_ID;