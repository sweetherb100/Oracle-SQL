CREATE TABLE FOREST (id INT, year INT, defol float, x float, y float, age INT, canopyd INT, gradient INT, alt INT, DEPTH INT, ph float, watermoisture INT,
alkali INT, humus INT, TYPE INT, fert INT);

SELECT *
FROM FOREST;

-- RESULTS ARE THE SAME
SELECT YEAR, COUNT(1) --COUNT
FROM FOREST
GROUP BY YEAR
ORDER BY YEAR;


SELECT YEAR, COUNT(1) NUM_LOCS --ELIMINATE THE DUPLICATE
FROM (
   SELECT DISTINCT YEAR, X, Y
   FROM FOREST
     )
GROUP BY YEAR
ORDER BY YEAR;


CREATE TABLE FLORIDA (YEAR INT, Route INT, statenum INT, richness INT, abundance INT, Active INT, Latitude float, Longitude float, RouteTypeID INT);
CREATE TABLE ROUTE (countrynum INT, statenum INT, Route INT, RouteName varchar(255), Active INT, Latitude INT, Longitude INT, Stratum INT, BCR INT, LandTypeID INT,
RouteTypeID INT, RouteTypeDetailId INT);

SELECT YEAR, COUNT(1) NUM_LOCS --ELIMINATE THE DUPLICATE
FROM (
   SELECT DISTINCT YEAR, Latitude, Longitude
   FROM FLORIDA
     )
GROUP BY YEAR
ORDER BY YEAR;

