/*
 Table point_2d holds the coordinates (x,y) of some unique points (more than two) in a plane.
Write a query to find the shortest distance between these points rounded to 2 decimals.

| x  | y  |
|----|----|
| -1 | -1 |
| 0  | 0  |
| -1 | -2 |

The shortest distance is 1.00 from point (-1,-1) to (-1,2). So the output should be:

| shortest |
|----------|
| 1.00     |
Note: The longest distance among all the points are less than 10000.
*/

CREATE TABLE Points (x_coord int, y_coord int);
TRUNCATE TABLE Points;
INSERT ALL
INTO Points (x_coord, y_coord) VALUES ('-1', '-1')
INTO Points (x_coord, y_coord) VALUES ('0', '0')
INTO Points (x_coord, y_coord) VALUES ('-1', '-2')
SELECT * FROM DUAL;
SELECT * FROM Points;


SELECT MIN(P.DISTANCE) AS SHORTEST
 FROM 
         (
          SELECT SQRT(
                           POWER((P1.X_COORD - P2.X_COORD), 2) + POWER((P1.Y_COORD - P2.Y_COORD), 2)
                           ) AS DISTANCE
           FROM POINTS P1, POINTS P2
         ) P;
        
SELECT SQRT(MIN(POWER((P1.X_COORD - P2.X_COORD), 2) + POWER((P1.Y_COORD - P2.Y_COORD), 2))) AS SHORTEST
 FROM POINTS P1, POINTS P2;

SELECT SQRT(MIN(POWER((P1.X_COORD - P2.X_COORD), 2) + POWER((P1.Y_COORD - P2.Y_COORD), 2))) AS SHORTEST
 FROM POINTS P1, POINTS P2
WHERE P1.X_COORD||P2.X_COORD != P1.Y_COORD||P2.Y_COORD;

SELECT SQRT(MIN(POWER((P1.X_COORD - P2.X_COORD), 2) + POWER((P1.Y_COORD - P2.Y_COORD), 2))) AS SHORTEST
 FROM POINTS P1, POINTS P2
WHERE P1.X_COORD||P2.X_COORD != P1.Y_COORD||P2.Y_COORD;