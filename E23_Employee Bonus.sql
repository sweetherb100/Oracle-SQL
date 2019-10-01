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

DROP TABLE Employee;
CREATE TABLE Employee (empId int, name varchar(255), supervisor int, salary int);
TRUNCATE TABLE Employee;
INSERT ALL
INTO Employee (empId, name, supervisor, salary) VALUES ('1', 'John', '3', '1000')
INTO Employee (empId, name, supervisor, salary) VALUES ('2', 'Dan', '3', '2000')
INTO Employee (empId, name, supervisor, salary) VALUES ('3', 'Brad', null, '4000')
INTO Employee (empId, name, supervisor, salary) VALUES ('4', 'Thomas', '3', '4000')
SELECT * FROM DUAL;
SELECT * FROM Employee;

DROP TABLE Bonus;
CREATE TABLE Bonus (empId int, bonus int);
TRUNCATE TABLE Bonus;
INSERT ALL
INTO Bonus (empId, bonus) VALUES ('2', '500')
INTO Bonus (empId, bonus) VALUES ('4', '2000')
SELECT * FROM DUAL;
SELECT * FROM Bonus;

SELECT empId,
name
FROM Employee
WHERE empId NOT IN (SELECT empId
						FROM Bonus
						WHERE bonus >=1000);


SELECT EE.name,
B.bonus
FROM Bonus B,
(
SELECT empId,
name
FROM Employee
WHERE empId NOT IN (SELECT empId
						FROM Bonus
						WHERE bonus >=1000)
) EE
WHERE EE.EmpId = B.EmpId (+);
					