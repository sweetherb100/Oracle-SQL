/*Given a table customer holding customers information and the referee.

+------+------+-----------+
| id   | name | referee_id|
+------+------+-----------+
|    1 | Will |      NULL |
|    2 | Jane |      NULL |
|    3 | Alex |         2 |
|    4 | Bill |      NULL |
|    5 | Zack |         1 |
|    6 | Mark |         2 |
+------+------+-----------+

Write a query to return the list of customers NOT referred by the person with id '2'.

For the sample data above, the result is:

+------+
| name |
+------+
| Will |
| Jane |
| Bill |
| Zack |
+------+*/

DROP TABLE CUSTOMER;
CREATE TABLE CUSTOMER (ID INT, NAME VARCHAR(255), REFEREE_ID INT);
TRUNCATE TABLE CUSTOMER;
INSERT ALL
INTO CUSTOMER (ID, NAME) VALUES ('1', 'WILL')
INTO CUSTOMER (ID, NAME) VALUES ('2', 'JANE')
INTO CUSTOMER (ID, NAME, REFEREE_ID) VALUES ('3', 'ALEX', '2')
INTO CUSTOMER (ID, NAME) VALUES ('4', 'BILL')
INTO CUSTOMER (ID, NAME, REFEREE_ID) VALUES ('5', 'ZACK', '1')
INTO CUSTOMER (ID, NAME, REFEREE_ID) VALUES ('6', 'MARK', '2') 
SELECT * FROM DUAL;
SELECT * FROM CUSTOMER;

SELECT NAME
FROM CUSTOMER
WHERE REFEREE_ID != '2'; --BE CAREFUL! IT ALSO ELMINATES THE ONES WITH NULL

--[METHOD 1]
SELECT NAME
FROM CUSTOMER
WHERE REFEREE_ID != '2' OR REFEREE_ID IS NULL; --I WAS STUPID TO WRITE AT FIRST 'IS NOT NULL'...

--[METHOD 2] More clear than [method 1]
SELECT NAME
FROM CUSTOMER
WHERE ID NOT IN (SELECT ID 
				FROM CUSTOMER 
				WHERE REFEREE_ID ='2');


