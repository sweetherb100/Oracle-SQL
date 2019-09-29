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
| 1           | reviews    | *7          |
| 3           | reviews    | 3          |
| 1           | ads        | *11         |
| 2           | ads        | 7          |
| 3           | ads        | 6          |
| 1           | page views | 3          |
| 2           | page views | *12         |
+-------------+------------+------------+

Result table:
+-------------+
| business_id |
+-------------+
| 1           |
+-------------+ 
Average for 'reviews', 'ads' and 'page views' are (7+3)/2=5, (11+7+6)/3=8, (3+12)/2=7.5 respectively.
Business with id 1 has 7 'reviews' events (more than 5) and 11 'ads' events (more than 8) so it is an active business.*/

DROP TABLE Events;
CREATE TABLE Events (business_id int, event_type varchar(255), occurences int);
TRUNCATE TABLE Events;
INSERT ALL
INTO Events (business_id, event_type, occurences) VALUES ('1', 'reviews', '7')
INTO Events (business_id, event_type, occurences) VALUES ('3', 'reviews', '3')
INTO Events (business_id, event_type, occurences) VALUES ('1', 'ads', '11')
INTO Events (business_id, event_type, occurences) VALUES ('2', 'ads', '7')
INTO Events (business_id, event_type, occurences) VALUES ('3', 'ads', '6')
INTO Events (business_id, event_type, occurences) VALUES ('1', 'page views', '3')
INTO Events (business_id, event_type, occurences) VALUES ('2', 'page views', '12')
SELECT * FROM DUAL;
SELECT * FROM Events;

--1st step: get the average
SELECT event_type,
	  AVG(occurences) AVG_OCC
FROM Events
GROUP BY event_type;

--2nd step: join with EVENT_TYPE and compare OCCURENCE
SELECT *
FROM Events E,
			(
			SELECT event_type ET,
				  AVG(occurences) AVG_OCC
			FROM Events
			GROUP BY event_type
			) AVGE
WHERE E.EVENT_TYPE = AVGE.ET
AND E.occurences > AVGE.AVG_OCC;

--3rd step: SELECT BUSINESS_ID which IS AT least 2
SELECT E.BUSINESS_ID
FROM Events E,
			(
			SELECT event_type ET,
				  AVG(occurences) AVG_OCC
			FROM Events
			GROUP BY event_type
			) AVGE
WHERE E.EVENT_TYPE = AVGE.ET
AND E.occurences > AVGE.AVG_OCC
GROUP BY E.BUSINESS_ID
HAVING COUNT(E.BUSINESS_ID) >= 2; -- at least 2
GROUP BY E.BUSINESS_ID
HAVING COUNT(E.BUSINESS_ID) > 2;