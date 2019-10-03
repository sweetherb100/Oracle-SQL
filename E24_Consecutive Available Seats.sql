/*Several friends at a cinema ticket office would like to reserve consecutive available seats.
Can you help to query all the consecutive available seats order by the seat_id using the following cinema table?
| seat_id | free |
|---------|------|
| 1       | 1    |
| 2       | 0    |
| 3       | 1    |
| 4       | 1    |
| 5       | 1    |

Your query should return the following result for the sample case above.

| seat_id |
|---------|
| 3       |
| 4       |
| 5       |

Note:
The seat_id is an auto increment int, and free is bool (1 means free, and 0 means occupied.).
Consecutive available seats are more than 2(inclusive) seats consecutively available.*/

DROP TABLE SEATS;
CREATE TABLE SEATS (SEAT_ID INT, FREE INT);
TRUNCATE TABLE SEATS;
INSERT ALL
INTO SEATS (SEAT_ID, FREE) VALUES ('1', '1')
INTO SEATS (SEAT_ID, FREE) VALUES ('2', '0')
INTO SEATS (SEAT_ID, FREE) VALUES ('3', '1')
INTO SEATS (SEAT_ID, FREE) VALUES ('4', '1')
INTO SEATS (SEAT_ID, FREE) VALUES ('5', '1')
SELECT * FROM DUAL;
SELECT * FROM SEATS;

--WRONG
SELECT SEAT_ID,
FREE,
LAG(SEAT_ID) OVER (ORDER BY SEAT_ID) PREV_ID,
LAG(FREE) OVER (ORDER BY SEAT_ID) PREV_FREE
FROM SEATS;
--WHERE FREE=1 AND LAG(FREE) OVER (ORDER BY SEAT_ID)=1; --WINDOW FUNCTION IS NOT ALLOWED 


--FINAL
SELECT SEAT_ID
FROM
(
	SELECT SEAT_ID,
	LEAD(FREE) OVER (ORDER BY SEAT_ID) AFTER_FREE,
	FREE,
	LAG(FREE) OVER (ORDER BY SEAT_ID) PREV_FREE
	FROM SEATS
) S
WHERE (PREV_FREE=1 AND FREE=1) OR (AFTER_FREE=1 AND FREE=1);