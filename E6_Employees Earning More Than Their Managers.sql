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
Given the Employee table, write a SQL query that finds out employees who earn more than their managers. 
For the above table, Joe is the only employee who earns more than his manager.

+----------+
| Employee |
+----------+
| Joe      |
+----------+
*/

DROP TABLE EMPLOYEE;
CREATE TABLE EMPLOYEE (ID INT, NAME VARCHAR(255), SALARY INT, MANAGERID INT);
TRUNCATE TABLE EMPLOYEE;
INSERT ALL
INTO EMPLOYEE (ID, NAME, SALARY, MANAGERID) VALUES ('1', 'JOE', '70000', '3')
INTO EMPLOYEE (ID, NAME, SALARY, MANAGERID) VALUES ('2', 'HENRY', '80000', '4')
INTO EMPLOYEE (ID, NAME, SALARY) VALUES ('3', 'SAM', '60000')
INTO EMPLOYEE (ID, NAME, SALARY) VALUES ('4', 'MAX', '90000')
SELECT * FROM DUAL;
SELECT * FROM EMPLOYEE;


-- [METHOD 1]
SELECT E.NAME AS EMPLOYEE
FROM EMPLOYEE E, 
EMPLOYEE M
WHERE E.MANAGERID= M.ID --SELF JOIN
AND E.SALARY > M.SALARY


--[METHOD 2]
SELECT E.NAME AS EMPLOYEE
FROM EMPLOYEE E
WHERE EXISTS (
               SELECT 1
                 FROM EMPLOYEE M
                WHERE E.MANAGERID = M.ID
                  AND E.SALARY > M.SALARY
              );
