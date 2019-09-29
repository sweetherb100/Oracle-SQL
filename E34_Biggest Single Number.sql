/*
Find the biggest number that only appears once.

my_numbers
+---+
|num|
+---+
| 8 |
| 8 |
| 3 |
| 3 |
| 1 |
| 4 |
| 5 |
| 6 | 

+---+
|num|
+---+
| 6 |

*/

DROP TABLE my_numbers;
CREATE TABLE my_numbers (num int);
TRUNCATE TABLE my_numbers;
INSERT ALL
INTO my_numbers (num) VALUES ('8')
INTO my_numbers (num) VALUES ('8')
INTO my_numbers (num) VALUES ('3')
INTO my_numbers (num) VALUES ('3')
INTO my_numbers (num) VALUES ('1')
INTO my_numbers (num) VALUES ('4')
INTO my_numbers (num) VALUES ('5')
INTO my_numbers (num) VALUES ('6')
SELECT * FROM DUAL;
SELECT * FROM my_numbers;