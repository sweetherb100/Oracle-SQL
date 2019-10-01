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

Write an SQL query to find the average number of sessions per user for a period of 30 days ending 2019-07-27 inclusively, rounded to 2 decimal places. 
The sessions we want to count for a user are those with at least one activity in that time period.

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
| 3       | 5          | 2019-07-21    | open_session  |
| 3       | 5          | 2019-07-21    | scroll_down   |
| 3       | 5          | 2019-07-21    | end_session   |
| 4       | 3          | 2019-06-25    | open_session  |
| 4       | 3          | 2019-06-25    | end_session   |
+---------+------------+---------------+---------------+

Result table:
+---------------------------+ 
| average_sessions_per_user |
+---------------------------+ 
| 1.33                      |
+---------------------------+ 
User 1 and 2 each had 1 session in the past 30 days while user 3 had 2 sessions so the average is (1 + 1 + 2) / 3 = 1.33.*/

DROP TABLE Activity;
CREATE TABLE Activity (user_id int, session_id int, activity_date date, activity_type varchar(255));
TRUNCATE TABLE Activity;
INSERT ALL
INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('1', '1', TO_DATE('2019-07-20', 'YYYY-MM-DD'), 'open_session')
INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('1', '1', TO_DATE('2019-07-20', 'YYYY-MM-DD'), 'scroll_down')
INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('1', '1', TO_DATE('2019-07-20', 'YYYY-MM-DD'), 'end_session')
INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('2', '4', TO_DATE('2019-07-20', 'YYYY-MM-DD'), 'open_session')
INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('2', '4', TO_DATE('2019-07-21', 'YYYY-MM-DD'), 'send_message')
INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('2', '4', TO_DATE('2019-07-21', 'YYYY-MM-DD'), 'end_session')
INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('3', '2', TO_DATE('2019-07-21', 'YYYY-MM-DD'), 'open_session')
INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('3', '2', TO_DATE('2019-07-21', 'YYYY-MM-DD'), 'send_message')
INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('3', '2', TO_DATE('2019-07-21', 'YYYY-MM-DD'), 'end_session')
INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('3', '5', TO_DATE('2019-07-21', 'YYYY-MM-DD'), 'open_session')
INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('3', '5', TO_DATE('2019-07-21', 'YYYY-MM-DD'), 'scroll_down')
INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('3', '5', TO_DATE('2019-07-21', 'YYYY-MM-DD'), 'end_session')
INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('4', '3', TO_DATE('2019-06-25', 'YYYY-MM-DD'), 'open_session')
INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('4', '3', TO_DATE('2019-06-25', 'YYYY-MM-DD'), 'end_session')
SELECT * FROM DUAL;
SELECT * FROM Activity;

SELECT DISTINCT user_id,
session_id
FROM ACTIVITY
WHERE activity_date >= TO_DATE('2019-07-27', 'YYYY-MM-DD') - 30
AND activity_date <= TO_DATE('2019-07-27', 'YYYY-MM-DD');


SELECT round(avg(CNT_session),2) average_sessions_per_user
FROM
(
	SELECT user_id,
	count(session_id) CNT_session
	FROM
	(
		SELECT DISTINCT user_id, --use distinct because they all have other activity_type
		session_id
		FROM ACTIVITY
		WHERE activity_date >= TO_DATE('2019-07-27', 'YYYY-MM-DD') - 30
		AND activity_date <= TO_DATE('2019-07-27', 'YYYY-MM-DD')
	)
	GROUP BY user_id
);