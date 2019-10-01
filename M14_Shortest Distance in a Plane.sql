/*
 Table point_2d holds the coordinates (x,y) of some unique points (more than two) in a plane.
Write a query to find the shortest distance between these points rounded to 2 decimals.

| x  | y  |
|----|----|
| -1 | -1 |
| 0  | 0  |
| -1 | -2 |

The shortest distance is 1.00 from point (-1,-1) to (-1,-2). So the output should be:

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

--strategy: first, all the combination should be done by cartesian product
-- second, should consider to exclude the distance between itself
SELECT p1.X_COORD x1,
p1.Y_COORD y1,
p2.x_coord x2,
p2.y_coord y2
FROM Points P1, Points P2
WHERE p1.x_coord != p2.X_COORD OR p1.y_coord != p2.y_coord; --OPPOSITE OF p1.x_coord = p2.X_COORD AND p1.y_coord = p2.y_coord

SELECT p1.X_COORD x1,
p1.Y_COORD y1,
p2.x_coord x2,
p2.y_coord y2,
power(p1.X_COORD - p2.x_coord, 2) x1_x2,
power(p1.Y_COORD - p2.y_coord, 2) y1_y2,
power(p1.X_COORD - p2.x_coord, 2) + power(p1.Y_COORD - p2.y_coord, 2) sum,
sqrt(power(p1.X_COORD - p2.x_coord, 2) + power(p1.Y_COORD - p2.y_coord, 2)) distance
FROM Points P1, Points P2
WHERE p1.x_coord != p2.X_COORD OR p1.y_coord != p2.y_coord;

--FINAL
SELECT min(sqrt(power(p1.X_COORD - p2.x_coord, 2) + power(p1.Y_COORD - p2.y_coord, 2))) shortest
FROM Points P1, Points P2
WHERE p1.x_coord != p2.X_COORD OR p1.y_coord != p2.y_coord;

