/*Table: Events
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| business_id   | int     |
| event_type    | varchar |
| occurences    | int     | 
+---------------+---------+
(business_id, event_type) is the primary key of this table.
Each row in the table logs the info that an event of some type occured at some business for a number of times.

Write an SQL query to find all active businesses.
An active business is a business that:
has more than one event type with occurences greater than the average occurences of that event type among all businesses.

The query result format is in the following example:
Events table:
+-------------+------------+------------+
| business_id | event_type | occurences |
+-------------+------------+------------+
| 1           | reviews    | 7          | *
| 3           | reviews    | 3          |
| 1           | ads        | 11         | *
| 2           | ads        | 7          |
| 3           | ads        | 6          |
| 1           | page views | 3          |
| 2           | page views | 12         | *
+-------------+------------+------------+

Result table:
+-------------+
| business_id |
+-------------+
| 1           |
+-------------+ 
Average for 'reviews', 'ads' and 'page views' are (7+3)/2=5, (11+7+6)/3=8, (3+12)/2=7.5 respectively.
Business with id 1 has 7 'reviews' events (more than 5) and 11 'ads' events (more than 8) so it is an active business.*/

DROP TABLE EVENTS;
CREATE TABLE EVENTS (BUSINESS_ID INT, EVENT_TYPE VARCHAR(255), OCCURENCES INT);
TRUNCATE TABLE EVENTS;
INSERT ALL
INTO EVENTS (BUSINESS_ID, EVENT_TYPE, OCCURENCES) VALUES ('1', 'REVIEWS', '7')
INTO EVENTS (BUSINESS_ID, EVENT_TYPE, OCCURENCES) VALUES ('3', 'REVIEWS', '3')
INTO EVENTS (BUSINESS_ID, EVENT_TYPE, OCCURENCES) VALUES ('1', 'ADS', '11')
INTO EVENTS (BUSINESS_ID, EVENT_TYPE, OCCURENCES) VALUES ('2', 'ADS', '7')
INTO EVENTS (BUSINESS_ID, EVENT_TYPE, OCCURENCES) VALUES ('3', 'ADS', '6')
INTO EVENTS (BUSINESS_ID, EVENT_TYPE, OCCURENCES) VALUES ('1', 'PAGE VIEWS', '3')
INTO EVENTS (BUSINESS_ID, EVENT_TYPE, OCCURENCES) VALUES ('2', 'PAGE VIEWS', '12')
SELECT * FROM DUAL;
SELECT * FROM EVENTS;

--1st step: get the average
SELECT EVENT_TYPE,
	  AVG(OCCURENCES) AVG_OCC
FROM EVENTS
GROUP BY EVENT_TYPE;

--2nd step: join with EVENT_TYPE and compare OCCURENCE
SELECT *
FROM EVENTS E,
(
	SELECT EVENT_TYPE ET,
	AVG(OCCURENCES) AVG_OCC
	FROM EVENTS
	GROUP BY EVENT_TYPE
) AVGE
WHERE E.EVENT_TYPE = AVGE.ET
AND E.OCCURENCES > AVGE.AVG_OCC;

--3rd step: SELECT BUSINESS_ID which IS at least 2
SELECT E.BUSINESS_ID
FROM EVENTS E,
(
	SELECT EVENT_TYPE ET,
	AVG(OCCURENCES) AVG_OCC
	FROM EVENTS
	GROUP BY EVENT_TYPE
) AVGE
WHERE E.EVENT_TYPE = AVGE.ET
AND E.OCCURENCES > AVGE.AVG_OCC
GROUP BY E.BUSINESS_ID
HAVING COUNT(E.BUSINESS_ID) >= 2; -- AT LEAST 2
