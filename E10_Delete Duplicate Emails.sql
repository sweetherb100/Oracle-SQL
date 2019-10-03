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

DROP TABLE PERSON;
CREATE TABLE PERSON (ID INT, EMAIL VARCHAR(255));
TRUNCATE TABLE PERSON;

INSERT ALL
INTO PERSON (ID, EMAIL) VALUES ('1', 'JOHN@EXAMPLE.COM')
INTO PERSON (ID, EMAIL) VALUES ('2', 'BOB@EXAMPLE.COM')
INTO PERSON (ID, EMAIL) VALUES ('3', 'JOHN@EXAMPLE.COM')
SELECT * FROM DUAL;
SELECT * FROM PERSON;



--FINAL
DELETE FROM PERSON
WHERE ID NOT IN (
                  SELECT ID
                  FROM (
                        SELECT MIN(P.ID) ID
                        FROM PERSON P
                        GROUP BY P.EMAIL
                       ) A --temp table
                  );


--[REFERENCE] DOESN'T WORK!!
-- => it is because I am asking to delete while I am referencing to my own table
-- => so I need to make it into temp table, therefore need temp table A
DELETE FROM PERSON
WHERE ID NOT IN (
                SELECT MIN(ID) AS ID
                FROM PERSON
                GROUP BY EMAIL
                );