/*Select all employee name and bonus whose bonus is < 1000.

Table:Employee
+-------+--------+-----------+--------+
| empId |  name  | supervisor| salary |
+-------+--------+-----------+--------+
|   1   | John   |  3        | 1000   |
|   2   | Dan    |  3        | 2000   |
|   3   | Brad   |  null     | 4000   |
|   4   | Thomas |  3        | 4000   |
+-------+--------+-----------+--------+
empId is the primary key column for this table.

Table: Bonus
+-------+-------+
| empId | bonus |
+-------+-------+
| 2     | 500   |
| 4     | 2000  |
+-------+-------+
empId is the primary key column for this table.

Example ouput:
+-------+-------+
| name  | bonus |
+-------+-------+
| John  | null  |
| Dan   | 500   |
| Brad  | null  |
+-------+-------+*/

DROP TABLE EMPLOYEE;
CREATE TABLE EMPLOYEE (EMPID INT, NAME VARCHAR(255), SUPERVISOR INT, SALARY INT);
TRUNCATE TABLE EMPLOYEE;
INSERT ALL
INTO EMPLOYEE (EMPID, NAME, SUPERVISOR, SALARY) VALUES ('1', 'JOHN', '3', '1000')
INTO EMPLOYEE (EMPID, NAME, SUPERVISOR, SALARY) VALUES ('2', 'DAN', '3', '2000')
INTO EMPLOYEE (EMPID, NAME, SUPERVISOR, SALARY) VALUES ('3', 'BRAD', NULL, '4000')
INTO EMPLOYEE (EMPID, NAME, SUPERVISOR, SALARY) VALUES ('4', 'THOMAS', '3', '4000')
SELECT * FROM DUAL;
SELECT * FROM EMPLOYEE;

DROP TABLE BONUS;
CREATE TABLE BONUS (EMPID INT, BONUS INT);
TRUNCATE TABLE BONUS;
INSERT ALL
INTO BONUS (EMPID, BONUS) VALUES ('2', '500')
INTO BONUS (EMPID, BONUS) VALUES ('4', '2000')
SELECT * FROM DUAL;
SELECT * FROM BONUS;


SELECT EE.NAME,
B.BONUS
FROM BONUS B,
(
	SELECT EMPID,
	NAME
	FROM EMPLOYEE
	WHERE EMPID NOT IN (	SELECT EMPID
				FROM BONUS
				WHERE BONUS >=1000)
) EE
WHERE EE.EMPID = B.EMPID (+);
					
