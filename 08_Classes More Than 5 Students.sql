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
The students should not be counted duplicate in each course.

*/

CREATE TABLE courses (student varchar(255), class varchar(255));
TRUNCATE TABLE courses;
INSERT ALL
INTO courses (student, class) VALUES ('A', 'Math')
INTO courses (student, class) VALUES ('B', 'English')
INTO courses (student, class) VALUES ('C', 'Math')
INTO courses (student, class) VALUES ('D', 'Biology')
INTO courses (student, class) VALUES ('E', 'Math')
INTO courses (student, class) VALUES ('F', 'Computer')
INTO courses (student, class) VALUES ('G', 'Math')
INTO courses (student, class) VALUES ('H', 'Math')
INTO courses (student, class) VALUES ('I', 'Math')
SELECT * FROM DUAL;


--WRONG: There could be same 2 students!
SELECT class
FROM COURSES
GROUP BY class
HAVING COUNT(class) >= 5;

--[COUNTER EXAMPLE]
TRUNCATE TABLE courses;
INSERT ALL
INTO courses (student, class) VALUES ('A', 'Math')
INTO courses (student, class) VALUES ('B', 'English')
INTO courses (student, class) VALUES ('C', 'Math')
INTO courses (student, class) VALUES ('D', 'Biology')
INTO courses (student, class) VALUES ('E', 'Math')
INTO courses (student, class) VALUES ('F', 'Math')
INTO courses (student, class) VALUES ('A', 'Math')
SELECT * FROM DUAL;
-- DUPLICATE ROWS OF 'A','Math'



--[METHOD 1] DISTINCT: doesn't sort
SELECT class
FROM (SELECT DISTINCT student, class
      FROM courses)
GROUP BY class
HAVING COUNT(class) >= 5;

--[METHOD 2] GROUP BY: sort
SELECT class
FROM (SELECT student, class
      FROM courses 
      GROUP BY student, class)
GROUP BY class
HAVING COUNT(class) >= 5
