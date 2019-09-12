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
CREATE TABLE Employee (Id int, Name varchar(255), Salary int, DepartmentId int);
CREATE TABLE Department (Id int, Name varchar(255));
TRUNCATE TABLE Employee;
INSERT ALL
INTO Employee (Id, Name, Salary, DepartmentId) VALUES ('1', 'Joe', '70000', '1')
INTO Employee (Id, Name, Salary, DepartmentId) VALUES ('2', 'Jim', '90000', '1')
INTO Employee (Id, Name, Salary, DepartmentId) VALUES ('3', 'Henry', '80000', '2')
INTO Employee (Id, Name, Salary, DepartmentId) VALUES ('4', 'Sam', '60000', '2')
INTO Employee (Id, Name, Salary, DepartmentId) VALUES ('5', 'Max', '90000', '1')
SELECT * FROM DUAL;
SELECT * FROM EMPLOYEE;

TRUNCATE TABLE Department;
INSERT ALL
INTO Department (Id, Name) VALUES ('1', 'IT')
INTO Department (Id, Name) VALUES ('2', 'Sales')
SELECT * FROM DUAL;
SELECT * FROM DEPARTMENT;



--CAN HAVE SAME HIGHEST SALARY IN THE SAME DEPARTMENT
--THEN I CANNOT JUST USE MAX... => SO I GET MAX AND THEN COMPARE THE SALARY OF THAT DEPARTMENT TO THE MAX

SELECT D.NAME AS Department,
E.NAME AS Employee,
E.SALARY AS Salary
FROM EMPLOYEE E,
DEPARTMENT D,
(
SELECT MAX(SALARY) AS MAX_SAL,
DEPARTMENTID MAX_DEPARTID
FROM EMPLOYEE
GROUP BY DEPARTMENTID
) M
WHERE E.DepartmentId=D.Id
AND E.SALARY = M.MAX_SAL
AND E.DEPARTMENTID = M.MAX_DEPARTID;


-- [METHOD 1]
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
AND E.DEPARTMENTID=M.DEPARTMENTID;


--[METHOD 2]
SELECT EE.NAME AS DEPARTMENT
     , E.NAME AS EMPLOYEE
     , EE.MAX_SAL AS SALARY
FROM EMPLOYEE E,
    (
    SELECT MAX(E.SALARY) AS MAX_SAL
        , E.DEPARTMENTID --POSSIBLE BECAUSE I GROUP BY IT
        , D.NAME ---E.DEPARTMENTID AND D.NAME ARE ACUTUALLY THE SAME THING
    FROM EMPLOYEE E,
         DEPARTMENT D
    WHERE E.DEPARTMENTID = D.ID
    GROUP BY E.DEPARTMENTID, D.NAME
    ) EE
WHERE 1=1
AND EE.MAX_SAL = E.SALARY
AND E.DEPARTMENTID = EE.DEPARTMENTID -- BE CAREFUL! DATA CAN BE SAME MAX_SAL BUT DIFFERENT DEPARTMENT

-- {"Employee": [[1, "Joe", 60000, 1], [4, "Max", 60000, 2]], 
-- "Department": [[1, "IT"], [2, "HR"]]}}
