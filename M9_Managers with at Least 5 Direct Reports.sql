/*
The Employee table holds all employees including their managers. 
Every employee has an Id, and there is also a column for the manager Id.

+------+----------+-----------+----------+
|Id    |Name 	  |Department |ManagerId |
+------+----------+-----------+----------+
|101   |John 	  |A 	      |null      |
|102   |Dan 	  |A 	      |101       |
|103   |James 	  |A 	      |101       |
|104   |Amy 	  |A 	      |101       |
|105   |Anne 	  |A 	      |101       |
|106   |Ron 	  |B 	      |101       |
+------+----------+-----------+----------+

Given the Employee table, write a SQL query that finds out managers with at least 5 direct report. 
For the above table, your SQL query should return:

+-------+
| Name  |
+-------+
| John  |
+-------+
Note:
No one would report to himself.
*/

DROP TABLE Employee;
CREATE TABLE Employee (Id int, Name varchar(255), Department varchar(255), ManagerId int);
TRUNCATE TABLE Employee;
INSERT ALL
INTO Employee (Id, Name, Department, ManagerId) VALUES ('101', 'John', 'A', NULL)
INTO Employee (Id, Name, Department, ManagerId) VALUES ('102', 'Dan', 'A', '101')
INTO Employee (Id, Name, Department, ManagerId) VALUES ('103', 'James', 'A', '101')
INTO Employee (Id, Name, Department, ManagerId) VALUES ('104', 'Amy', 'A', '101')
INTO Employee (Id, Name, Department, ManagerId) VALUES ('105', 'Anne', 'A', '101')
INTO Employee (Id, Name, Department, ManagerId) VALUES ('106', 'Ron', 'B', '101')
SELECT * FROM DUAL;
SELECT * FROM Employee;

SELECT *
FROM Employee E,
Employee MAN_E
WHERE E.MANAGERID = MAN_E.Id; --don't need TO be (+) OUTER LEFT JOIN

SELECT ManagerId
FROM Employee E
GROUP BY ManagerId
HAVING COUNT(ManagerId) >= 5;

SELECT E.NAME
FROM EMPLOYEE E,
	(SELECT MANAGERID
	FROM EMPLOYEE E
	GROUP BY MANAGERID
	HAVING COUNT(MANAGERID) >= 5) T
WHERE T.MANAGERID = E.ID;