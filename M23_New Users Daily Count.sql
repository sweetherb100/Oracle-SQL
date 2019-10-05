/*Table: Traffic
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| activity      | enum    |
| activity_date | date    |
+---------------+---------+
There is no primary key for this table, it may have duplicate rows.
The activity column is an ENUM type of ('login', 'logout', 'jobs', 'groups', 'homepage').

Write an SQL query that reports for every date within at most 90 days from today, 
the number of users that logged in for the !!! first time !!! on that date. 
Assume today is 2019-06-30.

The query result format is in the following example:
Traffic table:
+---------+----------+---------------+
| user_id | activity | activity_date | 
+---------+----------+---------------+
| 1       | login    | 2019-05-01    |
| 1       | homepage | 2019-05-01    |
| 1       | logout   | 2019-05-01    |
| 2       | login    | 2019-06-21    |
| 2       | logout   | 2019-06-21    |
| 3       | login    | 2019-01-01    |
| 3       | jobs     | 2019-01-01    |
| 3       | logout   | 2019-01-01    |
| 4       | login    | 2019-06-21    |
| 4       | groups   | 2019-06-21    |
| 4       | logout   | 2019-06-21    |
| 5       | login    | 2019-03-01    |
| 5       | logout   | 2019-03-01    |
| 5       | login    | 2019-06-21    |
| 5       | logout   | 2019-06-21    |
+---------+----------+---------------+

Result table:
+------------+-------------+
| login_date | user_count  |
+------------+-------------+
| 2019-05-01 | 1           |
| 2019-06-21 | 2           |
+------------+-------------+
Note that we only care about dates with non zero user count.
The user with id 5 first logged in on 2019-03-01 so he's not counted on 2019-06-21.*/

DROP TABLE TRAFFIC;
CREATE TABLE TRAFFIC (USER_ID INT, ACTIVITY VARCHAR(255), ACTIVITY_DATE DATE);
TRUNCATE TABLE TRAFFIC;
INSERT ALL
INTO TRAFFIC (USER_ID, ACTIVITY, ACTIVITY_DATE) VALUES ('1', 'LOGIN', TO_DATE('2019-05-01','YYYY-MM-DD'))
INTO TRAFFIC (USER_ID, ACTIVITY, ACTIVITY_DATE) VALUES ('1', 'HOMEPAGE', TO_DATE('2019-05-01','YYYY-MM-DD'))
INTO TRAFFIC (USER_ID, ACTIVITY, ACTIVITY_DATE) VALUES ('1', 'LOGOUT', TO_DATE('2019-05-01','YYYY-MM-DD'))
INTO TRAFFIC (USER_ID, ACTIVITY, ACTIVITY_DATE) VALUES ('2', 'LOGIN', TO_DATE('2019-06-21','YYYY-MM-DD'))
INTO TRAFFIC (USER_ID, ACTIVITY, ACTIVITY_DATE) VALUES ('2', 'LOGOUT', TO_DATE('2019-06-21','YYYY-MM-DD'))
INTO TRAFFIC (USER_ID, ACTIVITY, ACTIVITY_DATE) VALUES ('3', 'LOGIN', TO_DATE('2019-01-01','YYYY-MM-DD'))
INTO TRAFFIC (USER_ID, ACTIVITY, ACTIVITY_DATE) VALUES ('3', 'JOBS', TO_DATE('2019-01-01','YYYY-MM-DD'))
INTO TRAFFIC (USER_ID, ACTIVITY, ACTIVITY_DATE) VALUES ('3', 'LOGOUT', TO_DATE('2019-01-01','YYYY-MM-DD'))
INTO TRAFFIC (USER_ID, ACTIVITY, ACTIVITY_DATE) VALUES ('4', 'LOGIN', TO_DATE('2019-06-21','YYYY-MM-DD'))
INTO TRAFFIC (USER_ID, ACTIVITY, ACTIVITY_DATE) VALUES ('4', 'GROUPS', TO_DATE('2019-06-21','YYYY-MM-DD'))
INTO TRAFFIC (USER_ID, ACTIVITY, ACTIVITY_DATE) VALUES ('4', 'LOGOUT', TO_DATE('2019-06-21','YYYY-MM-DD'))
INTO TRAFFIC (USER_ID, ACTIVITY, ACTIVITY_DATE) VALUES ('5', 'LOGIN', TO_DATE('2019-03-01','YYYY-MM-DD'))
INTO TRAFFIC (USER_ID, ACTIVITY, ACTIVITY_DATE) VALUES ('5', 'LOGOUT', TO_DATE('2019-03-01','YYYY-MM-DD'))
INTO TRAFFIC (USER_ID, ACTIVITY, ACTIVITY_DATE) VALUES ('5', 'LOGIN', TO_DATE('2019-06-21','YYYY-MM-DD'))
INTO TRAFFIC (USER_ID, ACTIVITY, ACTIVITY_DATE) VALUES ('5', 'LOGOUT', TO_DATE('2019-06-21','YYYY-MM-DD'))
SELECT * FROM DUAL;
SELECT * FROM TRAFFIC;

SELECT USER_ID,
MIN(ACTIVITY_DATE)
FROM TRAFFIC
WHERE ACTIVITY = 'LOGIN'
GROUP BY USER_ID
HAVING MIN(ACTIVITY_DATE) > TO_DATE('2019-06-21','YYYY-MM-DD') -90
ORDER BY USER_ID;

--FINAL
SELECT T.ACTIVITY_DATE LOGIN_DATE,
COUNT(T.USER_ID) USER_COUNT
FROM 
(
	SELECT USER_ID,
	MIN(ACTIVITY_DATE) ACTIVITY_DATE
	FROM TRAFFIC
	WHERE ACTIVITY = 'LOGIN'
	GROUP BY USER_ID
	HAVING MIN(ACTIVITY_DATE) > TO_DATE('2019-06-21','YYYY-MM-DD') -90 --2019-03-23
) T
GROUP BY T.ACTIVITY_DATE;