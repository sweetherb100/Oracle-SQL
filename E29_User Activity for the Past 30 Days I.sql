/*+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| session_id    | int     |
| activity_date | date    |
| activity_type | enum    |
+---------------+---------+
There is no primary key for this table, it may have duplicate rows.
The activity_type column is an ENUM of type ('open_session', 'end_session', 'scroll_down', 'send_message').
The table shows the user activities for a social media website. 
Note that each session belongs to exactly one user.
 
Write an SQL query to find the daily active user account for a period of 30 days ending 2019-07-27 inclusively. 
A user was active on some day if he/she made at least one activity on that day.

The query result format is in the following example:

Activity table:
+---------+------------+---------------+---------------+
| user_id | session_id | activity_date | activity_type |
+---------+------------+---------------+---------------+
| 1       | 1          | 2019-07-20    | open_session  |
| 1       | 1          | 2019-07-20    | scroll_down   |
| 1       | 1          | 2019-07-20    | end_session   |
| 2       | 4          | 2019-07-20    | open_session  |
| 2       | 4          | 2019-07-21    | send_message  |
| 2       | 4          | 2019-07-21    | end_session   |
| 3       | 2          | 2019-07-21    | open_session  |
| 3       | 2          | 2019-07-21    | send_message  |
| 3       | 2          | 2019-07-21    | end_session   |
| 4       | 3          | 2019-06-25    | open_session  |
| 4       | 3          | 2019-06-25    | end_session   |
+---------+------------+---------------+---------------+

Result table:
+------------+--------------+ 
| day        | active_users |
+------------+--------------+ 
| 2019-07-20 | 2            |
| 2019-07-21 | 2            |
+------------+--------------+ 
Note that we do not care about days with zero active users.*/

DROP TABLE ACTIVITY;
CREATE TABLE ACTIVITY (USER_ID INT, SESSION_ID INT, ACTIVITY_DATE DATE, ACTIVITY_TYPE VARCHAR(255));
TRUNCATE TABLE ACTIVITY;
INSERT ALL
INTO ACTIVITY (USER_ID, SESSION_ID, ACTIVITY_DATE, ACTIVITY_TYPE) VALUES ('1', '1', TO_DATE('2019-07-20', 'YYYY-MM-DD'), 'OPEN_SESSION')
INTO ACTIVITY (USER_ID, SESSION_ID, ACTIVITY_DATE, ACTIVITY_TYPE) VALUES ('1', '1', TO_DATE('2019-07-20', 'YYYY-MM-DD'), 'SCROLL_DOWN')
INTO ACTIVITY (USER_ID, SESSION_ID, ACTIVITY_DATE, ACTIVITY_TYPE) VALUES ('1', '1', TO_DATE('2019-07-20', 'YYYY-MM-DD'), 'END_SESSION')
INTO ACTIVITY (USER_ID, SESSION_ID, ACTIVITY_DATE, ACTIVITY_TYPE) VALUES ('2', '4', TO_DATE('2019-07-20', 'YYYY-MM-DD'), 'OPEN_SESSION')
INTO ACTIVITY (USER_ID, SESSION_ID, ACTIVITY_DATE, ACTIVITY_TYPE) VALUES ('2', '4', TO_DATE('2019-07-21', 'YYYY-MM-DD'), 'SEND_MESSAGE')
INTO ACTIVITY (USER_ID, SESSION_ID, ACTIVITY_DATE, ACTIVITY_TYPE) VALUES ('2', '4', TO_DATE('2019-07-21', 'YYYY-MM-DD'), 'END_SESSION')
INTO ACTIVITY (USER_ID, SESSION_ID, ACTIVITY_DATE, ACTIVITY_TYPE) VALUES ('3', '2', TO_DATE('2019-07-21', 'YYYY-MM-DD'), 'OPEN_SESSION')
INTO ACTIVITY (USER_ID, SESSION_ID, ACTIVITY_DATE, ACTIVITY_TYPE) VALUES ('3', '2', TO_DATE('2019-07-21', 'YYYY-MM-DD'), 'SEND_MESSAGE')
INTO ACTIVITY (USER_ID, SESSION_ID, ACTIVITY_DATE, ACTIVITY_TYPE) VALUES ('3', '2', TO_DATE('2019-07-21', 'YYYY-MM-DD'), 'END_SESSION')
INTO ACTIVITY (USER_ID, SESSION_ID, ACTIVITY_DATE, ACTIVITY_TYPE) VALUES ('4', '3', TO_DATE('2019-06-25', 'YYYY-MM-DD'), 'OPEN_SESSION')
INTO ACTIVITY (USER_ID, SESSION_ID, ACTIVITY_DATE, ACTIVITY_TYPE) VALUES ('4', '3', TO_DATE('2019-06-25', 'YYYY-MM-DD'), 'END_SESSION')
SELECT * FROM DUAL;
SELECT * FROM ACTIVITY;

SELECT *
FROM ACTIVITY
WHERE TO_DATE('2019-07-27', 'YYYY-MM-DD') - 30 <= ACTIVITY_DATE
AND ACTIVITY_DATE <= TO_DATE('2019-07-27', 'YYYY-MM-DD');

--FINAL
SELECT ACTIVITY_DATE DAY,
COUNT(USER_ID) ACTIVE_USERS
FROM (
	SELECT DISTINCT USER_ID, --SHOULD USE DISTINCT (BE CAREFUL!)
	ACTIVITY_DATE
	FROM ACTIVITY
	WHERE TO_DATE('2019-07-27', 'YYYY-MM-DD') - 30 <= ACTIVITY_DATE
	AND ACTIVITY_DATE <= TO_DATE('2019-07-27', 'YYYY-MM-DD')
) A
GROUP BY ACTIVITY_DATE;