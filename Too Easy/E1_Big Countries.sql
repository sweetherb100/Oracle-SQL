/* 
There is a table World
+-----------------+------------+------------+--------------+---------------+
| name            | continent  | area       | population   | gdp           |
+-----------------+------------+------------+--------------+---------------+
| Afghanistan     | Asia       | 652230     | 25500100     | 20343000      |
| Albania         | Europe     | 28748      | 2831741      | 12960000      |
| Algeria         | Africa     | 2381741    | 37100000     | 188681000     |
| Andorra         | Europe     | 468        | 78115        | 3712000       |
| Angola          | Africa     | 1246700    | 20609294     | 100990000     |
+-----------------+------------+------------+--------------+---------------+
A country is big if it has an area of bigger than 3 million square km or a population of more than 25 million.

Write a SQL solution to output big countries' name, population and area.
*/

CREATE TABLE WORLD (NAME VARCHAR(255), CONTINENT VARCHAR(255), AREA INT, POPULATION INT, GDP INT);

TRUNCATE TABLE WORLD;
INSERT ALL 
INTO WORLD (NAME, CONTINENT, AREA, POPULATION, GDP) VALUES ('AFGHANISTAN', 'ASIA', '652230', '25500100', '20343000000')
INTO WORLD (NAME, CONTINENT, AREA, POPULATION, GDP) VALUES ('ALBANIA', 'EUROPE', '28748', '2831741', '12960000000')
INTO WORLD (NAME, CONTINENT, AREA, POPULATION, GDP) VALUES ('ALGERIA', 'AFRICA', '2381741', '37100000', '188681000000')
INTO WORLD (NAME, CONTINENT, AREA, POPULATION, GDP) VALUES ('ANDORRA', 'EUROPE', '468', '78115', '3712000000')
INTO WORLD (NAME, CONTINENT, AREA, POPULATION, GDP) VALUES ('ANGOLA', 'AFRICA', '1246700', '20609294', '100990000000')
SELECT * FROM DUAL;

SELECT * FROM WORLD;



SELECT NAME, 
POPULATION, 
AREA
FROM WORLD
WHERE AREA > 3000000 OR POPULATION > 25000000;
