/*
There is a table courses with columns: student and class

Please list out all classes which have more than or equal to 5 students.

For example, the table:
+---------+------------+
| student | class      |
+---------+------------+
| A       | Math       |
| B       | English    |
| C       | Math       |
| D       | Biology    |
| E       | Math       |
| F       | Computer   |
| G       | Math       |
| H       | Math       |
| I       | Math       |
+---------+------------+

Should output:
+---------+
| class   |
+---------+
| Math    |
+---------+

Note:
!!!! The students should not be counted duplicate in each course. !!!!

*/

CREATE TABLE COURSES (STUDENT VARCHAR(255), CLASS VARCHAR(255));
TRUNCATE TABLE COURSES;
INSERT ALL
INTO COURSES (STUDENT, CLASS) VALUES ('A', 'MATH')
INTO COURSES (STUDENT, CLASS) VALUES ('B', 'ENGLISH')
INTO COURSES (STUDENT, CLASS) VALUES ('C', 'MATH')
INTO COURSES (STUDENT, CLASS) VALUES ('D', 'BIOLOGY')
INTO COURSES (STUDENT, CLASS) VALUES ('E', 'MATH')
INTO COURSES (STUDENT, CLASS) VALUES ('F', 'COMPUTER')
INTO COURSES (STUDENT, CLASS) VALUES ('G', 'MATH')
INTO COURSES (STUDENT, CLASS) VALUES ('H', 'MATH')
INTO COURSES (STUDENT, CLASS) VALUES ('I', 'MATH')
SELECT * FROM DUAL;
SELECT * FROM COURSES;

--WRONG: THERE COULD BE SAME 2 STUDENTS!
SELECT CLASS
FROM COURSES
GROUP BY CLASS
HAVING COUNT(CLASS) >= 5;

--[COUNTER EXAMPLE]
TRUNCATE TABLE COURSES;
INSERT ALL
INTO COURSES (STUDENT, CLASS) VALUES ('A', 'MATH')
INTO COURSES (STUDENT, CLASS) VALUES ('B', 'ENGLISH')
INTO COURSES (STUDENT, CLASS) VALUES ('C', 'MATH')
INTO COURSES (STUDENT, CLASS) VALUES ('D', 'BIOLOGY')
INTO COURSES (STUDENT, CLASS) VALUES ('E', 'MATH')
INTO COURSES (STUDENT, CLASS) VALUES ('F', 'MATH')
INTO COURSES (STUDENT, CLASS) VALUES ('A', 'MATH')
SELECT * FROM DUAL;
-- DUPLICATE ROWS OF 'A','MATH'



--[METHOD 1] DISTINCT: DOESN'T SORT
SELECT CLASS
FROM (SELECT DISTINCT STUDENT, CLASS
      FROM COURSES)
GROUP BY CLASS
HAVING COUNT(CLASS) >= 5;

--[METHOD 2] GROUP BY: SORT
SELECT CLASS
FROM (SELECT STUDENT, CLASS
      FROM COURSES 
      GROUP BY STUDENT, CLASS)
GROUP BY CLASS
HAVING COUNT(CLASS) >= 5;
