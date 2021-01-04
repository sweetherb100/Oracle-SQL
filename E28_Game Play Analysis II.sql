/*Table: Activity
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some game.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on some day using some device.

Write a SQL query that reports the device that is first logged in for each player.

The query result format is in the following example:

Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+

Result table:
+-----------+-----------+
| player_id | device_id |
+-----------+-----------+
| 1         | 2         |
| 2         | 3         |
| 3         | 1         |
+-----------+-----------+*/

DROP TABLE ACTIVITY;
CREATE TABLE ACTIVITY (PLAYER_ID INT, DEVICE_ID INT, EVENT_DATE DATE, GAMES_PLAYED INT);
TRUNCATE TABLE ACTIVITY;
INSERT ALL
INTO ACTIVITY (PLAYER_ID, DEVICE_ID, EVENT_DATE, GAMES_PLAYED) VALUES ('1', '2', TO_DATE('2016-03-01', 'YYYY-MM-DD'), '5')
INTO ACTIVITY (PLAYER_ID, DEVICE_ID, EVENT_DATE, GAMES_PLAYED) VALUES ('1', '2', TO_DATE('2016-05-02', 'YYYY-MM-DD'), '6')
INTO ACTIVITY (PLAYER_ID, DEVICE_ID, EVENT_DATE, GAMES_PLAYED) VALUES ('2', '3', TO_DATE('2017-06-25', 'YYYY-MM-DD'), '1')
INTO ACTIVITY (PLAYER_ID, DEVICE_ID, EVENT_DATE, GAMES_PLAYED) VALUES ('3', '1', TO_DATE('2016-03-02', 'YYYY-MM-DD'), '0')
INTO ACTIVITY (PLAYER_ID, DEVICE_ID, EVENT_DATE, GAMES_PLAYED) VALUES ('3', '4', TO_DATE('2018-07-03', 'YYYY-MM-DD'), '5')
SELECT * FROM DUAL;
SELECT * FROM ACTIVITY;


--[METHOD 1]
SELECT PLAYER_ID,
DEVICE_ID
FROM
(
	SELECT PLAYER_ID,
	DEVICE_ID,
	EVENT_DATE,
	RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) DATE_RNK
	FROM ACTIVITY
)
WHERE DATE_RNK = 1;

--[METHOD 2]
SELECT A.PLAYER_ID,
A.DEVICE_ID
FROM ACTIVITY A,
(
	SELECT PLAYER_ID,
	MIN(EVENT_DATE) MIN_DATE
	FROM ACTIVITY
	GROUP BY PLAYER_ID
) AA
WHERE A.PLAYER_ID = AA.PLAYER_ID
AND A.EVENT_DATE = AA.MIN_DATE; --BE CAREFUL! SHOULD ALSO WRITE THIS PART
--IN THE END, SHOULD ADD ALL THE COLUMNS FROM AA TABLE