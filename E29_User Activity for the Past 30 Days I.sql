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
INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('4', '3', TO_DATE('2019-06-25', 'YYYY-MM-DD'), 'open_session')
INTO Activity (user_id, session_id, activity_date, activity_type) VALUES ('4', '3', TO_DATE('2019-06-25', 'YYYY-MM-DD'), 'end_session')
SELECT * FROM DUAL;
SELECT * FROM Activity;

SELECT *
FROM ACTIVITY
WHERE TO_DATE('2019-07-27', 'YYYY-MM-DD') - 30 <= activity_date
AND activity_date <= TO_DATE('2019-07-27', 'YYYY-MM-DD');

SELECT activity_date DAY,
count(user_id) active_users
FROM (
	SELECT DISTINCT user_id, --should use distinct (be careful!)
	ACTIVITY_DATE
	FROM ACTIVITY
	WHERE TO_DATE('2019-07-27', 'YYYY-MM-DD') - 30 <= activity_date
	AND activity_date <= TO_DATE('2019-07-27', 'YYYY-MM-DD')
) A
GROUP BY activity_date;