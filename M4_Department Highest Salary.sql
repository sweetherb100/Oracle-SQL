/*
The Employee table holds all employees. Every employee has an Id, a salary, and there is also a column for the department Id.

+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
The Department table holds all departments of the company.
+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+

Write a SQL query to find employees who have the highest salary in each of the departments. 
For the above tables, your SQL query should return the following rows (order of rows does not matter).

+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
+------------+----------+--------+
Explanation:

Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.
*/

DROP TABLE EMPLOYEE;
CREATE TABLE EMPLOYEE (ID INT, NAME VARCHAR(255), SALARY INT, DEPARTMENTID INT);
TRUNCATE TABLE EMPLOYEE;
INSERT ALL
INTO EMPLOYEE (ID, NAME, SALARY, DEPARTMENTID) VALUES ('1', 'JOE', '70000', '1')
INTO EMPLOYEE (ID, NAME, SALARY, DEPARTMENTID) VALUES ('2', 'JIM', '90000', '1')
INTO EMPLOYEE (ID, NAME, SALARY, DEPARTMENTID) VALUES ('3', 'HENRY', '80000', '2')
INTO EMPLOYEE (ID, NAME, SALARY, DEPARTMENTID) VALUES ('4', 'SAM', '60000', '2')
INTO EMPLOYEE (ID, NAME, SALARY, DEPARTMENTID) VALUES ('5', 'MAX', '90000', '1')
SELECT * FROM DUAL;
SELECT * FROM EMPLOYEE;

DROP TABLE DEPARTMENT;
CREATE TABLE DEPARTMENT (ID INT, NAME VARCHAR(255));
TRUNCATE TABLE DEPARTMENT;
INSERT ALL
INTO DEPARTMENT (ID, NAME) VALUES ('1', 'IT')
INTO DEPARTMENT (ID, NAME) VALUES ('2', 'SALES')
SELECT * FROM DUAL;
SELECT * FROM DEPARTMENT;

--Keep in mind there can be multiple same max within department

--[METHOD 1] 
SELECT D.NAME,
E.NAME,
E.SALARY
FROM DEPARTMENT D,
(
	SELECT DEPARTMENTID,
	NAME,
	SALARY,
	RANK() OVER (PARTITION BY DEPARTMENTID ORDER BY SALARY DESC) SAL_RANK
	FROM EMPLOYEE
) E
WHERE E.DEPARTMENTID = D.ID
AND E.SAL_RANK = 1; --MOST IMPORTANT PART


--[METHOD 2]
--Exception: CAN HAVE SAME HIGHEST SALARY IN THE SAME DEPARTMENT
--THEN I CANNOT JUST USE MAX... => SO I GET MAX AND THEN COMPARE THE SALARY OF THAT DEPARTMENT TO THE MAX
SELECT EE.NAME AS DEPARTMENT
     , E.NAME AS EMPLOYEE
     , EE.MAX_SAL AS SALARY
FROM EMPLOYEE E,
    (
    SELECT MAX(E.SALARY) AS MAX_SAL,
          E.DEPARTMENTID, --POSSIBLE BECAUSE I GROUP BY IT
          D.NAME ---E.DEPARTMENTID AND D.NAME ARE ACUTUALLY THE SAME THING
    FROM EMPLOYEE E,
         DEPARTMENT D
    WHERE E.DEPARTMENTID = D.ID
    GROUP BY E.DEPARTMENTID, D.NAME --GROUP BY 2 columns => already joined 2 tables
    ) EE
WHERE EE.MAX_SAL = E.SALARY
AND E.DEPARTMENTID = EE.DEPARTMENTID -- BE CAREFUL! DATA CAN BE SAME MAX_SAL BUT DIFFERENT DEPARTMENT
-- {"Employee": [[1, "Joe", 60000, 1], [4, "Max", 60000, 2]], 
-- "Department": [[1, "IT"], [2, "HR"]]}}


--[METHOD 3]
SELECT D.NAME AS DEPARTMENT,
        E.NAME AS EMPLOYEE,
        E.SALARY
FROM EMPLOYEE E,
    DEPARTMENT D,
    (
    SELECT MAX(SALARY) SALARY,
    DEPARTMENTID
    FROM EMPLOYEE
    GROUP BY DEPARTMENTID
    ) M --temp table just to get MAX group by departmentid
WHERE E.DEPARTMENTID=D.ID
AND E.SALARY= M.SALARY
AND E.DEPARTMENTID=M.DEPARTMENTID; -- BE CAREFUL! DATA CAN BE SAME MAX_SAL BUT DIFFERENT DEPARTMENT
