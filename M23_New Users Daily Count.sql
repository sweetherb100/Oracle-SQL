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
the number of users that logged in for the first time on that date. 
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


DROP TABLE Traffic;
CREATE TABLE Traffic (user_id int, activity varchar(255), activity_date date);
TRUNCATE TABLE Traffic;
INSERT ALL
INTO Traffic (user_id, activity, activity_date) VALUES ('1', 'login', TO_DATE('2019-05-01','YYYY-MM-DD'))
INTO Traffic (user_id, activity, activity_date) VALUES ('1', 'homepage', TO_DATE('2019-05-01','YYYY-MM-DD'))
INTO Traffic (user_id, activity, activity_date) VALUES ('1', 'logout', TO_DATE('2019-05-01','YYYY-MM-DD'))
INTO Traffic (user_id, activity, activity_date) VALUES ('2', 'login', TO_DATE('2019-06-21','YYYY-MM-DD'))
INTO Traffic (user_id, activity, activity_date) VALUES ('2', 'logout', TO_DATE('2019-06-21','YYYY-MM-DD'))
INTO Traffic (user_id, activity, activity_date) VALUES ('3', 'login', TO_DATE('2019-01-01','YYYY-MM-DD'))
INTO Traffic (user_id, activity, activity_date) VALUES ('3', 'jobs', TO_DATE('2019-01-01','YYYY-MM-DD'))
INTO Traffic (user_id, activity, activity_date) VALUES ('3', 'logout', TO_DATE('2019-01-01','YYYY-MM-DD'))
INTO Traffic (user_id, activity, activity_date) VALUES ('4', 'login', TO_DATE('2019-06-21','YYYY-MM-DD'))
INTO Traffic (user_id, activity, activity_date) VALUES ('4', 'groups', TO_DATE('2019-06-21','YYYY-MM-DD'))
INTO Traffic (user_id, activity, activity_date) VALUES ('4', 'logout', TO_DATE('2019-06-21','YYYY-MM-DD'))
INTO Traffic (user_id, activity, activity_date) VALUES ('5', 'login', TO_DATE('2019-03-01','YYYY-MM-DD'))
INTO Traffic (user_id, activity, activity_date) VALUES ('5', 'logout', TO_DATE('2019-03-01','YYYY-MM-DD'))
INTO Traffic (user_id, activity, activity_date) VALUES ('5', 'login', TO_DATE('2019-06-21','YYYY-MM-DD'))
INTO Traffic (user_id, activity, activity_date) VALUES ('5', 'logout', TO_DATE('2019-06-21','YYYY-MM-DD'))
SELECT * FROM DUAL;
SELECT * FROM Traffic;

SELECT user_id,
min(activity_date)
FROM traffic
WHERE activity = 'login'
GROUP BY user_id
HAVING min(activity_date) > TO_DATE('2019-06-21','YYYY-MM-DD') -90
ORDER BY USER_id;


--2019-03-23
SELECT TO_DATE('2019-06-21','YYYY-MM-DD') - 90
FROM dual;


SELECT T.activity_date login_date,
count(T.user_id) user_count
FROM 
(
SELECT user_id,
min(activity_date) activity_date
FROM traffic
WHERE activity = 'login'
GROUP BY user_id
HAVING min(activity_date) > TO_DATE('2019-06-21','YYYY-MM-DD') -90
ORDER BY USER_id
) T
GROUP BY T.activity_date