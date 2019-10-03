/*
X city opened a new cinema, many people would like to go to this cinema. The cinema also gives out a poster indicating the movies ratings and descriptions.

Please write a SQL query to output movies with an odd numbered ID and a description that is not 'boring'. 
Order the result by rating.


For example, table cinema:\
+---------+-----------+--------------+-----------+
|   id    | movie     |  description |  rating   |
+---------+-----------+--------------+-----------+
|   1     | War       |   great 3D   |   8.9     |
|   2     | Science   |   fiction    |   8.5     |
|   3     | irish     |   boring     |   6.2     |
|   4     | Ice song  |   Fantacy    |   8.6     |
|   5     | House card|   Interesting|   9.1     |
+---------+-----------+--------------+-----------+

For the example above, the output should be:
+---------+-----------+--------------+-----------+
|   id    | movie     |  description |  rating   |
+---------+-----------+--------------+-----------+
|   5     | House card|   Interesting|   9.1     |
|   1     | War       |   great 3D   |   8.9     |
+---------+-----------+--------------+-----------+
*/

CREATE TABLE CINEMA (ID INT, MOVIE VARCHAR(255), DESCRIPTION VARCHAR(255), RATING FLOAT);
TRUNCATE TABLE CINEMA;
INSERT ALL 
INTO CINEMA (ID, MOVIE, DESCRIPTION, RATING) VALUES ('1', 'WAR', 'GREAT 3D', '8.9')
INTO CINEMA (ID, MOVIE, DESCRIPTION, RATING) VALUES ('2', 'SCIENCE', 'FICTION', '8.5')
INTO CINEMA (ID, MOVIE, DESCRIPTION, RATING) VALUES ('3', 'IRISH', 'BORING', '6.2')
INTO CINEMA (ID, MOVIE, DESCRIPTION, RATING) VALUES ('4', 'ICE SONG', 'FANTACY', '8.6')
INTO CINEMA (ID, MOVIE, DESCRIPTION, RATING) VALUES ('5', 'HOUSE CARD', 'INTERESTING', '9.1')
SELECT * FROM DUAL;
SELECT * FROM CINEMA;


SELECT *
FROM CINEMA
WHERE MOD(ID,2) = 1 --%2, ==: WRONG SYNTAX
AND DESCRIPTION != 'BORING'
ORDER BY RATING DESC;
