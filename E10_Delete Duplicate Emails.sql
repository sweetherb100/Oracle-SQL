/*
Write a SQL query to delete all duplicate email entries in a table named Person, keeping only unique emails based on its smallest Id.

+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Id is the primary key column for this table.
For example, after running your query, the above Person table should have the following rows:

+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+
Note:

Your output is the whole Person table after executing your sql. Use delete statement.

*/

DROP TABLE Person;
CREATE TABLE Person (Id int, Email varchar(255));
TRUNCATE TABLE Person;

INSERT ALL
INTO Person (Id, Email) VALUES ('1', 'john@example.com')
INTO Person (Id, Email) VALUES ('2', 'bob@example.com')
INTO Person (Id, Email) VALUES ('3', 'john@example.com')
SELECT * FROM DUAL;
SELECT * FROM Person;



--[MYSQL] BUT IT IS NOT POSSIBLE IN ORACLE SO IN THE END, NOT RECOMMENDED!!
-- join forces you to use "DELETE A FROM TABLE A, TABLE B" 
DELETE A --join forces you to use like this way
FROM Person A, Person B
WHERE A.Email=B.Email --self-join
AND A.Id > B.Id;

--[ORACLE]
DELETE FROM PERSON
WHERE ID NOT IN (
                  SELECT ID
                  FROM (
                        SELECT MIN(P.ID) ID --CAN USE MIN BECAUSE I USED GROUP BY!!
                        FROM PERSON P
                        GROUP BY P.EMAIL
                       ) A --temp table
                  )


--[REFERENCE] DOESN'T WORK!!
-- => it is because I am asking to delete while I am referencing to my own table
-- => so I need to make it into temp table, therefore need temp table A

DELETE FROM Person
WHERE Id NOT IN (
                SELECT MIN(Id) AS Id
                FROM Person
                GROUP BY Email
                )
