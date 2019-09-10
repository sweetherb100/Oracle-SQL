/*
X city opened a new cinema, many people would like to go to this cinema. The cinema also gives out a poster indicating the movies�� ratings and descriptions.
Please write a SQL query to output movies with an odd numbered ID and a description that is not 'boring'. Order the result by rating.


For example, table cinema:

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

CREATE TABLE cinema (id int, movie varchar(255), description varchar(255), rating float);
TRUNCATE TABLE cinema;
INSERT ALL 
INTO cinema (id, movie, description, rating) VALUES ('1', 'War', 'great 3D', '8.9')
INTO cinema (id, movie, description, rating) VALUES ('2', 'Science', 'fiction', '8.5')
INTO cinema (id, movie, description, rating) VALUES ('3', 'irish', 'boring', '6.2')
INTO cinema (id, movie, description, rating) VALUES ('4', 'Ice song', 'Fantacy', '8.6')
INTO cinema (id, movie, description, rating) VALUES ('5', 'House card', 'Interesting', '9.1')
SELECT * FROM DUAL;
SELECT * FROM cinema;


SELECT *
FROM cinema
WHERE 1=1
AND mod(id,2) = 1 --%2, ==: WRONG SYNTAX
AND description != 'boring'
ORDER BY rating DESC;
