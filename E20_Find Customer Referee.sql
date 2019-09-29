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

DROP TABLE customer;
CREATE TABLE customer (id int, name varchar(255), referee_id int);
TRUNCATE TABLE customer;
INSERT ALL
INTO customer (id, name) VALUES ('1', 'Will')
INTO customer (id, name) VALUES ('2', 'Jane')
INTO customer (id, name, referee_id) VALUES ('3', 'Alex', '2')
INTO customer (id, name) VALUES ('4', 'Bill')
INTO customer (id, name, referee_id) VALUES ('5', 'Zack', '1')
INTO customer (id, name, referee_id) VALUES ('6', 'Mark', '2') 
SELECT * FROM DUAL;
SELECT * FROM customer;

SELECT NAME
FROM CUSTOMER
WHERE REFEREE_ID != '2'; --BE CAREFUL! IT ALSO ELMINATES THE ONES WITH NULL

SELECT NAME
FROM CUSTOMER
WHERE REFEREE_ID != '2' OR REFEREE_ID IS NULL; --I WAS STUPID TO WRITE AT FIST IS NOT NULL...

