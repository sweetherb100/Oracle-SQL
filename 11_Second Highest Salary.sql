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
CREATE TABLE Employee (Id int, Salary int);
TRUNCATE TABLE Employee;
INSERT ALL
INTO Employee (Id, Salary) VALUES ('1', '100')
INTO Employee (Id, Salary) VALUES ('2', '100')
INTO Employee (Id, Salary) VALUES ('3', '200')
INTO Employee (Id, Salary) VALUES ('4', '300')
INTO Employee (Id, Salary) VALUES ('5', '300')
SELECT * FROM DUAL;
SELECT * FROM EMPLOYEE;

--MAYBE I DON'T HAVE TO USE ROWNUM DIRECTLY BUT CAN WORK WITH MIN/MAX (DONT NEED TO USE GROUP BY)
SELECT * 
FROM EMPLOYEE
WHERE ROWNUM <2; --ROWNUM 


--Exception: [1, 100], [2, 100]
SELECT SecondHighestSalary
FROM (
	SELECT 
	LEAD(Salary,1) OVER (ORDER BY Salary) AS SecondHighestSalary
	FROM EMPLOYEE
	ORDER BY Salary
	)
WHERE ROWNUM=1;


--NOT WORKING!! THERE CAN BE SAME SALARY SO I SHOULDNT USE LEAD/LAG
SELECT 
LEAD(Salary,1) OVER (ORDER BY Salary) AS SecondHighestSalary
FROM EMPLOYEE
ORDER BY Salary
WHERE ROWNUM=1;
			
--DOESNT NEED GROUP BY
SELECT MAX(SALARY)
FROM EMPLOYEE;




--[METHOD 1]: key is "second largest"
SELECT MAX(Salary) as SecondHighestSalary
FROM Employee
WHERE Salary < (
                SELECT MAX(salary)
                FROM Employee
                );

SELECT MAX(SALARY) AS SecondHighestSalary
FROM EMPLOYEE
WHERE SALARY NOT IN (
					SELECT MAX(SALARY)
					FROM EMPLOYEE
				);

			
			
--[METHOD 2] TOO DIFFICULT TO UNDERSTAND
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
