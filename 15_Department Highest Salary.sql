/*
Create table If Not Exists Employee (Id int, Name varchar(255), Salary int, DepartmentId int)
Create table If Not Exists Department (Id int, Name varchar(255))
Truncate table Employee
insert into Employee (Id, Name, Salary, DepartmentId) values ('1', 'Joe', '70000', '1')
insert into Employee (Id, Name, Salary, DepartmentId) values ('2', 'Jim', '90000', '1')
insert into Employee (Id, Name, Salary, DepartmentId) values ('3', 'Henry', '80000', '2')
insert into Employee (Id, Name, Salary, DepartmentId) values ('4', 'Sam', '60000', '2')
insert into Employee (Id, Name, Salary, DepartmentId) values ('5', 'Max', '90000', '1')
Truncate table Department
insert into Department (Id, Name) values ('1', 'IT')
insert into Department (Id, Name) values ('2', 'Sales')

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
Write a SQL query to find employees who have the highest salary in each of the departments. For the above tables, your SQL query should return the following rows (order of rows does not matter).

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


--[METHOD 1]
/*
SELECT MAX(E.SALARY) AS MAX_SAL
    , E.DEPARTMENTID --I CAN ALSO WRITE DEPARTMENTID BECAUSE I GROUP BY IT
    , D.NAME
FROM EMPLOYEE E,
     DEPARTMENT D
WHERE E.DEPARTMENTID = D.ID
GROUP BY E.DEPARTMENTID, D.NAME
    
{"headers":["MAX_SAL","DEPARTMENTID","NAME"],"values":[[80000,2,"Sales"],[90000,1,"IT"]]}
*/

-- [METHOD 1]
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



--[METHOD 2]
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
    ) M
WHERE E.DEPARTMENTID=D.ID
AND E.SALARY= M.SALARY
AND E.DEPARTMENTID=M.DEPARTMENTID