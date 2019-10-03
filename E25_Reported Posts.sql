/*Table: Actions
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| post_id       | int     |
| action_date   | date    | 
| action        | enum    |
| extra         | varchar |
+---------------+---------+
!!! There is no primary key for this table, it may have "duplicate" rows. !!!
The action column is an ENUM type of ('view', 'like', 'reaction', 'comment', 'report', 'share').
The extra column has optional information about the action such as a reason for report or a type of reaction.

Write an SQL query that reports the number of posts reported yesterday for each report reason. Assume today is 2019-07-05.

The query result format is in the following example:

Actions table:
+---------+---------+-------------+--------+--------+
| user_id | post_id | action_date | action | extra  |
+---------+---------+-------------+--------+--------+
| 1       | 1       | 2019-07-01  | view   | null   |
| 1       | 1       | 2019-07-01  | like   | null   |
| 1       | 1       | 2019-07-01  | share  | null   |
| 2       | 4       | 2019-07-04  | view   | null   |
| 2       | 4       | 2019-07-04  | report | spam   |
| 3       | 4       | 2019-07-04  | view   | null   |
| 3       | 4       | 2019-07-04  | report | spam   |
| 4       | 3       | 2019-07-02  | view   | null   |
| 4       | 3       | 2019-07-02  | report | spam   |
| 5       | 2       | 2019-07-04  | view   | null   |
| 5       | 2       | 2019-07-04  | report | racism |
| 5       | 5       | 2019-07-04  | view   | null   |
| 5       | 5       | 2019-07-04  | report | racism |
+---------+---------+-------------+--------+--------+
Result table:
+---------------+--------------+
| report_reason | report_count |
+---------------+--------------+
| spam          | 1            |
| racism        | 2            |
+---------------+--------------+ 
Note that we only care about report reasons with non zero number of reports.*/

DROP TABLE Actions;
CREATE TABLE Actions (user_id int, post_id int, action_date date, action varchar(255), extra varchar(255));
TRUNCATE TABLE Actions;
INSERT ALL
INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('1', '1', TO_DATE('2019-07-01','YYYY-MM-DD'), 'view', NULL)
INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('1', '1', TO_DATE('2019-07-01','YYYY-MM-DD'), 'like', NULL)
INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('1', '1', TO_DATE('2019-07-01','YYYY-MM-DD'), 'share', NULL)
INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('2', '4', TO_DATE('2019-07-04','YYYY-MM-DD'), 'view', NULL)
INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('2', '4', TO_DATE('2019-07-04','YYYY-MM-DD'), 'report', 'spam')
INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('3', '4', TO_DATE('2019-07-04','YYYY-MM-DD'), 'view', NULL)
INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('3', '4', TO_DATE('2019-07-04','YYYY-MM-DD'), 'report', 'spam')
INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('4', '3', TO_DATE('2019-07-02','YYYY-MM-DD'), 'view', NULL)
INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('4', '3', TO_DATE('2019-07-02','YYYY-MM-DD'), 'report', 'spam')
INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('5', '2', TO_DATE('2019-07-04','YYYY-MM-DD'), 'view', NULL)
INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('5', '2', TO_DATE('2019-07-04','YYYY-MM-DD'), 'report', 'racism')
INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('5', '5', TO_DATE('2019-07-04','YYYY-MM-DD'), 'view', NULL)
INTO Actions (user_id, post_id, action_date, action, extra) VALUES ('5', '5', TO_DATE('2019-07-04','YYYY-MM-DD'), 'report', 'racism') 
SELECT * FROM DUAL;
SELECT * FROM Actions;


SELECT EXTRA REPORT_REASON,
COUNT(EXTRA) REPORT_COUNT
FROM
(
	SELECT DISTINCT POST_ID,  --THERE IS NO PRIMARY KEY FOR THIS TABLE, IT MAY HAVE "DUPLICATE" ROWS.
	EXTRA
	FROM ACTIONS
	WHERE ACTION_DATE = TO_DATE('2019-07-04','YYYY-MM-DD')
	AND ACTION = 'REPORT'
)
GROUP BY EXTRA;
