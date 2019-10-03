/*
Table: Person
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| PersonId    | int     |
| FirstName   | varchar |
| LastName    | varchar |
+-------------+---------+
PersonId is the primary key column for this table.


Table: Address
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| AddressId   | int     |
| PersonId    | int     |
| City        | varchar |
| State       | varchar |
+-------------+---------+
AddressId is the primary key column for this table.
 

Write a SQL query for a report that provides the following information for each person in the Person table, regardless if there is an address for each of those people:
FirstName, LastName, City, State
*/

DROP TABLE PERSON;
CREATE TABLE PERSON (PERSONID INT, FIRSTNAME VARCHAR(255), LASTNAME VARCHAR(255));
CREATE TABLE ADDRESS (ADDRESSID INT, PERSONID INT, CITY VARCHAR(255), STATE VARCHAR(255));
TRUNCATE TABLE PERSON;
INSERT INTO PERSON (PERSONID, LASTNAME, FIRSTNAME) VALUES ('1', 'WANG', 'ALLEN');
TRUNCATE TABLE ADDRESS;
INSERT INTO ADDRESS (ADDRESSID, PERSONID, CITY, STATE) VALUES ('1', '2', 'NEW YORK CITY', 'NEW YORK');


--[METHOD 1]
SELECT P.FIRSTNAME, 
       P.LASTNAME, 
       A.CITY, 
       A.STATE
FROM PERSON P LEFT OUTER JOIN ADDRESS A  --ANSI
ON P.PERSONID = A.PERSONID;


-- [METHOD 2]
SELECT P.FIRSTNAME, 
       P.LASTNAME, 
       A.CITY, 
       A.STATE
FROM PERSON  P, ADDRESS A
WHERE 1=1
AND P.PERSONID = A.PERSONID (+);  --ORACLE BASE
   
/* PERSONID OF ADDRESS is not a pk so it can be null
=> need to outer join with PERSON table
=> put (+) where null can exist
*/
