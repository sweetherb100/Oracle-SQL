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

DROP TABLE Person;
CREATE TABLE Person (PersonId int, FirstName varchar(255), LastName varchar(255));
CREATE TABLE Address (AddressId int, PersonId int, City varchar(255), State varchar(255));
TRUNCATE TABLE Person;
INSERT INTO Person (PersonId, LastName, FirstName) VALUES ('1', 'Wang', 'Allen');
TRUNCATE TABLE Address;
INSERT INTO Address (AddressId, PersonId, City, State) VALUES ('1', '2', 'New York City', 'New York');


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
