/*
Create table If Not Exists Employee (Id int, Salary int)
Truncate table Employee
insert into Employee (Id, Salary) values ('1', '100')
insert into Employee (Id, Salary) values ('2', '200')
insert into Employee (Id, Salary) values ('3', '300')


Write a SQL query to get the second highest salary from the Employee table.

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
For example, given the above Employee table, the query should return 200 as the second highest salary. If there is no second highest salary, then the query should return null.

+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
*/

--[METHOD 1]: key is "second largest"
SELECT MAX(Salary) as SecondHighestSalary
FROM Employee
WHERE Salary < (
                SELECT MAX(salary)
                FROM Employee
                )


--[METHOD 2]
SELECT NVL(
           (
            SELECT SALARY
              FROM 
                   (
                    SELECT ID
                         , SALARY
                         , DENSE_RANK () OVER (ORDER BY SALARY DESC) RN
                      FROM EMPLOYEE
                   ) A
            WHERE RN = 2
              AND ROWNUM = 1
           ), NULL
     ) AS "SecondHighestSalary"
 FROM DUAL
