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

Given the Employee table, 
write a SQL query that finds out managers with at least 5 direct report. 

For the above table, your SQL query should return:
+-------+
| Name  |
+-------+
| John  |
+-------+
Note:
No one would report to himself.
*/
DROP TABLE EMPLOYEE;
CREATE TABLE EMPLOYEE (ID INT, NAME VARCHAR(255), DEPARTMENT VARCHAR(255), MANAGERID INT);
TRUNCATE TABLE EMPLOYEE;
INSERT ALL
INTO EMPLOYEE (ID, NAME, DEPARTMENT, MANAGERID) VALUES ('101', 'JOHN', 'A', NULL)
INTO EMPLOYEE (ID, NAME, DEPARTMENT, MANAGERID) VALUES ('102', 'DAN', 'A', '101')
INTO EMPLOYEE (ID, NAME, DEPARTMENT, MANAGERID) VALUES ('103', 'JAMES', 'A', '101')
INTO EMPLOYEE (ID, NAME, DEPARTMENT, MANAGERID) VALUES ('104', 'AMY', 'A', '101')
INTO EMPLOYEE (ID, NAME, DEPARTMENT, MANAGERID) VALUES ('105', 'ANNE', 'A', '101')
INTO EMPLOYEE (ID, NAME, DEPARTMENT, MANAGERID) VALUES ('106', 'RON', 'B', '101')
SELECT * FROM DUAL;
SELECT * FROM EMPLOYEE;

SELECT MANAGERID
FROM EMPLOYEE E
GROUP BY MANAGERID
HAVING COUNT(MANAGERID) >= 5;

--FINAL
SELECT E.NAME
FROM EMPLOYEE E,
	(SELECT MANAGERID
	FROM EMPLOYEE E
	GROUP BY MANAGERID
	HAVING COUNT(MANAGERID) >= 5) T
WHERE T.MANAGERID = E.ID;

