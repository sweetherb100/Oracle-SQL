/*
Given a table salary, such as the one below, that has m=male and f=female values. 
Swap all f and m values (i.e., change all f values to m and vice versa) with a single update statement and no intermediate temp table.

Note that you must write a single update statement, DO NOT write any select statement for this problem.
Example:

| id | name | sex | salary |
|----|------|-----|--------|
| 1  | A    | m   | 2500   |
| 2  | B    | f   | 1500   |
| 3  | C    | m   | 5500   |
| 4  | D    | f   | 500    |
After running your update statement, the above salary table should have the following rows:
| id | name | sex | salary |
|----|------|-----|--------|
| 1  | A    | f   | 2500   |
| 2  | B    | m   | 1500   |
| 3  | C    | f   | 5500   |
| 4  | D    | m   | 500    |
*/

CREATE TABLE SALARY(ID INT, NAME VARCHAR(100), SEX CHAR(1), SALARY INT);
TRUNCATE TABLE SALARY;
INSERT ALL 
INTO SALARY (ID, NAME, SEX, SALARY) VALUES ('1', 'A', 'M', '2500')
INTO SALARY (ID, NAME, SEX, SALARY) VALUES ('2', 'B', 'F', '1500')
INTO SALARY (ID, NAME, SEX, SALARY) VALUES ('3', 'C', 'M', '5500')
INTO SALARY (ID, NAME, SEX, SALARY) VALUES ('4', 'D', 'F', '500')
SELECT * FROM DUAL;

SELECT * FROM SALARY;

-- [METHOD 1]
UPDATE SALARY S
SET S.SEX = DECODE(S.SEX, 'M','F','M');



-- [METHOD 2]
UPDATE salary
SET sex = 
CASE
       WHEN sex='f' --be careful with the character!
       THEN 'm'
       ELSE 'f'
END

