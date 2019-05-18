/*
The Employee table holds all employees including their managers. Every employee has an Id, and there is also a column for the manager Id.

+----+-------+--------+-----------+
| Id | Name  | Salary | ManagerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | NULL      |
| 4  | Max   | 90000  | NULL      |
+----+-------+--------+-----------+
Given the Employee table, write a SQL query that finds out employees who earn more than their managers. For the above table, Joe is the only employee who earns more than his manager.

+----------+
| Employee |
+----------+
| Joe      |
+----------+
*/

-- [METHOD 1]
SELECT E.Name AS Employee
FROM Employee E, Employee M
WHERE 1=1
AND E.ManagerId= M.Id (+) --OUTER JOIN
--AND E.ManagerId IS NOT NULL
AND E.Salary > M.Salary
/*
1) E.ManagerId IS NOT NULL : is not needed
=> when searching COLUMN_NAME='ABC', 
if the data is NULL, it will not be selected (NULL is excluded automatically)
2) E.ManagerId != NULL (X)
3) don't need outer join
=> don't have to consider when there is no manager (i.e. itself is manager)
*/


-- [METHOD 2]
SELECT E.Name AS Employee
FROM Employee E, Employee M
WHERE 1=1
AND E.ManagerId= M.Id --SELF JOIN
AND E.Salary > M.Salary



--[METHOD 3]
SELECT E.NAME AS EMPLOYEE
FROM EMPLOYEE E
WHERE EXISTS (
               SELECT 1
                 FROM EMPLOYEE E1
                WHERE E.MANAGERID = E1.ID
                  AND E.SALARY > E1.SALARY
              )
