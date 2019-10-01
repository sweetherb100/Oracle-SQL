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

DROP TABLE seats;
CREATE TABLE seats (seat_id int, free int);
TRUNCATE TABLE seats;
INSERT ALL
INTO seats (seat_id, free) VALUES ('1', '1')
INTO seats (seat_id, free) VALUES ('2', '0')
INTO seats (seat_id, free) VALUES ('3', '1')
INTO seats (seat_id, free) VALUES ('4', '1')
INTO seats (seat_id, free) VALUES ('5', '1')
SELECT * FROM DUAL;
SELECT * FROM seats;

SELECT seat_id,
free,
lag(seat_id) OVER (ORDER BY seat_id) after_id,
lag(FREE) OVER (ORDER BY seat_id) after_free
FROM seats;

SELECT seat_id,
free,
lag(seat_id) OVER (ORDER BY seat_id) after_id,
lag(FREE) OVER (ORDER BY seat_id) after_free
FROM seats;
--WHERE free=1 AND lag(FREE) OVER (ORDER BY seat_id)=1; --WINDOW FUNCTION IS NOT allowed 

--approach is too complicated
SELECT seat_id,
after_id
FROM 
(
	SELECT seat_id,
	free,
	lag(seat_id) OVER (ORDER BY seat_id) after_id,
	lag(FREE) OVER (ORDER BY seat_id) after_free
	FROM seats
)
WHERE FREE=1 AND after_free=1;

SELECT seat_id,
LEAD(free) OVER (ORDER BY seat_id) prev_free,
FREE,
lag(FREE) OVER (ORDER BY seat_id) after_free
FROM seats;


--Final
SELECT seat_id
FROM
(
SELECT seat_id,
LEAD(free) OVER (ORDER BY seat_id) prev_free,
FREE,
lag(FREE) OVER (ORDER BY seat_id) after_free
FROM seats
) S
WHERE (prev_free=1 AND FREE=1) OR (after_free=1 AND FREE=1);