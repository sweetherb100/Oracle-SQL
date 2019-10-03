/*
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

DROP TABLE EMPLOYEE;
CREATE TABLE EMPLOYEE (ID INT, SALARY INT);
TRUNCATE TABLE EMPLOYEE;
INSERT ALL
INTO EMPLOYEE (ID, SALARY) VALUES ('1', '100')
INTO EMPLOYEE (ID, SALARY) VALUES ('2', '100')
INTO EMPLOYEE (ID, SALARY) VALUES ('3', '200')
INTO EMPLOYEE (ID, SALARY) VALUES ('4', '300')
INTO EMPLOYEE (ID, SALARY) VALUES ('5', '300')
SELECT * FROM DUAL;
SELECT * FROM EMPLOYEE;

SELECT SALARY
FROM
(
SELECT ID,
SALARY,
DENSE_RANK() OVER (ORDER BY SALARY) RRR,
RANK() OVER (ORDER BY SALARY) R
FROM EMPLOYEE
)
WHERE RRR = 2;


--NOT WORKING!! THERE CAN BE SAME SALARY SO I SHOULDNT USE LEAD/LAG
SELECT 
LEAD(SALARY,1) OVER (ORDER BY SALARY) AS SECONDHIGHESTSALARY
FROM EMPLOYEE
ORDER BY SALARY
WHERE ROWNUM=1;


--[METHOD 1]: key is "second largest"
SELECT MAX(SALARY) AS SECONDHIGHESTSALARY
FROM EMPLOYEE
WHERE SALARY < (
				SELECT MAX(SALARY)
                FROM EMPLOYEE
                );

SELECT MAX(SALARY) AS SECONDHIGHESTSALARY
FROM EMPLOYEE
WHERE SALARY NOT IN (
					SELECT MAX(SALARY)
					FROM EMPLOYEE
					);
		
	
--[METHOD 2] DENSE_RANK()
SELECT SALARY SecondHighestSalary
FROM
(
	SELECT ID,
	SALARY,
	DENSE_RANK() OVER (ORDER BY SALARY) DRK
	FROM EMPLOYEE
)
WHERE DRK = 2;
