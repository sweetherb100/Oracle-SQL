/*
Write a SQL query to find all duplicate emails in a table named Person.

+----+---------+
| Id | Email   |
+----+---------+
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |
+----+---------+
For example, your query should return the following for the above table:

+---------+
| Email   |
+---------+
| a@b.com |
+---------+
Note: All emails are in lowercase.
*/

CREATE TABLE Person (Id int, Email varchar(255));
TRUNCATE TABLE Person;
INSERT ALL 
INTO Person (Id, Email) VALUES ('1', 'a@b.com')
INTO Person (Id, Email) VALUES ('2', 'c@d.com')
INTO Person (Id, Email) VALUES ('3', 'a@b.com')
SELECT * FROM DUAL;
SELECT * FROM Person;


SELECT EMAIL
FROM PERSON
GROUP BY EMAIL
HAVING COUNT(EMAIL) > 1; --GROUP BY SHOULD BE USED WITH "HAVING"
